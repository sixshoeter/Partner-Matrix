

## 03/06/2017  John M. Shoemaker, jshoemaker1@cox.net - created fcastUpd.4gl file
## February  07, 2018 John M. Shoemaker jshoemaker1@cox.net, add home_dir, #311

globals "globals.4gl"

define
   fcastRec record like fcast_au.*,
   InRec record
      form char(5),
      ceid like coverage_au.ceid,
      brand like brands.b_id,
      p_name like coverage_au.p_name,
      p_title like coverage_au.p_title,
      p_phone like coverage_au.p_phone,
      p_email like coverage_au.p_email,
      hq like coverage_au.hq,
      part_type like coverage_au.part_type,
      reseller like coverage_au.reseller,
      vad like coverage_au.vad,
      url like coverage_au.url,
      pwp like coverage_au.pwp,
      hunter like coverage_au.hunter,
      commercial like coverage_au.commercial,
      partners_well like coverage_au.partners_well,
      focus1 like coverage_au.focus1,
      focus2 like coverage_au.focus2,
      focus3 like coverage_au.focus3,
      ssr like coverage_au.ssr,
      ctp1 like coverage_au.ctp1,
      ctp2 like coverage_au.ctp2,
      ctp3 like coverage_au.ctp3,
      ctp4 like coverage_au.ctp4,
      ctp5 like coverage_au.ctp5,
      keyArr array[30] of char(20),
      valArr array[30] of char(20),
      chgArr array[30] of smallint
   end record

main
define
   i,j,l,iidx,nidx smallint,
   nSArr array[34] of smallint,
   cmdStr char(5120),
   eidx smallint,
   wStr char(5120),
   kStr char(5120),
   vStr char(5120),
   SQLStr char(5120),
   UPDStr char(5120),
   dStr char(5120),
   multi smallint,
   runStr char(512),
   tStr char(100),
   addTS smallint,
   ossr, nssr like coverage_au.ssr


#call ReadCmdLn( "updSkills", 34 )
call ReadCmdLn( "fcastUpd", 5 )
call ProcCmdLn( "fcastUpd" )
#call Header(0, IRec.i_id, BRec.b_id, 1)
let cmdStr = arg_val(5)

#set to NULL
for i = 1 to 30
   initialize InRec.keyArr[ i ] to NULL
   initialize InRec.valArr[ i ] to NULL
   let InRec.chgArr[ i ] = FALSE
end for


let addTS = TRUE   # default to adding a timestamp

#display "cmdStr: ", cmdStr clipped

## extract the FORM TYPE
call findIdx( cmdStr ) returning kStr, vStr, wStr
let InRec.form = vStr
#display "kStr: ", kStr
#display "vStr: ", vStr

## extract the CEID
#call findIdx( wStr ) returning kStr, vStr, wStr
#let InRec.ceid = vStr
#display "kStr: ", kStr clipped, "<br>"
#display "vStr: ", vStr clipped, "<br>"
#display "wStr: ", wStr clipped, "<br>"
#display "CEID: ", InRec.ceid clipped, "<br>"

#display "ceid: ", InRec.ceid, "<br>"
#display "brand: ", InRec.brand, "<br>"
#for i = 1 to 30
#   if( InRec.valArr[ i ] is not NULL )then
#      display InRec.valArr[ i ], "<br>"
#   end if
#end for

## load the current skill record
#let SQLStr = "select a.* from skills_", InRec.brand clipped, " a where a.ceid='", InRec.ceid clipped, "'"
#prepare CM1ID from SQLStr
#execute CM1ID into SkillRec.*

# build UPDStr
let multi = FALSE
#if( ChangesMade() )then

initialize fcastRec.* to NULL
 
case 
   when InRec.form = "950"
#      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
#      let fcastRec.sc = vStr clipped
       call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
       let l = length( wStr )
       let fcastRec.fcast_id = vStr clipped

#      while( vStr is not NULL )
      let i = 1
      while( l > 1 )

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.sc = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.cust_name = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.iot = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.market = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.industry = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.country = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.brand_grp = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.brand = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.prod_seg = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.prod_fam = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.brand_desc = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.oppty_name = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.oppty_num = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.partner_led = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.flow_code = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.close_qtr = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.exp_close_dt = CleanUp(vStr)

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.bpr_fcast_stat = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "vStr (before): ", vStr clipped, " rev: ", fCastRec.rev
         if( vStr != " " )then
            let fcastRec.rev = vStr clipped
#display "vStr (inside): ", vStr clipped, " rev: ", fCastRec.rev
         else
            let fcastRec.rev = 0.0
#display "vStr: none"
         end if

         call findIdx( wStr ) returning kStr, vStr, wStr
         if( vStr != " " )then
            let fcastRec.odds = vStr clipped
         else
            let fcastRec.odds = 0
         end if

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.ssm_step = vStr clipped

#         display "Before wStr: ", wStr clipped
         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.ceid = vStr clipped
