globals "globals.4gl"

define
   ORec record like skills_s5.*

main
define
   SQLStr char(256)

call ReadCmdLn("report", 4)
call ProcCmdLn("report")


let SQLStr = "select a.*, k.*, l.*, m.*, n.*, o.* from coverage_su a, skills_s1 k, skills_s2 l, skills_s3 m, skills_s4 n, skills_s5 o where a.ceid='", CLRec.CEID clipped, "' and a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid and a.ceid = o.ceid"
prepare R1ID from SQLStr
declare R1Curs cursor for R1ID

start report R1 

foreach R1Curs into URec.*, KRec.*, LRec.*, MRec.*, NRec.*, ORec.*
   output to report R1 (URec.*, KRec.*, LRec.*, MRec.*, NRec.*, ORec.* )
end foreach

finish report R1

end main

report R1( rptCoverage, Kskill, Lskill, Mskill, Nskill, Oskill )
   define
      rptCoverage record like coverage_su.*,
      Kskill, Lskill, Mskill, Nskill, Oskill record like skills_s1.*

   output 
      top margin 0
      bottom margin 0
      left margin 0
      page length 60

format
page header
   print "Partner Matrix Contents for: ", rptCoverage.part_name clipped, " (", rptCoverage.ceid clipped, ")"
   print "Page: ", pageno using "##", " as of: ", date, " for Systems Unit"
   print

before group of rptCoverage.ceid
   print "IBM Team Coverage: ", column 20, "  Channel Sales: ", rptCoverage.ssr clipped
   if( rptCoverage.ctp1 is not NULL )then
      print                        column 20, "Technical Sales: ", rptCoverage.ctp1 clipped
   end if
   print                        column 20, "Technical Sales: ", rptCoverage.ctp2 clipped
   print                        column 20, "Technical Sales: ", rptCoverage.ctp3 clipped
   print
   print "VAD: ", rptCoverage.vad, column 20, "URL: ", rptCoverage.url
   print "HQ in: ", rptCoverage.hq, column 20, "PW Profile: ", rptCoverage.pwp wordwrap right margin 80
   print column 10, "Sales Contact: ", rptCoverage.p_name
   print column 10, "        Title: ", rptCoverage.p_title
   print column 10, "        Phone: ", rptCoverage.p_phone
   print column 10, "        Email: ", rptCoverage.p_email
   print
   print rptCoverage.desc wordwrap right margin 80
   print
   print "Other Focus Areas: ", column 20, "1: ", rptCoverage.focus1 clipped
   print column 20, "2: ", rptCoverage.focus2 clipped
   print column 20, "3: ", rptCoverage.focus3 clipped
   if( rptCoverage.hunter )then
      print "This Partner is a HUNTER!"
   end if
   if( rptCoverage.commercial )then
      print "This Partner Sells in the Commercial Space!"
   end if
   if( rptCoverage.partners_well )then
      print "This Partner works well with other Partners!"
   end if
   print
   print "*** Selling into these Enterprise Units ***"
   print
   print "US WEST REGION"
   print "     Pacific Northwest: ", rptCoverage.eu_pacificnw
   print "      North California: ", rptCoverage.eu_northca
   print "    Southwest& Rockies: ", rptCoverage.eu_southwest
   print

   print "US MIDWEST REGION"
   print "        Northern Stars: ", rptCoverage.eu_northern
   print "                Plains: ", rptCoverage.eu_plains
   print "             Heartland: ", rptCoverage.eu_heartland
   print " Texas/New Mexico/Gulf: ", rptCoverage.eu_texas
   print

   print "US NORTH REGION"
   print "             Northeast: ", rptCoverage.eu_northeast
   print "          Garden State: ", rptCoverage.eu_garden
   print

   print "US MID-ATLANTIC REGION"
   print "       Delaware Valley: ", rptCoverage.eu_delaware
   print "        Potomac Valley: ", rptCoverage.eu_potomac
   print "             Carolinas: ", rptCoverage.eu_carolinas
   print

   print "US GREAT LAKES/SOUTH REGION"
   print "           Mid-America: ", rptCoverage.eu_midamerica
   print "           Ohio Valley: ", rptCoverage.eu_ohio
   print "             Southeast: ", rptCoverage.eu_southeast
   print "         Sunshine Belt: ", rptCoverage.eu_sunshine
   print

   need 4 lines
   print "US CANADA / FEDERAL REGIONS"
   print "                Canada: ", rptCoverage.eu_ca
   print "               Federal: ", rptCoverage.eu_fed

   skip 2 lines
   need 12 lines
   print "INDUSTRY FOCUS AREAS"
   print "          Energy & Utility: ", rptCoverage.ind_eu
   print "         Telecommunication: ", rptCoverage.ind_tel
   print "     Media & Entertainment: ", rptCoverage.ind_me
   print "                    Retail: ", rptCoverage.ind_ret
   print "    Wholesale Distribution: ", rptCoverage.ind_wd
   print "            Transportation: ", rptCoverage.ind_trans
   print "Banking & Financial Market: ", rptCoverage.ind_bank
   print "                 Insurance: ", rptCoverage.ind_ins
   print "             Manufacturing: ", rptCoverage.ind_mfg
   print "  Healthcare & Lifescience: ", rptCoverage.ind_hl
   print "                Government: ", rptCoverage.ind_gov
   print "               CROSS-BRAND: ", rptCoverage.ind_cross

