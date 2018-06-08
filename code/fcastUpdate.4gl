globals "globals.4gl"

main
define
   FcastBprRec record like fcast_bpr.*,
   FcastRec record like fcast_au.*,
   SSRname like fcast_au.ssr,
   eVar char(30),
   i,j smallint,
   revArr array[5] of float,
   revttl float,
   SQLStr char(128)

call ReadCmdLn( "fcastUpdate", 4 )
call ProcCmdLn( "fcastUpdate" )
call Header(0, IRec.i_id, BRec.b_id, 1)

## extract email address
let eVar = CleanUp(arg_val(4))
let eVar = eVar[8,30]
for i=1 to 30
if(eVar[i]="&")then
   exit for
end if
end for
let eVar=eVar[1,i-1]

let SQLStr = "select a.* from fcast_au a, fcast_bpr b where a.ssr=b.ssr and b.brand='", 
              BRec.b_id clipped, "' and b.email='", eVar clipped, "'"
prepare FCID from SQLStr
declare FCCurs cursor for FCID
display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>UPDATE FORECAST </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, "</span></em></div>"
display "<p>"

display "<FORM ID='fcast_upd' ACTION='/cgi-bin/fcastUpd", BRec.b_id clipped, ".ksh' method='post'>"
display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=950><br>"
display "This action will update your Forecast.<br>"
display "<table>"

## header
   display "<tr><th>Manage in SC?</th>",
           "<th>Customer Name</th>",
           "<th>IOT:</th>",
           "<th>Market</th>",
           "<th>Industry</th>",
           "<th>Reporting to Country</th>",
           "<th>Brand Group</th>",
           "<th>Brand </th>",
           "<th>Product Segment</th>",
           "<th>Product Family</th>",
           "<th>Brand Desc</th>",
           "<th>Opty Name</th>",
           "<th>Opty Number</th>",
           "<th>Partner Led?</th>",
           "<th>Flow Code</th>",
           "<th>Close Qtr</th>",
           "<th>Exp Close Dt</th>",
           "<th>BPR Fcast Status</th>",
           "<th>Revenue</th>",
           "<th>Odds</th>",
           "<th>SSM Step</th>",
#           "<th>CEID</th>",
           "<th>Partner Name</th>",
           "<th>Owning Org</th>",
           "<th>IEMM</th>",
           "<th>Report to Sector</th>",
           "<th>Revenue Type</th>",
           "<th>Manager</th>",
           "<th>Rep</th>",
#           "<th>Comments</th>",
           "<th>Lead Pass</th>",
           "<th>Slip Deal</th>",
           "<th>VAD</th>",
           "<th>Value Prop</th>",
           "<th>Compelling Reason</th>",
           "<th>Final Proposal</th>",
           "<th>BP Owned</th>",
           "</tr>"
for i=1 to 5
   let revArr[i]=0.0
end for
let revttl = 0.0

let i=1
foreach FCCurs into FcastRec.*
   if( i=1 )then
      let SSRname=FcastRec.ssr
   end if
   call DispRec(FcastRec.*)
   case FcastRec.close_qtr
      when "Q1"
         let revArr[1]=revArr[1]+(FcastRec.rev*1000000)
      when "Q2"
         let revArr[2]=revArr[2]+(FcastRec.rev*1000000)
      when "Q3"
         let revArr[3]=revArr[3]+(FcastRec.rev*1000000)
      when "Q4"
         let revArr[4]=revArr[4]+(FcastRec.rev*1000000)
      otherwise
         let revArr[5]=revArr[5]+(FcastRec.rev*1000000)
   end case
   let i=1+1
end foreach

call AddRow(SSRname) returning FcastRec.*
call DispRec(FcastRec.*)

