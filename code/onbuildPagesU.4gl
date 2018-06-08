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

globals "globals.4gl"

define
   SuccessArr array[40] of 
      record
         s_title like success_ws.s_title,
         s_link like success_ws.s_link
      end record,
   EUDetails array[30] of char(1),
   CTPArr array[10] of char(2)
   

main

define
    SSRRec record like reps.*,
    CTP1Rec record like reps.*,
    CTP2Rec record like reps.*,
    CTP3Rec record like reps.*,
    CTP4Rec record like reps.*,
    CTP5Rec record like reps.*,
    VRec record like vads.*,
    i,j,newi,c smallint,
    oRegion like eus.e_region,
    successCnt smallint,
    qtrStr char(512),
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
    tidx, SkilledYN smallint,
    tmpStr char(32)

call ReadCmdLn( "nbuildPagesU", 5 )
call ProcCmdLn( "nbuildPagesU" )
let showHeader = arg_val(5)
let secretVer = FALSE

if( showHeader > 0 )then
#   if( showHeader > 1 and NOT RevBox )then   #(only generate for brands not showing revenue)
   if( showHeader > 1 )then   
      let secretVer = TRUE
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

   call ShowTitle( showHeader )
   display " "

#display qtrStr
prepare QID from qtrStr
declare ACurs cursor for QID

foreach ACurs into URec.*, SSRRec.*, CTP1Rec.*, CTP2Rec.*, CTP3Rec.*, CTP4Rec.*, CTP5Rec.*, VRec.*

#   let ARec.ceid = URec.ceid
#   let ARec.vad = URec.vad
#   let ARec.hq = URec.hq
#   let ARec.part_type = URec.part_type
#   let ARec.reseller = URec.reseller
#   let ARec.part_name = URec.part_name
#   let ARec.ssr = URec.ssr
{
   case BRec.b_id
     when "AU"
      case URec.lead 
         when "IM" 
            let ARec.ctp = URec.ctp1
         when "EM" 
            let ARec.ctp = URec.ctp2
         when "BA" 
            let ARec.ctp = URec.ctp3
         otherwise
            if( URec.ctp1 is not null )then 
               let ARec.ctp=URec.ctp1
            else
               if( URec.ctp2 is not null )then 
                  let ARec.ctp=URec.ctp2
               else
                  if( URec.ctp3 is not null )then 
                     let ARec.ctp=URec.ctp3
                  end if
               end if
            end if
      end case
     when "SU"
      case URec.lead 
         when "WS" 
            let ARec.ctp = URec.ctp1
         otherwise
            if( URec.ctp1 is not null )then 
               let ARec.ctp=URec.ctp1
            else
               if( URec.ctp2 is not null )then 
                  let ARec.ctp=URec.ctp2
               else
                  if( URec.ctp3 is not null )then 
                     let ARec.ctp=URec.ctp3
                  end if
               end if
            end if
      end case
   end case
}
#   let ARec.eu_pacificnw = URec.eu_pacificnw
#   let ARec.eu_northca = URec.eu_northca
#   let ARec.eu_southwest = URec.eu_southwest
#   let ARec.eu_chicago = URec.eu_northern
#   let ARec.eu_plains = URec.eu_plains
#   let ARec.eu_heartland = URec.eu_heartland
#   let ARec.eu_texas = URec.eu_texas
#   let ARec.eu_midamerica = URec.eu_midamerica
#   let ARec.eu_ohio = URec.eu_ohio
#   let ARec.eu_southeast = URec.eu_southeast
#   let ARec.eu_sunshine = URec.eu_sunshine
#   let ARec.eu_northeast = URec.eu_northeast
#   let ARec.eu_garden = URec.eu_garden
#   let ARec.eu_delaware = URec.eu_delaware
#   let ARec.eu_potomac = URec.eu_potomac
#   let ARec.eu_carolinas = URec.eu_carolinas
#   let ARec.eu_ca_midmarket = URec.eu_ca
#   let ARec.eu_fed_dod = URec.eu_fed
#   let ARec.ind_eu = URec.ind_eu
#   let ARec.ind_tel = URec.ind_tel
#   let ARec.ind_me = URec.ind_me
#   let ARec.ind_ret = URec.ind_ret
#   let ARec.ind_wd = URec.ind_wd
#   let ARec.ind_trans = URec.ind_trans
#   let ARec.ind_bank = URec.ind_bank
#   let ARec.ind_ins = URec.ind_ins
#   let ARec.ind_mfg = URec.ind_mfg
#   let ARec.ind_hl = URec.ind_hl
#   let ARec.ind_gov = URec.ind_gov
#   let ARec.ind_cross = URec.ind_cross
#   let ARec.url = URec.url
#   let ARec.pwp = URec.pwp
#   let ARec.desc = URec.desc
#   let ARec.p_name = URec.p_name
#   let ARec.p_title = URec.p_title
#   let ARec.p_phone = URec.p_phone
#   let ARec.p_email = URec.p_email
#   let ARec.focus1 = URec.focus1
#   let ARec.focus2 = URec.focus2
#   let ARec.focus3 = URec.focus3
#   let ARec.updtime = URec.updtime


