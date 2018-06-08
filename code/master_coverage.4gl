
## May   06, 2015 John M. Shoemaker, created
## June  08, 2015 John M. Shoemaker, expand title for clarity
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

define
   ARecArr array[2000] of record 
      ceid like coverage_au.ceid,
      part_name like coverage_au.part_name,
      uname like coverage_au.part_name,

      ssr_au like coverage_au.ssr,
      lnk_au like reps.r_link,
      ssr_su like coverage_au.ssr,
      lnk_su like reps.r_link,
      ssr_bu like coverage_au.ssr,
      lnk_bu like reps.r_link,
      ssr_es like coverage_au.ssr,
      lnk_es like reps.r_link,
      ssr_st like coverage_au.ssr,
      lnk_st like reps.r_link,
      ssr_io like coverage_au.ssr,
      lnk_io like reps.r_link,
      ssr_cu like coverage_au.ssr,
      lnk_cu like reps.r_link

   end record,
   G_TotalCnt smallint,
   BrandTitlesArr array[20] of char(15),
   BrandCnt array[20] of smallint

main
define
   qtrStr char(512),
   wStr char(512),
   i smallint,
   HVP char(1),
   cnt smallint,
   oe smallint,
   tmpnm char(1),
   BPTV_Cnt smallint,
   ncolor char(15),
   inProdStr char(128)


call ReadCmdLn("master_coverage", 4)
#let HVP = arg_val(5)  #only the first 5 values are read via ReadCmdLn
call ProcCmdLn("master_coverage")
#call Header(2, 'NA', '--', 0)
call Header(0, IRec.i_id, BRec.b_id, 1)

for i = 1 to 14
   initialize BrandTitlesArr[i] to NULL
end for

let BrandTitlesArr[1] = "Analytics BPR"
let BrandTitlesArr[2] = "Hybrid Cloud BPR"
let BrandTitlesArr[3] = "Commerce BPR"
let BrandTitlesArr[4] = "ESS BPR"
let BrandTitlesArr[5] = "Storage BPR"
let BrandTitlesArr[6] = "IoT BPR"
let BrandTitlesArr[7] = "Cloud BPR"

#call GetFullProdStr() returning inProdStr  

display " "

display "<div class='centerText' dir='ltr'>"   
#display "<em><span style='font-size: 16px'>The Partners listed below reflect all of our Partners </span></em></div>"
#display "<div dir='ltr' style='text-align: center'>"
#display "<em><span style='font-size: 16px'>that are SVP Approved for resell of IBM Software.</span><br />"

#display "Address to this location: <a href='https://ibm.biz/PartnerMatrix'>https://ibm.biz/PartnerMatrix</a><br />"

display "<div dir='ltr' style='text-align: center'>"

display "<em><span style='font-size: 16px'></span></em></div>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", "Master Coverage List - all Units/Brands", "</span></em></div>"
display "<p>"

## Load ALL Data (all brands
let cnt = LoadMasterCovArr()

## create title for the data
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 950; font: 16px/26px Georgia, Garamond, Serif; height: 50px;'>"
display "<table class='u1' border='0' cellpadding='0' cellspacing='0' dir='ltr' height='50'>"

display "<tr>"
display "<td class='leftText' style='height: 10px; width: 150; font-size: 10px;'>"
display "BP Company Name"  #</h2>"
display "</td>"
for i=1 to 14
   if( BrandTitlesArr[i] is not NULL )then
      display "<td class='rightText' style='width: 100; font-size: 10px;'>"
      display "<div style='text-align: right'>"
      display BrandTitlesArr[i] clipped, "</div>"#, "</h2>"
      display "</td>"
   end if
end for
display "</table>"
display "</div>"

## create scrollable display of data
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 950; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto'>"
#display "<div dir='ltr' style='border-bottom: #ccc 1px solid; border-left: #ccc 1px solid; width: 600px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto; border-top: #ccc 1px solid; border-right: #ccc 1px solid'>"

display "<table class='u1' border='0' cellpadding='0' cellspacing='0' dir='ltr'>"

for cnt = 1 to 20
   let BrandCnt[cnt] = 0
end for

let cnt = 0
#foreach ACurs into ARec.*, tmpnm
for cnt = 1 to G_TotalCnt

   display "<tr>"
#   display "<tr style='height: 12px'>"
   display "<td class='leftText' style='height: 10px; width: 200; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
