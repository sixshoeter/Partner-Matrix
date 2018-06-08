# partners for VADs
## January   17, 2017 John M. Shoemaker, created from export11U.4gl, #194

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   tRec record like tbptv.*,
   SQLStr char(1048),
   inVadStr char(16),
   VadStr char(64),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   brand char(2),
   tssr, ttss like reps.r_name,
   i,j,si smallint,
   last_part_name like coverage_au.part_name,
   CTPArr array[10] of char(2),
   trag like tbptv.rag,
   trev like tbptv.nlrev_01,
   CTP1, CTP2, CTP3, CTP4, CTP5 char(10)

call ReadCmdLn( "export11", 4)
call ProcCmdLn( "export11" )
let inVadStr = arg_val(4)
if( inVadStr is not NULL )then
   let VadStr = "c.vad matches '", inVadStr clipped, "*'"
else
   let VadStr = ""
end if
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

if( VadStr is not NULL )then
   let SQLStr = "select unique c.* from ", cov_tab clipped, " c where c.reseller!='X' and ", VadStr clipped, " order by c.part_name"
else
   let SQLStr = "select unique c.* from ", cov_tab clipped, " c where c.reseller!='X' order by c.part_name"
end if

display '"', SQLStr, '"'
prepare SQID from SQLStr
declare SQCurs cursor for SQID

let i = 0
let last_part_name =  " "


   let CTP1 = "TSS"
   let CTP2 = "Other TSS"
   let CTP3 = "Other TSS"
   let CTP4 = "Other TSS"
   let CTP5 = "ACA"

   display 
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
           '"Reseller Type"', DELIMIT,
           '"State"', DELIMIT,
           '"VAD"', DELIMIT,
	   '"BPR"', DELIMIT,
	   '"', CTP1 clipped, '"', DELIMIT,
	   '"', CTP2 clipped, '"', DELIMIT,
	   '"', CTP3 clipped, '"', DELIMIT,
	   '"', CTP4 clipped, '"', DELIMIT,
	   '"', CTP5 clipped, '"', DELIMIT,
	   '"URL"', DELIMIT,
	   '"Profile URL"', DELIMIT,
	   '"Description"', DELIMIT,
	   '"Contact Name"', DELIMIT,
	   '"Contact Title"', DELIMIT,
	   '"Contact Phone"', DELIMIT,
	   '"Contact Email"', DELIMIT,
	   '"Focus 1"', DELIMIT,
	   '"Focus 2"', DELIMIT,
	   '"Focus 3"', DELIMIT,
           '"Pacific NW"', DELIMIT,
           '"Northern California"', DELIMIT,
           '"SouthWest/Rockies"', DELIMIT,
           '"Northern Stars"', DELIMIT,
           '"Plains"', DELIMIT,
           '"Heartland"', DELIMIT,
           '"Texas/NM/Gulf"', DELIMIT,
           '"Garden State"', DELIMIT,
           '"Northeast"', DELIMIT,
	   '"NY Metro"', DELIMIT,
	   '"Delaware Valley"', DELIMIT,
           '"Potomac Valley"', DELIMIT,
           '"Carolinas"', DELIMIT,
           '"Mid-America"', DELIMIT,
           '"Ohio Valley"', DELIMIT,
           '"Southeast"', DELIMIT,
           '"Sunshine Belt"', DELIMIT,
           '"Federal"', DELIMIT,
           '"Canada"', DELIMIT,
           '"Comm: Energy & Utility"', DELIMIT,
           '"Comm: Media & Entertainment"', DELIMIT,
           '"Comm: Telecommunications"', DELIMIT,
           '"Comm: CSI"', DELIMIT,
           '"Dist: Consumer Product"', DELIMIT,
           '"Dist: Retail"', DELIMIT,
           '"Dist: Travel & Trans"', DELIMIT,
           '"Fin: Banks"', DELIMIT,
           '"Fin: Financial Markets"', DELIMIT,
           '"Fin: Insurance"', DELIMIT,
           '"Ind: Aerospace & Defense"', DELIMIT,
           '"Ind: Automotive"', DELIMIT,
           '"Ind: Chemical & Petroleum"', DELIMIT,
           '"Ind: Electronics"', DELIMIT,
           '"Ind: Industrial Products"', DELIMIT,
           '"Public: Governmanet"', DELIMIT,
           '"Public: Education"', DELIMIT,
           '"Public: Health"', DELIMIT,
           '"Public: Life Sciences"', DELIMIT,
	   '"Last Updated"', DELIMIT
    
   
