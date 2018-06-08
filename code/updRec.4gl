

## 05/22/2015  John M. Shoemaker, jshoemaker1@cox.net - created
## 06/03/2015  John M. Shoemaker, jshoemaker1@cox.net - add form 505
## 06/22/2015  John M. Shoemaker, jshoemaker1@cox.net - add form 507
## 07/08/2015  John M. Shoemaker, jshoemaker1@cox.net - add form 510
## 05/04/2016  John M. Shoemaker, jshoemaker1@cox.net - add form 512, #164
## 06/09/2016  John M. Shoemaker, jshoemaker1@cox.net - add alliance fields, #112
## 07/19/2016  John M. Shoemaker, jshoemaker1@cox.net - correct for partners_well, #112
## 01/27/2017  John M. Shoemaker, jshoemaker1@cox.net - add POD, #197
## 04/11/2017  John M. Shoemaker, jshoemaker1@cox.net - add LAP, #212
## 08/18/2017  John M. Shoemaker, jshoemaker1@cox.net - add Activity Tracking, #214
## 09/21/2017  John M. Shoemaker, jshoemaker1@cox.net - correct long update str, #266
## 01/15/2018  John M. Shoemaker, jshoemaker1@cox.net - use control tables for activities, #295
## January   31, 2018 John M. Shoemaker jshoemaker1@cox.net, migrate to sales specialties, #300
## February  01, 2018 John M. Shoemaker jshoemaker1@cox.net, refine cross table-form 512, #302
## February  07, 2018 John M. Shoemaker jshoemaker1@cox.net, add home_dir, #311
## February  15, 2018 John M. Shoemaker jshoemaker1@cox.net, correct additional contacts, #307
## March     26, 2018 John M. Shoemaker jshoemaker1@cox.net, allow edit of alt name, #318
## May       14, 2018 John M. Shoemaker sixshoeter@gmail.com, add MasterRec columns for dirs, #324


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
#      pod like coverage_au.pod,
#      pcr like coverage_au.pcr,
      part_name_abbr like coverage_au.part_name_abbr,
      url like coverage_au.url,
      pwp like coverage_au.pwp,
      hunter like coverage_au.hunter,
      commercial like coverage_au.commercial,
      enterprise like coverage_au.enterprise,
      industry like coverage_au.industry,
      dfm like coverage_au.dfm,
      lap like coverage_au.lap,
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
   end record,
   SuccessRec record like success_au.*,
   ContactRec record 
      c_ceid like contacts_au.c_ceid,
      c_name like contacts_au.c_name,
      c_title like contacts_au.c_title,
      c_phone like contacts_au.c_phone,
      c_email like contacts_au.c_email,
      e_region char(30),
      e_name char(30)
   end record,
   CrossRec record like cross.*,
   ReviewRec record like review.*,
   Act_InitRec record like act_initiative.*,
   ActRec record like activity.*
 

main
define
   i,j,l,iidx,nidx smallint,
   nSArr array[34] of smallint,
   cmdStr char(4800),
   eidx smallint,
   wStr char(4800),
   kStr char(4800),
   vStr char(4800),
   SQLStr char(4800),
   UPDStr char(4800),
   dStr char(4800),
   multi smallint,
   runStr char(512),
   tStr char(100),
   addTS smallint,
   ossr, nssr like coverage_au.ssr,
   chg smallint


#call ReadCmdLn( "updSkills", 34 )
call ReadCmdLn( "updRec", 5 )
call ProcCmdLn( "updRec" )
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
call findIdx( wStr ) returning kStr, vStr, wStr
let InRec.ceid = vStr
#display "kStr: ", kStr
#display "vStr: ", vStr
#display "wStr: ", wStr
#display "CEID: ", InRec.ceid

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
case 
   when InRec.form = "501"
 
#     locate '='
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

         if( dStr is not NULL )then
            let UPDStr = 'begin work; update ', cov_tab clipped, ' set desc="', CleanUP(dStr) clipped, '"'
         else
            let UPDStr = 'begin work; update ', cov_tab clipped, ' set desc=NULL '
         end if
      else
         let UPDStr = 'begin work; update ', cov_tab clipped, ' set desc=NULL '
      end if

   when InRec.form = "502" or InRec.form = "503" 
   let eidx = 1
   while wStr is not NULL 
      call findIdx( wStr ) returning kStr, vStr, wStr
      let InRec.keyArr[ eidx ] = kStr
      let InRec.valArr[ eidx ] = vStr
      let InRec.chgArr[ eidx ] = TRUE
      let eidx = eidx + 1