#   display ARecArr[cnt].part_name clipped, "</td>"
#display "<td>",ARecArr[cnt].ceid clipped, "</td>"
   display ARecArr[cnt].part_name clipped, " (", ARecArr[cnt].ceid clipped, ") </td>"
  
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[cnt].lnk_au clipped, "' target ='_blank'>", ARecArr[cnt].ssr_au clipped, "</a></td>"
   if( ARecArr[cnt].ssr_au is not null )then
      let BrandCnt[ brand_au ] = BrandCnt[ brand_au ]+ 1
   end if
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[cnt].lnk_su clipped, "' target ='_blank'>", ARecArr[cnt].ssr_su clipped, "</a></td>"
   if( ARecArr[cnt].ssr_su is not null )then
      let BrandCnt[ brand_su ] = BrandCnt[ brand_su ]+ 1
   end if

   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[cnt].lnk_bu clipped, "' target ='_blank'>", ARecArr[cnt].ssr_bu clipped, "</a></td>"
   if( ARecArr[cnt].ssr_bu is not null )then
      let BrandCnt[ brand_bu ] = BrandCnt[ brand_bu ]+ 1
   end if
   
## AU TSS
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[cnt].lnk_es clipped, "' target ='_blank'>", ARecArr[cnt].ssr_es clipped, "</a></td>"
   if( ARecArr[cnt].ssr_es is not null )then
      let BrandCnt[ brand_es ] = BrandCnt[ brand_es ]+ 1
   end if
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[cnt].lnk_st clipped, "' target ='_blank'>", ARecArr[cnt].ssr_st clipped, "</a></td>"
   if( ARecArr[cnt].ssr_st is not null )then
      let BrandCnt[ brand_st ] = BrandCnt[ brand_st ]+ 1
   end if
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[cnt].lnk_io clipped, "' target ='_blank'>", ARecArr[cnt].ssr_io clipped, "</a></td>"
   if( ARecArr[cnt].ssr_io is not null )then
      let BrandCnt[ brand_io ] = BrandCnt[ brand_io ]+ 1
   end if
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[cnt].lnk_cu clipped, "' target ='_blank'>", ARecArr[cnt].ssr_cu clipped, "</a></td>"
   if( ARecArr[cnt].ssr_cu is not null )then
      let BrandCnt[ brand_cu ] = BrandCnt[ brand_cu ]+ 1
   end if
   

#-------------------------------------------------------------------------------------------------
   display "</tr>"
end for
#end foreach

#-------------------------------------------------------------------------------------------------
#display "</tbody>"
## display summary counts
display "<tfoot>"
display "<tr>"
display "<td>", "</td>"
display "<td>", BrandCnt[brand_au] using "##&", "</td>"
display "<td>", BrandCnt[brand_su] using "##&", "</td>"
display "<td>", BrandCnt[brand_bu] using "##&", "</td>"
display "<td>", BrandCnt[brand_es] using "##&", "</td>"
display "<td>", BrandCnt[brand_st] using "##&", "</td>"
display "<td>", BrandCnt[brand_io] using "##&", "</td>"
display "<td>", BrandCnt[brand_cu] using "##&", "</td>"
{
display "<td>", BrandCnt[brand_ti] using "##&", "</td>"
display "<td>", BrandCnt[brand_ba] using "##&", "</td>"
display "<td>", BrandCnt[brand_se] using "##&", "</td>"
}
display "</tr>"
display "</tfoot>"
display "</table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 1600; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of "
if( HVP = "Y") then
   display "High Value "
end if
display "Partners: ", cnt using "<<<", "<br />"
#display "IM - Information Management, ECM - Enterprise Content Management, BA - Business Analytics, IoT - Internet of Things, AU - Anlytics Units, WS - WebSphere, RA - Rational, TI - Tivoli, SU - Systems Unit"

display "</div>"
display "<p dir='ltr'> &nbsp;</p>"

call ShowVer( 0 )

end main

function LoadMasterCovArr()
define
   i smallint,
   SQLStr char(2048)

#display "before s1"
let SQLStr = "select a.ceid from coverage_au a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union",
" select a.ceid from coverage_su a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union",
" select a.ceid from coverage_bu a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union",
" select a.ceid from coverage_es a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union",
" select a.ceid from coverage_st a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union",
" select a.ceid from coverage_io a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union",
" select a.ceid from coverage_cu a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' ",
" into temp st1;"
prepare LMCAS1 from SQLStr
execute LMCAS1

#display "after s1"

let SQLStr = "select  ",
      "a.ceid,  ",
      "b.part_name part_name,  ",
      "c.part_name part2,  ",
      "d.part_name part3,  ",
      "e.part_name part4,  ",
      "f.part_name part5,  ",
      "g.part_name part6,  ",
      "h.part_name part7,  ",
      "'                                                                  ' uname, ",
      "b.ssr ssr_au,  ",
      "s1.r_link lnk_au, ",
      "c.ssr ssr_su,  ",
      "s2.r_link lnk_su, ",
      "d.ssr ssr_bu,  ",
      "s3.r_link lnk_bu, ",
      "e.ssr ssr_es,  ",
      "s4.r_link lnk_es, ",
      "f.ssr ssr_st,  ",
      "s5.r_link lnk_st, ",
      "g.ssr ssr_io,  ",
      "s6.r_link lnk_io, ",
      "h.ssr ssr_cu,  ",
      "s7.r_link lnk_cu ",
  "from  ",
      "st1 a, ",
      "outer (coverage_au b, outer reps s1 ), ",
      "outer (coverage_su c, outer reps s2 ), ",
      "outer (coverage_bu d, outer reps s3 ), ",
      "outer (coverage_es e, outer reps s4 ), ",
      "outer (coverage_st f, outer reps s5 ), ",
      "outer (coverage_io g, outer reps s6 ), ",
      "outer (coverage_cu h, outer reps s7 ) ",
