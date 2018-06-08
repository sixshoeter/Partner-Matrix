
globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   SQLStr char(512),
   wStr char(128),
   str char(20),
   DELIMIT char(1)

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

let DELIMIT="~"
#call Init()
#call Header(0, IRec.i_id, BRec.b_id, 1)

let SQLStr = BuildBaseStr( BRec.b_id, FALSE )

let wStr = "where a.ceid = k.ceid order by a.part_name"
let SQLStr = SQLStr clipped, " ", wStr clipped
prepare SQID from SQLStr
declare SQCurs cursor for SQID

   display "CEID", DELIMIT,
           "VAD", DELIMIT,
           "HQ", DELIMIT,
           "STATUS", DELIMIT,
           "RESELL CODE (R/H/E/N)", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "BPR", DELIMIT,
           "TSS", DELIMIT,
	   "SVP - CORE", DELIMIT,
	   "SVP - BPM", DELIMIT,
           "SVP - DP", DELIMIT,
           "SVP - EIS", DELIMIT,
           "SVP - SPARE", DELIMIT,
           "Pacific Northwest EU", DELIMIT,
           "North California EU", DELIMIT,
           "Southwest EU", DELIMIT,
           "Rockies EU", DELIMIT,
           "Chicago/Wis EU", DELIMIT,
           "Minn/North Dakota EU", DELIMIT,
           "Plains EU", DELIMIT,
           "Heartland EU", DELIMIT,
           "Texas/NM EU", DELIMIT,
           "Gulf Coast EU", DELIMIT,
	   "NY Metro EU", DELIMIT,
           "Garden State EU", DELIMIT,
           "Northeast EU", DELIMIT,
           "Delaware Valley EU", DELIMIT,
           "Potomac Valley EU", DELIMIT,
           "Carolinas EU", DELIMIT,
           "Mid-AMerica EU", DELIMIT,
           "Ohio Valley EU", DELIMIT,
           "Southeast EU", DELIMIT,
           "Sunshine Belt EU", DELIMIT,
           "Canada Industry EU", DELIMIT,
           "Canada Enterprise EU", DELIMIT,
           "Canada Midmarket EU", DELIMIT,
           "Federal Civilion EU", DELIMIT,
           "Federal DOD EU", DELIMIT,
           "Energy & Utility", DELIMIT,
           "Telecommunication", DELIMIT,
           "Media & Entertainment", DELIMIT,
           "Retail", DELIMIT,
           "Wholesale Distribution", DELIMIT,
           "Transportation", DELIMIT,
           "Banking and Financial Market", DELIMIT,
           "Insurance", DELIMIT,
           "Manufacturing", DELIMIT,
           "Healthcare & Lifescience", DELIMIT,
           "Govt", DELIMIT,
           "URL", DELIMIT,
           "PW Profile", DELIMIT,
           "Description", DELIMIT,
           "Contact Name", DELIMIT,
           "Phone", DELIMIT,
           "Email", DELIMIT,
           "Other Focus 1", DELIMIT,
           "Other Focus 2", DELIMIT,
           "Other Focus 3"


foreach SQCurs into ARec.*, KRec.*
   display ARec.ceid clipped, DELIMIT,
           ARec.vad clipped, DELIMIT,
           ARec.hq clipped, DELIMIT,
           ARec.part_type clipped, DELIMIT,
           ARec.reseller clipped, DELIMIT,
           '"', ARec.part_name clipped, '"', DELIMIT,
           '"', ARec.ssr clipped, '"', DELIMIT,
           '"', ARec.ctp clipped, '"', DELIMIT,
	   ARec.svp_01 clipped, DELIMIT,
	   ARec.svp_02 clipped, DELIMIT,
           ARec.svp_03 clipped, DELIMIT,
           ARec.svp_04 clipped, DELIMIT,
           ARec.svp_05 clipped, DELIMIT,
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
           ARec.eu_fed_dod clipped, DELIMIT,
           ARec.ind_eu clipped, DELIMIT,
           ARec.ind_tel clipped, DELIMIT,
           ARec.ind_me clipped, DELIMIT,
           ARec.ind_ret clipped, DELIMIT,
           ARec.ind_wd clipped, DELIMIT,
           ARec.ind_trans clipped, DELIMIT,
           ARec.ind_bank clipped, DELIMIT,
           ARec.ind_ins clipped, DELIMIT,
           ARec.ind_mfg clipped, DELIMIT,
           ARec.ind_hl clipped, DELIMIT,
           ARec.ind_gov clipped, DELIMIT,
           '"', ARec.url clipped, '"', DELIMIT,
           '"', ARec.pwp clipped, '"', DELIMIT,
           '"', ARec.desc clipped, '"', DELIMIT,
           '"', ARec.p_name clipped, '"', DELIMIT,
           '"', ARec.p_phone clipped, '"', DELIMIT,
           '"', ARec.p_email clipped, '"', DELIMIT,
           '"', ARec.focus1 clipped, '"', DELIMIT,
           '"', ARec.focus2 clipped, '"', DELIMIT,
           '"', ARec.focus3 clipped, '"'

end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

