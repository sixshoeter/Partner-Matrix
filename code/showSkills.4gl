## August 08, 2013 - John - create showSkills.4gl
## April 03, 2014 - John M. Shoemaker - add skill categories, only show other brands if in production
## September 26, 2014 - John M. Shoemaker - add date of last skill update
## November 24, 2014 John M. Shoemaker, expand to 30 skills
## December 04, 2014 John M. Shoemaker, use SkillsMax
## February 11, 2015 John M. Shoemaker, convert to Units

globals "globals.4gl"

define
#  BrandArr array[10] of char(2),
  ControlArr array[20] of record like control.*,
  deb smallint

main

define
    SSRRec record like reps.*,
    CTPRec record like reps.*,
    VRec record like vads.*,
    i smallint,
    color_idx smallint,
    ncnt smallint,
    successCnt smallint,
#    cov_tab char(25),
#    skill_tab char(25),
    skill_tab2 char(25),
    qtrStr char(256),
    colorStr char(16),
    textcolorStr char(16),
    BPTV_cnt smallint,
    skillStr char(64),
    tamt float,
    buStr char(2),
    tURL char(60),
    newBrand like brands.b_name,
    newBrandID like brands.b_id,
    nextB smallint,
    CRec record like control.*,
    nBrands smallint,
    col_cnt smallint,
    skill_cat smallint,
    nidx smallint

# set debug flag
let deb = FALSE

call ReadCmdLn( "showSkills", 4 )
call ProcCmdLn( "showSkills" )
let nBrands = GetControlArr()

call GetColor(BRec.b_id, 0,1) returning colorStr, textcolorStr

{
let colorArr[4] = "#00FF00"
let colorArr[3] = "#99FF99"
let colorArr[2] = "#FFFFCC"
let colorArr[1] = "#FFFFFF"
}
{
let BrandArr[5] = "LO"
let BrandArr[4] = "RA"
let BrandArr[3] = "TI"
let BrandArr[2] = "IM"
let BrandArr[1] = "WS"
}

let qtrStr = "select a.*,d.*, r.*, s.*, v.* ",
   "from ", cov_tab clipped, " a, outer ", skill_tab clipped, " d, outer reps r, outer reps s, outer vads v ",
   "where a.ceid = d.ceid and a.ceid = '", CLRec.CEID clipped, "' ",
     "and a.ssr = r.r_name ",
     "and a.ctp = s.r_name ",
     "and a.vad = v.v_id "

if( deb )then
   let qtrStr = qtrStr clipped, " order by d.c_id, d.s_num"
end if

call ShowTitle()
display " "

#display qtrStr
prepare QID from qtrStr
declare ACurs cursor for QID
foreach ACurs into ARec.*, KRec.*, SSRRec.*, CTPRec.*, VRec.*

   display "<table align='center' border='0' style='width: 744px'>"
   display "<tbody>"
   display "<tr>"
   display "<td style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
   display "<h1 style='text-align: center'>"
   display "<span style='color:", textcolorStr clipped, "'><span style='font-size: 36px'>",ARec.part_name clipped, "</span></span></h1>"
   display "</td>"
   display "<td style='text-align: center; width: 191px; vertical-align: middle'>"
#   display "<div>"
   display "<div style='text-align: center'>"

##    make url consistent with http prefix
   if( ARec.url[1,4] = "http" )then
      let tURL = ARec.url clipped
   else
      let tURL = "http://", ARec.url clipped
   end if

   display "<span style='font-size: 12pt'><a href='", tURL clipped, "' target='_blank'>", ARec.url clipped,"</a></span></div>"

## display the PW Profile if present
   if( ARec.pwp is not null) then
      display "<div style='text-align: center'>"
      display "<span style='font-size: 12pt'><a href='", ARec.pwp clipped, "' target='_blank'>PartnerWorld Profile", "</a></span></div>"
   end if


##    display the CEID
   display "<div style='text-align: center'>"
   display "<span style='font-size: 12pt'>CEID: ", ARec.ceid clipped,"</span></div>"
   display "<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -4.92%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span>"
#   display "</div>"
   display "</td>"
   display "<td style='text-align: center; width: 115px; vertical-align: middle'>"
   display "<img  style='block; width: auto; height: auto'; src='/", IRec.i_id clipped, "/I/", ARec.ceid clipped,".jpg' id='theImdID' /></td>"
   display "</tr>"


   display "</tbody>"
   display "</table>"

   display "<BR \>"

