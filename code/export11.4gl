# authorized partners
## February  17, 2016 John M. Shoemaker, filter out reseller X

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
   last_part_name like coverage_su.part_name,
   DataRec record
      rag like tbptv.rag,
      nlrev_01 like tbptv.nlrev_01
   end record,
   UArr array[900] of record like coverage_su.*,
   DataArr array[900] of record
      rag1 char(1),
      rag2 char(1),
      rag3 char(1),
      rag4 char(1),
      rag5 char(1),
      rag6 char(1),
      rag7 char(1),
      rag8 char(1),
      rag9 char(1),
      rag10 char(1),
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
let SQLStr = "select unique a.rag, a.nlrev_01, c.* from tbptv a, svp b, outer ", cov_tab clipped, " c where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and a.reseller!='N' and a.reseller!='X' order by a.part_name"

#display SQLStr
prepare SQID from SQLStr
declare SQCurs cursor for SQID

for i = 1 to 900
   initialize UArr[i].* to null 
   initialize DataArr[i].* to null 
   let DataArr[i].nlrev_01 = 0
end for
let i = 0
let last_part_name =  " "

for si = 1 to 20
   initialize SVPArr[si] to NULL
end for

case BRec.b_id 
   when 'AU'
      let SVPArr[1] = 'DATA'
      let SVPArr[2] = 'InfoSphere' 
      let SVPArr[3] = 'Optim' 
      let SVPArr[4] = 'Big Data/Nz' 
      let SVPArr[5] = 'EIS' 
      let SVPArr[6] = 'ECM' 
      let SVPArr[7] = 'Cognos' 
      let SVPArr[8] = 'SPSS Enter' 
      let SVPArr[9] = 'SPSS Stats' 
      let SVPArr[10] = 'Risk' 
   when 'WS'
      let SVPArr[1] = 'AIM Core'
      let SVPArr[2] = 'AIM BPM' 
      let SVPArr[3] = 'EIS'
end case

foreach SQCurs into DataRec.*, URec.*
   if( URec.part_name != last_part_name )then
      let last_part_name = URec.part_name
      let i = i + 1
      let UArr[i].part_name = URec.part_name
      let UArr[i].ceid = URec.ceid
      let UArr[i].ssr = URec.ssr
      let UArr[i].tss = URec.ctp1
   end if

case BRec.b_id 
   when 'AU'

   if( DataRec.rag = 'Information Management Data Management' )then
      let DataArr[i].rag1 = 'X'
      let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
      let SVPArr[1] = 'Information Management Data Management'

   else
      if( DataRec.rag = 'IBM InfoSphere' )then
         let DataArr[i].rag2 = 'X'
         let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
         let SVPArr[2] = 'IBM InfoSphere'

      else
         if( DataRec.rag = 'IBM Optim' )then
            let DataArr[i].rag3 = 'X'
            let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
            let SVPArr[3] = 'IBM Optim'

         else
            if( DataRec.rag = 'IBM IBM Big Data & Netezza' )then
               let DataArr[i].rag4 = 'X'
               let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
               let SVPArr[4] = 'IBM IBM Big Data & Netezza'

            else
               if( DataRec.rag = 'IBM Expert Integrated Systems' )then
                  let DataArr[i].rag5 = 'X'
                  let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                  let SVPArr[5] = 'IBM Expert Integrated Systems'

               else
                  if( DataRec.rag = 'IBM FileNet' )then
                     let DataArr[i].rag6 = 'X'
                     let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                     let SVPArr[6] = 'IBM FileNet'
            
                  else
                     if( DataRec.rag = 'IBM Cognos' )then
                        let DataArr[i].rag7 = 'X'
                        let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                        let SVPArr[7] = 'IBM Cognos'
               
                     else
                        if( DataRec.rag = 'IBM SPSS Enterprise' )then
                           let DataArr[i].rag8 = 'X'
                           let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                           let SVPArr[8] = 'IBM SPSS Enterprise'
                     
                        else
                           if( DataRec.rag = 'IBM SPSS Statistics' )then
                              let DataArr[i].rag9 = 'X'
                              let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                              let SVPArr[9] =  'IBM SPSS Statistics'

                           else
                              if( DataRec.rag = 'Risk Analytics' )then
                                 let DataArr[i].rag10 = 'X'
                                 let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                                 let SVPArr[10] = 'Risk Analytics' 
                             end if
                          end if
                       end if
                    end if
                 end if
              end if
           end if
        end if
     end if
 end if  #AU:

   when 'WS'

