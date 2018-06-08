

## 03/04/2016  John M. Shoemaker, jshoemaker1@cox.net - created #141
## 03/23/2016  John M. Shoemaker, jshoemaker1@cox.net - allow for multiple skill tables #150
## December   06, 2017  John M. Shoemaker, jshoemaker1@cox.net - merge AU/SU, #289
## February  07, 2018 John M. Shoemaker jshoemaker1@cox.net, add home_dir, #311
## May       14, 2018 John M. Shoemaker sixshoeter@gmail.com, add MasterRec columns for dirs, #324


globals "globals.4gl"

define
   InRec record
      form char(5),
      ceid like coverage_au.ceid,
      part_name like coverage_au.part_name,
      reseller like coverage_au.reseller,
      part_type like coverage_au.part_type,
      vad like coverage_au.vad
   end record,
   SuccessRec record like success_au.*,
   ContactRec record like contacts_au.*

main
define
   i,j,l,iidx,nidx smallint,
   nSArr array[34] of smallint,
   cmdStr char(2100),
   eidx smallint,
   wStr char(2100),
   kStr char(2100),
   vStr char(2100),
   SQLStr char(2100),
   UPDStr char(2100),
   dStr char(2100),
   multi smallint,
   runStr char(512),
   tStr char(100),
   addTS smallint,
   ossr, nssr like coverage_au.ssr


#call ReadCmdLn( "updSkills", 34 )
call ReadCmdLn( "addBP", 4 )
call ProcCmdLn( "addBP" )
#call Header(0, IRec.i_id, BRec.b_id, 1)
let cmdStr = arg_val(4)

#set to NULL
initialize InRec.* to NULL


let addTS = TRUE   # default to adding a timestamp

#display "cmdStr: ", cmdStr clipped

## extract the FORM TYPE
#call findIdx( cmdStr ) returning kStr, vStr, wStr
#let InRec.form = vStr
#display "InRec.form: ", InRec.form, "<br>"
#display "kStr: ", kStr
#display "vStr: ", vStr

## extract the CEID
#display "before: ", cmdStr clipped, "<br>"
call findIdx( cmdStr ) returning kStr, vStr, wStr
#display "after: ", wStr clipped, "<br>"
let InRec.ceid = vStr
#display "before: ", wStr clipped, "<br>"
call findIdx( wStr ) returning kStr, vStr, wStr
#display "after: ", wStr clipped, "<br>"
let InRec.part_name = CleanUp( vStr )

let InRec.reseller = "R"
let InRec.part_type = "O"
let InRec.vad = "na"
#display "kStr: ", kStr
#display "vStr: ", vStr
#display "wStr: ", wStr
#display "CEID: ", InRec.ceid

#display "ceid: ", InRec.ceid, "<br>"
#display "brand: ", InRec.brand, "<br>"

# extract part_name
let multi = FALSE
#if( ChangesMade() )then
#display "FORM: ", InRec.form
#case 
#   when InRec.form = "addBP"
 
#     locate '='
{
      let i = 1
      let l = length(wStr)
      while wStr[i,i] != '=' and i < l
         let i = i + 1
      end while
      if( i < l )then
         let iidx = i
         for j=1 to l
            let nidx = j+iidx
            if( wStr[nidx,nidx] = "+" )then
               let dStr[j,j] = " "
            else
               let dStr[j,j] = wStr[nidx,nidx]
            end if
         end for
}
         let UPDStr = "begin work; insert into ", cov_tab clipped, 
                      " (ceid, part_name, reseller, part_type, vad) ",
                      " values ('", downshift(InRec.ceid) clipped, "',",
                      "'", InRec.part_name clipped, "',",
                      "'", InRec.reseller clipped, "',",
                      "'", InRec.part_type clipped, "',",
                      "'", InRec.vad clipped, "'); "

         if( exists(CtlRec.skill_tab1) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab1 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab2) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab2 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab3) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab3 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab4) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab4 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab5) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab5 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab6) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab6 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab7) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab7 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab8) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab8 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab9) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab9 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab10) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab10 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab10) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab10 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if
         if( exists(CtlRec.skill_tab11) )then
            let UPDStr = UPDStr clipped, "insert into ", CtlRec.skill_tab11 clipped, " ",
                      " (ceid) values ('",  downshift(InRec.ceid) clipped, "');"
         end if

           
           
