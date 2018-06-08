## Jun 18, 2013 - John - accept either blank or null in Industry columns
## Jun 21, 2013 - John - convert "H" to "HQ" in Business Units
## Jul 24, 2013 - John - show details for all brands

globals "globals.4gl"

define
BPTVRec record like bptv.*,
SuccessArr array[10] of 
   record
      s_title like success_ws.s_title,
      s_link like success_ws.s_link
   end record,
BPTVArr array[10] of
   record
      rag like bptv_parts.rag,
      bptv_01 like bptv_parts.bptv_01,
      svp_01 like bptv_parts.svp_01,
      people_01 like bptv_parts.people_01,
      nlrev_01 like bptv_parts.nlrev_01,
      vrrev_01 like bptv_parts.vrrev_01
   end record

main

define
    SSRRec record like reps.*,
    CTPRec record like reps.*,
    VRec record like vads.*,
    i smallint,
    successCnt smallint,
    cov_tab char(25),
    skill_tab char(25),
    qtrStr char(256),
    colorStr char(16),
    BPTV_cnt smallint,
    skillStr char(64),
    tamt float,
    buStr char(2),
    tURL char(60)

call ReadCmdLn( "buildPages", 4 )
call ProcCmdLn( "buildPages" )
call LoadBPTVRec( CLRec.ceid )
let colorStr = GetColor(0,1)


case BRec.b_id
   when "IM"
      let cov_tab = "coverage_im"
      let skill_tab = "skills_im"
   when "WS"
      let cov_tab = "coverage_ws"
      let skill_tab = "skills_ws"
   otherwise
      let qtrStr = "coverage"
      let skill_tab = "skills"
      end case

   let qtrStr = "select a.*,d.*, r.*, s.*, v.* ",
   "from ", cov_tab clipped, " a, outer ", skill_tab clipped, " d, outer reps r, outer reps s, outer vads v ",
   "where a.ceid = d.ceid and a.ceid = '", CLRec.CEID clipped, "' ",
     "and a.ssr = r.r_name ",
     "and a.ctp = s.r_name ",
     "and a.vad = v.v_id "

call ShowTitle()
display " "

prepare QID from qtrStr
declare ACurs cursor for QID
foreach ACurs into ARec.*, KRec.*, SSRRec.*, CTPRec.*, VRec.*

display "<table align='center' border='0' style='width: 744px'>"
display "<tbody>"
display "<tr>"
display "<td style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<h1 style='text-align: center'>"
display "<span style='color: #ffffff'><span style='font-size: 36px'>",ARec.part_name clipped, "</span></span></h1>"
display "</td>"
display "<td style='text-align: center; width: 191px; vertical-align: middle'>"
#display "<div>"
display "<div style='text-align: center'>"

## make url consistent with http prefix
if( ARec.url[1,4] = "http" )then
   let tURL = ARec.url clipped
else
   let tURL = "http://", ARec.url clipped
end if

display "<span style='font-size: 12pt'><a href='", tURL clipped, "' target='_blank'>", ARec.url clipped,"</a></span></div>"

## display the PW Profile if present
if( ARec.pwp is not null) then
   display "<div style='text-align: center'>"
   display "<span style='font-size: 12pt'><a href='", ARec.pwp clipped, "' target='_blank'>PartnerWorld Profile", "</a></span></div>"
end if


## display the CEID
display "<div style='text-align: center'>"
display "<span style='font-size: 12pt'>CEID: ", ARec.ceid clipped,"</span></div>"
display "<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -4.92%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span>"
#display "</div>"
display "</td>"
display "<td style='text-align: center; width: 115px; vertical-align: middle'>"
display "<img  style='block; width: 300px; height: auto'; src='/", IRec.i_id clipped, "/I/", ARec.ceid clipped,".jpg' /></td>"
display "</tr>"
display "<tr>"
display "<td colspan='2' style='width: 421px'>"
display "<div>"
display "<span style='font-size:18px;'><span style='font-family:arial,helvetica,sans-serif;'>"
display ARec.desc clipped
display "</span></span></div>"
display "&nbsp;"
display "</td>"
display "<th style='text-align: center; background-color: rgb(240,248,255); width: 250px; vertical-align: middle'>"
display "<table align='center' border='1' height='127' style='width: 143px' width='195'>"
display "<tbody>"
display "<tr>"
display "<td style='width: 66px'>"
display "								&nbsp;</td>"
display "<td style='text-align: center; background-color: #add8e6; width: 65px'>"
display "<strong>Authorized</strong><br />(cert ppl)</td>"
display "<td style='text-align: center; background-color: #add8e6; width: 65px'>"
display "<strong>BPTV</strong></td>"
display "<td style='text-align: center; background-color: #add8e6; width: 65px'>"
display "<strong>New LiC Rev</strong></td>"
display "<td style='text-align: center; background-color: #add8e6; width: 65px'>"
display "<strong>Val Rev</strong></td>"
display "</tr>"