#display qtrStr
display "<table align='center' border='0' style='width: 744px'>"
display "<tbody>"
display "<tr>"
display "<td style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<h1 style='text-align: center'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 24px'>",URec.part_name clipped, "</span></span></h1>"
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
if( not secretVer )then
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-sec.html' class='no_show'>....</a>"
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
display URec.desc clipped
display "</span></span></div>"
display "&nbsp;"
display "</td>"
display "<th style='text-align: center; background-color: rgb(240,248,255); width: 250px; vertical-align: top'>"

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
display "<strong><a href='/", IRec.i_id clipped,"/", BRec.b_id clipped, "/H/BPTV.html' target='_blank'>BPTV</a></strong></th>"
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
## assume if they are in the file they are SVP approved
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

## display the PW level and Value Pack
display "<div style='text-align: center'>"
if( BPTVRec.pw_level="MEM" )then
   display "<span style='font-size: 8pt'>(<a href='http://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/pw_com_lev_index' target='_blank'>PW Level:</a> Member";
#   if( BPTVRec.value_pack = "Yes" )then
#      display " with Value Pack";
#   end if
   display " ", URec.tier using '#', ") </span></div>"
else
   if( BPTVRec.pw_level="ADV" )then
      display "<span style='font-size: 8pt'>(<a href='http://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/pw_com_lev_index' target='_blank'>PW Level:</a> Advanced";
#      display "<span style='font-size: 8pt'>(PW Level: Advanced";
#      if( BPTVRec.value_pack = "Yes" )then
#         display " with Value Pack";
#      end if
      display " ", URec.tier using '#', ") </span></div>"
   else
      if( BPTVRec.pw_level="PRE" )then
         display "<span style='font-size: 8pt'>(<a href='http://www-304.ibm.com/partnerworld/wps/servlet/ContentHandler/pw_com_lev_index' target='_blank'>PW Level:</a> Premier";
#         display "<span style='font-size: 8pt'>(PW Level: Premier";
#         if( BPTVRec.value_pack = "Yes" )then
#            display " with Value Pack";
#         end if
         display " ", URec.tier using '#', ") </span></div>"
      end if
   end if
end if
display "<div>"

display "<p>"
display "&nbsp;</p>"

##
## Show skills for current brand here if requested
##
if( G_includeskills )then
#   display "<tr>"
#   if( CtlRec.cflg3 )then   #rotate showing one skill category per row

#   let SQLStr = "select a.b_ord from brands a where a.b_id='", inBrand clipped, "'"
#   prepare LSU1 from SQLStr
#   execute LSU1 into bIdx

