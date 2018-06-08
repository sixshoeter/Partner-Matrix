# authorized partners

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   S1Rec, S2Rec, S3Rec, S4Rec, S5Rec record like skills_s1.*,
   ORec record like skills_s5.*,
   tRec record like tbptv.*,
   SQLStr char(2048),
   AdhocStr char(128),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   brand char(2),
   tssr, ttss like reps.r_name,
   i,j,si smallint,
   last_part_name like coverage_au.part_name,
   DataRec record
      rag like tbptv.rag,
      nlrev_01 like tbptv.nlrev_01
   end record,
   UArr array[900] of record like coverage_au.*,
   LArr array[900] of record like skills_s2.*,
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
   svpStr char(256),
   tBrandRec record like brands.*,
   SkilledYN, tidx, sidx smallint,
   CTPArr array[10] of char(2)

call ReadCmdLn( "export11", 4)
call ProcCmdLn( "export11" )
#let AdhocStr = arg_val(5)
#call Header(0, IRec.i_id, BRec.b_id, 1)

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id)

#let SQLStr = "select unique a.part_name, a.ceid, c.ssr, c.ctp, a.rag, a.nlrev_01 from tbptv a, svp b, outer ", cov_tab clipped, " c, svp d where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and a.rag = d.bptv_name order by a.part_name"
if( BRec.b_id='AU') then
   let SQLStr = "select unique a.rag, a.nlrev_01, c.*, k.*, l.*, m.*, n.* from tbptv a, svp b, ", cov_tab clipped, " c, skills_im k, skills_em l, skills_ba m, skills_io n where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and c.reseller!='N' order by c.part_name"
else
   let SQLStr = "select c.*, l.* from ", cov_tab clipped, " c, skills_s2 l where c.ceid = l.ceid and c.reseller!='N' "

end if
#let SQLStr = "select unique a.rag, a.nlrev_01, c.* from tbptv a, svp b, ", cov_tab clipped, " c where a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and year(a.revdt)=year(current) and a.ceid = c.ceid and c.reseller!='N' order by c.part_name"

#display SQLStr
prepare SQID from SQLStr
declare SQCurs cursor for SQID

for i = 1 to 900
   initialize DataArr[i].* to null 
   initialize UArr[i].* to null 
   let DataArr[i].nlrev_01 = 0
end for
let i = 0
let last_part_name =  " "

for si = 1 to 20
   initialize SVPArr[si] to NULL
end for

{case BRec.b_id 
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
}
#if( BRec.b_id = 'AU' )then
#   foreach SQCurs into DataRec.*, URec.*, KRec.*, LRec.*, MRec.*, MRec.*, NRec.*, ORec.*

#else
   foreach SQCurs into URec.*, LRec.*
#end if
   if( URec.part_name != last_part_name )then
      let last_part_name = URec.part_name
      let i = i + 1
      let UArr[i].* = URec.*
      let LArr[i].* = LArr.*
   end if
{
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
            if( DataRec.rag = 'IBM Big Data & Netezza' )then
               let DataArr[i].rag4 = 'X'
               let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
               let SVPArr[4] = 'IBM Big Data & Netezza'

            else
               if( DataRec.rag = 'Expert Integrated Systems' )then
                  let DataArr[i].rag5 = 'X'
                  let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                  let SVPArr[5] = 'Expert Integrated Systems'

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

when 'SU'

#display DataRec.rag
   if( DataRec.rag = 'WebSphere Core' )then
      let DataArr[i].rag1 = 'X'
      let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
      let SVPArr[1] = 'WebSphere Core'
#      display "Core"
   else
      if( DataRec.rag = 'WebSphere Business Process Mgt' )then
         let DataArr[i].rag2 = 'X'
         let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
         let SVPArr[2] = 'WebSphere Business Process Mgt'
#      display "BPM"
      else
         if( DataRec.rag = 'Expert Integrated Systems' )then
            let DataArr[i].rag3 = 'X'
            let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
            let SVPArr[3] = 'Expert Integrated Systems'
#      display "EIS"
         else
            if( DataRec.rag = 'Tivoli Storage Management' )then
               let DataArr[i].rag4 = 'X'
               let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
               let SVPArr[4] = 'Tivoli Storage Management'
            else
               if( DataRec.rag = 'Tivoli Automation' )then
                  let DataArr[i].rag5 = 'X'
                  let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                  let SVPArr[5] = 'Tivoli Automation'
               else
                  if( DataRec.rag = 'Tivoli Enterprise Asset Management' )then
                     let DataArr[i].rag6 = 'X'
                     let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                     let SVPArr[6] = 'Tivoli Enterprise Asset Management'
                  else
                     if( DataRec.rag = 'Rational' )then
                        let DataArr[i].rag7 = 'X'
		        let DataArr[i].nlrev_01 = DataArr[i].nlrev_01 + DataRec.nlrev_01
                        let SVPArr[7] = 'Rational'
                     end if
                  end if
               end if
            end if
         end if
      end if
    end if  #WS

end case
}
end foreach

