globals "globals.4gl"


main
define
   SQLStr char(256)

call ReadCmdLn("report", 4)
call ProcCmdLn("report")


let SQLStr = "select a.*, k.* from coverage_st a, skills_sw k, skills_sh l, skills_sv m  where a.ceid='", CLRec.CEID clipped, "' and a.ceid=k.ceid and a.ceid=l.ceid and a.ceid=m.ceid "
prepare R1ID from SQLStr
declare R1Curs cursor for R1ID

start report R1 

foreach R1Curs into URec.*, KRec.*, LRec.*, MRec.*
   output to report R1 (URec.*, KRec.*, LRec.*, MRec.*  )
end foreach

finish report R1

end main

report R1( rptCoverage, Kskill, Lskill, Mskill )
   define
      rptCoverage record like coverage_st.*,
      Kskill, Lskill, Mskill record like skills_sw.*

   output 
      top margin 0
      bottom margin 0
      left margin 0
      page length 60

format
page header
   print "Partner Matrix Contents for: ", rptCoverage.part_name clipped, " (", rptCoverage.ceid clipped, ")"
   print "Page: ", pageno using "##", " as of: ", date, " for Storage"
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
      print "This Partner does work well with other Partners!"
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

need 12 lines
   print column 35, "------------------------------------"
   print column 35, "Storage Software Proven SALES Skills"
   print column 35, "------------------------------------"
   print column 5, KRec.skill_01 using "#", " : Protect"
   print column 5, KRec.skill_02 using "#", " : Control"
   print column 5, KRec.skill_03 using "#", " : Virtualize"
   print column 5, KRec.skill_04 using "#", " : Acceleragte"
   print column 5, KRec.skill_05 using "#", " : Scale"
   print column 5, KRec.skill_06 using "#", " : Archive"
   print column 5, KRec.skill_07 using "#", " : Cloud Object Store"
   print column 5, KRec.skill_08 using "#", " : Platform Computing"
need 12 lines
   print column 35, "----------------------------------------"
   print column 35, "Storage Software Proven TECHNICAL Skills"
   print column 35, "----------------------------------------"
   print column 5, KRec.skill_09 using "#", " : Protect"
   print column 5, KRec.skill_10 using "#", " : Control"
   print column 5, KRec.skill_11 using "#", " : Virtualize"
   print column 5, KRec.skill_12 using "#", " : Acceleragte"
   print column 5, KRec.skill_13 using "#", " : Scale"
   print column 5, KRec.skill_14 using "#", " : Archive"
   print column 5, KRec.skill_15 using "#", " : Cloud Object Store"
   print column 5, KRec.skill_16 using "#", " : Platform Computing"

need 12 lines
   print column 35, "-----------------------"
   print column 35, "Partner Cloud Solutions"
   print column 35, "-----------------------"
   print column 5, KRec.skill_17 using "#", " : Protect"
   print column 5, KRec.skill_18 using "#", " : Control"
   print column 5, KRec.skill_19 using "#", " : Virtualize"
   print column 5, KRec.skill_20 using "#", " : Acceleragte"
   print column 5, KRec.skill_21 using "#", " : Scale"
   print column 5, KRec.skill_22 using "#", " : Archive"
   print column 5, KRec.skill_23 using "#", " : Cloud Object Store"
   print column 5, KRec.skill_24 using "#", " : Platform Computing"

need 9 lines
   print column 35, "-----------------------------"
   print column 35, "Storage Hardware SALES Skills"
   print column 35, "-----------------------------"
   print column 5, LRec.skill_01 using "#", " : FlashSystem"
   print column 5, LRec.skill_02 using "#", " : Storwize"
   print column 5, LRec.skill_03 using "#", " : XIV"
   print column 5, LRec.skill_04 using "#", " : DS8000"
   print column 5, LRec.skill_05 using "#", " : Tape"
   print column 5, LRec.skill_06 using "#", " : VersaStack"

need 9 lines
   print column 35, "---------------------------------"
   print column 35, "Storage Hardware TECHNICAL Skills"
   print column 35, "---------------------------------"
   print column 5, LRec.skill_07 using "#", " : FlashSystem"
   print column 5, LRec.skill_08 using "#", " : Storwize"
   print column 5, LRec.skill_09 using "#", " : XIV"
   print column 5, LRec.skill_10 using "#", " : DS8000"
   print column 5, LRec.skill_11 using "#", " : Tape"
   print column 5, LRec.skill_12 using "#", " : VersaStack"
print
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