need 10 lines
   print column 20, "------------------------------------------"
   print column 20, "APPLICATION PLATFORM PROVEN SKILLS"
   print column 20, "------------------------------------------"
print "*** RUN SOLUTIONS ***"
print column 5, KRec.skill_01 using "#", " : Application Server Family"
print column 5, KRec.skill_02 using "#", " : WAS on z"
print column 5, KRec.skill_03 using "#", " : eXtreme Scale"
print column 5, KRec.skill_04 using "#", " : Pure Application"
print column 5, KRec.skill_05 using "#", " : CICS VUE"
print column 5, KRec.skill_06 using "#", " : TX Series"

need 13 lines
print "*** BUILD SOLUTIONS/DEVOPS ***"
print column 5, KRec.skill_07 using "#", " : Collaborative Dev (Ratl Team Concert, Ratl Qualty Mgr, DOORS Next Gen)"
print column 5, KRec.skill_08 using "#", " : Analytics & Doc Gen (Ratl Pub Eng, Insight)"
print column 5, KRec.skill_09 using "#", " : Arch & Design (Ratl Design Mgr, Ratl SW Arch, Ratl Appl Dev)"
print column 5, KRec.skill_10 using "#", " : Continuous Testing (Ratl Test Workbench, Test Virtualization Srvr)"
print column 5, KRec.skill_11 using "#", " : Automated Testing (Ratl Functional Tester, Ratl Perf Tester)"
print column 5, KRec.skill_12 using "#", " : Change & Config Mgmt (ClearCase, ClearQuest)"
print column 5, KRec.skill_13 using "#", " : App Modernization (HATS, HIS, HACP, Asset Analyzer)"
print column 5, KRec.skill_14 using "#", " : Compiler Modernization (C, C++, COBOL, Fortran, PL/I)"
print column 5, KRec.skill_15 using "#", " : Dev Modernization (RDz, RDi, Ratl Business Dev, Ratl Dev for AIX/Linux)"
print column 5, KRec.skill_16 using "#", " : Host Test Modernization (Ratl Dev & Test, RSA, Ratl Test Virt Server, RTW)"
print column 5, KRec.skill_17 using "#", " : Build Mgmt (Build Forge)"
print column 5, KRec.skill_18 using "#", " : Asset Mgmt (RAM)"

need 4 lines
print "*** AUTOMATED DEPLOYMENT ***"
print column 5, KRec.skill_19 using "#", " : UrbanCode"

need 12 lines
   print column 20, "------------------------------------------"
   print column 20, "INTEGRATION PROVEN SKILLS"
   print column 20, "------------------------------------------"

print "*** CONNECTIVITY ***"
print column 5, LRec.skill_01 using "#", " : MQ Suite"
print column 5, LRec.skill_02 using "#", " : IIB"
print column 5, LRec.skill_03 using "#", " : WSRR"
print column 5, LRec.skill_04 using "#", " : APIM"
print column 5, LRec.skill_05 using "#", " : WESB"
print column 5, LRec.skill_06 using "#", " : MQ VUE"
print column 5, LRec.skill_07 using "#", " : CICS TG"
print column 5, LRec.skill_08 using "#", " : Comm Server"

