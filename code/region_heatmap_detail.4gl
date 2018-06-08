
## August    24, 2015 John M. Shoemaker, created
## September 22, 2015 John M. Shoemaker, jshoemaker1@cox.net, add in Social Unit OU
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #131
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #132
## February 16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #134
## November 30, 2017 - John Shoemaker jshoemaker1@cox.net - merge, #289

globals "globals.4gl"

define
   ARecArr array[1000] of record 
      ceid like coverage_au.ceid,
      part_name like coverage_au.part_name,
      uname like coverage_au.part_name,

      ssr_au like coverage_au.ssr,
      lnk_aus like reps.r_link,

      ctp_au1 like coverage_au.ctp1,
      ctp_au2 like coverage_au.ctp2,
      ctp_au3 like coverage_au.ctp3,
      ctp_au4 like coverage_au.ctp4,
      ctp_au5 like coverage_au.ctp5,

      lnk_au1 like reps.r_link,
      lnk_au2 like reps.r_link,
      lnk_au3 like reps.r_link,
      lnk_au4 like reps.r_link,
      lnk_au5 like reps.r_link
   end record,
#   ARecArr array[500] of record like coverage_ws.*,
   G_TotalCnt smallint,
   TitlesArr array[20] of char(15)

main
define
   qtrStr char(512),
   wStr char(512),
   SQLStr char(512),
   i smallint,
   Reg like _eucolnamesu.idx,
   RegStr like eus.e_region,
   EUSStr like eus.e_name,
   cnt smallint,
   oe smallint,
   tmpnm char(1),
   BPTV_Cnt smallint,
   ncolor char(15)


call ReadCmdLn("region_heatmap_detail", 5)
let Reg = arg_val(5)  #only the first 5 values are read via ReadCmdLn
call ProcCmdLn("region_heatmap_detail")
#call Header(2, 'NA', '--', 0)
call Header(0, IRec.i_id, BRec.b_id, 1)
#display "INPUT: Reg: ", Reg

let SQLStr = "select unique a.e_region, a.e_name from eus a where a.e_brand='", BRec.b_id clipped, "' ",
             " and a.e_id=", Reg
prepare RTSTID from SQLStr
execute RTSTID into RegStr, EUSStr

case BRec.b_id 
   when "AU"
      let TitlesArr[1] = "AU BPR"
      let TitlesArr[2] = "IM TSS"
      let TitlesArr[3] = "ECM TSS"
      let TitlesArr[4] = "BA TSS"
      let TitlesArr[5] = "IoT TSS"
      let TitlesArr[6] = "Other TSS"
   when "SU"
      let TitlesArr[1] = "SU BPR"
      let TitlesArr[2] = "WS TSS"
      let TitlesArr[3] = "RA TSS"
      let TitlesArr[4] = "TI TSS"
      let TitlesArr[5] = "Other TSS"
      let TitlesArr[6] = "Other TSS"
   when "BU"
      let TitlesArr[1] = "Commerce BPR"
      let TitlesArr[2] = "Commerce TSS"
   otherwise
      let TitlesArr[1] = "BPR"
      let TitlesArr[2] = "TSS"
end case


display " "

display "<div class='centerText' dir='ltr'>"   

display "<div dir='ltr' style='text-align: center'>"

display "<em><span style='font-size: 16px'></span></em></div>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", RegStr clipped, "/", EUSStr clipped, " Partner List", "</span></em></div>"
display "<p>"

## Load ALL Data (all brands
let cnt = LoadMasterCovArr( Reg )
#display "RETURN cnt: ", cnt

## create title for the data
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 800px; font: 16px/26px Georgia, Garamond, Serif; height: 50px;'>"
display "<table class='u1' border='0' cellpadding='0' cellspacing='0' dir='ltr' height='50'>"

display "<tr>"
display "<td class='leftText' style='height: 10px; width: 150; font-size: 10px;'>"
display "BP Company Name"  #</h2>"
display "</td>"
for i=1 to 6
   display "<td class='rightText' style='width: 100; font-size: 10px;'>"
   display "<div style='text-align: right'>"

   display TitlesArr[i] clipped, "</div>"#, "</h2>"
   display "</td>"
end for
display "</table>"
display "</div>"

## create scrollable display of data
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 800px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto'>"
#display "<div dir='ltr' style='border-bottom: #ccc 1px solid; border-left: #ccc 1px solid; width: 600px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto; border-top: #ccc 1px solid; border-right: #ccc 1px solid'>"

display "<table class='u1' border='0' cellpadding='0' cellspacing='0' dir='ltr'>"

#foreach ACurs into ARec.*, tmpnm
for i = 1 to cnt
#display "i: ", i
   display "<tr>"
#   display "<tr style='height: 12px'>"
   display "<td class='leftText' style='height: 10px; width: 200; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
#   display ARecArr[i].part_name clipped, "</td>"
#display "<td>",ARecArr[i].ceid clipped, "</td>"
   display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", ARecArr[i].ceid clipped, ".html' target='_blank'>", ARecArr[i].part_name clipped, "</a>", " (", ARecArr[i].ceid clipped, ") </td>"
  
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_aus clipped, "' target ='_blank'>", ARecArr[i].ssr_au clipped, "</a></td>"
   
