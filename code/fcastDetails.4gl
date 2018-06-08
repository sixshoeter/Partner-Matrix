globals "globals.4gl"

define
   tmpssr like fcast_au.ssr,
   tmptype char(1),
   tmptypedesc char(10)
   
main
define
   FcastBprRec record like fcast_bpr.*,
   FcastRec record like fcast_au.*,
   tmpid like fcast_au.fcast_id,
   tmppin like fcast_bpr.pin,
   SSRname like fcast_au.ssr,
   eVar char(100),
   kStr, vStr char(100),
   i,j smallint,
   revArr array[5] of float,
   revttl float,
   newRec smallint,
   SQLStr char(128)

call ReadCmdLn( "fcastDetails", 4 )
call ProcCmdLn( "fcastDetails" )
call Header(30, IRec.i_id, BRec.b_id, 0)

## extract fcast id
let eVar = CleanUp(arg_val(4))
call findIdx( eVar ) returning kStr, vStr, eVar
let tmpid = vStr clipped
#for i=1 to 30
#   if( eVar[i]='=' )then
#      let eVar=eVar[i+1,30]
#      exit for
#   end if
#end for

## extract ssr
call findIdx( eVar ) returning kStr, vStr, eVar
let tmpssr = vStr clipped

## extract fcast type
call findIdx( eVar ) returning kStr, vStr, eVar
let tmptype = vStr clipped

##extract pin
#call findIdx( eVar ) returning kStr, vStr, eVar
#let tmppin = vStr clipped

#display "fcast_id: ", tmpid
#display "ssr     : ", tmpssr
#display "pin     : ", tmppin
#display "eVar: ", eVar clipped

if( tmptype="C")then
   let tmptypedesc="UPDATE"
else
   let tmptypedesc="VIEW"
end if  #tmptype

if( tmpid>0 )then
   let newRec = FALSE
   let SQLStr = "select a.* from fcast_au a where a.fcast_id=", tmpid clipped, ";"
   prepare FCID from SQLStr
   declare FCCurs cursor for FCID
else
   let newRec = TRUE
   let FcastRec.fcast_id=0
end if
display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", tmptypedesc clipped, " FORECAST </span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, "</span></em></div>"
display "<p>"

display "<FORM ID='fcast_upd' ACTION='/cgi-bin/fcastDetailsUpd", BRec.b_id clipped, ".ksh' method='post'>"
display "<INPUT NAME='form' TYPE=hidden READONLY VALUE=975><br>"
display "This action will update your Forecast.<br>"
display "<table>"

let i=1
if( newRec )then
#display "New Record"
   call AddRow("") returning FcastRec.*
   let FcastRec.ssr=tmpssr
   call DispRec(FcastRec.*)
else
#display "Existing Record"
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
end if

display "</table>"
display "#", FcastRec.fcast_id using '<<<<<', "<br>"
#display "Enter New Comments Here: "
display "<label><b><i>Enter New Comments Here</i></b></label><br>"
display "<input type='radio' name='NCtype' id='F' value='F' checked = 'checked' />"
display "<label for = 'F'>FORECAST Comment</label><br />"
display "<input type='radio' name='NCtype' id='R' value='R' />"
display "<label for = 'R'>RISK Comment</label><br />"

display "<textarea name=newcomment rows='20' cols='83'></textarea>"
#display "<td><INPUT TYPE=text cols=83 rows=6 NAME=newcomment ></td>"
if( tmptype="C" )then
   display "<INPUT TYPE=submit VALUE='Submit'>"
end if
display "</FORM>"
display "<p>"
display "<label><b><i>Comment History: (F)-Forecast Comment, (R)-Risk Comment</i></b></label><p>"
call ShowComments( FcastRec.fcast_id )

end main