#display DataRec.rag
   if( DataRec.rag = 'WebSphere Core' )then
      let DataArr[i].rag1 = 'X'
      let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
#      display "Core"
   else
      if( DataRec.rag = 'WebSphere Business Process Mgt' )then
         let DataArr[i].rag2 = 'X'
         let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
#      display "BPM"
      else
         if( DataRec.rag = 'Expert Integrated Systems' )then
            let DataArr[i].rag3 = 'X'
            let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
#      display "EIS"
         end if
      end if
    end if  #WS

when 'BA'
   if( DataRec.rag = 'IBM Cognos' )then
      let DataArr[i].rag1 = 'X'
      let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
      let SVPArr[1] = 'IBM Cognos'

   else
      if( DataRec.rag = 'IBM SPSS Enterprise' )then
         let DataArr[i].rag2 = 'X'
         let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
         let SVPArr[2] = 'IBM SPSS Enterprise'

      else
         if( DataRec.rag = 'IBM SPSS Statistics' )then
            let DataArr[i].rag3 = 'X'
            let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
            let SVPArr[3] =  'IBM SPSS Statistics'

         else
            if( DataRec.rag = 'Risk Analytics' )then
               let DataArr[i].rag4 = 'X'
               let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
               let SVPArr[4] = 'Risk Analytics' 
            end if
         end if
      end if
    end if  #BA
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

   case BRec.b_id 
      when 'AU'
         display 
                 '"CEID"', DELIMIT,
                 '"Partner Name"', DELIMIT,
	         '"BPR"', DELIMIT,
	         '"TSS"', DELIMIT,
                 svpStr clipped,
                 '"Revenue"', DELIMIT
      when 'SU'
         display 
                 '"CEID"', DELIMIT,
                 '"Partner Name"', DELIMIT,
	         '"BPR"', DELIMIT,
	         '"TSS"', DELIMIT,
                 '"VAD"', DELIMIT,
                 '"HQ"', DELIMIT,
                 '"CIO"', DELIMIT,
                 svpStr clipped,
                 '"Revenue"', DELIMIT
   end case
 

for j = 1 to i
   case BRec.b_id
   when 'AU'
      display 
           '"', UArr[j].ceid clipped, '"', DELIMIT,
           '"', UArr[j].part_name clipped, '"', DELIMIT,
           '"', UArr[j].ssr clipped, '"', DELIMIT,
           '"', UArr[j].ctp1 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag1 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag2 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag3 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag4 clipped, '"', DELIMIT,
	   '"', DataArr[j].nlrev_01 using "###,###,##&", '"', DELIMIT
   when 'SU'
      display 
           '"', UArr[j].ceid clipped, '"', DELIMIT,
           '"', UArr[j].part_name clipped, '"', DELIMIT,
           '"', UArr[j].ssr clipped, '"', DELIMIT,
           '"', UArr[j].ctp1 clipped, '"', DELIMIT,
           '"', UArr[j].vad clipped, '"', DELIMIT,
           '"', UArr[j].hq clipped, '"', DELIMIT,
	   '"', DataArr[j].rag1 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag2 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag3 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag4 clipped, '"', DELIMIT,
	   '"', DataArr[j].nlrev_01 using "###,###,##&", '"', DELIMIT

end for


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

