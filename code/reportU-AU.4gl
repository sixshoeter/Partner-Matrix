globals "globals.4gl"

define
   AGRec record like skills_ag.*

main
define
   SQLStr char(256)

call ReadCmdLn("report", 4)
call ProcCmdLn("report")


let SQLStr = "select a.*, k.*, l.*, m.* from coverage_au a, skills_im k, skills_em l, skills_ba m, skills_ag ag where a.ceid='", CLRec.CEID clipped, "' and a.ceid = k.ceid and a.ceid = l.ceid and a.ceid = m.ceid and a.ceid=ag.ceid "
prepare R1ID from SQLStr
declare R1Curs cursor for R1ID

start report R1 

foreach R1Curs into URec.*, KRec.*, LRec.*, MRec.*, AGRec.*
   output to report R1 (URec.*, KRec.*, LRec.*, MRec.*, AGRec.* )
end foreach

finish report R1

end main

report R1( rptCoverage, Kskill, Lskill, Mskill, AGskill )
   define
      rptCoverage record like coverage_au.*,
      Kskill, Lskill, Mskill, AGskill record like skills_im.*

   output 
      top margin 0
      bottom margin 0
      left margin 0
      page length 60

format
page header
   print "Partner Matrix Contents for: ", rptCoverage.part_name clipped, " (", rptCoverage.ceid clipped, ")"
   print "Page: ", pageno using "##", " as of: ", date, " for Analytics Unit"
   print

before group of rptCoverage.ceid
   print "IBM Team Coverage: ", column 20, "  Channel Sales: ", rptCoverage.ssr clipped
   if( rptCoverage.ctp1 is not NULL )then
      print                        column 20, "Technical Sales: ", rptCoverage.ctp1 clipped
   end if
   print                        column 20, "Technical Sales: ", rptCoverage.ctp2 clipped
   print                        column 20, "Technical Sales: ", rptCoverage.ctp3 clipped
   print                        column 20, "Technical Sales: ", rptCoverage.ctp4 clipped
   print                        column 20, "Technical Sales: ", rptCoverage.ctp5 clipped
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
      print "This Partner has a Commercial Focus!"
   end if
   if( rptCoverage.enterprise )then
      print "This Partner has an Enterprise Focus!"
   end if
   if( rptCoverage.industry )then
      print "This Partner has an Industry Focus!"
   end if
   if( rptCoverage.partners_well )then
      print "This Partner works well with other Partners!"
   end if
   print
   print "*** Selling into these Regions ***"
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
   print "                    NY: ", rptCoverage.eu_ny
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
   print "MARKET/INDUSTRY FOCUS AREAS"
   print column 2, "COMMUNICATIONS/CSI"
   print "          Energy & Utility: ", rptCoverage.ind_eu
   print "     Media & Entertainment: ", rptCoverage.ind_me
   print "         Telecommunication: ", rptCoverage.ind_tel
   print "                       CSI: ", rptCoverage.ind_csi
   print column 2, "DISTRIBUTION"
   print "          Consumer Product: ", rptCoverage.ind_consume
   print "                    Retail: ", rptCoverage.ind_ret
   print "            Transportation: ", rptCoverage.ind_trans
   print column 2, "FINANCIAL SERVICES"
   print "                   Banking: ", rptCoverage.ind_bank
   print "         Financial Markets: ", rptCoverage.ind_finan
   print "                 Insurance: ", rptCoverage.ind_ins
   print column 2, "INDUSTRIAL"
   print "       Aerospace & Defense: ", rptCoverage.ind_defense
   print "                Automotive: ", rptCoverage.ind_auto
   print "      Chemical & Petroleum: ", rptCoverage.ind_chem
   print "               Electronics: ", rptCoverage.ind_elect
   print "       Industrial Products: ", rptCoverage.ind_indprod
   print column 2, "PUBLIC"
   print "                Government: ", rptCoverage.ind_gov
   print "                 Education: ", rptCoverage.ind_education
   print "                    Health: ", rptCoverage.ind_hl
   print "             Life Sciences: ", rptCoverage.ind_lifesci
   print "--------------------------------------------------------------------"
   print column 20, "** 4-has achieved Industry Authorization"
   print column 20, "** 3-has Industry Solutions"
   print column 20, "** 2-has Industry Practice"
   print column 20, "** 1/Y-has sold into the Industry"