# load the array of  BPTV info
let BPTV_Cnt = GetBPTVParts( ARec.ceid )

## authorized rows
for i = 1 to BPTV_Cnt
   display "<tr>"
   display "<td style='width: 66px'>"
   display "<strong>", BPTVArr[i].rag clipped, "</strong></td>"
   display "<td style='text-align: center; width: 65px'>"
   if( BPTVArr[i].svp_01 = 'Yes' {or BPTVArr[i].bptv_01>0}) then
      display BPTVArr[i].svp_01 clipped
      if( BPTVArr[i].people_01 > 0 )then
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
   else
      display "&nbsp;</td><td> &nbsp;</td>"
   end if

   display "<td stle='text-align: right; width: 66px'>"
   if( BPTVArr[i].nlrev_01 > 0 )then
      let tamt = BPTVArr[i].nlrev_01/1024
      display tamt using "###,###,###", "K</td>"
   else
      display "&nbsp;</td>"
   end if
   display "<td style='text-align: right; width: 66px'>"
   if( BPTVArr[i].vrrev_01 > 0 )then
      let tamt = BPTVArr[i].vrrev_01/1024
      display tamt using "###,###,###", "K</td>"
   else
      display "&nbsp;</td>"
   end if
display "</tr>"
end for

## find any other RAGs not in BPTV file
for i = 1 to G_SVPcnt
   if( SVPArr[i].flag = 0 )then
      display "<tr>"
      display "<td style='width: 66px'>"
      display "<strong>", SVPArr[i].s_name clipped, "</strong></td>"
      display "<td style='text-align: center; width: 65px'>"
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
  
      display "</tr>"
   end if
end for

{
display "<tr>"
display "<td style='width: 66px'>"
display "<strong>", SVPArr[1].s_name clipped, "</strong></td>"
display "<td style='text-align: center; width: 65px'>"
if( AREc.svp_01 is not null) then
   display ARec.svp_01, "</td>"
else
   display "&nbsp;</td>"
end if
display "</tr>"

display "<tr>"
display "<td style='width: 66px'>"
display "<strong>", SVPArr[2].s_name clipped, "</strong></td>"
display "<td style='text-align: center; width: 65px'>"
if( ARec.svp_02 is not null) then
   display ARec.svp_02, "</td>"
else
   display "&nbsp;</td>"
end if
display "</tr>"

display "						<tr>"
display "							<td style='width: 66px'>"
display "								<strong>", SVPArr[3].s_name clipped, "</strong></td>"
display "							<td style='text-align: center; width: 65px'>"
if( AREc.svp_03 is not null) then
   display ARec.svp_03, "</td>"
else
   display "&nbsp;</td>"
end if
display "						</tr>"
display "						<tr>"
display "							<td style='width: 66px'>"
display "								<strong>", SVPArr[4].s_name clipped, "</strong></td>"
display "							<td style='text-align: center; width: 65px'>"
display "									&nbsp;</td>"
display "							</tr>"
}

display "</tbody>"
display "</table>"

display "<BR \>"
#display "<span style='font-size: 8px'>&nbsp;</span></p>"

#display "<tr>"
display "<div style='text-align: center'>"
display "<strong><a href='/", IRec.i_id clipped,"/", BRec.b_id clipped, "/H/BPTV.html'>What is BPTV?</a></strong></div>"
display "<div style='text-align: center'>"
display "<em>(Business Partner Technical Vitality)</em></div>"
display "<br />"
#display "</th>"
#display "</tr>"

display "<table align='center' border='1' style='width: 100px'>"
display "<tbody>"

display "<tr>"
display "<td style='background-color: #add8e6' style='text-align: center'>"
display "Other Focus Areas</td>"
display "</tr>"
display "<tr><td>"
if( ARec.focus1 is not null) then
   display ARec.focus1 clipped
