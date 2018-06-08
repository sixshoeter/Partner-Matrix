globals "globals.4gl"

MAIN
define
   SQLStr char(1024),
   dt date,
   target like access.target,
   tbrand char(2),
   cnt smallint,
   pn like coverage_au.part_name

#select target, count(*) from access where target matches "*.html"
#group by 1 having count(*)>50 order by 2;

#select date(dttm) dt, count(*) from access where target matches "*.html"
#group by 1 having count(*)>50 order by 1 asc;

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/NC/*' and year(dttm)=2017"
prepare NCID from SQLStr
execute NCID into cnt
display "Unique NEW CLOUD IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/AU/*' and year(dttm)=2017"
prepare AUID from SQLStr
execute AUID into cnt
display "Unique Analytics IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/SU/*' and year(dttm)=2017"
prepare SUID from SQLStr
execute SUID into cnt
display "Unique Systems Middleware IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/BU/*' and year(dttm)=2017"
prepare BUID from SQLStr
execute BUID into cnt
display "Unique Commerce IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/ES/*' and year(dttm)=2017"
prepare ESID from SQLStr
execute ESID into cnt
display "Unique ESS IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/ST/*' and year(dttm)=2017"
prepare STID from SQLStr
execute STID into cnt
display "Unique Storage IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/IO/*' and year(dttm)=2017"
prepare IOID from SQLStr
execute IOID into cnt
display "Unique IoT IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/WU/*' and year(dttm)=2017"
prepare WUID from SQLStr
execute WUID into cnt
display "Unique Watson Unit IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/SE/*' and year(dttm)=2017"
prepare SEID from SQLStr
execute SEID into cnt
display "Unique Security IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/CU/*' and year(dttm)=2017"
prepare CUID from SQLStr
execute CUID into cnt
display "Unique Cloud IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/HW/*' and year(dttm)=2017"
prepare HWID from SQLStr
execute HWID into cnt
display "Unique Hardware IP addresses: ", cnt using "###,###"

{
let SQLStr = "select count(distinct ip) from access where target matches '*/NA/WS/*' and year(dttm)=2015"
prepare A1ID from SQLStr
execute A1ID into cnt
display "Unique WebSphere IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/IM/*' and year(dttm)=2015"
prepare A2ID from SQLStr
execute A2ID into cnt
display "Unique IM IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/EM/*' and year(dttm)=2015"
prepare A3ID from SQLStr
execute A3ID into cnt
display "Unique ECM IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/SC/*' and year(dttm)=2015"
prepare A4ID from SQLStr
execute A4ID into cnt
display "Unique Smarter Cities IP addresses: ", cnt using "###,###"

let SQLStr = "select count(distinct ip) from access where target matches '*/NA/IS/*' and year(dttm)=2015"
prepare A7ID from SQLStr
execute A7ID into cnt
display "Unique IS (Commerce) IP addresses: ", cnt using "###,###"
}

#let SQLStr = "select date(dttm) dt, target, count(*) cnt from access group by 1,2 "
#where target matches '*/NA/WS/*'"
#prepare A5ID from SQLStr
#declare A5Curs cursor for A5ID
#foreach A5Curs into dt, target, cnt
   #display "Unique : ", dt, target clipped, " ", cnt using "###,###"
#end foreach

let SQLStr = "select a.target, count(*) cnt from access a where ",
             "(a.target matches '*/NA/NC/H/*') or ",
             "(a.target matches '*/NA/AU/H/*') or ",
             "(a.target matches '*/NA/SU/H/*') or ",
             "(a.target matches '*/NA/CU/H/*') or ",
             "(a.target matches '*/NA/BU/H/*') or ",
             "(a.target matches '*/NA/ST/H/*') or ",
             "(a.target matches '*/NA/ES/H/*') or ",
             "(a.target matches '*/NA/IO/H/*') or ",
             "(a.target matches '*/cgi-bin/*query*') ",
             " and year(dttm)=2017 group by 1 order by 1 desc"
prepare A6ID from SQLStr
declare A6Curs cursor for A6ID
foreach A6Curs into target, cnt
   display target clipped, " ", cnt using "###,###"
end foreach

let SQLStr = "select a.target, count(*) cnt from access a where ",
             "(a.target matches '*/NA/NC/S/*') or ",
             "(a.target matches '*/NA/AU/S/*') or ",
             "(a.target matches '*/NA/SU/S/*') or ",
             "(a.target matches '*/NA/CU/S/*') or ",
             "(a.target matches '*/NA/BU/S/*') or ",
             "(a.target matches '*/NA/ST/S/*') or ",
             "(a.target matches '*/NA/ES/S/*') or ",
             "(a.target matches '*/NA/IO/S/*') ",
             " and year(dttm)=2017 group by 1 order by 1 desc"
prepare AS6ID from SQLStr
declare AS6Curs cursor for AS6ID
foreach AS6Curs into target, cnt
   display target clipped, " ", cnt using "###,###"
end foreach

#let SQLStr = "select count(distinct date(dttm)) from access where target matches '*/NA/RA/*'"
#prepare A5ID from SQLStr
#execute A5ID into cnt
#display "Unique Rational IP addresses: ", cnt using "###,###"

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/NCquery*' and year(dttm)=2017"
prepare NCB1ID from SQLStr
execute NCB1ID into cnt
display "NC Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/AUquery*' and year(dttm)=2017"
prepare AUB1ID from SQLStr
execute AUB1ID into cnt
display "AU Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/SUquery*' and year(dttm)=2017"
prepare SUB1ID from SQLStr
execute SUB1ID into cnt
display "SU Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/BUquery*' and year(dttm)=2017"
prepare BUB1ID from SQLStr
execute BUB1ID into cnt
display "BU Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/ESquery*' and year(dttm)=2017"
prepare ESB1ID from SQLStr
execute ESB1ID into cnt
display "ES Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/STquery*' and year(dttm)=2017"
prepare STB1ID from SQLStr
execute STB1ID into cnt
display "ST Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/IOquery*' and year(dttm)=2017"
prepare IOB1ID from SQLStr
execute IOB1ID into cnt
display "IO Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/WUquery*' and year(dttm)=2017"
prepare WUB1ID from SQLStr
execute WUB1ID into cnt
display "WU Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/SEquery*' and year(dttm)=2017"
prepare SEB1ID from SQLStr
execute SEB1ID into cnt
display "SE Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/CUquery*' and year(dttm)=2017"
prepare CUB1ID from SQLStr
execute CUB1ID into cnt
display "CU Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/HWquery*' and year(dttm)=2017"
prepare HWB1ID from SQLStr
execute HWB1ID into cnt
display "HW Find a Partner: ", cnt
{
let SQLStr = "select count(*) from access where target matches '*/cgi-bin/WSquery*' and year(dttm)=2017"
prepare B1ID from SQLStr
execute B1ID into cnt
display "WS Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/IMquery*' and year(dttm)=2017"
prepare B2ID from SQLStr
execute B2ID into cnt
display "IM Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/EMquery*' and year(dttm)=2017"
prepare B2aID from SQLStr
execute B2aID into cnt
display "EM Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/SCquery*' and year(dttm)=2017"
prepare B2bID from SQLStr
execute B2bID into cnt
display "SC Find a Partner: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/ISquery*' and year(dttm)=2017"
prepare ISB2bID from SQLStr
execute ISB2bID into cnt
display "IS Find a Partner: ", cnt
}

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/WSexports*' and year(dttm)=2017"
prepare B3ID from SQLStr
execute B3ID into cnt
display "WS Exports: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/IMexports*' and year(dttm)=2017"
prepare B4ID from SQLStr
execute B4ID into cnt
display "IM Exports: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/EMexports*' and year(dttm)=2017"
prepare B4aID from SQLStr
execute B4aID into cnt
display "EM Exports: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/SCexports*' and year(dttm)=2017"
prepare B4bID from SQLStr
execute B4bID into cnt
display "SC Exports: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/ISexports*' and year(dttm)=2017"
prepare ISB4bID from SQLStr
execute ISB4bID into cnt
display "IS Exports: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/NCexports*' and year(dttm)=2017"
prepare NC3ID from SQLStr
execute NC3ID into cnt
display "NC Exports: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/AUexports*' and year(dttm)=2017"
prepare AU3ID from SQLStr
execute AU3ID into cnt
display "AU Exports: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/SUexports*' and year(dttm)=2017"
prepare SU3ID from SQLStr
execute SU3ID into cnt
display "SU Exports: ", cnt

