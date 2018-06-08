##
## March     28, 2014 John M. Shoemaker, jshoemaker1@cox.net - require a selection of r/adio buttons
## February  02, 2015 John M. Shoemaker, jshoemaker1@cox.net, convert to Units
## February  06, 2015 John M. Shoemaker, jshoemaker1@cox.net, convert EUs to checkbox from radio
## September 08, 2015 John M. Shoemaker, jshoemaker1@cox.net, change wording for TOP #36
## September 15, 2015 John M. Shoemaker, jshoemaker1@cox.net, include non-top #26
## September 22, 2015 John M. Shoemaker, jshoe@us.ibm.com - add in Social Unit OU
## March     04, 2016 John M. Shoemaker, jshoe@us.ibm.com - add hunter, commerce, only region #108
## April     06, 2016 John M. Shoemaker, jshoe@us.ibm.com - add vad search #161
## April     08, 2016 John M. Shoemaker, add description search option #152
## July      22, 2016 John M. Shoemaker, add Markets/Industries #174
## August    17, 2016 John M. Shoemaker, rename enterprise units to only geography
## August    18, 2016 John M. Shoemaker, expand to numerical industry settings #178
## September 20, 2016 John M. Shoemaker, include optional FAP notes #190
## January   31, 2017 John M. Shoemaker, add link to map, #199
## February  15, 2017 John M. Shoemaker, change title menu variable, #207
## April     11, 2017 John M. Shoemaker, add LAP, #212
## April     14, 2017 John M. Shoemaker, add DFM, #215
## May       17, 2017 John M. Shoemaker, adjust wraping of Industries, and add more submits #229, #230
## August    31, 2017 John M. Shoemaker, add clear button with every submit, #252
## September 04, 2017 John M. Shoemaker, revise AU tables, #255
## September 05, 2017 John M. Shoemaker, add brand description to FAP, #257
## September 21, 2017 John M. Shoemaker, change Submit wording to Start Search, #261
## September 21, 2017 John M. Shoemaker, make simple an option, #263
## November  06, 2017 John M. Shoemaker, change wording in Find a Partner by Skill/M/G, #283
## November  06, 2017 John M. Shoemaker, make showgeo an option, #287
## November  10, 2017 John M. Shoemaker, allow for market-specific feat sols, #177
## January   10, 2018 John M. Shoemaker, add link to top partner page, #291
## January   15, 2018 John M. Shoemaker, make Elite link optional, based on Control.showelite, #293
## February  07, 2018 John M. Shoemaker, rotate default feat sols, #313
## April     18, 2018 John M. Shoemaker, add visual support of non-NA, #311
## May       14, 2018 John M. Shoemaker sixshoeter@gmail.com, add MasterRec columns for dirs, #324


globals "globals.4gl"

main

define
   si,i,cnt,mod_num,idx,oidx,nb,nc,ff smallint,
   colName char(15),
   old_n like eus.e_region,
   new_n char(50),
   old_i, new_i like industry.ig_name,
   scat_cnt smallint,
#   bArr array[10]of char(2),   #array of brands in the unit
#   bCnt smallint,              #number of brands in the Unit
   tBinU like unit_brand.b_id,   #brand in a unit
   tfap like unit_brand.include_fap,  #include in find-a-partner
   tltr like unit_brand.ltr,  #include in find-a-partner
   tDesc like unit_brand.desc,   #description of the brand
   UpdStr, SQLStr char(512),
   bIdx smallint,
   option_flg smallint,
   twidth smallint,
   last_iname like featsols.i_name,
   outer_cnt smallint,
   fs_idx smallint,
   sel_str char(8)


call ReadCmdLn("findPartner", 4)

## Mickey mouse things to allow showing of only Industrial Solutions
if( CLRec.brand != "39" )then
   call ProcCmdLn("findPartner")
   call Header(6, IRec.i_id, BRec.b_id, 0)
else
   let CLRec.brand = "NC"
   call ProcCmdLn("findPartner")
   call Header(39, IRec.i_id, BRec.b_id, 0)
end if  #special for Industrial

initialize old_n, new_n to null
let option_flg = FALSE

