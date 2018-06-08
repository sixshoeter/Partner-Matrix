## Jun 18, 2013 - John - accept either blank or null in Industry columns
## Jun 21, 2013 - John - convert "H" to "HQ" in Business Units
## August 23, 2013 - John M. Shoemaker, calc "K" by 1000 rather than 1024
## October 11, 2013 - John M. Shoemaker, multiple changes 
## February 12, 2014 - John M. Shoemaker, add timestamp
## March 24, 2014 - John M. Shoemaker, add HQ
## September 04, 2014 - John M. Shoemaker, add secret version option
## September 15, 2014 - John M. Shoemaker - add additional contacts
## October 07, 2014 - John M. Shoemaker - include contacts with region/eu as directed
## October 17, 2014 - John M. Shoemaker - include skills inline
## October 24, 2014 - John M. Shoemaker - align rag table to top
## November 11, 2014 - John M. Shoemaker - activate CtlRec.cflg3
## November 24, 2014 John M. Shoemaker, expand to 30 skills
## December 16, 2014 John M. Shoemaker, add certs to secret version
## December 23, 2014 John M. Shoemaker, use periods for blanks in skills
## February 02, 2015 John M. Shoemaker, convert to UNITS
## March    03, 2015 John M. Shoemaker, add additional fields for units (ctp1/2/3,lead,tier)
## March    18, 2015 John M. Shoemaker, revert to revenue (previous year and last 12 months)
## April    03, 2015 John M. Shoemaker, add tier if available
## May      01, 2015 John M. Shoemaker, fix text color of contacts in regions
## May      21, 2015 John M. Shoemaker, allow update of skills as appropriate
## June     10, 2015 John M. Shoemaker, fix error in p_phone update line
## June     22, 2015 John M. Shoemaker, add in PCR to the cross table & expand edits to all successes
## July     08, 2015 John M. Shoemaker, allow edit of all contacts
## September08, 2015 John M. Shoemaker, add coverage note #89
## January  27, 2016 John M. Shoemaker, add description of diff SU CTPs
## February  17, 2016 John M. Shoemaker, filter out reseller X
## February  23, 2016 John M. Shoemaker, allow option of only showing ACAs
## February  25, 2016 John M. Shoemaker, expand extra contacts to include Reg/EBU in contact section
## March     08, 2016 John M. Shoemaker, allow edit of other contacts #142
## March     23, 2016 John M. Shoemaker, capture email of person doing update #158
## April     05, 2016 John M. Shoemaker, allow for options for Storage #160
## April     06, 2016 John M. Shoemaker, add global msg #145
## April     13, 2016 John M. Shoemaker, show extended contacts for storage #160
## May       04, 2016 John M. Shoemaker, allow update of extended contacts #164
## May       26, 2016 John M. Shoemaker, correct bug  #166
## May       31, 2016 John M. Shoemaker, show swita/sca as appropriate
## June      07, 2016 John M. Shoemaker, show GSI #112
## June      13, 2016 John M. Shoemaker, correct logic for showing form 513
## July      19, 2016 John M. Shoemaker, correct logic for showing form 506 with partners_well
## July      22, 2016 John M. Shoemaker, add support for markets/industries, #174
## August    08, 2016 John M. Shoemaker, add ind_education
## August    09, 2016 John M. Shoemaker, add expanded support of Industry, #178
## August    11, 2016 John M. Shoemaker, add logic for ACA term for non-AU
## August    16, 2016 John M. Shoemaker, continue support of Industry, #178
## September 09, 2016 John M. Shoemaker, make segmentation an option, #184
## December  09, 2016 John M. Shoemaker, migrate to competency, #192
## January   03, 2017 John M. Shoemaker, remove BPTV, #192
## January   26, 2017 John M. Shoemaker, change Current Year revenue to Rolling 12 Months, #195
## January   27, 2017 John M. Shoemaker, move pw program level url to master table, #196
## January   27, 2017 John M. Shoemaker, add POD info, #197
## April     11, 2017 John M. Shoemaker, add LAP column, #212
## April     13, 2017 John M. Shoemaker, migrate from SVP to CVR, #213
## April     14, 2017 John M. Shoemaker, add Activity Tracking section, #214
## April     14, 2017 John M. Shoemaker, add DFM flag, #215
## April     19, 2017 John M. Shoemaker, add authorization to update/add, #217
## April     24, 2017 John M. Shoemaker, add page counts, #219
## May       08, 2017 John M. Shoemaker, add showcerts option, #220
## May       10, 2017 John M. Shoemaker, add showenterprisealign and showindustryalign, #223 #224
## May       17, 2017 John M. Shoemaker, allow update mode via main detail page, #225
## May       22, 2017 John M. Shoemaker jshoemaker1@cox.net, sync up columns for competency, #231
## May       22, 2017 John M. Shoemaker jshoemaker1@cox.net, ensure secret version hidden, #226
## June      12, 2017 John M. Shoemaker jshoemaker1@cox.net, add social review, #235
## June      27, 2017 John M. Shoemaker jshoemaker1@cox.net, add gsd solutions, #183
## August    09, 2017 John M. Shoemaker jshoemaker1@cox.net, add activity section, #214
## August    10, 2017 John M. Shoemaker jshoemaker1@cox.net, add target/pv section, #248
## August    25, 2017 John M. Shoemaker jshoemaker1@cox.net, use target/pv columns by qtr, #250
## August    25, 2017 John M. Shoemaker jshoemaker1@cox.net, secret & noheader pages dynamic, #246, #251
## September 18, 2017 John M. Shoemaker jshoemaker1@cox.net, add gsd solutions inline, #183
## September 20, 2017 John M. Shoemaker jshoemaker1@cox.net, chg Submit button names in update mode, #260
## October   10, 2017 John M. Shoemaker jshoemaker1@cox.net, replace Normalized revenue, #270
## October   23, 2017 John M. Shoemaker jshoemaker1@cox.net, allow for ESA, #276
## January   15, 2018 John M. Shoemaker jshoemaker1@cox.net, use control for activity table names, #295


globals "globals.4gl"

define
   SuccessArr array[40] of 
      record
         s_title like success_ws.s_title,
         s_link like success_ws.s_link
      end record,
   EUDetails array[30] of char(1),
   INDDetails array[30] of char(1),
   CTPArr array[10] of char(20),  
   ctpidx smallint,
   tUnitBrandRec record like unit_brand.*,
   UnitBrandArr array[6] of record like unit_brand.*,
   ActInitRec record like act_initiative.*,
   ActRec record like activity.*,
   stat_desc char(11),
   type_desc char(30),
   tmp_pname like coverage_st.part_name

 

main

define
    SSRRec record like reps.*,
    CTP1Rec record like reps.*,
    CTP2Rec record like reps.*,
    CTP3Rec record like reps.*,
    CTP4Rec record like reps.*,
    CTP5Rec record like reps.*,
    VRec record like vads.*,
    GSDRec record like gsd_solutions.*,
    GSDArr array[500] of 
       record
          sol_id like gsd_solutions.sol_id,
          sol_name like gsd_solutions.sol_name,
          sol_url like gsd_solutions.sol_url,
          comp_name char(512)
       end record,
    i,j,newi,c,gcnt smallint,
    oRegion like eus.e_region,
    oMarket like industry.ig_name,
    successCnt smallint,
    qtrStr, gsdStr char(512),
    colorStr char(16),
    textcolorStr char(16),
    BPTV_cnt smallint,
    skillStr char(96),
    tamt float,
    buStr char(2),
    tURL char(60),
    showHeader smallint,
    secretVer smallint,
    currYear smallint,
    prevYear smallint,
    vapcnt smallint,
    goVAP smallint,
    lstr like reps.r_link,
    stateStr like states.s_name,
    showTableHeader smallint,
    lastRag, cText like certs.prod_group,
    Scnt, Tcnt smallint,
    tBrandRec record like brands.*,
    SQLStr char(512),
    SQLStr1 char(512),
    SQLStr2 char(1024),
    tidx, SkilledYN smallint,
    tdesc like unit_brand.desc,
    tmpStr char(32),
    tseg_name like segmentation.seg_name,
    ctp_cnt smallint,
    retS1, retS2 char(20),
    color_idx smallint,
    inCompStat, idx smallint,
    snum1, enum1 float,
    pw_lev like competency.pw_level,
    pcrName like pod_info.pcr,
    pcrcnt smallint,
    button_face char(10),
    rcnt smallint,
    ravg smallfloat,
    rStr char(5),
    nStr char(100),
    TrgRec record like target.*,
    tQtr char(1),
    tTgt, tPV integer

#set explain on;
call ReadCmdLn( "nbuildPagesU", 5 )
call ProcCmdLn( "nbuildPagesU" )
let secretVer = FALSE
let UpdateAllow = FALSE
let showHeader = arg_val(5)

if( showHeader > 0 )then
#   if( showHeader > 1 and NOT RevBox )then   #(only generate for brands not showing revenue)
   if( showHeader > 1 )then   
      let secretVer = TRUE
      if( showHeader = 5 )then
         let UpdateAllow = TRUE
      end if
   end if
   let showHeader = TRUE
else
   let showHeader = FALSE
end if

call LoadBPTVRec( CLRec.ceid )
call GetColor(BRec.b_id, 0,1) returning colorStr, textcolorStr
call GetRevDates() returning prevYear, currYear

   let qtrStr = "select a.*,r.*, s.*, t.*, u.*, w.*, x.*, v.* ",
   "from ", cov_tab clipped, " a, outer reps r, outer reps s, outer reps t, outer reps u, outer reps w, outer reps x, outer vads v ",
   "where a.ceid = '", CLRec.CEID clipped, "' ",
     "and a.ssr = r.r_name ",
     "and a.ctp1 = s.r_name ",
     "and a.ctp2 = t.r_name ",
     "and a.ctp3 = u.r_name ",
     "and a.ctp4 = w.r_name ",
     "and a.ctp5 = x.r_name ",
     "and a.vad = v.v_id "


#display qtrStr
#whenever error continue
prepare QID from qtrStr
#display sqlca.sqlcode
declare ACurs cursor for QID




foreach ACurs into URec.*, SSRRec.*, CTP1Rec.*, CTP2Rec.*, CTP3Rec.*, CTP4Rec.*, CTP5Rec.*, VRec.*

   call ShowTitleDetail( showHeader, URec.ceid, UpdateAllow )
   display " "

#display qtrStr
display "<table align='center' border='0' style='width: 744px'>"
display "<tbody>"
display "<tr>"
display "<td style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<h1 style='text-align: center'>"
if( UpdateAllow )then
   display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 24px'>","<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a></span></span></h1>"
else
   display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 24px'>",URec.part_name clipped, "</span></span></h1>"
end if  #UpdateAllow
display "</td>"
display "<td style='text-align: center; width: 191px; vertical-align: middle'>"
#display "<div>"
display "<div style='text-align: center'>"


## make url consistent with http prefix
if( URec.url[1,4] = "http" )then
   let tURL = URec.url clipped
else
   let tURL = "http://", URec.url clipped
end if

display "<span style='font-size: 12pt'><a href='", tURL clipped, "' target='_blank'>", URec.url clipped,"</a></span></div>"

## display the PW Profile if present
if( URec.pwp is not null) then
   display "<div style='text-align: center'>"
   display "<span style='font-size: 12pt'><a href='", URec.pwp clipped, "' target='_blank'>PartnerWorld Profile", "</a></span></div>"
end if


## display the CEID
display "<div style='text-align: center'>"
display "<span style='font-size: 12pt'>CEID: ", URec.ceid clipped,"</span></div>"

## only show secret version if also showing the header
if( not secretVer and showHeader > 0 )then
#   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-sec.html' class='no_show'>....</a>"
   if( CtlRec.bg_color is null or CtlRec.bg_color = " " )then
      display "<a href='/cgi-bin/showSecret", BRec.b_id clipped, ".ksh?", URec.ceid clipped, "' class='no_show'>....</a>"
   else
      display "<a href='/cgi-bin/showSecret", BRec.b_id clipped, ".ksh?", URec.ceid clipped, "' style='color:", CtlRec.bg_color clipped, "; text-decoration: none;'>....</a>"
#      display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-sec.html'  style='color:", CtlRec.bg_color clipped, "; text-decoration: none;'>....</a>"
#      display "<style> div {display: block;} body {background-color: ", CtlRec.bg_color clipped, ";}</style>"
   end if

#   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-sec.html'  style='color:", CtlRec."; text-decoration: none;'>....</a>"
end if

display "<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -4.92%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span>"
#display "</div>"
display "</td>"
display "<td  class='centerText';style='text-align: center; width: 115px; vertical-align: middle'>"
display "<img  style='block; width: auto; height: auto'; src='/", IRec.i_id clipped, "/I/", URec.ceid clipped,".jpg' id='theImgID' /></td>"
display "</tr>"
display "<tr>"
display "<td colspan='2' style='width: 421px;vertical-align: top'>"
display "<div>"
display "<span style='font-size:16px;'><span style='font-family:arial,helvetica,sans-serif;'>"
if( UpdateAllow )then
   display "<FORM ID='desc'  ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit Description Change'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=501>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
   display "<TEXTAREA NAME='desc' rows='25' cols='100'>", URec.desc clipped, "</TEXTAREA>"
   display "</FORM>"
else
   display URec.desc clipped
end if
display "</span></span></div>"
display "&nbsp;"
display "</td>"
display "<th style='text-align: center; background-color: rgb(240,248,255); width: 250px; vertical-align: top'>"

######################################################
##  BPTV table
######################################################
if( not CtlRec.showcompetency )then
display "<table style='font-size:12px'; align='center' border='1' height='127' style='width: 143px'>"
#display "<table align='center' border='1' height='127' style='width: 143px' width='195'>"
display "<tbody>"
#display "<tr>"
display "<th style='text-align: center; background-color: #add8e6; width: 66px'>"
#display "&nbsp;</th>"
#display "<strong>", BRec.b_id clipped, " Product Groups</strong></th>"
display "<strong>", BRec.b_name clipped, "</strong></th>"
display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
display "<strong>Authorized</strong><br />"
if( CertFlg )then
   if( PplFlg )then
      display "(# certs/#ppl)</th>"
   else
      display "(# certs)</th>"
   end if
else  #not CertFlg
   if( PplFlg )then
      display "(# ppl)</th>"
   else
      display "</th>"
   end if
end if  #if CertFlg
display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
#display "<strong>BPTV</strong></th>"
display "<strong><a href='/", IRec.i_id clipped,"/", BRec.b_id clipped, "../../all/H/BPTV.html' target='_blank'>BPTV</a></strong></th>"
if( RevBox or secretVer )then
   if( SplitFlg or secretVer )then
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>", prevYear using "####", " Lic Rev</strong></th>"
#      display "<strong>", "2013 Lic Rev</strong></th>"
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>", "Roll 12 mo Lic Rev</strong></th>"
#      display "<strong>", "2014 Lic Rev</strong></th>"
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>", prevYear using "####", " Val Rev</strong></th>"
#      display "<strong>", "2013 Val Rev</strong></th>"
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>", "Roll 12 mo Val Rev</strong></th>"
#      display "<strong>", "2014 Val Rev</strong></th>"
   else
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>New Lic Rev</strong></th>"
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>Val Rev</strong></th>"
   end if
end if
#display "</tr>"

if( SplitFlg or secretVer  )then
#  load the array of BPTV info
   let BPTV_Cnt = GetBPTVPartsSplit( URec.ceid )
else
#  load the array of BPTV info
   let BPTV_Cnt = GetBPTVParts( URec.ceid )
end if

## authorized rows
for i = 1 to BPTV_Cnt
   display "<tr>"
   display "<td style='width: 66px'>"
   display "<strong>", BPTVArr[i].rag_alt clipped, "</strong></td>"
   display "<td style='text-align: center; width: 65px'>"
#   if( BPTVArr[i].bptv_01>0) then
## assume if they are in the file they are SVP/CVR approved
      display "Yes"
      if( PplFlg AND BPTVArr[i].people_01 > 0 )then
         display "(", BPTVArr[i].people_01 using "<<<", ")"
      end if
      display "</td>"
      display "<td style='text-align: center; width: 65px; "
## green
      if( BPTVArr[i].bptv_01 >= 70) then
         display "background-color: rgb(0,255,0)"
      else 
         if( BPTVArr[i].bptv_01 >= 50 and BPTVArr[i].bptv_01 < 70) then
## yellow
            display "background-color: rgb(255,255,0)"
         else
## red
            display "background-color: rgb(255,0,0)"
         end if
      end if
      display "'>"
      display BPTVArr[i].bptv_01 using '###', "</td>"
#   else
#      display "&nbsp;</td><td> &nbsp;</td>"
#   end if

if( RevBox or secretVer )then
   if( SplitFlg  or secretVer )then
##    show NL Revenue
##    year-1
      display "<td stle='text-align: right; width: 66px'>"
      if( BPTVArr[i].nlrev_01 > 0 )then
         let tamt = BPTVArr[i].nlrev_01/1000
         if( RevFlg )then
            display tamt using "###,###,###", "K"
         else
            display "Yes"
         end if
      else
         display "&nbsp;"
      end if
      display "</td>"
   
##    current ytd
      display "<td stle='text-align: right; width: 66px'>"
      if( BPTVArr[i].nlrev_02 > 0 )then
         let tamt = BPTVArr[i].nlrev_02/1000
         if( RevFlg )then
            display tamt using "###,###,###", "K"
         else
            display "Yes"
         end if
      else
         display "&nbsp;"
      end if
      display "</td>"

##    show year-1 Value Revenue
      display "<td style='text-align: right; width: 66px'>"
      if( BPTVArr[i].vrrev_01 > 0 )then
         let tamt = BPTVArr[i].vrrev_01/1000
         if( RevFlg )then
            display tamt using "###,###,###", "K"
         else
            display "Yes"
         end if
      else
         display "&nbsp;"
      end if
      display "</td>"

##    show ytd Value Revenue
      display "<td style='text-align: right; width: 66px'>"
      if( BPTVArr[i].vrrev_02 > 0 )then
         let tamt = BPTVArr[i].vrrev_02/1000
         if( RevFlg )then
            display tamt using "###,###,###", "K"
         else
            display "Yes"
         end if
      else
         display "&nbsp;"
      end if
      display "</td>"

   else
## 
      display "<td stle='text-align: right; width: 66px'>"
      if( BPTVArr[i].nlrev_01 > 0 )then
         let tamt = BPTVArr[i].nlrev_01/1000
         if( RevFlg )then
            display tamt using "###,###,###", "K"
         else
            display "Yes"
         end if
      else
         display "&nbsp;"
      end if
      display "</td>"

##    show Value Revenue
      display "<td style='text-align: right; width: 66px'>"
      if( BPTVArr[i].vrrev_01 > 0 )then
         let tamt = BPTVArr[i].vrrev_01/1000
         if( RevFlg )then
            display tamt using "###,###,###", "K"
         else
            display "Yes"
         end if
      else
         display "&nbsp;"
      end if
      display "</td>"
   end if #SplitFlg
end if  #RevFlg


display "</tr>"
end for

## find any other RAGs not in BPTV file
#display "CHECK FOR RAG NOT HERE: ", G_SVPcnt
for i = 1 to G_SVPcnt
   if( SVPArr[i].flag = 0 )then
