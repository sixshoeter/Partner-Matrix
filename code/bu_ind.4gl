
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"
define
   RepMax smallint

main

define
   i smallint,
   str char(20),
   inBU smallint

call ReadCmdLn( "businessunits", 5 )
call ProcCmdLn( "businessunits" )
let inBU = arg_val(5)  #only the first 5 values are read via ReadCmdLn

call Header(5, IRec.i_id, BRec.b_id, 1)

display " "
let str = DOWNSHIFT(BRec.b_id)

display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed below are selling into these Business Units. </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>Those Partners with 'top' skills have the skills listed in (parens).</span></em></div><p>"
display "<div dir='ltr' style='text-align: center'>"
#display "	<em><span style='font-size: 16px'>The TOP Skilled Partners are marked with '*'. <a HREF='/query_", str clipped, ".html'>Find a Partner</a></span></em>"
display "</div><p>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "	<tbody>"

declare RepCurs cursor for
   select b_brand, s.r_name, s.r_link, c.r_name, c.r_link 
      from bus b, reps s, reps c 
      where b.b_ssr = s.r_name
        and b.b_ctp = c.r_name
        and b.b_id = inBU
        and (s.r_name != 'Open' or c.r_name != 'Open')
      order by b.b_id


let i = 0
foreach RepCurs into RepArr2[i+1].*
   let i=i+1
end foreach
let RepMax = i

#for i = 1 to 10
   call ShowBUInd( inBU )
#end for

display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function ShowBUInd( in_bu )
define
   in_bu smallint,
   wStr char(512),
   qtrStr char(512),
   skillStr char(512),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   RRec record like reps.*,
   tmpnm char(1)

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

case in_bu
   when 1
      display "<span style='font-size: 18px'>Midwest</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_midwest='Y' or a.bu_midwest='H')"
   when 2
      display "<span style='font-size: 18px'>Pacifics</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_pacifics='Y' or a.bu_pacifics='H')"
   when 3
      display "<span style='font-size: 18px'>Great West</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_greatwest='Y' or a.bu_greatwest='H')"
   when 4
      display "<span style='font-size: 18px'>Southeast</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_southeast='Y' or a.bu_southeast='H')"
   when 5
      display "<span style='font-size: 18px'>Mid-Atlantic</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_midatl='Y' or a.bu_midatl='H')"
   when 6
      display "<span style='font-size: 18px'>New York</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_ny='Y' or a.bu_ny='H')"
   when 7
      display "<span style='font-size: 18px'>Northeast</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_northeast='Y' or a.bu_northeast='H')"
   when 8
      display "<span style='font-size: 18px'>Great Lakes</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_grtlakes='Y' or a.bu_grtlakes='H')"
   when 9
      display "<span style='font-size: 18px'>Federal</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_federal='Y' or a.bu_federal='H')"
   when 10
      display "<span style='font-size: 18px'>Canada</span></h3>"
      if( not IsEmpty( BUArr[in_bu].b_imt ) )then 
         display "<span style='font-size: 14px'><em>", BUArr[in_bu].b_imt clipped," IMT</em></span><p>"
      end if
      call ShowReps( RepMax )
      let wStr = "where a.ceid = k.ceid and (a.bu_canada='Y' or a.bu_canada='H')"
end case


case BRec.b_id
   when "WS"
      let qtrStr = "select a.*, k.* from coverage_ws a, outer skills_ws k "
   when "IM"
      let qtrStr = "select a.*, k.* from coverage_im a, outer skills_im k "
   when "TI"
      let qtrStr = "select a.*, k.* from coverage_ti a, outer skills_ti k "
   when "RA"
      let qtrStr = "select a.*, k.* from coverage_ra a, outer skills_ra k "
   when "LO"
      let qtrStr = "select a.*, k.* from coverage_lo a, outer skills_lo k "
   otherwise
      let qtrStr = "select a.*, k.* from coverage a, outer skills k "
end case

let wStr = wStr clipped, " and a.reseller !='N' and a.reseller != 'X' and a.part_type != 'D' "

## place results into temp table for changing sort name
   let qtrStr = qtrStr clipped, " ", wStr clipped, " order by a.part_name"

   prepare QID from qtrStr

   declare ACurs cursor for QID

display "</td>"
display "<td style='text-align: left; width: 367px'>"
display "<div>"


