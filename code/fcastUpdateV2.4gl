
# May      25, 2017  John M. Shoemaker, jshoemaker1@cox.net - add fcast archive status, #233
globals "globals.4gl"

define
   tmpemail like fcast_bpr.email,
   tmppin like fcast_bpr.pin,
   tmptype char(1),
   tmptypedesc char(10),
   rowcnt smallint,
   c1,c2 char(6)

main
define
   FcastBprRec record like fcast_bpr.*,
   FcastRec record like fcast_au.*,
   SSRname like fcast_au.ssr,
   eVar char(128),
   fcname like fcast_bpr.ssr,
   i,j smallint,
   revArr array[5] of float,
   revttl float,
   cnt,rc smallint,
   kStr, vStr char(128),
   tOrd smallint,
   emailtype, pintype char(10),
   SQLStr2 char(512),
   SQLStr char(1536)

call ReadCmdLn( "fcastUpdate", 4 )
call ProcCmdLn( "fcastUpdate" )
call Header(30, IRec.i_id, BRec.b_id, 0)

## extract email address
let eVar = CleanUp(arg_val(4))
#display eVar
call findIdx( eVar ) returning kStr, vStr, eVar
let tmpemail = vStr clipped
#display "Email: ", tmpemail

call findIdx( eVar ) returning kStr, vStr, eVar
let tmppin = vStr clipped

#display "Pin: ", tmppin
{
let eVar = eVar[8,40]
for i=1 to 40
if(eVar[i]="&")then
   exit for
end if
end for
let eVar=eVar[1,i-1]
}

call findIdx( eVar ) returning kStr, vStr, eVar
let tmptype = vStr clipped
#display "Type: ", vStr clipped

case tmptype 
   when "C"
      let tmptypedesc="CURRENT"
   when "A"
      let tmptypedesc="ARCHIVED"
   otherwise
      let tmptypedesc=""
end case

let SQLStr = "select count(*) from fcast_bpr where email='", tmpemail clipped, "'"
#display SQLStr
prepare FC0aID from SQLStr
execute FC0aID into rc
if( rc > 0 )then
   let emailtype="email"
   let pintype="pin"
   let SQLStr = "select a.* from fcast_au a, fcast_bpr b, flu_ssmstep c where a.ssr=b.ssr ", 
              "and b.brand='", BRec.b_id clipped, "' and b.email='", tmpemail clipped, "' ",
              "and b.pin='", tmppin clipped, "' ",
              "and a.ssm_step=c.ssmstep and c.screen_filter!='Y' and a.ftype='", tmptype clipped, "'",
              " union ",
              "select a.* from fcast_au a, fcast_bpr b, flu_ssmstep c where a.mgr=b.ssr ", 
              "and b.brand='", BRec.b_id clipped, "' and b.email='", tmpemail clipped, "' ",
              "and b.pin='", tmppin clipped, "' ",
              "and a.ssm_step=c.ssmstep and c.screen_filter!='Y' and a.ftype='", tmptype clipped, "'",
              "order by a.exp_close_dt"
   let SQLStr2="select unique a.ssr from fcast_bpr a where a.email='", tmpemail clipped, "' ",
             "and a.pin='", tmppin clipped, "' "
   let c1="FFFFFF"
   let c2="E6FFE6"
else  #rc <= 0
   let SQLStr = "select count(*) from fcast_bpr where ctp_email='", tmpemail clipped, "'"
#display SQLStr
   prepare FC0bID from SQLStr
   execute FC0bID into rc

   if( rc > 0 )then
      let SQLStr = "select a.*, c.ord from fcast_au a, fcast_bpr b, flu_ssmstep c where a.ssr=b.ssr ", 
              "and b.brand='", BRec.b_id clipped, "' and b.ctp_email='", tmpemail clipped, "' ",
              "and b.ctp_pin='", tmppin clipped, "' ",
              "and a.ssm_step=c.ssmstep and c.screen_filter!='Y' and a.ftype='", tmptype clipped, "'",
              " union ",
              "select a.*, c.ord from fcast_au a, fcast_bpr b, flu_ssmstep c where a.mgr=b.ssr ", 
              "and b.brand='", BRec.b_id clipped, "' and b.ctp_email='", tmpemail clipped, "' ",
              "and b.ctp_pin='", tmppin clipped, "' ",
              "and a.ssm_step=c.ssmstep and c.screen_filter!='Y' and a.ftype='", tmptype clipped, "'",
              "order by c.ord, a.exp_close_dt"
      let SQLStr2="select unique a.ctp from fcast_bpr a where a.ctp_email='", tmpemail clipped, "' ",
             "and a.ctp_pin='", tmppin clipped, "' "
      let c1="FFFFFF"
      let c2="E6FFE6"
   else
      let emailtype="xxxxx"
      let pintype="xxxxx"
   end if #rc>0 for ctp