#display i
## header
#           let si = 1
#           let svpStr = ""
#           while SVPArr[si] is not null 
#	      let svpStr = svpStr clipped, '"', SVPArr[si] clipped, '"', DELIMIT
##display si, svpStr
#              let si = si + 1
#           end while

case BRec.b_id 
   when 'AU'
   display 
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
	   '"BPR"', DELIMIT,
	   '"IM TSS"', DELIMIT,
	   '"ECM TSS"', DELIMIT,
	   '"BA TSS"', DELIMIT,
           svpStr clipped,
           '"Revenue"', DELIMIT
   when 'SU'
   display 
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
	   '"BPR"', DELIMIT,
	   '"TSS"', DELIMIT,
	   '"TSS"', DELIMIT,
	   '"TSS"', DELIMIT,
	   '"VAD"', DELIMIT,
	   '"HQ"', DELIMIT,
#           svpStr clipped,
#           '"Revenue"', DELIMIT,
	   '"WEST-Pacific NW/Rockies"', DELIMIT,
	   '"WEST-No CA"', DELIMIT,
	   '"WEST-Southwest"', DELIMIT,
	   '"MIDWEST-Northern"', DELIMIT,
	   '"MIDWEST-Plains"', DELIMIT,
	   '"MIDWEST-Heartland"', DELIMIT,
	   '"MIDWEST-Texas/NM/Gulf"', DELIMIT,
	   '"North-Garden State"', DELIMIT,
	   '"North-Northeast"', DELIMIT,
	   '"North-NY Metro"', DELIMIT,
	   '"MID-ATLANTIC-Delaware Vly"', DELIMIT,
	   '"MID-ATLANTIC-Potomac Vly"', DELIMIT,
	   '"MID-ATLANTIC-Carolinas"', DELIMIT,
	   '"GREAT LAKES/SOUTH-Mid-America"', DELIMIT,
	   '"GREAT LAKES/SOUTH-Ohio Vly"', DELIMIT,
	   '"GREAT LAKES/SOUTH-Southeast"', DELIMIT,
	   '"GREAT LAKES/SOUTH-Sunshine Belt"', DELIMIT,
	   '"FEDERAL"', DELIMIT,
	   ',"CANADA"', DELIMIT,
	   ',"MQ Suite"', DELIMIT,
	   ',"IIB"', DELIMIT,
	   ',"WSRR"', DELIMIT,
	   ',"APIM"', DELIMIT,
	   ',"WESB"', DELIMIT,
	   ',"MQ VUE"', DELIMIT,
	   ',"CICS TG"', DELIMIT,
	   ',"Comm Server"', DELIMIT,
	   ',"DataPower"', DELIMIT,
	   ',"Cast Iron"', DELIMIT,
	   ',"APIM"', DELIMIT,
	   ',"APIM for z"', DELIMIT,
	   ',"CAPSTONE"', DELIMIT

{
let SQLStr="select a.*, b.ordctp from brands a, unit_brand b where a.b_id=b.b_id and b.u_id='", BRec.b_id clipped, "' order by a.b_ord"
prepare LSU2 from SQLStr
declare LSU2Curs cursor for LSU2

foreach LSU2Curs into tBrandRec.*, tidx
   let CTPArr[tidx] = tBrandRec.b_id
   let SkilledYN = LoadSkillRec( tBrandRec.b_id, URec.ceid )

         for sidx = 1 to SkillsMax
display "sidx: ", sidx, " tidx: ", tidx, " Rec:", SkillArrU[tidx,sIdx].*
            if( SkillArrU[tidx,sidx].s_name != "NA" and SkillArrU[tidx,sidx].c_id = i )then
               display "<th class='centerText'; style='background-color: #add8e6'>"
               display "<strong>", SkillArrU[tidx,sidx].s_desc clipped, "</strong></th>"
            end if
         end for

#display "SkilledYN :", SkilledYN
   if( SkilledYN )then
#      call ShowSkillsCurrentBrand2( 1, tBrandRec.b_id, tBrandRec.b_ord )
   end if
end foreach
}

    
end case 