#   display "kStr: ", kStr
#   display "vStr: ", vStr
#   display "wStr: ", wStr
   end while

     let UPDStr = "begin work; update ", cov_tab clipped, " set "
     for i = 1 to 30
        if( InRec.valArr[ i ] = "h" )then
           let InRec.valArr[ i ] = "H"
        end if
        if( InRec.valArr[ i ] = "y" )then
           let InRec.valArr[ i ] = "Y"
        end if
        if( InRec.valArr[ i ] = "x" )then
           let InRec.valArr[ i ] = "Y"
        end if
        if( InRec.valArr[ i ] = "X" )then
           let InRec.valArr[ i ] = "Y"
        end if
        if( InRec.valArr[ i ] = "N" or InRec.valArr[ i ] = "n" )then
           let InRec.valArr[ i ] = NULL
        end if
        if( InRec.chgArr [ i ] )then
           if( multi )then
              let UPDStr = UPDStr clipped, ", "
           end if
           let UPDStr = UPDStr clipped, " ", InRec.keyArr[ i ] clipped, "="
           if( InRec.valArr[ i ] is not NULL )then
              let UPDStr = UPDStr clipped, "'", InRec.valArr[ i ] clipped, "'"
           else
              let UPDStr = UPDStr clipped, "NULL"
           end if
              
           let multi = TRUE
        end if
     end for

   when InRec.form = "504"
      let UPDStr = "begin work; update ", cov_tab clipped, " set "
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.p_name = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.p_name clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
 

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.p_title = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.p_title clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE


      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.p_phone = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.p_phone clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE


      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.p_email = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.p_email clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

   when InRec.form = "505"
      let addTS = FALSE
      let SuccessRec.ceid = InRec.ceid
      let UPDStr = "begin work; insert into ", success_tab clipped, " values ('", SuccessRec.ceid clipped, "'"
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let SuccessRec.s_title = vStr clipped

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let SuccessRec.s_link = vStr clipped

      let UPDStr = UPDStr clipped, ",'", CleanUp(SuccessRec.s_title) clipped, "', '", CleanUp(SuccessRec.s_link) clipped, "')"

   when InRec.form = "506"
      let UPDStr = "begin work; update ", cov_tab clipped, " set "
#display "wStr: ", wStr clipped, "<br>"
      call findIdx( wStr ) returning kStr, vStr, wStr

      let InRec.part_name_abbr = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.part_name_abbr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE


      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.hq = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", upshift(InRec.hq) clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE


      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.part_type = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let tStr = upshift(InRec.part_type)
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.reseller = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( tStr is not NULL )then
            let tStr = upshift(InRec.reseller)
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.vad = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.vad clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
{
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.pod = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.pod clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.pcr = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.pcr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
}
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.url = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.url clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.pwp = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.pwp clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      if( CtlRec.showhunter )then
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.hunter = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let tStr = upshift(InRec.hunter)
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
      end if  #showhunter

      if( CtlRec.showcommercial )then
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.commercial = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let tStr = upshift(InRec.commercial)
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
      end if  #CtlRec.showcommercial

      if( CtlRec.showenterprisealign )then
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.enterprise = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let tStr = upshift(InRec.enterprise)
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
      end if  #CtlRec.showenterprisealign

      if( CtlRec.showindustryalign )then
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.industry = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let tStr = upshift(InRec.industry)
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
      end if  #CtlRec.showindustryalign

      if( CtlRec.showlap )then
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.lap = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let tStr = upshift(InRec.lap)
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
      end if  #showlap

{
      if( CtlRec.showdfm )then
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.dfm = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let tStr = upshift(InRec.dfm)
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
      end if  #showdfm
}
      if( CtlRec.showpartnerswell )then
         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let InRec.partners_well = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let tStr = upshift(InRec.partners_well[1])
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
            let UPDStr = UPDStr clipped, "'", tStr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE
      end if  #partners_well

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.focus1 = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.focus1 clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.focus2 = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.focus2 clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.focus3 = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.focus3 clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.ssr = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.ssr clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.ctp1 = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.ctp1 clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.ctp2 = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.ctp2 clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.ctp3 = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.ctp3 clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.ctp4 = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.ctp4 clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let InRec.ctp5 = CleanUp( vStr )
         if( multi )then
            let UPDStr = UPDStr clipped, ", "
         end if
         let UPDStr = UPDStr clipped, " ", kStr clipped, "="
         if( vStr is not NULL )then
            let UPDStr = UPDStr clipped, "'", InRec.ctp5 clipped, "'"
         else
            let UPDStr = UPDStr clipped, "NULL"
         end if
         let multi = TRUE


   when InRec.form = "507"
      let addTS = FALSE
      let SuccessRec.ceid = InRec.ceid
      let UPDStr = "begin work; delete from ", success_tab clipped, " where ceid='", SuccessRec.ceid clipped, "';"
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let SuccessRec.s_title = vStr clipped
      let l = length( wStr )