let SQLStr="select a.*, b.ordctp from brands a, unit_brand b where a.b_id=b.b_id and b.u_id='", BRec.b_id clipped, "' order by a.b_ord"
prepare LSU2 from SQLStr
declare LSU2Curs cursor for LSU2

foreach LSU2Curs into tBrandRec.*, tidx
   let CTPArr[tidx] = tBrandRec.b_id
   let SkilledYN = LoadSkillRec( tBrandRec.b_id, URec.ceid )
#display "SkilledYN :", SkilledYN
   if( SkilledYN )then
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

end if

## Certifications (only for Secret pages)
#display "SECRETVER: ", secretVer 
if( secretVer )then
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

end if

## Success and Reference Section
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

for i = 1 to successCnt
   display "<p>"
   display "<span style='font-size:18px;'><a href='", SuccessArr[i].s_link clipped, "' target='_blank'>", SuccessArr[i].s_title clipped,"</a></span></p>"
end for

display "<br />"
display "<p>"
display "&nbsp;</p>"
display "</td>"
display "</tr>"

## Enterprise Unit Section
call GetEUDetails()
display "<tr>"
#display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>E N T E R P R I S E&nbsp;&nbsp; U N I T S</span></span></td>"
display "</tr>"
display "<tr>"
display "<td colspan='3' style='text-align: center; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"

## display headquarters
if( URec.hq is not NULL )then
   let stateStr = GetState( URec.hq clipped )
   if( stateStr is not NULL )then
      display "<em>Headquarted in ", stateStr clipped, "</em>"
   else
      display "<p>"
      display "&nbsp;</p>"
   end if
else
   display "<p>"
   display "&nbsp;</p>"
end if

## set up table for list of enterprise units
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
                  display buStr clipped
	       end if   #there are contacts to show
            else
               display buStr clipped
            end if  # if G_eucontacts

            display "</td>"
         else
            display "'>&nbsp;</td>"
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

display "</tbody>"
display "</table>"
display "<br />"
display "<p>"

## VAD Section
display "<span style='font-size:18px';>VAD: <a href='", VRec.v_link clipped, "' target='_blank'>", VRec.v_name clipped, "</span> </a></p><br \>"
display "</td>"
display "</tr>"

## Industry Section
display "<tr>"
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>I N D U S T R Y</span></span></td>"
display "</tr>"
display "<tr>"
display "<td colspan='3' style='text-align: center; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
display "<p>"
display "&nbsp;</p>"
display "<table align='center' border='1' height='60' width='641'>"
display "<tbody>"
display "<tr>"
for i = 1 to 12
display "<td style='background-color: #add8e6'><strong>", INDArr[i].i_short clipped, "</strong></td>"
end for
display "</tr>"
{
display "<td style='background-color: #add8e6'><strong>Energy & Utility</strong></td>"
display "<td style='background-color: #add8e6'><strong>Telecommunication</strong></td>"
display "<td style='background-color: #add8e6'><strong>Media & Entertain</strong></td>"
display "<td style='background-color: #add8e6'><strong>Retail</strong></td>"
display "<td style='background-color: #add8e6'><strong>Wholesale</strong></td>"
display "<td style='background-color: #add8e6'><strong>Transportation</strong></td>"
display "<td style='background-color: #add8e6'><strong>Banking/Financial</strong></td>"
display "<td style='background-color: #add8e6'><strong>Insurance</strong></td>"
display "<td style='background-color: #add8e6'><strong>Manufacturing</strong></td>"
display "<td style='background-color: #add8e6'><strong>Healthcare/Lifescience</strong></td>"
display "<td style='background-color: #add8e6'><strong>Government</strong></td>"
}