else
   display "&nbsp;"
end if
display "</td></tr>"
display "<tr><td>"
if( ARec.focus2 is not null) then
   display ARec.focus2 clipped
else
   display "&nbsp;"
end if
display "</td></tr>"
display "<tr><td>"
if( ARec.focus3 is not null) then
   display ARec.focus3 clipped
else
   display "&nbsp;"
end if
display "</td></tr>"
display "</tbody>"
display "</table>"
display "<br />"
# show top skilled areas
# display "<tr>"

let skillStr=BuildSkillStr(3)
{
if (KRec.skill_01=3 )then
      let skillStr = AddText( skillStr, SkillArr[1].s_name)
end if
if (KRec.skill_02=3 )then
      let skillStr = AddText( skillStr, SkillArr[2].s_name)
end if
if (KRec.skill_03=3 )then
      let skillStr = AddText( skillStr, SkillArr[3].s_name)
end if
if (KRec.skill_04=3 )then
      let skillStr = AddText( skillStr, SkillArr[4].s_name)
end if
if (KRec.skill_05=3 )then
      let skillStr = AddText( skillStr, SkillArr[5].s_name)
end if
if (KRec.skill_06=3 )then
      let skillStr = AddText( skillStr, SkillArr[6].s_name)
end if
if (KRec.skill_07=3 )then
      let skillStr = AddText( skillStr, SkillArr[7].s_name)
end if
if (KRec.skill_08=3 )then
   let skillStr = AddText( skillStr, SkillArr[8].s_name)
end if
if (KRec.skill_09=3 )then
      let skillStr = AddText( skillStr, SkillArr[9].s_name)
end if
if (KRec.skill_10=3 )then
      let skillStr = AddText( skillStr, SkillArr[10].s_name)
end if
if (KRec.skill_11=3 )then
      let skillStr = AddText( skillStr, SkillArr[11].s_name)
end if
if (KRec.skill_12=3 )then
      let skillStr = AddText( skillStr, SkillArr[12].s_name)
end if
if (KRec.skill_13=3 )then
      let skillStr = AddText( skillStr, SkillArr[13].s_name)
end if
if (KRec.skill_14=3 )then
      let skillStr = AddText( skillStr, SkillArr[14].s_name)
end if
if (KRec.skill_15=3 )then
      let skillStr = AddText( skillStr, SkillArr[15].s_name)
end if
if (KRec.skill_16=3 )then
      let skillStr = AddText( skillStr, SkillArr[16].s_name)
end if
if (KRec.skill_17=3 )then
      let skillStr = AddText( skillStr, SkillArr[17].s_name)
end if
if (KRec.skill_18=3 )then
      let skillStr = AddText( skillStr, SkillArr[18].s_name)
end if
if (KRec.skill_19=3 )then
      let skillStr = AddText( skillStr, SkillArr[19].s_name)
end if
if (KRec.skill_20=3 )then
      let skillStr = AddText( skillStr, SkillArr[20].s_name)
end if
}

if( skillStr is not NULL )then
   display "<div style='text-align: center'>"
   display "<em>Top Skilled in:</em><br />", skillStr clipped, "</div>"
end if
#display "</tr>"
display "<p>"

## display the PW level and Value Pack
display "<div style='text-align: center'>"
if( BPTVRec.pw_level="MEM" )then
   display "<span style='font-size: 8pt'>(PW Level: Member";
   if( BPTVRec.value_pack = "Yes" )then
      display " with Value Pack";
   end if
   display ")</span></div>"
else
   if( BPTVRec.pw_level="ADV" )then
      display "<span style='font-size: 8pt'>(PW Level: Advanced";
      if( BPTVRec.value_pack = "Yes" )then
         display " with Value Pack";
      end if
      display ")</span></div>"
   else
      if( BPTVRec.pw_level="PRE" )then
         display "<span style='font-size: 8pt'>(PW Level: Premier";
         if( BPTVRec.value_pack = "Yes" )then
            display " with Value Pack";
         end if
         display ")</span></div>"
      end if
   end if
end if
display "<div>"