#display "Zero: ", SVPArr[i].*
      display "<tr>"
      display "<td style='width: 66px'>"
      display "<strong>", SVPArr[i].s_name clipped, "</strong></td>"
      display "<td style='text-align: center; width: 65px'>"
{
      case i
         when 1
            if( ARec.svp_01 = 'Y') then
               display "Yes</td>"
            else
               display "&nbsp;</td>"
            end if
         when 2
            if( ARec.svp_02 = 'Y') then
               display "Yes</td>"
            else
               display "&nbsp;</td>"
            end if
         when 3
            if( ARec.svp_03 = 'Y') then
               display "Yes</td>"
            else
               display "&nbsp;</td>"
            end if
         when 4
            if( ARec.svp_04 = 'Y') then
               display "Yes</td>"
            else
               display "&nbsp;</td>"
            end if
         when 5
            if( ARec.svp_05 = 'Y') then
               display "Yes</td>"
            else
               display "&nbsp;</td>"
            end if
      end case
}
      display "&nbsp;</td>"
  
      display "</tr>"
   end if
end for

if( RevBox or secretVer )then
   display "<tr><td></td><td></td><td></td><td colspan='4'>* FRev +uplift</td></tr>"
end if

display "</tbody>"
display "</table>"

display "<BR \>"
end if  #not showcompetency

################################################################
## COMPETENCY SECTION START
################################################################
if( CtlRec.showcompetency )then
#if( CtlRec.showcompetency and (URec.ceid='7epgd' or URec.ceid='18z7govd' or URec.ceid='6c33d' or URec.ceid='18z7gey8' or URec.ceid='18z7ge5l' or URec.ceid='18z7gkgl' or URec.ceid='18z7gkgl'))then

## retrieve comp data for this partner
call LoadCompArr( BRec.b_id, URec.ceid )
let G_SVPinfocnt = LoadSVPInfoArr( BRec.b_id, URec.ceid )

################################################################
## (new) SVP/CVR SECTION
################################################################
#display "<span style='font-size: 12;color:red'>** THE TABLE ABOVE WILL BE REPLACED AT YEAR END BY THE TWO TABLES BELOW **</span>"
if( G_SVPinfocnt > 0 )then
   display "<table style='font-size:12px'; align='center' border='1' height='127' style='width: 200px'>"
#   display "<table align='center' border='1' height='127' style='width: 143px' width='195'>"
   display "<tbody>"
#   display "<tr>"
   display "<tr><th colspan='2' style='text-align: center; background-color: #add8e6;font-size:16px'><em>CVR Authorizations</em></tr>"

   display "<th style='text-align: center; background-color: #add8e6; width: 300px'>"
   display "<strong>", BRec.b_name clipped, "</strong></th>"
   display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
   display "<strong>CVR Authorization</strong>"
   for i = 1 to G_SVPinfocnt
      display "<tr>"
      display "<td style='width: 266px'>"
      display "<strong>", SVPInfoArr[i].prod_grp_desc clipped, "</strong></td>"
   
      display "<td style='text-align: center; width: 65px'>"
      display "<strong>", SVPInfoArr[i].prod_grp_stat clipped, "</strong></td>"
      display "</tr>"
   end for  #G_SVPinfocnt
   display "</table>"
end if  #G_SVPinfocnt > 0

################################################################
## Target/PV Section
################################################################
if( CtlRec.showtarget )then
   call LoadTargets( URec.ceid ) returning TrgRec.*
#   if( TrgRec.t_st_q3_target >0 or TrgRec.t_st_q3_pv > 0)then
      let tQtr=currQtr()
#display "tQtr: ", tQtr
      case tQtr
         when "1"
            let tTgt=TrgRec.t_strg_q1_target
            let tPV=TrgRec.t_strg_q1_pv
         when "2"
            let tTgt=TrgRec.t_strg_q2_target
            let tPV=TrgRec.t_strg_q2_pv
         when "3"
            let tTgt=TrgRec.t_strg_q3_target
            let tPV=TrgRec.t_strg_q3_pv
         when "4"
            let tTgt=TrgRec.t_strg_q4_target
            let tPV=TrgRec.t_strg_q4_pv
         otherwise
            let tTgt=0
            let tPV=0
      end case  #tQtr

      display "<table style='font-size:12px'; align='center' border='1' height='127' style='width: 200px'>"
      display "<tbody>"
      display "<tr><th colspan='2' style='text-align: center; background-color: #add8e6;font-size:16px'><em>", BRec.b_name clipped, " Target and PV - Q", tQtr, "</em></tr>"
      display "<th style='text-align: center; background-color: #add8e6; width: 250px'>"
      display "<strong>Target</strong></th>"
      display "<th style='text-align: center; background-color: #add8e6; width: 250px'>"
      display "<strong>PV</strong>"
      display "<tr><td>", tTgt using "$$$,$$$,$$$","</td><td>", tPV using "$$$,$$$,$$$", "</td></tr>"

      display "</table>"
#   end if  #if present

end if  #showtarget
################################################################

if( G_COMPcnt > 0 )then
   display "<table style='font-size:12px'; align='center' border='1' height='127' style='width: 200px'>"
#   display "<table align='center' border='1' height='127' style='width: 143px' width='195'>"
   display "<tbody>"
#   display "<tr>"
   if( RevBox or secretVer )then
      display "<tr><th colspan='5' style='text-align: center; background-color: #add8e6;font-size:16px'><em>Competency Achievements</em></tr>"
   else
      display "<tr><th colspan='4' style='text-align: center; background-color: #add8e6;font-size:16px'><em>Competency Achievements</em></tr>"
   end if
   display "<th style='text-align: center; background-color: #add8e6; width: 66px'>"
#   display "&nbsp;</th>"
#   display "<strong>", BRec.b_id clipped, " Product Groups</strong></th>"
   display "<strong>", BRec.b_name clipped, "</strong></th>"
   display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
   display "<strong>Competency Level</strong><br />"
   display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
   display "<strong>Current Status</strong><br />"
   display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
   display "<strong># Solutions</strong><br />"
   if( RevBox or secretVer )then
      if( SplitFlg or secretVer )then
         display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
   display "<strong><a href='../../all/H/Competency.html' target='_blank'>Normalized Rev</a><br>Rolling 12 Month</strong></th>"

{
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>", "Roll 12 mo Lic Rev</strong></th>"
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>", prevYear using "####", " Val Rev</strong></th>"
      display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
      display "<strong>", "Roll 12 mo Val Rev</strong></th>"
}
      else
         display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
         display "<strong>New Lic Rev</strong></th>"
         display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
         display "<strong>Val Rev</strong></th>"
      end if
#display "<th style='text-align: center; background-color: #add8e6; width: 65px'>"
#display "<strong>CVR Status</strong><br />"

   end if
#display "</tr>"

{
if( SplitFlg or secretVer  )then
#  load the array of BPTV info
   let BPTV_Cnt = GetBPTVPartsSplit( URec.ceid )
else
#  load the array of BPTV info
   let BPTV_Cnt = GetBPTVParts( URec.ceid )
end if
}

## authorized rows
   for i = 1 to G_COMPcnt
      display "<tr>"
      display "<td style='width: 66px'>"
      display "<strong>", CompArr[i].bu clipped, "</strong></td>"
   
      display "<td style='text-align: center; width: 65px'>"
      display "<strong>", CompArr[i].comp_name clipped, "</strong></td>"
#   display "</td>"
#   call inComp( CompArr[i].comp_name ) returning inCompStat, idx
#if( inCompStat )then
      display "<td style='text-align: center; width: 65px;'>"
   #########if( CompArr[i].achieved_level != 'Specialist' and CompArr[i].achieved_level != 'Expert' )then
      if( CompArr[i].achieved_level is null or CompArr[i].achieved_level = ' ' )then
#      if( CompArr[i].achieved_level is null or CompArr[i].achieved_level = ' ' )then
         let enum1 = 1
         let snum1 = CompArr[i].spec_prog_pct
         if(  CompArr[i].rev_norm_curr_yr is null or CompArr[i].rev_norm_curr_yr < 0 )then
            let button_face="None"
         else
            let button_face="In Process"
         end if  #no revenue
         display "<FORM ID='comp' ACTION='/cgi-bin/ShowCompStat", BRec.b_id clipped, ".ksh' METHOD=POST>", "<input TYPE=submit VALUE='", button_face clipped, "'><INPUT NAME='complevel' TYPE=hidden READONLY VALUE='",CompArr[i].comp_name clipped,"'><INPUT NAME='ceid' TYPE=hidden READONLY VALUE=",  URec.ceid clipped, "> </form>"
         display "<span style='font-size: 8px'>Progress toward SPECIALIST level:</span>"
         display "<progress max='", enum1 using '<<&', "' value='", snum1 using '<<&', "'></progress></td>"
      else
         let enum1 = 1
         let snum1 = CompArr[i].exp_prog_pct
         display "<FORM ID='comp' ACTION='/cgi-bin/ShowCompStat", BRec.b_id clipped, ".ksh' METHOD=POST>", "<input TYPE=submit VALUE='",  CompArr[i].achieved_level clipped, "'><INPUT NAME='complevel' TYPE=hidden READONLY VALUE='",CompArr[i].comp_name clipped,"'><INPUT NAME='ceid' TYPE=hidden READONLY VALUE=",  URec.ceid clipped, "> </form>"
         if( CompArr[i].achieved_level = "Specialist" )then
            display "<span style='font-size: 8px'>Progress toward EXPERT level:</span>"
         else
            if( CompArr[i].achieved_level = "Expert" )then
               display "<span style='font-size: 8px'>Progress maintaining EXPERT level:</span>"
            else
               display "<span style='font-size: 8px'>Progress toward next level:</span>"
            end if
         end if
         display "<progress max='", enum1 using '<<&', "' value='", snum1 using '<<&', "'></progress></td>"
      end if  #Not Achieved

#   display "<a href='/cgi-bin/ShowCompStat.ksh ", "' class='no_show' target='_blank'>", CompArr[i].stat clipped, "</a></td>"
#   else
#      display CompArr[i].achieved_level clipped, "</td>"
#   end if


      display "<td style='text-align: center; width: 65px'>"
#      if( CompArr[i].sols = 0 )then
      if( CompArr[i].sols = 0 or CompArr[i].gsd_indicator is NULL or CompArr[i].gsd_indicator < 1 )then
         display "<strong>", CompArr[i].sols clipped, "</strong></td>"
      else
         let nStr=AddPlus(CompArr[i].comp_name) 
	 display "<strong>", "<a href='/cgi-bin/showGSDsols", BRec.b_id clipped, ".ksh?", URec.ceid clipped, ":", nStr clipped, "'>", CompArr[i].sols clipped, "</a></strong></td>"
      end if  #sols=0
#   display "</td>"

   if( RevBox or secretVer )then
      display "<td style='width: 66px'>"
      if(  CompArr[i].rev_norm_curr_yr > 0 and CompArr[i].rev_norm_curr_yr is not null )then
         display CompArr[i].rev_norm_curr_yr using "$$$,$$$,$$$", "</td>"
      else
         display "</td>"
      end if
   end if  #RevBox or secretVer

#   display "<td style='width: 66px'>"
#   if( inSVP( CompArr[i].comp_name) )then
#      display "CVR Auth", "</td>"
#   else
#      display "</td>"
#   end if
#else
#  display "<td>-</td><td>-</td><td>-</td><td>"
#end if
   display "</tr>"
   end for

      display "</tbody>"
      display "</table>"
   end if  #G_COMPcnt > 0
end if  # if show competency
################################################################
## COMPETENCY SECTION END
################################################################

#display "<span style='font-size: 8px'>&nbsp;</span></p>"

#display "<tr>"
#display "<div style='text-align: center'>"
#display "<strong><a href='/", IRec.i_id clipped,"/", BRec.b_id clipped, "/H/BPTV.html'>What is BPTV?</a></strong></div>"
#display "<div style='text-align: center'>"
#display "<em>(Business Partner Technical Vitality)</em></div>"
#display "<br />"
#display "</th>"
#display "</tr>"



# show top skilled areas
# display "<tr>"

let skillStr=BuildSkillStr(3)

if( not G_includeskills )then
   if( skillStr is not NULL )then
      display "<div style='text-align: center'>"
      display "<em>Top Skilled in:</em><br />", skillStr clipped, "</div>"
   end if
   display "<div style='text-align: center'>"
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-skills.html'>All ", BRec.b_name clipped, " Skills</a><br />"
end if  #G_includeskills

#display "</tr>"

## show VAP details
if( ShowVAPFlg )then
   let G_VAPcnt = LoadVAP( URec.ceid )
   let goVAP = FALSE
   for i = 1 to G_VAPcnt
      if( IsValidVAPforBrand(BRec.b_id, i))then
         let goVAP = TRUE
         exit for
      end if
   end for
   if( goVAP )then
      display "<div style='text-align: center'>"
      display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-vap.html'>VAP Solutions </a><p>"
   end if  #goVAP
end if  #ShowVAPFlg