end if  #rc>0 for sales

#display SQLStr
prepare FCID from SQLStr
declare FCCurs cursor for FCID

## determine name for the email provided
#display SQLStr2
prepare FC2ID from SQLStr2
execute FC2ID into fcname
if( sqlca.sqlcode != 0 )then
   display "Email or pin code do not match"
end if


display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", tmptypedesc clipped, " FORECAST </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, "</span></em></div>"
display "<p>"

#display "<FORM ID='fcast_upd' ACTION='/cgi-bin/fcastUpd", BRec.b_id clipped, ".ksh' method='post'>"
#display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=950><br>"
#display "This action will update your Forecast.<br>"
display "<table>"

## header
   display 
            "<tr>",
           "<th class='leftText'>Partner Name</th>",
           "<th class='leftText'>Customer Name</th>",
           "<th class='leftText'>Brand </th>",
           "<th>Brand Desc</th>",
	   "<th>Opty Name</th>",
	   "<th>Opty Number</th>",
           "<th>Flow Code</th>",
           "<th>Exp Close Dt</th>",
           "<th class='leftText'>BPR Fcast Status</th>",
           "<th>Revenue</th>",
           "<th>Odds</th>",
           "<th>SSM Step</th>",
           "<th>Rep</th>",
           "<th>UID</th>",
           "<th>Share Up</th>",
           "</tr>"
for i=1 to 5
   let revArr[i]=0.000
end for
let revttl = 0.000

let i=1
let rowcnt=0
foreach FCCurs into FcastRec.*, tOrd
   let rowcnt=rowcnt+1
   if( i=1 )then
      let SSRname=FcastRec.ssr
   end if
   call DispRecV2(FcastRec.*)
   case FcastRec.close_qtr
      when "Q1"
         let revArr[1]=revArr[1]+(FcastRec.rev*1000000.000)
      when "Q2"
         let revArr[2]=revArr[2]+(FcastRec.rev*1000000.000)
      when "Q3"
         let revArr[3]=revArr[3]+(FcastRec.rev*1000000.000)
      when "Q4"
         let revArr[4]=revArr[4]+(FcastRec.rev*1000000.000)
      otherwise
         let revArr[5]=revArr[5]+(FcastRec.rev*1000000.000)
   end case
   let i=i+1
end foreach
let cnt = i-1

#call AddRow(SSRname) returning FcastRec.*
#call DispRecV2(FcastRec.*)

display "</table>"
#display "<INPUT TYPE=submit VALUE='Submit'>"
#display "</FORM>"
display "<p>"
display "<td><FORM ID='fcast_upd' ACTION='/cgi-bin/fcastDetails", BRec.b_id clipped, ".ksh' method='post' target='_blank'>"
display "<INPUT NAME='id' TYPE=hidden READONLY VALUE=0><br>"
display "<INPUT NAME='ssr' TYPE=hidden READONLY VALUE='", fcname clipped, "'><br>"
display "<INPUT NAME='fcast_type' TYPE=hidden READONLY VALUE='", tmptype clipped, "'><br>"
if( tmptype="C" )then
   display "<INPUT TYPE=submit VALUE='Add New Row'>"
end if
display "</FORM></td>"
display "<td><FORM ID='fcast_exp' ACTION='/cgi-bin/fcastExport", BRec.b_id clipped, ".ksh' method='post' target='_blank'>"
display "<INPUT NAME='ssr' TYPE=hidden READONLY VALUE='", fcname clipped, "'><br>"
display "<INPUT NAME='fcast_type' TYPE=hidden READONLY VALUE='", tmptype clipped, "'><br>"
display "<INPUT TYPE=submit VALUE='Export'>"
display "</FORM></td>"
display "Summary:<p>"
display "Number of forecast items: ", cnt using "<<<&","<br>"
let revttl = revArr[1]+revArr[2]+revArr[3]+revArr[4]+revArr[5]
display "Forecast Total: ", revttl using "$$$,$$$,$$$", "<br>"
if( revArr[1] > 0.0 )then display "   Q1: ", revArr[1] using "$$$,$$$,$$$", "<br>" end if
if( revArr[2] > 0.0 )then display "   Q2: ", revArr[2] using "$$$,$$$,$$$", "<br>" end if
if( revArr[3] > 0.0 )then display "   Q3: ", revArr[3] using "$$$,$$$,$$$", "<br>" end if
if( revArr[4] > 0.0 )then display "   Q4: ", revArr[4] using "$$$,$$$,$$$", "<br>" end if
if( revArr[5] > 0.0 )then display "     : ", revArr[5] using "$$$,$$$,$$$", "<p>" end if