display "<p>"
display "&nbsp;</p>"
{
display "<table align='center' border='1' height='127' style='width: 143px' width='195'>"
display "<tbody>"
display "<tr>"
display "<td style='width: 66px'>"
display "&nbsp;</td>"
display "<td style='text-align: center; background-color: #add8e6; width: 65px'>"
display "<strong>BPTV</strong></td>"
display "</tr>"

for i = 1 to BPTV_Cnt

# row i of BPTV
   display "<tr>"
   display "<td style='width: 66px'>"
   display "<strong>", BPTVArr[i].rag clipped, "</strong></td>"
   display "<td style='text-align: center; width: 65px'>"
   display " "
   if( BPTVArr[i].bptv_01 is not null AND BPTVArr[i].bptv_01 > 0 ) then
      display BPTVArr[i].bptv_01 using "###", "</td>"
   else
      display "&nbsp;</td>"
   end if
   display "</tr>"
   end for
}
{
# row 1 of BPTV
display "							<tr>"
display "								<td style='width: 66px'>"
display "									<strong>", SVPArr[1].s_name clipped, "</strong></td>"
display "								<td style='text-align: center; width: 65px'>"
display "									"
if( AREc.bptv_01 is not null) then
   display ARec.bptv_01 using "###", "</td>"
else
   display "&nbsp;</td>"
end if
display "							</tr>"

# row 2 of BPTV
display "							<tr>"
display "								<td style='width: 66px'>"
display "									<strong>", SVPArr[2].s_name clipped, "</strong></td>"
display "								<td style='text-align: center; width: 65px'>"
display "									"
if( AREc.bptv_02 is not null) then
   display ARec.bptv_02 using "###", "</td>"
else
   display "&nbsp;</td>"
end if
display "							</tr>"

# close BPTV table
display "</tbody>"
display "</table>"

display "<div style='text-align: center'>"
display "<strong><a href='../P/BPTV.html'>BPTV Scores</a></strong></div>"
display "<div style='text-align: center'>"
display "<em>(Business Partner Technical Vitality)</em></div>"
display "</th>"
display "</tr>"
}

## Success and Reference Section
display "			<tr>"
display "				<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "					<span style='color: #ffffff'><span style='font-size: 22px'>R E F E R E N C E S&nbsp; &amp;&nbsp; S U C C E S S&nbsp; S T O R I E S</span></span></td>"
display "			</tr>"
display "			<tr>"
display "				<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
display "					<p>"
display "						&nbsp;</p>"

## check on accreditation and write message as appropriate
if( AccRec.ceid = CLRec.CEID )then
   display "<p>"
   display "<span style='font-size:18px;'>", "<img src='/", IRec.i_id clipped, "/I/star1.jpg' width='61' heigth='51'/><em>", "** IBM Software Practice Accelerator: ACCREDITED!","</em></span></p>"
end if

## retrieve and display successes
let successCnt = GetSuccesses( ARec.ceid )

for i = 1 to successCnt
   display "<p>"
   display "<span style='font-size:18px;'><a href='", SuccessArr[i].s_link clipped, "' target='_blank'>", SuccessArr[i].s_title clipped,"</a></span></p>"
end for

display "					<br />"
display "					<p>"
display "						&nbsp;</p>"
display "				</td>"
display "			</tr>"


## Business Unit Section
display "<tr>"
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: #ffffff'><span style='font-size: 22px'>B U S I N E S S&nbsp;&nbsp; U N I T S</span></span></td>"
display "</tr>"
display "<tr>"
display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
display "<p>"
display "&nbsp;</p>"
display "<table align='center' border='1' height='60' width='641'>"
display "<tbody>"
display "<tr>"

for i = 1 to 10
   display "<td style='background-color: #add8e6'>"
   display "<strong>", BUArr[i].b_name clipped, "</strong></td>"
end for
display "</tr>"
{
display "<td style='background-color: #add8e6'>"
display "<strong>Pacifics</strong></td>"
display "<td style='background-color: #add8e6'>"
display "<strong>Great West</strong></td>"
display "<td style='background-color: #add8e6'>"
display "<strong>Southeast</strong></td>"
display "<td style='background-color: #add8e6'>"
display "<strong>Mid-Atlantic</strong></td>"
display "<td style='background-color: #add8e6'>"
display "<strong>NY Area</strong></td>"
display "<td style='background-color: #add8e6'>"
display "<strong>Northeast</strong></td>"
display "<td style='background-color: #add8e6'>"
display "<strong>Great Lakes</strong></td>"
display "<td style='background-color: #add8e6'>"
display "<strong>Federal</strong></td>"
display "<td style='background-color: #add8e6'>"
dtisplay "<strong>Canada</strong></td>"
}

