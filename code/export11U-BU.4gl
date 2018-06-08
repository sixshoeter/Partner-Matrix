# authorized partners

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   tRec record like tbptv.*,
   SQLStr char(2048),
   AdhocStr char(128),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   brand char(2),
   tssr, ttss like reps.r_name,
   i,j,si smallint,
   last_part_name like coverage_bu.part_name,
   DataRec record
      part_name like coverage_bu.part_name,
      ceid like coverage_bu.ceid,
      ssr like coverage_bu.ssr,
      tss like coverage_bu.ctp1,
      rag like tbptv.rag,
      nlrev_01 like tbptv.nlrev_01
   end record,
   DataArr array[900] of record
      part_name like coverage_bu.part_name,
      ceid like coverage_bu.ceid,
      ssr like coverage_bu.ssr,
      tss like coverage_bu.ctp1,
      rag1 char(1),
      rag2 char(1),
      rag3 char(1),
      rag4 char(1),
      nlrev_01 like tbptv.nlrev_01
   end record,
   SVPArr array[20] of char(50),
   svpStr char(256)

call ReadCmdLn( "export11", 4)
call ProcCmdLn( "export11" )
#let AdhocStr = arg_val(5)
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

#let SQLStr = "select unique a.part_name, a.ceid, c.ssr, c.ctp, a.rag, a.nlrev_01 from tbptv a, svp b, outer ", cov_tab clipped, " c, svp d where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and a.rag = d.bptv_name order by a.part_name"
let SQLStr = "select unique a.part_name, a.ceid, c.ssr, c.ctp1, a.rag, a.nlrev_01 from tbptv a, svp b, outer ", cov_tab clipped, " c where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and c.reseller!='N' order by a.part_name"

#display SQLStr
prepare SQID from SQLStr
declare SQCurs cursor for SQID

for i = 1 to 900
   initialize DataArr[i].* to null 
   let DataArr[i].nlrev_01 = 0
end for
let i = 0
let last_part_name =  " "

for si = 1 to 20
   initialize SVPArr[si] to NULL
end for

case BRec.b_id 
   when 'BU'
      let SVPArr[1] = 'Customer Engagement'
      let SVPArr[2] = 'Digital Experience' 
      let SVPArr[3] = 'Partner Engagement'
end case

foreach SQCurs into DataRec.*
   if( DataRec.part_name != last_part_name )then
      let last_part_name = DataRec.part_name
      let i = i + 1
      let DataArr[i].part_name = DataRec.part_name
      let DataArr[i].ceid = DataRec.ceid
      let DataArr[i].ssr = DataRec.ssr
      let DataArr[i].tss = DataRec.tss
   end if

case BRec.b_id 
   when 'BU'
#display DataRec.rag
   if( DataRec.rag = 'Customer Engagement Solutions' )then
      let DataArr[i].rag1 = 'X'
      let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
#      display "Core"
   else
      if( DataRec.rag = 'Digital Experience' )then
         let DataArr[i].rag2 = 'X'
         let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
#      display "BPM"
      else
         if( DataRec.rag = 'Partner & Supplier Engagement Solutions' )then
            let DataArr[i].rag3 = 'X'
            let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
#      display "EIS"
         end if
      end if
   end if 

end case
end foreach

#display i
## header
           let si = 1
           let svpStr = ""
           while SVPArr[si] is not null 
	      let svpStr = svpStr clipped, '"', SVPArr[si] clipped, '"', DELIMIT
#display si, svpStr
              let si = si + 1
           end while

   display 
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
	   '"BPR"', DELIMIT,
	   '"TSS"', DELIMIT,
           svpStr clipped,
           '"Revenue"', DELIMIT
 

for j = 1 to i
   display 
           '"', DataArr[j].ceid clipped, '"', DELIMIT,
           '"', DataArr[j].part_name clipped, '"', DELIMIT,
           '"', DataArr[j].ssr clipped, '"', DELIMIT,
           '"', DataArr[j].tss clipped, '"', DELIMIT,
	   '"', DataArr[j].rag1 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag2 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag3 clipped, '"', DELIMIT,
	   '"', DataArr[j].nlrev_01 using "###,###,##&", '"', DELIMIT

end for


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

