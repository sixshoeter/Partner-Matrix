##
## March     28, 2014  John M. Shoemaker, jshoemaker1@cox.net - require a selection of r/adio buttons
## February  02, 2015  John M. Shoemaker, jshoemaker1@cox.net, convert to Units
## February  06, 2015  John M. Shoemaker, jshoemaker1@cox.net, convert EUs to checkbox from radio
## September 08, 2015  John M. Shoemaker, jshoemaker1@cox.net, change wording for TOP #36
## September 15, 2015  John M. Shoemaker, jshoemaker1@cox.net, include non-top #26
## September 22, 2015  John M. Shoemaker, jshoe@us.ibm.com - add in Social Unit OU
## March     04, 2016  John M. Shoemaker, jshoe@us.ibm.com - add hunter, commerce, only region #108
## April     06, 2016  John M. Shoemaker, jshoe@us.ibm.com - add vad search #161
## April     08, 2016  John M. Shoemaker, add description search option #152
## July      22, 2016  John M. Shoemaker, add Markets/Industries #174
## August    17, 2016  John M. Shoemaker, rename enterprise units to only geography
## August    18, 2016  John M. Shoemaker, expand to numerical industry settings #178
## September 20, 2016  John M. Shoemaker, include optional FAP notes #190
## January   31, 2017  John M. Shoemaker, add link to map, #199
## February  15, 2017  John M. Shoemaker, change title menu variable, #207
## April     11, 2017  John M. Shoemaker, add LAP, #212
## April     14, 2017  John M. Shoemaker, add DFM, #215
## May       17, 2017  John M. Shoemaker, adjust wraping of Industries, and add more submits #229, #230
## August    31, 2017  John M. Shoemaker, add clear button with every submit, #252
## September 04, 2017  John M. Shoemaker, revise AU tables, #255
## September 05, 2017  John M. Shoemaker, add brand description to FAP, #257
## September 21, 2017  John M. Shoemaker, change Submit wording to Start Search, #261
## September 21, 2017  John M. Shoemaker, make simple an option, #263
## November  06, 2017  John M. Shoemaker, make showgeo an option, #287
## November  07, 2017  John M. Shoemaker, adjust wording of Skills, #286


globals "globals.4gl"

{
define
   SkillArrU array[70] of
    record
       c_id like skill.c_id,
       s_num like skill.s_num,
       db_num like skill.db_num,
       s_name like skill.s_name,
       s_desc like skill.s_desc
    end record
}
main

define
   si,i,cnt,mod_num,idx,oidx,nb,nc smallint,
   colName char(15),
   old_n, new_n like eus.e_region,
   old_i, new_i like industry.ig_name,
   scat_cnt smallint,
#   bArr array[10]of char(2),   #array of brands in the unit
#   bCnt smallint,              #number of brands in the Unit
   tBinU like unit_brand.b_id,   #brand in a unit
   tfap like unit_brand.include_fap,  #include in find-a-partner
   tDesc like unit_brand.desc,   #description of the brand
   SQLStr char(128),
   bIdx smallint,
   option_flg smallint


call ReadCmdLn("findPartner", 4)
call ProcCmdLn("findPartner")
call Header(6, IRec.i_id, BRec.b_id, 1)
initialize old_n, new_n to null
let option_flg = FALSE

## load skill categories if available
#if( CtlRec.skill_cat )then
#   let scat_cnt = LoadSkillCat( BRec.b_id )
#end if


display " "

if( not CtlRec.usesimple )then
   display "<div dir='ltr' style='text-align: center'>"
   display "<em><span style='font-size: 16px'>Please select the desired filter options below. Each of your choices will further filter the results.</span></em></div>"
   display "<div dir='ltr' style='text-align: center'>"
   display "<em><span style='font-size: 16px'>For Example: Checking both <i>Southwest</i> and <i>BPM</i> will find all Partners</span></em></div>"
   display "<div dir='ltr' style='text-align: center'>"
   display "<em><span style='font-size: 16px'>selling in the <i>Southwest</i> that are top skilled in <i>BPM</i>.</span></em></div><p>"
   display "<div dir='ltr' style='text-align: center'>"
