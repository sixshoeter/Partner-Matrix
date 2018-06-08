
#July 01, 2013 John M. Shoemaker, refined authorizations page
#July 26, 2013 John M. Shoemaker, order by name no case
#August 20, 2013 John M. Shoemaker, check both bptv feed and coverage for auth
#October 29, 2013 John M. Shoemaker, add ba/se/is brands
#february 14, 2014 John M. Shoemaker, use 'cov_tab' 
#March 26, 2014 John M. Shoemaker, clean up some of the html
#September 18, 2014 John M. Shoemaker, correct title wording

globals "globals.4gl"

main
define
   qtrStr char(512),
   wStr char(512),
   i smallint,
   HVP char(1),
   cnt smallint,
   oe smallint,
   tmpnm char(1),
   BPTV_Cnt smallint


call ReadCmdLn("authorization", 5)
let HVP = arg_val(5)  #only the first 5 values are read via ReadCmdLn
call ProcCmdLn("authorization")
call Header(2, IRec.i_id, BRec.b_id, 1)

display " "

display "<div class='centerText' dir='ltr'>"   
display "	<em><span style='font-size: 16px'>The Partners listed below reflect all of our Covered Partners </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>that are SVP Approved for resell of ", BRec.b_name clipped, " Software.</span></em></div><p>"
display "<div dir='ltr' style='text-align: center'>"

if( ShowHVP )then
   case HVP 
      when "E" 
         display "<span style='font-size:16px;'>Show ALL <a href='../H/authorization.html'>Authorized Partners</a></span><br /><br />"
      when "H" 
         display "<span style='font-size:16px;'>Show ALL <a href='../H/authorization.html'>Authorized Partners</a></span><br /><br />"
      otherwise
         display "<span style='font-size:16px;'>Show ONLY <a href='../H/hvp.html'>High Value Partners</a></span>   "
         display "<span style='font-size:16px;'>Show ONLY <a href='../H/emerging.html'>Emerging Partners</a></span><br /><br />"
   end case
end if

display "	<em><span style='font-size: 16px'></span></em></div>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

## create title for the data
#display "<div style='margin:0px auto;display:block'>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 835px; font: 16px/26px Georgia, Garamond, Serif; height: 50px;'>"
display "<table class='centerText' border='0' cellpadding='0' cellspacing='0' dir='ltr' height='50'>"
#display "<table border='0' cellpadding='0' cellspacing='0' dir='ltr' height='78' width='725' align='center'>"
#display "<colgroup>"
#display "<col style='width: 252px' />"
#display "<col span='3' style='width: 65px' />"
#display "</colgroup>"
#display "<tbody>"

display "<tr>"
display "<th class='leftText' style='width: 275; font-size: 10px;'>"
#display "<th class='leftText'; style='background-color: rgb(230,230,250); width: 275px;'>"
display "<h2>"
display "BP Company Name</h2>"
display "</th>"
for i=1 to G_SVPcnt
   display "<th class='centerText' style='width: 140; font-size: 10px;'>"
   display "<h2 style='text-align: center'>"
   display SVPArr[i].s_name clipped, "</h2>"
   display "</th>"
end for
display "</table>"
display "</div>"

## create scrollable display of data
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 835px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto'>"
#display "<div dir='ltr' style='border-bottom: #ccc 1px solid; border-left: #ccc 1px solid; width: 600px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto; border-top: #ccc 1px solid; border-right: #ccc 1px solid'>"

display "<table class='centerText' border='0' cellpadding='0' cellspacing='0' dir='ltr'>"
#display "<table align='center' border='0' cellpadding='0' cellspacing='0' dir='ltr'>"
#display "<table align='center' border='0' cellpadding='0' cellspacing='0' dir='ltr' style='width: 725px'>"
#display "<colgroup>"
#display "<col style='width: 252px' />"
#display "<col span='3' style='width: 65px' />"
#display "</colgroup>"
#display "<tbody>"

## add in extra column to be used for upshifting the name for sorting
#let qtrStr = BuildBaseStr( BRec.b_id, FALSE )

let qtrStr = "select a.*, a.part_name as ucase from ", cov_tab clipped, " a "
{02/13/2014 - replaced with line above
case BRec.b_id
   when "WS"
      let qtrStr = "select a.*, a.part_name as ucase from coverage_ws a "
   when "IM"
      let qtrStr = "select a.*, a.part_name as ucase from coverage_im a "
   when "TI"
      let qtrStr = "select a.*, a.part_name as ucase from coverage_ti a "
   when "RA"
      let qtrStr = "select a.*, a.part_name as ucase from coverage_ra a "
   when "LO"
      let qtrStr = "select a.*, a.part_name as ucase from coverage_lo a "
   when "BA"
      let qtrStr = "select a.*, a.part_name as ucase from coverage_ba a "
   when "SE"
      let qtrStr = "select a.*, a.part_name as ucase from coverage_se a "
   when "IS"
      let qtrStr = "select a.*, a.part_name as ucase from coverage_is a "
   otherwise
      let qtrStr = "select a.*, a.part_name as ucase from coverage a "
end case
}