foreach SQCurs into URec.*  
      let last_part_name = URec.part_name
      let i = i + 1
   display 
           '"', URec.ceid clipped, '"', DELIMIT,
           '"', URec.part_name clipped, '"', DELIMIT,
           '"', URec.reseller clipped, '"', DELIMIT,
           '"', URec.hq clipped, '"', DELIMIT,
           '"', URec.vad clipped, '"', DELIMIT,
           '"', URec.ssr clipped, '"', DELIMIT,
           '"', URec.ctp1 clipped, '"', DELIMIT,
           '"', URec.ctp2 clipped, '"', DELIMIT,
           '"', URec.ctp3 clipped, '"', DELIMIT,
           '"', URec.ctp4 clipped, '"', DELIMIT,
           '"', URec.ctp5 clipped, '"', DELIMIT,
           '"', URec.url clipped, '"', DELIMIT,
           '"', URec.pwp clipped, '"', DELIMIT,
           '"', URec.desc clipped, '"', DELIMIT,
           '"', URec.p_name clipped, '"', DELIMIT,
           '"', URec.p_title clipped, '"', DELIMIT,
           '"', URec.p_phone clipped, '"', DELIMIT,
           '"', URec.p_email clipped, '"', DELIMIT,
           '"', URec.focus1 clipped, '"', DELIMIT,
           '"', URec.focus2 clipped, '"', DELIMIT,
           '"', URec.focus3 clipped, '"', DELIMIT,
           '"', URec.eu_pacificnw clipped, '"', DELIMIT,
           '"', URec.eu_northca clipped, '"', DELIMIT,
           '"', URec.eu_southwest clipped, '"', DELIMIT,
           '"', URec.eu_northern clipped, '"', DELIMIT,
           '"', URec.eu_plains clipped, '"', DELIMIT,
           '"', URec.eu_heartland clipped, '"', DELIMIT,
           '"', URec.eu_texas clipped, '"', DELIMIT,
           '"', URec.eu_garden clipped, '"', DELIMIT,
           '"', URec.eu_northeast clipped, '"', DELIMIT,
	   '"', URec.eu_ny clipped, '"', DELIMIT,
	   '"', URec.eu_delaware clipped, '"', DELIMIT,
           '"', URec.eu_potomac clipped, '"', DELIMIT,
           '"', URec.eu_carolinas clipped, '"', DELIMIT,
           '"', URec.eu_midamerica clipped, '"', DELIMIT,
           '"', URec.eu_ohio clipped, '"', DELIMIT,
           '"', URec.eu_southeast clipped, '"', DELIMIT,
           '"', URec.eu_sunshine clipped, '"', DELIMIT,
           '"', URec.eu_fed clipped, '"', DELIMIT,
           '"', URec.eu_ca clipped, '"', DELIMIT,

           '"', URec.ind_eu clipped, '"', DELIMIT,
           '"', URec.ind_me clipped, '"', DELIMIT,
           '"', URec.ind_tel clipped, '"', DELIMIT,
           '"', URec.ind_csi clipped, '"', DELIMIT,

           '"', URec.ind_consume clipped, '"', DELIMIT,
           '"', URec.ind_ret clipped, '"', DELIMIT,
           '"', URec.ind_trans clipped, '"', DELIMIT,

           '"', URec.ind_bank clipped, '"', DELIMIT,
           '"', URec.ind_finan clipped, '"', DELIMIT,
           '"', URec.ind_ins clipped, '"', DELIMIT,

           '"', URec.ind_defense clipped, '"', DELIMIT,
           '"', URec.ind_auto clipped, '"', DELIMIT,
           '"', URec.ind_chem clipped, '"', DELIMIT,
           '"', URec.ind_elect clipped, '"', DELIMIT,
           '"', URec.ind_indprod clipped, '"', DELIMIT,

           '"', URec.ind_gov clipped, '"', DELIMIT,
           '"', URec.ind_education clipped, '"', DELIMIT,
           '"', URec.ind_hl clipped, '"', DELIMIT,
           '"', URec.ind_lifesci clipped, '"', DELIMIT,

           '"', URec.updtime clipped, '"', DELIMIT
 
end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

