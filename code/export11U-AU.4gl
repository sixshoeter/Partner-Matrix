# authorized partners
## February  17, 2016 John M. Shoemaker, filter out reseller X

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   tRec record like tbptv.*,
   SQLStr char(1048),
   AdhocStr char(128),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   brand char(2),
   tssr, ttss like reps.r_name,
   i,j,si smallint,
   last_part_name like coverage_au.part_name,
   CTPArr array[10] of char(2),
   trag like tbptv.rag,
   trev like tbptv.nlrev_01

call ReadCmdLn( "export11", 4)
call ProcCmdLn( "export11" )
#let AdhocStr = arg_val(5)
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

#let SQLStr = "select unique a.part_name, a.ceid, c.ssr, c.ctp, a.rag, a.nlrev_01 from tbptv a, svp b, outer ", cov_tab clipped, " c, svp d where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and a.rag = d.bptv_name order by a.part_name"
case BRec.b_id
   when 'AU'
#      let SQLStr = "select unique c.*, k.*, l.*, m.*, n.* from ", cov_tab clipped, " c, skills_im k, skills_em l, skills_ba m, skills_io n where c.ceid = k.ceid and c.ceid = l.ceid and c.ceid = m.ceid and c.ceid = n.ceid and c.reseller!='N' order by c.part_name"
      let SQLStr = "select unique c.* from ", cov_tab clipped, " c where c.reseller!='N' and c.reseller!='X' order by c.part_name"
   when 'SU'
      let SQLStr = "select unique a.rag, a.nlrev_01, c.*, k.*, l.*, m.*, n.* from tbptv a, svp b, ", cov_tab clipped, " c, skills_s1 k, skills_s2 l, skills_s3 m, skills_s4 n, skills_s5 o where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.ceid = o.ceid and c.reseller!='N' and c.reseller!='X' order by c.part_name"
   when 'CU'
   when 'BU'
      let SQLStr = "select unique a.rag, a.nlrev_01, c.*, k.*from tbptv a, svp b, ", cov_tab clipped, " c, skills_co k where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and a.ceid = k.ceid and c.reseller!='N' and c.reseller!='X' order by c.part_name"
   otherwise
   let SQLStr = "select c.*, l.* from ", cov_tab clipped, " c, skills_s2 l where c.ceid = l.ceid and c.reseller!='N' and c.reseller!='X' order by c.part_name"
end case

#let SQLStr = "select unique a.rag, a.nlrev_01, c.* from tbptv a, svp b, ", cov_tab clipped, " c where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and c.reseller!='N' order by c.part_name"

#display '"', SQLStr, '"'
prepare SQID from SQLStr
declare SQCurs cursor for SQID

let i = 0
let last_part_name =  " "



case BRec.b_id 
   when 'AU'
   display 
	   '"Tech Lead"', DELIMIT,
	   '"Tier"', DELIMIT,
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
           '"Partner Type"', DELIMIT,
           '"Reseller Type"', DELIMIT,
           '"State"', DELIMIT,
           '"VAD"', DELIMIT,
	   '"BPR"', DELIMIT,
	   '"IM TSS"', DELIMIT,
	   '"ECM TSS"', DELIMIT,
	   '"BA TSS"', DELIMIT,
	   '"IoT TSS"', DELIMIT,
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
           '"Energy"', DELIMIT,
           '"Telecommunications"', DELIMIT,
           '"Media"', DELIMIT,
           '"Retail"', DELIMIT,
           '"Whlsle/Dist"', DELIMIT,
           '"Transportation"', DELIMIT,
           '"Banking"', DELIMIT,
           '"Insurance"', DELIMIT,
           '"Mfg"', DELIMIT,
           '"Healthcare"', DELIMIT,
           '"Government"', DELIMIT,
           '"Cross-Industry"', DELIMIT,
	   '"Last Updated"', DELIMIT
#           '"Revenue"', DELIMIT
    
end case 

   
foreach SQCurs into URec.*  #, KRec.*, LRec.*, MRec.*, NRec.*
      let last_part_name = URec.part_name
      let i = i + 1
case BRec.b_id 
   when 'AU'
   display 
           '"', URec.lead clipped, '"', DELIMIT,
           '"', URec.tier clipped, '"', DELIMIT,
           '"', URec.ceid clipped, '"', DELIMIT,
           '"', URec.part_name clipped, '"', DELIMIT,
           '"', URec.part_type clipped, '"', DELIMIT,
           '"', URec.reseller clipped, '"', DELIMIT,
           '"', URec.hq clipped, '"', DELIMIT,
           '"', URec.vad clipped, '"', DELIMIT,
           '"', URec.ssr clipped, '"', DELIMIT,
           '"', URec.ctp1 clipped, '"', DELIMIT,
           '"', URec.ctp2 clipped, '"', DELIMIT,
           '"', URec.ctp3 clipped, '"', DELIMIT,
           '"', URec.ctp4 clipped, '"', DELIMIT,
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
           '"', URec.ind_tel clipped, '"', DELIMIT,
           '"', URec.ind_me clipped, '"', DELIMIT,
           '"', URec.ind_ret clipped, '"', DELIMIT,
           '"', URec.ind_wd clipped, '"', DELIMIT,
           '"', URec.ind_trans clipped, '"', DELIMIT,
           '"', URec.ind_bank clipped, '"', DELIMIT,
           '"', URec.ind_ins clipped, '"', DELIMIT,
           '"', URec.ind_mfg clipped, '"', DELIMIT,
           '"', URec.ind_hl clipped, '"', DELIMIT,
           '"', URec.ind_gov clipped, '"', DELIMIT,
           '"', URec.ind_cross clipped, '"', DELIMIT,
           '"', URec.updtime clipped, '"', DELIMIT
 
   end case
end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

