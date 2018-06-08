
## June 9, 2014 - John M. Shoemaker - add contact title
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   SQLStr char(512),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   BPTV_Cnt smallint,
   svp_str1, svp_str2, svp_str3, svp_str4, svp_str5, svp_str6, svp_str7, svp_str8, svp_str9, svp_str10 char(1),
   tReseller char(20)

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id, 1)

let SQLStr = BuildBaseStr( BRec.b_id, FALSE )

case BRec.b_id
   when 'AU'
      let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.reseller != 'N' and a.reseller != 'X' order by a.part_name "
   when 'SU'
      let wStr = "where a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.ceid = o.ceid and a.reseller != 'N' and a.reseller != 'X' order by a.part_name "
   otherwise
      let wStr = "where a.ceid = k.ceid and a.reseller != 'N' and a.reseller != 'X' order by a.part_name "
end case

let SQLStr = SQLStr clipped, " ", wStr clipped
#display SQLStr
prepare SQID from SQLStr
declare SQCurs cursor for SQID

case BRec.b_id

   when 'AU'
      display "CEID", DELIMIT,
           "PARTNER TYPE", DELIMIT,
           "RESELLER CODE", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "HQ", DELIMIT,
           "PARTNER CONTACT", DELIMIT,
           "PARTNER TITLE", DELIMIT,
           "PARTNER PHONE", DELIMIT,
           "PARTNER EMAIL", DELIMIT,
	   "SVP DATA", DELIMIT,
	   "SVP INFOSPHERE", DELIMIT,
           "SVP OPTIM", DELIMIT,
           "SVP BIG DATA/NZ", DELIMIT,
	   "SVP EIS", DELIMIT,
	   "SVP ECM", DELIMIT,
	   "SVP COGNOS", DELIMIT,
	   "SVP SPSS ENTERPRISE", DELIMIT,
	   "SVP SPSS STATISTICS", DELIMIT,
	   "SVP RISK", DELIMIT,
	   "BP Rep", DELIMIT,
           "IM TSS", DELIMIT,
           "ECM TSS", DELIMIT,
           "BA TSS", DELIMIT,
           "Other Focus Area 1", DELIMIT,
           "Other Focus Area 2", DELIMIT,
           "Other Focus Area 3", DELIMIT,
           "PACIFIC NORTHWEST/ROCKIES", DELIMIT,
           "NORTH CALIFORNIA", DELIMIT,
           "SOUTHWEST", DELIMIT,
           "NORTHERN STARS", DELIMIT,
           "PLAINS", DELIMIT,
           "HEARTLAND", DELIMIT,
           "TEXAS/NM/Gulf", DELIMIT,
           "GARDEN STATE", DELIMIT,
           "NORTHEAST", DELIMIT,
           "DELAWARE VALLEY", DELIMIT,
           "POTOMAC VALLEY", DELIMIT,
           "CAROLINAS", DELIMIT,
           "MID-AMERICA", DELIMIT,
           "OHIO VALLEY", DELIMIT,
           "SOUTHEAST", DELIMIT,
           "SUNSHINE BELT", DELIMIT,
           "CANADA ", DELIMIT,
           "FEDERAL ", DELIMIT,
           "Ind: Energy", DELIMIT,
           "Ind: Tele", DELIMIT,
           "Ind: Media", DELIMIT,
           "Ind: Retail", DELIMIT,
           "Ind: Warehouse", DELIMIT,
           "Ind: Transportation", DELIMIT,
           "Ind: Banking", DELIMIT,
           "Ind: Insurance", DELIMIT,
           "Ind: Manufacturing", DELIMIT,
           "Ind: Health", DELIMIT,
           "Ind: Goverment", DELIMIT,
           "Ind: Cross-Industry"

   when 'SU'
      display "CEID", DELIMIT,
           "PARTNER TYPE", DELIMIT,
           "RESELLER CODE", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "HQ", DELIMIT,
           "PARTNER CONTACT", DELIMIT,
           "PARTNER TITLE", DELIMIT,
           "PARTNER PHONE", DELIMIT,
           "PARTNER EMAIL", DELIMIT,
	   "SVP DATA", DELIMIT,
	   "SVP OPTIM/GUARDIUM", DELIMIT,
           "SVP INFOSPHERE", DELIMIT,
           "SVP BIG DATA/NZ", DELIMIT,
           "SVP EIS", DELIMIT,
           "BP Brand Rep", DELIMIT,
           "TSS", DELIMIT,
           "TSS", DELIMIT,
           "TSS", DELIMIT,
           "Other Focus Area 1", DELIMIT,
           "Other Focus Area 2", DELIMIT,
           "Other Focus Area 3", DELIMIT,
           "PACIFIC NORTHWEST", DELIMIT,
           "NORTH CALIFORNIA", DELIMIT,
           "SOUTHWEST", DELIMIT,
           "NORTHERN STARS", DELIMIT,
           "PLAINS", DELIMIT,
           "HEARTLAND", DELIMIT,
           "TEXAS/NM/Gulf", DELIMIT,
           "GARDEN STATE", DELIMIT,
           "NORTHEAST", DELIMIT,
           "DELAWARE VALLEY", DELIMIT,
           "POTOMAC VALLEY", DELIMIT,
           "CAROLINAS", DELIMIT,
           "MID-AMERICA", DELIMIT,
           "OHIO VALLEY", DELIMIT,
           "SOUTHEAST", DELIMIT,
           "SUNSHINE BELT", DELIMIT,
           "CANADA ", DELIMIT,
           "FEDERAL ", DELIMIT,
           "Ind: Energy", DELIMIT,
           "Ind: Tele", DELIMIT,
           "Ind: Media", DELIMIT,
           "Ind: Retail", DELIMIT,
           "Ind: Warehouse", DELIMIT,
           "Ind: Transportation", DELIMIT,
           "Ind: Banking", DELIMIT,
           "Ind: Insurance", DELIMIT,
           "Ind: Manufacturing", DELIMIT,
           "Ind: Health", DELIMIT,
           "Ind: Goverment", DELIMIT,
           "Ind: Cross-Industry"
