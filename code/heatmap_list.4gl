
## May       12, 2015 John M. Shoemaker, created
## August    03, 2015 John M. Shoemaker, correct titles for all units
## September 22, 2015 - John M. Shoemaker, jshoe@us.ibm.com - add in Social Unit OU
## February  16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #134
## February  17, 2016 John M. Shoemaker, filter out reseller X
## July      23, 2016 John M. Shoemaker, add support for markets #174
## February  02, 2017 John M. Shoemaker, allow non-null industries to be included, #204


globals "globals.4gl"

define
   ARecArr array[1000] of record 
      ceid like coverage_au.ceid,
      part_name like coverage_au.part_name,
      uname like coverage_au.part_name,

      ssr_au like coverage_au.ssr,
      lnk_aus like reps.r_link,

      ctp_au1 like coverage_au.ctp1,
      ctp_au2 like coverage_au.ctp2,
      ctp_au3 like coverage_au.ctp3,
      ctp_au4 like coverage_au.ctp4,
      ctp_au5 like coverage_au.ctp5,

      lnk_au1 like reps.r_link,
      lnk_au2 like reps.r_link,
      lnk_au3 like reps.r_link,
      lnk_au4 like reps.r_link,
      lnk_au5 like reps.r_link
   end record,
#   ARecArr array[500] of record like coverage_ws.*,
   G_TotalCnt smallint,
   BrandTitlesArr array[20] of char(15)


main
define
   qtrStr char(512),
   wStr char(512),
   i smallint,
   Ind like industry.i_short,
   SkiCat like skill_cat.c_id,
   inBrand like brands.b_id,
   cnt smallint,
   oe smallint,
   tmpnm char(1),
   BPTV_Cnt smallint,
   ncolor char(15),
   t_long like skill_cat.c_long,
   inProdStr char(128),
   SQLStr char(256)


call ReadCmdLn("heatmap_detail", 7)
let inBrand = arg_val(5)  #only the first 5 values are read via ReadCmdLn
let Ind = arg_val(6)  #only the first 5 values are read via ReadCmdLn
let SkiCat = arg_val(7)  #only the first 5 values are read via ReadCmdLn
call ProcCmdLn("heatmap_detail")
#call Header(2, 'NA', '--', 0)
call Header(0, IRec.i_id, BRec.b_id, 1)
#display "INPUT: Ind: ", Ind

case BRec.b_id
   when 'AU'
      let BrandTitlesArr[1] = "AU BPR"
      let BrandTitlesArr[2] = "IM TSS"
      let BrandTitlesArr[3] = "ECM TSS"
      let BrandTitlesArr[4] = "BA TSS"
      let BrandTitlesArr[5] = "IoT TSS"
      let BrandTitlesArr[6] = "Other AU TSS"
   when 'SU'
      let BrandTitlesArr[1] = "WS BPR"
      let BrandTitlesArr[2] = "RA TSS"
      let BrandTitlesArr[3] = "TI TSS"
      let BrandTitlesArr[4] = "Other TSS"
   when 'BU'
      let BrandTitlesArr[1] = "Commerce BPR"
      let BrandTitlesArr[2] = "Commerce TSS"
   otherwise
      let BrandTitlesArr[1] = "BPR"
      let BrandTitlesArr[2] = "TSS"
end case

call GetFullProdStr() returning inProdStr  

let SQLStr = "select a.c_long from skill_cat a where a.c_brand='", inBrand clipped, "' ",
             "and a.c_id=", SkiCat 
#display "SQLStr: ", SQLStr
prepare SCL1 from SQLStr
execute SCL1 into t_long

display " "

display "<div class='centerText' dir='ltr'>"   

display "<div dir='ltr' style='text-align: center'>"

display "<em><span style='font-size: 16px'></span></em></div>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", Ind clipped, " Partners with ", t_long clipped, " Skills", "</span></em></div>"
display "<p>"

## Load ALL Data (all brands
let cnt = LoadMasterCovArr( inBrand, Ind, SkiCat )
#display "cnt: ", cnt

## create title for the data
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 800px; font: 16px/26px Georgia, Garamond, Serif; height: 50px;'>"
display "<table class='u1' border='0' cellpadding='0' cellspacing='0' dir='ltr' height='50'>"

display "<tr>"
display "<td class='leftText' style='height: 10px; width: 150; font-size: 10px;'>"
display "BP Company Name"  #</h2>"
display "</td>"
for i=1 to 6
   display "<td class='rightText' style='width: 100; font-size: 10px;'>"
   display "<div style='text-align: right'>"

   display BrandTitlesArr[i] clipped, "</div>"#, "</h2>"
   display "</td>"