#display "<b>Important Note: Only Recommended Partners will be returned from this query!</b></div>"
   display "</div>"  #replaces line above
end if  #usesimple

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped,"</span></em></div>"

display "<p dir='ltr'> &nbsp;</p>"

##temporary message regarding Industry data
#display "<div dir='ltr' style='text-align: center'><em><span style='color:red;font: normal 16px Arial'>The Market/Industry data is still being populated, so return results based on these attributes may not be complete.</em></span></div>"
##end temporary message


if( not CtlRec.usesimple )then
   if( CtlRec.showgeo )then
      display "<h2>Query Inputs</h2> <em>(Each checkbox below for Geography and Skills are ADDED as additional filters-e.g., NOT either-or)"
   else
      display "<h2>Query Inputs</h2> <em>(Each checkbox below for Skills are ADDED as additional filters-e.g., NOT either-or)"
   end if  #showgeo
else
   display "<h2>Find a Partner</h2>"
end if  #usesimple

if( not CtlRec.usesimple )then
display "<form action=cgi-bin/", BRec.b_id clipped, "query_eus.ksh>"

## don't use right now
if( BRec.b_id = "XX" )then
   display "<fieldset>"
   display "<p>"
   display "<label><b><i>High Value Partners:</i></b></label>"
   display "<br />"
   display "<input type='checkbox'"
   display "   name='reseller'"
   display "   value = 'reseller' />"
   display "<lable for = 'chkHVP'>Only Show High Value Partners</label>"
   display "</p>"
   display "</fieldset>"
end if


##########################################
## control if geo is a search option
if( CtlRec.showgeo )then
display "<fieldset>"
display "<p>"
if( CtlRec.regiononly )then
   display "<label style='color:red;font: normal 16px Arial'><b><i>Geography / Regions:</i></b></label>"
else
   display "<label style='color:red;font: normal 16px Arial'><b><i>Geographies </i></b></label>(see the map <a href='map.jpg' target='_blank'>here</a>):"

end if #only region
if( MasterRec.geo_note is not NULL and MasterRec.geo_note != " " )then
   display "<lable style='color:black;font: normal 14px Arial'><i>", MasterRec.geo_note clipped,
           "</i></label>"
end if

display "<br />"


case BRec.b_id
   when "AU"
      let mod_num = 4
   when "SU"
      let mod_num = 3
   when "BU"
      let mod_num = 3
   when "CU"
      let mod_num = 3
   when "OU"
      let mod_num = 3
   when "WS"
      let mod_num = 5
   when "IM"
      let mod_num = 3
   when "TI"
      let mod_num = 5
   when "RA"
      let mod_num = 2
   when "LO"
      let mod_num = 5
   when "SC"
      let mod_num = 3
   otherwise
      let mod_num = 4
end case

if( CtlRec.regiononly )then
## Regions
   for i = 1 to G_Regioncnt 
      display "<br />"
      display "<input type='checkbox'"
      display "   name = 'reg'"
      display "   value = '", RegionArr[i].e_region clipped, "' />"
      display "  <label for = 'chkReg", RegionArr[i].e_region clipped, "'>",
                 RegionArr[i].e_region clipped, "</label>"
   end for  #G_Regioncnt
else
## Enterprise Units
   let new_n = EUArr[1].e_region
   let old_n = new_n
   display "<label><b><i>", new_n clipped, "</i></b></label>"
   display "<br />"

   for i = 1 to G_EUcnt
      let new_n = EUArr[i].e_region

       if( new_n != old_n )then
          display "<br />"
          display "<label><b><i>", new_n clipped, "</i></b></label>"
          display "<br />"
          let old_n = new_n
       end if

        let cnt = EUArr[i].e_id
	let colName = EUColNamesArr[ cnt ].colname

       display "<input type='checkbox'"
       display "   name = 'eu'"
       display "   value = '", colName clipped, "' />"
#    display "   value = '", colName clipped, "' required='required'/>"
       display "  <label for = 'chkEU", EUArr[i].e_id using "<<", "'>", 
                 EUArr[i].e_name clipped, "</label>"
   end for  #G_EUcnt

   display "</p>"
   display "</fieldset>"