need 9 lines
   print column 35, "--------------------------"
   print column 35, "ANALYTICS IM PROVEN SKILLS"
   print column 35, "--------------------------"
   print "*** BIG DATA AND NETEZZA ***"
   print column 5, KRec.skill_01 using "#", " : BigInsights/Hadoop"
   print column 5, KRec.skill_18 using "#", " : PureData for Analytics (Netezza)"
   print column 5, KRec.skill_06 using "#", " : PureData for Operational Analytics"
   print column 5, KRec.skill_04 using "#", " : Streams"
   print column 5, KRec.skill_03 using "#", " : Watson Explorer"
need 3 lines
   print "*** CLOUD SOLUTIONS ***"
   print column 5, KRec.skill_09 using "#", " : Bluemix/Softlayer"
   print column 5, KRec.skill_10 using "#", " : Cloud Databases (incl. Cloudant and dashDB)"

need 6 lines
   print "*** DATA MANAGEMENT ***"
   print column 5, KRec.skill_07 using "#", " : Database Tools and DB2 Connect"
   print column 5, KRec.skill_08 using "#", " : DB2"
   print column 5, KRec.skill_12 using "#", " : DB2 on z/OS"
   print column 5, KRec.skill_05 using "#", " : Industry Models"
   print column 5, KRec.skill_14 using "#", " : Informix"

need 2 lines
   print "*** EXPERT INTEGRATED SYSTEMS ***"
   print column 5, KRec.skill_15 using "#", " : PureData for Transactions"

need 4 lines
   print "*** INFOSPHERE INFORMATION INTEGRATION ***"
   print column 5, KRec.skill_02 using "#", " : InfoSphere Data Replication (CDC, Data Rep, Fed Serv)"
   print column 5, KRec.skill_13 using "#", " : Information Server (DS, QS, Foundation Tools)"
   print column 5, KRec.skill_16 using "#", " : MDM & EA (Entity Analytics, MDM and Reference Data Mgmt)"
   need 4 lines
   print "*** OPTIM/GUARDIUM (DATA GOVERNANCE) ***"
   print column 5, KRec.skill_11 using "#", " : Guardium (Monitor, Vulnerability, Redaction, Encryption)"
   print column 5, KRec.skill_19 using "#", " : Guardium Encryption"
   print column 5, KRec.skill_17 using "#", " : Optim (Capture and Replay, Data Growth, Masking, TDM)"

   skip 2 lines
need 8 lines
   print column 35, "--------------------------"
   print column 35, "ANALYTICS BA PROVEN SKILLS"
   print column 35, "--------------------------"
   print "*** BUSINESS INTELLIGENCE ***", column 40, "*** PREDICTIVE ANALYTICS ***"
   print column 5, MRec.skill_01 using "#", " : Cognos Analytics", column 40, MRec.skill_05 using "#", " : SPSS Data Collection"
 print column 5, MRec.skill_02 using "#", " : Cognos 10.x", column 40, MRec.skill_06 using "#", " : SPSS Statistics"
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

print "*** DECISION OPTIMIZATION ***",column 40, MRec.skill_26 using "#", " : Fin Risk Mgmt Insurers"
print column 5, MRec.skill_29 using "#", " : Dec Opt Center", column 40, MRec.skill_27 using "#", " : Risk Information Governance"
print column 5, MRec.skill_30 using "#", " : CPLEX", column 40, MRec.skill_28 using "#", " : Governance, Risk and Compliance"

   skip 2 lines
   need 6 lines
   print column 35, "---------------------------"
   print column 35, "ANALYTICS ECM PROVEN SKILLS"
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