display "<tr>"
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_eu is not null and URec.ind_eu != " ") then
   display "background-color:00FF00'>", URec.ind_eu, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_tel is not null and URec.ind_tel!= " ") then
   display "background-color:00FF00'>", URec.ind_tel, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_me is not null and URec.ind_me != " ") then
   display "background-color:00FF00'>", URec.ind_me, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_ret is not null and URec.ind_ret != " ") then
   display "background-color:00FF00'>", URec.ind_ret, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_wd is not null and URec.ind_wd != " ") then
   display "background-color:00FF00'>", URec.ind_wd, "</td>"
   else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_trans is not null and URec.ind_trans != " ") then
   display "background-color:00FF00'>", URec.ind_trans, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_bank is not null and URec.ind_bank != " ") then
   display "background-color:00FF00'>", URec.ind_bank, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_ins is not null and URec.ind_ins != " ") then
   display "background-color:00FF00'>", URec.ind_ins, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_mfg is not null and URec.ind_mfg != " ") then
   display "background-color:00FF00'>", URec.ind_mfg, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_hl is not null and URec.ind_hl != " ") then
   display "background-color:00FF00'>", URec.ind_hl, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_gov is not null and URec.ind_gov != " ") then
   display "background-color:00FF00'>", URec.ind_gov, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( URec.ind_cross is not null and URec.ind_cross != " ") then
   display "background-color:00FF00'>", URec.ind_cross, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "</tr>"
display "</tbody>"
display "</table>"
display "<br />"
display "<p>"

display "</td>"
display "</tr>"

## Contact Section
display "<tr>"

## partner contacts
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; vertical-align: middle'>"
#display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: ", textcolorStr clipped, "'><span style='font-size: 22px'>C O N T A C T S</span></span></td>"
display "</tr>"
display "<tr>"
display "<td style='text-align: center; width: 421px'>"
display "<div>"
display "<em><span style='font-size: 14pt'>Primary Partner Contact</span></em></div>"

display "<div>"
display "<div style='position: absolute; left: -2.94%'>"
display "&nbsp;</div>"
display "</div>"
display "<div>"
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

## ibm contacts
display "<td style='text-align: center; width: 421px; vertical-align: middle'>"
display "</td>"
display "<td class='separator'; style='text-align: center; width: 421px'>"
display "<div>"

if( ShowCrossFlg )then
   display "<em><span style='font-size: 14pt'>", bprStr clipped, ": </span></em>"
   display "<a href='", SSRRec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", SSRRec.r_name clipped, "</span></a></div>"
   display "<div>"
   display "&nbsp;</div>"
else
   display "<em><span style='font-size: 14pt'>", bprStr clipped, "</span></em></div>"
   display "<div>"
   display "<a href='", SSRRec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", SSRRec.r_name clipped, "</span></a></div>"
   display "<div>"
   display "&nbsp;</div>"
   end if

# TSS
if( ShowCrossFlg )then
   display "<div>"
   display "<em><span style='font-size: 14pt'>", tssStr  clipped, ": </span></em>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
   if( CTP1Rec.r_name = "Open" )then
      display "<span style='font-size: 18px'>", CTP1Rec.r_name clipped, "</span></div>"
   else
      display "<a href='", CTP1Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP1Rec.r_name clipped, "</span></a></div>"
   end if
else
   display "<div>"
   display "<em><span style='font-size: 14pt'>", tssStr  clipped, "</span></em></div>"
#1st TSS
   display "<div>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
   if( CTP1Rec.r_name = "Open" )then
      display "<span style='font-size: 18px'>", CTP1Rec.r_name clipped, "</span></div>"
   else
      if( CTP1Rec.r_name is not NULL and CTP1Rec.r_name != ' ')then
         display "<a href='", CTP1Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP1Rec.r_name clipped, "</span></a> "
         if( NOT CtlRec.expandbrand )then
            if( CTPArr[1] = URec.lead )then
               let tmpStr = "(", CTPArr[1] clipped, ") TSS Lead"
            else
               let tmpStr = "(", CTPArr[1] clipped, ")"
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
            if( CTPArr[2] = URec.lead )then
               let tmpStr = "(", CTPArr[2] clipped, ") TSS Lead"
            else
               let tmpStr = "(", CTPArr[2] clipped, ")"
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
            if( CTPArr[3] = URec.lead )then
               let tmpStr = "(", CTPArr[3] clipped, ") TSS Lead"
            else
               let tmpStr = "(", CTPArr[3] clipped, ")"
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
            if( CTPArr[4] = URec.lead )then
               let tmpStr = "(", CTPArr[4] clipped, ") TSS Lead"
            else
               let tmpStr = "(", CTPArr[4] clipped, ")"
            end if
            display tmpStr clipped
         end if
         display "</div>"
      end if
    end if