function ShowComments( inID )
define
   inID integer,
   FCCRec record like fcast_comments_au.*,
   SQLStr char(256)

   let SQLStr = "select a.* from fcast_comments_au a where a.fcast_id=", inID, " order by a.updtime desc"
   prepare SC1ID from SQLStr
   declare SC1Curs cursor for SC1ID

   display "<table>"
   foreach SC1Curs into FCCRec.*
      display "<tr><td style='width: 120px'>", FCCRec.updtime, "</td>"
#      if( FCCRec.fcast_comment_type="F" )then display "Forecast Comment" end if
#      if( FCCRec.fcast_comment_type="R" )then display "Risk Comment" end if
      display "<td>(", FCCRec.fcast_comment_type clipped, ")", FCCRec.fcast_comment, "</td></tr>"
   end foreach
   display "</table>"


end function  #ShowComments


function DispRec(FcastRec)
define
   FcastRec record like fcast_au.*

#   display "<tr><td><INPUT TYPE=text size='1' VALUE='", FcastRec.sc clipped, "'></td>"
display "<INPUT NAME='fcast_id' TYPE=hidden READONLY VALUE=", FcastRec.fcast_id using '######&', "><br>"
display "<INPUT NAME='updperson' TYPE=hidden READONLY VALUE='", tmpssr clipped, "'><br>"

{
##LINE 0
   display "<tr><td>Opportunity State:</td>"
   call ListBoxOpptyStat( FcastRec.oppty_stat )
}
##LINE 1
   display "</tr><tr>"
   display "<td>Customer:</td><td><INPUT TYPE=text size='60' NAME=cust_name VALUE='", FcastRec.cust_name clipped, "'></td>"
   display "<td>Partner:</td>"
   call ListBoxPartners( FcastRec.ceid )
   display "<td>Partner Led:"
   call ListBoxFcastYN( FcastRec.partner_led )
   display "<td>Partner Owned:</td>"
   call ListBoxFcastYN( FcastRec.bp_own )

##LINE 2
   display "</tr><tr>"
   display "<td>IOT:</td>"
   call ListBoxIOT( FcastRec.iot )
   display "<td>Market:</td>"
   call ListBoxFcastMkt( FcastRec.market )
   display "<td>Rept To Country:</td>"
   call ListBoxCountry( FcastRec.country )

##LINE 3
   display "</tr><tr>"
   display "<td>Brand Group:</td>"
   call ListBoxBrandGrp( FcastRec.brand_grp )

#LINE 4A
   display "</tr><tr>"
   display "<td>Brand 1:</td>"
   call ListBoxBrand( FcastRec.brand )
   display "<td>Brand 2:</td>"
   call ListBoxBrand( FcastRec.brand2 )
   display "<td>Brand 3:</td>"
   call ListBoxBrand( FcastRec.brand3 )

#LINE 4B
   display "</tr><tr>"
   display "<td>Prod Seg 1:</td>"
   call ListBoxProdSeg( FcastRec.prod_seg )
   display "<td style='width: 120px'>Prod Seg 2:</td>"
   call ListBoxProdSeg( FcastRec.prod_seg2 )
   display "<td>Prod Seg 3:</td>"
   call ListBoxProdSeg( FcastRec.prod_seg3 )

#LINE 4C
   display "</tr><tr>"
   display "<td>Prod Fam 1:</td>"
   call ListBoxProdFam( FcastRec.prod_fam )
   display "<td>Prod Fam 2:</td>"
   call ListBoxProdFam( FcastRec.prod_fam2 )
   display "<td>Prod Fam 3:</td>"
   call ListBoxProdFam( FcastRec.prod_fam3 )

#LINE
   display "</tr><tr>"

   display "<td>Brand Desc:</td>"
   display "<td><INPUT TYPE=text size='40' NAME=brand_desc VALUE='", FcastRec.brand_desc clipped, "'></td>"
##LINE 5
   display "</tr><tr>"
   display "<td>Oppty Name:</td>"
   display "<td><INPUT TYPE=text size='50' NAME=oppty_name VALUE='", FcastRec.oppty_name clipped, "'></td>"
   display "<td>Oppty Num:</td>"
   display "<td><INPUT TYPE=text size='10' NAME=oppty_num VALUE='", FcastRec.oppty_num clipped, "'></td>"
   display "<td>In SC:</td>"
   call ListBoxFcastYN( FcastRec.sc )

