
## June 30, 2015  John M. Shoemaker, add in heatmap report
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #131
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #132
## February 16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #134
## February  17, 2016 John M. Shoemaker, filter out reseller X
## July      21, 2016 John M. Shoemaker, show market name #174
## July      23, 2016 John M. Shoemaker, show market name #174
## August    10, 2016 John M. Shoemaker, refine the loop 
## February  15, 2017  John M. Shoemaker, change title menu variable, #207
## September 21, 2017  John M. Shoemaker, complete migration to focus 5, #249
## September 21, 2017  John M. Shoemaker, give indication of sections that expand, #265
## October   06, 2017  John M. Shoemaker, ignore case in sorting, #269

globals "globals.4gl"

define
   IndRec record
      i_brand like industry.i_brand,
      ig_name like industry.ig_name,
      i_id like industry.i_id,
      i_short like industry.i_short,
      i_name like industry.i_name,
      i_col like _ind_colname.i_col
   end record

main

define
   i smallint,
   SQLStr char(256),
   iCnt smallint

call ReadCmdLn( "industries", 4 )
call ProcCmdLn( "industries" )
call Header(4, IRec.i_id, BRec.b_id, 1)
display " "

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below reflect all of our Partners</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>that have knowledge and experience in these Markets/Industries.</span></em></div>"
#display "<div dir='ltr' style='text-align: center'>"
#display "	<em><span style='font-size: 16px'>Those Partners with 'top' skills have the skills listed in (parens).</span></em></div><p>"

display "<p><div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", CtlRec.menu_str clipped,"</span></em></div>"
display "<p>"

display "<p><div dir='ltr' style='text-align: center'>"
display "<span style='font-size: 16px'>", "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/H/heatmap.html' target='_blank'>", "Market/Industry Segment Heatmap</a></span></div>"
display "<p>"

display "<table style='border:0px dotted black;' align='center';dir='ltr';height='376';style='width: 492px' width='638'>"
display "	<tbody>"

let SQLStr = "select a.i_brand, a.ig_name, a.i_id, a.i_short, a.i_name, b.i_col from industry a, _ind_colname b where a.i_short = b.i_short and a.i_brand = '", BRec.b_id clipped, "' order by a.i_id"
#display SQLStr

#display SQLStr
prepare IID from SQLStr
declare IIDCurs cursor for IID

foreach IIDCurs into IndRec.*
#display IndRec.i_id
   call ShowIN( IndRec.i_id )
end foreach

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowIN( in_in )
define
   in_in smallint,
   cStr char(64),
   wStr char(512),
   qtrStr char(512),
   skillStr char(512),
   cntStr char(512),
   cnt smallint,
   skill_colorStrL char(16),
   skill_textcolorStr char(16),
   cText, vText, tText char(80)  #vText=visible text, cText=changed for internal HTML use

   if( IndRec.ig_name is not null and IndRec.ig_name != " " )then
      let vText = IndRec.ig_name clipped, ":", IndRec.i_name clipped, " "
      let tText = IndRec.ig_name clipped, "  :  ", IndRec.i_name clipped, " "
   else
      let vText = IndRec.i_name clipped, " "
      let tText = IndRec.i_name clipped, " "
   end if
   let cText = noSpaces(vText)
   let vText = tText


#display "<tr>"
#display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
#display "<h3>"

#     display "<span style='font-size: 18px'>", IndRec.i_name clipped, "</span></h3>"


if( UnitModeYN() )then
   case BRec.b_id
      when 'AU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = c.ceid and a.ceid = d.ceid and a.", IndRec.i_col clipped, " is not null and a.", IndRec.i_col clipped, "!=' '"
      when 'SU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.ceid = o.ceid and a.", IndRec.i_col clipped, " is not null and a.", IndRec.i_col clipped, "!=' '"

      when 'BU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.", IndRec.i_col clipped, " is not null and a.", IndRec.i_col clipped, "!=' '"

      when 'ST'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.", IndRec.i_col clipped, " is not null and a.", IndRec.i_col clipped, "!=' '"

      otherwise
         let wStr = "where a.ceid = k.ceid and a.", IndRec.i_col clipped, " is not null and a.", IndRec.i_col clipped, "!=' '"
   end case
else
   let wStr = "where a.ceid = k.ceid and a.", IndRec.i_col clipped, " is not null and a.", IndRec.i_col clipped, "!=' '"
end if  #UnitModeYN


let wStr = wStr clipped, " and a.reseller != 'N' and a.reseller != 'V' and a.reseller !='X' and a.part_type != 'D' "

let qtrStr = BuildBaseStr( BRec.b_id, TRUE )
let cntStr = BuildCntStr( BRec.b_id, TRUE )
let cntStr = cntStr clipped, " ", wStr clipped
#display cntStr
prepare QcntID from cntStr
execute QcntID into cnt

   let qtrStr = qtrStr clipped, " ", wStr clipped, " order by lower(a.part_name)"
#display qtrStr clipped
   prepare QID from qtrStr

   declare ACurs cursor for QID

#display "</td>"
#display "<td style='text-align: left; width: 367px'>"
#display "<div>"

   display "<tr><td colspan='100' style='text-align: left; background-color: ", skill_colorStrL clipped, "; width: 421px; vertical-align: middle'><a href='javascript:;' onClick=togglerows('", cText clipped, "');>", "<span style='font-size: 18px'>", vText clipped, " </span><span style='font-size: 12px'>( ", cnt using '##&', " Partners )</span></a><span style='font-size: 10px'> &nbsp;&nbsp; >> </span>"
display "<tr id='", cText clipped, "' style='display:none'>"
display "<td><table style='border:0px dotted black;'><tr>"

foreach ACurs into URec.*, KRec.*, LRec.*, MRec.*, NRec.*

   display "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a>"

   case URec.reseller 
      when "E" 
         display "<i><span style='font-size: 10px'>(Emerging)</span></i>"
      when "H" 
         if( ShowHVP )then
            display "<i><span style='font-size: 10px'>(HV)</span></i>"
         end if
      when "S" 
         display "<i><span style='font-size: 10px'>(S)</span></i>"
   end case


## displays TOP skills for this partner
#   let skillStr = BuildSkillStrU( 3 )
#   if( skillStr is not null )then
#      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
#   end if


   display "<br/>"
end foreach

display "</td></tr>"

display "</tr></table>"


end function

