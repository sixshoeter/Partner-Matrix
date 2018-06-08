
##
## February  01, 2017 - John M. Shoemaker, jshoemaker1@cox.net, create #203

globals "globals.4gl"

main

define
   i, nat_cnt, cov_cnt smallint,
   InfoRec record
      pod like pod.pod,
      ceid like pod.ceid,
      unit_ceid like pod.ceid,
      part_name like pod.part_name,
      r_name like reps.r_name,
      r_link like reps.r_link,
      pod_ord like pod_info.pod_ord
   end record,
   oPod like pod.pod,
   oBP like pod.part_name,
   SQLStr char(256)

call ReadCmdLn( "coverage", 3 )
call ProcCmdLn( "coverage" )
call Header(0, IRec.i_id, BRec.b_id, 1)

display " "
display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'> POD Organization</span></em></div>"
display "<div dir='ltr' style='text-align: center'>"
display "<p>"

display "<table align='center' border='1' dir='ltr' height='376' style='width: 950px' width='950'>"
display "<tbody>"

## use pod table to determine pcr
let SQLStr="select b.pod, b.ceid, d.ceid, b.part_name, s.r_name, s.r_link, c.pod_ord ",
           "from pod b, pod_info c, outer reps s, outer ", cov_tab clipped, " d where ",
           "b.pod=c.pod and b.pcr=s.r_name and b.ceid=d.ceid and d.reseller!='X'",
           "order by c.pod_ord, part_name, r_name"

prepare PODID from SQLStr
declare PODCurs cursor for PODID

let i = 1
let nat_cnt=0
let oPod="<none>"
let oBP="<none>"

foreach PODCurs into InfoRec.*

if( oPod != InfoRec.pod )then
   if( i > 1 )then
      display "</td>"
      display "</tr>"
   end if
   display "<tr>"
   display "<td style='text-align: center; background-color: rgb(230,230,250); width: 200px; vertical-align: middle'>"
   display "<h3>"
   display "<span style='font-size:21px;'>"
   display InfoRec.pod clipped, " Pod<br /><p>"

   let cov_cnt = GetPodCnt(InfoRec.pod)
   if( cov_cnt > 0 )then
      display "<p><span style='font-size:10px;'>", "(", cov_cnt using "<<<"
      if( cov_cnt > 1 )then
         display " partners)"
      else
         display " partner)"
      end if
      display "</span>"
   end if

   display "<br><br><span style='font-size:8px;'>PCR names in parans on right.</span>"

   display "</span"
   display "</td>"
   display "<td style='text-align: left; width: 450px'>"
   display "<div>"

   let i=i+1
   let oPod=InfoRec.pod
end if  #oPod=InfoRec.pod


#<a href='", InfoRec.r_link clipped, "' target='_blank'>",InfoRec.r_name clipped, "</a><p>"

   if( InfoRec.pod != 'National' and oBP != InfoRec.part_name )then
      if( InfoRec.unit_ceid is not null )then
	 display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", InfoRec.unit_ceid clipped, ".html'>", InfoRec.part_name clipped, " </a>"
      else
         display InfoRec.part_name clipped
      end if  #unit_ceid is not null
      if( InfoRec.r_name is not null )then
         display "(<a href='", InfoRec.r_link clipped, "' target='_blank'>", InfoRec.r_name clipped, "</a>)"
      end if  #r_name is not null
      display "<br />"
   else
      if( oBP = InfoRec.part_name )then
         if( nat_cnt = 0 )then
            if( InfoRec.unit_ceid is not null )then
	       display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", InfoRec.unit_ceid clipped, ".html'>", InfoRec.part_name clipped, " </a>"
            else
               display InfoRec.part_name clipped
            end if  #unit_ceid is not null
            display "(<a href='", InfoRec.r_link clipped, "' target='_blank'>", InfoRec.r_name clipped, "</a>"
         else
            display "- <a href='", InfoRec.r_link clipped, "' target='_blank'>", InfoRec.r_name clipped, "</a>"
         end if
         let nat_cnt=nat_cnt+1
      else
            if( nat_cnt > 0)then
               display ")<br />" 
            end if
            if( InfoRec.unit_ceid is not null )then
	       display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", InfoRec.unit_ceid clipped, ".html'>", InfoRec.part_name clipped, " </a>"
            else
               display InfoRec.part_name clipped
            end if  #unit_ceid is not null
            display "(<a href='", InfoRec.r_link clipped, "' target='_blank'>", InfoRec.r_name clipped, "</a>"
            let nat_cnt=nat_cnt+1
      end if  #oBP = part_name
   end if  #oBP != part_name

   let oBP=InfoRec.part_name
   let i=i+1
end foreach
if( InfoRec.pod = 'National' )then
   display ")"
end if

display "</td>"
display "</tr>"
display "      </tbody>"
display "   </table>"
display "</div>"
display "<p dir='ltr'> &nbsp;</p>"
display "</tr>"

call ShowVer( 0 )

end main

function GetPodCnt( in_pod )
define
   in_pod like pod_info.pod,
   cnt smallint,
   SQLStr char(256)

let SQLStr = "select count(distinct ceid) from pod a where a.pod='", in_pod clipped, "' "

#display SQLStr
prepare GCCID from SQLStr
execute GCCID into cnt

return cnt

end function  #GetPodCnt