##LINE 6
   display "</tr><tr>"
   display "<td>Flow Code:</td>"
   call ListBoxFlowCode( FcastRec.flow_code )
   display "<td>Close Qtr:</td>"
   call ListBoxQtr( FcastRec.close_qtr )
   if( FcastRec.exp_close_dt > today or FcastRec.bpr_fcast_stat='Won')then
      display "<td>Exp Close Dt:</td>"
   else
      display "<td bgcolor='#FF0000'>Exp Close Dt:</td>"
   end if
   display "<td><INPUT TYPE=date size='10' NAME=exp_close_dt VALUE='", FcastRec.exp_close_dt using "mm/dd/yyyy", "'></td>"

##LINE 7
   display "</tr><tr>"
   display "<td>BPR Stat:</td>"
   call ListBoxStatus( FcastRec.bpr_fcast_stat )
   display "<td>Revenue ($M):</td>"
   display "<td><INPUT TYPE=text min=0 max=100 NAME=rev VALUE=", FcastRec.rev using "#####&.&&&", "></td>"
   display "<td>Odds:</td>"
   display "<td><INPUT TYPE=number size='3' NAME=odds VALUE=", FcastRec.odds clipped, "></td>"

##LINE 8
   display "</tr><tr>"
   display "<td>SSM Step:</td>"
   call ListBoxSSMStep( FcastRec.ssm_step )
   display "<td>Owning Org:</td>"
   call ListBoxOwningOrg( FcastRec.owning_org )
   display "<td>IEMM:</td>"
   display "<td><INPUT TYPE=text size='10' NAME=iemm VALUE='", FcastRec.iemm clipped, "'></td>"

##LINE 9
   display "</tr><tr>"
   display "<td>Report to Sector:</td>"
   display "<td><INPUT TYPE=text size='10' NAME=report_to_sector VALUE='", FcastRec.report_to_sector clipped, "'></td>"
   display "<td>Revenue Type:</td>"
   call ListBoxRevType( FcastRec.crm_rev_type )
#   display "<td>:</td>"

##LINE 10
   display "</tr><tr>"
   display "<td>Manager:</td>"
   call ListBoxGSIMgr( FcastRec.mgr )
   display "<td>Rep:</td>"
   call ListBoxGSISSR( FcastRec.ssr )
   display "<td>VAD:</td>"
   call ListBoxVAD2( FcastRec.vad )

##LINE 11
   display "</tr><tr>"
   display "<td>Lead Pass:</td>"
   call ListBoxFcastYN( FcastRec.lead_pass )
   display "<td>Slip Deal:</td>"
   call ListBoxFcastYN( FcastRec.slip_deal )
#   display "<td>:</td>"

##LINE 12
   display "</tr><tr>"
   display "<td>Value Prop:</td>"
   display "<td><INPUT TYPE=text size='30' NAME=value_prop VALUE='", FcastRec.value_prop clipped, "'></td>"
   display "<td>Reason Act:</td>"
#   display "<td><INPUT TYPE=text size='20' NAME=reason_act VALUE='", FcastRec.reason_act clipped, "'></td>"
   display "<td><textarea name=reason_act rows='7' cols='35'>", FcastRec.reason_act clipped, "</textarea></td>"
   display "<td>Final Prop:</td>"

#   display "<td><INPUT TYPE=text size='30' NAME=final_prop VALUE='", FcastRec.final_prop clipped, "'></td>"
   display "<td><textarea name=final_prop rows='7' cols='35'>", FcastRec.final_prop clipped, "</textarea></td>"

##LINE 13
   display "</tr><tr>"
   display "<td>Share To Upline:</td>"
   call ListBoxFcastYN( FcastRec.pass_on )
   display "<td>CURRENT or ARCHIVE:</td>"
   call ListBoxArchive( FcastRec.ftype )
{
           "<th>Comments</th>",
           "<th>BP Owned</th>",
           "</tr>"
}


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