## show Solution details
if( CtlRec.showsolutions )then
   let G_VAPcnt = LoadSolutions( URec.ceid )
   let goVAP = FALSE
   if( G_VAPcnt > 0 )then
{   for i = 1 to G_VAPcnt
      if( IsValidVAPforBrand(BRec.b_id, i))then
         let goVAP = TRUE
         exit for
      end if
   end for
   if( goVAP )then
}
      display "<div style='text-align: center'>"
      display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-solutions.html'>Partner Solutions </a><p>"
   end if  #G_VAPcnt > 0
{   end if  #goVAP}
end if  #ShowVAPFlg



if( ShowFocusArea( URec.focus1, URec.focus2, AREc.focus3) )then
   display "<table align='center' border='1' style='width: 100px'>"
   display "<tbody>"
   display "<tr>"
   display "<td style='background-color: #add8e6' style='text-align: center'>"
   display "Other Focus Areas</td>"
   display "</tr>"
   display "<tr><td>"
   if( URec.focus1 is not null) then
      display URec.focus1 clipped
   else
      display "&nbsp;"
   end if
   display "</td></tr>"
   if( URec.focus2 is not null) then
      display "<tr><td>"
      display URec.focus2 clipped
      display "</td></tr>"
   end if
   if( URec.focus3 is not null) then
      display "<tr><td>"
      display URec.focus3 clipped
      display "</td></tr>"
   end if
display "</tbody>"
display "</table>"
display "<br />"
end if
## show other brands
if( ShowBrands )then
   call ShowOtherBrands ( BRec.b_id, URec.ceid )
end if

display "<p>"

## display the Partner Segmentation
let i = 0
if( URec.part_type != ' ' and CtlRec.show_cio )then
   let SQLStr = "select a.seg_name from segmentation a where a.seg_id='", URec.part_type, "'"
   prepare SGID from SQLStr
   execute SGID into tseg_name

   if( tseg_name is not null )then
      display "<span style='font-size: 8pt'><a href='../../all/H/Segmentation.html' target='_blank'>Segmentation</a>: ", tseg_name clipped, "</span><br />"
   end if
end if


## display the Partner Program Status (may only be Storage)
if( URec.prog_status != ' ' and URec.prog_status is not NULL )then
   display "<div style='text-align: center'>"
   display "<span style='font-size: 8pt'><a href='https://www-356.ibm.com/partnerworld/wps/servlet/ContentHandler/isv_com_spe_storage' target='_blank'>", URec.prog_status clipped, " Partner</a></span></div>"
end if

## display the Partner Certification Status (may only be Storage)
if( CtlRec.showstoragecerts )then
   call GetStorageCertStr( BRec.b_id, URec.ceid ) returning retS1, retS2
   if( retS1 != ' ' )then
      display "<div style='text-align: center'>"
      display "<span style='font-size: 8pt'><a href='http://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/stg_com_tac-authorization' target='_blank'>", retS1 clipped, "</a></span></div>"
   end if
   if( retS2 != ' ' )then
      display "<div style='text-align: center'>"
      display "<span style='font-size: 8pt'><a href='http://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/stg_com_tac-authorization' target='_blank'>", retS2 clipped, "</a></span></div>"
   end if
end if  #CtlRec.showstoragecerts

## display the PW level and Value Pack
let pw_lev = GetPWLevel( URec.ceid )
if( pw_lev is not NULL )then
   display "<span style='font-size: 8pt'><a href='", MasterRec.pw_url clipped, "' target='_blank'>PW Level:</a> ", pw_lev clipped, " </span></div>"
end if  #PW level

{
if( BPTVRec.pw_level="MEM" )then
   display "<span style='font-size: 8pt'><a href='http://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/pw_com_lev_index' target='_blank'>PW Level:</a> Member";
#   if( BPTVRec.value_pack = "Yes" )then
#      display " with Value Pack";
#   end if
   display " ", URec.tier using '#', " </span></div>"
else
   if( BPTVRec.pw_level="ADV" )then
      display "<span style='font-size: 8pt'><a href='http://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/pw_com_lev_index' target='_blank'>PW Level:</a> Advanced";
#      display "<span style='font-size: 8pt'>(PW Level: Advanced";
#      if( BPTVRec.value_pack = "Yes" )then
#         display " with Value Pack";
#      end if
      display " ", URec.tier using '#', " </span></div>"
   else
      if( BPTVRec.pw_level="PRE" )then
         display "<span style='font-size: 8pt'><a href='http://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/pw_com_lev_index' target='_blank'>PW Level:</a> Premier";
#         display "<span style='font-size: 8pt'>(PW Level: Premier";
#         if( BPTVRec.value_pack = "Yes" )then
#            display " with Value Pack";
#         end if
         display " ", URec.tier using '#', " </span></div>"
      end if  #PRE
   end if  #ADV
end if  #MEM
}

## display the hunter flag if appropriate
if( CtlRec.showhunter AND (URec.hunter='Y' ))then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/HUNTER.html' target='_blank'>Hunter</a></span></div>";
end if

## display the commercial flag if appropriate
if( CtlRec.showcommercial AND (URec.commercial='Y' ))then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/COMMERCIAL.html' target='_blank'>Commercial Focus</a></span></div>";
end if

## display the enterprise flag if appropriate
if( CtlRec.showenterprisealign AND (URec.enterprise='Y' ))then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/ENTERPRISE.html' target='_blank'>Enterprise Focus</a></span></div>";
end if

## display the industry flag if appropriate
if( CtlRec.showindustryalign AND (URec.industry='Y' ))then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/INDUSTRY.html' target='_blank'>Industry Focus</a></span></div>";
end if

## display the LAP (Linux Acceleration Program) flag if appropriate
if( CtlRec.showlap AND (URec.lap='Y' ))then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/LAP.html' target='_blank'>LAP</a></span></div>";
end if

## display the DFM (Data First Method) flag if appropriate
if( CtlRec.showdfm AND (URec.dfm='Y' ))then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/DFM.html' target='_blank'>Data First Method Trained</a></span></div>";
end if

## display the Partnering flag if appropriate
if( CtlRec.showpartnerswell AND (URec.partners_well='Y' ))then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/PARTNERS.html' target='_blank'>Partners with Partners</a></span></div>";
end if

## display the Partner Type if appropriate
if( URec.reseller = "G" )then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/GSI.html' target='_blank'>GSI Partner Type</a></span></div>";
end if

## display the Partner Type if appropriate
if( URec.reseller = "E" )then
   display "<div><span style='font-size: 8pt'><a href='../../all/H/ESA.html' target='_blank'>ESA Partner Type</a></span></div>";
end if

## display the Social Review if appropriate
if( CtlRec.showreview )then   #secretVer for testing
   call commentInfo( URec.ceid ) returning rcnt, ravg
   let rStr=getRatingStr(ravg)
   display "<br><div><span style='font-size: 12pt'> >>> Social Feedback <<< </span><br>"
   display rStr, "<br>"
   display "<FORM ID='review' ACTION='/cgi-bin/review", BRec.b_id clipped, ".ksh'>" #method='post'>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,">"
   display "<INPUT NAME='brand' TYPE=hidden READONLY VALUE=", BRec.b_id clipped,">"
   if( rcnt > 1 )then
      display "<INPUT TYPE=submit VALUE='", rcnt using "<<<", " Comments'>"
   else
      if( rcnt=1 )then
         display "<INPUT TYPE=submit VALUE='", rcnt using "<<<", " Comment'>"
      else
         display "<INPUT TYPE=submit VALUE='No Comments Yet'>"
      end if
   end if
   display "</FORM>"
   display "</div>"
end if

display "<div>"

display "<p>"
display "&nbsp;</p>"

##
############################################
## Show skills for current brand here if requested
############################################
##
if( G_includeskills )then
#if( CtlRec.newindustry )then
   display "<tr>"
   display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
   display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>E V A L U A T E D&nbsp;&nbsp; D E T A I L E D&nbsp;&nbsp; S K I L L S</span></span></td>"
   display "</tr>"
   display "<tr>"
   display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
   display "<p>"
   display "&nbsp;</p>"
#end if  #G_includeskills

#   display "<tr>"
#   if( CtlRec.cflg3 )then   #rotate showing one skill category per row

#   let SQLStr = "select a.b_ord from brands a where a.b_id='", inBrand clipped, "'"
#   prepare LSU1 from SQLStr
#   execute LSU1 into bIdx

let SQLStr="select a.*, b.ordctp, b.desc from brands a, unit_brand b where a.b_id=b.b_id and b.u_id='", BRec.b_id clipped, "' order by a.b_ord"
prepare LSU2 from SQLStr
declare LSU2Curs cursor for LSU2

foreach LSU2Curs into tBrandRec.*, tidx, tdesc
   let CTPArr[tidx] = tdesc
#   let CTPArr[tidx] = tBrandRec.b_id
   let SkilledYN = LoadSkillRec( tBrandRec.b_id, URec.ceid )
#display "SkilledYN :", SkilledYN
   if( SkilledYN or UpdateAllow )then
      call ShowSkillsCurrentBrand2( 1, tBrandRec.b_id, tBrandRec.b_ord )
   end if
end foreach
#      call eoadSkillRec( "BA", URec.ceid )
#      call ShowSkillsCurrentBrand2( 1, "BA", 6 )
#      call LoadSkillRec( "EM", URec.ceid )
#      call ShowSkillsCurrentBrand2( 1, "EM", 9 )
#   else
#      call ShowSkillsCurrentBrand( 1 )
#   end if
#   display "</tr>"

#if( CtlRec.newindustry )then
   display "</tr>"
#end if
end if  #include skills

############################################
## GSD Solutions (NO longer only for Secret pages)
############################################
#display "SECRETVER: ", secretVer 
let gsdStr="select count(*) from gsd_solutions where ceid='", uRec.ceid clipped, "'"
prepare GSDID0 from gsdStr
execute GSDID0 into gcnt

if( gcnt>0 )then
#   display "<tr>"
#   display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
#   display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>G S D   &nbsp;&nbsp;&nbsp;S O L U T I O N S</span></span></td>"
#   display "</tr>"
display "<table align='center' border='1' height='60' width='900'>"
#display "<tbody>"
display "<tr>"
display "<td colspan='100' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>Partner Solution Details</span></span></td>"
display "</tr>"
#display "&nbsp;</p>"

display "<tr><th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Solution Name", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Competencies", "</strong></th>"

display "<th class='centerText'; style='background-color: #add8e6'>"
display "<strong>", "Solution ID (link to GSD Details)", "</strong></th>"
display "</tr>"

let gsdStr = "select a.* from gsd_solutions a where a.ceid='", uRec.ceid clipped, "' order by sol_name, sol_id, comp_name "

#display gsdStr
prepare GSDID from gsdStr
declare GSDCurs cursor for GSDID
let gcnt=0
foreach GSDCurs into GSDRec.*

   if( gcnt=0 )then
      let gcnt=gcnt+1
      initialize GSDArr[gcnt].* to NULL

      let GSDArr[gcnt].sol_id=GSDRec.sol_id clipped
      let GSDArr[gcnt].sol_name=GSDRec.sol_name clipped
      let GSDArr[gcnt].sol_url=GSDRec.sol_url clipped
      let GSDArr[gcnt].comp_name=GSDRec.comp_name clipped
#      display "gcnt:", gcnt, " 1st time:", GSDArr[gcnt].comp_name clipped, "<br>"
   else
      if( GSDRec.sol_id = GSDArr[gcnt].sol_id )then
         let GSDArr[gcnt].comp_name=GSDArr[gcnt].comp_name clipped, "<br>", GSDRec.comp_name clipped
      else
         let gcnt=gcnt+1
         initialize GSDArr[gcnt].* to NULL

         let GSDArr[gcnt].sol_id=GSDRec.sol_id clipped
         let GSDArr[gcnt].sol_name=GSDRec.sol_name clipped
         let GSDArr[gcnt].sol_url=GSDRec.sol_url clipped
         let GSDArr[gcnt].comp_name=GSDRec.comp_name clipped
      end if  #same sol_id
   end if  #first time
end foreach

#display "gcnt:", gcnt, "<br>"
for i=1 to gcnt
   display "<tr>"
   display "<td>"
   display "<strong>", GSDArr[i].sol_name clipped, "</strong></td>"

   display "<td>"
   display "<strong>", GSDArr[i].comp_name clipped, "</strong></td>"

   display "<td>"
   display "<strong>", "<a href='http://www-304.ibm.com/partnerworld/gsd/solutiondetails.do?solution=", GSDArr[i].sol_id using "<<<<<<", "' target='_blank'>", GSDArr[i].sol_id clipped, "</a>", "</strong></td>"
#   display "<strong>", GSDRec.sol_url clipped, "</strong></td>"

   display "</tr>"
end for

display "</table>"

   display "<table align='center' border='0' width='744px'>"
   display "<br />"
#display "<tr>"

#   display "<br />"
end if  #secretVer

############################################
## Certifications (only for Secret pages)
############################################
#display "SECRETVER: ", secretVer 
if( secretVer )then
   display "<tr>"
   display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
   display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>C O V E R A G E - N O T E S</span></span></td>"
   display "</tr>"
   display "<tr>"
   display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
   display "<p>"
   display "&nbsp;</p>"

if( UpdateAllow )then
display "<FORM ID='desc'  ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit Note Change'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=511>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
   display "<TEXTAREA NAME='desc' rows='3' cols='100'>", URec.note clipped, "</TEXTAREA>"
   display "</FORM>"
else
   display  URec.note clipped
end if
   display "</tr>"
end if

if( secretVer or CtlRec.showcerts )then
   let G_CertCnt = GetCerts2( BRec.b_id, URec.ceid )
   display "<tr>"
   display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
   display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>C E R T I F I C A T I O N S</span></span></td>"
   display "</tr>"
   display "<tr>"
   display "<td colspan='3' style='text-align: center; vertical-align: middle'>"

   let showTableHeader = TRUE
   let lastRag = "<none>"

   for i = 1 to G_CertCnt 

      if( lastRag != CertArr[i].prod_group )then
         if( i>1 )then
            display "</table>"
            display "</td></tr>"
         end if
         display "<table align='center' border='0' width='700'>"
#         display "<tbody>"
         let cText = CertArr[i].prod_group clipped
#         let cText = CertArr[i].brand clipped, " - ", CertArr[i].prod_group clipped
         let cText = noSpaces(cText)
         call CertCount(URec.ceid, CertArr[i].prod_group ) returning Scnt, Tcnt
         display "<tr><td width='300'><a href='javascript:;' onClick=togglerows('", cText clipped, "');>", CertArr[i].prod_group clipped, "</a></td><td width='100'>Sales Certs: ", Scnt, "</td><td>Technical Certs: ", Tcnt, "</td></tr>"
#         display "<tr><td width='300'><a href='javascript:;' onClick=togglerows('", cText clipped, "');>", CertArr[i].prod_group clipped, " (",CertArr[i].brand clipped, ")","</a></td><td width='100'>Sales Certs: ", Scnt, "</td><td>Technical Certs: ", Tcnt, "</td></tr>"

         display "<tr id='", cText clipped, "' style='display:none'>"
         display "<td>"
         display "<table border='1'>"
         display "<tr>"
         display "<td class='centerText'; style='background-color: #add8e6'><strong>Product Group</strong></td>"
         display "<td class='centerText'; style='background-color: #add8e6'><strong>Brand</strong></td>"
         display "<td class='centerText'; style='background-color: #add8e6'><strong>Cert Type</strong></td>"
         display "<td class='centerText'; style='background-color: #add8e6'><strong>Cert Number</strong></td>"
         display "<td class='centerText'; style='background-color: #add8e6';width='300'><strong>Cert Description</strong></td>"
         display "<td class='centerText'; style='background-color: #add8e6';width='300'><strong>Sunset Date</strong></td>"
         display "<td class='centerText'; style='background-color: #add8e6'><strong># Certs</strong></td>"
         display "</tr>"
      end if

      display "<tr>"
#      display "<td style='text-align: center; vertical-align: middle;'>",CertArr[i].country clipped, "</td>"
      display "<td style='text-align: center; vertical-align: middle;'>",CertArr[i].prod_group clipped, "</td>"
      display "<td style='text-align: center; vertical-align: middle;'>",CertArr[i].brand clipped, "</td>"
      display "<td style='text-align: center; vertical-align: middle;'>",CertArr[i].cert_type clipped, "</td>"
      display "<td style='text-align: center; vertical-align: middle;'>",CertArr[i].cert_num clipped, "</td>"
      display "<td style='text-align: center; vertical-align: middle';width='300'>",CertArr[i].cert_desc clipped, "</td>"
      display "<td style='text-align: center; vertical-align: middle';width='300'>",CertArr[i].sunset_dt clipped, "</td>"
      display "<td style='text-align: center; vertical-align: middle;'>",CertArr[i].cnt clipped, "</td>"
#      display "<td style='text-align: center; vertical-align: middle;'>",CertArr[i].achieve_dt clipped, "</td>"
#      display "<td style='text-align: center; vertical-align: middle;'>",CertArr[i].sunset_dt clipped, "</td>"
      display "</tr>"

      let lastRAG = CertArr[i].prod_group
   
   end for

   display "</table>"
   display "</td></tr>"
   display "</table>"
   display "<br />"
   display "<p>"

   display "<table align='center' border='0' width='744px'>"
   display "<br />"

end if  #secretVer or CtlRec.showcerts

############################################
## Success and Reference Section
############################################
display "<tr>"
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>R E F E R E N C E S&nbsp; &amp;&nbsp; S U C C E S S&nbsp; S T O R I E S</span></span></td>"
display "</tr>"
display "<tr>"
display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
display "<p>"
display "&nbsp;</p>"

## check on accreditation and write message as appropriate
if( G_Acccnt > 0 )then   #AccRec.ceid = CLRec.CEID )then
   display "<p>"
   display "<span style='font-size:18px;'>", "<img src='/", IRec.i_id clipped, "/I/star1.jpg' width='61' heigth='51'/><em>", "** IBM Software Practice Accelerator: ACCREDITED ", G_AccList clipped,"</em></span></p>"
end if

## retrieve and display successes
let successCnt = GetSuccesses( URec.ceid )

# allow entry of a new record if in update mode
if( UpdateAllow )then
   display "<FORM ID='rss1' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Insert New Record'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=505>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
   display "You can ADD new rows here.</br>"
   display "Title: <INPUT NAME='s_title' TYPE=text SIZE=50>"
   display "  URL: <INPUT NAME='s_url' TYPE=text SIZE=100><br>"
   display "</FORM>"
end if

if( successCnt > 0)then
   if( UpdateAllow )then
      display "<FORM ID='rss2' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
      display "<INPUT TYPE=submit VALUE='Submit Changes'><br>"
      display "To DELETE a record, remove the Title for that record and pres Submit.<br />"
      display "To UPDATE a record, simply edit the text below and press Submit."
      display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=507>"
      display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"

   end if
   for i = 1 to successCnt
      if( UpdateAllow )then
         if( SuccessArr[i].s_title is not NULL )then
            display "<p>"
            display "Title: <INPUT NAME='s_title' TYPE=text SIZE=50 VALUE='", SuccessArr[i].s_title clipped, "'>"
            display "  URL: <INPUT NAME='s_url' TYPE=text SIZE=100 VALUE='", SuccessArr[i].s_link clipped, "'><BR>"
         end if
      else
         display "<p>"
         display "<span style='font-size:18px;'><a href='", SuccessArr[i].s_link clipped, "' target='_blank'>", SuccessArr[i].s_title clipped,"</a></span></p>"
      end if
   end for
   if( UpdateAllow )then
      display "</FORM>"
   end if
end if

display "<br />"
display "<p>"
display "&nbsp;</p>"
display "</td>"
display "</tr>"

############################################
## Industry Section
############################################
display "<tr>"
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>M A R K E T / I N D U S T R Y</span></span></td>"
display "</tr>"
display "<tr>"
display "<td colspan='3' style='text-align: center; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
display "<p>"
display "&nbsp;</p>"
if( UpdateAllow )then
   display "<FORM ID='ind' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit Market/Industry Changes'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=503>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
end if
display "<table align='center' border='1' height='60' width='641'>"
display "<tbody>"
display "<tr>"

{
for i = 1 to G_INDcnt
display "<td style='background-color: #add8e6'><strong>", INDArr[i].i_short clipped, "</strong></td>"
end for
display "</tr>"

display "<tr>"
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_eu is not null and URec.ind_eu != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>", "<INPUT NAME='", "ind_eu", "' VALUE='", URec.ind_eu, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_eu, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_eu", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"  
   end if  #UpdateAllow
end if  #eu

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_tel is not null and URec.ind_tel!= " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_tel", "' VALUE='", URec.ind_tel, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_tel, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_tel", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"  
   end if  #UpdateAllow
end if  #tel

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_me is not null and URec.ind_me != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_me", "' VALUE='", URec.ind_me, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_me, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_me", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #me

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_ret is not null and URec.ind_ret != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_ret", "' VALUE='", URec.ind_ret, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_ret, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_ret", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #ret

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_wd is not null and URec.ind_wd != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_wd", "' VALUE='", URec.ind_wd, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_wd, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_wd", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #wd

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_trans is not null and URec.ind_trans != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_trans", "' VALUE='", URec.ind_trans, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_trans, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_trans", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #trans

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_bank is not null and URec.ind_bank != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_bank", "' VALUE='", URec.ind_bank, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_bank, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_bank", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #bank

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_ins is not null and URec.ind_ins != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_ins", "' VALUE='", URec.ind_ins, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_ins, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_ins", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #ins

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_mfg is not null and URec.ind_mfg != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_mfg", "' VALUE='", URec.ind_mfg, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_mfg, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_mfg", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #mfg

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_gov is not null and URec.ind_gov != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_gov", "' VALUE='", URec.ind_gov, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_gov, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_gov", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #gov

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_education is not null and URec.ind_hl != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_education", "' VALUE='", URec.ind_education, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_education, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_education", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #education

display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_hl is not null and URec.ind_hl != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_hl", "' VALUE='", URec.ind_hl, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_hl, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_hl", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #hl


display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_cross is not null and URec.ind_cross != " ") then
   if( UpdateAllow )then
      display "background-color:00FF00'>",  "<INPUT NAME='", "ind_cross", "' VALUE='", URec.ind_cross, "'></td>"
   else
      display "background-color:00FF00'>", URec.ind_cross, "</td>"
   end if  #UpdateAllow
else
   if( UpdateAllow )then
      display "'><INPUT NAME='", "ind_cross", "' VALUE=''></td>"
   else
      display "'>&nbsp</td>"
   end if  #UpdateAllow
end if  #cross

display "</tr>"
display "</tbody>"
if( UpdateAllow )then
   display "</FORM>"
end if
display "</table>"
display "<br />"
display "<p>"

display "</td>"
display "</tr>"
}

############################################
## NEW Industry Section
############################################

call GetINDDetails()
let i = 1
let j = 1
while i <= G_INDcnt
   let newi = i
   let oMarket = INDArr[i].ig_name
   if( INDArr[i].i_name != "<none>" )then
      display "<tr><td colspan='6' style='text-align: center;background-color:", colorStr clipped, "'>", "<span style='color: ", textcolorStr clipped, "'>", INDArr[i].ig_name clipped, "</span></td></tr>"
   end if
      display "<tr>"
      while oMarket = INDArr[i].ig_name
         if( EUArr[i].e_name != "<none>" )then
            display "<td style='background-color: #add8e6'>"
            display "<strong>", INDarr[i].i_name clipped, "</strong></td>"
         end if
         let i = i + 1
      end while
   let j = i   #remember the new starting point to reset later

   display "</tr>"

   
   display "<tr>"
   let oMarket = INDArr[newi].ig_name
   while oMarket = INDArr[newi].ig_name
      if( INDArr[newi].i_name != "<none>" )then
         display "<td style='text-align: center; vertical-align: middle; "
         if( INDDetails[newi] ) then
#if( BRec.b_id="SE" or BRec.b_id="CU" or BRec.b_id="BU" )then
                  if (INDDetails[newi] > 0 )then
                     let color_idx = INDDetails[newi]+ 1
                  else
                     if( INDDetails[newi] = "Y" )then
                        let color_idx = 2
                     else
                        let color_idx = 1
                     end if
                  end if

            let buStr = INDDetails[newi]
#display "color_idx: ", color_idx, "<p>"
#display "newi: ", newi, "<p>"
#display "INDDetails[newi]: ", INDDetails[newi], "<p>"
#else
#            let buStr = BUText( INDDetails[newi] clipped )
#end if
#if( BRec.b_id = "SE" or BRec.b_id="CU" or BRec.b_id="BU" ) then
            display "background-color:",  colorArr[color_idx] clipped, "'>"
#else
#            display "background-color:00FF00'>"
#end if

               if( UpdateAllow )then
                  display "<INPUT NAME='", INDColNamesArr[ newi ].i_col clipped, "' VALUE=", buStr clipped,"><br>"
	       else
                  display buStr clipped
               end if

            display "</td>"
         else
            if( UpdateAllow )then
               display "'><INPUT NAME='", INDColNamesArr[ newi ].i_col clipped, "' VALUE=''><br></td>"
            else
               display "'>&nbsp;</td>"
            end if
	 end if  #if INDDetails[newi]
      end if  #if not <none>
      let newi = newi + 1
   end while

   display "</tr>"

   let i = j  #new starting point set above

end while

## display legend
display "<tr><td colspan='100'>* 4-", MasterRec.ind_4 clipped, ", 3-", MasterRec.ind_3 clipped, ", 2-", MasterRec.ind_2 clipped, ", 1/Y-", MasterRec.ind_1 clipped, ""
display "</td></tr>"

if( UpdateAllow )then
# provide empty entry for inserting

# close out the FORM
   display "</FORM>"
end if
display "</tbody>"
display "</table>"
display "<br />"
display "<p>"

## end of NEW Industry Section


############################################
## Activity Tracking Section
############################################
#if( CtlRec.showplanning and CLRec.CEID='18z7gkgl' )then
if( CtlRec.showplanning or (BRec.b_id='NC' and URec.ceid='18z7gkgl') )then
   display "<tr>"
   display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
   #display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
   display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>A C T I V I T Y&nbsp; &nbsp; T R A C K I N G</span></span></td>"
   display "</tr>"
   display "<tr>"
   display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
   display "<p>"
   display "&nbsp;</p>"

## select statements
let SQLStr1 = "select a.*, b.part_name from ", CtlRec.act_init_tab clipped," a, ", cov_tab clipped, " b where a.ceid='", CLRec.CEID clipped, "' and a.ceid=b.ceid "
let SQLStr2 = "select b.* from ", CtlRec.act_tab clipped, " b where b.ceid='", CLRec.CEID clipped, "' ",
              "and b.act_stat != 'A' ", 
              "order by b.act_st_dt "