display "</table>"
display "<INPUT TYPE=submit VALUE='Submit'>"
display "</FORM>"
display "<p>"
display "Summary:<p>"
let revttl = revArr[1]+revArr[2]+revArr[3]+revArr[4]+revArr[5]
display "Forecast Total: ", revttl using "$$$,$$$,$$$", "<br>"
if( revArr[1] > 0.0 )then display "   Q1: ", revArr[1] using "$$$,$$$,$$$", "<br>" end if
if( revArr[2] > 0.0 )then display "   Q2: ", revArr[2] using "$$$,$$$,$$$", "<br>" end if
if( revArr[3] > 0.0 )then display "   Q3: ", revArr[3] using "$$$,$$$,$$$", "<br>" end if
if( revArr[4] > 0.0 )then display "   Q4: ", revArr[4] using "$$$,$$$,$$$", "<br>" end if
if( revArr[5] > 0.0 )then display "     : ", revArr[5] using "$$$,$$$,$$$", "<p>" end if


end main

function DispRec(FcastRec)
define
   FcastRec record like fcast_au.*

#   display "<tr><td><INPUT TYPE=text size='1' VALUE='", FcastRec.sc clipped, "'></td>"
   display "<tr>"
   display "<INPUT NAME='fcast_id' TYPE=hidden READONLY VALUE=", FcastRec.fcast_id using '######&', "><br>"
call ListBoxFcastYN( FcastRec.sc )
   display "<td><INPUT TYPE=text size='60' NAME=cust_name VALUE='", FcastRec.cust_name clipped, "'></td>"
#   display "<td><INPUT TYPE=text size='15' VALUE='", FcastRec.iot clipped, "'></td>"
call ListBoxIOT( FcastRec.iot )

#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.industry clipped, "'></td>"
call ListBoxFcastMkt( FcastRec.market )
if( FcastRec.market = " " )then
   call ListBoxFcastIndAll( FcastRec.market, FcastRec.industry )
else
   call ListBoxFcastInd( FcastRec.market, FcastRec.industry )
end if  #market is blank
#   display "<td><INPUT TYPE=text size='15' VALUE='", FcastRec.country clipped, "'></td>"
call ListBoxCountry( FcastRec.country )
#   display "<td><INPUT TYPE=text size='10' VALUE='", FcastRec.brand_grp clipped, "'></td>"
call ListBoxBrandGrp( FcastRec.brand_grp )
call ListBoxBrand( FcastRec.brand )
#   display "<td><INPUT TYPE=text size='50' NAME=prod_seg VALUE='", FcastRec.prod_seg clipped, "'></td>"
call ListBoxProdSeg( FcastRec.prod_seg )
#   display "<td><INPUT TYPE=text size='30' NAME=prod_fam VALUE='", FcastRec.prod_fam clipped, "'></td>"
call ListBoxProdFam( FcastRec.prod_fam )
   display "<td><INPUT TYPE=text size='40' NAME=brand_desc VALUE='", FcastRec.brand_desc clipped, "'></td>"
   display "<td><INPUT TYPE=text size='50' NAME=oppty_name VALUE='", FcastRec.oppty_name clipped, "'></td>"
   display "<td><INPUT TYPE=text size='10' NAME=oppty_num VALUE='", FcastRec.oppty_num clipped, "'></td>"
#   display "<td><INPUT TYPE=text size='1' VALUE='", FcastRec.partner_led clipped, "'></td>"
call ListBoxFcastYN( FcastRec.partner_led )
#   display "<td><INPUT TYPE=text size='10' VALUE='", FcastRec.flow_code clipped, "'></td>"
call ListBoxFlowCode( FcastRec.flow_code )
#   display "<td><INPUT TYPE=text size='2' NAME=close_qtr VALUE='", FcastRec.close_qtr clipped, "'></td>"
call ListBoxQtr( FcastRec.close_qtr )
   display "<td><INPUT TYPE=date size='10' NAME=exp_close_dt VALUE='", FcastRec.exp_close_dt using "mm/dd/yyyy", "'></td>"
#   display "<td><INPUT TYPE=text size='11' VALUE='", FcastRec.bpr_fcast_stat clipped, "'></td>"
call ListBoxStatus( FcastRec.bpr_fcast_stat )
   display "<td><INPUT TYPE=text min=0 max=100 NAME=rev VALUE=", FcastRec.rev, "></td>"
   display "<td><INPUT TYPE=number size='3' NAME=odds VALUE=", FcastRec.odds clipped, "></td>"