end for
display "</table>"
display "</div>"

## create scrollable display of data
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 800px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto'>"
#display "<div dir='ltr' style='border-bottom: #ccc 1px solid; border-left: #ccc 1px solid; width: 600px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto; border-top: #ccc 1px solid; border-right: #ccc 1px solid'>"

display "<table class='u1' border='0' cellpadding='0' cellspacing='0' dir='ltr'>"

#foreach ACurs into ARec.*, tmpnm
for i = 1 to cnt

   display "<tr>"
#   display "<tr style='height: 12px'>"
   display "<td class='leftText' style='height: 10px; width: 200; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
#   display ARecArr[i].part_name clipped, "</td>"
#display "<td>",ARecArr[i].ceid clipped, "</td>"
   
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", ARecArr[i].ceid clipped, ".html' target='_blank'>", ARecArr[i].part_name clipped, "</a>", " (", ARecArr[i].ceid clipped, ") </td>"

  
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_aus clipped, "' target ='_blank'>", ARecArr[i].ssr_au clipped, "</a></td>"
   
{
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_sus clipped, "' target ='_blank'>", ARecArr[i].ssr_su clipped, "</a></td>"

   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_iss clipped, "' target ='_blank'>", ARecArr[i].ssr_is clipped, "</a></td>"
} 
## AU TSS
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au1 clipped, "' target ='_blank'>", ARecArr[i].ctp_au1 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au2 clipped, "' target ='_blank'>", ARecArr[i].ctp_au2 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au3 clipped, "' target ='_blank'>", ARecArr[i].ctp_au3 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au4 clipped, "' target ='_blank'>", ARecArr[i].ctp_au4 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au5 clipped, "' target ='_blank'>", ARecArr[i].ctp_au5 clipped, "</a></td>"
   
## SU TSS
{
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su1 clipped, "' target ='_blank'>", ARecArr[i].ctp_su1 clipped, "</a></td>"
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su2 clipped, "' target ='_blank'>", ARecArr[i].ctp_su2 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su3 clipped, "' target ='_blank'>", ARecArr[i].ctp_su3 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su4 clipped, "' target ='_blank'>", ARecArr[i].ctp_su4 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su5 clipped, "' target ='_blank'>", ARecArr[i].ctp_su5 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_is1 clipped, "' target ='_blank'>", ARecArr[i].ctp_is1 clipped, "</a></td>"
}
   

#-------------------------------------------------------------------------------------------------
   display "</tr>"
end for
#end foreach

#-------------------------------------------------------------------------------------------------
#display "</tbody>"
## display summary counts
display "</table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 800px; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of "
display "Partners: ", cnt using "<<<", "<br />"

display "</div>"
display "<p dir='ltr'> &nbsp;</p>"

call ShowVer( 0 )

end main

function LoadMasterCovArr( inBrand, inInd, inSkillCat )
define
   inBrand like brands.b_id,
   inInd like industry.i_short,
   inSkillCat like skill_cat.c_id,
   cnt, i smallint,
   tmpcolname like _ind_colname.i_col,
   SQLStr char(1024),
   SkillCatRec record like skill_cat.*
 
   let SQLStr = "select a.i_col from _ind_colname a where a.i_short = '", inInd clipped, "'"
   prepare ICLU1 from SQLStr
   execute ICLU1 into tmpcolname
#display "tmpcolname: ", tmpcolname
#display "inBrand: ", inBrand

let cnt = GroupCEIDs( inBrand, inInd, inSkillCat )
#display "cnt: ", cnt

let SQLStr = "select a.ceid from ", cov_tab clipped, " a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' and a.", tmpcolname clipped, " is not null and a.", tmpcolname clipped, " != ' ' and a.ceid in (select ceid from _ceids) into temp st1;"

#select a.ceid from coverage_au a where a.reseller !='N' and a.reseller !='V' and a.part_type!='D' union
#select a.ceid from coverage_su a where a.reseller !='N' and a.reseller !='V' and a.part_type!='D' union
#select a.ceid from coverage_is a where a.reseller !='N' and a.reseller !='V' and a.part_type!='D' 
#into temp st1;

#display SQLStr
   prepare ICLU2 from SQLStr
   execute ICLU2 

## get list of CEIDs to use

#display "After creation of st1"


let SQLStr = "select  ",
      "a.ceid, ",
      "b.part_name part_name, ",
      "'                                                                  ' uname, ",
      "b.ssr ssr_au,  ",
      "s1.r_link lnk_aus, ",
      "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
      "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
  "from  ",
      "st1 a,  ",
      "outer (", cov_tab clipped, " b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