{
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_sus clipped, "' target ='_blank'>", ARecArr[i].ssr_su clipped, "</a></td>"

   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_iss clipped, "' target ='_blank'>", ARecArr[i].ssr_is clipped, "</a></td>"
} 
## AU TSS
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au1 clipped, "' target ='_blank'>", ARecArr[i].ctp_au1 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au2 clipped, "' target ='_blank'>", ARecArr[i].ctp_au2 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au3 clipped, "' target ='_blank'>", ARecArr[i].ctp_au3 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au4 clipped, "' target ='_blank'>", ARecArr[i].ctp_au4 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_au5 clipped, "' target ='_blank'>", ARecArr[i].ctp_au5 clipped, "</a></td>"
   
## SU TSS
{
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su1 clipped, "' target ='_blank'>", ARecArr[i].ctp_su1 clipped, "</a></td>"
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su2 clipped, "' target ='_blank'>", ARecArr[i].ctp_su2 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su3 clipped, "' target ='_blank'>", ARecArr[i].ctp_su3 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su4 clipped, "' target ='_blank'>", ARecArr[i].ctp_su4 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_su5 clipped, "' target ='_blank'>", ARecArr[i].ctp_su5 clipped, "</a></td>"
   
   display "<td class='leftText' style='height: 10px; width: 100px; font-size: 10px;"
   if( (i mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display "<a href='", ARecArr[i].lnk_is1 clipped, "' target ='_blank'>", ARecArr[i].ctp_is1 clipped, "</a></td>"
}
   

#-------------------------------------------------------------------------------------------------
   display "</tr>"
end for
#end foreach

#-------------------------------------------------------------------------------------------------
#display "</tbody>"
## display summary counts
display "</table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 800px; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of "
display "Partners: ", cnt using "<<<", "<br />"

display "</div>"
display "<p dir='ltr'> &nbsp;</p>"

call ShowVer( 0 )

end main

function LoadMasterCovArr( inReg )
define
   inReg like _eucolnamesu.idx,
   i smallint,
   tmpcolname like _eucolnamesu.colname,
   SQLStr char(1024)
 
   let SQLStr = "select a.colname from _eucolnamesu a where a.idx = '", inReg clipped, "'"
   prepare ICLU1 from SQLStr
   execute ICLU1 into tmpcolname
#display "tmpcolname: ", tmpcolname

let SQLStr = "select a.ceid from ", cov_tab clipped, " a where a.reseller !='N' and a.reseller !='V' and a.part_type!='D' and a.", tmpcolname clipped, " in ('Y','H') into temp st1;"

#select a.ceid from coverage_au a where a.reseller !='N' and a.reseller !='V' and a.part_type!='D' union
#select a.ceid from coverage_su a where a.reseller !='N' and a.reseller !='V' and a.part_type!='D' union
#select a.ceid from coverage_is a where a.reseller !='N' and a.reseller !='V' and a.part_type!='D' 
#into temp st1;

#display SQLStr
   prepare ICLU2 from SQLStr
   execute ICLU2 

#display "After creation of st1"

case BREc.b_id

   when "AU"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_au b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

   when "SU"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_su b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

   when "CU"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_cu b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

   when "BU"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_bu b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

{
   when "BU"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp ctp_au1,' ' ctp_au2, ' ' ctp_au3, ' ' ctp_au4, ' ' ctp_au5, ",
            "m.r_link lnk_au1, ' ' lnk_au2, ' ' lnk_au3, ' ' lnk_au4, ' ' lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_is b, outer reps s1, outer reps m ) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp = m.r_name ",
      "into temp st2; "
}

   when "SE"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_se b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

   when "ST"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_st b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

   when "ES"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_es b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "


   when "WU"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_wu b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

   when "IO"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_io b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

   when "HW"
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (coverage_hw b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "

   otherwise
      let SQLStr = "select  ",
            "a.ceid, ",
            "b.part_name part_name, ",
            "'                                                                  ' uname, ",
            "b.ssr ssr_au,  ",
            "s1.r_link lnk_aus, ",
            "b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5, ",
            "m.r_link lnk_au1, n.r_link lnk_au2, o.r_link lnk_au3, p.r_link lnk_au4, q.r_link lnk_au5  ",
        "from  ",
            "st1 a,  ",
            "outer (", cov_tab clipped ," b, outer reps s1, outer reps m, outer reps n, outer reps o, outer reps p, outer reps q) ",
      "where ",
            "a.ceid = b.ceid ",
        "and b.ssr = s1.r_name ",
        "and b.ctp1 = m.r_name ",
        "and b.ctp2 = n.r_name ",
        "and b.ctp3 = o.r_name ",
        "and b.ctp4 = p.r_name ",
        "and b.ctp5 = q.r_name ",
      "into temp st2; "


end case
#display SQLStr
   prepare GSC2 from SQLStr
   execute GSC2 

#display "after creation of st2"

update st2 set uname = upper(part_name);

let SQLStr = "select ",
      "a.ceid, ",
      "a.part_name, ",
      "a.uname, ",
      "a.ssr_au, ",
      "a.lnk_aus, ",
      "ctp_au1, ctp_au2, ctp_au3, ctp_au4, ctp_au5, ",
      "lnk_au1, lnk_au2, lnk_au3, lnk_au4, lnk_au5 ",
      "from st2 a order by uname "

#display SQLStr
   prepare LMA1 from SQLStr
   declare LMA1Curs cursor for LMA1

   let i = 0
   foreach LMA1Curs into ARecArr[i+1].*
      let i = i + 1
   end foreach

   let G_TotalCnt = i

   return G_TotalCnt


end function  #LoadMasterCovArr

