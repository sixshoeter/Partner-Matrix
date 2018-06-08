# March      10, 2017  John M. Shoemaker jshoe@us.ibm.com, created


globals "globals.4gl"

define
   tmpemail like fcast_bpr.email,
   tmppin like fcast_bpr.pin,
   tmptype char(1),
   rc, rowcnt smallint,
   c1,c2 char(6)

MAIN
define
   DataRec record like fcast_au.*,
   pname like coverage_au.part_name,
   DELIMIT char(1),
   inssr like fcast_au.ssr,
   updstr1, updstr2 char(20),
   eVar, kStr, vStr char(100),
   FCCRec record like fcast_comments_au.*,
   SQLStr char(2014),
   SQLStr2 char(512),
   i smallint,
   emailtype, pintype char(10),
   brand_line, prodseg_line, prodfam_line char(200),
   fc_cmt, rc_cmt char(4098)

call ReadCmdLn("home", 5)
call ProcCmdLn("home")
let DELIMIT=","

{
## extract ssr
let eVar = arg_val(5)

for i=1 to 40
   if( eVar[i]='=' )then
      let eVar=eVar[i+1,40]
      exit for
   end if
end for
#let inssr = CleanUp(eVar)
let tmpemail = CleanUp(eVar)
}

let eVar = CleanUp(arg_val(5))

## extract ssr
call findIdx( eVar ) returning kStr, vStr, eVar
let tmpemail = vStr clipped
#display "tmpemail: ", tmpemail

## extract fcast type
call findIdx( eVar ) returning kStr, vStr, eVar
let tmptype = vStr clipped
#display "tmptype: ", tmptype



let SQLStr="select count(*) from fcast_bpr where ssr='", tmpemail clipped, "'"
#display SQLStr
prepare FC0aID from SQLStr
execute FC0aID into rc
if( rc > 0 )then
   let emailtype="email"

   let SQLStr="select a.*, b.part_name from ", CtlRec.fcast_tab clipped, " a, ", cov_tab clipped, " b, ",
           "flu_ssmstep c ",
           "where a.ceid = b.ceid and a.ssr='", tmpemail clipped, "' ",
           "and a.ssm_step=c.ssmstep and c.export_filter!='Y' and a.ftype='", tmptype clipped, "' ",
           " union ",
           "select a.*, b.part_name from ", CtlRec.fcast_tab clipped, " a, ", cov_tab clipped, " b, ",
           "flu_ssmstep c ",
           "where a.ceid = b.ceid and a.mgr='", tmpemail clipped, "' ", 
           "and a.ssm_step=c.ssmstep and c.export_filter!='Y' and a.ftype='", tmptype clipped, "' ",
           "order by a.mgr, a.ssr, a.rev desc "
else  #rc <= 0
   let SQLStr = "select count(*) from fcast_bpr where ctp='", tmpemail clipped, "'"
#   display SQLStr
   prepare FC0bID from SQLStr
   execute FC0bID into rc

   if( rc > 0 )then
      let SQLStr="select a.*, b.part_name from ", CtlRec.fcast_tab clipped, " a, ", cov_tab clipped, " b, ",
           "flu_ssmstep c, fcast_bpr d ",
           "where a.ceid = b.ceid and a.ssr=d.ssr ",
           "and a.ceid = b.ceid and d.ctp='", tmpemail clipped, "' ",
           "and a.ssm_step=c.ssmstep and c.export_filter!='Y' and a.ftype='", tmptype clipped, "' ",
           "order by a.mgr, a.ssr, a.rev desc "
   else
      let emailtype="xxxxx"
      let pintype="xxxxx"
      let SQLStr=""
   end if #rc>0 for ctp
end if  #rc>0 for sales

#display SQLStr
prepare ID1 from SQLStr
declare ID1Curs cursor for ID1

   display 
           "PASS UP LINE?", DELIMIT,
           "Manage in SC?", DELIMIT,
           "Customer Name", DELIMIT,
           "Reports to IOT", DELIMIT,
           "Market", DELIMIT,
           "Reporting Country", DELIMIT,
           "Brand Group", DELIMIT,
           "Brand", DELIMIT,
           "Product Segment", DELIMIT,
           "Product Family", DELIMIT,
           "Brand Description", DELIMIT,
           "Opportunity Name", DELIMIT,
           "Opportunity Number", DELIMIT,
           "Partner Led Y/N", DELIMIT,
           "Flow Code", DELIMIT,
           "Close Qtr", DELIMIT,
           "Expected Close Date", DELIMIT,
           "BP Rep Forecast Status", DELIMIT,
           "Latest Rev Amount USD ($M)", DELIMIT,
           "Odds", DELIMIT,
           "SSM Step Name", DELIMIT,
           "BP Name", DELIMIT,
           "Owning Org", DELIMIT,
           "IEMM", DELIMIT,
           "Report to Sector Code", DELIMIT,
           "CRM Revenue Type", DELIMIT,
           "Manager", DELIMIT,
           "Rep", DELIMIT,
           "Forecast Comments", DELIMIT,
           "Lead Pass", DELIMIT,
           "Slip Deal", DELIMIT,
           "VAD", DELIMIT,
           "Risk Comment", DELIMIT,
           "Unique Business Value", DELIMIT,
           "Value Proposition", DELIMIT,
           "Compelling Reeason to Act", DELIMIT,
           "Final Proposal", DELIMIT,
           "BP Owned"