let SQLStr = "select count(*) from access where target matches '*/cgi-bin/BUexports*' and year(dttm)=2017"
prepare BU3ID from SQLStr
execute BU3ID into cnt
display "BU Exports: ", cnt

display "------------------------------------"
display "Consider specific partner pages"
display "------------------------------------"

let SQLStr = "select a.target, a.target[5,6] brand, count(*) cnt from access a where ",
             "(a.target matches '*/NA/NC/P/*.html') or ",
             "(a.target matches '*/NA/AU/P/*.html') or ",
             "(a.target matches '*/NA/SU/P/*.html') or ",
             "(a.target matches '*/NA/CU/P/*.html') or ",
             "(a.target matches '*/NA/BU/P/*.html') or ",
             "(a.target matches '*/NA/ST/P/*.html') or ",
             "(a.target matches '*/NA/ES/P/*.html') or ",
             "(a.target matches '*/NA/IO/P/*.html') or ",
             "(a.target matches '*/NA/AU/S/*.html') or ",
             "(a.target matches '*/NA/SU/S/*.html') or ",
             "(a.target matches '*/NA/CU/S/*.html') or ",
             "(a.target matches '*/NA/BU/S/*.html') or ",
             "(a.target matches '*/NA/ST/S/*.html') or ",
             "(a.target matches '*/NA/ES/S/*.html') or ",
             "(a.target matches '*/NA/IO/S/*.html') ",
             " and year(dttm)=2017 and month(dttm)=5 group by 2, 1 order by 2, 3 desc"