##    Detailed Skill Section - current brand
   call LoadSkills()

   display "<table align='center' border='1' height='60' width='641'>"
   display "<tbody>"
   display "<tr>"
   display "<td colspan='100' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
   display "<span style='color:", textcolorStr clipped, "'><span style='font-size: 22px'>", BRec.b_name clipped, " Detailed Skills</span></span></td>"
   display "</tr>"
   display "&nbsp;</p>"

## display category if requested
if( CtlRec.skill_cat )then
   let skill_cat = LoadSkillCat( BRec.b_id )
   if( skill_cat > 0)then
      display "<tr>"
      for i = 1 to skill_cat
         let col_cnt = GetCatCnt( BRec.b_id, SkillCatArr[i].c_id )
   
         display "<td colspan='", col_cnt using "<<", "' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
         display "<span style='color:", textcolorStr clipped, "'><span style='font-size: 18px'>", SkillCatArr[i].c_long clipped, "</span></span></td>"
      end for
      display "</tr>"
   end if  #skill_cat > 0

end if  #skill_cat

for i = 1 to SkillsMax
   if( SkillArr[i].s_name != "NA" )then
      display "<th class='centerText'; style='background-color: #add8e6'>"
      display "<strong>", SkillArr[i].s_desc clipped, "</strong></th>"
   end if
end for

display "<tr>"

for i = 1 to SkillsMax
   if( SkillArr[i].s_name != "NA" )then
    if( not G_DebugFlg )then 
     if (BPSkillsArr[i] > 0 )then
         let color_idx = BPSkillsArr[i] + 1
     else
         let color_idx = 1
     end if
      display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
      display "<strong>", BPSkillsArr[i] using "##", "</strong></td>"
    else
     let nidx = SkillArr[i].db_num
     if (BPSkillsArr[i] > 0 )then
         let color_idx = BPSkillsArr[nidx] + 1
     else
         let color_idx = 1
     end if
      display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
      display "<strong>", BPSkillsArr[nidx] using "##", "</strong></td>"
    end if
#display i, BPSkillsArr[i], color_idx
   end if
end for
display "</tr>"
if( GSkillDt is not NULL) then
   display "<tr><td colspan='100'>Updated: ", GSkillDt, "</td></tr>"
end if

display "</tbody>"
display "</table>"
display "<br />"

##
##
## determine if another brand data available
##
##

for nextB = 1 to nBrands
   if( (BRec.b_id != ControlArr[nextB].brand) AND (ControlArr[nextB].production) )then
      let newBrandID = ControlArr[nextB].brand
      let newBrand = ControlArr[nextB].menu_str
      let skill_tab2 = ControlArr[nextB].skill_tab1

      let ncnt = RowsAvail( skill_tab2, ARec.ceid )
      let colorStr = ControlArr[nextB].active_color
      let textcolorStr = ControlArr[nextB].text_color

      if(ncnt > 0 )then
##       load the Skill Array with the new Brands skills
         call LoadSkillArr( newBrandID )

         let qtrStr = "select d.* ", 
               "from ", skill_tab2 clipped, " d ", 
               "where d.ceid = '", CLRec.CEID clipped, "' "

         prepare Q2ID from qtrStr
         declare A2Curs cursor for Q2ID
         foreach A2Curs into KRec.*
         end foreach

##       Detailed Skill Section - new brand (requires KRec to be populated)
         call LoadSkills()

         display "<table align='center' border='1' height='60' width='641'>"
         display "<tbody>"
         display "<tr>"
         display "<td colspan='100' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
         display "<span style='color:", textcolorStr clipped, "'><span style='font-size: 22px'>", newBrand clipped, " Detailed Skills</span></span></td>"
         display "</tr>"
         display "&nbsp;</p>"

