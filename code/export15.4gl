# export15.4gl - export all coverage

## May   06, 2015 John M. Shoemaker, created
## February  17, 2016 John M. Shoemaker, filter out reseller X


globals "globals.4gl"

main
define
   AllRec  record 
      ceid like coverage_au.ceid,
      part_name like coverage_au.part_name,
      uname like coverage_au.part_name,
      hq like coverage_au.hq,
      vad like coverage_au.vad,
      ssr_au like coverage_au.ssr,
      ssr_su like coverage_au.ssr,
      ssr_is like coverage_au.ssr,
      ctp_au1 like coverage_au.ctp1,
      ctp_au2 like coverage_au.ctp2,
      ctp_au3 like coverage_au.ctp3,
      ctp_au4 like coverage_au.ctp4,
      ctp_au5 like coverage_au.ctp5,
      ctp_su1 like coverage_au.ctp1,
      ctp_su2 like coverage_au.ctp2,
      ctp_su3 like coverage_au.ctp3,
      ctp_su4 like coverage_au.ctp4,
      ctp_su5 like coverage_au.ctp5,
      ctp_is1 like coverage_au.ctp1,
      ctp_is2 like coverage_au.ctp2,
      ctp_is3 like coverage_au.ctp3,
      ctp_is4 like coverage_au.ctp4,
      ctp_is5 like coverage_au.ctp5
   end record,
#   ARecArr array[500] of record like coverage_ws.*,
   tmpName like coverage_au.part_name,
   tmpssr like coverage_au.ssr,
   SQLStr char(2048),
   DELIMIT char(1)

call ReadCmdLn("home", 4)
call ProcCmdLn("home")

let DELIMIT=","
#call Init()
#call Header(0, IRec.i_id, BRec.b_id, 1)

select a.ceid from coverage_au a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union
select a.ceid from coverage_su a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union
select a.ceid from coverage_bu a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' 
into temp st1;

select 
      a.ceid, 
      b.part_name part_name, 
      c.part_name part2, 
      d.part_name part3, 
      '                                                                  ' uname,

      b.hq hq,
      c.hq hq2,
      d.hq hq3,

      b.vad vad,
      c.vad vad2,
      d.vad vad3,

      b.ssr ssr_au, 
      c.ssr ssr_su, 
      d.ssr ssr_is, 
      b.ctp1 ctp_au1, b.ctp2 ctp_au2, b.ctp3 ctp_au3, b.ctp4 ctp_au4, b.ctp5 ctp_au5,
      c.ctp1 ctp_su1, c.ctp2 ctp_su2, c.ctp3 ctp_su3, c.ctp4 ctp_su4, c.ctp5 ctp_su5,
      d.ctp1 ctp_is1, ' ' ctp_is2, ' ' ctp_is3, ' ' ctp_is4, ' ' ctp_is5 
  from 
      st1 a, 
      outer coverage_au b,
      outer coverage_su c,
      outer coverage_bu d 
where 
      a.ceid = b.ceid
  and a.ceid = c.ceid
  and a.ceid = d.ceid
into temp st2;

## update part_names from other systems
update st2 set part_name = part2 where part_name is null or part_name = ' ';
update st2 set part_name = part3 where part_name is null or part_name = ' ';

## update hq from other systems
update st2 set hq = hq2 where hq is null or hq = ' ';
update st2 set hq = hq3 where hq is null or hq = ' ';

## update vad from other systems
update st2 set vad = vad2 where vad is null or vad = ' ';
update st2 set vad = vad3 where vad is null or vad = ' ';

update st2 set uname = upper(part_name)

let SQLStr = "select ",
      "a.ceid, ",
      "a.part_name, ",
      "a.uname, ",
      "a.hq, ",
      "a.vad, ",
      "a.ssr_au, ",
      "a.ssr_su, ",
      "a.ssr_is, ",
      "ctp_au1, ctp_au2, ctp_au3, ctp_au4, ctp_au5,",
      "ctp_su1, ctp_su2, ctp_su3, ctp_su4, ctp_su5,",
      "ctp_is1, ctp_is2, ctp_is3, ctp_is4, ctp_is5 ",
      "from st2 a order by uname "

   prepare LMA1 from SQLStr
   declare LMA1Curs cursor for LMA1


    display 
           "CEID", DELIMIT,
           "PARTNER NAME", DELIMIT,
           "HQ", DELIMIT,
           "VAD", DELIMIT,
           "Analytics BPR", DELIMIT,
           "Systems BPR", DELIMIT,
           "Commerce BPR", DELIMIT,
           "IM TSS", DELIMIT,
           "ECM TSS", DELIMIT,
           "BA TSS", DELIMIT,
           "IoT TSS", DELIMIT,
           "Other Analytics TSS", DELIMIT,
           "WS TSS", DELIMIT,
           "RA TSS", DELIMIT,
           "TI TSS", DELIMIT,
           "Other Systems TSS1", DELIMIT,
           "Other Systems TSS2", DELIMIT,
           "Commerce TSS", DELIMIT

   foreach LMA1Curs into AllRec.*

    display 
           AllRec.ceid clipped, DELIMIT,
           '"', AllRec.part_name clipped, '"', DELIMIT,
           '"', AllRec.hq clipped, '"', DELIMIT,
           '"', AllRec.vad clipped, '"', DELIMIT,
           '"', AllRec.ssr_au clipped, '"', DELIMIT,
           '"', AllRec.ssr_su clipped, '"', DELIMIT,
           '"', AllRec.ssr_is clipped, '"', DELIMIT,
           '"', AllRec.ctp_au1 clipped, '"', DELIMIT,
           '"', AllRec.ctp_au2 clipped, '"', DELIMIT,
           '"', AllRec.ctp_au3 clipped, '"', DELIMIT,
           '"', AllRec.ctp_au4 clipped, '"', DELIMIT,
           '"', AllRec.ctp_au5 clipped, '"', DELIMIT,
           '"', AllRec.ctp_su1 clipped, '"', DELIMIT,
           '"', AllRec.ctp_su2 clipped, '"', DELIMIT,
           '"', AllRec.ctp_su3 clipped, '"', DELIMIT,
           '"', AllRec.ctp_su4 clipped, '"', DELIMIT,
           '"', AllRec.ctp_su5 clipped, '"', DELIMIT,
           '"', AllRec.ctp_is1 clipped, '"', DELIMIT


end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