end main

function DispRecV2(FcastRec)
define
   FcastRec record like fcast_au.*

#   display "<tr class='d0'>"
   if( rowcnt mod 2 = 0 )then
      display "<tr style='background-color:#", c1 clipped, "'>"
   else
      display "<tr style='background-color:#", c2 clipped, "'>"
   end if
#   display "<INPUT NAME='fcast_id' TYPE=hidden READONLY VALUE=", FcastRec.fcast_id using '######&', "><br>"
#   display "<td class='leftText'>", FcastRec.oppty_stat clipped, "</td>"
   let FcastRec.part_name =  GetPartnerName( FcastRec.ceid )
   display "<td class='leftText'>", FcastRec.part_name clipped, "</td>"
   display "<td class='leftText'>", FcastRec.cust_name clipped, "</td>"
   display "<td>", FcastRec.brand clipped, "</td>"
   display "<td>", FcastRec.brand_desc clipped, "</td>"
   display "<td>", FcastRec.oppty_name clipped, "</td>"
   if( FcastRec.oppty_num is not null and FcastRec.oppty_num != " " and FcastRec.oppty_num != "Being Created" )then
      display "<td>", "<a href='https://w3-150.ibm.com/sales/salesconnect/#Opportunities/", FcastRec.oppty_num clipped, "' target='_blank'>", FcastRec.oppty_num clipped, "</td>"
   else
   display "<td>", FcastRec.oppty_num clipped, "</td>"
   end if

   display "<td>", FcastRec.flow_code clipped, "</td>"
   if( FcastRec.exp_close_dt > today or FcastRec.bpr_fcast_stat='Won' )then
      display "<td>", FcastRec.exp_close_dt clipped, "</td>"
   else
      display "<td bgcolor='#FF0000'>",FcastRec.exp_close_dt clipped, "</td>"
   end if

   display "<td class='leftText'>", FcastRec.bpr_fcast_stat clipped, "</td>"
   display "<td>", FcastRec.rev using "<<<<<&.&&&", "</td>"
   display "<td>", FcastRec.odds, "</td>"
   display "<td>", FcastRec.ssm_step clipped, "</td>"
   display "<td>", FcastRec.ssr clipped, "</td>"
   display "<td>", FcastRec.fcast_id using '####&', "</td>"
   display "<td>", FcastRec.pass_on clipped, "</td>"
display "<td><FORM ID='fcast_upd' ACTION='/cgi-bin/fcastDetails", BRec.b_id clipped, ".ksh' method='post' target='_blank'>"
display "<INPUT NAME='id' TYPE=hidden READONLY VALUE=", FcastRec.fcast_id, ">"
display "<INPUT NAME='email' TYPE=hidden READONLY VALUE=", tmpemail clipped, ">"
display "<INPUT NAME='fstat' TYPE=hidden READONLY VALUE='", tmptype clipped, "'>"
#display "<INPUT NAME='pin' TYPE=hidden READONLY VALUE=", tmppin clipped, ">"
if( FcastRec.ftype="C" )then
   display "<INPUT TYPE=submit VALUE='UPDATE'>"
else
   display "<INPUT TYPE=submit VALUE='VIEW'>"
end if
display "</FORM></td>"
   display "</tr>"

end function  #DispRecV2

function ListBoxFcastSSR( inSel )
define
   inSel like fcast_bpr.ssr,
   sqlStr char(64),
   tssr like fcast_bpr.ssr

   let sqlStr = "select unique a.ssr from fast_bpr a order by 1"
   prepare LBFCSSRID from sqlStr
   declare LBFCSSRCurs cursor for LBFCSSRID

   display "<SELECT NAME='ssr'>"

   foreach LBFCSSRCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT><br>"
end function  #ListBoxFcastSSR

