##
## April    16, 2016 John M. Shoemaker jshoemaker1@cox.net, create 
## June     11, 2016 John M. Shoemaker jshoemaker1@cox.net, migrate Commerce/Cloud to Units
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #131
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #132
## February 16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #134
## February  17, 2016 John M. Shoemaker, filter out reseller X
##

globals "globals.4gl"

define
   IndRec record
      i_brand like industry.i_brand,
      i_id like industry.i_id,
      i_short like industry.i_short,
      i_name like industry.i_name,
      i_col like ind_colname.i_col
   end record,
   SQLStr2 char(256)

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
display "	<em><span style='font-size: 16px'>that have knowledge and experience in these Industries.</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>Those Partners with 'top' skills have the skills listed in (parens).</span></em></div><p>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

let SQLStr = "select a.i_brand, a.i_id, a.i_short, a.i_name, b.i_col from industry a, ind_colname b where a.i_short = b.i_short and a.i_brand = '", BRec.b_id clipped, "' order by a.i_id"
#display SQLStr

prepare IID from SQLStr
declare IIDCurs cursor for IID

foreach IIDCurs into IndRec.*
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
   skill_colorStrL char(16),
   skill_textcolorStr char(16),
   cText, vText char(80),  #vText=visible text, cText=changed for internal HTML use
   cText2, vText2 char(80),  #vText=visible text, cText=changed for internal HTML use
   tEURec record
      e_brand like eus.e_brand,
      e_region like eus.e_region,
      e_id like eus.e_id,
      e_name like eus.e_name,
      colname like _eucolnamesu.colname
   end record

   let vText = IndRec.i_name clipped, " "
   let cText = noSpaces(vText)


#display "<tr>"
#display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
#display "<h3>"

#     display "<span style='font-size: 18px'>", IndRec.i_name clipped, "</span></h3>"


if( UnitModeYN() )then
   case BRec.b_id
      when 'AU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.", IndRec.i_col clipped, " = 'Y'"
      when 'SU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.ceid = o.ceid and a.", IndRec.i_col clipped, " = 'Y'"

      when 'BU'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.", IndRec.i_col clipped, " = 'Y'"

      when 'ST'
         let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.", IndRec.i_col clipped, " = 'Y'"

      otherwise
         let wStr = "where a.ceid = k.ceid and a.", IndRec.i_col clipped, " = 'Y'"
   end case
else
   let wStr = "where a.ceid = k.ceid and a.", IndRec.i_col clipped, " = 'Y'"
end if  #UnitModeYN


let wStr = wStr clipped, " and a.reseller != 'N' and a.reseller != 'V' and a.reseller != 'X' and a.part_type != 'D' "

let qtrStr = BuildBaseStr( BRec.b_id, TRUE )

   let qtrStr = qtrStr clipped, " ", wStr clipped, " order by a.part_name"
#display qtrStr clipped
   prepare QID from qtrStr
   declare ACurs cursor for QID

#display "</td>"
#display "<td style='text-align: left; width: 367px'>"
#display "<div>"

## SHOW GEO
   display "<tr><td colspan='100' style='text-align: center; background-color: ", skill_colorStrL clipped, "; width: 421px; vertical-align: middle'><a href='javascript:;' onClick=togglerows('", cText clipped, "');>", "<span style='font-size: 22px'>", vText clipped, "</span></a><span style='font-size: 12px'>  (Click to expand)</span>"
display "<tr id='", cText clipped, "' style='display:none'>"
display "<td><table border='1'><tr>"

   let SQLStr2 = "select a.e_brand, e_region, e_id, e_name, b.colname from eus a, _eucolnamesu b where a.e_id = b.idx and a.e_brand='", BRec.b_id clipped, "' order by e_id "
#display SQLStr2
   prepare EID from SQLStr2
   declare ECurs cursor for EID


   foreach ECurs into tEURec.*
      let vText2 = tEURec.e_name clipped, "(", vText clipped, ")"
      let cText2 = noSpaces(vText2)

## SHOW PARTNERS
      let skill_colorStrL="rgb(256,200,200)"
      display "<tr><td colspan='100' style='text-align: center; background-color: ", skill_colorStrL clipped, "; width: 421px; vertical-align: middle'><a href='javascript:;' onClick=togglerows('", cText2 clipped, "');>", "<span style='font-size: 14px'>", vText2 clipped, "</span></a><span style='font-size: 12px'>  (Click to expand)</span>"
      display "<tr id='", cText2 clipped, "' style='display:none'>"
      display "<td><table border='1'><tr>"

## now display partners
         foreach ACurs into URec.*, KRec.*, LRec.*, MRec.*, NRec.*
               display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a><br/>"

#   let skillStr = BuildSkillStrU( 3 )
#   if( skillStr is not null )then
#      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
#   end if
#
         end foreach
      display "</td></tr>"

      display "</tr></table>"
   end foreach


display "</td></tr>"

display "</tr></table>"


end function