#   display "<td><INPUT TYPE=text size='40' VALUE='", FcastRec.ssm_step clipped, "'></td>"
call ListBoxSSMStep( FcastRec.ssm_step )
#   display "<td><INPUT TYPE=text size='10' NAME=ceid VALUE='", FcastRec.ceid clipped, "'></td>"
call ListBoxPartners( FcastRec.ceid )
#   display "<td><INPUT TYPE=text size='30' VALUE='", FcastRec.part_name clipped, "'></td>"
#   display "<td><INPUT TYPE=text size='20' NAME=owning_org VALUE='", FcastRec.owning_org clipped, "'></td>"
call ListBoxOwningOrg( FcastRec.owning_org )
   display "<td><INPUT TYPE=text size='10' NAME=iemm VALUE='", FcastRec.iemm clipped, "'></td>"
   display "<td><INPUT TYPE=text size='10' NAME=report_to_sector VALUE='", FcastRec.report_to_sector clipped, "'></td>"
#   display "<td><INPUT TYPE=text size='20' VALUE='", FcastRec.crm_rev_type clipped, "'></td>"
call ListBoxRevType( FcastRec.crm_rev_type )
#   display "<td><INPUT TYPE=text size='40' VALUE='", FcastRec.mgr clipped, "'></td>"
call ListBoxGSIMgr( FcastRec.mgr )
#   display "<td><INPUT TYPE=text size='40' VALUE='", FcastRec.ssr clipped, "'></td>"
call ListBoxGSISSR( FcastRec.ssr )
{
display "<td>"
display "<a href='' target ='_blank'>View/Add Comments</a>"
display "</td>"
}
{
display "<td>"
display "<FORM ID='fcast_comment_upd' ACTION='/cgi-bin/XXXXXUpd", BRec.b_id clipped, ".ksh' method='post'>"
display "<INPUT NAME='form-cmt' TYPE=hidden READONLY VALUE=960><br>"
display "<INPUT TYPE=submit VALUE='View/Add Comments'>"
display "</form>"
display "</td>"
}
#   display "<td><INPUT TYPE=text size='1' VALUE='", FcastRec.lead_pass clipped, "'></td>"
call ListBoxFcastYN( FcastRec.lead_pass )

#   display "<td><INPUT TYPE=text size='1' VALUE='", FcastRec.slip_deal clipped, "'></td>"
call ListBoxFcastYN( FcastRec.slip_deal )
#   display "<td><INPUT TYPE=text size='10' VALUE='", FcastRec.vad clipped, "'></td>"
call ListBoxVAD2( FcastRec.vad )

   display "<td><INPUT TYPE=text size='30' NAME=value_prop VALUE='", FcastRec.value_prop clipped, "'></td>"
   display "<td><INPUT TYPE=text size='20' NAME=reason_act VALUE='", FcastRec.reason_act clipped, "'></td>"
   display "<td><INPUT TYPE=text size='30' NAME=final_prop VALUE='", FcastRec.final_prop clipped, "'></td>"
#   display "<td><INPUT TYPE=text size='1' VALUE='", FcastRec.bp_own clipped, "'></td>"
call ListBoxFcastYN( FcastRec.bp_own )
   display "</tr>"
end function  #DispRec

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

function ListBoxPartners( inSel )
define
   inSel like coverage_au.ceid,
   sqlStr char(128),
   tceid like coverage_au.ceid,
   tssr like coverage_au.part_name

   let sqlStr = "select unique a.ceid, a.part_name from ", cov_tab clipped, " a where a.reseller='G' ",
                 " order by 2"
   prepare LBFCPID from sqlStr
   declare LBFCPCurs cursor for LBFCPID

   display "<td><SELECT NAME='ceid'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFCPCurs into tceid, tssr
   if( inSel = tceid )then
      display "<OPTION SELECTED value='", tceid clipped, "'>",tssr clipped
   else
      display "<OPTION value='", tceid clipped, "'>", tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
#   return tssr

end function  #ListBoxPartners


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
   let FcastBprRec.sc = " "
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

