
## May   08, 2015 John M. Shoemaker, created
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

define
   IndRec record like industry.*,
   IndGroupRec record like ind_group.*,
#   SkillCatArr array[100] of record like skill_cat.*,
   SkillRec record like skill.*,
   BrandRec record like brands.*

main
define
   SQLStr0 char(1024),
   SQLStr1 char(1024),
   SQLStr2 char(1024),
   SQLStr3 char(1024),
   wStr char(512),
   i, iCnt, idx, ti smallint,
   cntval smallint,
   HVP char(1),
   cnt smallint,
   oe smallint,
   tmpnm char(1),
   BPTV_Cnt smallint,
   ncolor char(15),
   t_iot like iots.i_name,
   inProdStr char(128)


call ReadCmdLn("heatmap", 4)
#let HVP = arg_val(5)  #only the first 5 values are read via ReadCmdLn
call ProcCmdLn("heatmap")
#call Header(2, 'NA', '--', 0)
call Header(21, IRec.i_id, BRec.b_id, 1)

display " "

display "<div class='centerText' dir='ltr'>"   
#display "<em><span style='font-size: 16px'>The Partners listed below reflect all of our Partners </span></em></div>"
#display "<div dir='ltr' style='text-align: center'>"
#display "<em><span style='font-size: 16px'>that are SVP Approved for resell of IBM Software.</span><br />"

#display "Address to this location: <a href='https://ibm.biz/PartnerMatrix'>https://ibm.biz/PartnerMatrix</a><br />"

display "<div dir='ltr' style='text-align: center'>"

display "<em><span style='font-size: 16px'></span></em></div>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", "IOT Industry Segment Heatmap", "</span></em></div>"
#if( inProdStr is not NULL )then
#   display "<em><span style='font-size: 20px'>", "In Production: ", inProdStr clipped, "</span></em></div>"
#display "These brands on in production: ", inProdStr clipped
#else
#   let inProdStr = "WebSphere, Information Management, Ind Sol: Smarter Cities, ECM"
#   display "<div dir='ltr' style='text-align: center'>"
#   display "<em><span style='font-size: 20px'>", "Brands in Production: ", inProdStr clipped, "</span></em></div>"
#end if
display "<p>"

## get the full IOT name
let SQLStr0 = "select a.i_name from iots a where a.i_id='", CLRec.iot clipped, "'"
prepare IOTID from SQLStr0
execute iOTID into t_iot

#display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 800; font: 16px/26px Georgia, Garamond, Serif; height: 50px;'>"
display "<table class='u1' border='1' cellpadding='0' cellspacing='0' dir='ltr' height='50'>"
## get the skill categories 
let SQLStr0 = "select a.* from skill_cat a, unit_brand b ",
              "where a.c_brand = b.b_id and b.u_id = '", BRec.b_id clipped, "' ",
              "order by b.ord, a.c_id"

#display SQLStr0
prepare IID0 from SQLStr0
declare IICurs0 cursor for IID0
display "<tr><th colspan='2' style='font-size: 24px; text-align:center; background-color: #add8e6'>", t_iot clipped, "<th style='text-align:center; background-color: #add8e6'>Total"
let idx = 0
foreach IICurs0 into SkillCatArr[idx+1].*
   display "<th style='text-align:center; background-color: #add8e6'>", SkillCatArr[idx+1].c_long clipped, "</th>"
   let idx = idx + 1
end foreach
display "</tr>"

## get the actual skills, bt category 
#let SQLStr1 = "select b.* from skill b ",
#              "where b.c_id=", SkillCatRec.c_id, " and b.b_id = '", SkillCatRec.c_brand clipped, "' ",
#              " and b.s_name != 'NA' ",
#              "order by b.s_num"
#display "<tr>"
#prepare IID1 from SQLStr1
#declare IICurs1 cursor for IID1
#foreach IICurs1 into SkillRec.*
#      display "<th>", SkillRec.s_desc clipped, "</th>" 
#end foreach
#display "</tr>"

## get the industry groups
let SQLStr2 = "select unique b.* from industry a, ind_group b where a.ig_name = b.ig_name ",
             " and a.i_brand='", BRec.b_id clipped, "' and b.ig_brand='", BRec.b_id clipped, "'",
             " order by b.ig_order "

## build table

