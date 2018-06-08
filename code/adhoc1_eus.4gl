##
## October 11, 2013 John M. Shoemaker, multiple changes
## January 16, 2014 John M. Shoemaker, convert to EU from BU
## September 29, 2014 John M. Shoemaker, verify with categories
## November 24, 2014 John M. Shoemaker, expand to 30 skills
##

globals "globals.4gl"

define
   AdhocStr char(256),
   DispStr char(512),
   aEUArr array[30] of char(30),
   aEUcnt smallint,
   cnt smallint,
   NEWRepArr array[2] of
   record
      ssr      like reps.r_name,
      ssr_link like reps.r_link
   end record,
   tssr like reps.r_name,
   tssr_link like reps.r_link


main

define
   i smallint,
   SQLStr char(512)

call ReadCmdLn( "adhoc1", 5)
call ProcCmdLn( "adhoc1" )
let AdhocStr = arg_val(5)
call Header(0, IRec.i_id, BRec.b_id, 1)

let DispStr = "<div dir='ltr' style='text-align: center'> <em><span style='font-size: 20px'>"
display "<p>"
call ParseStr( AdhocStr )
let DispStr = DispStr clipped, "</span></em></div>"

display " "

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed meet <b>ALL</b> of the Criteria provided.</span></em></div><p>"
display DispStr clipped
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "<tbody>"
#display aEUArr[aEUcnt], aEUcnt, AdhocStr clipped

declare RepCurs cursor for 
   select s.r_name, s.r_link 
      from eus b, reps s 
      where b.e_ssr = s.r_name 
        and b.e_brand = BRec.b_id 
        and b.e_name = aEUArr[aEUcnt] 
      order by b.e_id

let i = 1
initialize NEWRepArr[i].* to NULL
foreach RepCurs into tssr, tssr_link
#NEWRepArr[1].ssr, NEWRepArr[1].ssr_link
#display "I:", i
#display NEWRepArr[i].*
   let i=i+1
#display "I:", i

end foreach
#display "I: ", i using "&&&"

call ShowAdhoc1()

display "</tbody>"
display "</table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 492px; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of Partners: ", cnt using "<<&"
display "</div"
display "<p dir='ltr'> &nbsp;</p>"
#display "</tr>"

call ShowVer( 0 )

end main

function ShowAdhoc1( )
define
   in_bu smallint,
   wStr char(64),
   qtrStr char(512),
   skillStr char(64),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   RRec record like reps.*,
   sort_by char(18)

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

display "<span style='font-size: 18px'>Top Skilled Resellers (top skills enclosed in parans)</span></h3>"
display "Please contact the BP Brand Rep"
if( tssr is not null) then
display "<a href='", tssr_link clipped, "' target='_blank'>",tssr clipped, "</a>, "
end if
display " for help in determining the right Partner to work with.<p>"

if( not CtlRec.cflg4 )then
   let qtrStr = BuildBaseStr( BRec.b_id, FALSE )
else
   let qtrStr = BuildBaseStr2( TRUE, FALSE )
end if

let AdhocStr = AdhocStr clipped, " and (a.reseller != 'N' and a.part_type != 'D') "

if( not CtlRec.cflg4 )then
   let sort_by = "a.part_name"
   let qtrStr = qtrStr clipped, " where a.ceid = k.ceid ", AdhocStr clipped, " order by ", sort_by clipped
else
   let sort_by = "a.part_name"
   let qtrStr = qtrStr clipped, " where a.ceid = k.ceid ", AdhocStr clipped, " order by ", sort_by clipped
end if

#   let qtrStr = qtrStr clipped, " where a.ceid = k.ceid ", AdhocStr clipped, " order by ", sort_by clipped
#display qtrStr
   prepare QID from qtrStr
   declare ACurs cursor for QID

display "</td>"
display "<td style='text-align: left; width: 367px'>"
display "<div>"

let cnt = 0

foreach ACurs into ARec.*, KRec.*

   let cnt = cnt + 1
   let skillStr = BuildSkillStr ( 3 )
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", ARec.ceid clipped, ".html'>", ARec.part_name clipped, "</a>"

   case ARec.reseller 
      when "E"
         display "<i><span style='font-size: 10px'>(Emerging)</span></i>"
      when "H"
         if( ShowHVP )then
            display "<i><span style='font-size: 10px'>(HV)</span></i>"
         end if
      when "S"
         display "<i><span style='font-size: 10px'>(S)</span></i>"
   end case

   if( skillStr is not null )then
      display "<br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp(", skillStr clipped, ") </span>"
   end if

   display "<br/>"
{end if}
end foreach
#display "CNT: ", cnt
if( cnt = 0 )then
   display "<em>No partners meet the search criteria.</em>"
end if
display "</td></tr>"

end function

function ParseStr( inStr)
define
   inStr char(256),
   l,i,j smallint,
   EUStr char(256),
   SKStr char(256),
   bucnt, skcnt smallint,
   NewStr char(256),
   skilllevel char(2),
   skilllevelStr char(4)

let bucnt = 0
let skcnt = 0