#         display "After ceid: ", vStr clipped
#         display "After wStr: ", wStr clipped

#         call findIdx( wStr ) returning kStr, vStr, wStr
#         let fcastRec.part_name = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.owning_org = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.iemm = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.report_to_sector = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.crm_rev_type = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.mgr = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.ssr = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.lead_pass = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.slip_deal = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.vad = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.value_prop = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.reason_act = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.final_prop = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
         let fcastRec.bp_own = vStr clipped

      if( i=1 )then
         let addTS = FALSE
#         let UPDStr = "begin work; delete from ", CtlRec.fcast_tab clipped, " where ssr='", CleanUp(fcastRec.ssr) clipped, "';"
         let UPDStr = "begin work;"
      end if
         if( fcastRec.cust_name is not NULL )then
            if( fcastRec.fcast_id=0 )then
              let UPDStr = UPDStr clipped, ' insert into ', CtlRec.fcast_tab clipped, ' values (', 
                   0, ', ',
              '"', fcastRec.sc clipped, '", ',
	      '"', CleanUp(fcastRec.cust_name) clipped, '", ',
              '"', CleanUp(fcastRec.iot) clipped, '", ',
              '"', CleanUp(fcastRec.market) clipped, '", ',
              '"', CleanUp(fcastRec.industry) clipped, '", ',
              '"', CleanUp(fcastRec.country) clipped, '", ',
              '"', CleanUp(fcastRec.brand_grp) clipped, '", ',
              '"', CleanUp(fcastRec.brand) clipped, '", ',
              '"', CleanUp(fcastRec.prod_seg) clipped, '", ',
              '"', CleanUp(fcastRec.prod_fam) clipped, '", ',
              '"', CleanUp(fcastRec.brand_desc) clipped, '", ',
              '"', CleanUp(fcastRec.oppty_name) clipped, '", ',
              '"', CleanUp(fcastRec.oppty_num) clipped, '", ',
              '"', CleanUp(fcastRec.partner_led) clipped, '", ',
              '"', CleanUp(fcastRec.flow_code) clipped, '", ',
              '"', CleanUp(fcastRec.close_qtr) clipped, '", ',
              '"', CleanUp(fcastRec.exp_close_dt) clipped, '", ',
              '"', CleanUp(fcastRec.bpr_fcast_stat) clipped, '", ',
                   CleanUp(fcastRec.rev) using "#####&.&&", ', ',
                   CleanUp(fcastRec.odds) using "##&", ', ',
              '"', CleanUp(fcastRec.ssm_step) clipped, '", ',
              '"', CleanUp(fcastRec.ceid) clipped, '", ',
              '"', CleanUp(fcastRec.part_name) clipped, '", ',
              '"', CleanUp(fcastRec.owning_org) clipped, '", ',
              '"', CleanUp(fcastRec.iemm) clipped, '", ',
              '"', CleanUp(fcastRec.report_to_Sector) clipped, '", ',
              '"', CleanUp(fcastRec.crm_rev_type) clipped, '", ',
              '"', CleanUp(fcastRec.mgr) clipped, '", ',
              '"', CleanUp(fcastRec.ssr) clipped, '", ',
              '"', CleanUp(fcastRec.lead_pass) clipped, '", ',
              '"', CleanUp(fcastRec.slip_deal) clipped, '", ',
              '"', CleanUp(fcastRec.vad) clipped, '", ',
              '"', CleanUp(fcastRec.value_prop) clipped, '", ',
              '"', CleanUp(fcastRec.reason_act) clipped, '", ',
              '"', CleanUp(fcastRec.final_prop) clipped, '", ',
              '"', CleanUp(fcastRec.bp_own) clipped, '", ',
              'current',
              '); '
            else
              let UPDStr = UPDStr clipped, ' update ', CtlRec.fcast_tab clipped, ' set ',
              ' sc="', fcastRec.sc clipped, '", ',
	      ' cust_name="', CleanUp(fcastRec.cust_name) clipped, '", ',
              ' iot="', CleanUp(fcastRec.iot) clipped, '", ',
              'market="', CleanUp(fcastRec.market) clipped, '", ',
              'industry="', CleanUp(fcastRec.industry) clipped, '", ',
              'country="', CleanUp(fcastRec.country) clipped, '", ',
              'brand_grp="', CleanUp(fcastRec.brand_grp) clipped, '", ',
              'brand="', CleanUp(fcastRec.brand) clipped, '", ',
              'prod_seg="', CleanUp(fcastRec.prod_seg) clipped, '", ',
              'prod_fam="', CleanUp(fcastRec.prod_fam) clipped, '", ',
              'brand_desc="', CleanUp(fcastRec.brand_desc) clipped, '", ',
              'oppty_name="', CleanUp(fcastRec.oppty_name) clipped, '", ',
              'oppty_num="', CleanUp(fcastRec.oppty_num) clipped, '", ',
              'partner_led="', CleanUp(fcastRec.partner_led) clipped, '", ',
              'flow_code="', CleanUp(fcastRec.flow_code) clipped, '", ',
              'close_qtr="', CleanUp(fcastRec.close_qtr) clipped, '", ',
              'exp_close_dt="', CleanUp(fcastRec.exp_close_dt) clipped, '", ',
              'bpr_fcast_stat="', CleanUp(fcastRec.bpr_fcast_stat) clipped, '", ',
              'rev=',  CleanUp(fcastRec.rev) using "#####&.&&", ', ',
              'odds=', CleanUp(fcastRec.odds) using "##&", ', ',
              'ssm_step="', CleanUp(fcastRec.ssm_step) clipped, '", ',
              'ceid="', CleanUp(fcastRec.ceid) clipped, '", ',
              'part_name="', CleanUp(fcastRec.part_name) clipped, '", ',
              'owning_org="', CleanUp(fcastRec.owning_org) clipped, '", ',
              'iemm="', CleanUp(fcastRec.iemm) clipped, '", ',
              'report_to_sector="', CleanUp(fcastRec.report_to_sector) clipped, '", ',
              'crm_rev_type="', CleanUp(fcastRec.crm_rev_type) clipped, '", ',
              'mgr="', CleanUp(fcastRec.mgr) clipped, '", ',
              'ssr="', CleanUp(fcastRec.ssr) clipped, '", ',
              'lead_pass="', CleanUp(fcastRec.lead_pass) clipped, '", ',
              'slip_deal="', CleanUp(fcastRec.slip_deal) clipped, '", ',
              'vad="', CleanUp(fcastRec.vad) clipped, '", ',
              'value_prop="', CleanUp(fcastRec.value_prop) clipped, '", ',
              'reason_act="', CleanUp(fcastRec.reason_act) clipped, '", ',
              'final_prop="', CleanUp(fcastRec.final_prop) clipped, '", ',
              'bp_own="', CleanUp(fcastRec.bp_own) clipped, '", ',
              'updtime=current ',
              ' where fcast_id=', fcastRec.fcast_id, '; '
            end if  #fcast_id=0
         end if  #cust_name is null
  
         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let fcastRec.fcast_id = vStr clipped
         let l = length( wStr )
         let i = i+1