function ListBoxFcastMkt( inSel )
define
   inSel like industry.ig_name,
   sqlStr char(128),
   tssr like industry.ig_name

   let sqlStr = "select unique a.ig_name from industry a where a.i_brand='", BRec.b_id clipped, "' order by 1"
   prepare LBFCMID from sqlStr
   declare LBFCMCurs cursor for LBFCMID

   display "<td><SELECT NAME='market'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFCMCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxFcastMkt


function ListBoxFcastIndAll( inMkt, inSel )
define
   inMkt like industry.ig_name,
   inSel like industry.i_name,
   sqlStr char(128),
   tssr like industry.i_name

   let sqlStr = "select unique a.i_name from industry a where a.i_brand='", BRec.b_id clipped, 
                 "' order by 1"
   prepare LBFCIAID from sqlStr
   declare LBFCIACurs cursor for LBFCIAID

   display "<td><SELECT NAME='industry'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFCIACurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxFcastIndAll

function ListBoxFcastInd( inMkt, inSel )
define
   inMkt like industry.ig_name,
   inSel like industry.i_name,
   sqlStr char(128),
   tssr like industry.i_name

   let sqlStr = "select unique a.i_name from industry a where a.i_brand='", BRec.b_id clipped, 
                 "' and a.ig_name='", inMkt clipped, "' order by 1"
   prepare LBFCIID from sqlStr
   declare LBFCICurs cursor for LBFCIID

   display "<td><SELECT NAME='industry'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   foreach LBFCICurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxFcastInd

function ListBoxFcastYN( inSel )
define
   inSel char(1)

   display "<td><SELECT NAME='yn'>"

   display "<OPTION>"
   if( inSel = "Y" )then
      display "<OPTION SELECTED>Y"
   else
   display "<OPTION>Y"
   end if
   if( inSel = "N" )then
      display "<OPTION SELECTED>N"
   else
      display "<OPTION>N"
   end if

   display "</SELECT></td>"
end function  #ListBoxFcastYN

function GetPartnerName( inSel )
define
   inSel like coverage_au.ceid,
   sqlStr char(128),
   tceid like coverage_au.ceid,
   tssr like coverage_au.part_name

   let sqlStr = "select unique a.part_name from ", cov_tab clipped, " a where a.reseller='G' and a.ceid='", inSel clipped, "' ",
                 " order by 1"
   prepare LBFCPID from sqlStr
   execute LBFCPID into tssr
   return tssr

end function  #GetPartnerName


function ListBoxFlowCode( inSel )
define
   inSel like flu_flowcode.flow_code,
   sqlStr char(128),
   tssr like flu_flowcode.flow_code,
   tmp smallint

   let sqlStr = "select unique a.flow_code, a.ord from flu_flowcode a ",
                 " order by a.ord"
   prepare LBFLU1ID from sqlStr
   declare LBFLU1Curs cursor for LBFLU1ID

   display "<td><SELECT NAME='flow_code'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFLU1Curs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxFlowCode

function ListBoxStatus( inSel )
define
   inSel like flu_stat.fc_status,
   sqlStr char(128),
   tssr like flu_stat.fc_status,
   tmp smallint

   let sqlStr = "select unique a.fc_status, a.ord from flu_stat a ",
                 " order by a.ord"
   prepare LBFLU2ID from sqlStr
   declare LBFLU2Curs cursor for LBFLU2ID

   display "<td><SELECT NAME='bpr_fcast_stat'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFLU2Curs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxStatus

function ListBoxRevType( inSel )
define
   inSel like flu_revtype.rev_type,
   sqlStr char(128),
   tssr like flu_revtype.rev_type,
   tmp smallint

   let sqlStr = "select unique a.rev_type, a.ord from flu_revtype a ",
                 " order by a.ord"
   prepare LBFLU3ID from sqlStr
   declare LBFLU3Curs cursor for LBFLU3ID

   display "<td><SELECT NAME='crm_rev_type'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFLU3Curs into tssr,tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxRevType

function ListBoxIOT( inSel )
define
   inSel like flu_iot.iot,
   sqlStr char(128),
   tssr like flu_iot.iot,
   tmp smallint

   let sqlStr = "select unique a.iot, a.ord from flu_iot a ",
                 " order by a.ord "
   prepare LBFLU4ID from sqlStr
   declare LBFLU4Curs cursor for LBFLU4ID

   display "<td><SELECT NAME='iot'>"

   display "<OPTION>"
   foreach LBFLU4Curs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxIOT

