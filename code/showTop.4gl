## January  09, 2018 John M. Shoemaker, create showTop.4gl, #291
## February 02, 2018 John M. Shoemaker, remove default of NC, #310

globals "globals.4gl"

main
define
   UBRec record like unit_brand.*,
   SCRec record like skill_cat.*,
   SRec record like skill.*,
   snum smallint,
   mc smallint,
   t1cnt, t2cnt, t3cnt smallint,
   tceid like coverage_nc.ceid,
   tpart_name like coverage_nc.part_name,
#   thq like coverage_nc.hq,
   thq like states.s_name,
   tmp_line char(128),
   osdesc like unit_brand.sdesc,
   oc_long like skill_cat.c_long,
   os_desc like skill.s_desc,
   cnt,pcnt smallint,
   SQLStr1, SQLStr2, SQLStr3, SQLStr4, SQLStr5 char(512)


#set explain on;
call ReadCmdLn( "showTop", 3 )
call ProcCmdLn( "showTop" )
let UpdateAllow = FALSE

let snum=4

call ShowTitleDetailS( FALSE, 0, FALSE )
display "<div style='width: 80%; margin: 0 auto;'>"
display "<h2 class='leftText' style='text-align: left;'><strong>IBM Cloud Elite ", MasterRec.best_msg clipped, " Partners</strong></h2>"
display "</div>"

##-----------------------------------------------------------------------------------------------------
## Build TOP SKILLS - START
##-----------------------------------------------------------------------------------------------------

#let SQLStr="select b.*, c.*, a.* from skill a, unit_brand b, skill_cat c where a.b_id=b.b_id and c.c_brand=a.b_id and c.c_id=a.c_id and b.u_id='NC' and s_name != 'NA' order by a.b_id, c.c_id, a.s_num"

   let osdesc="X"
   let oc_long="X"
   let os_desc="X"

   display "<div id='Top' class='tab' style='padding: 10px; ;'>"
## UB
   let SQLStr1="select b.* from unit_brand b where b.u_id='", CLRec.brand clipped, "' order by b_id;"

   prepare Top1ID from SQLStr1
   declare Top1Curs cursor for Top1ID
   let t1cnt=FALSE
   foreach Top1Curs into UBRec.*
   
## SC
      let SQLStr2="select unique c.* from skill_cat c where c.c_brand='", UBRec.b_id clipped, "' order by c_brand, c.c_id"

      prepare Top2ID from SQLStr2
      declare Top2Curs cursor for Top2ID
      let t2cnt=FALSE
      foreach Top2Curs into SCRec.*
## S
         let SQLStr3="select a.* from skill a where a.b_id='", UBRec.b_id clipped, "' and a.c_id=", SCRec.c_id using "<<", " and s_name != 'NA'"

          prepare Top3ID from SQLStr3
          declare Top3Curs cursor for Top3ID
          let t3cnt=FALSE
          foreach Top3Curs into SRec.*

##    Partner

             let SQLStr5="select count(*) from skills_", UBRec.b_id clipped, " a, coverage_nc b where a.ceid=b.ceid and skill_", SRec.db_num using "&&", ">=", snum using "&"
             prepare Top4CntID from SQLStr5
             execute Top4CntID into pcnt

             let SQLStr4="select b.ceid, b.part_name, b.hq from skills_", UBRec.b_id clipped, " a, coverage_nc b where a.ceid=b.ceid and skill_", SRec.db_num using "&&", ">=", snum using "&", "  order by part_name"
#             let SQLStr4="select b.ceid, b.part_name, c.s_name from skills_", UBRec.b_id clipped, " a, coverage_nc b, outer states c where a.ceid=b.ceid and b.hq=c.s_id and skill_", SRec.db_num using "&&", ">=", snum using "&", "  order by part_name"
             prepare Top4ID from SQLStr4
             declare Top4Curs cursor for Top4ID
             let cnt=0
             foreach Top4Curs into tceid, tpart_name, thq