##          display category if requested
         if( ControlArr[nextB].skill_cat )then
            let skill_cat = LoadSkillCat( newBrandID )
            if( skill_cat > 0)then
               display "<tr>"
               for i = 1 to skill_cat
                  let col_cnt = GetCatCnt( newBrandID, SkillCatArr[i].c_id )
         
                  display "<td colspan='", col_cnt using "<<", "' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
                  display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 18px'>", SkillCatArr[i].c_long clipped, "</span></span></td>"
               end for
               display "</tr>"
            end if  #skill_cat > 0
         
         end if  #skill_cat

         for i = 1 to SkillsMax
            if( SkillArr[i].s_name != "NA" )then
               display "<th class='centerText'; style='background-color: #add8e6'>"
               display "<strong>", SkillArr[i].s_desc clipped, "</strong></th>"
            end if
         end for

         display "<tr>"

         for i = 1 to SkillsMax
            if( SkillArr[i].s_name != "NA" )then
               if (BPSkillsArr[i] > 0 )then
##                adjust color index to be off set by one to avoid 0
                  let color_idx = BPSkillsArr[i] + 1
              else
                  let color_idx = 1
              end if
               display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
               display "<strong>", BPSkillsArr[i] using "##", "</strong></td>"
            end if
         end for
         display "</tr>"
         if( GSkillDt is not NULL) then
            display "<tr><td colspan='100'>Updated: ", GSkillDt, "</td></tr>"
         end if

         display "</tbody>"
         display "</table>"
         display "<br />"

         end if  #rows available

      end if  #not the same brand
   end for

## close out the page
   display "<p>"
   display "3 - TOP Skilled Partner, with multiple successful engagements<br />"
   display "2 - Skilled Partner, with successful engagements<br />"
   display "1 - Learning Partner<p>"

   display "<span style='visibility: hidden'><span style='font-size: 78%'><span style='position: absolute; left: -2.94%'><span style='color: #7889fb'>–</span></span></span></span></div>"
   display "<div>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.65%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></div>"
   display "<div>"
   display "<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -2.65%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span></div>"
   display "</div>"
   display "<p dir='ltr'>"
   display "&nbsp;</p>"
end foreach

call ShowVer( 0 )

end main

function ShowTitle()

   call Header(0, IRec.i_id, BRec.b_id, 1)

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

end function

function RowsAvail( inTable, inCEID )
define
   inTable char(25),
   inCEID like skills_ws.ceid,
   SQLStr char(1024),
   cnt smallint

   let SQLStr="select count(*) from ", inTable clipped, " d where ceid='", inCEID clipped, "' and (",
      "d.skill_01 > 0 or ",
      "d.skill_02 > 0 or ",
      "d.skill_03 > 0 or ",
      "d.skill_04 > 0 or ",
      "d.skill_05 > 0 or ",
      "d.skill_06 > 0 or ",
      "d.skill_07 > 0 or ",
      "d.skill_08 > 0 or ",
      "d.skill_09 > 0 or ",
      "d.skill_10 > 0 or ",
      "d.skill_11 > 0 or ",
      "d.skill_12 > 0 or ",
      "d.skill_13 > 0 or ",
      "d.skill_14 > 0 or ",
      "d.skill_15 > 0 or ",
      "d.skill_16 > 0 or ",
      "d.skill_17 > 0 or ",
      "d.skill_18 > 0 or ",
      "d.skill_19 > 0 or ",
      "d.skill_20 > 0 or ",
      "d.skill_21 > 0 or ",
      "d.skill_22 > 0 or ",
      "d.skill_23 > 0 or ",
      "d.skill_24 > 0 or ",
      "d.skill_25 > 0 or ",
      "d.skill_26 > 0 or ",
      "d.skill_27 > 0 or ",
      "d.skill_28 > 0 or ",
      "d.skill_29 > 0 or ",
      "d.skill_30 > 0 ",
      ")"
   

   prepare RAID from SQLStr
   execute RAID into cnt

   return cnt

end function

function GetControlArr()
define
   i smallint

declare GCACurs cursor for 
   select a.* from control a, brands b where a.brand=b.b_id order by b.b_ord

let i = 0
foreach GCACurs into ControlArr[i+1].*
   let i = i+1
end foreach

return i

end function  #GetControlArr

{
function GetCatCnt( inBrand, inCat )
define
   inBrand like brands.b_id,
   inCat smallint,
   cnt,
   sqlStr char(128)

let cnt = 0
let sqlStr = "select count(*) from skill a where a.b_id='", inBrand clipped, "' and a.c_id=", inCat
prepare GCCID from sqlStr
execute GCCID into cnt

return cnt

end function  #GetCatCnt
}
