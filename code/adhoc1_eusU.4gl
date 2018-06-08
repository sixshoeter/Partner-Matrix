##
## October 11, 2013 John M. Shoemaker, multiple changes
## January 16, 2014 John M. Shoemaker, convert to EU from BU
## September 29, 2014 John M. Shoemaker, verify with categories
## November 24, 2014 John M. Shoemaker, expand to 30 skills
## February 03, 2015 John M. Shoemaker, convert to Units
## March    17, 2015 John M. Shoemaker, correct for SU
## April    15, 2015 John M. Shoemaker, fix error for table alias for skills_s5
## April    15, 2015 John M. Shoemaker, add table n
## June     11, 2015 John M. Shoemaker, add Commerce
## August   18, 2015 John M. Shoemaker, correct error with selecting all EUs
## September14, 2015 John M. Shoemaker, remove landing BPR #125
## September24, 2015 John M. Shoemaker, allow selection at region level #115
## February  17, 2016 John M. Shoemaker, filter out reseller X
## July      22, 2016 John M. Shoemaker, add support for market/industry #174
## September 20, 2016 John M. Shoemaker, allow Industry search to be provided val and greater #174
## September 04, 2017 John M. Shoemaker, revise AU tables, #255
## September 12, 2017 John M. Shoemaker, add export button of results, #259
## September 21, 2017 John M. Shoemaker, use sorted ranking and limit results, #262
## September 21, 2017 John M. Shoemaker, make simple an option, #263
## October   06, 2017 John M. Shoemaker, ignore case in part_name sort, #269
## January   18, 2018 John M. Shoemaker, expand parse str lengths
## January   31, 2018 John M. Shoemaker jshoemaker1@cox.net, migrate to sales specialties, #300

globals "globals.4gl"

define
   AdhocStr char(1024),
   DispStr char(1024),
   skilllevelStr char(64),
   aEUArr array[30] of char(30),
   aINDArr array[30] of char(30),
   aEUcnt, aINDcnt smallint,
   cnt smallint,
   NEWRepArr array[2] of
   record
      ssr      like reps.r_name,
      ssr_link like reps.r_link
   end record,
   tssr like reps.r_name,
   tssr_link like reps.r_link,
   kUsed, lUsed, mUsed, bUsed, cUsed, dUsed, nUsed smallint,
   pUsed, qUsed, rUsed, tUsed, uUsed, vUsed, wUsed, xUsed, yUsed, zUsed smallint,
   eUsed, fUsed, gUsed, hUsed smallint,
   sUsed, iUsed, jUsed smallint


main

define
   i smallint,
   SQLStr char(1024),
   qStr char(1024)

call ReadCmdLn( "adhoc1", 5)
call ProcCmdLn( "adhoc1" )
let AdhocStr = arg_val(5)
call Header(0, IRec.i_id, BRec.b_id, 1)

let DispStr = "<div dir='ltr' style='text-align: center'> <em><span style='font-size: 18px'>"
display "<p>"
call ParseStrU( AdhocStr )
let DispStr = DispStr clipped, "</span></em></div>"

display " "

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", IRec.i_name clipped, " * ", BRec.b_name clipped,"</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "	<em><span style='font-size: 16px'>The Partners listed meet <b>ALL</b> of the Criteria provided.</span></em></div><p>"
display DispStr clipped
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 492px' width='638'>"
display "<tbody>"
#display aEUArr[aEUcnt], aEUcnt, AdhocStr clipped


if( aEUcnt > 0 )then
   let SQLStr = "select s.r_name, s.r_link from eus b, reps s where b.e_ssr = s.r_name ",
                " and b.e_brand = '", BRec.b_id clipped, "' and b.e_name = '", aEUArr[aEUcnt] clipped, "' ",
                " order by b.e_id"
#display SQLStr
   prepare RepID from SQLStr
   declare RepCurs cursor for RepID
   let i = 1
   initialize NEWRepArr[i].* to NULL

   foreach RepCurs into tssr, tssr_link
   #NEWRepArr[1].ssr, NEWRepArr[1].ssr_link
   #display "I:", i
   #display NEWRepArr[i].*
      let i=i+1
   #display "I:", i
   
   end foreach
   #display "I: ", i using "&&&"