#display SQLStr clipped
prepare AUpID from SQLStr
declare AUpCurs cursor for AUpID
foreach AUpCurs into target, tbrand, cnt
   let pn=getPN(target, tbrand)
   if( pn is not null )then
      display tbrand, "~", pn clipped, "~", cnt using "###,###"
   end if
end foreach

{
display "------------------------------------"
display "Analytics deeper look"
display "------------------------------------"

select date(dttm) dt1, id, count(*) cnt1 from access_page group by 1,2 into temp t1;
select dt1, count(*) cnt from t1 group by 1 into temp t2;

display "see /home/ftpuser/access_t2.csv"
unload to "/home/ftpuser/access_t2.csv" select * from t2 order by dt1;
}


END MAIN

function getPN( intarget, inbrand )
define
   intarget like access.target,
   inbrand char(2),
   SQLStr char(128),
   l,i,j,k smallint,
   tVal, retVal like coverage_au.part_name

   let i=1
   let j=0
   let l=length(intarget)

#     find start of ceid
   while i<(l-2) and j=0
      if(intarget[i,i+2] = "/P/" or intarget[i,i+2] = "/S/" )then
         let j=i+3  #start of ceid
#display "J: ", j, " ", intarget clipped
      end if 
      let i=i+1
#display "i,l,j: ", i, l, j
   end while  #find start of ceid

#     find end of ceid
   let i=j  #start looking for the end by starting where the ceid starts
   let k=0
   while i<l and k=0
      if(intarget[i,i] = "." or intarget[i,i] = "-")then
         let k=i-1  #end of ceid
#display "K: ", k, " ", intarget clipped
      end if 
      let i=i+1
#display "i,l,k: ", i, l, k
   end while  #find end of ceid

   if( k<=j )then
      let retVal = ""
   else
      let tVal= intarget[j,k]
      let SQLStr="select a.part_name from coverage_", inbrand clipped, " a where a.ceid='", tVal clipped, "'"
      prepare LUPN from SQLStr
      execute LUPN into retVal
   end if

#   display "CEID: ", retVal
   return retVal

end function  #getPN


# '*/NA/AU/P/*.html')