function ListBoxCountry( inSel )
define
   inSel like flu_country.country,
   sqlStr char(128),
   tssr like flu_country.country,
   tmp smallint

   let sqlStr = "select unique a.country, a.ord from flu_country a ",
                 " order by a.ord"
   prepare LBFLU5ID from sqlStr
   declare LBFLU5Curs cursor for LBFLU5ID

   display "<td><SELECT NAME='country'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFLU5Curs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxCountry

function ListBoxBrandGrp( inSel )
define
   inSel like flu_brand_grp.brand_grp,
   sqlStr char(128),
   tssr like flu_brand_grp.brand_grp,
   tmp smallint

   let sqlStr = "select unique a.brand_grp, a.ord from flu_brand_grp a ",
                 " order by a.ord"
   prepare LBFLU6ID from sqlStr
   declare LBFLU6Curs cursor for LBFLU6ID

   display "<td><SELECT NAME='brand_grp'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFLU6Curs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxBrandGrp

function ListBoxBrand( inSel )
define
   inSel like flu_brand.brand,
   sqlStr char(128),
   tssr like flu_brand.brand,
   tmp smallint

   let sqlStr = "select unique a.brand, a.ord from flu_brand a ",
                 " order by a.ord"
   prepare LBFLU7ID from sqlStr
   declare LBFLU7Curs cursor for LBFLU7ID

   display "<td><SELECT NAME='brand'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFLU7Curs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxBrand

function ListBoxSSMStep( inSel )
define
   inSel like flu_ssmstep.ssmstep,
   sqlStr char(128),
   tssr like flu_ssmstep.ssmstep,
   tmp smallint

   let sqlStr = "select unique a.ssmstep, a.ord from flu_ssmstep a ",
                 " order by a.ord"
   prepare LBFLU8ID from sqlStr
   declare LBFLU8Curs cursor for LBFLU8ID

   display "<td><SELECT NAME='ssm_step'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFLU8Curs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxSSMStep

function ListBoxGSISSR( inSel )
define
   inSel like reps.r_name,
   sqlStr char(128),
   tssr like reps.r_name,
   tmp smallint

   let sqlStr = "select unique a.r_name from reps a where a.r_type in ('GS','GM') ",
                 " order by 1"
   prepare LBFLU9ID from sqlStr
   declare LBFLU9Curs cursor for LBFLU9ID

   display "<td><SELECT NAME='ssr'>"

   display "<OPTION>"
   foreach LBFLU9Curs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxGSISSR

function ListBoxGSIMgr( inSel )
define
   inSel like reps.r_name,
   sqlStr char(128),
   tssr like reps.r_name,
   tmp smallint

   let sqlStr = "select unique a.r_name from reps a where a.r_type in ('GM') ",
                 " order by 1"
   prepare LBFLUaID from sqlStr
   declare LBFLUaCurs cursor for LBFLUaID

   display "<td><SELECT NAME='mgr'>"

   display "<OPTION>"
   foreach LBFLUaCurs into tssr
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxGSIMgr

function ListBoxOwningOrg( inSel )
define
   inSel like flu_owning_org.owning_org,
   sqlStr char(128),
   tssr like flu_owning_org.owning_org,
   tmp smallint

   let sqlStr = "select unique a.owning_org, a.ord from flu_owning_org a ",
                 " order by a.ord"
   prepare LBFLUbID from sqlStr
   declare LBFLUbCurs cursor for LBFLUbID

   display "<td><SELECT NAME='owning_org'>"

   display "<OPTION>"
   foreach LBFLUbCurs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxOwningOrg

function ListBoxVAD2( inSel )
define
   inSel like vads.v_name,
   sqlStr char(128),
   tssr like vads.v_name,
   tmp smallint

   let sqlStr = "select unique a.v_name from vads a ",
                 " order by 1"
   prepare LBFLUcID from sqlStr
   declare LBFLUcCurs cursor for LBFLUcID

   display "<td><SELECT NAME='vad'>"

   display "<OPTION>"
   foreach LBFLUcCurs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxVAD2

function ListBoxQtr( inSel )
define
   inSel like fcast_au.close_qtr,
   sqlStr char(128),
   tssr like fcast_au.close_qtr,
   tmp smallint

   display "<td><SELECT NAME='close_qtr'>"

   if( inSel = "Q1" )then
      display "<OPTION SELECTED>Q1"
   else
      display "<OPTION>Q1"
   end if
   if( inSel = "Q2" )then
      display "<OPTION SELECTED>Q2"
   else
      display "<OPTION>Q2"
   end if
   if( inSel = "Q3" )then
      display "<OPTION SELECTED>Q3"
   else
      display "<OPTION>Q3"
   end if
   if( inSel = "Q4" )then
      display "<OPTION SELECTED>Q4"
   else
      display "<OPTION>Q4"
   end if


   display "</SELECT></td>"