foreach ID1Curs into DataRec.*, pname

## build forecast comment string
   let fc_cmt=""
   let SQLStr2="select a.* from fcast_comments_au a where a.fcast_id=", DataRec.fcast_id,
               " and a.fcast_comment_type='F' order by updtime desc"
   prepare FCID from SQLStr2
   declare FCCurs cursor for FCID
   foreach FCCurs into FCCRec.*
      let fc_cmt=fc_cmt clipped, "[", FCCRec.updtime, "]", FCCRec.fcast_comment clipped, ";"
   end foreach
   
   let rc_cmt=""
   let SQLStr2="select a.* from fcast_comments_au a where a.fcast_id=", DataRec.fcast_id,
               " and a.fcast_comment_type='R' order by updtime desc"
   prepare RCID from SQLStr2
   declare RCCurs cursor for RCID
   foreach RCCurs into FCCRec.*
      let rc_cmt=rc_cmt clipped, "[", FCCRec.updtime, "]", FCCRec.fcast_comment clipped, ";"
   end foreach

## populate brand line
   if( DataRec.brand is not null and DataRec.brand != " " )then
      let brand_line = DataRec.brand
   end if
   if( DataRec.brand2 is not null and DataRec.brand2 != " " )then
      let brand_line = brand_line clipped, "; ", DataRec.brand2
   end if
   if( DataRec.brand3 is not null and DataRec.brand3 != " " )then
      let brand_line = brand_line clipped, "; ", DataRec.brand3
   end if

## populate product segment line
   if( DataRec.prod_seg is not null and DataRec.prod_seg != " " )then
      let prodseg_line = DataRec.prod_seg
   end if
   if( DataRec.prod_seg2 is not null and DataRec.prod_seg2 != " " )then
      let prodseg_line = prodseg_line clipped, "; ", DataRec.prod_seg2
   end if
   if( DataRec.prod_seg3 is not null and DataRec.prod_seg3 != " " )then
      let prodseg_line = prodseg_line clipped, "; ", DataRec.prod_seg3
   end if

## populate product family line
   if( DataRec.prod_fam is not null and DataRec.prod_fam != " " )then
      let prodfam_line = DataRec.prod_fam
   end if
   if( DataRec.prod_fam2 is not null and DataRec.prod_fam2 != " " )then
      let prodfam_line = prodfam_line clipped, "; ", DataRec.prod_fam2
   end if
   if( DataRec.prod_fam3 is not null and DataRec.prod_fam3 != " " )then
      let prodfam_line = prodfam_line clipped, "; ", DataRec.prod_fam3
   end if

   display 
      '"', DataRec.pass_on clipped, '"', DELIMIT,
      '"', DataRec.sc clipped, '"', DELIMIT,
      '"', DataRec.cust_name clipped, '"', DELIMIT,
      '"', DataRec.iot clipped, '"', DELIMIT,
      '"', DataRec.market clipped, '"', DELIMIT,
      '"', DataRec.country clipped, '"', DELIMIT,
      '"', DataRec.brand_grp clipped, '"', DELIMIT,
      '"', brand_line clipped, '"', DELIMIT,
      '"', prodseg_line clipped, '"', DELIMIT,
      '"', prodfam_line clipped, '"', DELIMIT,
      '"', DataRec.brand_desc clipped, '"', DELIMIT,
      '"', DataRec.oppty_name clipped, '"', DELIMIT,
      '"', DataRec.oppty_num clipped, '"', DELIMIT,
      '"', DataRec.partner_led clipped, '"', DELIMIT,
      '"', DataRec.flow_code clipped, '"', DELIMIT,
      '"', DataRec.close_qtr clipped, '"', DELIMIT,
      '"', DataRec.exp_close_dt, '"', DELIMIT,
      '"', DataRec.bpr_fcast_stat clipped, '"', DELIMIT,
           DataRec.rev, DELIMIT,
           DataRec.odds, DELIMIT,
      '"', DataRec.ssm_step clipped, '"', DELIMIT,
      '"', pname clipped, '"', DELIMIT,
      '"', DataRec.owning_org clipped, '"', DELIMIT,
      '"', DataRec.iemm clipped, '"', DELIMIT,
      '"', DataRec.report_to_sector clipped, '"', DELIMIT,
      '"', DataRec.crm_rev_type clipped, '"', DELIMIT,
      '"', DataRec.mgr clipped, '"', DELIMIT,
      '"', DataRec.ssr clipped, '"', DELIMIT,
      '"', fc_cmt clipped, '"', DELIMIT,
      '"', DataRec.lead_pass clipped, '"', DELIMIT,
      '"', DataRec.slip_deal clipped, '"', DELIMIT,
      '"', DataRec.vad clipped, '"', DELIMIT,
      '"', rc_cmt clipped, '"', DELIMIT,
      '"', '"', DELIMIT,
      '"', DataRec.value_prop clipped, '"', DELIMIT,
      '"', DataRec.reason_act clipped, '"', DELIMIT,
      '"', DataRec.final_prop clipped, '"', DELIMIT,
      '"', DataRec.bp_own clipped, '"'
       
  
end foreach


END MAIN

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