display "<tr>"
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_midwest is not null and ARec.bu_midwest != " ") then
   let buStr = BUText( ARec.bu_midwest )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_pacifics is not null and ARec.bu_pacifics != " ") then
   let buStr = BUText( ARec.bu_pacifics )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_greatwest is not null and ARec.bu_greatwest != " ") then
   let buStr = BUText( ARec.bu_greatwest )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_southeast is not null and ARec.bu_southeast != " ") then
   let buStr = BUText( ARec.bu_southeast )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_midatl is not null and ARec.bu_midatl != " ") then
   let buStr = BUText( ARec.bu_midatl )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_ny is not null and ARec.bu_ny != " ") then
   let buStr = BUText( ARec.bu_ny )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_northeast is not null and ARec.bu_northeast != " ") then
   let buStr = BUText( ARec.bu_northeast )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_grtlakes is not null and ARec.bu_grtlakes != " ") then
   let buStr = BUText( ARec.bu_grtlakes )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_federal is not null and ARec.bu_federal != " ") then
   let buStr = BUText( ARec.bu_federal )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if

display "<td style='text-align: center; vertical-align: middle; "
if( ARec.bu_canada is not null and ARec.bu_canada != " ") then
   let buStr = BUText( ARec.bu_canada )
   display "background-color:00FF00'>", buStr, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "</tr>"
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
display "<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "<span style='color: #ffffff'><span style='font-size: 22px'>I N D U S T R Y</span></span></td>"
display "</tr>"
display "<tr>"
display "<td colspan='3' style='text-align: center; width: 421px; vertical-align: middle'>"
display "<p>"
display "&nbsp;</p>"
display "<table align='center' border='1' height='60' width='641'>"
display "<tbody>"
display "<tr>"
for i = 1 to 11
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
if( ARec.ind_eu is not null and ARec.ind_eu != " ") then
   display "background-color:00FF00'>", ARec.ind_eu, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_tel is not null and ARec.ind_tel!= " ") then
   display "background-color:00FF00'>", ARec.ind_tel, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_me is not null and ARec.ind_me != " ") then
   display "background-color:00FF00'>", ARec.ind_me, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_ret is not null and ARec.ind_ret != " ") then
   display "background-color:00FF00'>", ARec.ind_ret, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_wd is not null and ARec.ind_wd != " ") then
   display "background-color:00FF00'>", ARec.ind_wd, "</td>"
   else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_trans is not null and ARec.ind_trans != " ") then
   display "background-color:00FF00'>", ARec.ind_trans, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_bank is not null and ARec.ind_bank != " ") then
   display "background-color:00FF00'>", ARec.ind_bank, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_ins is not null and ARec.ind_ins != " ") then
   display "background-color:00FF00'>", ARec.ind_ins, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_mfg is not null and ARec.ind_mfg != " ") then
   display "background-color:00FF00'>", ARec.ind_mfg, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_hl is not null and ARec.ind_hl != " ") then
   display "background-color:00FF00'>", ARec.ind_hl, "</td>"
else
   display "'>&nbsp;</td>"
end if
display "<td style='text-align: center; vertical-align: middle; "
if( ARec.ind_gov != "") then
   display "background-color:00FF00'>", ARec.ind_gov, "</td>"
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
display "			<tr>"
display "				<td colspan='3' style='text-align: center; background-color: ", colorStr clipped, "; width: 421px; vertical-align: middle'>"
display "					<span style='font-size: 22px'><span style='color: rgb(255,255,255)'>C O N T A C T S</span></span></td>"
display "			</tr>"
display "			<tr>"
display "				<td style='text-align: center; width: 421px'>"
display "					<div>"
display "						<em><span style='font-size: 14pt'>Lead Pass</span>:</em></div>"
display "					<div>"
display "						<div style='position: absolute; left: -2.94%'>"
display "							&nbsp;</div>"
display "					</div>"
display "					<div>"
display "						<span style='font-size: 22px'><span style='font-size: 18px'>"
if( ARec.p_name is not null ) then
   display ARec.p_name clipped, "</span></span></div>"
else
   display "&nbsp;</span></span></div>"
end if
display "					<div>"
display "						<div style='position: absolute; left: -2.94%'>"
display "							&nbsp;</div>"
display "					</div>"
display "					<div>"
if( ARec.p_phone is not null ) then
   display ARec.p_phone clipped, "</span></span></div>"