#   display "<td><INPUT TYPE=text size='1' VALUE='", FcastRec.slip_deal clipped, "'></td>"
#   display "<td><INPUT TYPE=text size='10' VALUE='", FcastRec.vad clipped, "'></td>"

#   display "<td><INPUT TYPE=text size='1' VALUE='", FcastRec.bp_own clipped, "'></td>"
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
   inSel like market.m_name,
   sqlStr char(128),
   tssr like market.m_name,
   tmp smallint

   let sqlStr = "select unique a.m_name, a.ord from market a order by a.ord"
   prepare LBFCMID from sqlStr
   declare LBFCMCurs cursor for LBFCMID

   display "<td><SELECT NAME='market'>"
#   display "<td><INPUT TYPE=text size='35' VALUE='", FcastRec.market clipped, "'></td>"

   display "<OPTION>"
   foreach LBFCMCurs into tssr, tmp
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

function ListBoxArchive( inSel )
define
   inSel char(1)

   display "<td><SELECT NAME='ca'>"

   display "<OPTION>"
   if( inSel = "C" )then
      display "<OPTION SELECTED>C"
   else
   display "<OPTION>C"
   end if
   if( inSel = "A" )then
      display "<OPTION SELECTED>A"
   else
      display "<OPTION>A"
   end if

   display "</SELECT></td>"
end function  #ListBoxArchive

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

#   display "<OPTION>"
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

{
function ListBoxOpptyStat( inSel )
define
   inSel like flu_oppty_stat.oppty_stat,
   sqlStr char(128),
   tssr like flu_oppty_stat.oppty_stat,
   tmp smallint

   let sqlStr = "select unique a.oppty_stat, a.ord from flu_oppty_stat a ",
                 " order by a.ord"
   prepare LBFLUfID from sqlStr
   declare LBFLUfCurs cursor for LBFLUfID

   display "<td><SELECT NAME='oppty_stat'>"

   display "<OPTION>"
   foreach LBFLUfCurs into tssr, tmp
   if( inSel = tssr )then
      display "<OPTION SELECTED>", tssr clipped
   else
      display "<OPTION>",tssr clipped
   end if

   end foreach

   display "</SELECT></td>"
end function  #ListBoxOpptyStat
}

#####################################################################
function AddRow(inSSR)
define
   inSSR like fcast_au.ssr,
   FcastBprRec record like fcast_au.*

   initialize FcastBprRec.* to NULL

   let FcastBprRec.fcast_id = 0
#   let FcastBprRec.oppty_stat = "Active"
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
   let FcastBprRec.partner_led = "Y"
   let FcastBprRec.flow_code = " "
   let FcastBprRec.close_qtr = " "
   let FcastBprRec.exp_close_dt = null
   let FcastBprRec.bpr_fcast_stat = " "
   let FcastBprRec.rev = 0.0
   let FcastBprRec.odds = 0
   let FcastBprRec.ssm_step = "03-Identified/Validating"
   let FcastBprRec.ceid = " "
   let FcastBprRec.part_name = " "
   let FcastBprRec.owning_org = "Business Partners"
   let FcastBprRec.iemm = "Enterprise"
   let FcastBprRec.report_to_sector = "Enterprise"
   let FcastBprRec.crm_rev_type = " "
   let FcastBprRec.mgr = "Doug Connelly"
   let FcastBprRec.ssr = inSSR
   let FcastBprRec.lead_pass = "N"
   let FcastBprRec.slip_deal = "N"
   let FcastBprRec.vad = " "
   let FcastBprRec.value_prop = " "
   let FcastBprRec.reason_act = " "
   let FcastBprRec.final_prop = " "
   let FcastBprRec.bp_own = " "
   let FcastBprRec.pass_on = "N"
   let FcastBprRec.ftype = "C"
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
