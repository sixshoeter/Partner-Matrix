
globals "globals.4gl"

define
   AdhocStr char(256),
   DispStr char(512),
   wCovWS char(128),
   wCovIM char(128),
   wCovTI char(128),
   wCovRA char(128),
   wCovLO char(128),
   wSkiWS char(128),
   wSkiIM char(128),
   wSkiTI char(128),
   wSkiRA char(128),
   wSkiLO char(128),
   wSkiBA char(128),
   wSkiSE char(128),
   wSkiIS char(128),
   aBUArr array[10] of char(20),
   aBUcnt smallint,
   cnt smallint

main

define
   i smallint

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
display "	<tbody>"

declare RepCurs cursor for
   select s.r_name, s.r_link
      from bus b, reps s
      where b.b_ssr = s.r_name
        and b.b_brand = BRec.b_id
        and b.b_name = aBUArr[1]
      order by b.b_id

let i = 1
foreach RepCurs into RepArr[i].*
   let i=i+1
end foreach

call ShowAdhoc2()

display "      </tbody>"
display "   </table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 492px; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of Partners: ", cnt using "<<<"
display "</div"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowAdhoc2( )
define
   in_bu smallint,
   wStr char(64),
   qtrStr char(512),
   skillStr char(64),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   RRec record like reps.*,
   buStr char(64),
   skStr1 char(64),
   skStr2 char(64),
   skStr3 char(64),
   skStr4 char(64),
   skStr5 char(64),
   skStr6 char(64),
   skStr7 char(64),
   skStr8 char(64)

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

display "<span style='font-size: 18px'>Top Skilled Resellers (top skills enclosed in parans)</span></h3>"
display "Please contact the BP Brand Rep"
if( RepArr[1].ssr is not null) then
display "<a href='", RepArr[1].ssr_link clipped, "' target='_blank'>",RepArr[1].ssr clipped, "</a>, "
end if
display " for help in determining the right Partner to work with.<p>"

call ParseAdhocStr( AdhocStr ) returning buStr, skStr1, skStr2, skStr3, skStr4, skStr5
initialize qtrStr to NULL
if( skStr1 is not NULL )then
   let qtrStr = qtrStr clipped, "select a.*, k.* from coverage_ws a, skills_ws k where a.ceid = k.ceid and ", buStr clipped, " and ", skStr1 clipped
end if
if( skStr2 is not NULL )then
   if( qtrStr is not NULL) then
      let qtrStr = qtrStr clipped, " union "
   end if
   let qtrStr = qtrStr clipped, " select a.*, l.* from coverage_im a, skills_im l where a.ceid = l.ceid and ", buStr clipped, " and ", skStr2 clipped
end if
if( skStr3 is not NULL )then
   if( qtrStr is not NULL) then
      let qtrStr = qtrStr clipped, " union "
   end if
   let qtrStr = qtrStr clipped, " select a.*, m.* from coverage_ti a, skills_ti m where a.ceid = m.ceid and ", buStr clipped, " and ", skStr3 clipped
end if
if( skStr4 is not NULL )then
   if( qtrStr is not NULL) then
      let qtrStr = qtrStr clipped, " union "
   end if
   let qtrStr = qtrStr clipped, " select a.*, n.* from coverage_ra a, skills_ra n where a.ceid = n.ceid and ", buStr clipped, " and ", skStr4 clipped
end if
if( skStr5 is not NULL )then
   if( qtrStr is not NULL) then
      let qtrStr = qtrStr clipped, " union "
   end if
   let qtrStr = qtrStr clipped, " select a.*, o.* from coverage_lo a, skills_lo o where a.ceid = o.ceid and ", buStr clipped, " and ", skStr5 clipped
end if
if( skStr6 is not NULL )then
   if( qtrStr is not NULL) then
      let qtrStr = qtrStr clipped, " union "
   end if
   let qtrStr = qtrStr clipped, " select a.*, p.* from coverage_ba a, skills_ba p where a.ceid = p.ceid and ", buStr clipped, " and ", skStr6 clipped
end if
if( skStr7 is not NULL )then
   if( qtrStr is not NULL) then
      let qtrStr = qtrStr clipped, " union "
   end if
   let qtrStr = qtrStr clipped, " select a.*, q.* from coverage_se a, skills_se q where a.ceid = q.ceid and ", buStr clipped, " and ", skStr7 clipped
end if
if( skStr8 is not NULL )then
   if( qtrStr is not NULL) then
      let qtrStr = qtrStr clipped, " union "
   end if
   let qtrStr = qtrStr clipped, " select a.*, r.* from coverage_is a, skills_is r where a.ceid = r.ceid and ", buStr clipped, " and ", skStr8 clipped
end if