"where  ",
      "a.ceid = b.ceid ",
  "and a.ceid = c.ceid ",
  "and a.ceid = d.ceid ",
  "and a.ceid = e.ceid ",
  "and a.ceid = f.ceid ",
  "and a.ceid = g.ceid ",
  "and a.ceid = h.ceid ",
  "and b.ssr = s1.r_name ",
  "and c.ssr = s2.r_name ",
  "and d.ssr = s3.r_name ",
  "and e.ssr = s4.r_name ",
  "and f.ssr = s5.r_name ",
  "and g.ssr = s6.r_name ",
  "and h.ssr = s7.r_name ",
"into temp st2; "
prepare LMCAS2 from SQLStr
execute LMCAS2

#display "after s2"

update st2 set part_name = part2 where part_name is null or part_name = ' ';
update st2 set part_name = part3 where part_name is null or part_name = ' ';
update st2 set part_name = part4 where part_name is null or part_name = ' ';
update st2 set part_name = part5 where part_name is null or part_name = ' ';
update st2 set part_name = part6 where part_name is null or part_name = ' ';
update st2 set part_name = part7 where part_name is null or part_name = ' ';

update st2 set uname = upper(part_name);
#display "before final select"
let SQLStr = "select ",
      "a.ceid, ",
      "a.part_name, ",
      "a.uname, ",
      "a.ssr_au, ",
      "a.lnk_au, ",
      "a.ssr_su, ",
      "a.lnk_su, ",
      "a.ssr_bu, ",
      "a.lnk_bu, ",
      "a.ssr_es, ",
      "a.lnk_es, ",
      "a.ssr_st, ",
      "a.lnk_st, ",
      "a.ssr_io, ",
      "a.lnk_io, ",
      "a.ssr_cu, ",
      "a.lnk_cu ",
      "from st2 a order by uname "

   prepare LMA1 from SQLStr
   declare LMA1Curs cursor for LMA1

   let i = 0
   foreach LMA1Curs into ARecArr[i+1].*
      let i = i + 1
   end foreach

   let G_TotalCnt = i

   return G_TotalCnt


end function  #LoadMasterCovArr

function GetSkillColor(in_brand, in_ceid)
define
   in_brand char(2),
   in_ceid char(10),
   ret_color char(15),
   i,max_skill smallint,
   SQLStr char(128),
   CtlRec record like control.*

#display in_brand, in_ceid
   call GetControlRec( in_brand ) returning CtlRec.*

   let SQLStr = "select a.* from ", CtlRec.skill_tab1 clipped, " a where a.ceid='", in_ceid clipped, "'"
#display SQLStr
   prepare GSC1 from SQLStr
   execute GSC1 into KRec.*

## load the Skills Arrays
   call LoadSkillArr( in_brand )

   call LoadSkills()
   let max_skill = 0
   for i = 1 to SkillsMax
      if( BPSkillsArr[i] > max_skill )then
         let max_skill = BPSkillsArr[i]
      end if
   end for
#display "max: ", max_skill

   case max_skill
#     green
      when 3
         let ret_color = "#00FF00"

#     lighter green
      when 2
         let ret_color = "#99EE99"

#     yellow
      when 1
         let ret_color = "#FFFFCC"

#     no-color
      otherwise
         let ret_color = "#FFFFFF"
     
   end case

   return ret_color

end function  #GetSkillColor

function GetFullProdStr()
   define
      i smallint,
      retStr char(128),
      CRec record like control.*

   initialize retStr to NULL

   return retStr

   for i = 1 to 10
      case i
         when brand_ws
            call GetControlRec( "WS" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_im
            call GetControlRec( "IM" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_sc
            call GetControlRec( "SC" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_em
            call GetControlRec( "EM" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

{
         when brand_is
            call GetControlRec( "IS" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "IS", retStr
         when brand_ti
            call GetControlRec( "TI" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "TI", retStr
         when brand_ra
            call GetControlRec( "RA" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "RA", retStr
         when brand_lo
            call GetControlRec( "LO" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "LO", retStr
         when brand_ba
            call GetControlRec( "BA" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "BA", retStr
         when brand_se
            call GetControlRec( "SE" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "SE", retStr
}
      end case
   end for  #i

   return retStr


end function  #GetFullProdStr