#      while( vStr is not NULL )
      while( l > 1 )
         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let SuccessRec.s_link = vStr clipped

         let UPDStr = UPDStr clipped, " insert into ", success_tab clipped, " values ('", SuccessRec.ceid clipped, "', '", CleanUp(SuccessRec.s_title) clipped, "', '", CleanUp(SuccessRec.s_link) clipped, "'); "

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let SuccessRec.s_title = vStr clipped
         let l = length( wStr )
      end while

{
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let SuccessRec.s_link = vStr clipped

      let UPDStr = UPDStr clipped, " insert into ", success_tab clipped, " values ('", SuccessRec.ceid clipped, "', '", CleanUp(SuccessRec.s_title) clipped, "', '", CleanUp(SuccessRec.s_link) clipped, "'); "
}

   when InRec.form = "510"
      let addTS = FALSE
      let ContactRec.c_ceid = InRec.ceid
      let UPDStr = "begin work; delete from ", cont_tab clipped, " where c_ceid='", ContactRec.c_ceid clipped, "';"
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let ContactRec.c_name = vStr clipped
      let l = length( wStr )

#      while( vStr is not NULL )
      while( l > 1 )
         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ContactRec.c_title = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ContactRec.c_phone = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ContactRec.c_email = vStr clipped

#not in new UI	 call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
#not in new UI         let ContactRec.e_region = vStr clipped

#not in new UI         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
#not in new UI         let ContactRec.e_name = vStr clipped

         if( ContactRec.c_name is not NULL and ContactRec.c_name != " " )then
           let UPDStr = UPDStr clipped, ' insert into ', cont_tab clipped, ' values (', 
              '"', ContactRec.c_ceid clipped, '", ',
              '"', CleanUp(ContactRec.c_name) clipped, '", ',
              '"', CleanUp(ContactRec.c_title) clipped, '", ',
              '"', CleanUp(ContactRec.c_phone) clipped, '", ',
              '"', CleanUp(ContactRec.c_email) clipped, '", ',
              '" ", ',
              '" " ',
#not in new UI              '"', CleanUp(ContactRec.e_region) clipped, '", ',
#not in new UI              '"', CleanUp(ContactRec.e_name) clipped, '" ',
              '); '
         end if
  
         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ContactRec.c_name = vStr clipped
         let l = length( wStr )
#display "wStr: ", wStr clipped, " l: ", l
      end while


   when InRec.form = "511"
 
#     locate '='
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

         if( dStr is not NULL )then
            let UPDStr = 'begin work; update ', cov_tab clipped, ' set note="', CleanUP(dStr) clipped, '"'
         else
            let UPDStr = 'begin work; update ', cov_tab clipped, ' set note=NULL '
         end if
      else
         let UPDStr = 'begin work; update ', cov_tab clipped, ' set note=NULL '
      end if

   when InRec.form = "512"
      let addTS = TRUE
      let CrossRec.ceid = InRec.ceid
      let UPDStr = "begin work; "
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"

#      let CrossRec.spr = vStr clipped
#      let l = length( wStr )

#      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
#      let CrossRec.spr_hw = vStr clipped

#      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      if( CtlRec.showspr )then
         let CrossRec.spr_power = vStr clipped
         call findIdx( wStr ) returning kStr, vStr, wStr
      end if

#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      if( CtlRec.showpta )then
         let CrossRec.pta = vStr clipped
	 call findIdx( wStr ) returning kStr, vStr, wStr

         let CrossRec.pta_hw = vStr clipped
	 call findIdx( wStr ) returning kStr, vStr, wStr
      end if  #showpta

      if( CtlRec.showzrep )then
         let CrossRec.zrep = vStr clipped
	 call findIdx( wStr ) returning kStr, vStr, wStr
      end if
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
#      let CrossRec.pcr = vStr clipped

      let CrossRec.updtime = current

      let chg=FALSE
      if( CtlRec.showspr or CtlRec.showpta or CtlRec.showzrep )then
         let UPDStr = UPDStr clipped, ' update ', CtlRec.coverextend_tab clipped, ' set '