display " "

display "<div class='section1'>"
if( IRec.i_id="NA" )then
   display "<h1 class='auto-style2'><strong>IBM Partner Matrix</strong> - ", CtlRec.menu_str clipped,"</h1>"
else
   display "<h1 class='auto-style2'><strong>IBM ", IRec.i_name clipped, " Partner Matrix</strong> - ", CtlRec.menu_str clipped,"</h1>"
end if  #NA
display "</div>"

##========================================================================
## Search Section 
##========================================================================
display "<div class='section2'>"

if( CtlRec.showfeatsols )then
   display "<h3 class='heading' onclick=", '"shide(', "'feat')", '">'
   display "<img id='featimg' class='imgstyle1' height='30' src='/NA/I/circle.jpg' width='30'> Featured Solutions</h3> "

   display "<div style='display: inline;' id='featshow'>"
#   display "<h3 style='padding-top: 4px;'>Featured Solutions</h3>"

   display "<div class='featsolnav'>"
   display "   <div>"
   let last_iname = " "
   let outer_cnt=0
   for i=1 to G_FeatSols
      if( FSArr[i].i_name != last_iname )then
         let outer_cnt=outer_cnt+1

         display "		<div id='n", outer_cnt using '<<<', "' style='visibility: hidden' class='featsolnavbar'></div><div style='width: 250px; cursor: hand; color: #01579b;' id='nl", outer_cnt using '<<<', "' onmouseout='navhover(", outer_cnt using '<<<', ")' onmouseover='navhover(", outer_cnt using '<<<', ")' onclick='javascript:updatefeat(", outer_cnt using '<<<', ")'>", FSArr[i].i_name clipped, "</div>"
         let last_iname=FSArr[i].i_name 

##       update lastshown date for solution
         let UpdStr="update featsols set lastshown=current where brand='", FSArr[i].brand clipped, "' ",
                    "and ceid='", FSArr[i].ceid clipped, "' and m_name='", FSArr[i].m_name clipped, "' ",
                    "and i_name='", FSArr[i].i_name clipped, "';"
#         display UpdStr
         prepare UPID from UpdStr
         execute UPID
      end if
   end for  #loop through G_FeatSols
   display "   </div></div>"

   for i=1 to 3
      display "<div class='featsolfade' id='featsol", i using '<<<', 
              "' onclick='popupSolution(", i using '<<<', ")'></div>"
   end for
display "<div style='clear: both;'></div>"
display "</div>"
display "<p></p>"
end if #showfeatsols
display "</div>"
display "<div class='section1'>"
display "<form action=/", MasterRec.cgi_dir clipped, "/", BRec.b_id clipped, "query_nmS.ksh>"

display "<h3 class='heading' onclick=", '"shide(', "'name')", '">'
display "<img id='nameimg' class='imgstyle2' height='30' src='/NA/I/circle.jpg' width='30'> Find a Partner by Name</h3>"
display "<p id='namesearch' style='padding-left: 20px; display: none;'>Partner Name: <input name='nmsearch' required size='20'><input type='submit' value='Search' class='btn'></p>" 
display "</form>"
if( CtlRec.showssrsearch )then
   display "<br>"
   display "<form action=/", MasterRec.cgi_dir clipped, "/", BRec.b_id clipped, "query_ssrS.ksh>"
   display "<p id='ssrsearch' style='padding-left: 20px; display: none;'>IBM Coverage Rep: <input name='ssrsearch' required size='20'><input type='submit' value='Search' class='btn'></p>" 
   display "</form>"
end if  #show SSR search

display "<h3 class='heading' onclick=", '"shide(', "'type')", '">'
display "<img id='typeimg' class='imgstyle2' height='30' src='/NA/I/circle.jpg' width='30'> Find a Partner by Top Skill/Market/Geo</h3> "


##========================================================================
## Skills 
##========================================================================
display "<div style='display: none;' id='browsetable'>"
display "<form action=/", MasterRec.cgi_dir clipped, "/", BRec.b_id clipped, "query_eusS.ksh>"