end case

foreach SQCurs into URec.*, KRec.*
   let BPTV_Cnt = GetBPTVParts( URec.ceid )

      if ( SVPinBPTV(SVPArr[1].bptv_name ))then
         let svp_str1 = "Y"
      else
         let svp_str1 = " "
      end if
      if ( SVPinBPTV(SVPArr[2].bptv_name ))then
         let svp_str2 = "Y"
      else
         let svp_str2 = " "
      end if
      if ( SVPinBPTV(SVPArr[3].bptv_name ))then
         let svp_str3 = "Y"
      else
         let svp_str3 = " "
      end if
      if ( SVPinBPTV(SVPArr[4].bptv_name ))then
         let svp_str4 = "Y"
      else
         let svp_str4 = " "
      end if
      if ( SVPinBPTV(SVPArr[5].bptv_name ))then
         let svp_str5 = "Y"
      else
         let svp_str5 = " "
      end if
      if ( SVPinBPTV(SVPArr[6].bptv_name ))then
         let svp_str6 = "Y"
      else
         let svp_str6 = " "
      end if
      if ( SVPinBPTV(SVPArr[7].bptv_name ))then
         let svp_str7 = "Y"
      else
         let svp_str7 = " "
      end if
      if ( SVPinBPTV(SVPArr[8].bptv_name ))then
         let svp_str8 = "Y"
      else
         let svp_str8 = " "
      end if
      if ( SVPinBPTV(SVPArr[9].bptv_name ))then
         let svp_str9 = "Y"
      else
         let svp_str9 = " "
      end if
      if ( SVPinBPTV(SVPArr[10].bptv_name ))then
         let svp_str10 = "Y"
      else
         let svp_str10 = " "
      end if


   case URec.reseller 
      when 'R'
         let tReseller = "Reseller"
      when 'V'
         let tReseller = "VAD"
      when 'E'
         let tReseller = "Emerging"
      otherwise
         let tReseller = URec.reseller
   end case