#              'set spr="', CleanUp(CrossRec.spr) clipped, '", ',
              if( CtlRec.showspr )then
                 let UPDStr=UPDStr clipped, " ", 'spr_power="', CleanUp(CrossRec.spr_power) clipped, '" '
                 let chg=TRUE
              end if
              if( CtlRec.showpta )then
                 if( chg )then
                    let UPDStr=UPDStr clipped, ", "
                 end if
                 let UPDStr=UPDStr clipped, 
                 'pta="', CleanUp(CrossRec.pta) clipped, '", ',
                 'pta_hw="', CleanUp(CrossRec.pta_hw) clipped, '" '
              end if
              if( CtlRec.showzrep )then
                 if( chg )then
                    let UPDStr=UPDStr clipped, ", "
                 end if
                  let UPDStr=UPDStr clipped,
                 'zrep="', CleanUp(CrossRec.zrep) clipped, '" '
               end if

      end if  #any changes to cross



   when InRec.form = "513"
      let addTS = TRUE
      let CrossRec.ceid = InRec.ceid
      let UPDStr = "begin work; "
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let CrossRec.swita = vStr clipped
      let l = length( wStr )

      let CrossRec.updtime = current

      let UPDStr = UPDStr clipped, ' update ', CtlRec.coverextend_tab clipped, ' ',
              'set swita="', CleanUp(CrossRec.swita) clipped, '" '


   when InRec.form = "514"
      let addTS = TRUE
      let CrossRec.ceid = InRec.ceid
      let UPDStr = "begin work; "
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let CrossRec.alliance_bpr = vStr clipped
      let l = length( wStr )

      let CrossRec.updtime = current

      let UPDStr = UPDStr clipped, ' update ', CtlRec.coverextend_tab clipped, ' ',
              'set alliance_bpr="', CleanUp(CrossRec.alliance_bpr) clipped, '", ',
              'alliance_ctp="', CleanUp(CrossRec.alliance_ctp) clipped, '" '


   when InRec.form = "751"    #activity tracking - act_initiative
      let addTS = FALSE
      let Act_InitRec.ceid = InRec.ceid
      let UPDStr = "begin work; delete from ", CtlRec.act_init_tab clipped, " where ceid='", Act_InitRec.ceid clipped, "';"
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let Act_InitRec.bp_init1 = vStr clipped
      let l = length( wStr )

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let Act_InitRec.st_init1 = vStr clipped

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let Act_InitRec.bp_init2 = vStr clipped

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let Act_InitRec.st_init2 = vStr clipped

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let Act_InitRec.bp_init3 = vStr clipped

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let Act_InitRec.st_init3 = vStr clipped


      let UPDStr = UPDStr clipped, ' insert into  ', CtlRec.act_init_tab clipped, ' (ceid, bp_init1, bp_init2, bp_init3, st_init1, st_init2, st_init3) ',
              'values (', 
              '"', Act_InitRec.ceid clipped, '",', 
              '"', CleanUp(Act_InitRec.bp_init1) clipped, '",', 
              '"', CleanUp(Act_InitRec.bp_init2) clipped, '",', 
              '"', CleanUp(Act_InitRec.bp_init3) clipped, '",', 
              '"', CleanUp(Act_InitRec.st_init1) clipped, '",', 
              '"', CleanUp(Act_InitRec.st_init2) clipped, '",', 
              '"', CleanUp(Act_InitRec.st_init3) clipped, '" ',
              ')'


   when InRec.form = "752"    #activity tracking - activity
      let addTS = FALSE
      let ActRec.ceid = InRec.ceid

      let UPDStr = "begin work;"
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let ActRec.act_sn = vStr clipped
      let l = length( wStr )

