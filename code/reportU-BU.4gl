globals "globals.4gl"


main
define
   SQLStr char(256)

call ReadCmdLn("report", 4)
call ProcCmdLn("report")


let SQLStr = "select a.*, k.*, l.*, m.* from coverage_bu a, skills_b1 k, skills_b2 l, skills_b3 m, skills_b4 n where a.ceid='", CLRec.CEID clipped, "' and a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid = n.ceid "
prepare R1ID from SQLStr
declare R1Curs cursor for R1ID

start report R1 

foreach R1Curs into URec.*, KRec.*, LRec.*, MRec.*, NRec.*
   output to report R1 (URec.*, KRec.*, LRec.*, MRec.*, NRec.* )
end foreach

finish report R1

end main

report R1( rptCoverage, Kskill, Lskill, Mskill, Nskill )
   define
      rptCoverage record like coverage_bu.*,
      Kskill, Lskill, Mskill, Nskill record like skills_b1.*

   output 
      top margin 0
      bottom margin 0
      left margin 0
      page length 60

format
page header
print "Partner Matrix Contents for: ", rptCoverage.part_name clipped, " (", rptCoverage.ceid clipped, ")"
   print "Page: ", pageno using "##", " as of: ", date, " for Commerce"
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
   print
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

need 14 lines
   print column 35, "--------------------------"
   print column 35, "B2B INTEGRATION PROVEN SKILLS"
   print column 35, "--------------------------"
   print "*** B2B INTEGRATION ***"
   print column 5, KRec.skill_01 using "#", " : Sterling B2B Integration Services"
   print column 5, KRec.skill_18 using "#", " : Sterling B2B Collaboration Network"
   print column 5, KRec.skill_06 using "#", " : Sterling B2B Integrator"
   print column 5, KRec.skill_04 using "#", " : Sterling File Gateway"
   print column 5, KRec.skill_03 using "#", " : Multi-Enterprise Relationship Management"
   print column 5, KRec.skill_03 using "#", " : Transformation Extender"
   print column 5, KRec.skill_03 using "#", " : Transformation Extender Advanced"
   print column 5, KRec.skill_03 using "#", " : Sterling Secure Proxy"
   print column 5, KRec.skill_03 using "#", " : Partner Engagement Manager"
   print column 5, KRec.skill_03 using "#", " : Sterling Gentran"
need 4 lines
   print "*** MANAGED FILE TRANSFER ***"
   print column 5, KRec.skill_09 using "#", " : Control Center"
   print column 5, KRec.skill_10 using "#", " : Sterling File Transfer Service"
   print column 5, KRec.skill_10 using "#", " : Connect: Direct"

need 6 lines
   print "*** DATA MANAGEMENT ***"
   print column 5, KRec.skill_07 using "#", " : "
   print column 5, KRec.skill_08 using "#", " : "
   print column 5, KRec.skill_12 using "#", " : "
   print column 5, KRec.skill_05 using "#", " : "
   print column 5, KRec.skill_14 using "#", " : "

need 2 lines
   print "*** EXPERT INTEGRATED SYSTEMS ***"
   print column 5, KRec.skill_15 using "#", " : "
need 4 lines
   print "*** INFOSPHERE INFORMATION INTEGRATION ***"
   print column 5, KRec.skill_02 using "#", " : "
   print column 5, KRec.skill_13 using "#", " : "
   print column 5, KRec.skill_16 using "#", " : "
   need 4 lines
   print "*** OPTIM/GUARDIUM (DATA GOVERNANCE) ***"
   print column 5, KRec.skill_11 using "#", " : "
   print column 5, KRec.skill_19 using "#", " : "
   print column 5, KRec.skill_17 using "#", " : "

   skip 2 lines
need 8 lines
   print column 35, "--------------------------"
   print column 35, "PROCUREMENT & PAYMENTS PROVEN SKILLS"
   print column 35, "--------------------------"
   print "*** BUSINESS INTELLIGENCE ***", column 40, "*** PREDICTIVE ANALYTICS ***"
   print column 5, MRec.skill_01 using "#", " : Cognos Enterprise", column 40, MRec.skill_05 using "#", " : SPSS Data Collection"
 print column 5, MRec.skill_02 using "#", " : Cognos Express", column 40, MRec.skill_06 using "#", " : SPSS Statistics"
