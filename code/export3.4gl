
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   SQLStr char(1024),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   BPTV_Cnt smallint,
   svp_str1, svp_str2, svp_str3, svp_str4, svp_str5 char(1),
   brand like brands.b_id

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id, 1)

let SQLStr = 
   "select 'WS' brand, a.*, k.* from coverage_ws a, skills_ws k where a.ceid = k.ceid and a.part_type != 'D' and a.reseller != 'N' and a.reseller != 'X' ",
   "union select 'IM' brand, a.*, k.* from coverage_im a, skills_im k where a.ceid = k.ceid and a.part_type != 'D' and a.reseller != 'N' and a.reseller != 'X' ",
   "union select 'TI' brand, a.*, k.* from coverage_ti a, skills_ti k where a.ceid = k.ceid and a.part_type != 'D' and a.reseller != 'N' and a.reseller != 'X' ",
   "union select 'RA' brand, a.*, k.* from coverage_ra a, skills_ra k where a.ceid = k.ceid and a.part_type != 'D' and a.reseller != 'N' and a.reseller != 'X' ",
   "order by 7, 1 " 

#"union select 'LO' brand, a.*, k.* from coverage_lo a, skills_lo k where a.ceid = k.ceid and a.part_type != 'D' and a.reseller != 'N'"

#let wStr = "where a.ceid = k.ceid and a.part_type != 'D' and a.reseller != 'N' order by a.part_name "
#let SQLStr = SQLStr clipped, " ", wStr clipped
#display SQLStr clipped
prepare SQID from SQLStr
declare SQCurs cursor for SQID

case BRec.b_id

   when 'IM'
      display "BRAND", DELIMIT,
           "CEID", DELIMIT,
           "PARTNER TYPE", DELIMIT,
           "RESELLER CODE", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "PARTNER CONTACT", DELIMIT,
           "PARTNER PHONE", DELIMIT,
           "PARTNER EMAIL", DELIMIT,
#	   "SVP DATA", DELIMIT,
#	   "SVP OPTIM/GUARDIUM", DELIMIT,
#           "SVP INFOSPHERE", DELIMIT,
#           "SVP BIG DATA/NZ", DELIMIT,
#           "SVP EIS", DELIMIT,
           "BP Brand Rep", DELIMIT,
           "TSS", DELIMIT,
           "Other Focus Area 1", DELIMIT,
           "Other Focus Area 2", DELIMIT,
           "Other Focus Area 3", DELIMIT,
           "PACIFIC NORTHWEST EU", DELIMIT,
           "NORTH CALIFORNIA EU", DELIMIT,
           "SOUTHWEST EU", DELIMIT,
           "ROCKIES EU", DELIMIT,
           "CHICAGO/WIS EU", DELIMIT,
           "MINN/NORTH DAKOTA EU", DELIMIT,
           "PLAINS EU", DELIMIT,
           "HEARTLAND EU", DELIMIT,
           "TEXAS/NM EU", DELIMIT,
           "GULF COAST EU", DELIMIT,
           "NY METRO EU", DELIMIT,
           "GARDEN STATE EU", DELIMIT,
           "NORTHEAST EU", DELIMIT,
           "DELAWARE VALLEY EU", DELIMIT,
           "POTOMAC VALLEY EU", DELIMIT,
           "CAROLINAS EU", DELIMIT,
           "MID-AMERICA EU", DELIMIT,
           "OHIO VALLEY EU", DELIMIT,
           "SOUTHEAST EU", DELIMIT,
           "SUNSHINE BELT EU", DELIMIT,
           "CANADA INDUSTRY EU", DELIMIT,
           "CANADA ENTERPRISE EU", DELIMIT,
           "CANADA MIDMARKET EU", DELIMIT,
           "FEDERAL CIVILION EU", DELIMIT,
           "FEDERAL DOD EU"

   when 'WS'
      display "BRAND", DELIMIT,
           "CEID", DELIMIT,
           "PARTNER TYPE", DELIMIT,
           "RESELLER CODE", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "PARTNER CONTACT", DELIMIT,
           "PARTNER PHONE", DELIMIT,
           "PARTNER EMAIL", DELIMIT,
#	   "SVP CORE", DELIMIT,
#	   "SVP BPM", DELIMIT,
#           "SVP DP", DELIMIT,
#           "SVP EIS", DELIMIT,
#           "(na)", DELIMIT,
           "BP Brand Rep", DELIMIT,
           "TSS", DELIMIT,
           "Other Focus Area 1", DELIMIT,
           "Other Focus Area 2", DELIMIT,
           "Other Focus Area 3", DELIMIT,
           "PACIFIC NORTHWEST EU", DELIMIT,
           "NORTH CALIFORNIA EU", DELIMIT,
           "SOUTHWEST EU", DELIMIT,
           "ROCKIES EU", DELIMIT,
           "CHICAGO/WIS EU", DELIMIT,
           "MINN/NORTH DAKOTA EU", DELIMIT,
           "PLAINS EU", DELIMIT,
           "HEARTLAND EU", DELIMIT,
           "TEXAS/NM EU", DELIMIT,
           "GULF COAST EU", DELIMIT,
           "NY METRO EU", DELIMIT,
           "GARDEN STATE EU", DELIMIT,
           "NORTHEAST EU", DELIMIT,
           "DELAWARE VALLEY EU", DELIMIT,
           "POTOMAC VALLEY EU", DELIMIT,
           "CAROLINAS EU", DELIMIT,
           "MID-AMERICA EU", DELIMIT,
           "OHIO VALLEY EU", DELIMIT,
           "SOUTHEAST EU", DELIMIT,
           "SUNSHINE BELT EU", DELIMIT,
           "CANADA INDUSTRY EU", DELIMIT,
           "CANADA ENTERPRISE EU", DELIMIT,
           "CANADA MIDMARKET EU", DELIMIT,
           "FEDERAL CIVILION EU", DELIMIT,
           "FEDERAL DOD EU"


   otherwise
      display "BRAND", DELIMIT,
           "CEID", DELIMIT,
           "PARTNER TYPE", DELIMIT,
           "RESELLER CODE", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "PARTNER CONTACT", DELIMIT,
           "PARTNER PHONE", DELIMIT,
           "PARTNER EMAIL", DELIMIT,