else
   display "&nbsp;</span></span></div>"
end if
display "					<div>"
display "						<span style='font-size: 18px'><span style='color: rgb(89,89,89)'>"
if( ARec.p_email is not null ) then
   display "<a href='mailto:", ARec.p_email clipped, "' style='position: relative' target='_blank'>", ARec.p_email clipped, "</a></span></span></div>"
else
   display "&nbsp;</span></span></div>"
end if
display "				</td>"
display "				<td style='text-align: center; width: 421px; vertical-align: middle'>"
display "					<div>"
display "						<em><span style='font-size: 14pt'>BP Rep</span>:</em></div>"
display "					<div>"
display "<a href='", SSRRec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", SSRRec.r_name clipped, "</span></a></div>"
display "				</td>"
display "				<td style='text-align: center; width: 421px'>"
display "					<div>"
display "						<div>"
display "							&nbsp;</div>"
display "						<div>"
display "							<div>"
display "								<em><span style='font-size: 14pt'>TSS Rep</span>:</em></div>"
display "							<div>"
display "								<span style='font-size: 78%'><span style='position: absolute; left: -2.94%'>–</span></span>"
if( CTPRec.r_name = "Open" )then
   display "<span style='font-size: 18px'>", CTPRec.r_name clipped, "</span></div>"
else
   display "<a href='", CTPRec.r_link clipped, "' target='_blank'><span style='font-size: 18px'>", CTPRec.r_name clipped, "</span></a></div>"
end if
display "							<div>"
display "								&nbsp;</div>"
display "						</div>"
display "					</div>"
display "				</td>"
display "			</tr>"
display "			<tr>"
display "				<td style='width: 421px'>"
display "					&nbsp;</td>"
display "				<td style='width: 191px'>"
display "					&nbsp;</td>"
display "				<td style='width: 115px'>"
display "					&nbsp;</td>"
display "			</tr>"
display "		</tbody>"
display "	</table>"
display "	<br />"
display "	<div>"
display "<span style='visibility: hidden'><span style='font-size: 78%'><span style='position: absolute; left: -2.94%'><span style='color: #7889fb'>–</span></span></span></span></div>"
display "<div>"
display "		<span style='font-size: 78%'><span style='position: absolute; left: -2.65%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></div>"
display "	<div>"
display "		<span style='visibility: hidden'><span style='font-size: 133%'><span style='position: absolute; left: -2.65%'><span style='font-family: wingdings'><span style='color: #7889fb'>§</span></span></span></span></span></div>"
display "</div>"
display "<p dir='ltr'>"
display "	&nbsp;</p>"
end foreach

call ShowVer( 0 )

end main

function ShowTitle()

   call Header(0, IRec.i_id, BRec.b_id)

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<p>"

end function

function GetSuccesses( in_ceid )
define
   in_ceid like success_ws.ceid,
   i smallint,
   SQLStr char(128)

   let i = 0
   let SQLStr = "select a.s_title, a.s_link from success_", BRec.b_id clipped, " a where a.ceid='", in_ceid clipped, "'"
   prepare GSID from SQLStr
   declare GSCurs cursor for GSID
   foreach GSCurs into SuccessArr[i+1].*
      let i = i + 1
   end foreach

    return i
end function

function GetBPTVParts( in_ceid )
define
   in_ceid like bptv_parts.ceid,
   i,k smallint,
   SQLStr char(128)

   let i = 0
   let SQLStr = "select a.rag, a.bptv_01, svp_01, people_01, nlrev_01, vrrev_01 from bptv_parts a where a.ceid='", in_ceid clipped, "' and a.brand='", BRec.b_id clipped, "'"
   prepare BPID from SQLStr
   declare BPCurs cursor for BPID
   foreach BPCurs into BPTVArr[i+1].*
      let i = i + 1
      for k=1 to G_SVPcnt
         if( BPTVArr[i].rag = SVPArr[k].s_name )then
            let SVPArr[k].flag = 1
         end if
      end for
   end foreach

    return i
end function #GetBPTVParts

function LoadBPTVRec ( in_ceid )
define
   in_ceid like bptv.ceid,
   SQLStr char(128)
   
   let SQLStr = "select a.* from bptv a where a.ceid='", in_ceid clipped, "'"
   prepare BPRID from SQLStr
   execute BPRID into BPTVRec.*

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