end if

call ShowAdhoc1() returning qStr

display "</tbody>"
display "</table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 492px; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of Partners: ", cnt using "<<&"
#if( BRec.b_id='SU' )then
display "<FORM ID='expfap' ACTION='/cgi-bin/exportFAP", BRec.b_id clipped, ".ksh' method='post'>"
display "<INPUT TYPE=submit VALUE='Export Results to CSV'>"
display '<INPUT NAME="qry" TYPE=hidden READONLY VALUE="', qStr clipped, '">'
display "</FORM>"
#end if
display "</div"
display "<p dir='ltr'> &nbsp;</p>"
#display "</tr>"

call ShowVer( 0 )

end main

function ShowAdhoc1()
define
   in_bu smallint,
   wStr char(64),
   qtrStr char(1024),
   skillStr char(300),
   my_ssr like bus.b_ssr,
   my_ctp like bus.b_ctp,
   RRec record like reps.*,
   sort_by char(18),
   SSRStr char(64)

display "<tr>"
display "<td style='text-align: center; background-color: rgb(230,230,250); width: 111px; vertical-align: middle'>"
display "<h3>"

display "<span style='font-size: 18px'>Resellers </span></h3>"
display "Please contact the BP Brand Rep"
#if( tssr is not null) then
#display "<a href='", tssr_link clipped, "' target='_blank'>",tssr clipped, "</a>, "
#end if
display " for help in determining the right Partner to work with.<p>"
display "<br><br><span style='font-size:8px;'>BPR names in parans on right.</span>"

#if( not CtlRec.cflg4 )then
#   let qtrStr = BuildBaseStr( BRec.b_id, FALSE )
#else
#   let qtrStr = BuildBaseStr2( TRUE, FALSE )
#end if

#display "Used: ", kUsed, lUsed, mUsed, nUsed
let qtrStr = "select a.* "
#AU
if( kUsed )then let qtrStr = qtrStr clipped, ", k.* " end if
if( lUsed )then let qtrStr = qtrStr clipped, ", l.* " end if
if( mUsed )then let qtrStr = qtrStr clipped, ", m.* " end if
if( bUsed )then let qtrStr = qtrStr clipped, ", b.* " end if
if( cUsed )then let qtrStr = qtrStr clipped, ", c.* " end if
if( dUsed )then let qtrStr = qtrStr clipped, ", d.* " end if

if( pUsed )then let qtrStr = qtrStr clipped, ", p.* " end if
if( qUsed )then let qtrStr = qtrStr clipped, ", q.* " end if
if( rUsed )then let qtrStr = qtrStr clipped, ", r.* " end if
#if( sUsed )then let qtrStr = qtrStr clipped, ", s.* " end if
if( sUsed )then let qtrStr = qtrStr clipped, ", s.* " end if
if( iUsed )then let qtrStr = qtrStr clipped, ", i.* " end if
if( jUsed )then let qtrStr = qtrStr clipped, ", j.* " end if

#SU
if( tUsed )then let qtrStr = qtrStr clipped, ", t.* " end if
if( uUsed )then let qtrStr = qtrStr clipped, ", u.* " end if
if( vUsed )then let qtrStr = qtrStr clipped, ", v.* " end if
if( wUsed )then let qtrStr = qtrStr clipped, ", w.* " end if

if( xUsed )then let qtrStr = qtrStr clipped, ", x.* " end if
if( yUsed )then let qtrStr = qtrStr clipped, ", y.* " end if
if( zUsed )then let qtrStr = qtrStr clipped, ", z.* " end if

#BU
if( eUsed )then let qtrStr = qtrStr clipped, ", e.* " end if
if( fUsed )then let qtrStr = qtrStr clipped, ", f.* " end if
if( gUsed )then let qtrStr = qtrStr clipped, ", g.* " end if
if( hUsed )then let qtrStr = qtrStr clipped, ", h.* " end if

#SE
if( nUsed )then let qtrStr = qtrStr clipped, ", n.* " end if

if( kUsed or lUsed or mUsed or cUsed or dUsed or bUsed )then
   let qtrStr = qtrStr clipped, " from coverage_au a"