display "<input type='submit' value='Start Search'>"
display "<input type='reset' value='Clear'>"
end if  #if CtlRec.regiononly

end if  #showgeo
##############################################################

## show markets/industries
if( CtlRec.showindustry )then

   display "<fieldset>"
   display "<p>"
   display "<label style='color:red;font: normal 16px Arial'><b><i>Markets/Industries:</i></b></label>"
   if( MasterRec.market_note is not NULL and MasterRec.market_note != " " )then
      display "<lable style='color:black;font: normal 14px Arial'><i>", MasterRec.market_note clipped, 
              "</i></label>"
   end if
   display "<br />"
## markets
   let nc = 0  #number of industry columns displayed
   let new_i = INDArr[1].ig_name
   let old_i = new_i
   display "<div><table>"  ## TABLE FOR MARKETS (TFM)
   display "<tr><td>" ## TABLE FOR MARKETS
   display "<label><b><i>", new_i clipped, "</i></b></label>"
#TFM   display "<br />"
   display "</td></tr>" ## TABLE FOR MARKETS

   for i = 1 to G_INDcnt
      let new_i = INDArr[i].ig_name

       if( new_i != old_i )then
          display "</tr><tr><td>" ## TABLE FOR MARKETS
#TFM	  display "<br />"
	  display "<label><b><i>", new_i clipped, "</i></b></label>"
          let nc = 0  #number of industry columns displayed
#TFM	  display "<br />"
          display "</td></tr><tr>" ## TABLE FOR MARKETS
          let old_i = new_i
       end if

        let cnt = INDArr[i].i_id
	let colName = INDColNamesArr[ cnt ].i_col

#if( BRec.b_id = "SE" or BRec.b_id = "CU" or BRec.b_id = "BU" )then
{  ##BEFORE ALIGNING IN A TABLE - new code below
       display INDArr[i].i_name clipped, ":<nobr><SELECT NAME='", colName clipped, "'>"
       display "<OPTION></OPTION>"
       display "<OPTION>1-Industry Sales"
       display "<OPTION>2-Industry Practice"
       display "<OPTION>3-Industry Solutions"
       display "<OPTION>4-Industry Authorization"
       display "</SELECT>"
}
       if( nc >= 3 )then
          display "</tr><tr>"
          let nc = 0
       end if
       let nc = nc + 1
       display "<td class='rightText'>" ## TABLE FOR MARKETS
       display INDArr[i].i_name clipped, ": </td><td><SELECT NAME='", colName clipped, "'>"
       display "<OPTION></OPTION>"
       display "<OPTION>1-Industry Sales"
       display "<OPTION>2-Industry Practice"
       display "<OPTION>3-Industry Solutions"
       display "<OPTION>4-Industry Authorization"
       display "</SELECT>"
       display "</td>" ## TABLE FOR MARKETS
#else
#       display "<input type='checkbox'"
#       display "   name = 'ind'"
#       display "   value = '", colName clipped, "' />"
#    display "   value = '", colName clipped, "' required='required'/>"
#       display "  <label for = 'chkIND", INDArr[i].i_id using "<<", "'>", 
#                 INDArr[i].i_name clipped, "</label>"
#end if
   end for  #G_INDcnt
       display "</tr></table>" ## TABLE FOR MARKETS
       display "</div>" ## TABLE FOR MARKETS

   display "</p>"
   display "</fieldset>"
display "<input type='submit' value='Start Search'>"
display "<input type='reset' value='Clear'>"
end if  #showindustry


## show skills
display "<fieldset>"
display "<p>"
display "<label style='color:red;font: normal 16px Arial'><b><i>Select Skill(s):</i></b></label>"
if( MasterRec.skill_note is not NULL and MasterRec.skill_note != " " )then
   display "<lable style='color:black;font: normal 14px Arial'><i>", MasterRec.skill_note clipped,
           "</i></label>"
end if
display "<br />"
display "<label style='color:red;'>Choose Desired Partner Skill Level:</label>"

display "<input type = 'radio'"
display "name = 'SLevel'"
display "id = '3'"
display "value = '3'"
display "checked = 'checked' />"
display "<label for = '3'>", MasterRec.top_msg clipped, "</label>"