let qtrStr = qtrStr clipped, " order by a.part_name"
display qtrStr
display "Adhoc:", AdhocStr clipped
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

display "</td></tr>"

end function

function ParseStr( inStr)
define
   inStr char(256),
   l,i,j smallint,
   BUStr char(256),
   SKStr char(256),
   bucnt, skcnt smallint,
   NewStr char(256),
   skilllevel char(2),
   skilllevelStr char(4)

let bucnt = 0
let skcnt = 0

##FIND BUSINESS UNITS
#display "BEFORE: ", inStr clipped, "<br />"
let l=length(inStr clipped)
for i = 1 to l-4
  if(inStr[i,i+4]="a.bu_") then
     for j = i to l
        if( inStr[j]="=")then
           let BUStr = inStr[i,j-1]
           let NewStr = GetBUStr(BUStr)
           if( bucnt = 0 )then
              let DispStr = DispStr clipped, "BUSINESS UNITS: ", NewStr clipped
           else
              let DispStr = DispStr clipped, ", ", NewStr clipped
           end if
           let bucnt = bucnt + 1
           let aBUArr[bucnt] = NewStr clipped
           exit for
        end if
     end for
  end if 
end for
let aBUcnt = bucnt

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

function GetBUStr( inStr)
define
   inStr char(64),
   colStr char(20),
   QStr char(128),
   tStr like bus.b_name

   let QStr = "select unique a.b_name from bus a where a.b_brand = '", BRec.b_id clipped,
              "' and a.b_id = "
   let colStr = inStr[3,64] clipped

   case colStr 
      when "bu_midwest"
         let QStr = QStr clipped, " 1"
      when "bu_pacifics"
         let QStr = QStr clipped, " 2"
      when "bu_greatwest"
         let QStr = QStr clipped, " 3"
      when "bu_southeast"
         let QStr = QStr clipped, " 4"
      when "bu_midatl"
         let QStr = QStr clipped, " 5"
      when "bu_ny"
         let QStr = QStr clipped, " 6"
      when "bu_northeast"
         let QStr = QStr clipped, " 7"
      when "bu_grtlakes"
         let QStr = QStr clipped, " 8"
      when "bu_canada"
         let QStr = QStr clipped, "10"
      when "bu_federal"
         let QStr = QStr clipped, "09"
      otherwise
         let QStr = QStr clipped, "99"
   end case

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
      otherwise
      let QStr = QStr clipped, "99"
   end case

#display "Skill QStr: ", QStr
prepare LSID from QStr 
execute LSID into tStr
#display "tStr: ", tStr

return tStr

end function

function ParseAdhocStr ( inStr )
define
   inStr char(128),
   i,j,len smallint,
   tmpStr char(3),
   retStr0 char(128),
   retStr  char(128),
   retStr1 char(128),
   retStr2 char(128),
   retStr3 char(128),
   retStr4 char(128),
   retStr5 char(128),
   retStr6 char(128),
   retStr7 char(128),
   retStr8 char(128),
   sStr char(3)

## look for BU
initialize retStr0 to NULL
initialize retStr1 to NULL
initialize retStr2 to NULL
initialize retStr3 to NULL
initialize retStr4 to NULL
initialize retStr5 to NULL
initialize retStr6 to NULL
initialize retStr7 to NULL
initialize retStr8 to NULL

let len = length(inStr clipped)
let sStr = "'Y'"

for i = 1 to len
#display i
   if( inStr[i,i+1]="a.") then
      for j = i to len 
         let tmpStr=inStr[j,j+2]
#display "j:", j, tmpStr clipped
         if (tmpStr = sStr ) then
            let retStr0 = inStr[i,j+2]
            exit for
         end if
#display "J:", j
      end for
   end if
end for

## look for skills
let sStr = "'3'"
for i = 1 to len
if( inStr[i,i+5]=".skill") then
      for j = i to len 
         let tmpStr=inStr[j,j+2]
#display "j:", j, tmpStr clipped
         if (tmpStr = sStr ) then
            let retStr = inStr[i-1,j+2]
            exit for
         end if
#display "J:", j
      end for
end if
end for
#display "retStr: ", retStr
case retStr[1,2]
   when "k."
      let retStr1 = retStr clipped
   when "l."
      let retStr2 = retStr clipped
   when "m."
      let retStr3 = retStr clipped
   when "n."
      let retStr4 = retStr clipped
   when "o."
      let retStr5 = retStr clipped
   when "p."
      let retStr6 = retStr clipped
   when "q."
      let retStr7 = retStr clipped
   when "r."
      let retStr8 = retStr clipped
end case

return retStr0, retStr1, retStr2, retStr3, retStr4, retStr5, retStr6, retStr6, retStr6 

end function  #ParseAdhocStr