#      while( vStr is not NULL )
      while( l > 1 )
         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_name = CleanUp(vStr) clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_desc = CleanUp(vStr) clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_code = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_init = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_stat = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_rev = vStr clipped
         if( ActRec.act_rev is NULL or vStr=" " )then
            let ActRec.act_rev=0.0
         end if

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_st_dt = CleanUp(vStr)

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_ed_dt = CleanUp(vStr)

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_own_ibm = vStr clipped

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_own_bp = vStr clipped

         if( ActRec.act_sn > 0 )then
            let UPDStr = UPDStr clipped, ' update ', CtlRec.act_tab clipped, ' ',
                 'set act_name="', CleanUp(ActRec.act_name) clipped, '", ',
                 'act_desc="', CleanUp(ActRec.act_desc) clipped, '", ',
                 'act_code="', CleanUp(ActRec.act_code) clipped, '", ',
                 'act_init="', CleanUp(ActRec.act_init) clipped, '", ',
                 'act_stat="', CleanUp(ActRec.act_stat) clipped, '", ',
                 'act_rev=', ActRec.act_rev using '&&&&&&&&', ', ',
                 'act_st_dt="', CleanUp(ActRec.act_st_dt) clipped, '", ',
                 'act_ed_dt="', CleanUp(ActRec.act_ed_dt) clipped, '", ',
                 'act_own_ibm="', CleanUp(ActRec.act_own_ibm) clipped, '", ',
                 'act_own_bp="', CleanUp(ActRec.act_own_bp) clipped, '" ',
                 'where act_sn=', ActRec.act_sn, '; '
          else
            if( ActRec.act_name is not NULL and ActRec.act_name != " " and ActRec.act_name != "(new record)" )then
               let UPDStr = UPDStr clipped, ' insert into ', CtlRec.act_tab clipped, ' ',
                    '(act_sn, ceid, act_name, act_desc, act_code, act_init, act_stat, act_rev, act_st_dt, act_ed_dt, act_own_ibm, act_own_bp) values ',
                    '(0, ',
                    '"', CleanUp(ActRec.ceid) clipped, '", ',
                    '"', CleanUp(ActRec.act_name) clipped, '", ',
                    '"', CleanUp(ActRec.act_desc) clipped, '", ',
                    '"', CleanUp(ActRec.act_code) clipped, '", ',
                    '"', CleanUp(ActRec.act_init) clipped, '", ',
                    '"', CleanUp(ActRec.act_stat) clipped, '", ',
                    '', ActRec.act_rev using '&&&&&&&&', ', ',
                    '"', CleanUp(ActRec.act_st_dt) clipped, '", ',
                    '"', CleanUp(ActRec.act_ed_dt) clipped, '", ',
                    '"', CleanUp(ActRec.act_own_ibm) clipped, '", ',
                    '"', CleanUp(ActRec.act_own_bp) clipped, '"); '
             end if  #valid new record

          end if  #act_sn > 0

         call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
         let ActRec.act_sn = vStr clipped
         let l = length( wStr )
      end while


   when InRec.form = "1001"  #add new review comment
      let addTS = FALSE
      let ReviewRec.ceid = InRec.ceid
      let UPDStr = "begin work; "
      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let ReviewRec.brand = vStr clipped
      let l = length( wStr )

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let ReviewRec.rating = vStr clipped
      let l = length( wStr )

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let ReviewRec.reviewer = vStr clipped

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let ReviewRec.reviewer_email = vStr clipped

      call findIdx( wStr ) returning kStr, vStr, wStr
#display "kStr: ", kStr clipped, "<br>", "vStr: ", vStr, "<br>"
      let ReviewRec.comment = vStr clipped

      let ReviewRec.stat = "R"
      let ReviewRec.updtime = current

      let UPDStr = UPDStr clipped, ' insert into review (ceid,brand,stat,updtime,rating,reviewer,reviewer_email,comment)',
              'values (', 
              '"', ReviewRec.ceid clipped, '",', 
              '"', ReviewRec.brand clipped, '",', 
              '"', ReviewRec.stat clipped, '",', 
              '"', ReviewRec.updtime clipped, '",', 
              '"', ReviewRec.rating clipped, '",', 
              '"', ReviewRec.reviewer clipped, '",', 
              '"', CleanUp(ReviewRec.reviewer_email) clipped, '",', 
              '"', CleanUp(ReviewRec.comment) clipped, '" ', 
              ')'
end case

   if( addTS )then
      let UPDStr = UPDStr clipped, ", updtime=current where ceid='", InRec.ceid clipped, "'"
   end if

#  end if
#   display UPDStr clipped
if( InRec.form = "XXX" )then
   display UPDStr clipped
   let UPDStr = "rollback work"
end if
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
               if( InRec.form!="1001" )then
                  let runStr = MasterRec.home_dir clipped, "/", MasterRec.cgi_dir clipped, "/procNext", BRec.b_id clipped, ".ksh ", InRec.ceid clipped
               else
                  let runStr = MasterRec.home_dir clipped, "/", MasterRec.cgi_dir clipped, "/refreshNext", BRec.b_id clipped, ".ksh ", InRec.ceid clipped
               end if
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
   inStr, outStr char(2100),
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
   inStr, outStr char(4800),
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