if( UpdateAllow )then
   display "<FORM ID='actinit' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit Initiatives'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=751>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
end if

display "<table>"
prepare FCID from SQLStr1
execute FCID into ActInitRec.*, tmp_pname
#declare FCCurs cursor for FCID

display "<h2>", BRec.b_name clipped, " Activity Initiatives</h2>"
display "<table>"

let i=1
#foreach FCCurs into ActInitRec.*, tmp_pname
#   display
#           "<tr>",
#           "<th class='leftText'>Partner: ", tmp_pname clipped, " (", ActInitRec.ceid clipped, ")</td></tr>"
#   display "<tr></tr>"
display "<tr>"
display "<p>"
#   display
#           "<tr>",
#           "<th class='leftText' style='width: 300'>BP Initiative #1</th>",
#           "<th class='leftText' style='width: 300'>BP Initiative #2</th>",
#           "<th class='leftText' style='width: 300'>BP Initiative #3</th></tr>"
#
#   display "<tr><td>", ActInitRec.bp_init1 clipped, "</td>",
#           "<td>", ActInitRec.bp_init2 clipped, "</td>",
#           "<td>", ActInitRec.bp_init3 clipped, "</td></tr>"
   display "<tr></tr>"
   display "<tr><th style='width: 500'>BP Initiatives</th><th style='width: 500'>", BRec.b_name clipped, " Initiatives</th></tr>",
           "<tr><td class='centerText'>";
   if( UpdateAllow )then
      display "<INPUT NAME='bp_init1' SIZE='60' VALUE='", ActInitRec.bp_init1 clipped,"'>";
   else
      display ActInitRec.bp_init1 clipped;
   end if

   display "</td><td class='centerText'>"; 

   if( UpdateAllow )then
      display "<INPUT NAME='st_init1' SIZE='60' VALUE='", ActInitRec.st_init1 clipped,"'>";
   else
      display ActInitRec.st_init1 clipped;
   end if
   display "</td></tr>"

   display "<tr><td  class='centerText'>";
   if( UpdateAllow )then
      display "<INPUT NAME='bp_init2' SIZE='60' VALUE='", ActInitRec.bp_init2 clipped,"'>";
   else
      display ActInitRec.bp_init2 clipped;
   end if

   display "</td><td class='centerText'>";

   if( UpdateAllow )then
      display "<INPUT NAME='st_init2' SIZE='60' VALUE='", ActInitRec.st_init2 clipped,"'>";
   else
      display ActInitRec.st_init2 clipped;
   end if
   display "</td></tr>"

   display "<tr><td  class='centerText'>";
   if( UpdateAllow )then
      display "<INPUT NAME='bp_init3' SIZE='60' VALUE='", ActInitRec.bp_init3 clipped,"'>";
   else
      display ActInitRec.bp_init3 clipped;
   end if

   display "</td><td class='centerText'>";

   if( UpdateAllow )then
      display "<INPUT NAME='st_init3' SIZE='60' VALUE='", ActInitRec.st_init3 clipped,"'>";
   else
      display ActInitRec.st_init3 clipped;
   end if
   display "</td></tr>"
   display "</table>"
# close out the FORM
   display "</FORM>"

#   display "<tr><td class='centerText'>", ActInitRec.bp_init2 clipped, "</td><td class='centerText'>", ActInitRec.st_init2 clipped, "</td></tr>"
#   display "<tr><td class='centerText'>", ActInitRec.bp_init3 clipped, "</td><td class='centerText'>", ActInitRec.st_init3 clipped, "</td></tr>"

if( UpdateAllow )then
   display "<FORM ID='actvity' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit Activities'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=752>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
end if

#   display "<table>"
#   display "<tr></tr>"
#display SQLStr2
   prepare FC2ID from SQLStr2
   declare FC2Curs cursor for FC2ID
#   display "<tr></tr>"
   display
           "<table align='center' border='1' height='60' width='1000'><tr>",
           "<th class='leftText' style='width: 500'>Activity Name</th>",
           "<th class='leftText' style='width: 500'>Activity Description</th>",
           "<th class='leftText'>Activity Type</th>",
           "<th class='leftText' style='weidth: 500'>Associated Initiative</th>",
           "<th class='leftText'>Status Name</th>",
           "<th class='leftText'>Revenue ($k)</th>",
           "<th class='leftText' style='width: 75'>Start Date</th>",
           "<th class='leftText' style='width: 75'>End Date</th>",
           "<th class='leftText' style='width: 150'>IBM Owner</th>",
           "<th class='leftText' style='width: 150'>BP Owner</th><tr>"


   foreach FC2Curs into ActRec.*
      case ActRec.act_code
         when "D"
            let type_desc="Ecosystem Development"
         when "E"
            let type_desc="Enablement"
         when "M"
            let type_desc="Marketing"
         when "O"
            let type_desc="Opportunity Identification"
         when "P"
            let type_desc="Deal Progression"

      end case

      case ActRec.act_stat
         when "S"
            let stat_desc="Started"
         when "I"
            let stat_desc="In-Process"
         when "C"
            let stat_desc="Completed"
      end case

      display "<tr><td class='leftText' style='width: 500'>";
      if( UpdateAllow )then
#         display "<INPUT NAME='id' TYPE=hidden READONLY VALUE=", ActRec.act_sn, "><INPUT NAME='act_name' SIZE='60' VALUE='", ActRec.act_name clipped,"'>";
         display "<INPUT NAME='id' TYPE=hidden READONLY VALUE=", ActRec.act_sn, "><TEXTAREA NAME='act_name' rows='2' cols='30'>", ActRec.act_name clipped, "</TEXTAREA>"
#         display "<INPUT NAME='act_name' SIZE='60' VALUE='", ActRec.act_name clipped,"'>";
      else
         display ActRec.act_name clipped;
      end if
      display "</td>"

      display "<td class='leftText' style='width: 500'>";
      if( UpdateAllow )then
#         display "<INPUT NAME='act_desc' SIZE='60' VALUE='", ActRec.act_desc clipped,"'>";
         display "<TEXTAREA NAME='act_desc' rows='3' cols='30'>", ActRec.act_desc clipped, "</TEXTAREA>"

      else
         display ActRec.act_desc clipped;
      end if
      display "</td>"

      display "<td class='leftText' style='width: 500'>";
      if( UpdateAllow )then
         call ListBoxActType( ActRec.act_code )
      else
         display type_desc clipped
      end if
#      if( UpdateAllow )then
#     ma
#         display "<INPUT NAME='act_code' SIZE='60' VALUE='", ActRec.act_desc clipped,"'>";
#      else
#         display ActRec.act_desc clipped;
#      end if
      display "</td>"

      display "<td class='leftText' style='width: 500'>";
      if( UpdateAllow )then
         call ListBoxActInit( ActRec.act_init )
      else
         display ActRec.act_init clipped
      end if
      display "</td>"

#	      "<td style='width: 500'>",ActRec.act_init clipped, "</td>",

      display "<td class='leftText' style='width: 500'>";
      if( UpdateAllow )then
         call ListBoxActStatus( ActRec.act_stat )
      else
         display stat_desc clipped
      end if
      display "</td>"
#	      "<td>",stat_desc clipped, "</td>",

      display "<td class='leftText' style='width: 200'>";
      if( UpdateAllow )then
         display "<INPUT NAME='act_rev' SIZE='10' VALUE='", ActRec.act_rev clipped,"'>";
      else
         display ActRec.act_rev clipped;
      end if
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      if( UpdateAllow )then
         display "<INPUT NAME='act_st_dt' SIZE='10' VALUE='", ActRec.act_st_dt clipped,"'>";
      else
         display ActRec.act_st_dt clipped;
      end if
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      if( UpdateAllow )then
         display "<INPUT NAME='act_ed_dt' SIZE='10' VALUE='", ActRec.act_ed_dt clipped,"'>";
      else
         display ActRec.act_ed_dt clipped;
      end if
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      if( UpdateAllow )then
         display "<INPUT NAME='act_own_ibm' SIZE='25' VALUE='", ActRec.act_own_ibm clipped,"'>";
      else
         display ActRec.act_own_ibm clipped;
      end if
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      if( UpdateAllow )then
         display "<INPUT NAME='act_own_bp' SIZE='25' VALUE='", ActRec.act_own_bp clipped,"'>";
      else
         display ActRec.act_own_bp clipped;
      end if
      display "</td>"
      display "</tr>"

   end foreach


#end foreach

## show empty line for new data
   if( UpdateAllow )then
      display "<tr><td class='leftText' style='width: 500'>";
      display "<INPUT NAME='id' TYPE=hidden READONLY VALUE=0><TEXTAREA NAME='act_name' rows='2' cols='30'>(new record)</TEXTAREA>"
      display "</td>"

      display "<td class='leftText' style='width: 500'>";
      display "<TEXTAREA NAME='act_desc' rows='3' cols='30'></TEXTAREA>"
      display "</td>"

      display "<td class='leftText' style='width: 500'>";
      call ListBoxActType( "D" )
      display "</td>"

      display "<td class='leftText' style='width: 500'>";
      call ListBoxActInit( "" )
      display "</td>"

      display "<td class='leftText' style='width: 500'>";
      call ListBoxActStatus( "" )
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      display "<INPUT NAME='act_rev' SIZE='10' VALUE='0'>";
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      display "<INPUT NAME='act_st_dt' SIZE='10' VALUE=''>";
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      display "<INPUT NAME='act_ed_dt' SIZE='10' VALUE=''>";
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      display "<INPUT NAME='act_own_ibm' SIZE='25' VALUE=''>";
      display "</td>"

      display "<td class='leftText' style='width: 200'>";
      display "<INPUT NAME='act_own_bp' SIZE='25' VALUE=''>";
      display "</td>"
      display "</tr>"
   end if  #updateallow for blank line

   display "</table>"  #inner

# close out the FORM
   display "</FORM>"

   display "<br />"
   display "<p>"
   display "&nbsp;</p>"
   display "</td>"
   display "</tr>"
end if  #if showplanning


############################################
## Enterprise Unit Section
############################################
call GetEUDetails()
display "<tr>"
#display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>G E O G R A P H I E S</span></span></td>"
display "</tr>"
display "<tr>"
display "<td colspan='3' style='text-align: center; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"

## display headquarters
if( URec.hq is not NULL )then
   let stateStr = GetState( URec.hq clipped )
   if( stateStr is not NULL )then
      display "<em>Headquartered in ", stateStr clipped, "</em>"
   else
      display "<p>"
      display "&nbsp;</p>"
   end if
else
   display "<p>"
   display "&nbsp;</p>"
end if

## set up table for list of enterprise units
if( UpdateAllow )then
   display "<FORM ID='eu' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit Geography Changes'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=502>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
end if

display "<table align='center' border='1' height='60' width='641'>"
display "<tbody>"

## separate by regions
let i = 1
let j = 1

while i <= G_EUcnt
   let newi = i
   let oRegion = EUArr[i].e_region
   if( EUArr[i].e_name != "<none>" )then
      display "<tr><td colspan='6' style='text-align: center;background-color:", colorStr clipped, "'>", "<span style='color: ", textcolorStr clipped, "'>", EUArr[i].e_region clipped, "</span></td></tr>"
   end if
            if( G_eucontacts )then  #show contacts in region/eu section
               let G_ContactCnt = LoadContactArr2( URec.ceid, oRegion, ' ' )
               if( G_ContactCnt > 0 )then  #there are contacts to show
                  display "<tr><td colspan='6' style='text-align: center;'>", "<span style='color: ", textcolorStr clipped, "'>"

                  for c = 1 to G_ContactCnt
                     call ShowContactLine ( ContactArr[c].c_name )
                     call ShowContactLine ( ContactArr[c].c_title )
                     call ShowContactLine ( ContactArr[c].c_phone )
                     call ShowContactLine ( ContactArr[c].c_email )
                     display "<br \>"
                  end for
                  display "</span></td></tr>"
                end if   #there are contacts to show
            end if  #if G_eucontacts

      display "<tr>"
      while oRegion = EUArr[i].e_region
         if( EUArr[i].e_name != "<none>" )then
            display "<td style='background-color: #add8e6'>"
            display "<strong>", EUarr[i].e_name clipped, "</strong></td>"
         end if
         let i = i + 1
      end while
   let j = i   #remember the new starting point to reset later

   display "</tr>"

   
   display "<tr>"
   let oRegion = EUArr[newi].e_region
   while oRegion = EUArr[newi].e_region
      if( EUArr[newi].e_name != "<none>" )then
         display "<td style='text-align: center; vertical-align: middle; "
         if( EUDetails[newi] ) then
            let buStr = BUText( EUDetails[newi] clipped )
            display "background-color:00FF00'>"
            if( G_eucontacts )then  #show contacts in region/eu section
               let G_ContactCnt = LoadContactArr2( URec.ceid, oRegion, EUArr[newi].e_name )
               if( G_ContactCnt > 0 )then  #there are contacts to show
                  for c = 1 to G_ContactCnt
                     call ShowContactLine ( ContactArr[c].c_name )
                     call ShowContactLine ( ContactArr[c].c_title )
                     call ShowContactLine ( ContactArr[c].c_phone )
                     call ShowContactLine ( ContactArr[c].c_email )
                     display "<br \>"
		  end for
	       else  #no contacts
                  if( UpdateAllow )then
                     display "<INPUT NAME='", EUColNamesArr[ newi ].colname clipped, "' VALUE=", buStr clipped,"><br>"
                  else
                     display buStr clipped
                  end if
	       end if   #there are contacts to show
            else
               if( UpdateAllow )then
                  display "<INPUT NAME='", EUColNamesArr[ newi ].colname clipped, "' VALUE=", buStr clipped,"><br>"
               else
                  display buStr clipped
               end if
            end if  # if G_eucontacts

            display "</td>"
         else
            if( UpdateAllow )then
               display "'><INPUT NAME='", EUColNamesArr[ newi ].colname clipped, "' VALUE=''><br></td>"
            else

               display "'>&nbsp;</td>"
            end if
	 end if  #if EUDetails[newi]
      end if  #if not <none>
      let newi = newi + 1
   end while

   display "</tr>"

{
            if( G_eucontacts )then  #show contacts in region/eu section
               let G_ContactCnt = LoadContactArr2( URec.ceid, oRegion, ' ' )
               if( G_ContactCnt > 0 )then  #there are contacts to show
                  display "<tr><td colspan='6' style='text-align: center;'>", "<span style='color: ", textcolorStr clipped, "'>"

                  for c = 1 to G_ContactCnt
                     call ShowContactLine ( ContactArr[c].c_name )
                     call ShowContactLine ( ContactArr[c].c_title )
                     call ShowContactLine ( ContactArr[c].c_phone )
                     call ShowContactLine ( ContactArr[c].c_email )
                     display "<br \>"
                  end for
                  display "</span></td></tr>"
                end if   #there are contacts to show
            end if
}

   let i = j  #new starting point set above

end while

if( UpdateAllow )then
# provide empty entry for inserting

# close out the FORM
   display "</FORM>"
end if
display "</tbody>"
display "</table>"
display "<br />"
display "<p>"

############################################
## VAD Section
############################################
if( VRec.v_id != "na" )then
   display "<span style='font-size:18px';>VAD: <a href='", VRec.v_link clipped, "' target='_blank'>", VRec.v_name clipped, "</span> </a></p><br \>"
else
   display "<span style='font-size:18px';>VAD: ", VRec.v_name clipped, "</span> </p><br \>"
end if
display "</td>"
display "</tr>"

############################################
## Contact Section
############################################
display "<tr>"

## partner contacts
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>C O N T A C T S</span></span></td>"
display "</tr>"
display "<tr>"
display "<td style='text-align: center; width: 421px'>"
display "<div>"
display "<em><span style='font-size: 14pt'>Primary Sales Contact</span></em></div>"

display "<div>"
display "<div style='position: absolute; left: -2.94%'>"
display "&nbsp;</div>"
display "</div>"
display "<div>"
#let UpdateAllow = FALSE
if( UpdateAllow )then
   display "<FORM ID='cont' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit Contact Changes'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=504>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
end if

   display "<span style='font-size: 22px'><span style='font-size: 18px'>"
   if( URec.p_name is not null ) then
      if( UpdateAllow )then
         display "Name: <INPUT NAME='p_name' TYPE=text VALUE='", URec.p_name clipped, "' size='30'></span></span></div>"
      else
         display URec.p_name clipped, "</span></span></div>"
      end if
   else
      if( UpdateAllow )then
         display "Name: <INPUT NAME='p_name' TYPE='text' size='30'></span></span></div>"
      else
         display "</span></span></div>"
      end if
   end if

   if( URec.p_title is not null ) then
      display "<div>"
      display "<div style='position: absolute; left: -2.94%'>"
      display "&nbsp;</div>"
      display "</div>"
      display "<div>"
      display "<span style='font-size: 14px'><span style='font-size: 14px'>"
      if( UpdateAllow )then
         display "Title: <INPUT NAME='p_title' TYPE='text' VALUE='", URec.p_title clipped, "' size='30'></span></span></div>"
      else
         display URec.p_title clipped, "</span></span></div>"
      end if
   else
      if( UpdateAllow )then
         display "Title: <INPUT NAME='p_title' TYPE='text' size='30'>"
      end if
   end if
   
   display "<div>"
   display "<div style='position: absolute; left: -2.94%'>"
   display "&nbsp;</div>"
   display "</div>"
   display "<div>"
   if( URec.p_phone is not null ) then
      if( UpdateAllow )then
         display  "Phone: <INPUT NAME='p_phone' TYPE='text' VALUE='", URec.p_phone clipped, "' size='30'></span></span></div>"
      else
         display URec.p_phone clipped, "</span></span></div>"
      end if
   else
      if( UpdateAllow )then
         display  "Phone: <INPUT NAME='p_phone' TYPE='text' size='30'><span></span></div>"
      else
         display "&nbsp;</span></span></div>"
      end if
   end if
   
   display "<div>"
   display "<span style='font-size: 18px'><span style='color: rgb(89,89,89)'>"
   if( URec.p_email is not null ) then
      if( UpdateAllow )then
         display  "Email: <INPUT NAME='p_email' TYPE='email' VALUE='", URec.p_email clipped, "' size='30'></span></span></div>"
      else
         display "<a href='mailto:", URec.p_email clipped, "' style='position: relative' target='_blank'>", URec.p_email clipped, "</a></span></span></div>"
      end if
   else
      if( UpdateAllow )then
         display  "Email: <INPUT NAME='p_email' TYPE='email' size='30'></span></span></div>"
      else
         display "&nbsp;</span></span></div>"
      end if
   end if
   display "</td>"

   if( UpdateAllow )then
      display "</FORM>"
   end if
{
else
   display "<span style='font-size: 22px'><span style='font-size: 18px'>"
   if( URec.p_name is not null ) then
      display URec.p_name clipped, "</span></span></div>"
   else
      display "&nbsp;</span></span></div>"
   end if

   if( URec.p_title is not null ) then
      display "<div>"
      display "<div style='position: absolute; left: -2.94%'>"
      display "&nbsp;</div>"
      display "</div>"
      display "<div>"
      display "<span style='font-size: 14px'><span style='font-size: 14px'>"
      display URec.p_title clipped, "</span></span></div>"
   end if
   
   display "<div>"
   display "<div style='position: absolute; left: -2.94%'>"
   display "&nbsp;</div>"
   display "</div>"
   display "<div>"
   if( URec.p_phone is not null ) then
      display URec.p_phone clipped, "</span></span></div>"
   else
      display "&nbsp;</span></span></div>"
   end if
   
   display "<div>"
   display "<span style='font-size: 18px'><span style='color: rgb(89,89,89)'>"
   if( URec.p_email is not null ) then
      display "<a href='mailto:", URec.p_email clipped, "' style='position: relative' target='_blank'>", URec.p_email clipped, "</a></span></span></div>"
   else
      display "&nbsp;</span></span></div>"
   end if
   display "</td>"

end if  #if UpdateAllow 
}