print column 5, MRec.skill_03 using "#", " : Cognos Insight", column 40, MRec.skill_07 using "#", " : SPSS Modeler"
print column 5, MRec.skill_04 using "#", " : Watson Analytics", column 40, MRec.skill_08 using "#", " : SPSS Modeler Gold"

need 7 lines
print"*** PERFORMANCE MANAGEMENT ***", column 50, "*** SOLUTIONS ***"
print column 5, MRec.skill_09 using "#", " : TM1", column 40, MRec.skill_17 using "#", " : Financial and Operational Perf Mgmt"
print column 5, MRec.skill_10 using "#", " : Cognos Disclosure Mgmt", column 40, MRec.skill_18 using "#", " : Narrative Reporting and Disclosure Mgmt"
print column 5, MRec.skill_12 using "#", " : Controller", column 40, MRec.skill_19 using "#", " : Sales Performance Mgmt"
print column 5, MRec.skill_12 using "#", " : Incentive Compensation Mgmt", column 40, MRec.skill_20 using "#", " : Predictive Customer Intelligence"
print column 5, MRec.skill_13 using "#", " : Territory Mgmt", column 40, MRec.skill_21 using "#", " : Predictive Maintenance and Quality"
print column 5, MRec.skill_14 using "#", " : Concert", column 40, MRec.skill_22 using "#", " : Capacity Mgmt Analytics"

need 6 lines
print "*** RISK ANALYTICS ***", column 40, MRec.skill_23 using "#", " : Forward looking Business Intelligence"
print column 5, MRec.skill_15 using "#", " : OpenPages", column 40, MRec.skill_24 using "#", " : Predictive Analytics Enterprise solutions"
print column 5, MRec.skill_16 using "#", " : Algorithmics", column 40, MRec.skill_25 using "#", " : Fin Risk Mgmt Bank and Markets"

print column 40, MRec.skill_26 using "#", " : Fin Risk Mgmt Insurers"
print column 40, MRec.skill_27 using "#", " : Risk Information Governance"
print column 40, MRec.skill_28 using "#", " : Governance, Risk and Compliance"

   skip 2 lines
   need 6 lines
   print column 35, "---------------------------"
   print column 35, "MARKETING CUSTOMER ANALYTICS PROVEN SKILLS"
   print column 35, "---------------------------"

print "*** CAPTURE ***"
print column 5, LRec.skill_01 using "#", " : Datacap"
print column 5, LRec.skill_02 using "#", " : Production Imaging Edition"
need 8 lines
print "*** CONTENT MANAGEMENT ***"
print column 5, LRec.skill_03 using "#", " : IBM Content Navigator"
print column 5, LRec.skill_04 using "#", " : FileNet Content Manager"
print column 5, LRec.skill_05 using "#", " : IBM Content Manager"
print column 5, LRec.skill_06 using "#", " : Content Manager OnDemand"
print column 5, LRec.skill_07 using "#", " : FileNet Image Services/Manager"
print column 5, LRec.skill_08 using "#", " : Social Content Mgmt"
print column 5, LRec.skill_20 using "#", " : Content Classification"
need 4 lines
print "*** CASE MANAGEMENT ***"
print column 5, LRec.skill_10 using "#", " : IBM Case Foundation"
print column 5, LRec.skill_09 using "#", " : IBM Case Manager"
print column 5, LRec.skill_11 using "#", " : IBM Case Manager for Investigation"
need 7 lines
print "*** INFORMATION LIFECYCLE GOVERNANCE ***"
print column 5, LRec.skill_12 using "#", " : Atlas"
print column 5, LRec.skill_13 using "#", " : StoredIQ"
print column 5, LRec.skill_14 using "#", " : IBM Content Collector"
print column 5, LRec.skill_15 using "#", " : IBM Content Collector for SAP"
print column 5, LRec.skill_16 using "#", " : eDiscovery"
print column 5, LRec.skill_17 using "#", " : IBM Enterprise Records"
need 4 lines
print "*** CLOUD ***"
print column 5, LRec.skill_19 using "#", " : Partner Cloud Solutions"
print column 5, LRec.skill_21 using "#", " : Watson Curator"

   skip 2 lines
   need 6 lines
   print column 35, "---------------------------"
   print column 35, "eCOMMERCE PROVEN SKILLS"
   print column 35, "---------------------------"



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

