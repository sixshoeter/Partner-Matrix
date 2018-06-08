
globals "globals.4gl"

MAIN
   define
      ARec record like _inst.*,
      i,j,l smallint,
      locStr char(2),
      SQLStr char(9000)

##first make sure all ceids are downshifted
let SQLStr = "select a.* from _inst a order by a.part_name ;"
#display SQLStr
begin work;

update coverage_st set ssr=" " where ssr is not null and ssr != " ";
#update coverage_st set ctp5=" " where ctp5 is not null and ctp5 != " ";
#update cross set pta=" " where pta is not null and pta != " ";
#update cross set pta_hw=" " where pta_hw is not null and pta_hw != " ";
#update cross set spr=" " where spr is not null and spr != " ";
#update cross set spr_hw=" " where spr_hw is not null and spr_hw != " ";
#update cross set pcr=" " where pcr is not null and pcr != " ";


   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*

      display ARec.part_name
  

## update coverage
      if( ARec.spr is not null and ARec.spr!= " " )then
##    find state
      let l=length(ARec.loc)
      if( l>1 )then
         let i=1
         while i<l
            if( ARec.loc[i]=", " )then
               let locStr=ARec.loc[i+2,i+3]
               exit while
            end if
            let i=i+1
         end while
      end if
         update coverage_st set 
            ssr  = ARec.spr,
            part_type  = ARec.cio_sw,
            hq = locStr,
            updtime=current
         where ceid = ARec.ceid 
      end if

{
      if( ARec.pta[1,4] != "Open" )then
         update coverage_st set 
            ctp5  = ARec.pta,
            updtime=current
         where ceid = ARec.ceid 
      end if
}


## update cross table
{
      if( ARec.sds_stor_spr[1,4] != "Open" )then
         update cross set 
	    pta  = ARec.pta,
            pta_hw  = ARec.pta_hw,
            spr = ARec.sds_stor_spr,
            spr_hw  = ARec.stor_spr,
            pcr  = ARec.pcr,
            updtime=current
         where ceid = ARec.ceid 
      end if
}

   end foreach

#commit work;
END MAIN