else
   if( tUsed or uUsed or vUsed or wUsed or xUsed )then
      let qtrStr = qtrStr clipped, " from coverage_su a"
   else
      if( eUsed or fUsed or gUsed or hUsed )then
         let qtrStr = qtrStr clipped, " from coverage_bu a"
      else
         if( zUsed )then
            let qtrStr = qtrStr clipped, " from coverage_cu a"
         else 
            if( sUsed or jUsed or jUsed )then
              let qtrStr = qtrStr clipped, " from coverage_st a"
            else
               if( rUsed )then
                 let qtrStr = qtrStr clipped, " from coverage_io a"
               else
                  if( qUsed )then
                     let qtrStr = qtrStr clipped, " from coverage_es a"
                  else
                     if( pUsed )then
                        let qtrStr = qtrStr clipped, " from coverage_wu a"
                     else
                        if( pUsed )then
                           let qtrStr = qtrStr clipped, " from coverage_se a"
                        else
                           let qtrStr = qtrStr clipped, " from coverage_", downshift(BRec.b_id) clipped, " a"
                        end if
                     end if
                  end if
               end if
            end if
         end if
      end if
   end if
end if

if( kUsed )then let qtrStr = qtrStr clipped, ", skills_n1 k " end if
if( lUsed )then let qtrStr = qtrStr clipped, ", skills_n2 l " end if
if( mUsed )then let qtrStr = qtrStr clipped, ", skills_n3 m " end if
if( cUsed )then let qtrStr = qtrStr clipped, ", skills_n4 c " end if
if( dUsed )then let qtrStr = qtrStr clipped, ", skills_n5 d " end if
if( bUsed )then let qtrStr = qtrStr clipped, ", skills_ag b " end if
if( pUsed )then let qtrStr = qtrStr clipped, ", skills_wu p " end if
if( qUsed )then let qtrStr = qtrStr clipped, ", skills_es q " end if
if( rUsed )then let qtrStr = qtrStr clipped, ", skills_io r " end if
#if( sUsed )then let qtrStr = qtrStr clipped, ", skills_st s " end if
if( tUsed )then let qtrStr = qtrStr clipped, ", skills_n6 t " end if
if( uUsed )then let qtrStr = qtrStr clipped, ", skills_n7 u " end if
#if( vUsed )then let qtrStr = qtrStr clipped, ", skills_s3 v " end if
#if( wUsed )then let qtrStr = qtrStr clipped, ", skills_s4 w " end if
#if( xUsed )then let qtrStr = qtrStr clipped, ", skills_s5 x " end if
if( yUsed )then let qtrStr = qtrStr clipped, ", skills_co y " end if
if( zUsed )then let qtrStr = qtrStr clipped, ", skills_cu z " end if

if( eUsed )then let qtrStr = qtrStr clipped, ", skills_b1 e " end if
if( fUsed )then let qtrStr = qtrStr clipped, ", skills_b2 f " end if
if( gUsed )then let qtrStr = qtrStr clipped, ", skills_b3 g " end if
if( hUsed )then let qtrStr = qtrStr clipped, ", skills_b4 h " end if

if( sUsed )then let qtrStr = qtrStr clipped, ", skills_sw s " end if
if( iUsed )then let qtrStr = qtrStr clipped, ", skills_sh i " end if
if( jUsed )then let qtrStr = qtrStr clipped, ", skills_sv j " end if

if( nUsed )then let qtrStr = qtrStr clipped, ", skills_se n " end if


let AdhocStr = AdhocStr clipped, " and (a.reseller != 'N' and a.reseller != 'X' and a.part_type != 'D') "

#if( not CtlRec.cflg4 )then
   let sort_by = "lower(a.part_name)"
