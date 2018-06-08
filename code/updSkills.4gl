
## February  07, 2018 John M. Shoemaker jshoemaker1@cox.net, add home_dir, #311
## May       14, 2018 John M. Shoemaker sixshoeter@gmail.com, add MasterRec columns for dirs, #324



globals "globals.4gl"

define
   InRec record
      ceid like coverage_au.ceid,
      brand like brands.b_id,
      valArr array[30] of smallint,
      chgArr array[30] of smallint
   end record

main
define
   i smallint,
   nSArr array[34] of smallint,
   cmdStr char(256),
   eidx smallint,
   wStr char(256),
   kStr, vStr char(64),
   SQLStr char(512),
   UPDStr char(1024),
   runStr char(512),
   multi smallint

#call ReadCmdLn( "updSkills", 34 )
call ReadCmdLn( "updSkills", 5 )
call ProcCmdLn( "updSkills" )
#call Header(0, IRec.i_id, BRec.b_id, 1)

let cmdStr = arg_val(5)

#set to NULL
for i = 1 to 30
   initialize InRec.valArr[ i ] to NULL
   let InRec.chgArr[ i ] = FALSE
end for


#display "cmdStr: ", cmdStr clipped

## extract the CEID
call findIdx( cmdStr ) returning kStr, vStr, wStr
let InRec.ceid = vStr
#display "kStr: ", kStr
#display "vStr: ", vStr
#display "wStr: ", wStr
#display "CEID: ", InRec.ceid

## extract the BRAND
call findIdx( wStr ) returning kStr, vStr, wStr
let InRec.brand = vStr
#display "kStr: ", kStr
#display "vStr: ", vStr
#display "wStr: ", wStr

let eidx = 1
while wStr is not NULL 
   call findIdx( wStr ) returning kStr, vStr, wStr
   let eidx = kStr
   let InRec.valArr[ eidx ] = vStr
   let InRec.chgArr[ eidx ] = TRUE
#   display "eidx: ", eidx
#   display "kStr: ", kStr
#   display "vStr: ", vStr
#   display "wStr: ", wStr
#   let eidx = eidx + 1
end while

#display "ceid: ", InRec.ceid, "<br>"
#display "brand: ", InRec.brand, "<br>"
#for i = 1 to 30
#   if( InRec.valArr[ i ] is not NULL )then
#      display InRec.valArr[ i ], "<br>"
#   end if
#end for

## load skill array (just using the non-U version)
for i = 1 to 70
   initialize SkillArr[ i ].* to NULL
end for

call LoadSkillArr( InRec.brand )

## load the current skill record
#let SQLStr = "select a.* from skills_", InRec.brand clipped, " a where a.ceid='", InRec.ceid clipped, "'"
#prepare CM1ID from SQLStr
#execute CM1ID into SkillRec.*

# build UPDStr
let multi = FALSE
#if( ChangesMade() )then
     let UPDStr = "begin work; update skills_", InRec.brand clipped, " set "
     for i = 1 to 30
        if( InRec.valArr[ i ] < 1 )then
           let InRec.valArr[ i ] = NULL
        end if
        if( InRec.valArr[ i ] > 4 )then
           let InRec.valArr[ i ] = 3
        end if
        if( InRec.chgArr [ i ] )then
           if( multi )then
              let UPDStr = UPDStr clipped, ", "
           end if
           let UPDStr = UPDStr clipped, " skill_", SkillArr[ i ].db_num using '&&', "="
           if( InRec.valArr[ i ] is not NULL )then
              let UPDStr = UPDStr clipped, InRec.valArr[ i ]
           else
              let UPDStr = UPDStr clipped, "NULL"
           end if
              
           let multi = TRUE
        end if
     end for
     let UPDStr = UPDStr clipped, ", updtime=current where ceid='", InRec.ceid clipped, "'"
#  end if
#   display UPDStr
   whenever error continue
   prepare UPDID from UPDStr
   if( SQLCA.sqlcode = 0 )then
      execute UPDID
      if( SQLCA.sqlcode = 0 )then
         let UPDStr = "commit work"
         prepare UPDID2 from UPDStr
         if( SQLCA.sqlcode = 0 )then
            execute UPDID2
            if( SQLCA.sqlcode = 0 )then
#               display "Update Successful! "
#               let runStr = "/home/informix/shoe/", MasterRec.cgi_dir clipped, "/procNext", BRec.b_id clipped, ".ksh ", InRec.ceid clipped
               let runStr = MasterRec.home_dir clipped, "/", MasterRec.cgi_dir clipped, "/procNext", BRec.b_id clipped, ".ksh ", InRec.ceid clipped
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
   inStr, outStr char(256),
   keyStr, valStr char(64),
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