#      end if
#end case

#   display "UPDStr: ", UPDStr clipped

#if( InRec.form = "addBP" )then
#   display UPDStr clipped
#   let UPDStr = "rollback work"
#end if
   whenever error continue
   prepare UPDID from UPDStr
   if( SQLCA.sqlcode = 0 )then
      execute UPDID
      if( SQLCA.sqlcode = 0 )then
#if( InRec.form != "501" )then
         let UPDStr = "commit work"
#end if
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
               display "Insert had a Problem - return code: ", SQLCA.sqlcode
            end if
         else
            display "Insert had a Problem - return code: ", SQLCA.sqlcode
         end if
      else
         if( SQLCA.sqlcode = -239 )then
            display "This Partner already Exists in our database! Please hit Back and select Partner List. If you are ",
                    "unable to locate the Partner in that list, please send the CEID and details to ",
                    "<a href='mailto:jshoe@us.ibm.com' style='position: relative' target='_blank'>John Shoemaker.</a>"
         else
            display "Insert had a Problem - return code: ", SQLCA.sqlcode
         end if
      end if
   else
      display "Insert had a Problem - return code: ", SQLCA.sqlcode
   end if
end main

{
function findIdx( inStr )
	define
   inStr, outStr char(2100),
   keyStr char(100),
   valStr char(400),
   i,j,l smallint,
   vlen smallint

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

#  cleanup valStr looking for '+'s
   let vlen = length( valStr clipped )
   for i = 1 to vlen
      if( valStr[i] = "+" )then
         let valStr[i] = " "
      end if
   end for

   return keyStr, valStr, outStr

end function  #findIdx
}
{
function CleanUp( inStr )
define
   inStr char(2100),
   outStr char(2100),
   i,j,l smallint

   let l = length( inStr )
   let outStr = inStr

   for i = 1 to l-3
      if( outStr[i,i] = "+" )then
         let outStr[i,i] = " "
      end if
#      if( outStr[i,i+5] = "%0D%OA" )then
#         let outStr[i,i+2] = "<p>"
#         let outStr[i+1,l] = outStr[i+6,l]
#      end if
      if( outStr[i,i+2] = "%0A" )then
         let outStr[i,i] = " "
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
      if( outStr[i,i+2] = "%22" )then
         let outStr[i,i] = "'"
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
      if( outStr[i,i+2] = "%27" )then
         let outStr[i,i] = "'"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%28" )then
         let outStr[i,i] = "("
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%29" )then
         let outStr[i,i] = ")"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2A" )then
         let outStr[i,i] = "*"
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
      if( outStr[i,i+2] = "%2D" )then
         let outStr[i,i] = "-"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%2E" )then
         let outStr[i,i] = "."
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
      if( outStr[i,i+2] = "%3B" )then
         let outStr[i,i] = ";"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3C" )then
         let outStr[i,i] = "<"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3D" )then
         let outStr[i,i] = "="
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3E" )then
         let outStr[i,i] = ">"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%3F" )then
         let outStr[i,i] = "?"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%40" )then
         let outStr[i,i] = "@"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%92" )then
         let outStr[i,i] = "'"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
      if( outStr[i,i+2] = "%96" )then
         let outStr[i,i] = "'"
         let outStr[i+1,l] = outStr[i+3,l]
      end if
   end for

   return outStr

end function  #CleanUp
}

function exists( inStr )
define
   inStr char(50),
   ret smallint

   let ret = TRUE
   
   if( inStr is NULL or inStr = " " )then
      let ret = FALSE
   end if

   return ret

end function  #exists