display "<input NAME='SLevel' TYPE=hidden READONLY VALUE='3'>"

let SQLStr = "select a.b_id, a.include_fap, a.ltr, a.sdesc from unit_brand a where a.u_id = '", BRec.b_id clipped, "' and a.include_fap>0"
if( BRec.b_id[1]="M" )then
   let SQLStr = SQLStr clipped, " order by a.b_id, a.ord"
else
   let SQLStr = SQLStr clipped, " order by a.ord"
end if  #Market
prepare UB1ID from SQLStr
declare UB1Curs cursor for UB1ID

let ff=0
let cnt = 1
display "<table cellpadding='5' cellspacing='0'>"
display "<tbody>"
display "<tr>"
display "<td colspan='2' class='tsheader' style='height: 42px'><strong>Skills</strong></td>"
#display "<td colspan='1' class='lnheader' style='height: 42px'><a href='/NA/NC/H/showTop.html' target='_blank'><strong>Elite Partners</strong></a></td>"
#display "<td colspan='1' class='lnheader' style='height: 42px;'><a href='/NA/NC/H/showTop.html' target='_blank'><strong>Elite Partners</strong></a></td>"
if( CtlRec.showelite )then
   display "<td colspan='1' class='lnheader' style='height: 42px;'><a href='/", MasterRec.cgi_dir clipped, "/top", BRec.b_id clipped, "S.ksh' target='_blank'><strong>Elite Partners</strong></a></td>"
end if  #showelite

#display "<td><a href='/NA/NC/H/showTop.html' target='_blank'><img height='32' src='/", IRec.i_id clipped, "/I/elite.jpg' width='70' style='padding: 10px;'></a></td>"

display "</tr>"

foreach UB1Curs into tBinU, tfap, tltr, tDesc

   let ff=ff+1
   let scat_cnt = LoadSkillCat( tBinU )

   let SQLStr = "select a.b_ord from brands a where a.b_id='", tBinU clipped, "'"
#display SQLStr
   prepare LSU1 from SQLStr
   execute LSU1 into bIdx

   let idx = 0
   let oidx = 0
   let mod_num=3

   let twidth=380
{
if( BRec.b_id="AU" )then
   if( ff = 3 or ff = 5 )then
      let twidth=250
   else
      if( ff=4 )then
         let twidth=200
      end if
   end if
end if

if( BRec.b_id="AU" and ff=3 )then
   display "<td colspan='2'>"
   display "&nbsp;"
   display "<table><tr>"
end if
if( BRec.b_id="AU" and (ff=4 or ff=5) )then
   display "<td style='width: 32px; height: 111px;'></td>"
end if
}
   display "<td style='height: 111px; width: ", twidth using '<<<', "px;' class='tdata'><label><strong>", tDesc clipped, "</strong></label>"
   display "<br />"
   display "<SELECT NAME='", tltr clipped, "' size=5 multiple style='width: ", twidth using '<<<',"px'>"
   display "<option selected>"
   for si = 1 to scat_cnt

      for i = 1 to SkillsMaxU
       if( SkillArrU[bIdx, i].s_name != "NA" and SkillArrU[bIdx,i].c_id = si )then

          if(CtlRec.skill_cat )then
             let idx = SkillArrU[bIdx,i].c_id
             if( idx > oidx )then
                let oidx = idx
             end if
          end if

          display "<option name='",tltr clipped,".skill_", SkillArrU[bIdx,i].db_num using "&&", "' value='skill_", SkillArrU[bIdx,i].db_num using "&&", "'>",  SkillCatArr[idx].c_short clipped, " - ", SkillArrU[bIdx,i].s_desc clipped

       end if  #not NA and c_id matche

      end for  #1 to SkillsMaxU
   end for #1 to scat_cnt

   let cnt = cnt + 1 
#display "b_id: ", BRec.b_id clipped, " cnt:", cnt, " ff:", ff
   display "</select></td>"
   if( BRec.b_id='AU' )then
      if( (((cnt mod mod_num ) = 0 ) and ff<3 ) or (ff=5) )then
         display "</tr><tr class='tdata'>"
      end if  #AU
   else
      if( (cnt mod mod_num ) = 0 )then
         display "</tr><tr>"
         let cnt = 1
      end if
   end if  #special for AU

