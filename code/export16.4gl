# export16.4gl - export TSSs with BPTV changes

## June  08, 2015 John M. Shoemaker, created
## February  17, 2016 John M. Shoemaker, filter out reseller X
## HARD CODED RETURN PREV QUARTER - NEEDS EITHER FIXED OR CHANGED


globals "globals.4gl"

main
define
   AllRec  record 
      ceid like coverage_au.ceid,
      part_name like coverage_au.part_name,
      ctp1 like coverage_au.ctp1,
      ctp2 like coverage_au.ctp2,
      ctp3 like coverage_au.ctp3,
      ctp4 like coverage_au.ctp4,
      ctp5 like coverage_au.ctp5,
      rag  like tbptv.rag,
      bptv_01 like tbptv.bptv_01,
      bptv_02 like tbptv.bptv_01
   end record,
   tmpName like coverage_au.part_name,
   tmpssr like coverage_au.ssr,
   SQLStr char(2048),
   searchYr, searchQtr smallint,
   max_dt date,
   max_dtH date,
   DELIMIT char(1),
   qtrDate char(6),
   qtrDateH char(6)

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id, 1)

# determine current quarter based on tbptv dates
let SQLStr="select max(revdt) from tbptv"
prepare GMRDT from SQLStr
execute GMRDT into max_dt
let qtrDate = prevQuarter(max_dt)
let searchYr=qtrDate[1,4]
let searchQtr=qtrDate[6,6]
#display "max_dt: ", max_dt
#display "qtrDate: ", qtrDate
#display "searchYr: ", searchYr
#display "searchQtr:", searchQtr

# determine max revdt based on prev quarter 
let SQLStr="select max(revdt) from tbptv_history where q_year=", searchYr, " and q_qtr= ", searchQtr
prepare GMRDTH from SQLStr
execute GMRDTH into max_dtH
#display "max_dtH: ", max_dtH

let SQLStr ="select a.ceid, a.part_name, a.rag, a.bptv_01 ",
            "from tbptv_history a ",
            "where a.q_year=", searchYr, " ",
              "and a.q_qtr=", searchQtr,  " ",
              "and a.iot = 'NA' ",
              "and a.revdt = '", max_dtH, "' ",    #(select max(revdt) from tbptv_history)
            "into temp hist1 "

#display SQLStr clipped
prepare BHT1 from SQLStr
execute BHT1 


let SQLStr = "select a.ceid, a.part_name, a.rag, a.bptv_01 ",
             "from tbptv a ",
             "where ",
                   "a.iot = 'NA' ",
               "and a.revdt = '", max_dt, "' ",   #(select max(revdt) from tbptv)
             "into temp hist2 "

#display SQLStr clipped
prepare BHT2 from SQLStr
execute BHT2 


let SQLStr = "select a.ceid, a.part_name, a.rag, a.bptv_01 bptv_01, b.bptv_01 bptv_02 ",
             "from hist1 a, hist2 b ",
             "where a.ceid = b.ceid ",
             "and a.rag = b.rag ",
             "into temp hist3 "

#display SQLStr clipped
prepare BHT3 from SQLStr
execute BHT3 

if( UnitModeYN() )then
#   let SQLStr = "select a.ceid, a.part_name, a.ctp1, a.ctp2, a.ctp3, a.ctp4, a.ctp5, b.rag, b.bptv_01, b.bptv_02 from ", cov_tab clipped, " a,hist3 b where a.ceid = b.ceid and a.reseller != 'N' and a.reseller != 'X' "
   let SQLStr = "select a.ceid, a.part_name, a.ctp1, a.ctp2, a.ctp3, a.ctp4, a.ctp5, b.rag, b.bptv_01, b.bptv_02 from ", cov_tab clipped, " a,hist3 b, svp c where a.ceid = b.ceid and b.rag = c.bptv_name and a.reseller != 'N' and a.reseller != 'X' and c.s_brand = '", BRec.b_id clipped, "'"
else
   let SQLStr = "select a.ceid, a.part_name, a.ctp, ' ' ctp2, ' ' ctp3, ' ' ctp4, ' ' ctp5, b.rag, b.bptv_01, b.bptv_02 from ", cov_tab clipped, " a,hist3 b where a.ceid = b.ceid and a.reseller != 'N' and a.reseller != 'X' "
end if

#-------------


#display SQLStr clipped
   prepare LMA1 from SQLStr
   declare LMA1Curs cursor for LMA1

    display 
           "CEID", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "TSS", DELIMIT,
           "TSS", DELIMIT,
           "TSS", DELIMIT,
           "TSS", DELIMIT,
           "TSS", DELIMIT,
           "PRODUCT GROUP", DELIMIT,
           "BPTV-", max_dtH, DELIMIT,
           "BPTV-", max_dt, DELIMIT

   foreach LMA1Curs into AllRec.*

    display 
           AllRec.ceid clipped, DELIMIT,
           '"', AllRec.part_name clipped, '"', DELIMIT,
           '"', AllRec.ctp1 clipped, '"', DELIMIT,
           '"', AllRec.ctp2 clipped, '"', DELIMIT,
           '"', AllRec.ctp3 clipped, '"', DELIMIT,
           '"', AllRec.ctp4 clipped, '"', DELIMIT,
           '"', AllRec.ctp5 clipped, '"', DELIMIT,
           '"', AllRec.rag clipped, '"', DELIMIT,
           '"', AllRec.bptv_01, '"', DELIMIT,
           '"', AllRec.bptv_02, '"', DELIMIT


end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

function prevQuarter( in_date )
define
   in_date date,
   ret_qtr char(6),
   yr, mo, qtr smallint


let mo = month(in_date)
case 
   when mo=1 or mo=2 or mo=3
      let qtr = 4
      let yr = year(in_date)-1
   when mo=4 or mo=5 or mo=6
      let qtr = 1
      let yr = year(in_date)
   when mo=7 or mo=8 or mo=9
      let qtr = 2
      let yr = year(in_date)
   when mo=10 or mo=11 or mo=12
      let qtr = 3
      let yr = year(in_date)
end case
let ret_qtr = yr*100 + qtr
#let ret_qtr = (year(in_date)*100) + 1 + (month(in_date) - 1) / 3

#return ret_qtr

return "201601"

end function  #prevQuarter

