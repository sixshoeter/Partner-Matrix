
##
## January 17, 2014 - modify based on new data source (operations)
##

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

let SQLStr = "select b.ctp, a.* from certs a, ", cov_tab clipped, " b where a.ceid = b.ceid and (a.sunset_dt is not null and a.sunset_dt < today+365 ) order by b.ctp, a.part_name, a.prod_group, a.sunset_dt"
#let SQLStr = "select b.ctp, a.* from certs a, ", cov_tab clipped, " b where a.ceid = b.ceid and a.brand='", BRec.b_id clipped, "' and a.sunset_dt is not null order by b.ctp, a.part_name, a.prod_group, a.sunset_dt"

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
   if(( tRec.brand='DATA' and BRec.b_id = 'IM' ) or
      ( tRec.brand='ECM' and BRec.b_id = 'EM' ) or
      ( tRec.brand='ICS' and BRec.b_id = 'LO' ) or
      ( tRec.brand='WS' and BRec.b_id = 'WS' )) then
      display 
           '"', tss clipped, '"', DELIMIT,
           '"', tRec.country clipped, '"', DELIMIT,
           '"', tRec.ceid clipped, '"', DELIMIT,
           '"', tRec.part_name clipped, '"', DELIMIT,
           '"', tRec.brand clipped, '"', DELIMIT,
	   '"', tRec.prod_group clipped, '"', DELIMIT,
	   '"', tRec.cert_num, '"', DELIMIT,
	   '"', tRec.cert_desc, '"', DELIMIT,
	   '"', tRec.cert_type, '"', DELIMIT,
	   tRec.sunset_dt clipped, DELIMIT
   end if

end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