## ibm contacts
display "<td style='text-align: center; width: 421px; vertical-align: middle'>"
display "</td>"
display "<td class='separator'; style='text-align: center; width: 421px'>"
display "<div>"

#if( ShowCrossFlg )then
#   display "<em><span style='font-size: 14pt'>", bprStr clipped, ": </span></em>"
#   display "<a href='", SSRRec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", SSRRec.r_name clipped, "</span></a></div>"
#   display "<div>"
#   display "&nbsp;</div>"
#else
   display "<em><span style='font-size: 14pt'>", bprStr clipped, "</span></em></div>"
   display "<div>"
   display "<a href='", SSRRec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", SSRRec.r_name clipped, "</span></a></div>"
   display "<div>"
   display "&nbsp;</div>"
#end if  #ShowCrossFlg

# TSS
#if( ShowCrossFlg )then
#   display "<div>"
#   display "<em><span style='font-size: 14pt'>", tssStr  clipped, ": </span></em>"
#   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
#   if( CTP1Rec.r_name = "Open" )then
#      display "<span style='font-size: 18px'>", CTP1Rec.r_name clipped, "</span></div>"
#   else
#      display "<a href='", CTP1Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP1Rec.r_name clipped, "</span></a></div>"
#   end if
#else
   display "<div>"
   display "<em><span style='font-size: 14pt'>", tssStr  clipped, "</span></em></div>"
#1st TSS
if( (NOT CtlRec.onlyshowaca) or SecretVer )then
   display "<div>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
   if( CTP1Rec.r_name = "Open" )then
      display "<span style='font-size: 18px'>", CTP1Rec.r_name clipped, "</span></div>"
   else
      if( CTP1Rec.r_name is not NULL and CTP1Rec.r_name != ' ')then
         display "<a href='", CTP1Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP1Rec.r_name clipped, "</span></a> "
         if( NOT CtlRec.expandbrand )then
            if( CtlRec.showctplabel )then
               if( CTPArr[1] = URec.lead )then
                  let tmpStr = "(", CTPArr[1] clipped, ") TSS Lead"
               else
                  let tmpStr = "(", CTPArr[1] clipped, ")"
               end if
            else
               let tmpStr = " "
            end if
            display tmpStr clipped
         end if
         display "</div>"
      end if
     end if
#2nd TSS
   display "<div>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
   if( CTP2Rec.r_name = "Open" )then
      display "<span style='font-size: 18px'>", CTP2Rec.r_name clipped, "</span></div>"
   else
      if( CTP2Rec.r_name is not NULL and CTP2Rec.r_name != ' ')then
         display "<a href='", CTP2Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP2Rec.r_name clipped, "</span></a> "
         if( NOT CtlRec.expandbrand )then
            if( CtlRec.showctplabel )then
               if( CTPArr[2] = URec.lead )then
                  let tmpStr = "(", CTPArr[2] clipped, ") TSS Lead"
               else
                  let tmpStr = "(", CTPArr[2] clipped, ")"
               end if
            else
               let tmpStr = " "
            end if
            display tmpStr clipped
         end if
         display "</div>"
      end if
   end if
#3rd TSS
   display "<div>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
   if( CTP3Rec.r_name = "Open" )then
      display "<span style='font-size: 18px'>", CTP3Rec.r_name clipped, "</span></div>"
   else
      if( CTP3Rec.r_name is not NULL and CTP3Rec.r_name != ' ')then
         display "<a href='", CTP3Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP3Rec.r_name clipped, "</span></a> "
         if( NOT CtlRec.expandbrand )then
            if( CtlRec.showctplabel )then
               if( CTPArr[3] = URec.lead )then
                  let tmpStr = "(", CTPArr[3] clipped, ") TSS Lead"
               else
                  let tmpStr = "(", CTPArr[3] clipped, ")"
               end if
            else
               let tmpStr = " "
            end if
            display tmpStr clipped
         end if
         display "</div>"
      end if
    end if
#4th TSS
   display "<div>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
   if( CTP4Rec.r_name = "Open" )then
      display "<span style='font-size: 18px'>", CTP4Rec.r_name clipped, "</span></div>"
   else
      if( CTP4Rec.r_name is not NULL and CTP4Rec.r_name != ' ')then
         display "<a href='", CTP4Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP4Rec.r_name clipped, "</span></a> "
         if( NOT CtlRec.expandbrand )then
            if( CtlRec.showctplabel )then
               if( BRec.b_id = "AU" )then
                  let tmpStr = "(Exec ACA)"
               else
                  if( CTPArr[4] = URec.lead )then
                     let tmpStr = "(", CTPArr[4] clipped, ") TSS Lead"
                  else
                     let tmpStr = "(", CTPArr[4] clipped, ")"
                  end if
               end if  #if AU
            else
               let tmpStr = " "
            end if
            display tmpStr clipped
         end if
         display "</div>"
      end if
    end if
end if  #only show ACA
#5th TSS
   display "<div>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
   if( CTP5Rec.r_name = "Open" )then
      display "<span style='font-size: 18px'>", CTP5Rec.r_name clipped, "</span></div>"
   else
      if( CTP5Rec.r_name is not NULL and CTP5Rec.r_name != ' ')then
         display "<a href='", CTP5Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP5Rec.r_name clipped, "</span></a> "
         if( NOT CtlRec.expandbrand )then
            if( CtlRec.showctplabel )then
               if( CTPArr[5] = URec.lead )then
                  if( CtlRec.useaca )then
                     if( BRec.b_id = "AU" )then
                        let tmpStr = "(ACA) Lead"
                     else
                        let tmpStr = "(Primary ", CtlRec.tss_stext clipped, ")"
                     end if
                  else
                     let tmpStr = "(", CTPArr[5] clipped, ") TSS Lead"
                  end if
               else
                  if( CtlRec.useaca )then
                     if( BRec.b_id = "AU" )then
                        let tmpStr = "(ACA) Lead"
                     else
                        let tmpStr = "(Primary ", CtlRec.tss_stext clipped, ")"
                     end if
                  else
                     let tmpStr = "(", CTPArr[5] clipped, ")"
                  end if
               end if #ctp = lead
            else
               let tmpStr = " "
            end if  #showctplabel
            display tmpStr clipped
         end if
         display "</div>"
      end if
    end if
#end if
#end if

# cross-brand
if( CtlRec.showcrossflg )then
   call LoadCrossRec( URec.ceid )

#     get url for alliance_bpr
   if( G_CrossAvail and CtlRec.showalliance and CRec.alliance_bpr is not NULL and CRec.alliance_bpr != " " and CRec.alliance_bpr != "NA" )then
      let lstr = getRepLink(CRec.alliance_bpr)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", allianceBPRStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.alliance_bpr clipped, "</span></a></div>"
   end if  #G_CrossAvail - alliance_bpr

#     get url for alliance_ctp
   if( G_CrossAvail and CtlRec.showalliance and CRec.alliance_ctp is not NULL and CRec.alliance_ctp != " " and CRec.alliance_ctp != "NA" )then
      let lstr = getRepLink(CRec.alliance_ctp)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", allianceCTPStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.alliance_ctp clipped, "</span></a></div>"
   end if  #G_CrossAvail - alliance_ctp

#     get url for swita
   if( G_CrossAvail and CtlRec.showswita and CRec.swita is not NULL and CRec.swita != " " and CRec.swita != "NA" )then
      let lstr = getRepLink(CRec.swita)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", switaStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.swita clipped, "</span></a></div>"
   end if  #G_CrossAvail - swita

#     get url for spr
   if( G_CrossAvail and CtlRec.showspr and CRec.spr is not NULL and CRec.spr != " " and CRec.spr != "NA")then
      let lstr = getRepLink(CRec.spr)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", sprStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.spr clipped, "</span></a></div>"
   end if  #G_CrossAvail - spr

#     get url for spr_hw
   if( G_CrossAvail and CtlRec.showspr and CRec.spr_hw is not NULL and CRec.spr_hw != " " and CRec.spr_hw != "NA")then
      let lstr = getRepLink(CRec.spr_hw)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", sprHWStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.spr_hw clipped, "</span></a></div>"
   end if  #G_CrossAvail - spr_hw

#     get url for spr_power
   if( G_CrossAvail and CtlRec.showspr and CRec.spr_power is not NULL and CRec.spr_power != " " and CRec.spr_power != "NA")then
      let lstr = getRepLink(CRec.spr_power)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", sprHWPWStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.spr_power clipped, "</span></a></div>"
   end if  #G_CrossAvail - spr_hw

#     get url for pta  - this should be the same as ctp5 in coverage file so not shown here
{
   if( G_CrossAvail and CtlRec.showpta and CRec.pta is not NULL and CRec.pta != " " and CRec.pta != "NA")then
      let lstr = getRepLink(CRec.pta)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", ptaStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.pta clipped, "</span></a></div>"
   end if  #G_CrossAvail - pta
}
#     get url for pta_hw
   if( G_CrossAvail and CtlRec.showpta and CRec.pta_hw is not NULL and CRec.pta_hw != " " and CRec.pta_hw != "NA")then
      let lstr = getRepLink(CRec.pta_hw)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", ptaHWStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.pta_hw clipped, "</span></a></div>"
   end if  #G_CrossAvail - pta_hw

#   if( CtlRec.showextend_st )then

#     get url for flash
      if ( G_CrossAvail and CtlRec.showflash and CRec.flash is not NULL and CRec.flash != " " and CRec.flash != "NA" )then
         let lstr = getRepLink(CRec.flash)

#      display "<div>"
#      display "&nbsp;</div>"
         display "<div>"
         display "<em><span style='font-size: 14pt'>", "Flash", ": </span></em>"
	 display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
	 display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.flash clipped, "</span></a></div>"
       end if  #not null - flash
#   end if  #showextend_st

#     get url for PCR
   if( CtlRec.showpcr )then
#   if( G_CrossAvail and CtlRec.showpcr )then
      let pcrcnt=LoadPODArray(URec.ceid)
#      let pcrName = GetPCRName(URec.pod, URec.ceid)   #removed function

      for i=1 to pcrcnt
         if( PODArr[i].pcr is not NULL and PODArr[i].pcr != " " and PODArr[i].pcr != "NA")then
            let lstr = getRepLink(PODArr[i].pcr)

            display "<div>"
            display "&nbsp;</div>"
            display "<div>"
            display "<em><span style='font-size: 14pt'>", pcrStr  clipped, ": </span></em>"
            display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
            if( lstr != " " and lstr is not null )then
               display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", PODArr[i].pcr clipped, "</span></a></div>"
            else   #null
               display PODArr[i].pcr clipped, "</div>"
            end if  #lstr is not null
         end if  #not null
      end for #for i=1 to pcrcnt

#     show POD name
      if( URec.pod is not null )then
         display "<div>"
         display "<em><span style='font-size: 14pt'>POD: </span></em>"
         display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
         display "<span style='font-size: 18px'>", URec.pod clipped, "</span></div>"
      end if  #URec.pod is not null

   end if  #G_CrossAvail and showPCR

end if  #ShowCrossFlg

# cross-brand
{
#  get url for spr
   if( CRec.spr is not NULL and CRec.spr != " " and CRec.spr != "NA")then
	   let lstr = getRepLink(CRec.spr)

#      display "<div>"
#      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", "SPR", ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.spr clipped, "</span></a></div>"
   end if  #not null

#  get url for pta
   if( CRec.pta is not NULL and CRec.pta != " " and CRec.pta != "NA")then
      let lstr = getRepLink(CRec.pta)

#      display "<div>"
#      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", "PTA", ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.pta clipped, "</span></a></div>"
   end if  #not null
}

if( not CtlRec.showextend_st )then
   display "<div>"
   display "&nbsp;</div>"
end if  #CtlRec.showextend_st

display "</div>"
display "</div>"
display "</td>"
display "</tr>"

if( G_add_contacts)then
   if( G_eucontacts )then  #show contacts in region/eu section
      let G_ContactCnt = LoadContactArr2( URec.ceid, '<none>', '<none>' )
   else
      call LoadContactArr( URec.ceid )
   end if
 
   if( G_ContactCnt > 0 OR UpdateAllow )then
      display "<tr><td style='text-align: center; width: 421px'>"
      if( UpdateAllow )then
         display "<br>"
         display "<FORM ID='opc' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
         display "<INPUT TYPE=submit VALUE='Submit Other Contact Changes'><br>"
         display "To DELETE a record, remove the NAME for that record and press Submit.<br> "
         display "To UPDATE a record, simply edit the text below and press Submit.<br>"
         display "To ADD a record, simply enter the contact information in the blank section below and press Submit."
         display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=510>"
         display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
      end if


      display "<em><span style='font-size: 14pt'>Other Partner Contacts</span></em></div>"
      for c = 1 to G_ContactCnt
         if( UpdateAllow )then
            display "<br>NAME: <INPUT NAME='c_name' TYPE=text SIZE=30 VALUE='", ContactArr[c].c_name clipped, "'><br>"
         else
            if( ContactArr[c].c_name is not null ) then
               display "<div>"
               display "<span style='font-size: 22px'><span style='font-size: 18px'>"
               display ContactArr[c].c_name clipped, "</span></span></div>"
            else
               display "&nbsp;</span></span></div>"
            end if
          end if
   
         if( UpdateAllow )then
            display "TITLE: <INPUT NAME='c_title' TYPE=text SIZE=40 VALUE='", ContactArr[c].c_title clipped, "'><br>"
         else
            if( ContactArr[c].c_title is not null ) then
	    display "<div>"
               display "<div style='position: absolute; left: -2.94%'>"
               display "&nbsp;</div>"
               display "</div>"
               display "<div>"
               display "<span style='font-size: 14px'><span style='font-size: 14px'>"
               display ContactArr[c].c_title clipped, "</span></span></div>"
            end if
         end if

         if( UpdateAllow )then
            display "PHONE: <INPUT NAME='c_phone' TYPE=text SIZE=30 VALUE='", ContactArr[c].c_phone clipped, "'><br>"
         else
            if( ContactArr[c].c_phone is not null ) then
               display "<div>"
               display "<div style='position: absolute; left: -2.94%'>"
               display "&nbsp;</div>"
               display "</div>"
               display "<div>"
               display ContactArr[c].c_phone clipped, "</span></span></div>"
            end if
         end if

         if( UpdateAllow )then
            display "EMAIL: <INPUT NAME='c_phone' TYPE=text SIZE=50 VALUE='", ContactArr[c].c_email clipped, "'><br>"
         else
            if( ContactArr[c].c_email is not null ) then
               display "<div>"
               display "<span style='font-size: 18px'><span style='color: rgb(89,89,89)'>"
               display "<a href='mailto:", ContactArr[c].c_email clipped, "' style='position: relative' target='_blank'>", ContactArr[c].c_email clipped, "</a></span></span></div>"
            end if
         end if
{
         if( UpdateAllow )then
            display "REGION: <INPUT NAME='c_region' TYPE=text SIZE=50 VALUE='", ContactArr[c].e_region clipped, "'><br>"
         else
            if( ContactArr[c].e_region is not null ) then
               display "<div>"
               display "<div style='position: absolute; left: -2.94%'>"
               display "&nbsp;</div>"
               display "</div>"
               display "<div>"
               display ContactArr[c].e_region clipped, "</span></span></div>"
            end if
         end if

         if( UpdateAllow )then
            display "ENTERPRISE UNIT: <INPUT NAME='c_region' TYPE=text SIZE=50 VALUE='", ContactArr[c].e_name clipped, "'><br>"
         else
            if( ContactArr[c].e_name is not null ) then
               display "<div>"
               display "<div style='position: absolute; left: -2.94%'>"
               display "&nbsp;</div>"
               display "</div>"
               display "<div>"
               display ContactArr[c].e_name clipped, "</span></span></div>"
            end if
         end if
}
         if( UpdateAllow )then
#display "e_region: ", ContactArr[c].e_region
            call ListBoxRegion( ContactArr[c].e_region )
            call ListBoxEUS( ContactArr[c].e_region, ContactArr[c].e_name )
         end if
         display "<br \>"
      end for

      if( UpdateAllow )then
         display "<br>NAME: <INPUT NAME='c_name' TYPE=text SIZE=30 VALUE=''><br>"
         display "TITLE: <INPUT NAME='c_title' TYPE=text SIZE=40 VALUE=''><br>"
         display "PHONE: <INPUT NAME='c_phone' TYPE=text SIZE=30 VALUE=''><br>"
         display "EMAIL: <INPUT NAME='c_phone' TYPE=text SIZE=50 VALUE=''><br>"
         call ListBoxRegion( '')
         call ListBoxEUS( '', '')
      end if
      display "</td></tr>"

      if( UpdateAllow )then
         display "</FORM>"
      end if
   end if  #G_ContactCnt > 0 
end if

if( URec.updtime is not NULL) then
   display "<tr><td></td><td></td><td>Updated: ", URec.updtime, "</td></tr>"
end if
display "<tr>"
display "<td style='width: 421px'>"
display "&nbsp;</td>"
display "<td style='width: 191px'>"
display "&nbsp;</td>"
display "<td style='width: 115px'>"
display "&nbsp;</td>"
display "</tr>"
display "</tbody>"
display "</table>"
display "<br />"
display "<div>"
display "<span style='visibility: hidden'><span style='font-size: 78%'><span style='position: absolute; left: -2.94%'><span style='color: #7889fb'>–</span></span></span></span></div>"
display "<div>"
display "<span style='font-size: 78%'><span style='position: absolute; left: -2.65%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></div>"
display "<div>"
display "<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -2.65%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span></div>"
display "</div>"
display "<p dir='ltr'>"
display "&nbsp;</p>"
end foreach


## allow edit of misc fields
if( UpdateAllow )then
   display "<FORM ID='eu' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit Changes Below'>"
   display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=506>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
   display "HQ: <INPUT NAME='hq' SIZE=2 VALUE=", URec.hq clipped,"><br>"
   call ListBoxSegment( URec.part_type )
#   display "SEGMENT: <SELECT NAME='part_type'><OPTION SELECTED>", URec.part_type clipped,"</SELECT><br>"
#   display "SEGMENT: <INPUT NAME='part_type' SIZE=1 VALUE=", URec.part_type clipped,"><br>"
   call ListBoxReseller( URec.reseller )
#   display "RESELLER CODE (Reseller, Not): <SELECT NAME='reseller'><OPTION SELECTED>", URec.reseller clipped, "<OPTION>N</SELECT><br>"
#   display "RESELLER CODE (R-Reseller, N-Not (N will remove from Matrix): <INPUT NAME='reseller' SIZE=1 VALUE=", URec.reseller clipped,"><br>"
   call ListBoxVAD( URec.vad )
#   display "VAD: <INPUT NAME='vad' VALUE=", URec.vad clipped,"><br>"
#   call ListBoxPOD( URec.pod )
   display "URL: <INPUT NAME='url' SIZE=50 VALUE=", URec.url clipped,"><br>"
   display "PartnerWorld Profile URL: <INPUT NAME='pwp' SIZE=100 VALUE=", URec.pwp clipped,"><br>"
#   display "Hunter? : <INPUT NAME='hunter' VALUE='", URec.hunter clipped,"'><br>"
   call ListBoxHunter( URec.hunter )
