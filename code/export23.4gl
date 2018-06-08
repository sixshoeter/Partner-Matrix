# partners for VADs
## November  06, 2017 John M. Shoemaker, created for Systems Unit, #288
## January   15, 2018 John M. Shoemaker, use control tables for activity tab names, #295

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   Tinit like act_initiative.bp_init1,
   Tstat like alu_status.alu_stat_desc,
   TRec record like activity.*,
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

call ReadCmdLn( "export23", 3)
call ProcCmdLn( "export23" )
#let inVadStr = arg_val(4)
#if( inVadStr is not NULL )then
#   let VadStr = "c.vad matches '", inVadStr clipped, "*'"
#else
#   let VadStr = ""
#end if
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

let SQLStr="select a.bp_init1, b.* from ", CtlRec.act_init_tab clipped, " a, ", CtlRec.act_tab clipped, " b where a.bp_init1=b.act_init ", " union ",
           "select a.bp_init2, b.* from ", CtlRec.act_init_tab clipped, " a, ", CtlRec.act_tab clipped, " b where a.bp_init2=b.act_init ", "union ",
           "select a.bp_init3, b.* from ", CtlRec.act_init_tab clipped, " a, ", CtlRec.act_tab clipped, " b where a.bp_init3=b.act_init ", "union ",
           "select a.st_init1, b.* from ", CtlRec.act_init_tab clipped, " a, ", CtlRec.act_tab clipped, " b where a.st_init1=b.act_init ", "union ",
           "select a.st_init2, b.* from ", CtlRec.act_init_tab clipped, " a, ", CtlRec.act_tab clipped, " b where a.st_init2=b.act_init ", "union ",
           "select a.st_init3, b.* from ", CtlRec.act_init_tab clipped, " a, ", CtlRec.act_tab clipped, " b where a.st_init3=b.act_init ",
           "into temp _acts"
#display '"', SQLStr, '"'
prepare TTID from SQLStr
execute TTID

let SQLStr = "select c.*, d.*, e.alu_stat_desc from ", cov_tab clipped, " c, _acts d, alu_status e ",
             "where c.ceid=d.ceid and c.reseller!='X' and d.act_stat=e.alu_stat ",
             "order by c.part_name"

#display '"', SQLStr, '"'
prepare SQID from SQLStr
declare SQCurs cursor for SQID
let i = 0
let last_part_name =  " "

   display 
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
           '"State"', DELIMIT,
           '"VAD"', DELIMIT,
	   '"BPR"', DELIMIT,
	   '"BP Initiative"', DELIMIT,
	   '"Activity Name"', DELIMIT,
	   '"Activity Description"', DELIMIT,
	   '"Activity Status"', DELIMIT,
	   '"Revenue ($K)"', DELIMIT,
	   '"Start Date"', DELIMIT,
	   '"End Date"', DELIMIT,
	   '"IBM Owner"', DELIMIT,
	   '"Partner Owner"', DELIMIT
    
   
foreach SQCurs into URec.*, Tinit, TRec.*, Tstat
      let i = i + 1
   display 
           '"', URec.ceid clipped, '"', DELIMIT,
           '"', URec.part_name clipped, '"', DELIMIT,
           '"', URec.hq clipped, '"', DELIMIT,
           '"', URec.vad clipped, '"', DELIMIT,
           '"', URec.ssr clipped, '"', DELIMIT,
           '"', Tinit clipped, '"', DELIMIT,
           '"', TRec.act_name clipped, '"', DELIMIT,
           '"', TRec.act_desc clipped, '"', DELIMIT,
           '"', Tstat clipped, '"', DELIMIT,
                TRec.act_rev, DELIMIT,
           '"', TRec.act_st_dt clipped, '"', DELIMIT,
           '"', TRec.act_ed_dt clipped, '"', DELIMIT,
           '"', TRec.act_own_ibm clipped, '"', DELIMIT,
           '"', TRec.act_own_bp clipped, '"', DELIMIT

end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