#display "wStr: ", wStr clipped, " l: ", l
      end while

end case

#  end if
#   display UPDStr
if( InRec.form != "950" )then
   display UPDStr clipped
   let UPDStr = "rollback work"
end if
   whenever error continue
   prepare UPDID from UPDStr
   if( SQLCA.sqlcode = 0 )then
      execute UPDID
      if( SQLCA.sqlcode = 0 )then
if( InRec.form != "XXX" )then
         let UPDStr = "commit work"
end if
         prepare UPDID2 from UPDStr
         if( SQLCA.sqlcode = 0 )then
            execute UPDID2
	    if( SQLCA.sqlcode = 0 )then
               display "Update Successful! "
#               let runStr = "/home/informix/shoe/cgi-bin/fcastNext", BRec.b_id clipped, ".ksh "
               let runStr = MasterRec.home_dir clipped, "/cgi-bin/fcastNext", BRec.b_id clipped, ".ksh "
#               display runStr
               RUN runStr
            else
               display "Update had a Problem - return code: ", SQLCA.sqlcode
            end if
         else
            display "Update had a Problem - return code: ", SQLCA.sqlcode
         end if
      else
         display "Update had a Problem - return code: ", SQLCA.sqlcode
      end if
   else
      display "Update had a Problem - return code: ", SQLCA.sqlcode
   end if

end main

{
function ChangesMade()
define
   SQLStr char(128),
   SkillRec record like skills_im.*,
   i, chgFlg smallint

   let chgFlg = FALSE

   let SQLStr = "select a.* from skills_", InRec.brand clipped, " a where a.ceid='", InRec.ceid clipped, "'"
   prepare CM1ID from SQLStr
   execute CM1ID into SkillRec.*

   for i = 1 to 30
      if( InRec.chgArr[ i ] )then
#         if( InRec.valArr[ i ] != 
         let chgFlg = TRUE
         exit for
      end if
   end for
   
   return chgFlg

end function  #ChangesMade
}
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

function findEmail( inStr )
define
   inStr, outStr char(5120),
   keyStr char(100),
   valStr char(400),
   i,j,l smallint

   let i = 1
   let j = 5
   let l = length(inStr)
   initialize keyStr to NULL
   initialize valStr to NULL

#  locate 'yname
   while inStr[i,j] != 'yname' and j < l
      let i = i + 1
      let j = j + 1
   end while

#  set outStr
   if( j < l )then
      let valStr = inStr[i,l]
      let outStr = inStr[1,i-1]
   else
      let valStr = ""
   end if

   return valStr, outStr

end function  #findEmail


