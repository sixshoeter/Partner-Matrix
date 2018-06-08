

# May   08, 2015 John M. Shoemaker, created
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

define
   IndRec record like industry.*,
   IndGroupRec record like ind_group.*

main
define
   SQLStr1 char(1024),
   SQLStr2 char(1024),
   wStr char(512),
   i, iCnt smallint,
   HVP char(1),
   cnt smallint,
   oe smallint,
   tmpnm char(1),
   BPTV_Cnt smallint,
   ncolor char(15),
   inProdStr char(128)


call ReadCmdLn("heatmap_lu1", 4)
#let HVP = arg_val(5)  #only the first 5 values are read via ReadCmdLn
call ProcCmdLn("heatmap_lu1")
#call Header(2, 'NA', '--', 0)
call Header(0, IRec.i_id, BRec.b_id, 1)

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

let SQLStr1 = "select unique b.* from industry a, ind_group b where a.ig_name = b.ig_name ",
             " and a.i_brand='", BRec.b_id clipped, "' ",
             " order by b.ig_order "

## build table
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 800; font: 16px/26px Georgia, Garamond, Serif; height: 50px;'>"
display "<table class='u1' border='0' cellpadding='0' cellspacing='0' dir='ltr' height='50'>"

prepare IID1 from SQLStr1
declare IICurs1 cursor for IID1
foreach IICurs1 into IndGroupRec.*
   display "<tr><td>",IndGroupRec.ig_name clipped, "</td></tr>"

   let SQLStr2 = "select a.* from industry a where a.ig_name = '", IndGroupRec.ig_name clipped, "' ",
                " and a.i_brand='", BRec.b_id clipped, "' ",
                " order by a.i_id "

   prepare IID2 from SQLStr2
   declare IICurs2 cursor for IID2
   foreach IICurs2 into IndRec.*
   let iCnt = IndustryCount( IndRec.i_short )
   display "<tr><td><td>",IndRec.i_name clipped, "</td><td>",iCnt, "</td></td></tr>"

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
   tmpcolname like ind_colname.i_col,
   retval smallint

   let SQLStr = "select a.i_col from ind_colname a where a.i_short = '", inIndustry clipped, "'"
   prepare ICLU1 from SQLStr
   execute ICLU1 into tmpcolname

   let SQLStr = "select count(*) from ", cov_tab clipped, " a where a.reseller != 'N' and a.reseller != 'V' and a.reseller !='X' and a.part_type != 'D' and a.", tmpcolname clipped, " ='Y' "
   prepare ICLU2 from SQLStr
   execute ICLU2 into retval

   return retval

end function  #IndustryCount

