

## 05/22/2015  John M. Shoemaker, jshoemaker1@cox.net - created
## 06/03/2015  John M. Shoemaker, jshoemaker1@cox.net - add form 505
## 06/22/2015  John M. Shoemaker, jshoemaker1@cox.net - add form 507
## 06/23/2015  John M. Shoemaker, jshoemaker1@cox.net - add form 508

globals "globals.4gl"

define
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
   end record,
   SuccessRec record like success_au.*,
   crossRec record like cross.*

main
define
   i,j,l,iidx,nidx smallint,
   nSArr array[34] of smallint,
   cmdStr char(1024),
   eidx smallint,
   wStr char(4096),
   kStr char(100),
   vStr char(400),
   SQLStr char(4096),
   UPDStr char(4096),
   multi smallint,
   runStr char(512),
   tStr char(100),
   addTS smallint,
   ossr, nssr like coverage_au.ssr


#call ReadCmdLn( "updSkills", 34 )
call ReadCmdLn( "massRec", 5 )
call ProcCmdLn( "massRec" )
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

# build UPDStr
let multi = FALSE
#if( ChangesMade() )then
case 
   when InRec.form = "508"
      let UPDStr = "begin work; update ", cov_tab clipped, " set "
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let ossr = CleanUp( vStr )
      let UPDStr = UPDStr clipped, " ", kStr clipped, "="

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let nssr = CleanUp( vStr )

      if( nssr is not NULL )then
         let UPDStr = UPDStr clipped, "'", nssr clipped, "'"
      else
         let UPDStr = UPDStr clipped, "NULL"
      end if

   if( addTS )then
      if( ossr is not NULL )then
         let UPDStr = UPDStr clipped, ", updtime=current where ssr='", ossr clipped, "'"
      else
         let UPDStr = UPDStr clipped, ", updtime=current where ssr is NULL"
      end if
   end if

   when InRec.form = "601"
      let addTS = FALSE
      let UPDStr = "begin work; "
#extract CEID
      call findIdx( wStr ) returning kStr, vStr, wStr
#     display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let crossRec.ceid = vStr clipped

      while( vStr is not NULL )
#extract Partner name
         call findIdx( wStr ) returning kStr, vStr, wStr
#        display "1: kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let crossRec.part_name = CleanUp(vStr) clipped

#extract PCR
         call findIdx( wStr ) returning kStr, vStr, wStr
#        display "2: kStr: ", kStr clipped, "-", "vStr: ", vStr, "-CEID: ", crossRec.ceid, "<br>"
         let crossRec.pcr = CleanUp(vStr) clipped

         if( crossRec.pcr is not NULL and crossRec.ceid is not NULL )then
            let UPDStr = UPDStr clipped, " update cross set pcr='", crossRec.pcr clipped, "' where ceid='", crossRec.ceid clipped, "'; "
         end if

#extract CEID
      call findIdx( wStr ) returning kStr, vStr, wStr
#        display "3: kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let crossRec.ceid = vStr clipped

      end while

end case


#  end if
#   display UPDStr
if( InRec.form = "xxx" )then
   display UPDStr clipped
   let l = length(UpdStr)
   display "length: ", l
   let UPDStr = "rollback work"
end if
   whenever error continue
   prepare UPDID from UPDStr
   if( SQLCA.sqlcode = 0 )then
      execute UPDID
      if( SQLCA.sqlcode = 0 )then
if( InRec.form != "xxx" )then
         let UPDStr = "commit work"
end if
         prepare UPDID2 from UPDStr
         if( SQLCA.sqlcode = 0 )then
            execute UPDID2
            if( SQLCA.sqlcode = 0 )then
               display "Update Successful! "
#               let runStr = "/home/informix/shoe/cgi-bin/procNext", BRec.b_id clipped, ".ksh ", InRec.ceid clipped
#               display runStr
#               RUN runStr
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
   inStr, outStr char(4096),
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
{
function CleanUp( inStr )
define
   inStr char(400),
   outStr char(400),
   i,j,l smallint

   let l = length( inStr )
   let outStr = inStr

   for i = 1 to l-3
      if( outStr[i,i] = "+" )then
         let outStr[i,i] = " "
      end if
      if( outStr[i,i+2] = "%40" )then
         let outStr[i,i] = "@"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%20" )then
         let outStr[i,i] = " "
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%21" )then
         let outStr[i,i] = "!"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%23" )then
         let outStr[i,i] = "#"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%24" )then
         let outStr[i,i] = "$"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%25" )then
         let outStr[i,i] = "%"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%26" )then
         let outStr[i,i] = "&"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2B" )then
         let outStr[i,i] = "+"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2C" )then
         let outStr[i,i] = ","
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2F" )then
         let outStr[i,i] = "/"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3A" )then
         let outStr[i,i] = ":"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3D" )then
         let outStr[i,i] = "="
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3F" )then
         let outStr[i,i] = "?"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
   end for

   return outStr

end function  #CleanUp
}