display "<input type = 'radio'"
display "name = 'SLevel'"
display "id = '2'"
display "value = '2' />"
display "<label for = '2'>", MasterRec.top_msg clipped, " and ", MasterRec.middle_msg clipped, "</label>"

display "<input type = 'radio'"
display "name = 'SLevel'"
display "id = '1'"
display "value = '1' />"
display "<label for = '1'>", MasterRec.top_msg clipped, ", ", MasterRec.middle_msg clipped, " and ",
                             MasterRec.low_msg clipped, "</label>"
 

display "<br />"

let SQLStr = "select a.b_id, a.include_fap, a.desc from unit_brand a where a.u_id = '", BRec.b_id clipped, "' order by a.ord"
#display "SQLStr1: ", SQLStr clipped, "<br>"
prepare UB1ID from SQLStr
declare UB1Curs cursor for UB1ID
foreach UB1Curs into tBinU, tfap, tDesc
#display "tBinU:", tBinU
#let bArr[1] = "IM"
#let bArr[2] = "EM"
#let bArr[3] = "BA"

#for nb = 1 to 3
if( CtlRec.skill_cat )then
   let scat_cnt = LoadSkillCat( tBinU )

   let SQLStr = "select a.b_ord from brands a where a.b_id='", tBinU clipped, "'"
#display SQLStr
   prepare LSU1 from SQLStr
   execute LSU1 into bIdx

#   call LoadSkillsU( tBinU )
end if  #if skill_cat

let cnt = 0
let idx = 0
let oidx = 0

if( tfap )then
   display "<lable style='color:black;font: normal 20px Arial'><i>", tDesc clipped, "</i></label>"
end if
display "<lable style='color:black;font: normal 14px Arial'></label>"
for si = 1 to scat_cnt
#display "si/scat_cnt:", si, scat_cnt
for i = 1 to SkillsMaxU
#display i, SkillArrU[bIdx, i].s_name
    if( SkillArrU[bIdx, i].s_name != "NA" and SkillArrU[bIdx,i].c_id = si )then
       let cnt = cnt + 1  

    if(CtlRec.skill_cat )then
       let idx = SkillArrU[bIdx,i].c_id
       if( idx > oidx )then
          display "<p><em>", SkillCatArr[idx].c_long clipped,"</em><br />"
          let oidx = idx
          let cnt = 1
       end if
    end if
#   display "Category", i, scat_cnt, idx, bIdx, SkillCatArr[idx].c_id, SkillArrU[bIdx,i].c_id

       display "<input type='checkbox'"
       display "   name = '",tBinU clipped,"-skill_", SkillArrU[bIdx,i].db_num using "&&", "'"
       display "   value = 'skill_", SkillArrU[bIdx,i].db_num using "&&", "' />"
#       display "   name = 'skill_", i using "&&", "'"
#       display "   value = 'skill_", i using "&&", "' />"
#       display "   value = '", BRec.b_id clipped, ".skill_", i using "&&", "' />"
       display "  <label for = 'chkSK'>", 
                 SkillArrU[bIdx,i].s_desc clipped, "</label>"
       if( (cnt mod mod_num ) = 0 )then
          display "<br />"
       end if
    end if

end for  #1 to SkillsMaxU
end for #1 to scat_cnt
if( cnt > 1 )then
   display "<HR>"
   display "<input type='submit' value='Start Search'>"
   display "<input type='reset' value='Clear'>"
end if
display "<HR>"
end foreach   #loop through brands in the unit

display "</p>"
display "</fieldset>"

## add other query options
## include hunter
if( CtlRec.showhunter )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      if( MasterRec.other_note is not NULL and MasterRec.other_note != " " )then
         display "<lable style='color:black;font: normal 14px Arial'><i>", MasterRec.other_note clipped,
                 "</i></label>"
      end if

      display "<br />"
      let option_flg = TRUE
   end if
   display "<input type='checkbox'"
   display "   name = 'hunt'"
   display "   value = 'hunter' />"
   display "  <label for = 'chkHU1'>Hunter</label>"
end if  #include hunter 