#   display "Commercial? : <INPUT NAME='commercial' VALUE='", URec.commercial clipped,"'><br>"
   call ListBoxCommercial( URec.commercial )
   call ListBoxEnterprise( URec.enterprise )
   call ListBoxIndustry( URec.industry )
   call ListBoxLAP( URec.lap )
   call ListBoxDFM( URec.dfm )
   call ListBoxPartnersWell( URec.partners_well )
   display "Other Focus Area #1: <INPUT NAME='focus1' VALUE='", URec.focus1 clipped,"'><br>"
   display "Other Focus Area #2: <INPUT NAME='focus2' VALUE='", URec.focus2 clipped,"'><br>"
   display "Other Focus Area #3: <INPUT NAME='focus3' VALUE='", URec.focus3 clipped,"'><br>"
   call ListBoxSSR( URec.ssr )
#   display "BPR: <INPUT NAME='ssr' SIZE=30 VALUE='", URec.ssr clipped,"'><br>"

   let ctp_cnt = LoadUnitBrand( BRec.b_id )
   if( BRec.b_id="ES" )then
      call ListBoxCTPall( 1, URec.ctp1 )
      call ListBoxCTPall( 2, URec.ctp2 )
      call ListBoxCTPall( 3, URec.ctp3 )
      call ListBoxCTPall( 4, URec.ctp4 )
      call ListBoxCTPall( 5, URec.ctp5 )
  
   else
      call ListBoxCTP1( URec.ctp1 )
      call ListBoxCTP2( URec.ctp2 )
      call ListBoxCTP3( URec.ctp3 )
      call ListBoxCTP4( URec.ctp4 )
      call ListBoxCTP5( URec.ctp5 )
   end if  #not ESS
#   display "TSS #1 (", UnitBrandArr[1].b_id clipped, "): <INPUT NAME='ctp1' SIZE=30 VALUE='", URec.ctp1 clipped,"'><br>"
#   display "TSS #2 (",  UnitBrandArr[2].b_id clipped, "): <INPUT NAME='ctp2' SIZE=30 VALUE='", URec.ctp2 clipped,"'><br>"
#   display "TSS #3 (",  UnitBrandArr[3].b_id clipped, "): <INPUT NAME='ctp3' SIZE=30 VALUE='", URec.ctp3 clipped,"'><br>"
#   display "TSS #4 (",  UnitBrandArr[4].b_id clipped, "): <INPUT NAME='ctp4' SIZE=30 VALUE='", URec.ctp4 clipped,"'><br>"
#   display "TSS #5 (",  UnitBrandArr[5].b_id clipped, "): <INPUT NAME='ctp5' SIZE=30 VALUE='", URec.ctp5 clipped,"'><br>"
   display "</FORM>"
end if

if( UpdateAllow )then
   if( CtlRec.showextend_st AND (CtlRec.coverextend_tab is not NULL and CtlRec.coverextend_tab != " " ))then
      display "<FORM ID='eu' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
      display "<INPUT TYPE=submit VALUE='Submit Changes Below'>"
      display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=512>"
      display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
      if( CtlRec.coverextend_tab is not NULL and CtlRec.coverextend_tab != " " )then
         
#         if( CtlRec.showflash )then
#            call ListBoxFlash( CRec.flash )
#         end if
         if( CtlRec.showspr )then
            call ListBoxSPR( CRec.spr )
            call ListBoxSPRHW( CRec.spr_hw )
            call ListBoxSPRPower( CRec.spr_power )
         end if
         if( CtlRec.showpta )then
            call ListBoxPTAHW( CRec.pta_hw )
         end if
## PCR SHOULD BE UPDATED IN POD TABLE NOT CROSS TABLE
#         if( CtlRec.showpcr )then
#            call ListBoxPCR( CRec.pcr )
#         end if
         if( CtlRec.showzrep )then
            call ListBoxzRep( CRec.zrep )
         end if
      end if
      display "</FORM>"
   end if
end if  #updateAllow - form 512

if( UpdateAllow )then
   if( CtlRec.showcrossflg AND (CtlRec.coverextend_tab is not NULL and CtlRec.coverextend_tab != " " ))then
      display "<FORM ID='eu' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
      display "<INPUT TYPE=submit VALUE='Submit Changes Below'>"
      display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=513>"
      display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
      if( CtlRec.coverextend_tab is not NULL and CtlRec.coverextend_tab != " " )then
         if( CtlRec.showswita )then
            call ListBoxSWITA( CRec.swita )
         end if
      end if
      display "</FORM>"
   end if
end if   #updateAllow - form 513

if( UpdateAllow )then
   if( URec.reseller =  'G' AND CtlRec.showalliance AND (CtlRec.coverextend_tab is not NULL and CtlRec.coverextend_tab != " " ))then
      display "<FORM ID='eu' ACTION='/cgi-bin/updRec", BRec.b_id clipped, ".ksh' method='post'>"
      display "<INPUT TYPE=submit VALUE='Submit Changes Below'>"
      display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=514>"
      display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
      if( CtlRec.coverextend_tab is not NULL and CtlRec.coverextend_tab != " " )then
         if( CtlRec.showalliance )then
            call ListBoxAllianceBPR( CRec.alliance_bpr )
            call ListBoxAllianceCTP( CRec.alliance_ctp )
         end if
      end if
      display "</FORM>"
   end if
end if   #updateAllow - form 514


if( UpdateAllow )then
   display "<HR>"
   display "EDIT EACH SECTION ONE AT A TIME AND PRESS Submit ABOVE THAT SECTION TO SAVE, THEN MOVE TO ANOTHER SECTION AND REPEAT."
   display "<HR>"
   display "<HR>"
end if

call ShowVer( 1 )

if (not UpdateAllow )then
   display "<FORM ID='upd' ACTION='/cgi-bin/setupUpd", BRec.b_id clipped, ".ksh'>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", URec.ceid clipped,"><br>"
   display "EMAIL (required to update): <INPUT NAME='yname' TYPE=email size=20 required autocomplete='on'>"
   display "PIN (required to update): <INPUT NAME='yid' TYPE=password size=8 required>"
   display "<INPUT TYPE=submit VALUE='UPDATE THIS PARTNER'>"
   display "</FORM>"
end if

if( secretVer )then
   display "<FORM ID='addBP' ACTION='/cgi-bin/addBP", BRec.b_id clipped, ".ksh'>"
   display "EMAIL (required to add): <INPUT NAME='yname' TYPE=email size=20 required autocomplete='on'>"
#   display "PIN (required to add): <INPUT NAME='yid' TYPE=password size=8 required>"
   display "CEID: <INPUT NAME='ceid' TYPE=text SIZE='15' required>"
   display "Partner Name: <INPUT NAME='part_name' TYPE=text SIZE='40' required>"
   display "<INPUT TYPE=submit VALUE='ADD PARTNER'>"
   display "</FORM>"

end if

end main

function GetSuccesses( in_ceid )
define
   in_ceid like success_ws.ceid,
   i smallint,
   SQLStr char(256)

   let i = 0
   let SQLStr = "select a.s_title, a.s_link from success_", BRec.b_id clipped, " a where a.ceid='", in_ceid clipped, "'"
   prepare GSID from SQLStr
   declare GSCurs cursor for GSID
   foreach GSCurs into SuccessArr[i+1].*
      let i = i + 1
   end foreach

    return i
end function

function BUText( in_bu )
define
   in_bu char(1),
   retStr char(2)

if( in_bu = "H" )then
   let retStr = "HQ"
else
   let retStr = in_bu
end if

return retStr

end function

function ShowOtherBrands( inBrand, inceid )
define
   inBrand like brands.b_id,      #current brand
   inceid like coverage_ws.ceid   #current CEID

   call LoadActiveBrands( 1, inceid )

   call ShowDetailSection ( inBrand, inceid )

end function #ShowOtherBrands


function ShowFocusArea( Str1, Str2, Str3 )
define
   Str1, Str2, Str3 like coverage_ws.focus1

if( (Str1 is NULL or Str1 = "" or Str1 = " ") AND
    (Str2 is NULL or Str2 = "" or Str2 = " ") AND
    (Str3 is NULL or Str3 = "" or Str3 = " ") )then
   return FALSE
else
   return TRUE
end if

end function  #ShowFocusArea

function GetRevDates()
define
    currYear smallint,
    prevYear smallint

   prepare GRD1 from 
      "select min(year(revdt)) from tbptv"
   execute GRD1 into prevYear
   prepare GRD2 from 
      "select max(year(revdt)) from tbptv"
   execute GRD2 into currYear

## TEMP
#   let prevYear=2014
#   let currYear=2015

   return prevYear, currYear
end function  #GetRevDates


function GetEUDetails()
   define
      i smallint,
      idx smallint

    for i = 1 to 30
       let idx = i     #EUDetails[ EUColNamesArr[i].idx ]

       case EUColNamesArr[ i ].colname

       when 'eu_pacificnw'
          if( URec.eu_pacificnw = 'Y' or URec.eu_pacificnw ='H' )then
             let EUDetails[ idx ] = URec.eu_pacificnw 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_northca'
          if( URec.eu_northca = 'Y' or URec.eu_northca ='H' )then
             let EUDetails[ idx ] = URec.eu_northca 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_southwest'
          if( URec.eu_southwest = 'Y' or URec.eu_southwest ='H' )then
             let EUDetails[ idx ] = URec.eu_southwest 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_northern'
          if( URec.eu_northern = 'Y' or URec.eu_northern ='H' )then
             let EUDetails[ idx ] = URec.eu_northern 
          else
             let EUDetails[ idx ] = ''
          end if

#       when 'eu_chicago'
#          if( URec.eu_chicago = 'Y' or URec.eu_chicago ='H' )then
#             let EUDetails[ idx ] = URec.eu_chicago 
#          else
#             let EUDetails[ idx ] = ''
#          end if

#       when 'eu_minn'
#          if( URec.eu_minn = 'Y' or URec.eu_minn ='H' )then
#             let EUDetails[ idx ] = URec.eu_minn 
#          else
#             let EUDetails[ idx ] = ''
#          end if

       when 'eu_plains'
          if( URec.eu_plains = 'Y' or URec.eu_plains ='H' )then
             let EUDetails[ idx ] = URec.eu_plains 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_heartland'
          if( URec.eu_heartland = 'Y' or URec.eu_heartland ='H' )then
             let EUDetails[ idx ] = URec.eu_heartland 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_texas'
          if( URec.eu_texas = 'Y' or URec.eu_texas ='H' )then
             let EUDetails[ idx ] = URec.eu_texas 
          else
             let EUDetails[ idx ] = ''
          end if

#       when 'eu_gulf'
#          if( URec.eu_gulf = 'Y' or URec.eu_gulf ='H' )then
#             let EUDetails[ idx ] = URec.eu_gulf 
#          else
#             let EUDetails[ idx ] = ''
#          end if

       when 'eu_garden'
          if( URec.eu_garden = 'Y' or URec.eu_garden ='H' )then
             let EUDetails[ idx ] = URec.eu_garden 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_northeast'
          if( URec.eu_northeast = 'Y' or URec.eu_northeast ='H' )then
             let EUDetails[ idx ] = URec.eu_northeast 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_ny'
          if( URec.eu_ny = 'Y' or URec.eu_ny ='H' )then
             let EUDetails[ idx ] = URec.eu_ny 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_delaware'
          if( URec.eu_delaware = 'Y' or URec.eu_delaware ='H' )then
             let EUDetails[ idx ] = URec.eu_delaware 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_potomac'
          if( URec.eu_potomac = 'Y' or URec.eu_potomac ='H' )then
             let EUDetails[ idx ] = URec.eu_potomac 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_carolinas'
          if( URec.eu_carolinas = 'Y' or URec.eu_carolinas ='H' )then
             let EUDetails[ idx ] = URec.eu_carolinas 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_midamerica'
          if( URec.eu_midamerica = 'Y' or URec.eu_midamerica ='H' )then
             let EUDetails[ idx ] = URec.eu_midamerica 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_ohio'
          if( URec.eu_ohio = 'Y' or URec.eu_ohio ='H' )then
             let EUDetails[ idx ] = URec.eu_ohio 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_southeast'
          if( URec.eu_southeast = 'Y' or URec.eu_southeast ='H' )then
             let EUDetails[ idx ] = URec.eu_southeast 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_sunshine'
          if( URec.eu_sunshine = 'Y' or URec.eu_sunshine ='H' )then
             let EUDetails[ idx ] = URec.eu_sunshine 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_fed'
          if( URec.eu_fed = 'Y' or URec.eu_fed ='H' )then
             let EUDetails[ idx ] = URec.eu_fed 
          else
             let EUDetails[ idx ] = ''
          end if

       when 'eu_ca'
          if( URec.eu_ca = 'Y' or URec.eu_ca ='H' )then
             let EUDetails[ idx ] = URec.eu_ca
          else
             let EUDetails[ idx ] = ''
          end if

#       when 'eu_ca_enterprise'
#          if( URec.eu_ca_enterprise = 'Y' or URec.eu_ca_enterprise ='H' )then
#             let EUDetails[ idx ] = URec.eu_ca_enterprise 
#          else
#             let EUDetails[ idx ] = ''
#          end if

#       when 'eu_ca_midmarket'
#          if( URec.eu_ca_midmarket = 'Y' or URec.eu_ca_midmarket ='H' )then
#             let EUDetails[ idx ] = URec.eu_ca_midmarket 
#          else
#             let EUDetails[ idx ] = ''
#          end if

#       when 'eu_fed_dod'
#          if( URec.eu_fed_dod = 'Y' or URec.eu_fed_dod ='H' )then
#             let EUDetails[ idx ] = URec.eu_fed_dod 
#          else
#             let EUDetails[ idx ] = ''
#          end if

       end case
    end for

end function  #GetEUDetails

function GetINDDetails()
   define
      i smallint,
      idx smallint

    for i = 1 to 30
       let idx = i    

       case INDColNamesArr[ i ].i_col

       when 'ind_eu'
          if( URec.ind_eu is not NULL and URec.ind_eu != ' ' )then
             let INDDetails[ idx ] = URec.ind_eu 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_me'
          if( URec.ind_me is not NULL and URec.ind_me != ' ' )then
             let INDDetails[ idx ] = URec.ind_me 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_tel'
          if( URec.ind_tel is not NULL and URec.ind_tel != ' ' )then
             let INDDetails[ idx ] = URec.ind_tel 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_csi'
          if( URec.ind_csi is not NULL and URec.ind_csi != ' ' )then
             let INDDetails[ idx ] = URec.ind_csi 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_consume'
          if( URec.ind_consume is not NULL and URec.ind_consume != ' ' )then
             let INDDetails[ idx ] = URec.ind_consume 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_ret'
          if( URec.ind_ret is not NULL and URec.ind_ret != ' ' )then
             let INDDetails[ idx ] = URec.ind_ret 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_trans'
          if( URec.ind_trans is not NULL and URec.ind_trans != ' ' )then
             let INDDetails[ idx ] = URec.ind_trans 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_bank'
          if( URec.ind_bank is not NULL and URec.ind_bank != ' ' )then
             let INDDetails[ idx ] = URec.ind_bank 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_finan'
          if( URec.ind_finan is not NULL and URec.ind_finan != ' ' )then
             let INDDetails[ idx ] = URec.ind_finan 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_ins'
          if( URec.ind_ins is not NULL and URec.ind_ins != ' ' )then
             let INDDetails[ idx ] = URec.ind_ins 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_defense'
          if( URec.ind_defense is not NULL and URec.ind_defense != ' ' )then
             let INDDetails[ idx ] = URec.ind_defense 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_auto'
          if( URec.ind_auto is not NULL and URec.ind_auto != ' ' )then
             let INDDetails[ idx ] = URec.ind_auto 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_chem'
          if( URec.ind_chem is not NULL and URec.ind_chem != ' ' )then
             let INDDetails[ idx ] = URec.ind_chem 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_elect'
          if( URec.ind_elect is not NULL and URec.ind_elect != ' ' )then
             let INDDetails[ idx ] = URec.ind_elect 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_indprod'
          if( URec.ind_indprod is not NULL and URec.ind_indprod != ' ' )then
             let INDDetails[ idx ] = URec.ind_indprod 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_gov'
          if( URec.ind_gov is not NULL and URec.ind_gov != ' ' )then
             let INDDetails[ idx ] = URec.ind_gov 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_education'
          if( URec.ind_education is not NULL and URec.ind_education != ' ' )then
             let INDDetails[ idx ] = URec.ind_education 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_hl'
          if( URec.ind_hl is not NULL and URec.ind_hl != ' ' )then
             let INDDetails[ idx ] = URec.ind_hl 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_lifesci'
          if( URec.ind_lifesci is not NULL and URec.ind_lifesci != ' ' )then
             let INDDetails[ idx ] = URec.ind_lifesci 
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_fed'
          if( URec.ind_fed is not NULL and URec.ind_fed != ' ' )then
             let INDDetails[ idx ] = URec.ind_fed
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_can'
          if( URec.ind_can is not NULL and URec.ind_can != ' ' )then
             let INDDetails[ idx ] = URec.ind_can
          else
             let INDDetails[ idx ] = ''
          end if

       when 'ind_cross'
          if( URec.ind_cross is not NULL and URec.ind_cross != ' ' )then
             let INDDetails[ idx ] = URec.ind_cross
          else
             let INDDetails[ idx ] = ''
          end if

       end case
    end for

end function  #GetINDDetails

function ShowContactLine( inText )
define
   inText char(80)

   if( inText is not null ) then
      display "<div>"
      display "<div style='position: absolute; left: -2.94%'>"
      display "&nbsp;</div>"
      display "</div>"
      display "<div>"
      display "<span style='font-size: 14px'><span style='font-size: 14px; color: rgb(0,0,0)'>"
      display inText clipped, "</span></span></div>"
end if


end function  #ShowContactLine


function ShowSkillsCurrentBrand2( in_type, inBrand, inbIdx)
define
   in_type smallint,
   inBrand like brands.b_id,
   inbIdx smallint,
   i,col_cnt,sidx smallint,
   skill_colorStr char(16),
   skill_colorStrL char(16),
   skill_textcolorStr char(16),
   skill_cat smallint,
   color_idx smallint,
tmpWrap smallint,  # to wrap at skill category - USED FOR TESTING
   nidx smallint,
   sStr char(128),
   bText like brands.b_name,  #brand long name
   cText, vText char(80)  #vText=visible text, cText=changed for internal HTML use

   call GetColor(BRec.b_id, 0,1) returning skill_colorStr, skill_textcolorStr
   let bText = GetBrandName( inBrand )
   let vText = bText clipped, " Skills"
   let cText = noSpaces(vText)

##    Detailed Skill Section - current brand
#display "Loading Skills: ", inBrand, "/", inbIdx
   call LoadSkillsU( inBrand, inbIdx )

#   display "<tbody>"

   display "<tr>"
{  now below the start of the table
   display "<td colspan='100' style='text-align: center; background-color: ", skill_colorStr clipped, "; width: 421px; vertical-align: middle'>"
   display "<span style='color:", skill_textcolorStr clipped, "'><span style='font-size: 22px'>", BRec.b_name clipped, " Detailed Skills</span></span></td>"
}
   display "</tr>"

#   display "&nbsp;</p>"

   if( in_type = 1 )then
      display "<table align='center' border='1' width='744px'>"
   else
      display "<table align='center' border='1' height='60' width='641'>"
   end if
   if( BRec.b_id="SU" )then
      let skill_colorStrL = "rgb(255,255,255)"
   end if
   display "<tr><td colspan='100' style='text-align: center; background-color: ", skill_colorStrL clipped, "; width: 421px; vertical-align: middle'><a href='javascript:;' onClick=togglerows('", cText clipped, "');>", "<span style='font-size: 22px'>", vText clipped, "</span></a><span style='font-size: 12px'>  (Click to expand)</span>"
   display "<span style='color:", skill_textcolorStr clipped, "'><span style='font-size: 22px'>", "</span></span></td></tr>"
