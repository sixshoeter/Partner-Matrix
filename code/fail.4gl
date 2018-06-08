
globals "globals.4gl"

MAIN
define
   FRec record like fail.*,
   PName like coverage_ws.part_name,
   SSR like coverage_ws.ssr,
   CTP like coverage_ws.ctp,
   sqlStr char(512),
   covStr char(128),
   cnt, i smallint,
   DEL char(1)


let DEL="~"

{select a.ceid, a.part_name from coverage_ws a
union
select b.ceid, b.part_name from coverage_ws b
into temp allNames;
}

select a.ceid, a.ssr, a.ctp from coverage_ws a
union
select b.ceid, b.ssr, b.ctp from coverage_im b
into temp allCoverage;

select unique a.ceid, a.part_name from tbptv a
into temp allNames;

let sqlStr = "select a.*, b.part_name, c.ssr, c.ctp from fail a, outer allNames b, outer allCoverage c where a.ceid=b.ceid and a.ceid = c.ceid"
prepare FID from sqlStr
declare FCurs cursor for FID

foreach FCurs into FRec.*, PName, SSR, CTP
   let cnt = GetBPTVPartsSplit(FRec.ceid) 
   let BRec.b_id = FRec.brand

   display FRec.ceid clipped, DEL, PName clipped, DEL, "Failed: ", FRec.detail clipped, DEL
      if( SSR is not NULL) then
         let covStr = SSR clipped, "/", CTP clipped
      else
         let covStr = "(not covered)"
      end if
      display covStr clipped, DEL,
              "AUTHORIZED", DEL,
              "CERTIFIED PEOPLE", DEL,
              "2012 Revenue",DEL,
              "2012 Value Rev",DEL,
              "2013 Revenue",DEL,
              "2013 Value Rev",DEL
   for i = 1 to cnt 
   display DEL,
              BPTVArr[i].rag, DEL,
              BPTVArr[i].people_01, DEL,
              BPTVArr[i].nlrev_01,DEL,
              BPTVArr[i].vrrev_01,DEL,
              BPTVArr[i].nlrev_02,DEL,
              BPTVArr[i].vrrev_02,DEL
   end for
   display ""
end foreach

END MAIN