end foreach   #loop through brands in the unit

display "</tr></table></td>"

##========================================================================
## Market
##========================================================================
## show markets/industries
if( CtlRec.showindustry )then
   display "</tr><tr>"
   display "<td colspan='2' class='tsheader' style='height: 40'><strong>Market</strong></td>"
   display "</tr>"
   display "<tr class='tdata'>"
   display "<td colspan='2'>"
   display "<table cellspacing='5px'>"
   display "<tbody><tr>"


## markets
   let new_i = MKArr[1].m_short
   let old_i = new_i

   for i = 1 to (G_MKcnt-2)
      let new_i = MKArr[i].m_short

       if( new_i != old_i )then
          let nc = 0  #number of markets columns displayed
          let old_i = new_i
       end if

        let cnt = MKArr[i].ord
#	let colName = INDColNamesArr[ cnt ].i_col

       let nc = nc + 1
       if( BRec.b_id[1]="M" and new_i=BRec.b_name )then
          let sel_str="checked"
       else
          let sel_str=" "
       end if  #Market
#display "MARKET XX: ", BRec.b_id, BRec.b_name clipped, " : ", sel_str
       display "<td style='height: 24px'><input type='checkbox' name='mk' ", 
               "value='", cnt using "<<", "' ", sel_str clipped, ">"
       display "<label for='chkG1'>", new_i clipped, "</label></td>"
       if( i mod 3 = 0 )then
   display "</tr><tr>"
end if
   end for  #G_INDcnt
   display "</tr></tbody></table>"
   display "</td>"
   display "</tr>"
   display "<tr>"
   display "<td colspan='2'>&nbsp;</td>"
   display "</tr>"

end if  #showindustry

##========================================================================
## Geography - available by CtlRec.showgeo
##========================================================================
if( CtlRec.showgeo )then
display "<tr>"
display "<td colspan='2' class='tsheader' style='height: 40'><label><strong>Geography </strong></td>"
display "</tr>"

   let new_n = RegionArr[1].e_short
   let old_n = new_n

   display "<tr class='tdata'><td colspan='2'>"
   display "<table cellspacing='5px'>"
   display "<tr>"
   for i = 1 to G_Regioncnt
      let new_n = RegionArr[i].e_short clipped

#       if( new_n != old_n )then
        let cnt = RegionArr[i].e_ord
#	let colName = EUColNamesArr[ cnt ].colname
       display "<td style='height: 24px'><input type='checkbox' name='reg' ", 
               "value='", RegionArr[i].e_ord using "<<", "'>"
       display "<label for='mk1'>", new_n clipped, "</label></td>"
       if( i mod 4 = 0 )then
   display "</tr><tr>"
end if
#          let old_n = new_n
#       end if


#       display "<input type='checkbox'"
#       display "   name = 'eu'"
#       display "   value = '", colName clipped, "' />"
#    display "   value = '", colName clipped, "' required='required'/>"
#       display "  <label for = 'chkEU", EUArr[i].e_id using "<<", "'>", 
#                 EUArr[i].e_name clipped, "</label>"
   end for  #G_EUcnt

display "</tr>"
display "</tbody></table>"

end if  #showgeo
###############################

display "</p><p>"
display "<input type='submit' value='Search' class='btn'>"
display "<input type='reset' value='Clear' class='btn'>"

display "</form>"
display "</div>"
let fs_idx=getFScnt( BRec.b_id )
display "<script>updatefeat(randomIntFromInterval(1,", fs_idx using '####', "))</script>"
display "</body></html>"


## add other query options

end main

function getFScnt( inbrand )
define
   inbrand like brands.b_id,
   SQLStr char(128),
   retVal smallint

let retVal=0
let SQLStr="select count(unique i_name) from featsols where brand='", inbrand clipped, "'"
prepare gFSID from SQLStr
execute gFSID into retVal

#display "brand: ", inbrand, " retVal: ", retVal
#  return results
   return retVal

end function  #getFScnt