#	   "SVP DATA", DELIMIT,
#	   "SVP OPTIM/GUARDIUM", DELIMIT,
#           "SVP INFOSPHERE", DELIMIT,
#           "SVP BIG DATA/NZ", DELIMIT,
#           "SVP EIS", DELIMIT,
           "BP Brand Rep", DELIMIT,
           "TSS", DELIMIT,
           "Other Focus Area 1", DELIMIT,
           "Other Focus Area 2", DELIMIT,
           "Other Focus Area 3", DELIMIT,
           "PACIFIC NORTHWEST EU", DELIMIT,
           "NORTH CALIFORNIA EU", DELIMIT,
           "SOUTHWEST EU", DELIMIT,
           "ROCKIES EU", DELIMIT,
           "CHICAGO/WIS EU", DELIMIT,
           "MINN/NORTH DAKOTA EU", DELIMIT,
           "PLAINS EU", DELIMIT,
           "HEARTLAND EU", DELIMIT,
           "TEXAS/NM EU", DELIMIT,
           "GULF COAST EU", DELIMIT,
           "NY METRO EU", DELIMIT,
           "GARDEN STATE EU", DELIMIT,
           "NORTHEAST EU", DELIMIT,
           "DELAWARE VALLEY EU", DELIMIT,
           "POTOMAC VALLEY EU", DELIMIT,
           "CAROLINAS EU", DELIMIT,
           "MID-AMERICA EU", DELIMIT,
           "OHIO VALLEY EU", DELIMIT,
           "SOUTHEAST EU", DELIMIT,
           "SUNSHINE BELT EU", DELIMIT,
           "CANADA INDUSTRY EU", DELIMIT,
           "CANADA ENTERPRISE EU", DELIMIT,
           "CANADA MIDMARKET EU", DELIMIT,
           "FEDERAL CIVILION EU", DELIMIT,
           "FEDERAL DOD EU"

end case

foreach SQCurs into brand, ARec.*, KRec.*
{
   let BPTV_Cnt = GetBPTVParts( ARec.ceid )

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
}

   display brand clipped, DELIMIT,
           ARec.ceid clipped, DELIMIT,
           ARec.part_type clipped, DELIMIT,
           ARec.reseller clipped, DELIMIT,
           '"', ARec.part_name clipped, '"', DELIMIT,
           '"', ARec.p_name clipped, '"', DELIMIT,
           '"', ARec.p_phone clipped, '"', DELIMIT,
           '"', ARec.p_email clipped, '"', DELIMIT,
#           '"', svp_str1 clipped, '"', DELIMIT,
#           '"', svp_str2 clipped, '"', DELIMIT,
#           '"', svp_str3 clipped, '"', DELIMIT,
#           '"', svp_str4 clipped, '"', DELIMIT,
#           '"', svp_str5 clipped, '"', DELIMIT,
           '"', ARec.ssr clipped, '"', DELIMIT,
           '"', ARec.ctp clipped, '"', DELIMIT,
           '"', ARec.focus1 clipped, '"', DELIMIT,
           '"', ARec.focus2 clipped, '"', DELIMIT,
           '"', ARec.focus3 clipped, '"', DELIMIT,
           ARec.eu_pacificnw clipped, DELIMIT,
           ARec.eu_northca clipped, DELIMIT,
           ARec.eu_southwest clipped, DELIMIT,
           ARec.eu_rockies clipped, DELIMIT,
           ARec.eu_chicago clipped, DELIMIT,
           ARec.eu_minn clipped, DELIMIT,
           ARec.eu_plains clipped, DELIMIT,
           ARec.eu_heartland clipped, DELIMIT,
           ARec.eu_texas clipped, DELIMIT,
           ARec.eu_gulf clipped, DELIMIT,
           ARec.eu_ny clipped, DELIMIT,
           ARec.eu_garden clipped, DELIMIT,
           ARec.eu_northeast clipped, DELIMIT,
           ARec.eu_delaware clipped, DELIMIT,
           ARec.eu_potomac clipped, DELIMIT,
           ARec.eu_carolinas clipped, DELIMIT,
           ARec.eu_midamerica clipped, DELIMIT,
           ARec.eu_ohio clipped, DELIMIT,
           ARec.eu_southeast clipped, DELIMIT,
           ARec.eu_sunshine clipped, DELIMIT,
           ARec.eu_ca_industry clipped, DELIMIT,
           ARec.eu_ca_enterprise clipped, DELIMIT,
           ARec.eu_ca_midmarket clipped, DELIMIT,
           ARec.eu_fed_civ clipped, DELIMIT,
           ARec.eu_fed_dod clipped



end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