##FIND ENTERPRISE UNITS
#display "BEFORE: ", inStr clipped, "<br />"
let l=length(inStr clipped)
for i = 1 to l-4
  if(inStr[i,i+4]="a.eu_") then
     for j = i to l
        if( inStr[j]="=")then
           let EUStr = inStr[i,j-1]
           let NewStr = GetEUStr(EUStr)
#           display "NewStr: ", NewStr clipped
           if( bucnt = 0 )then
              let DispStr = DispStr clipped, "ENTERPRISE UNITS: ", NewStr clipped
#           else
#              let DispStr = DispStr clipped, ", ", NewStr clipped
           end if
           let bucnt = bucnt + 1
           let aEUArr[bucnt] = NewStr clipped
           exit for
        end if
     end for
  end if 
end for
let aEUcnt = bucnt

if(bucnt>0)then
   let DispStr = DispStr clipped, "<br />"
end if
##FIND SKILLS
#display "BEFORE: ", inStr clipped
for i = 1 to l-7
  if(inStr[i,i+7]="k.skill_") then
     let skilllevel=inStr[i+14,i+14]
     if( skilllevel = "3" )then
        let skilllevelStr = "   "
     else
        let skilllevelStr = "(", skilllevel clipped, ")"
     end if
     for j = i to l
        if( inStr[j]="=")then
           let SKStr = inStr[i,j-1]
           let NewStr = GetSKStr(SKStr)
#display "SKStr: ", SKStr
#display "NewStr: ", NewStr 
           if( skcnt = 0 )then
              let DispStr = DispStr clipped, "SKILLS: ", NewStr clipped, " ", skilllevelStr clipped
           else
              let DispStr = DispStr clipped, ", ", NewStr clipped, " ", skilllevelStr clipped
           end if
           let skcnt = skcnt + 1
           exit for
        end if
     end for
  end if 
end for
end function

function GetEUStr( inStr)
define
   inStr char(64),
   colStr char(30),
   QStr char(128),
   tStr like eus.e_name,
   i smallint


   initialize tStr to NULL
   initialize QStr to NULL
   let QStr = "select unique a.e_name from eus a where a.e_brand = '", BRec.b_id clipped, "' and a.e_id = "
   let colStr = inStr[3,64] clipped

#   display "QStr (before for): ", QStr clipped
   for i = 1 to G_NumCols
      if( EUColNamesArr[i].colname = colStr )then
         let QStr = QStr clipped, " ", EUColNamesArr[i].idx using '##'
         exit for
      end if
   end for
#   display "QStr (after for): ", QStr clipped

#display "QStr: ", QStr
prepare LBID from QStr 
execute LBID into tStr

return tStr

end function


function GetSKStr( inStr)
define
   inStr char(64),
   colStr char(20),
   QStr char(128),
   tStr char(128)

   let QStr = "select unique a.s_desc from skill a where a.b_ID = '", BRec.b_id clipped,
              "' and a.s_num = "
   let colStr = inStr[3,64] clipped

   case colStr 
      when "skill_01"
         let QStr = QStr clipped, " 1"
      when "skill_02"
         let QStr = QStr clipped, " 2"
      when "skill_03"
         let QStr = QStr clipped, " 3"
      when "skill_04"
         let QStr = QStr clipped, " 4"
      when "skill_05"
         let QStr = QStr clipped, " 5"
      when "skill_06"
         let QStr = QStr clipped, " 6"
      when "skill_07"
         let QStr = QStr clipped, " 7"
      when "skill_08"
         let QStr = QStr clipped, " 8"
      when "skill_09"
         let QStr = QStr clipped, " 9"
      when "skill_10"
         let QStr = QStr clipped, "10"
      when "skill_11"
         let QStr = QStr clipped, "11"
      when "skill_12"
         let QStr = QStr clipped, "12"
      when "skill_13"
         let QStr = QStr clipped, "13"
      when "skill_14"
         let QStr = QStr clipped, "14"
      when "skill_15"
         let QStr = QStr clipped, "15"
      when "skill_16"
         let QStr = QStr clipped, "16"
      when "skill_17"
         let QStr = QStr clipped, "17"
      when "skill_18"
         let QStr = QStr clipped, "18"
      when "skill_19"
         let QStr = QStr clipped, "19"
      when "skill_20"
         let QStr = QStr clipped, "20"
      when "skill_21"
         let QStr = QStr clipped, "21"
      when "skill_22"
         let QStr = QStr clipped, "22"
      when "skill_23"
         let QStr = QStr clipped, "23"
      when "skill_24"
         let QStr = QStr clipped, "24"
      when "skill_25"
         let QStr = QStr clipped, "25"
      when "skill_26"
         let QStr = QStr clipped, "26"
      when "skill_27"
         let QStr = QStr clipped, "27"
      when "skill_28"
         let QStr = QStr clipped, "28"
      when "skill_29"
         let QStr = QStr clipped, "29"
      when "skill_30"
         let QStr = QStr clipped, "30"
      otherwise
      let QStr = QStr clipped, "99"
   end case

#display "Skill QStr: ", QStr
prepare LSID from QStr 
execute LSID into tStr
#display "tStr: ", tStr

return tStr

end function