#   let qtrStr = qtrStr clipped, " where a.ceid=k.ceid and a.ceid=l.ceid and a.ceid=m.ceid ", AdhocStr clipped, " order by ", sort_by clipped
   let qtrStr = qtrStr clipped, " where 1=1 "
   if( kUsed )then let qtrStr = qtrStr clipped, " and a.ceid=k.ceid " end if
   if( lUsed )then let qtrStr = qtrStr clipped, " and a.ceid=l.ceid " end if
   if( mUsed )then let qtrStr = qtrStr clipped, " and a.ceid=m.ceid " end if
   if( cUsed )then let qtrStr = qtrStr clipped, " and a.ceid=c.ceid " end if
   if( dUsed )then let qtrStr = qtrStr clipped, " and a.ceid=d.ceid " end if
   if( bUsed )then let qtrStr = qtrStr clipped, " and a.ceid=b.ceid " end if
   if( nUsed )then let qtrStr = qtrStr clipped, " and a.ceid=n.ceid " end if
   if( pUsed )then let qtrStr = qtrStr clipped, " and a.ceid=p.ceid " end if
   if( qUsed )then let qtrStr = qtrStr clipped, " and a.ceid=q.ceid " end if
   if( rUsed )then let qtrStr = qtrStr clipped, " and a.ceid=r.ceid " end if
#   if( sUsed )then let qtrStr = qtrStr clipped, " and a.ceid=s.ceid " end if
   if( tUsed )then let qtrStr = qtrStr clipped, " and a.ceid=t.ceid " end if
   if( uUsed )then let qtrStr = qtrStr clipped, " and a.ceid=u.ceid " end if
   if( vUsed )then let qtrStr = qtrStr clipped, " and a.ceid=v.ceid " end if
   if( wUsed )then let qtrStr = qtrStr clipped, " and a.ceid=w.ceid " end if
   if( xUsed )then let qtrStr = qtrStr clipped, " and a.ceid=x.ceid " end if
   if( yUsed )then let qtrStr = qtrStr clipped, " and a.ceid=y.ceid " end if
   if( zUsed )then let qtrStr = qtrStr clipped, " and a.ceid=z.ceid " end if

   if( eUsed )then let qtrStr = qtrStr clipped, " and a.ceid=e.ceid " end if
   if( fUsed )then let qtrStr = qtrStr clipped, " and a.ceid=f.ceid " end if
   if( gUsed )then let qtrStr = qtrStr clipped, " and a.ceid=g.ceid " end if
   if( hUsed )then let qtrStr = qtrStr clipped, " and a.ceid=h.ceid " end if

   if( sUsed )then let qtrStr = qtrStr clipped, " and a.ceid=s.ceid " end if
   if( iUsed )then let qtrStr = qtrStr clipped, " and a.ceid=i.ceid " end if
   if( jUsed )then let qtrStr = qtrStr clipped, " and a.ceid=j.ceid " end if

   let qtrStr = qtrStr clipped, " ", AdhocStr clipped, " order by ", sort_by clipped
#else
#   let sort_by = "a.part_name"
#   let qtrStr = qtrStr clipped, " where a.ceid = k.ceid ", AdhocStr clipped, " order by ", sort_by clipped
#end if

#   let qtrStr = qtrStr clipped, " where a.ceid = k.ceid ", AdhocStr clipped, " order by ", sort_by clipped
#let qtrStr = qtrStr clipped, " into temp _t1"
#display qtrStr
#prepare Q0ID from qtrStr
#execute Q0ID
#let qtrStr = "select a.* from _t1"

#display qtrStr
   prepare Q1ID from qtrStr
   declare ACurs cursor for Q1ID

display "</td>"
display "<td style='text-align: left; width: 367px'>"
display "<div>"

let cnt = 0

foreach ACurs into URec.*, KRec.*, LRec.*, MRec.*, NRec.*
#display "START"
   let cnt = cnt + 1
# display "skillStr: ", skillStr clipped

   let SSRStr = GetSSRStr()
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, ".html'>", URec.part_name clipped, "</a>", SSRStr clipped


{
   case URec.reseller 
      when "E"
         display "<i><span style='font-size: 10px'>(Emerging)</span></i>"
   end case
}

   case URec.reseller 
      when "E"
         display "<i><span style='font-size: 10px'>(Emerging)</span></i>"
      when "H"
         if( ShowHVP )then
            display "<i><span style='font-size: 10px'>(HV)</span></i>"
         end if
      when "S"
         display "<i><span style='font-size: 10px'>(S)</span></i>"
   end case

#   let skillStr = BuildSkillStrU ( 3 )
#   if( skillStr is not null )then
#      display "<br /><span style='font-size: 12px'>&nbsp &nbsp &nbsp &nbsp &nbsp(", skillStr clipped, ") </span>"
#   end if

   display "<br/>"
{end if}
end foreach
#display "CNT: ", cnt
if( cnt = 0 )then
   display "<em>No partners meet the search criteria.</em>"
