
globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   tRec record like certs.*,
   SQLStr char(2048),
   AdhocStr char(128),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   brand char(2),
   tss char(20)

call ReadCmdLn( "export7", 4)
call ProcCmdLn( "export7" )
#let AdhocStr = arg_val(5)
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

let SQLStr = "select b.ctp, a.* from certs a, ", cov_tab clipped, " b where a.ceid = b.ceid and a.brand='", BRec.b_id clipped, "' and a.expire_dt is not null order by b.ctp, a.part_name, a.prod_group, a.expire_dt"

let SQLStr = SQLStr clipped
prepare SQID from SQLStr
declare SQCurs cursor for SQID

## header
   display 
           '"TSS"', DELIMIT,
           '"COUNTRY"', DELIMIT,
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
           '"Brand"', DELIMIT,
	   '"RAG"', DELIMIT,
	   '"Cert Number"', DELIMIT,
	   '"Certification"', DELIMIT,
	   '"Certification Type"', DELIMIT,
	   '"Expire Date"', DELIMIT

foreach SQCurs into tss, tRec.*
   display 
           '"', tss clipped, '"', DELIMIT,
           '"', tRec.country clipped, '"', DELIMIT,
           '"', tRec.ceid clipped, '"', DELIMIT,
           '"', tRec.part_name clipped, '"', DELIMIT,
           '"', tRec.brand clipped, '"', DELIMIT,
	   '"', tRec.prod_group clipped, '"', DELIMIT,
	   '"', tRec.cert_type_cd, '"', DELIMIT,
	   '"', tRec.cert_desc, '"', DELIMIT,
	   '"', tRec.cert_type, '"', DELIMIT,
	   tRec.expire_dt clipped, DELIMIT

end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer()

end main

