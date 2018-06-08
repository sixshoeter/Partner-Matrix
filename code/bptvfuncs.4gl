globals "globals.4gl"

function GetBPTVParts( in_ceid )
define
   in_ceid like nbptv_parts.ceid,
   i,k smallint,
   SQLStr char(256)


   let SQLStr = "select a.rag, b.s_name, a.bptv_01, people_01, nlrev_01, 0 as nlrev_02, vrrev_01 from nbptv_parts a, svp b where a.ceid='", in_ceid clipped, "' and a.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' order by b.s_id"
#display SQLStr clipped
   prepare BPID from SQLStr
   declare BPCurs cursor for BPID

   for i = 1 to 10
      initialize BPTVArr[i].* to NULL  
   end for

   let i = 0
   foreach BPCurs into BPTVArr[i+1].*
      let i = i + 1
      for k=1 to G_SVPcnt
         if( BPTVArr[i].rag = SVPArr[k].bptv_name )then
            let SVPArr[k].flag = i
         end if
      end for
   end foreach

    return i
end function #GetBPTVParts
#############################################

function GetBPTVPartsSplit( in_ceid )
define
   in_ceid like nbptv_parts.ceid,
   i,k smallint,
   SQLStr char(512),
   mindt, maxdt date,
   tBPTVRec record
       rag_1 like nbptv_parts.rag,
       rag_2 like nbptv_parts.rag,
       rag_alt like svp.s_name,
       bptv_01 like nbptv_parts.bptv_01,
       people_01 like nbptv_parts.people_01,
       nlrev_01 like nbptv_parts.nlrev_01,
       nlrev_02 like nbptv_parts.nlrev_01,
       vrrev_01 like nbptv_parts.vrrev_01,
       vrrev_02 like nbptv_parts.vrrev_01
   end record

   let SQLStr = "select min(revdt) from tbptv where ceid = '", in_ceid clipped, "'"
   prepare GPPS1 from SQLStr
   execute GPPS1 into mindt

   let SQLStr = "select max(revdt) from tbptv where ceid = '", in_ceid clipped, "'"
   prepare GPPS2 from SQLStr
   execute GPPS2 into maxdt

   let SQLStr = "select unique a.rag as rag_1, c.rag as rag_2, b.s_name, c.bptv_01, c.people_01, a.nlrev_01, c.nlrev_01 as nlrev_02, a.vrrev_01, c.vrrev_01 as vrrev_02 from svp b, outer tbptv a, outer tbptv c where a.ceid='", in_ceid clipped, "' and c.ceid='", in_ceid clipped, "' and a.rag = b.bptv_name and c.rag = b.bptv_name and b.s_brand='", BRec.b_id clipped, "' and a.revdt='", mindt, "' and c.revdt='", maxdt, "' order by b.s_name "  ##b.s_id"
#display SQLStr clipped
   prepare BPID2 from SQLStr
   declare BPSCurs cursor for BPID2

   for i = 1 to 10
      initialize BPTVArr[i].* to NULL  
   end for

   let i = 0
   foreach BPSCurs into tBPTVRec.*
#display G_SVPcnt
#display BPTVArr[i+1].*
      if( tBPTVRec.rag_1 is not NULL or tBPTVRec.rag_2 is not NULL )then
         let i = i + 1
         if( tBPTVRec.rag_1 is NOT NULL )then
            let BPTVArr[i].rag = tBPTVRec.rag_1
         else
            let BPTVArr[i].rag = tBPTVRec.rag_2
         end if
         let BPTVArr[i].rag_alt = tBPTVRec.rag_alt
         let BPTVArr[i].bptv_01 = tBPTVRec.bptv_01
         let BPTVArr[i].people_01 = tBPTVRec.people_01
         let BPTVArr[i].nlrev_01 = tBPTVRec.nlrev_01
         let BPTVArr[i].nlrev_02 = tBPTVRec.nlrev_02
         let BPTVArr[i].vrrev_01 = tBPTVRec.vrrev_01
         let BPTVArr[i].vrrev_02 = tBPTVRec.vrrev_02

         for k=1 to G_SVPcnt
            if( BPTVArr[i].rag = SVPArr[k].bptv_name )then
#display ">", BPTVArr[i].rag, SVPArr[k].bptv_name, "<br />"
               let SVPArr[k].flag = 1
else
#display "*", "B:", BPTVArr[i].rag, "S:", SVPArr[k].bptv_name, "<br />"

            end if
         end for
      end if
   end foreach

    return i
end function #GetBPTVPartsSplit
#############################################
function LoadBPTVRec ( in_ceid )
define
   in_ceid like nbptv.ceid,
   SQLStr char(128)
   
   let SQLStr = "select unique a.* from nbptv a where a.ceid='", in_ceid clipped, "'"

   prepare BPRID from SQLStr
   execute BPRID into BPTVRec.*

end function
#############################################

function SVPinBPTV( in_svp )
define
   in_svp like svp.bptv_name,
   i smallint,
   retFlag smallint

   let retFlag = FALSE

   for i = 1 to 10
#display "i: ", i, BPTVArr[i].rag clipped, ":", in_svp clipped
      if( BPTVArr[i].rag = in_svp )then
         let retFlag = TRUE
         exit for
      end if
   end for

   return retFlag

end function