##              show UnitBrand sdesc if there are top partners
                if( osdesc!=UBRec.sdesc )then
                   display "<table border='1' width='1044px' cellpadding='5'>"
                   display "<tbody><tr>"

                   display "<td colspan='100' style='vertical-align: middle; background-color: #F0F0F0'>"
                   display "<strong>", UBRec.sdesc clipped, "</strong></td></tr>"
                   display "<tr><td>"
                   display "<table cellspacing='0' border='0' style='padding-left: 10px;' class='mytable'>"
                   display "<tbody>"
                   let osdesc=UBRec.sdesc
                   let t1cnt=TRUE
                end if


##              show SkillCat c_long if there are top partners
                if( oc_long != SCRec.c_long )then
#                   display "<tr><td colspan='1' style='width: 350px; vertical-align: top;'>", SCRec.c_long clipped, "</td>"
                   display "<tr><td class='bottomborder2' width='350px;'><strong>", SCRec.c_long clipped, "</strong></td>"
                   display "<td class='auto-style3'>"
                   display "<table cellspacing='0' border='0' style='padding-left: 10px;' class='mytable'>"
                   let oc_long=SCRec.c_long
                   let t2cnt=TRUE
                end if


##              show Skill c_desc if there are top partners
                if( os_desc != SRec.s_desc )then
                   display "<tr><td class='bottomborder2' width='200'><em>", SRec.s_desc clipped, "</em></td>"
#                   display "<tr><td colspan='1' style='width: 350px; vertical-align: top;'>", SRec.s_desc clipped, "</td>"
                   display "<td class='bottomborder2' width='50'>&nbsp;</td>"
                   display "<td><table cellspacing='0' border='0' style='padding-left: 10px;' class='mytable'>"
                   let os_desc=SRec.s_desc
                   let t3cnt=TRUE
                end if

##              show Partner
                let cnt=cnt+1
                let tmp_line="<a href='/NA/", CLRec.brand clipped, "/S/", tceid clipped, ".html' target='pdetails'>", tpart_name clipped, "</a>" 
                if( thq is not null and thq != " " )then
                   let tmp_line=tmp_line clipped, " (", thq clipped, ")"
                end if  #thq
                if( cnt=pcnt )then
                   display "<tr><td class='bottomborder2'>", tmp_line clipped, "</td></tr>"
                else
#                   display "<tr><td>", tmp_line clipped, "</td></tr>"
                   display "<tr><td>", tmp_line clipped, "</td></tr>"
                end if

##    /Partner
#            display "</table>"
             end foreach
             if( t3cnt )then
                display "</table>"
		let t3cnt=FALSE
             end if

## /S
          end foreach  #Top3Curs

## /SC
          if( t2cnt )then
             display "</table>"
          let t2cnt=FALSE
          end if
      end foreach  #Top2Curs

## /UB
      if( t1cnt )then
	     display "</table>"
             display "</table>"
      let t1cnt=FALSE
      end if
   end foreach  #Top1Curs
#      display "</table>" 

display "</div>"
##-----------------------------------------------------------------------------------------------------
## Build TOP SKILLS - END
##-----------------------------------------------------------------------------------------------------

end main