foreach ACurs into ARec.*, KRec.*
{
   if (ARec.skill_01=3 or 
       ARec.skill_02=3 or 
       ARec.skill_03=3 or 
       ARec.skill_04=3 or 
       ARec.skill_05=3 or 
       ARec.skill_06=3 or 
       ARec.skill_07=3 or 
       ARec.skill_08=3 or 
       ARec.skill_09=3 or 
       ARec.skill_10=3 or 
       ARec.skill_11=3 or 
       ARec.skill_12=3 or
       ARec.skill_13=3 or
       ARec.skill_14=3 or
       ARec.skill_15=3 or
       ARec.skill_16=3 or
       ARec.skill_17=3 or
       ARec.skill_18=3 or
       ARec.skill_19=3 or
       ARec.skill_20=3 or
       ARec.skill_21=3 or
       ARec.skill_22=3 or
       ARec.skill_23=3 or
       ARec.skill_24=3 or
       ARec.skill_25=3 or
       ARec.skill_26=3 or
       ARec.skill_27=3 or
       ARec.skill_28=3 or
       ARec.skill_29=3 or
       ARec.skill_30=3 ) then
      display "*"
   end if
}
{
   let skillStr=null
   if (KRec.skill_01=3 )then
         let skillStr = AddText( skillStr, SkillArr[1].s_name)
   end if
   if (KRec.skill_02=3 )then
         let skillStr = AddText( skillStr, SkillArr[2].s_name)
   end if
   if (KRec.skill_03=3 )then
         let skillStr = AddText( skillStr, SkillArr[3].s_name)
   end if
   if (KRec.skill_04=3 )then
         let skillStr = AddText( skillStr, SkillArr[4].s_name)
   end if
   if (KRec.skill_05=3 )then
         let skillStr = AddText( skillStr, SkillArr[5].s_name)
   end if
   if (KRec.skill_06=3 )then
         let skillStr = AddText( skillStr, SkillArr[6].s_name)
   end if
   if (KRec.skill_07=3 )then
         let skillStr = AddText( skillStr, SkillArr[7].s_name)
   end if
   if (KRec.skill_08=3 )then
         let skillStr = AddText( skillStr, SkillArr[8].s_name)
   end if
   if (KRec.skill_09=3 )then
         let skillStr = AddText( skillStr, SkillArr[9].s_name)
   end if
   if (KRec.skill_10=3 )then
         let skillStr = AddText( skillStr, SkillArr[10].s_name)
   end if
   if (KRec.skill_11=3 )then
         let skillStr = AddText( skillStr, SkillArr[11].s_name)
   end if
   if (KRec.skill_12=3 )then
         let skillStr = AddText( skillStr, SkillArr[12].s_name)
   end if
   if (KRec.skill_13=3 )then
         let skillStr = AddText( skillStr, SkillArr[13].s_name)
   end if
   if (KRec.skill_14=3 )then
         let skillStr = AddText( skillStr, SkillArr[14].s_name)
   end if
   if (KRec.skill_15=3 )then
         let skillStr = AddText( skillStr, SkillArr[15].s_name)
   end if
   if (KRec.skill_16=3 )then
         let skillStr = AddText( skillStr, SkillArr[16].s_name)
   end if
   if (KRec.skill_17=3 )then
         let skillStr = AddText( skillStr, SkillArr[17].s_name)
   end if
   if (KRec.skill_18=3 )then
         let skillStr = AddText( skillStr, SkillArr[18].s_name)
   end if
   if (KRec.skill_19=3 )then
         let skillStr = AddText( skillStr, SkillArr[19].s_name)
   end if
   if (KRec.skill_20=3 )then
         let skillStr = AddText( skillStr, SkillArr[20].s_name)
   end if
   if (KRec.skill_21=3 )then
         let skillStr = AddText( skillStr, SkillArr[21].s_name)
   end if
   if (KRec.skill_22=3 )then
         let skillStr = AddText( skillStr, SkillArr[22].s_name)
   end if
   if (KRec.skill_23=3 )then
         let skillStr = AddText( skillStr, SkillArr[23].s_name)
   end if
   if (KRec.skill_24=3 )then
         let skillStr = AddText( skillStr, SkillArr[24].s_name)
   end if
   if (KRec.skill_25=3 )then
         let skillStr = AddText( skillStr, SkillArr[25].s_name)
   end if
   if (KRec.skill_26=3 )then
         let skillStr = AddText( skillStr, SkillArr[26].s_name)
   end if
   if (KRec.skill_27=3 )then
         let skillStr = AddText( skillStr, SkillArr[27].s_name)
   end if
   if (KRec.skill_28=3 )then
         let skillStr = AddText( skillStr, SkillArr[28].s_name)
   end if
   if (KRec.skill_29=3 )then
         let skillStr = AddText( skillStr, SkillArr[29].s_name)
   end if
   if (KRec.skill_30=3 )then
         let skillStr = AddText( skillStr, SkillArr[30].s_name)
   end if
}

   let skillStr = BuildSkillStr( 3 )
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
      display " <br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp (", skillStr clipped, ") </span><span class='1b-half'></span>"
   end if

   display "<br/>"
end foreach

display "</td></tr>"

end function

function IsEmpty( inStr )
   define
      inStr char(10),
      ret smallint


   if( inStr is NULL or inStr = " " or inStr ="" )then
      return true
   else
      return false
   end if

    
end function

function ShowReps( RepMax )
define
   RepMax smallint,
   i smallint

      for i = 1 to RepMax
         display RepArr2[i].b_brand clipped, " Brand Rep<br /><a href='", RepArr2[i].ssr_link clipped, "' target='_blank'>",RepArr2[i].ssr clipped, "</a><p>"
         display RepArr2[i].b_brand clipped, " TSS Rep<br /><a href='", RepArr2[i].ctp_link clipped, "' target='_blank'>",RepArr2[i].ctp clipped, "</a>"
         display "<hr>"
      end for
end function  #ShowReps