## include commercial
if( CtlRec.showcommercial )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      display "<br />"
      let option_flg = TRUE
   end if
   display "<input type='checkbox'"
   display "   name = 'comm'"
   display "   value = 'commercial' />"
   display "  <label for = 'chkCO1'>Commercial Focus</label>"
end if  #include commercial

## include enterprise
if( CtlRec.showenterprisealign )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      display "<br />"
      let option_flg = TRUE
   end if
   display "<input type='checkbox'"
   display "   name = 'ent'"
   display "   value = 'enterprise' />"
   display "  <label for = 'chkCO1'>Enterprise Focus</label>"
end if  #include commercial

## include industry
if( CtlRec.showindustryalign )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      display "<br />"
      let option_flg = TRUE
   end if
   display "<input type='checkbox'"
   display "   name = 'ind'"
   display "   value = 'industry' />"
   display "  <label for = 'chkCO1'>Industry Focus</label>"
end if  #include commercial

## include lap
if( CtlRec.showlap )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      display "<br />"
      let option_flg = TRUE
   end if
   display "<input type='checkbox'"
   display "   name = 'lap'"
   display "   value = 'lap' />"
   display "  <label for = 'chkCO1'>LAP (Linux Acceleration Program)</label>"
end if  #include lap

## include dfm
if( CtlRec.showdfm )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      display "<br />"
      let option_flg = TRUE
   end if
   display "<input type='checkbox'"
   display "   name = 'dfm'"
   display "   value = 'dfm' />"
   display "  <label for = 'chkCO1'>DFM (Data First Method) Trained</label>"
end if  #include dfm

## include partners_well
if( CtlRec.showpartnerswell )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      display "<br />"
      let option_flg = TRUE
   end if
   display "<input type='checkbox'"
   display "   name = 'partwell'"
   display "   value = 'partners_well' />"
   display "  <label for = 'chkPW1'>Partners Well with Other Partners</label>"
end if  #include commercial

## include VAD
if( CtlRec.searchvad )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      display "<br />"
      let option_flg = TRUE
   else
      display "<br />"
   end if
   call ListBoxVAD( "" )
end if  #include VAD

## include description search
if( CtlRec.searchdesc )then
   if( not option_flg ) then
      display "<fieldset>"
      display "<p>"
      display "<label style='color:red;font: normal 16px Arial'><b><i>Other Options:</i></b></label>"
      display "<br />"
      let option_flg = TRUE
   else
      display "<br />"
   end if
   display "<label>Search Description Field (case sensitive): </label>"
   display "<input type='text'"
   display "   name = 'desc'"
   display "   size = 30"
   display ">"
end if  #include search description

if( option_flg )then
   display "</fieldset>"
end if
display "<HR>"

display "<input type='submit' value='Start Search'>"
display "<input type='reset' value='Clear'>"
display "</form>"

call ShowVer( 0 )

##=========================================================================================
## KEEP SIMPLE OPTION
##=========================================================================================
else  #usesimple
   display "<form action=cgi-bin/", BRec.b_id clipped, "query_eus.ksh>"
   display "<p>"
   display "<input NAME='SLevel' TYPE=hidden READONLY VALUE='3'>"
   display "<table>"
   display "</table>"

end if #usesimple

end main

{
function LoadBrandSkills( inBrand )
define
   inBrand like skill.b_id,
   Cnt smallint,
   SQLStr char(256),
   SkillRec record 
      c_id like skill.c_id,
      s_num like skill.s_num,
      db_num like skill.db_num,
      s_name like skill.s_name,
      s_desc like skill.s_desc
   end record


#load the SkillArr which lists the mapping for the current brand for each skill name
let SQLStr = "select a.c_id, a.s_num, a.db_num, a.s_name, a.s_desc from skill a where a.b_id='", inBrand clipped

let SQLStr = SQLStr clipped, "' order by a.c_id, a.s_num"
#display "AAA:", SQLStr clipped
prepare SkillID from SQLStr
declare SkillCurs cursor for SkillID
let Cnt=0

foreach SkillCurs into SkillRec.*
   let Cnt = SkillRec.s_num
   let SkillArrU[Cnt].* = SkillRec.*
#display "XXX: ", Cnt, "YYY", SkillRec.*
end foreach

#return Cnt

end function  #LoadBrandSkills
}