{

      let osc=-1    ##old skill category
      for i = 1 to skill_cat
         let col_cnt = GetCatCnt( inBrand, SkillCatArr[i].c_id )
         display "<tr><td colspan='1' style='width: 350px; vertical-align: top;'>", SkillCatArr[i].c_long clipped, "</td>"
	 display "<td class='auto-style3'>"
         display "<table width='380' cellspaces='0' class='mytable'>"
         let mc=0
         for sidx = 1 to SkillsMax
#display "Rec:", SkillArrU[inbIdx,sIdx].*
            if( osc != SkillCatArr[i].c_id and (BPSkillsArr[sidx]='1' or BPSkillsArr[sidx]='2' or BPSkillsArr[sidx]='3' or BPSkillsArr[sidx]='4'))then
#            if( osc != SkillCatArr[i].c_id )then
               if( SkillArrU[inbIdx,sidx].s_name != "NA" and SkillArrU[inbIdx,sidx].c_id = i )then
                  if( mc=0 )then
#         display "<tr><td colspan='1' style='width: 350px; vertical-align: top;'>", SkillCatArr[i].c_long clipped, "</td>"
#         display "<td class='auto-style3'>"
#         display "<table width='380' cellspaces='0' class='mytable'>"

                  display "<tr>"
                  end if
                  let mc=mc+1
                  display "<td class='bottomborder2' width='300'>", SkillArrU[inbIdx,sidx].s_desc clipped, "</td>"
                  display "<td class='bottomborder2' width='50'>&nbsp;</td>"
                  display "<td class='' width='150'>"
#                     let mc = mc+1
#                  else
#                     display "<td class='bottomborder2' width=350'>", SkillArrU[inbIdx,sidx].s_desc clipped, "</td>"
#		     let mc = mc+1
#                  end if
                  let starmax=BPSkillsArr[sidx]
#                  display "starmax:", starmax
                     if( starmax >4 )then
                        let starmax=4
                     else 
                        if( starmax < 1 or  starmax is null )then
                           let starmax=0
                        end if
                     end if
                     if( UpdateAllow )then
                        display "<INPUT NAME='", sidx using '<<', "' VALUE=", starmax using '##', ">"
                     else
                        for starcnt=1 to starmax
                           display "<img style='margin-bottom: 2px;' height='15' src='/", IRec.i_id clipped, "/I/stargold.jpg' width='20'>"
                        end for
                        for starcnt=1 to (3-starmax)
                           display "<img style='margin-bottom: 2px;' height='15' src='/", IRec.i_id clipped, "/I/starplain.jpg' width='20'>"
                        end for
                     end if  #UpdateAllow
                     display "</tr><tr>"
               end if
else
 if( SkillArrU[inbIdx,sidx].s_name != "NA" and SkillArrU[inbIdx,sidx].c_id = i and UpdateAllow )then
                  display "<tr>"
                  display "<td class='bottomborder2' width='300'>", SkillArrU[inbIdx,sidx].s_desc clipped, "</td>"
                  display "<td class='bottomborder2' width='50'>&nbsp;</td>"
                  display "<td class='' width='150'>"

                        display "<INPUT NAME='", sidx using '<<', "' VALUE=' '", ">"
                     display "</tr><tr>"
end if
            end if  #osc
         end for  #sidx 
            display "</table>"
	    display "</td></tr>"

     end for  #loop through skill cats
#     display "</tr>"
  end if  #skill_cat > 0

##MODif( GSkillDt is not NULL) then
##MOD   display "<span style='font-size: 10px'> (Last Updated: ", GSkillDt, ")</span>"
##MODend if
#display "</td></tr>"

if( UpdateAllow )then
   display "</FORM>"
end if

#display "</tr>"
display "</table>"

## display All Skills
#display "<tr><td colspan='100'>"
#display "<div style='text-align: center'>"
#display "<a href='/", IRec.i_id clipped, "/", BRec.b_id clipped, "/P/", URec.ceid clipped, "-skills.html'>All Skills</a><br />"

#display "</tbody>"
 
display "</table>"
#display "<table align='center' border='0' width='044px'>"
#display "<br />"

end function  #ShowSkillsCurrentBrandS

function showSkillCell( sIdx, inVal, colorStr )
define
   sIdx smallint,
   inVal smallint,
   colorStr char(7),
   ret char(256)

   if( inVal > 0 )then
      if( UpdateAllow )then
         let ret = "<td class='centerText'; style='background-color: ", colorStr, "'><strong>", "<INPUT NAME='", sIdx using '<<', "' VALUE=", inVal using '##', "></strong></td>"
      else
         let ret = "<td class='centerText'; style='background-color: ", colorStr, "'><strong>", inVal using "##", "</strong></td>"
      end if
   else
      if( UpdateAllow )then
         let ret = "<td class='whiteText'; style='background-color: ", colorStr, "'><INPUT NAME='", sIdx using '<<', "' VALUE=></td>"
      else
         let ret = "<td class='whiteText'; style='background-color: ", colorStr, "'>.</td>"
      end if
   end if
#display "inVal:", inVal
#display "colorStr:", colorStr
#display "RET: ", ret
   return ret

end function  #showSkillCell
}