#5th TSS
   display "<div>"
   display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
   if( CTP5Rec.r_name = "Open" )then
      display "<span style='font-size: 18px'>", CTP5Rec.r_name clipped, "</span></div>"
   else
      if( CTP5Rec.r_name is not NULL and CTP5Rec.r_name != ' ')then
         display "<a href='", CTP5Rec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTP5Rec.r_name clipped, "</span></a> "
         if( NOT CtlRec.expandbrand )then
            if( CTPArr[5] = URec.lead )then
               let tmpStr = "(", CTPArr[5] clipped, ") TSS Lead"
            else
               let tmpStr = "(", CTPArr[5] clipped, ")"
            end if
            display tmpStr clipped
         end if
         display "</div>"
      end if
    end if
end if
#end if

# cross-brand
if( ShowCrossFlg )then
   call LoadCrossRec( URec.ceid )

#     get url for swita
   if( G_CrossAvail and CRec.swita is not NULL and CRec.swita != " " and CRec.swita != "NA")then
      let lstr = getRepLink(CRec.swita)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", switaStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.swita clipped, "</span></a></div>"
   end if  #G_CrossAvail

#     get url for spr
   if( G_CrossAvail and CRec.spr is not NULL and CRec.spr != " " and CRec.spr != "NA")then
      let lstr = getRepLink(CRec.spr)

      display "<div>"
      display "&nbsp;</div>"
      display "<div>"
      display "<em><span style='font-size: 14pt'>", sprStr  clipped, ": </span></em>"
      display "<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
      display "<a href='", lstr clipped, "' target='_blank'><span style='font-size: 18px'>", CRec.spr clipped, "</span></a></div>"
   end if  #G_CrossAvail
end if  #ShowCrossFlg

display "<div>"
display "&nbsp;</div>"
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
 
   if( G_ContactCnt > 0 )then
      display "<tr><td style='text-align: center; width: 421px'>"

      display "<em><span style='font-size: 14pt'>Other Partner Contacts</span></em></div>"
      for c = 1 to G_ContactCnt
         display "<div>"
         display "<span style='font-size: 22px'><span style='font-size: 18px'>"
         if( ContactArr[c].c_name is not null ) then
            display ContactArr[c].c_name clipped, "</span></span></div>"
         else
            display "&nbsp;</span></span></div>"
         end if
   
         if( ContactArr[c].c_title is not null ) then
            display "<div>"
            display "<div style='position: absolute; left: -2.94%'>"
            display "&nbsp;</div>"
            display "</div>"
            display "<div>"
            display "<span style='font-size: 14px'><span style='font-size: 14px'>"
            display ContactArr[c].c_title clipped, "</span></span></div>"
         end if

         if( ContactArr[c].c_phone is not null ) then
            display "<div>"
            display "<div style='position: absolute; left: -2.94%'>"
            display "&nbsp;</div>"
            display "</div>"
            display "<div>"
            display ContactArr[c].c_phone clipped, "</span></span></div>"
         end if

         if( ContactArr[c].c_email is not null ) then
            display "<div>"
            display "<span style='font-size: 18px'><span style='color: rgb(89,89,89)'>"
            display "<a href='mailto:", ContactArr[c].c_email clipped, "' style='position: relative' target='_blank'>", ContactArr[c].c_email clipped, "</a></span></span></div>"
         end if

         display "<br \>"
      end for

      display "</td></tr>"
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

call ShowVer( 1 )

end main