display "<tr id='", cText clipped, "' style='display:none'>"
display "<td><table border='1'><tr>"

if( UpdateAllow )then
   display "<FORM ID='skills' ACTION='/cgi-bin/updSkills", BRec.b_id clipped, ".ksh' method='post'>"
   display "<INPUT TYPE=submit VALUE='Submit ",vText clipped," Changes'>"
   display "<INPUT NAME='ceid' TYPE=hidden READONLY VALUE=", CLRec.ceid clipped, ">"
   display "<INPUT NAME='brd' TYPE=hidden READONLY VALUE=", inBrand clipped, ">"
end if

## display category if requested
if( CtlRec.skill_cat )then
   let skill_cat = LoadSkillCat( inBrand )
   if( skill_cat > 0)then
      display "<tr>"
      for i = 1 to skill_cat
         let col_cnt = GetCatCnt( inBrand, SkillCatArr[i].c_id )
#  display "skill_cat: ", skill_cat, " col_cnt: ", col_cnt, " SkillCatArr[i].c_id: ", SkillCatArr[i].c_id
 
         display "<td colspan='", col_cnt using "<<", "' style='text-align: center; background-color: ", skill_colorStr clipped, "; width: 421px; vertical-align: middle'>"
         display "<span style='color:", skill_textcolorStr clipped, "'><span style='font-size: 18px'>", SkillCatArr[i].c_long clipped, "</span></span></td>"
         display "</tr>"

         display "<tr>"

         for sidx = 1 to SkillsMax
#display "Rec:", SkillArrU[inbIdx,sIdx].*
            if( SkillArrU[inbIdx,sidx].s_name != "NA" and SkillArrU[inbIdx,sidx].c_id = i )then
               display "<th class='centerText'; style='background-color: #add8e6'>"
               display "<strong>", SkillArrU[inbIdx,sidx].s_desc clipped, "</strong></th>"
            end if
         end for  #sidx 

         display "</tr>"

         display "<tr>"

         for sidx = 1 to SkillsMax
#display "BPSkillsArr for sidx: ", sidx, ":", BPSkillsArr[sidx]
            if( SkillArrU[inbIdx,sidx].s_name != "NA" and SkillArrU[inbIdx,sidx].c_id = i )then
               if( not G_DebugFlg )then 
                  if (BPSkillsArr[sidx] > 0 )then
                     let color_idx = BPSkillsArr[sidx] + 1
                  else
                     let color_idx = 1
                  end if
#   	          display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
                  let sStr = showSkillCell( sidx, BPSkillsArr[sidx], colorArr[color_idx] )
#                 display sStr clipped, "</td>"
                  display sStr clipped
               else
#                  let nidx = SkillArr[sidx].db_num
                  let nidx = SkillArrU[inbIdx,sidx].db_num
#if( BRec.b_id='ST') then display sidx, nidx end if   ##XXXXX
                  if (BPSkillsArr[sidx] > 0 )then
                     let color_idx = BPSkillsArr[nidx] + 1
                  else
                     let color_idx = 1
                  end if
#                 display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
                  let sStr = showSkillCell( sidx, BPSkillsArr[nidx], colorArr[color_idx] )
#                 display sStr clipped, "</td>"
                  display sStr clipped
               end if
#display i, BPSkillsArr[i], color_idx
           end if
       end for  #sidx=1 to SkillsMax
       display "</tr>"

     end for  #loop through skill cats
     display "</tr>"
  end if  #skill_cat > 0

else #not using skill categories
   for i = 1 to SkillsMax
      if( SkillArr[i].s_name != "NA" )then
         display "<th class='centerText'; style='background-color: #add8e6'>"
         display "<strong>", SkillArr[i].s_desc clipped, "</strong></th>"
         end if
   end for

   display "<tr>"

   for i = 1 to SkillsMax
      if( SkillArr[i].s_name != "NA" )then
       if( not G_DebugFlg )then 
        if (BPSkillsArr[i] > 0 )then
            let color_idx = BPSkillsArr[i] + 1
        else
            let color_idx = 1
        end if
#         display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
         let sStr = showSkillCell( i, BPSkillsArr[i], colorArr[color_idx] )
#         display sStr clipped, "</td>"
         display sStr clipped
       else
        let nidx = SkillArr[i].db_num
        if (BPSkillsArr[i] > 0 )then
            let color_idx = BPSkillsArr[nidx] + 1
        else
            let color_idx = 1
        end if
#         display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
         let sStr = showSkillCell( i, BPSkillsArr[nidx], colorArr[color_idx] )
#         display sStr clipped, "</td>"
         display sStr clipped
       end if
#display i, BPSkillsArr[i], color_idx
      end if
   end for
   display "</tr>"
end if  #skill_cat

## display legend
display "<tr><td colspan='100'>* 3-", MasterRec.top_msg clipped, ", 2-", MasterRec.middle_msg clipped, ", 1-", MasterRec.low_msg clipped, ""
if( GSkillDt is not NULL) then
   display "<span style='font-size: 10px'> (Last Updated: ", GSkillDt, ")</span>"
end if
display "</td></tr>"

if( UpdateAllow )then
   display "</FORM>"
end if

display "</tr></table>"

## display All Skills
#display "<tr><td colspan='100'>"
#display "<div style='text-align: center'>"
#display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-skills.html'>All Skills</a><br />"

#display "</tbody>"
display "</table>"

if( in_type = 1 )then
   display "<table align='center' border='0' width='744px'>"
   display "<br />"
end if

end function  #ShowSkillsCurrentBrand2

function ShowDetailSection ( inBrand, inceid )
define
   inBrand like brands.b_id,      #current brand
   inceid like coverage_ws.ceid   #current CEID

   display "<p>Details from Other Brands<br />"

         if( ProductionBrand[ brand_nc ] and inBrand != 'NC' )then
            call ShowDetailLine( "NC", inceid )
         end if
         if( ProductionBrand[ brand_au ] and inBrand != 'AU' )then
            call ShowDetailLine( "AU", inceid )
         end if
         if( ProductionBrand[ brand_su ] and inBrand != 'SU' )then
            call ShowDetailLine( "SU", inceid )
         end if
         if( ProductionBrand[ brand_bu ] and inBrand != 'BU' )then
            call ShowDetailLine( "BU", inceid )
         end if
         if( ProductionBrand[ brand_st ] and inBrand != 'ST' )then
            call ShowDetailLine( "ST", inceid )
         end if
         if( ProductionBrand[ brand_cu ] and inBrand != 'CU' )then
            call ShowDetailLine( "CU", inceid )
         end if
         if( ProductionBrand[ brand_es ] and inBrand != 'ES' )then
            call ShowDetailLine( "ES", inceid )
         end if
         if( ProductionBrand[ brand_wu ] and inBrand != 'WU' )then
            call ShowDetailLine( "WU", inceid )
         end if

end function  #ShowDetailSection

function ShowDetailLine( inBrand, inceid )
define
   inBrand like brands.b_id,    #current brand ID for this task
   inceid like coverage_ws.ceid, #current CEID
   Bdesc like brands.b_name,
   SQLStr char(128)

   let SQLStr = "select a.b_name from brands a where a.b_id='", inBrand clipped, "'"
   prepare SDL1ID from SQLStr
   execute SDL1ID into Bdesc

#display inBrand, inceid
   display "<a href='/cgi-bin/showNoHeader", inBrand clipped, ".ksh?", inceid clipped, "' target='_blank'>", Bdesc clipped, "</a><br />"
#   display "<a href='/", IRec.i_id clipped, "/", BrandArr[inBrandID].b_id clipped, "/P/", inceid clipped, "-nh.html' target='_blank'>", BrandArr[inBrandID].b_name clipped, "</a><br />"

end function  #ShowDetailLine
{
function ShowDetailLine( inBrandID, inceid )
define
   inBrandID like brands.b_ord,      #current brand ID
   inceid like coverage_ws.ceid   #current CEID

#display inBrandID, inceid
#   display "<a href='/", IRec.i_id clipped, "/", inBrandID clipped, "/P/", inceid clipped, "-nh.html' target='_blank'>", BrandArr[inBrandID].b_name clipped, "</a><br />"
   display "<a href='/", IRec.i_id clipped, "/", BrandArr[inBrandID].b_id clipped, "/P/", inceid clipped, "-nh.html' target='_blank'>", BrandArr[inBrandID].b_name clipped, "</a><br />"

end function  #ShowDetailLine
}
function GetCerts( inbrand, inceid )
define
   inbrand like brands.b_id,
   inceid like coverage_ws.ceid,
   SQLStr char(512),
   i smallint

   let i = 0

   let SQLStr = "select a.* from certs a, brand_certs b, brand_certs_det d where a.brand = b.bc_id and b.b_id = '", 
        inbrand clipped, "' and b.b_id = d.b_id and b.bc_id = d.bc_id and a.prod_group = d.rag ",
        " and a.ceid = '", inceid clipped, "' order by a.prod_group, a.cert_type, a.cert_desc"

   prepare GCID from SQLStr
   declare GCCurs cursor for GCID

   foreach GCCurs into CertArr[i+1].*
      if( i < CertMax )then
         let i = i + 1
      end if
  
   end foreach


   return i
   

end function  #GetCerts

function GetCerts2( inbrand, inceid )
define
   inbrand like brands.b_id,
   inceid like coverage_ws.ceid,
   SQLStr char(512),
   i smallint

   let i = 0

#   let SQLStr = "select  a.brand, a.prod_group, a.cert_type, a.cert_num, a.cert_desc, count(*) cnt from certs a, brand_certs b, brand_certs_det d where a.brand = b.bc_id ",
#        " and b.b_id = d.b_id and b.bc_id = d.bc_id and a.prod_group = d.rag ",
#        " and a.ceid = '", inceid clipped, "' group by 1,2,3,4,5 order by a.prod_group, a.cert_type, a.cert_desc"

   let SQLStr = "select  a.brand, a.prod_group, a.cert_type, a.cert_num, a.cert_desc, a.sunset_dt, count(*) cnt from certs a where a.ceid = '", inceid clipped, "' group by 2,3,4,5,6, 1 order by a.prod_group, a.cert_type, a.cert_desc, a.brand"

   prepare GCID2 from SQLStr
   declare GCCurs2 cursor for GCID2

   foreach GCCurs2 into CertArr[i+1].*
      if( i < CertMax )then
         let i = i + 1
      end if
  
   end foreach


   return i
   

end function  #GetCerts2
{
function noSpaces(inText)
define
   inText char(64),
   rtText char(64),
   i,l smallint

   let l = length(inText)

   for i = 1 to l
      if( inText[i] = ' ' )then
         let rtText[i]='_'
      else
         let rtText[i]=inText[i]
      end if
   end for

   return rtText

end function  #noSpaces
}
function CertCount( inceid, inrag )
define
   inceid like certs.ceid,
   inrag like certs.prod_group,
   sc, tc smallint,
   SQLStr char(512)
    
   let sc = 0
   let tc = 0

#   let SQLStr = "select count(*) cnt from certs a, brand_certs b, brand_certs_det d where a.brand = b.bc_id ",
#        " and b.b_id = d.b_id and b.bc_id = d.bc_id and a.prod_group = d.rag ",
#        " and a.ceid = '", inceid clipped, "' and a.prod_group = '", inrag clipped, "' ", 
#        " and a.cert_type = ? "

   let SQLStr = "select count(*) cnt from certs a where a.ceid = '", inceid clipped, "' and a.prod_group = '", inrag clipped, "' and a.cert_type = ? "
   prepare CC1 from SQLStr

   execute CC1 into sc using "Sales" #into sc
   execute CC1 into tc using "Technical" #into tc

   return sc, tc

end function  #CertCount

{
function showSkillCell( inIdx, colorStr )
define
   inIdx smallint,
   colorStr char(7),
   ret char(256)

   if( inIdx > 0 )then
      let ret = "<td class='centerText'; style='background-color: ", colorStr, "'><strong>", inIdx using "##", "</strong></td>"
   else
      let ret = "<td class='whiteText'; style='background-color: ", colorStr, "'>.</td>"
   end if
#display "inIdx:", inIdx
#display "colorStr:", colorStr
#display "RET: ", ret
   return ret

end function  #showSkillCell
}

function showSkillCell( sIdx, inVal, colorStr )
define
   sIdx smallint,
   inVal smallint,
   colorStr char(7),
   ret char(256)

   if( inVal > 0 )then
      if( UpdateAllow )then
         let ret = "<td class='centerText'; style='background-color: ", colorStr, "'><strong>", "<INPUT NAME='", sIdx using '<<', "' VALUE=", inVal using '##', "></strong></td>"
      else
         let ret = "<td class='centerText'; style='background-color: ", colorStr, "'><strong>", inVal using "##", "</strong></td>"
      end if
   else
      if( UpdateAllow )then
         let ret = "<td class='whiteText'; style='background-color: ", colorStr, "'><INPUT NAME='", sIdx using '<<', "' VALUE=></td>"
      else
         let ret = "<td class='whiteText'; style='background-color: ", colorStr, "'>.</td>"
      end if
   end if
#display "inVal:", inVal
#display "colorStr:", colorStr
#display "RET: ", ret
   return ret

end function  #showSkillCell

function showIndCell( sIdx, inVal, colorStr )
define
   sIdx smallint,
   inVal char(1),
   colorStr char(7),
   ret char(256)

   if( inVal > 0 )then
      if( UpdateAllow )then
         let ret = colorStr
      else
         let ret = colorStr
      end if
   else
      if( UpdateAllow )then
         let ret = colorStr
      else
         let ret = colorStr
      end if
   end if
#display "inVal:", inVal
#display "colorStr:", colorStr
#display "RET: ", ret
   return ret

end function  #showIndCell

function LoadUnitBrand( inUnit )
define
   inUnit char(2),
   SQLStr char(128),
   i smallint

let SQLStr = "select a.* from unit_brand a where a.u_id='", inUnit clipped, "' order by a.ordctp"
prepare LUBID from SQLStr
declare LUBCurs cursor for LUBID

let i = 0
foreach LUBCurs into tUnitBrandRec.*
   let ctpidx = tUnitBrandRec.ordctp
   let UnitBrandArr[ctpidx].* = tUnitBrandRec.*
   let i = i + 1
end foreach

return i

end function  #LoadUnitBrand


function ListBoxSegment( inSel )
define
   inSel char(1),
   sqlStr char(64),
   SegRec record like segmentation.*

   let sqlStr = "select a.* from segmentation a where a.seg_id is not null"
   prepare LBSID from sqlStr
   declare LBSCurs cursor for LBSID

   display "SEGMENT: <SELECT NAME='part_type'>"

   foreach LBSCurs into SegRec.*
   if( inSel = SegRec.seg_id )then
      display "<OPTION SELECTED>", SegRec.seg_id clipped, " - ", SegRec.seg_name clipped
   else
      display "<OPTION>", SegRec.seg_id clipped, " - ", SegRec.seg_name clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxSegment


function ListBoxHunter( inSel )
define
   inSel char(1)

   if( CtlRec.showhunter )then
      display "HUNTER: <SELECT NAME='hunter'>"
#   else
#      display "<SELECT NAME='hunter' style='display: none;' >"
#   end if

   if( inSel = "N" )then
      display "<OPTION SELECTED>", "N - NOT Hunter"
   else
      display "<OPTION>",  "N - NOT Hunter"
   end if

   if( inSel = "Y" )then
      display "<OPTION SELECTED>", "Y - Hunter"
   else
      display "<OPTION>",  "Y - Hunter"
   end if

   display "</SELECT>"
   if( CtlRec.showhunter )then
      display "<br>"
   end if
end if  #showhunter
end function  #ListBoxHunter


function ListBoxCommercial( inSel )
define
   inSel char(1)

   if( CtlRec.showcommercial )then
      display "COMMERCIAL FOCUS: <SELECT NAME='commercial'>"
#   else
#      display "<SELECT NAME='commercial' style='display: none;'>"
#   end if

   if( inSel = "N" )then
      display "<OPTION SELECTED>", "N - NOT Commercial Segment"
   else
      display "<OPTION>",  "N - NOT Commercial Segment"
   end if

   if( inSel = "Y" )then
      display "<OPTION SELECTED>", "Y - Commercial Segment"
   else
      display "<OPTION>",  "Y - Commercial Segment"
   end if

   display "</SELECT>"
   if( CtlRec.showcommercial )then
      display "<br>"
   end if
end if  #showcommercial
end function  #ListBoxCommercial

function ListBoxEnterprise( inSel )
define
   inSel char(1)

   if( CtlRec.showenterprisealign )then
      display "ENTERPRISE FOCUS: <SELECT NAME='enterprise'>"
#   else
#      display "<SELECT NAME='enterprise' style='display: none;'>"
#   end if

   if( inSel = "N" )then
      display "<OPTION SELECTED>", "N - NOT Enterprise Segment"
   else
      display "<OPTION>",  "N - NOT Enterprise Segment"
   end if

   if( inSel = "Y" )then
      display "<OPTION SELECTED>", "Y - Enterprise Segment"
   else
      display "<OPTION>",  "Y - Enterprise Segment"
   end if

   display "</SELECT>"
   if( CtlRec.showenterprisealign )then
      display "<br>"
   end if
end if  #showenterprisealign

end function  #ListBoxEnterprise

function ListBoxIndustry( inSel )
define
   inSel char(1)

   if( CtlRec.showindustryalign )then
      display "INDUSTRY FOCUS: <SELECT NAME='industry'>"
#   else
#      display "<SELECT NAME='industry' style='display: none;'>"
#   end if

   if( inSel = "N" )then
      display "<OPTION SELECTED>", "N - NOT Industry Segment"
   else
      display "<OPTION>",  "N - NOT Industry Segment"
   end if

   if( inSel = "Y" )then
      display "<OPTION SELECTED>", "Y - Industry Segment"
   else
      display "<OPTION>",  "Y - Industry Segment"
   end if

   display "</SELECT>"
   if( CtlRec.showindustryalign )then
      display "<br>"
   end if
end if  #showindustryalign
end function  #ListBoxIndustry

function ListBoxLAP( inSel )
define
   inSel char(1)

   if( CtlRec.showlap )then
      display "LAP: <SELECT NAME='lap'>"
#   else
#      display "<SELECT NAME='lap' style='display: none;'>"
#   end if

   if( inSel = "N" )then
      display "<OPTION SELECTED>", "N - NOT LAP "
   else
      display "<OPTION>",  "N - NOT LAP"
   end if

   if( inSel = "Y" )then
      display "<OPTION SELECTED>", "Y - LAP"
   else
      display "<OPTION>",  "Y - LAP"
   end if

   display "</SELECT>"
   end if

   if( CtlRec.showlap )then
      display "<br>"
   end if


end function  #ListBoxLAP

function ListBoxDFM( inSel )
define
   inSel char(1)

   if( CtlRec.showdfm )then
      display "DFM: <SELECT NAME='dfm'>"
#   else
#      display "<SELECT NAME='dfm' style='display: none;'>"
#   end if

   if( inSel = "N" )then
      display "<OPTION SELECTED>", "N - NOT DFM "
   else
      display "<OPTION>",  "N - NOT DFM"
   end if

   if( inSel = "Y" )then
      display "<OPTION SELECTED>", "Y - DFM"
   else
      display "<OPTION>",  "Y - DFM"
   end if

   display "</SELECT>"
   end if

   if( CtlRec.showdfm )then
      display "<br>"
   end if


end function  #ListBoxDFM

function ListBoxPartnersWell( inSel )
define
   inSel char(1)

   if( CtlRec.showpartnerswell )then
      display "Partners Well with OTHER Partners: <SELECT NAME='partners_well'>"