need 2 lines
print "*** GATEWAY ***"
print column 5, LRec.skill_09 using "#", " : DataPower"

need 5 lines
print "*** CLOUD INTEGRATION ***"
print column 5, LRec.skill_10 using "#", " : Cast Iron"
print column 5, LRec.skill_11 using "#", " : APIM"
print column 5, LRec.skill_12 using "#", " : APIM for z"
print column 5, LRec.skill_13 using "#", " : Capstone"

need 13 lines
   print column 20, "------------------------------------------"
   print column 20, "SMARTER PROCESS PROVEN SKILLS"
   print column 20, "------------------------------------------"

print "*** PROCESS & DECISION IMPROVEMENT ***"
print column 5, MRec.skill_01 using "#", " : BPM"
print column 5, MRec.skill_02 using "#", " : BPM on Cld"
print column 5, MRec.skill_03 using "#", " : BPM on z"
print column 5, MRec.skill_04 using "#", " : ODM"
print column 5, MRec.skill_05 using "#", " : BR on z"
print column 5, MRec.skill_06 using "#", " : ODM for z"
print column 5, MRec.skill_07 using "#", " : B Monitor"
print column 5, MRec.skill_08 using "#", " : BWL"
print column 5, MRec.skill_09 using "#", " : ACM"

need 5 lines
   print column 20, "-------------------------------------------------"
   print column 20, "VIDEO SERVICES PROVEN SKILLS"
   print column 20, "-------------------------------------------------"
print column 5, NRec.skill_01 using "#", " : Aspera"
print column 5, NRec.skill_02 using "#", " : ClearLeap"

{
print "*** DIGITAL EXPERIENCE ***"
print column 5, NRec.skill_01 using "#", " : Portal Svr"
print column 5, NRec.skill_02 using "#", " : Portal on z"
print column 5, NRec.skill_03 using "#", " : WCM"
print column 5, NRec.skill_04 using "#", " : Forms"
print column 5, NRec.skill_05 using "#", " : CES"
print column 5, NRec.skill_06 using "#", " : EES"
print column 5, NRec.skill_07 using "#", " : DE on Cld"
}
need 11 lines
   print column 20, "-------------------------------------------------"
   print column 20, "IT SERVICE MANAGEMENT PROVEN SKILLS"
   print column 20, "-------------------------------------------------"

print "*** MANAGE SOLUTIONS ***"
print column 5, ORec.skill_01 using "#", " : Ops Mgmt (Netcool)"
print column 5, ORec.skill_02 using "#", " : Pfm Mgmt (ITM/APM)"
print column 5, ORec.skill_03 using "#", " : Automation (TWS)"
print column 5, ORec.skill_04 using "#", " : Analytics"
print column 5, ORec.skill_05 using "#", " : Host (ICO)"
print column 5, ORec.skill_06 using "#", " : PD Tools"
print column 5, ORec.skill_07 using "#", " : CICS Tool"


print "--------------------------------------------------------------------"
print column 20, "** 3-TOP Skilled Partner with multiple successes"
print column 20, "** 2-Skilled Partner"
print column 20, "** 1-Learning Partner"


#   call ShowSkillsR( "IM", 2 )

   

end report

function ShowSkillsR( inBrand, inbIdx )
define
   inBrand char(2),
   inbIdx smallint,
   skill_cat smallint,
   bText, vText char(64),
   i, sidx, col_cnt smallint

   let bText = GetBrandName( inBrand )
   let vText = bText clipped, " Detailed Skills"
   call LoadSkillsU( inBrand, inbIdx )


if( CtlRec.skill_cat )then
   let skill_cat = LoadSkillCat( inBrand )

   if( skill_cat > 0)then
      for i = 1 to skill_cat
         let col_cnt = GetCatCnt( inBrand, SkillCatArr[i].c_id )

#         output to report R1 ( URec.*, KRec.*
#         output to report R1 ( SkillCatArr[i].c_long clipped)


         for sidx = 1 to SkillsMax
            if( SkillArrU[inbIdx,sidx].s_name != "NA" and SkillArrU[inbIdx,sidx].c_id = i )then
#               display SkillArrU[inbIdx,sidx].s_desc clipped
            end if
         end for
      end for
   end if
end if


end function  #ShowSkillsR