function ShowTitle( showHeader )
define
   showHeader smallint

   call Header(8, IRec.i_id, BRec.b_id, showHeader)     #8-partner details

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

end function

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
   let vText = bText clipped, " Detailed Skills"
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
         end for
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
#	      display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
              let sStr = showSkillCell( BPSkillsArr[sidx], colorArr[color_idx] )
#              display sStr clipped, "</td>"
              display sStr clipped
             else
                let nidx = SkillArr[sidx].db_num
                if (BPSkillsArr[sidx] > 0 )then
                    let color_idx = BPSkillsArr[nidx] + 1
                else
                    let color_idx = 1
                end if
#                display "<td class='centerText'; style='background-color: ", colorArr[color_idx], "'>"
                let sStr = showSkillCell( BPSkillsArr[nidx], colorArr[color_idx] )
#                display sStr clipped, "</td>"
                display sStr clipped
             end if
#display i, BPSkillsArr[i], color_idx
           end if
       end for
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
         let sStr = showSkillCell( BPSkillsArr[i], colorArr[color_idx] )
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
         let sStr = showSkillCell( BPSkillsArr[nidx], colorArr[color_idx] )
#         display sStr clipped, "</td>"
         display sStr clipped
       end if
#display i, BPSkillsArr[i], color_idx
      end if
   end for
   display "</tr>"
end if  #skill_cat
display "<tr><td colspan='100'>* 3-TOP Skilled Partner, 2-Skilled Partner, 1-Learning Partner"
if( GSkillDt is not NULL) then
   display "<span style='font-size: 10px'> (Last Updated: ", GSkillDt, ")</span>"
end if
display "</td></tr>"

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

         if( ProductionBrand[ brand_ws ] and inBrand != 'WS' )then
            call ShowDetailLine( brand_ws, inceid )
         end if
         if( ProductionBrand[ brand_im ] and inBrand != 'IM' )then
            call ShowDetailLine( brand_im, inceid )
         end if
         if( ProductionBrand[ brand_sc ] and inBrand != 'SC' )then
            call ShowDetailLine( brand_sc, inceid )
         end if
         if( ProductionBrand[ brand_em ] and inBrand != 'EM' )then
            call ShowDetailLine( brand_em, inceid )
         end if
         if( ProductionBrand[ brand_ti ] and inBrand != 'TI' )then
            call ShowDetailLine( brand_ti, inceid )
         end if
         if( ProductionBrand[ brand_ra ] and inBrand != 'RA' )then
            call ShowDetailLine( brand_ra, inceid )
         end if
         if( ProductionBrand[ brand_lo ] and inBrand != 'LO' )then
            call ShowDetailLine( brand_lo, inceid )
         end if
         if( ProductionBrand[ brand_ba ] and inBrand != 'BA' )then
            call ShowDetailLine( brand_ba, inceid )
         end if
         if( ProductionBrand[ brand_is ] and inBrand != 'IS' )then
            call ShowDetailLine( brand_is, inceid )
         end if
         if( ProductionBrand[ brand_se ] and inBrand != 'SE' )then
            call ShowDetailLine( brand_se, inceid )
         end if

end function  #ShowDetailSection

function ShowDetailLine( inBrandID, inceid )
define
   inBrandID like brands.b_ord,      #current brand ID
   inceid like coverage_ws.ceid   #current CEID

#display inBrandID, inceid
   display "<a href='/", IRec.i_id clipped, "/", BrandArr[inBrandID].b_id clipped, "/P/", inceid clipped, "-nh.html' target='_blank'>", BrandArr[inBrandID].b_name clipped, "</a><br />"

end function  #ShowDetailLine

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

   let SQLStr = "select  a.brand, a.prod_group, a.cert_type, a.cert_num, a.cert_desc, count(*) cnt from certs a where a.ceid = '", inceid clipped, "' group by 2,3,4,5,1 order by a.prod_group, a.cert_type, a.cert_desc, a.brand"

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