#   else
#      display "<SELECT NAME='partners_well' style='display: none;'>"
#   end if

   if( inSel = "N" )then
      display "<OPTION SELECTED>", "N - NOT Partnering Well"
   else
      display "<OPTION>",  "N - NOT Partnering Well"
   end if

   if( inSel = "Y" )then
      display "<OPTION SELECTED>", "Y - Partners Well"
   else
      display "<OPTION>",  "Y - Partners Well"
   end if

   display "</SELECT>"
#   if( CtlRec.showpartnerswell )then
      display "<br>"
   end if

end function  #ListBoxPartnersWell

function ListBoxReseller( inSel )
define
   inSel char(1)

   display "RESELLER CODE: <SELECT NAME='reseller'>"

   if( inSel = "R" )then
      display "<OPTION SELECTED>", "R - Reseller"
   else
      display "<OPTION>",  "R - Reseller"
   end if

   if( inSel = "E" )then
      display "<OPTION SELECTED>", "E - ESA"
   else
      display "<OPTION>",  "E - ESA"
   end if

   if( inSel = "G" )then
      display "<OPTION SELECTED>", "G - GSI"
   else
      display "<OPTION>",  "G - GSI"
   end if

   if( inSel = "V" )then
      display "<OPTION SELECTED>", "V - VAD"
   else
      display "<OPTION>",  "V - VAD"
   end if

   if( inSel = "N" )then
      display "<OPTION SELECTED>", "N - NOT Covered"
   else
      display "<OPTION>",  "N - NOT Covered"
   end if

   if( inSel = "X" )then
      display "<OPTION SELECTED>", "X - NOT PARTNER"
   else
      display "<OPTION>",  "X - NOT PARTNER"
   end if

   display "</SELECT><br>"
end function  #ListBoxReseller

{
function ListBoxVAD( inSel )
define
   inSel like coverage_au.vad,
   sqlStr char(64),
   VADRec record like vads.*

   let sqlStr = "select a.* from vads a "
   prepare LBVID from sqlStr
   declare LBVCurs cursor for LBVID

   display "VAD: <SELECT NAME='vad'>"

   foreach LBVCurs into VADRec.*
   if( inSel = VADRec.v_id )then
      display "<OPTION SELECTED>", VADRec.v_id clipped
   else
      display "<OPTION>", VADRec.v_id clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxVAD
}

function ListBoxSSR( inSel )
define
   inSel like coverage_au.ssr,
   sqlStr char(64),
   tssr like coverage_au.ssr

   let sqlStr = "select unique a.ssr from ", cov_tab clipped, " a order by 1"
   prepare LBSSRID from sqlStr
   declare LBSSRCurs cursor for LBSSRID

   display "BPR: <SELECT NAME='ssr'>"

   foreach LBSSRCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxSSR


function ListBoxFlash( inSel )
define
   inSel like cross.flash,
   sqlStr char(64),
   tssr like cross.flash

   let sqlStr = "select unique a.flash from ", CtlRec.coverextend_tab clipped, " a order by 1"
   prepare LBFLAID from sqlStr
   declare LBFLACurs cursor for LBFLAID

   display "FLASH Rep: <SELECT NAME='flash'>"

   foreach LBFLACurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxFlash

function ListBoxSPR( inSel )
define
   inSel like cross.spr,
   sqlStr char(64),
   tssr like cross.spr

   let sqlStr = "select unique a.spr from ", CtlRec.coverextend_tab clipped, " a order by 1"
   prepare LBSPRID from sqlStr
   declare LBSPRCurs cursor for LBSPRID

   display "SPR Rep: <SELECT NAME='spr'>"

   foreach LBSPRCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxSPR

function ListBoxSPRHW( inSel )
define
   inSel like cross.spr_hw,
   sqlStr char(64),
   tssr like cross.spr_hw

   let sqlStr = "select unique a.spr_hw from ", CtlRec.coverextend_tab clipped, " a order by 1"
   prepare LBSPRHWID from sqlStr
   declare LBSPRHWCurs cursor for LBSPRHWID

   display "SPR-HW Rep: <SELECT NAME='spr_hw'>"

   foreach LBSPRHWCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxSPRHW


function ListBoxSPRPower( inSel )
define
   inSel like cross.spr_power,
   sqlStr char(64),
   tssr like cross.spr_power

   let sqlStr = "select unique a.spr_power from ", CtlRec.coverextend_tab clipped, " a order by 1"
   prepare LBSPRPWID from sqlStr
   declare LBSPRPWCurs cursor for LBSPRPWID

   display "SPR-Power Rep: <SELECT NAME='spr_power'>"

   foreach LBSPRPWCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxSPRPower

function ListBoxPTAHW( inSel )
define
   inSel like cross.pta_hw,
   sqlStr char(64),
   tssr like cross.pta_hw

   let sqlStr = "select unique a.pta_hw from ", CtlRec.coverextend_tab clipped, " a order by 1"
   prepare LBPTAHWID from sqlStr
   declare LBPTAHWCurs cursor for LBPTAHWID

   display "PTA-HW Rep: <SELECT NAME='pta_hw'>"

   foreach LBPTAHWCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxPTAHW
{
function ListBoxPCR( inSel )
define
   inSel like cross.pcr,
   sqlStr char(64),
   tssr like cross.pcr

   let sqlStr = "select unique a.pcr from cross a order by 1"
   prepare LBPCRID from sqlStr
   declare LBPCRCurs cursor for LBPCRID

   display "PCR Rep: <SELECT NAME='pcr'>"

   foreach LBPCRCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxPCR
}
function ListBoxzRep( inSel )
define
   inSel like cross.pcr,
   sqlStr char(64),
   tssr like cross.pcr

   let sqlStr = "select unique a.zrep from cross a order by 1"
   prepare LBzRepID from sqlStr
   declare LBzRepCurs cursor for LBzRepID

   display "zRep Rep: <SELECT NAME='zrep'>"

   foreach LBzRepCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxzRep

function ListBoxSWITA( inSel )
define
   inSel like cross.pcr,
   sqlStr char(64),
   tssr like cross.pcr

   let sqlStr = "select unique a.swita from cross a order by 1"
   prepare LBSWITAID from sqlStr
   declare LBSWITACurs cursor for LBSWITAID

   display "SCA Rep: <SELECT NAME='swita'>"

   foreach LBSWITACurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxSWITA

function ListBoxAllianceBPR( inSel )
define
   inSel like cross.alliance_bpr,
   sqlStr char(64),
   tssr like cross.alliance_bpr

   let sqlStr = "select unique a.alliance_bpr from cross a order by 1"
   prepare LBABPRID from sqlStr
   declare LBABPRCurs cursor for LBABPRID

   display "Alliance BPR: <SELECT NAME='alliance_bpr'>"

   foreach LBABPRCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxAllianceBPR

function ListBoxAllianceCTP( inSel )
define
   inSel like cross.alliance_ctp,
   sqlStr char(64),
   tssr like cross.alliance_ctp

   let sqlStr = "select unique a.alliance_ctp from cross a order by 1"
   prepare LBACTPID from sqlStr
   declare LBACTPCurs cursor for LBACTPID

   display "Alliance BPR: <SELECT NAME='alliance_ctp'>"

   foreach LBACTPCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxAllianceCTP

function ListBoxCTP1( inSel )
define
   inSel like coverage_au.ctp1,
   sqlStr char(64),
   tctp like coverage_au.ctp1

   let sqlStr = "select unique a.ctp1 from ", cov_tab clipped, " a order by 1"
   prepare LBCTP1ID from sqlStr
   declare LBCTP1Curs cursor for LBCTP1ID

   if( BRec.b_id = 'SU' )then
      display "TSS #1 (", UnitBrandArr[1].desc clipped, "): <SELECT NAME='ctp1' '", URec.ctp1 clipped,"'><br>"
   else
      display "TSS #1 (", UnitBrandArr[1].b_id clipped, "): <SELECT NAME='ctp1' '", URec.ctp1 clipped,"'><br>"
   end if

   foreach LBCTP1Curs into tctp
   if( inSel = tctp )then
      display "<OPTION SELECTED>", tctp clipped
   else
      display "<OPTION>",tctp clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxCTP1


function ListBoxCTP2( inSel )
define
   inSel like coverage_au.ctp2,
   sqlStr char(64),
   tctp like coverage_au.ctp2

   let sqlStr = "select unique a.ctp2 from ", cov_tab clipped, " a order by 1"
   prepare LBCTP2ID from sqlStr
   declare LBCTP2Curs cursor for LBCTP2ID

   if( BRec.b_id = 'SU' )then
      display "TSS #2 (", UnitBrandArr[2].desc clipped, "): <SELECT NAME='ctp2' '", URec.ctp2 clipped,"'><br>"
   else
      display "TSS #2 (", UnitBrandArr[2].b_id clipped, "): <SELECT NAME='ctp2' '", URec.ctp2 clipped,"'><br>"
   end if

   foreach LBCTP2Curs into tctp
   if( inSel = tctp )then
      display "<OPTION SELECTED>", tctp clipped
   else
      display "<OPTION>",tctp clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxCTP2


function ListBoxCTP3( inSel )
define
   inSel like coverage_au.ctp3,
   sqlStr char(64),
   tctp like coverage_au.ctp3

   let sqlStr = "select unique a.ctp3 from ", cov_tab clipped, " a order by 1"
   prepare LBCTP3ID from sqlStr
   declare LBCTP3Curs cursor for LBCTP3ID

   if( BRec.b_id = 'SU' )then
      display "TSS #3 (", UnitBrandArr[3].desc clipped, "): <SELECT NAME='ctp3' '", URec.ctp3 clipped,"'><br>"
   else
      display "TSS #3 (", UnitBrandArr[3].b_id clipped, "): <SELECT NAME='ctp3' '", URec.ctp3 clipped,"'><br>"
   end if

   foreach LBCTP3Curs into tctp
   if( inSel = tctp )then
      display "<OPTION SELECTED>", tctp clipped
   else
      display "<OPTION>",tctp clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxCTP3

function ListBoxCTP4( inSel )
define
   inSel like coverage_au.ctp4,
   sqlStr char(64),
   tctp like coverage_au.ctp4

   let sqlStr = "select unique a.ctp4 from ", cov_tab clipped, " a order by 1"
   prepare LBCTP4ID from sqlStr
   declare LBCTP4Curs cursor for LBCTP4ID

   if( BRec.b_id = 'SU' )then
      display "TSS #4 (", UnitBrandArr[4].desc clipped, "): <SELECT NAME='ctp4' '", URec.ctp4 clipped,"'><br>"
   else
      display "TSS #4 (", UnitBrandArr[4].b_id clipped, "): <SELECT NAME='ctp4' '", URec.ctp4 clipped,"'><br>"
   end if

   foreach LBCTP4Curs into tctp
   if( inSel = tctp )then
      display "<OPTION SELECTED>", tctp clipped
   else
      display "<OPTION>",tctp clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxCTP4

function ListBoxCTP5( inSel )
define
   inSel like coverage_au.ctp5,
   sqlStr char(64),
   tctp like coverage_au.ctp5

   let sqlStr = "select unique a.ctp5 from ", cov_tab clipped, " a order by 1"
   prepare LBCTP5ID from sqlStr
   declare LBCTP5Curs cursor for LBCTP5ID

   if( BRec.b_id = 'SU' )then
      display "TSS #5 (", UnitBrandArr[5].desc clipped, "): <SELECT NAME='ctp5' '", URec.ctp5 clipped,"'><br>"
   else
      display "TSS #5 (", UnitBrandArr[5].b_id clipped, "): <SELECT NAME='ctp5' '", URec.ctp5 clipped,"'><br>"
   end if

   foreach LBCTP5Curs into tctp
   if( inSel = tctp )then
      display "<OPTION SELECTED>", tctp clipped
   else
      display "<OPTION>",tctp clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxCTP5

function ListBoxCTPall( idx, inSel )
define
   idx smallint,
   inSel like coverage_au.ctp1,
   sqlStr char(512),
   tctp like coverage_au.ctp1

   let sqlStr = "select ctp1 from ", cov_tab clipped, 
                " union select ctp2 from ", cov_tab clipped, 
                " union select ctp3 from ", cov_tab clipped, 
                " union select ctp4 from ", cov_tab clipped, 
                " union select ctp5 from ", cov_tab clipped,
                " order by 1"
   prepare LBCTPaID from sqlStr
   declare LBCTPaCurs cursor for LBCTPaID

   display "TSS ", idx using '&', "(", UnitBrandArr[1].b_id clipped, "): <SELECT NAME='ctp", idx using '&', "' '", URec.ctp1 clipped,"'><br>"

   foreach LBCTPaCurs into tctp
   if( inSel = tctp )then
      display "<OPTION SELECTED>", tctp clipped
   else
      display "<OPTION>",tctp clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxCTPall


function ListBoxRegion( inSel )
define
   inSel like eus.e_region,
   sqlStr char(128),
   EUSRec record like eus.*

   let sqlStr = "select unique a.e_region from eus a where a.e_brand='", BRec.b_id clipped, "' order by 1 "
   prepare LBRegID from sqlStr
   declare LBRegCurs cursor for LBRegID

   display "REGION: <SELECT NAME='e_region'>"

   foreach LBRegCurs into EUSRec.e_region
   if( inSel = EUSRec.e_region )then
      display "<OPTION SELECTED>", EUSRec.e_region clipped
   else
      display "<OPTION>", EUSRec.e_region clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxRegion

function ListBoxEUS( inReg, inSel )
define
   inReg like eus.e_region,
   inSel like eus.e_name,
   sqlStr char(128),
   EUSRec record like eus.*,
   tregion like eus.e_region

   let sqlStr = "select unique a.e_region, a.e_name from eus a where a.e_brand='", BRec.b_id clipped, "' order by 1,2 "
   prepare LBEUSID from sqlStr
   declare LBEUSCurs cursor for LBEUSID

   display "EUS: <SELECT NAME='e_name'>"

   foreach LBEUSCurs into tregion, EUSRec.e_name
   if( inSel = EUSRec.e_name )then
      display "<OPTION SELECTED>", EUSRec.e_name clipped
   else
      display "<OPTION>", EUSRec.e_name clipped
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxEUS

function ListBoxActType( inSel )
define
   inSel like activity.act_code,
   sqlStr char(64),
   tctp like activity.act_code,
   tRec record like alu_type.*

   let sqlStr = "select unique a.* from alu_type a order by a.ord"
   prepare LBATID from sqlStr
   declare LBATCurs cursor for LBATID

   display "<SELECT NAME='at'><br>"

   foreach LBATCurs into tRec.*

   if( inSel = tRec.alu_code )then
      display "<OPTION SELECTED>", tRec.alu_code clipped, " - ", tRec.alu_type
   else
      display "<OPTION>", tRec.alu_code clipped, " - ", tRec.alu_type
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxActType

function ListBoxActStatus( inSel )
define
   inSel like activity.act_stat,
   sqlStr char(64),
   tctp like activity.act_stat,
   tRec record like alu_status.*

   let sqlStr = "select unique a.* from alu_status a order by a.ord"
   prepare LBASID from sqlStr
   declare LBASCurs cursor for LBASID

   display "<SELECT NAME='as'><br>"

   foreach LBASCurs into tRec.*

   if( inSel = tRec.alu_stat )then
      display "<OPTION SELECTED>", tRec.alu_stat clipped, " - ", tRec.alu_stat_desc
   else
      display "<OPTION>", tRec.alu_stat clipped, " - ", tRec.alu_stat_desc
   end if
   
   end foreach

   display "</SELECT><br>"
end function  #ListBoxActStatus

function ListBoxActInit( inSel )
define
   inSel like act_initiative.bp_init1,
   sqlStr char(512),
   tctp like act_initiative.bp_init1,
   tRec record like act_initiative.*,
   init_avail smallint

   let init_avail=FALSE
   let sqlStr = "select unique a.* from ", CtlRec.act_init_tab clipped, " a where a.ceid='", URec.ceid clipped, "'"
   prepare LBATIID from sqlStr
   execute LBATIID into tRec.*


   display "<SELECT NAME='ati'><br>"

   if( tRec.bp_init1 is not null )then
      let init_avail=TRUE
      if( inSel = tRec.bp_init1 )then
         display "<OPTION SELECTED>", tRec.bp_init1 clipped
      else
         display "<OPTION>", tRec.bp_init1 clipped
      end if
   end if

   if( tRec.bp_init2 is not null )then
      let init_avail=TRUE
      if( inSel = tRec.bp_init2 )then
         display "<OPTION SELECTED>", tRec.bp_init2 clipped
      else
         display "<OPTION>", tRec.bp_init2 clipped
      end if
   end if

   if( tRec.bp_init3 is not null )then
      let init_avail=TRUE
      if( inSel = tRec.bp_init3 )then
         display "<OPTION SELECTED>", tRec.bp_init3 clipped
      else
         display "<OPTION>", tRec.bp_init3 clipped
      end if
   end if

   if( tRec.st_init1 is not null )then
      let init_avail=TRUE
      if( inSel = tRec.st_init1 )then
         display "<OPTION SELECTED>", tRec.st_init1 clipped
      else
         display "<OPTION>", tRec.st_init1 clipped
      end if
   end if

   if( tRec.st_init2 is not null )then
      let init_avail=TRUE
      if( inSel = tRec.st_init2 )then
         display "<OPTION SELECTED>", tRec.st_init2 clipped
      else
         display "<OPTION>", tRec.st_init2 clipped
      end if
   end if

   if( tRec.st_init3 is not null )then
      let init_avail=TRUE
      if( inSel = tRec.st_init3 )then
         display "<OPTION SELECTED>", tRec.st_init3 clipped
      else
         display "<OPTION>", tRec.st_init3 clipped
      end if
   end if

## put in default of NONE if there are no initiatives
   if( not init_avail )then
      display "<OPTION SELECTED>NONE"
   end if

   display "</SELECT><br>"
end function  #ListBoxActInit

function inSVP( inComp )
define
   inComp like competency.comp_name,
   i smallint,
   retVal smallint

   let retVal = FALSE
#display "G_SVPinfocnt: ", G_SVPinfocnt
   for i = 1 to G_SVPinfocnt
#display "inComp:", inComp clipped
#display "CVR:", SVPInfoArr[i].prod_grp_desc clipped
#display "SVP_NAME:", SVPInfoArr[i].svp_name clipped

      if( inComp = SVPInfoArr[i].comp_name )then
         let retVal = TRUE
      end if
   end for
   
   return retVal

end function  #inSVP

function inComp( inComp )
define
   inComp like competency.comp_name,
   i smallint,
   retVal smallint,
   idx smallint

   let retVal = FALSE
   let idx = 0
#display "G_SVPinfocnt: ", G_SVPinfocnt
   for i = 1 to G_COMPcnt
#display "inComp:", inComp clipped
#display "SVP:", SVPInfoArr[i].prod_grp_desc clipped
#display "SVP_NAME:", SVPInfoArr[i].svp_name clipped

      if( inComp = CompArr[i].comp_name )then
         let retVal = TRUE
         let idx = i
      end if
   end for
   
   return retVal, idx

end function  #inComp


function AddPlus( inStr )
define
   inStr char(100),
   i,l smallint

   let l=length(inStr)

   for i=1 to l
      if( inStr[i]=" " )then
         let inStr[i]="+"
      end if
   end for

   return inStr

end function  #AddPlus

function LoadTargets( inCEID ) 
define
   inCEID like target.t_ceid,
   TrgRec record like target.*,
   SQLStr char(512)

   let SQLStr = "select a.* from target a where a.t_ceid='", inCEID clipped, "'"
   prepare LTID from SQLStr
   execute LTID into TrgRec.*

   return TrgRec.*

end function  #LoadTargets