let wStr = ""
case HVP 
   when "E"
      let wStr = "where a.reseller='E'"
   when "H"
      let wStr = "where a.reseller='H'"
   when "S"
      let wStr = "where a.reseller='S'"
   otherwise
      let wStr = "where (a.reseller !='N' and a.reseller !='V' and a.reseller != 'S' and a.part_type != 'D') "
end case

## place results into temp table for changing sort name
let qtrStr = qtrStr clipped, " ", wStr clipped, " into temp _arec"

#display qtrStr
## upshift the temp name
prepare tQID from qtrStr
execute tQID
update _arec set ucase = upper(part_name)

let wStr = ""
let qtrStr = "select a.* from _arec a "
if( HVP = "Y" )then
   let wStr = "where a.reseller='H'"
else
   let wStr = "where (a.reseller !='N' and a.reseller !='V')"
end if
## sort by the upshifted name
let qtrStr = qtrStr clipped, " ", wStr clipped, " order by a.ucase"
#display qtrStr
prepare QID from qtrStr

declare ACurs cursor for QID

let cnt = 0
foreach ACurs into ARec.*, tmpnm
   let cnt = cnt + 1

#  load the array of BPTV info
   let BPTV_Cnt = GetBPTVParts( ARec.ceid )

   display "<tr>"
#   display "<tr style='height: 12px'>"
   display "<td class='leftText' style='height: 12px; width: 275px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", ARec.ceid clipped, ".html'>", ARec.part_name clipped, " </a></td>"
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none"
   if( (cnt mod 2) = 0) then
      display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if

#   if( BPTV_Cnt > 0 )then
      if ( SVPinBPTV(SVPArr[1].bptv_name ) or ARec.svp_01 = "Y" )then
         display "Y"
      else
         display " "
      end if
#   else 
#      display " "
#   end if

   display "</td>"
   if( G_SVPcnt >= 2 )then
      display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none"
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
#      if ( BPTVArr[2].bptv_01>0 or ARec.svp_02 = "Y" )then
      if ( SVPinBPTV(SVPArr[2].bptv_name ) or ARec.svp_02 = "Y" )then
         display "Y"
      else
         display " "
      end if
#      display ARec.svp_02, "</td>"
      display "</td>"
      if( G_SVPcnt >= 3 )then
         display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none"
         if( (cnt mod 2) = 0) then
            display "; background-color: #E0E0E0'>"
         else
            display "'>"
         end if
#         if ( BPTVArr[3].bptv_01>0 or ARec.svp_03 = "Y" )then
#display "SVPArr3: ", SVPArr[3].bptv_name clipped, " : " 
         if ( SVPinBPTV(SVPArr[3].bptv_name ) or ARec.svp_03 = "Y" )then
            display "Y"
         else
            display " "
         end if
#         display ARec.svp_03, "</td>"
         display "</td>"
         if( G_SVPcnt >= 4 )then
            display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none"
            if( (cnt mod 2) = 0) then
               display "; background-color: #E0E0E0'>"
            else
               display "'>"
            end if
#            if ( BPTVArr[4].bptv_01>0 or ARec.svp_04 = "Y" )then
            if ( SVPinBPTV(SVPArr[4].bptv_name ) or ARec.svp_04 = "Y" )then
               display "Y"
            else
               display " "
            end if
#            display ARec.svp_04, "</td>"
            display "</td>"
            if( G_SVPcnt >= 5 )then
               display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none"
               if( (cnt mod 2) = 0) then
                  display "; background-color: #E0E0E0'>"
               else
                  display "'>"
               end if
#               if ( BPTVArr[5].bptv_01>0 or ARec.svp_05 = "Y" )then
               if ( SVPinBPTV(SVPArr[5].bptv_name ) or ARec.svp_05 = "Y" )then
                  display "Y"
               else
                  display " "
               end if
#               display ARec.svp_05, "</td>"
               display "</td>"
            end if
         end if
      end if
   end if
   display "</tr>"
end foreach

#display "</tbody>"
display "</table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 835px; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of "
if( HVP = "Y") then
   display "High Value "
end if
display "Partners: ", cnt using "<<<"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"

call ShowVer( 0 )

end main