end if
display "</td></tr>"

return qtrStr

end function  #ShowAdhoc1

function ParseStrU( inStr)
define
   inStr, tStr char(1024),
   l,i,j smallint,
   EUStr char(1024),
   INDStr char(1024),
   SKStr char(1024),
   bucnt, indcnt, skcnt smallint,
   NewStr, oNewStr char(1024),
   skilllevel char(2),
#   skilllevelStr char(4),
   currBrand like brands.b_id,
   foundInd smallint

let bucnt = 0
let indcnt = 0
let skcnt = 0
initialize NewStr to NULL
{
##FIND REGION REQUESTS FIRSTS
let l=length(inStr clipped)
for i = 1 to l-4
   if( inStr[i,i+2]="(j." )then
      for j=i+3 to l-4
         if( inStr[j,j]=")" )then
            let tStr = inStr[1,i], "a."
         end if
      end for
   end if
end for
}

##FIND ENTERPRISE UNITS
#display "BEFORE: ", inStr clipped, "<br />"
let oNewStr = "NONE"
let l=length(inStr clipped)
for i = 1 to l-4
  if(inStr[i,i+4]="a.eu_") then
     for j = i to l
        if( inStr[j]="=")then
           let EUStr = inStr[i,j-1]
           let NewStr = GetEUStr(EUStr)
           if( NewStr != oNewStr )then
#display "NewStr: ", NewStr clipped, " oNewStr: ", oNewStr clipped
#display "DispStr 1: ", DispStr clipped
           if( bucnt = 0 )then
              let DispStr = DispStr clipped, "ENTERPRISE UNITS: ", NewStr clipped
           else
              let DispStr = DispStr clipped, ", ", NewStr clipped
           end if
#display "DispStr 2: ", DispStr clipped
           let bucnt = bucnt + 1
           let aEUArr[bucnt] = NewStr clipped
           let oNewStr = NewStr
           end if
           exit for
        end if
     end for
  end if 
end for
let aEUcnt = bucnt


if(bucnt>0)then
   let DispStr = DispStr clipped, "<br />"
end if


##FIND INDUSTRIES
if( CtlRec.showindustry )then
   let foundInd = FALSE

#display "BEFORE: ", inStr clipped, "<br />"
let oNewStr = "NONE"
let l=length(inStr clipped)
let i = 1   #if using while
while i <= l-5 AND not foundInd
#for i = 1 to l-5  #replace with while
  if(inStr[i,i+5]="a.ind_") then
     for j = i to l
        if( inStr[j]="=" or inStr[j]=">" or inStr[j]="<" )then
##ORIG        if( inStr[j]="=")then
#if( inStr[j-1]="!" or inStr[j-1]=">" or inStr[j-1]="<" )then
#           let INDStr = inStr[i,j-2]
#else
           let INDStr = inStr[i,j-1]
#end if
           let foundInd = TRUE
           let NewStr = GetINDStr(INDStr)
           if( NewStr != oNewStr )then
#display "NewStr: ", NewStr clipped, " oNewStr: ", oNewStr clipped
#display "DispStr 1: ", DispStr clipped
           if( indcnt = 0 )then
              let DispStr = DispStr clipped, "INDUSTRIES: ", NewStr clipped
           else
              let DispStr = DispStr clipped, ", ", NewStr clipped
           end if
#display "DispStr 2: ", DispStr clipped
           let indcnt = indcnt + 1
           let aINDArr[indcnt] = NewStr clipped
           let oNewStr = NewStr
           end if
           exit for
        end if
     end for
  end if 
#end for #replace with while
   let i = i + 1
end while
let aEUcnt = indcnt


if(indcnt>0)then
   let DispStr = DispStr clipped, "<br />"
end if

end if

##FIND SKILLS
let kUsed = FALSE
let lUsed = FALSE
let mUsed = FALSE
let cUsed = FALSE
let dUsed = FALSE
let bUsed = FALSE
let nUsed = FALSE
let pUsed = FALSE
let qUsed = FALSE
let rUsed = FALSE
let sUsed = FALSE
let iUsed = FALSE
let jUsed = FALSE
let tUsed = FALSE
let uUsed = FALSE
let vUsed = FALSE
let wUsed = FALSE
let xUsed = FALSE
let yUsed = FALSE
let zUsed = FALSE

