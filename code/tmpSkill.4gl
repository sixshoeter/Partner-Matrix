globals "globals.4gl"

function ProcCmdLn( inprg)
define
   Cnt smallint,
   inprg char(10),
   SQLStr char(128)

call OpenDatabase(CLRec.db)

let SQLStr='select a.* from iots a where a.i_id = "', CLRec.iot clipped, '"'
prepare IID from SQLStr
execute IID into IRec.*

let SQLStr='select a.* from brands a where a.b_id = "', CLRec.brand clipped, '"'
prepare BID from SQLStr
execute BID into BRec.*

#load the SVPArr which lists the text for each SVP authorization for the brand
let SQLStr = "select a.*, 0 flag from svp a where a.s_brand='", BRec.b_id clipped, "' order by s_id"
prepare SVPID from SQLStr
declare SVPCurs cursor for SVPID
let Cnt=0

foreach SVPCurs into SVPArr[Cnt+1].*
   let Cnt=Cnt + 1
end foreach
let G_SVPcnt = Cnt

#load the BUArr which lists the text for each BU authorization for the brand
let SQLStr = "select a.* from bus a where a.b_brand='", BRec.b_id clipped, "' order by b_id"
prepare BUID from SQLStr
declare BUCurs cursor for BUID
let Cnt=0

foreach BUCurs into BUArr[Cnt+1].*
   let Cnt=Cnt + 1
end foreach

#load the INDArr which lists the text for each Industry authorization for the brand
let SQLStr = "select a.* from industry a where a.i_brand='", BRec.b_id clipped, "' order by i_id"
prepare INDID from SQLStr
declare INDCurs cursor for INDID
let Cnt=0

foreach INDCurs into INDArr[Cnt+1].*
   let Cnt=Cnt + 1
end foreach

#load the SkillArr which lists the mapping for the current brand for each skill name
let SQLStr = "select a.s_num, a.s_name, a.s_desc from skill a where a.b_id='", BRec.b_id clipped, "' order by s_num"
prepare SkillID from SQLStr
declare SkillCurs cursor for SkillID
let Cnt=0

foreach SkillCurs into SkillArr[Cnt+1].*
   let Cnt=Cnt + 1
end foreach

## identify the version and refresh date
let V_Num = "2.00a"
let V_Dt = current year to second

end function

function ShowVer( 0 )
   display "<span style='font-size:9px; text-align:left;'>", V_Num clipped, 
           " - ", V_Dt, "</span>"
end function

function GetProgName(inProg)
   define
      inProg smallint,
      retStr char(15)

   case inProg
      when 0
         let retStr = "Home"
      when 1
         let retStr = "Home"
      when 2
         let retStr = "Authorizations"
      when 3
         let retStr = "Skills"
      when 4
         let retStr = "Industries"
      when 5
         let retStr = "Business Units"
      when 6
         let retStr = "Find a Partner"
      otherwise
         let retStr = "Partner Matrix"
   end case

   return retStr
end function


function AddText( basestr, addstr )
define
   basestr char(64),
   addstr char(5)

   if( basestr is null )then
      let basestr = addstr clipped
   else
      let basestr = basestr clipped, ", ", addstr clipped
   end if
   
   return basestr
end function

function BuildSkillStr( inLevel )
define
   inLevel smallint,
   revLevel smallint,
   tmpStr char(15),
   skillStr char(64)

   if( inLevel is null or inLevel > 3 or inLevel < 0 )then
      let inLevel = 3
   end if

   let revLevel = inLevel * -1
   let skillStr=null
   if (KRec.skill_01 = inLevel )then
         let skillStr = AddText( skillStr, SkillArr[1].s_name)
   end if
   if( KRec.skill_01 = revLevel )then
         let tmpStr = SkillArr[1].s_name clipped, "-Services"
         let skillStr = AddText( skillStr, tmpStr )
   end if
   if (KRec.skill_02=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[2].s_name)
   end if
   if (KRec.skill_03=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[3].s_name)
   end if
   if (KRec.skill_04=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[4].s_name)
   end if
   if (KRec.skill_05=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[5].s_name)
   end if
   if (KRec.skill_06=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[6].s_name)
   end if
   if (KRec.skill_07=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[7].s_name)
   end if
   if (KRec.skill_08=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[8].s_name)
   end if
   if (KRec.skill_09=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[9].s_name)
   end if
   if (KRec.skill_10=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[10].s_name)
   end if
   if (KRec.skill_11=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[11].s_name)
   end if
   if (KRec.skill_12=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[12].s_name)
   end if
   if (KRec.skill_13=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[13].s_name)
   end if
   if (KRec.skill_14=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[14].s_name)
   end if
   if (KRec.skill_15=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[15].s_name)
   end if
   if (KRec.skill_16=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[16].s_name)
   end if
   if (KRec.skill_17=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[17].s_name)
   end if
   if (KRec.skill_18=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[18].s_name)
   end if
   if (KRec.skill_19=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[19].s_name)
   end if
   if (KRec.skill_20=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[20].s_name)
   end if

return skillStr

end function