#

   display URec.ceid clipped, DELIMIT,
           URec.part_type clipped, DELIMIT,
           '"', tReseller clipped, '"', DELIMIT,
           '"', URec.part_name clipped, '"', DELIMIT,
           '"', URec.hq clipped, '"', DELIMIT,
           '"', URec.p_name clipped, '"', DELIMIT,
           '"', URec.p_title clipped, '"', DELIMIT,
           '"', URec.p_phone clipped, '"', DELIMIT,
           '"', URec.p_email clipped, '"', DELIMIT,
           '"', svp_str1 clipped, '"', DELIMIT,
           '"', svp_str2 clipped, '"', DELIMIT,
           '"', svp_str3 clipped, '"', DELIMIT,
           '"', svp_str4 clipped, '"', DELIMIT,
           '"', svp_str5 clipped, '"', DELIMIT,
           '"', svp_str6 clipped, '"', DELIMIT,
           '"', svp_str7 clipped, '"', DELIMIT,
           '"', svp_str8 clipped, '"', DELIMIT,
           '"', svp_str9 clipped, '"', DELIMIT,
           '"', svp_str10 clipped, '"', DELIMIT,
           '"', URec.ssr clipped, '"', DELIMIT,
           '"', URec.ctp1 clipped, '"', DELIMIT,
           '"', URec.ctp2 clipped, '"', DELIMIT,
           '"', URec.ctp3 clipped, '"', DELIMIT,
           '"', URec.focus1 clipped, '"', DELIMIT,
           '"', URec.focus2 clipped, '"', DELIMIT,
           '"', URec.focus3 clipped, '"', DELIMIT,
           URec.eu_pacificnw clipped, DELIMIT,
           URec.eu_northca clipped, DELIMIT,
           URec.eu_southwest clipped, DELIMIT,
           URec.eu_northern clipped, DELIMIT,
           URec.eu_plains clipped, DELIMIT,
           URec.eu_heartland clipped, DELIMIT,
           URec.eu_texas clipped, DELIMIT,
           URec.eu_garden clipped, DELIMIT,
	   URec.eu_northeast clipped, DELIMIT,
	   URec.eu_delaware clipped, DELIMIT,
           URec.eu_potomac clipped, DELIMIT,
           URec.eu_carolinas clipped, DELIMIT,
           URec.eu_midamerica clipped, DELIMIT,
           URec.eu_ohio clipped, DELIMIT,
           URec.eu_southeast clipped, DELIMIT,
           URec.eu_sunshine clipped, DELIMIT,
           URec.eu_ca clipped, DELIMIT,
           URec.eu_fed clipped, DELIMIT,
           URec.ind_eu clipped, DELIMIT,
           URec.ind_tel clipped, DELIMIT,
           URec.ind_me clipped, DELIMIT,
           URec.ind_ret clipped, DELIMIT,
           URec.ind_wd clipped, DELIMIT,
           URec.ind_trans clipped, DELIMIT,
           URec.ind_bank clipped, DELIMIT,
           URec.ind_ins clipped, DELIMIT,
           URec.ind_mfg clipped, DELIMIT,
           URec.ind_hl clipped, DELIMIT,
           URec.ind_gov clipped,DELIMIT,
           URec.ind_cross clipped
{, DELIMIT,
           KRec.skill_12 using "&", DELIMIT,
           KRec.skill_08 using "&", DELIMIT,
           KRec.skill_10 using "&", DELIMIT,
           KRec.skill_02 using "&", DELIMIT,
           KRec.skill_01 using "&", DELIMIT,
           KRec.skill_06 using "&", DELIMIT,
           KRec.skill_07 using "&", DELIMIT,
           KRec.skill_13 using "&", DELIMIT,
           KRec.skill_14 using "&", DELIMIT,
           KRec.skill_09 using "&", DELIMIT,
           KRec.skill_03 using "&", DELIMIT,
           KRec.skill_04 using "&", DELIMIT,
           KRec.skill_05 using "&", DELIMIT,
           KRec.skill_15 using "&", DELIMIT,
           KRec.skill_16 using "&", DELIMIT,
           KRec.skill_11 using "&"
}


end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