let eUsed = FALSE
let fUsed = FALSE
let gUsed = FALSE
let hUsed = FALSE
#display "BEFORE: ", inStr clipped
for i = 1 to l-7
  if(inStr[i+1,i+7]=".skill_") then
case inStr[i] 
   when "k"
      let kUsed = TRUE
#      let currBrand = "A1"
      let currBrand = "N1"
   when "l"
      let lUsed = TRUE
#      let currBrand = "A2"
      let currBrand = "N2"
   when "m"
      let mUsed = TRUE
#      let currBrand = "A3"
      let currBrand = "N3"
   when "c"
      let cUsed = TRUE
#      let currBrand = "A4"
      let currBrand = "N4"
   when "d"
      let dUsed = TRUE
#      let currBrand = "A5"
      let currBrand = "N5"
   when "b"
      let bUsed = TRUE
      let currBrand = "AG"
   when "n"
      let nUsed = TRUE
      let currBrand = "SE"
   when "p"
      let pUsed = TRUE
      let currBrand = "WA"
   when "q"
      let qUsed = TRUE
      let currBrand = "ES"
   when "r"
      let rUsed = TRUE
      let currBrand = "IO"
   when "s"
      let sUsed = TRUE
      let currBrand = "SW"
   when "i"
      let iUsed = TRUE
      let currBrand = "SH"
   when "j"
      let jUsed = TRUE
      let currBrand = "SV"
   when "t"
      let tUsed = TRUE
#      let currBrand = "S1"
      let currBrand = "N6"
   when "u"
      let uUsed = TRUE
#      let currBrand = "S2"
      let currBrand = "N7"
   when "v"
      let vUsed = TRUE
      let currBrand = "S3"
   when "w"
      let wUsed = TRUE
      let currBrand = "S4"
   when "x"
      let xUsed = TRUE
      let currBrand = "S5"
   when "y"
      let yUsed = TRUE
      let currBrand = "CO"
   when "z"
      let zUsed = TRUE
      let currBrand = "CU"

   when "e"
      let eUsed = TRUE
      let currBrand = "B1"
   when "f"
      let fUsed = TRUE
      let currBrand = "B2"
   when "g"
      let gUsed = TRUE
      let currBrand = "B3"
   when "h"
      let hUsed = TRUE
      let currBrand = "B4"
end case

     let skilllevel=inStr[i+15,i+15]
     {
     if( skilllevel = "3" )then
        let skilllevelStr = "   "
     else
        let skilllevelStr = "(", skilllevel clipped, ")"
     end if
      }

     case skilllevel
        when '3'
           let skilllevelStr = "(Recommended Partners Only)"
        when '2'
           let skilllevelStr = "(Recommended AND Skilled Partners)"
        when '1'
           let skilllevelStr = "(Recommended, Skilled, and Learning Partners)"
     end case

     for j = i to l
        if( inStr[j]="=")then
           let SKStr = inStr[i,j-2]
           let NewStr = GetSKStrU(currBrand, SKStr)
#display "SKStr: ", SKStr
#display "NewStr: ", NewStr 
           if( skcnt = 0 )then
              let DispStr = DispStr clipped, "SKILLS: ", NewStr clipped, " "
           else  #ParseStr
              let DispStr = DispStr clipped, ", ", NewStr clipped, " "
           end if
           let skcnt = skcnt + 1
           exit for
        end if
     end for
  end if 
end for

let DispStr = DispStr clipped, " ", skilllevelStr clipped
end function  #ParseStrU

function GetEUStr( inStr)
define
   inStr char(64),
   colStr char(30),
   QStr char(128),
   tStr like eus.e_name,
   i smallint


   initialize tStr to NULL
   initialize QStr to NULL
   let QStr = "select unique a.e_name from eus a where a.e_brand = '", BRec.b_id clipped, "' and a.e_id = "
   let colStr = inStr[3,64] clipped