end function  #ListBoxQtr


function ListBoxProdSeg( inSel )
define
   inSel like flu_prod_seg.prod_seg,
   sqlStr char(128),
   tssr like flu_prod_seg.prod_seg,
   tmp smallint

   let sqlStr = "select unique a.prod_seg, a.ord from flu_prod_seg a ",
                 " order by a.ord"
   prepare LBFLUdID from sqlStr
   declare LBFLUdCurs cursor for LBFLUdID

   display "<td><SELECT NAME='prod_seg'>"

   display "<OPTION>"
   foreach LBFLUdCurs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxProdSeg


function ListBoxProdFam( inSel )
define
   inSel like flu_prod_fam.prod_fam,
   sqlStr char(128),
   tssr like flu_prod_fam.prod_fam,
   tmp smallint

   let sqlStr = "select unique a.prod_fam, a.ord from flu_prod_fam a ",
                 " order by a.ord"
   prepare LBFLUeID from sqlStr
   declare LBFLUeCurs cursor for LBFLUeID

   display "<td><SELECT NAME='prod_fam'>"

   display "<OPTION>"
   foreach LBFLUeCurs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxProdFam

#####################################################################
function AddRow(inSSR)
define
   inSSR like fcast_au.ssr,
   FcastBprRec record like fcast_au.*

   initialize FcastBprRec.* to NULL

   let FcastBprRec.fcast_id = 0
#   let FcastBprRec.oppty_stat = "Active"
   let FcastBprRec.sc = "N"
   let FcastBprRec.cust_name = " "
   let FcastBprRec.iot = "North America"
   let FcastBprRec.market = " "
   let FcastBprRec.industry = " "
   let FcastBprRec.country = "United States"
   let FcastBprRec.brand_grp = "Analytics"
   let FcastBprRec.brand = "Analytics Platform"
   let FcastBprRec.prod_seg = " "
   let FcastBprRec.prod_fam = " "
   let FcastBprRec.brand_desc =" "
   let FcastBprRec.oppty_name = " "
   let FcastBprRec.oppty_num = " "
   let FcastBprRec.partner_led = " "
   let FcastBprRec.flow_code = " "
   let FcastBprRec.close_qtr = " "
   let FcastBprRec.exp_close_dt = null
   let FcastBprRec.bpr_fcast_stat = " "
   let FcastBprRec.rev = 0.0
   let FcastBprRec.odds = 0
   let FcastBprRec.ssm_step = " "
   let FcastBprRec.ceid = " "
   let FcastBprRec.part_name = " "
   let FcastBprRec.owning_org = " "
   let FcastBprRec.iemm = " "
   let FcastBprRec.report_to_sector = " "
   let FcastBprRec.crm_rev_type = " "
   let FcastBprRec.mgr = "Doug Connelly"
   let FcastBprRec.ssr = inSSR
   let FcastBprRec.lead_pass = " "
   let FcastBprRec.slip_deal = "N"
   let FcastBprRec.vad = " "
   let FcastBprRec.value_prop = " "
   let FcastBprRec.reason_act = " "
   let FcastBprRec.final_prop = " "
   let FcastBprRec.bp_own = " "
   let FcastBprRec.updtime = current

   return FcastBprRec.*

end function  #AddRow

{
function findIdx( inStr )
define
   inStr, outStr char(5120),
   keyStr char(100),
   valStr char(400),
   i,j,l smallint

   let i = 1
   let j = 2
   let l = length(inStr)
   initialize keyStr to NULL
   initialize valStr to NULL

#  locate '='
   while inStr[j,j] != '=' and j < l
      let j = j + 1
   end while

   if( i < j )then
      let keyStr = inStr[i,j-1]
   end if

   let i = j + 1
   let j = j + 1

#  locate '&'
   while inStr[j,j] != '&' and j < l
      let j = j + 1
   end while

#display "i: ", i, " j: ", j, " l: ", l
   if( i < j OR j = l )then
      if( j < l )then
         let valStr = inStr[i,j-1]
      else
         let valStr = inStr[i,j]
      end if
   end if

   if( j < l )then
      let j = j + 1
   end if

#  set outStr
   if( j < l )then
      let outStr = inStr[ j, l ]
   else
      let outStr = ""
   end if

   return keyStr, valStr, outStr

end function  #findIdx
}