for j = 1 to i
case BRec.b_id 
   when 'AU'
   display 
           '"', UArr[j].ceid clipped, '"', DELIMIT,
           '"', UArr[j].part_name clipped, '"', DELIMIT,
           '"', UArr[j].ssr clipped, '"', DELIMIT,
           '"', UArr[j].ctp1 clipped, '"', DELIMIT,
           '"', UArr[j].ctp2 clipped, '"', DELIMIT,
           '"', UArr[j].ctp3 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag1 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag2 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag3 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag4 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag5 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag6 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag7 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag8 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag9 clipped, '"', DELIMIT,
	   '"', DataArr[j].rag10 clipped, '"', DELIMIT,
	   '"', DataArr[j].nlrev_01 using "###,###,##&", '"', DELIMIT

   when 'SU'
   display 
           '"', UArr[j].ceid clipped, '"', DELIMIT,
           '"', UArr[j].part_name clipped, '"', DELIMIT,
           '"', UArr[j].ssr clipped, '"', DELIMIT,
           '"', UArr[j].ctp1 clipped, '"', DELIMIT,
           '"', UArr[j].ctp2 clipped, '"', DELIMIT,
           '"', UArr[j].ctp3 clipped, '"', DELIMIT,
           '"', UArr[j].vad clipped, '"', DELIMIT,
           '"', UArr[j].hq clipped, '"', DELIMIT,
#	   '"', DataArr[j].rag1 clipped, '"', DELIMIT,
#	   '"', DataArr[j].rag2 clipped, '"', DELIMIT,
#	   '"', DataArr[j].rag3 clipped, '"', DELIMIT,
#	   '"', DataArr[j].rag4 clipped, '"', DELIMIT,
#	   '"', DataArr[j].rag5 clipped, '"', DELIMIT,
#	   '"', DataArr[j].rag6 clipped, '"', DELIMIT,
#	   '"', DataArr[j].rag7 clipped, '"', DELIMIT,
#	   '"', DataArr[j].nlrev_01 using "###,###,##&", '"', DELIMIT,
           '"', UArr[j].eu_pacificnw clipped, '"', DELIMIT,
           '"', UArr[j].eu_northca clipped, '"', DELIMIT,
           '"', UArr[j].eu_southwest clipped, '"', DELIMIT,
           '"', UArr[j].eu_northern clipped, '"', DELIMIT,
           '"', UArr[j].eu_plains clipped, '"', DELIMIT,
           '"', UArr[j].eu_heartland clipped, '"', DELIMIT,
           '"', UArr[j].eu_texas clipped, '"', DELIMIT,
           '"', UArr[j].eu_garden clipped, '"', DELIMIT,
           '"', UArr[j].eu_northeast clipped, '"', DELIMIT,
           '"', UArr[j].eu_ny clipped, '"', DELIMIT,
           '"', UArr[j].eu_delaware clipped, '"', DELIMIT,
           '"', UArr[j].eu_potomac clipped, '"', DELIMIT,
           '"', UArr[j].eu_carolinas clipped, '"', DELIMIT,
           '"', UArr[j].eu_midamerica clipped, '"', DELIMIT,
           '"', UArr[j].eu_ohio clipped, '"', DELIMIT,
           '"', UArr[j].eu_southeast clipped, '"', DELIMIT,
           '"', UArr[j].eu_sunshine clipped, '"', DELIMIT,
           '"', UArr[j].eu_fed clipped, '"', DELIMIT,
           '"', UArr[j].eu_ca clipped, '"', DELIMIT,
           LArr[j].skill_01, DELIMIT,
           LArr[j].skill_02, DELIMIT,
           LArr[j].skill_03, DELIMIT,
           LArr[j].skill_04, DELIMIT,
           LArr[j].skill_05, DELIMIT,
           LArr[j].skill_06, DELIMIT,
           LArr[j].skill_07, DELIMIT,
           LArr[j].skill_08, DELIMIT,
           LArr[j].skill_09, DELIMIT,
           LArr[j].skill_10, DELIMIT,
           LArr[j].skill_11, DELIMIT,
	   LArr[j].skill_12, DELIMIT,
	   LArr[j].skill_13, DELIMIT
       
   end case
end for


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