#   display "QStr (before for): ", QStr clipped
   for i = 1 to G_NumCols
      if( EUColNamesArr[i].colname = colStr )then
         let QStr = QStr clipped, " ", EUColNamesArr[i].idx using '##'
         exit for
      end if
   end for
#   display "QStr (after for): ", QStr clipped

#display "QStr: ", QStr
prepare LBID from QStr 
execute LBID into tStr

return tStr

end function  #GetEUStr


function GetINDStr( inStr)
define
   inStr char(64),
   colStr char(30),
   QStr char(128),
   tStr like industry.i_name,
   i smallint


   initialize tStr to NULL
   initialize QStr to NULL
   let QStr = "select unique a.i_name from industry a where a.i_brand = '", BRec.b_id clipped, "' and a.i_id = "
   let colStr = inStr[3,64] clipped

#   display "inStr: ", inStr clipped, "<br>"
#   display "QStr (before for): ", QStr clipped, "<br>"
#   display "colStr: ", colStr clipped, "<br>"
   for i = 1 to G_INDNumCols
#display "i:", i, " i_col: ", INDColNamesArr[i].i_col clipped, " idx: ", INDColNamesArr[i].idx using "##", " colStr: ", colStr clipped, "<br>"
      if( INDColNamesArr[i].i_col = colStr )then
         let QStr = QStr clipped, " ", INDColNamesArr[i].idx using '##'
         exit for
      end if
   end for
#   display "QStr (after for): ", QStr clipped, "<br>"

#display "QStr: ", QStr
prepare GISID from QStr 
execute GISID into tStr

return tStr

end function  #GetINDStr

function GetSKStrU( inBrand, inStr )
define
   inBrand like brands.b_id,
   inStr char(64),
   colStr char(20),
   QStr char(128),
   tStr char(128)

   let QStr = "select unique a.s_desc from skill a where a.b_id = '", inBrand clipped,
              "' and a.db_num = "
   let colStr = inStr[3,64] clipped

#display "QStr: ", QStr clipped
#display "colStr: ", colStr clipped

   case colStr 
      when "skill_01"
         let QStr = QStr clipped, " 1"
      when "skill_02"
         let QStr = QStr clipped, " 2"
      when "skill_03"
         let QStr = QStr clipped, " 3"
      when "skill_04"
         let QStr = QStr clipped, " 4"
      when "skill_05"
         let QStr = QStr clipped, " 5"
      when "skill_06"
         let QStr = QStr clipped, " 6"
      when "skill_07"
         let QStr = QStr clipped, " 7"
      when "skill_08"
         let QStr = QStr clipped, " 8"
      when "skill_09"
         let QStr = QStr clipped, " 9"
      when "skill_10"
         let QStr = QStr clipped, "10"
      when "skill_11"
         let QStr = QStr clipped, "11"
      when "skill_12"
         let QStr = QStr clipped, "12"
      when "skill_13"
         let QStr = QStr clipped, "13"
      when "skill_14"
         let QStr = QStr clipped, "14"
      when "skill_15"
         let QStr = QStr clipped, "15"
      when "skill_16"
         let QStr = QStr clipped, "16"
      when "skill_17"
         let QStr = QStr clipped, "17"
      when "skill_18"
         let QStr = QStr clipped, "18"
      when "skill_19"
         let QStr = QStr clipped, "19"
      when "skill_20"
         let QStr = QStr clipped, "20"
      when "skill_21"
         let QStr = QStr clipped, "21"
      when "skill_22"
         let QStr = QStr clipped, "22"
      when "skill_23"
         let QStr = QStr clipped, "23"
      when "skill_24"
         let QStr = QStr clipped, "24"
      when "skill_25"
         let QStr = QStr clipped, "25"
      when "skill_26"
         let QStr = QStr clipped, "26"
      when "skill_27"
         let QStr = QStr clipped, "27"
      when "skill_28"
         let QStr = QStr clipped, "28"
      when "skill_29"
         let QStr = QStr clipped, "29"
      when "skill_30"
         let QStr = QStr clipped, "30"
      otherwise
      let QStr = QStr clipped, "99"
   end case

#display "Skill QStr: ", QStr
prepare LSID from QStr 
execute LSID into tStr
#display "tStr: ", tStr

return tStr

end function