"where ",
      "a.ceid = b.ceid ",
  "and b.ssr = s1.r_name ",
  "and b.ctp1 = m.r_name ",
  "and b.ctp2 = n.r_name ",
  "and b.ctp3 = o.r_name ",
  "and b.ctp4 = p.r_name ",
  "and b.ctp5 = q.r_name ",
"into temp st2; "

#display SQLStr
   prepare GSC2 from SQLStr
   execute GSC2 

#display "after creation of st2"

update st2 set uname = upper(part_name);

let SQLStr = "select ",
      "a.ceid, ",
      "a.part_name, ",
      "a.uname, ",
      "a.ssr_au, ",
      "a.lnk_aus, ",
      "ctp_au1, ctp_au2, ctp_au3, ctp_au4, ctp_au5, ",
      "lnk_au1, lnk_au2, lnk_au3, lnk_au4, lnk_au5 ",
      "from st2 a order by uname "

#display SQLStr
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

      end case
   end for  #i

   return retStr


end function  #GetFullProdStr


function GroupCEIDs(in_brand, in_industry, in_skillcat )
   define
      in_brand like brands.b_id,
      in_industry like industry.i_short,
      in_skillcat like skill_cat.c_id,
      returnCnt smallint,
      SQLStr char(1024),
      tabStr char(128),
      skillStr char(128),
      cname like _ind_colname.i_col,
      i, ti smallint,
      BrandRec record like brands.*,
      SkillCatRec record like skill_cat.*
     
      let returnCnt = 0

##    find those partners with industry skill in this skill category
      let SQLStr="select unique a.* from brands a where a.b_id = '", in_brand clipped, "'"
#display SQLStr
      prepare GCID3 from SQLStr
      declare GCID3Curs cursor for GCID3
      foreach GCID3Curs into BrandRec.*
         call LoadSkillsU( "", BrandRec.b_ord )
         let ti = BrandRec.b_ord
#display "ti: ", ti
         let SQLStr = "select a.* from skill_cat a where a.c_brand='", BrandRec.b_id clipped, "' and a.c_id=", in_skillcat
#display SQLStr
         prepare GSCUD1 from SQLStr
	 execute GSCUD1 into SkillCatRec.*
         initialize tabStr to NULL
         let skillStr = " ("
         for i = 1 to 30
#display " SkillCatRec.c_brand: ", SkillCatRec.c_brand
#display "       BrandRec.b_id:", BrandRec.b_id
#display "SkillArrU[ti,i].c_id: ", SkillArrU[ti,i].c_id 
#display "    SkillCatRec.c_id: ", SkillCatRec.c_id
            if( SkillCatRec.c_brand = BrandRec.b_id and SkillArrU[ti,i].c_id = SkillCatRec.c_id )then
               if( tabStr = "" or tabStr is NULL )then
                  let tabStr = "skills_", BrandRec.b_id clipped, " b "
               end if
#               display "Brand: ", BrandRec.b_name clipped, " - I:",i, "-", SkillArrU[ti,i].*
               if( skillStr != " (" )then
                  let skillStr = skillStr clipped, " or "
               end if
               let skillStr = skillStr clipped, " ", "b.skill_", SkillArrU[ti,i].db_num using "&&", "=3"
            end if
         end for
         let skillStr = skillStr clipped, ")"
#display "tabStr: ", tabStr
#display "skillStr: ", skillStr
##    determine the column name for the correct industry
      let SQLStr = "select a.i_col from _ind_colname a where a.i_short = '", in_industry clipped, "'"
      prepare GCID1 from SQLStr
      execute GCID1 into cname

      if( tabStr is not NULL AND cname is not NULL )then
         let SQLStr = "select a.ceid from ", cov_tab clipped, " a ", ", ", tabStr clipped, " where a.ceid = b.ceid and a.reseller != 'N' and a.reseller != 'V' and a.part_type!='D' ",
                   " and a.", cname clipped, " is not NULL ", 
                   " and a.", cname clipped, " != ' ' ", 
                   " and ", skillStr clipped,
                   " into temp _ceids"
#display "SQLStr: ", SQLStr
         prepare GCID2 from SQLStr
         execute GCID2 
#      else
#         let SQLStr = "select count(*) from ", cov_tab clipped, " a where a.reseller != 'N' and a.reseller != 'V' and a.part_type!='D' ",
#                   " and a.", cname clipped, " = 'Y' "
      end if
      end foreach

#"select * from skill where b_id='IM' and c_id=1"


   return returnCnt

end function  #GroupCEIDs