prepare IID2 from SQLStr2
declare IICurs2 cursor for IID2
foreach IICurs2 into IndGroupRec.*
   display "<tr><td colspan=99; style='background-color: #add8e6;font-size: 24px'><strong>",IndGroupRec.ig_name clipped, "</strong></td></tr>"

## get the industries for a particular industry group 
   let SQLStr3 = "select a.* from industry a where a.ig_name = '", IndGroupRec.ig_name clipped, "' ",
                " and a.i_brand='", BRec.b_id clipped, "' ",
                " order by a.i_id "

   prepare IID3 from SQLStr3
   declare IICurs3 cursor for IID3
   foreach IICurs3 into IndRec.*
      let iCnt = IndustryCount( IndRec.i_short )
      display "<tr><td style='background-color: #add8e6'><td style='background-color: #add8e6'><strong>",IndRec.i_name clipped, "</strong></td><td style='text-align:center;'>","<a href=/", CLRec.iot clipped, "/", CLRec.brand clipped, "/H/", IndRec.i_short clipped,".html target='_blank'>",iCnt, "</a></td>"
      for i = 1 to idx 
         let cntval = GroupCount(IndRec.i_short, SkillCatArr[i].* )
         display "<td style='text-align:center;'>", "<a href=/", CLRec.iot clipped, "/",  CLRec.brand clipped, "/H/", SkillCatArr[i].c_brand clipped, "-", IndRec.i_short clipped, "-", SkillCatArr[i].c_id using "<<", ".html target='_blank'>", cntval, "</a></td>"
      end for
display "</div>"

   end foreach

end foreach
display "</table>"

#-------------------------------------------------------------------------------------------------
#display "</tbody>"
## display summary counts

call ShowVer( 0 )

end main

function IndustryCount( inIndustry )
define
   inBrand like brands.b_id,
   inIndustry like industry.i_short,
   SQLStr char(512),
   tmpcolname like _ind_colname.i_col,
   retval smallint

   let SQLStr = "select a.i_col from _ind_colname a where a.i_short = '", inIndustry clipped, "'"
   prepare ICLU1 from SQLStr
   execute ICLU1 into tmpcolname

   let SQLStr = "select count(*) from ", cov_tab clipped, " a where a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' and a.part_type != 'D' and a.", tmpcolname clipped, " is not null and a.", tmpcolname clipped, " !=' ' "
#display SQLStr
   prepare ICLU2 from SQLStr
   execute ICLU2 into retval

   return retval

end function  #IndustryCount

function GroupCount(in_industry, SkillCatRec )
   define
      in_industry like industry.i_short,
      SkillCatRec record like skill_cat.*,
      returnCnt smallint,
      SQLStr char(1024),
      tabStr char(128),
      skillStr char(128),
      cname like _ind_colname.i_col,
      i, ti smallint
     
      let returnCnt = 0

##    find those partners with industry skill in this skill category
      let SQLStr="select unique a.* from brands a, unit_brand b where a.b_id=b.b_id and b.u_id='", BRec.b_id clipped, "' and a.b_id = b.b_id order by a.b_ord"
      prepare GCID3 from SQLStr
      declare GCID3Curs cursor for GCID3
      foreach GCID3Curs into BrandRec.*
         call LoadSkillsU( "", BrandRec.b_ord )
         let ti = BrandRec.b_ord
         initialize tabStr to NULL
         let skillStr = " ("
         for i = 1 to 30
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

      if( tabStr is not NULL )then
         let SQLStr = "select count(*) from ", cov_tab clipped, " a ", ", ", tabStr clipped, " where a.ceid = b.ceid and a.reseller != 'N' and a.reseller != 'V' and a.part_type!='D' ",
                   " and a.", cname clipped, " is not null and a.", cname clipped, " != ' ' ", 
                   " and ", skillStr clipped
#display SQLStr clipped
   prepare GCID2 from SQLStr
   execute GCID2 into returnCnt
#      else
#         let SQLStr = "select count(*) from ", cov_tab clipped, " a where a.reseller != 'N' and a.reseller != 'V' and a.part_type!='D' ",
#                   " and a.", cname clipped, " = 'Y' "
      end if
      end foreach

#"select * from skill where b_id='IM' and c_id=1"
      


   return returnCnt

end function  #GroupCount

