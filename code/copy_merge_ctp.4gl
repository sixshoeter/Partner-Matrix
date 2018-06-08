globals "globals.4gl"
define
   NCRec record like coverage_nc.*


main
define
   SRec record like coverage_su.*,
   f1used, f2used, f3used, f4used, f5used smallint,
   SQLStr, SQLStr2 char(1024)

   let SQLStr="select a.* from coverage_su a order by part_name "

begin work;
   prepare SID from SQLStr
   declare SCurs cursor for SID

   foreach SCurs into SRec.*

      let f1used=FALSE
      let f2used=FALSE
      let f3used=FALSE
      let f4used=FALSE
      let f5used=FALSE
   
      let SQLStr2="select a.* from coverage_nc a where ceid='", SRec.ceid clipped, "'"
      prepare S2ID from SQLStr2
      execute S2ID into NCRec.*

      display "NC: "
      display NCRec.ctp1
      display NCRec.ctp2
      display NCRec.ctp3
      display NCRec.ctp4
      display NCRec.ctp5

      display "SU: "
      display SRec.ctp1
      display SRec.ctp2
      display SRec.ctp3
      display SRec.ctp4
      display SRec.ctp5
     
      if( NCRec.ctp1 is null or NCRec.ctp1=" " )then
         if( SRec.ctp1 is not null and SRec.ctp1 !=" " and notExist(SRec.ctp1) )then
            let NCRec.ctp1=SRec.ctp1 
            let f1used = TRUE
         else
            if( SRec.ctp2 is not null and SRec.ctp2 !=" " and notExist(SRec.ctp2))then
               let NCRec.ctp1=SRec.ctp2 
               let f2used = TRUE
            else
               if( SRec.ctp3 is not null and SRec.ctp3 !=" " and notExist(SRec.ctp3))then
                  let NCRec.ctp1=SRec.ctp3 
                  let f3used = TRUE
               else
                  if( SRec.ctp4 is not null and SRec.ctp4 !=" " and notExist(SRec.ctp4))then
                     let NCRec.ctp1=SRec.ctp4 
                     let f4used = TRUE
                  else
                     if( SRec.ctp5 is not null and SRec.ctp5 !=" " and notExist(SRec.ctp5))then
                        let NCRec.ctp1=SRec.ctp5 
                        let f5used = TRUE
                     end if
                  end if
               end if
            end if
         end if
      end if

      if( NCRec.ctp2 is null or NCRec.ctp2=" " )then
         if( SRec.ctp1 is not null and SRec.ctp1 !=" " and not f1used and notExist(SRec.ctp1))then
            let NCRec.ctp2=SRec.ctp1 
            let f1used = TRUE
         else
            if( SRec.ctp2 is not null and SRec.ctp2 !=" " and not f2used and notExist(SRec.ctp2))then
               let NCRec.ctp2=SRec.ctp2 
               let f2used = TRUE
            else
               if( SRec.ctp3 is not null and SRec.ctp3 !=" " and not f3used and notExist(SRec.ctp3))then
                  let NCRec.ctp2=SRec.ctp3 
                  let f3used = TRUE
               else
                  if( SRec.ctp4 is not null and SRec.ctp4 !=" " and not f4used and notExist(SRec.ctp4))then
                     let NCRec.ctp2=SRec.ctp4 
                     let f4used = TRUE
                  else
                     if( SRec.ctp5 is not null and SRec.ctp5 !=" " and not f5used and notExist(SRec.ctp5))then
                        let NCRec.ctp2=SRec.ctp5 
                        let f5used = TRUE
                     end if
                  end if
               end if
            end if
         end if
      end if


      if( NCRec.ctp3 is null or NCRec.ctp3=" " )then
         if( SRec.ctp1 is not null and SRec.ctp1 !=" " and not f1used and notExist(SRec.ctp1))then
            let NCRec.ctp3=SRec.ctp1 
            let f1used = TRUE
         else
            if( SRec.ctp2 is not null and SRec.ctp2 !=" " and not f2used and notExist(SRec.ctp2))then
               let NCRec.ctp3=SRec.ctp2 
               let f2used = TRUE
            else
               if( SRec.ctp3 is not null and SRec.ctp3 !=" " and not f3used and notExist(SRec.ctp3))then
                  let NCRec.ctp3=SRec.ctp3 
                  let f3used = TRUE
               else
                  if( SRec.ctp4 is not null and SRec.ctp4 !=" " and not f4used and notExist(SRec.ctp4))then
                     let NCRec.ctp3=SRec.ctp4 
                     let f4used = TRUE
                  else
                     if( SRec.ctp5 is not null and SRec.ctp5 !=" " and not f5used and notExist(SRec.ctp5))then
                        let NCRec.ctp3=SRec.ctp5 
                        let f5used = TRUE
                     end if
                  end if
               end if
            end if
         end if
      end if

      if( NCRec.ctp4 is null or NCRec.ctp4=" " )then
         if( SRec.ctp1 is not null and SRec.ctp1 !=" " and not f1used and notExist(SRec.ctp1))then
            let NCRec.ctp4=SRec.ctp1 
            let f1used = TRUE
         else
            if( SRec.ctp2 is not null and SRec.ctp2 !=" " and not f2used and notExist(SRec.ctp2))then
               let NCRec.ctp4=SRec.ctp2 
               let f2used = TRUE
            else
               if( SRec.ctp3 is not null and SRec.ctp3 !=" " and not f3used and notExist(SRec.ctp3))then
                  let NCRec.ctp4=SRec.ctp3 
                  let f3used = TRUE
               else
                  if( SRec.ctp4 is not null and SRec.ctp4 !=" " and not f4used and notExist(SRec.ctp4))then
                     let NCRec.ctp4=SRec.ctp4 
                     let f4used = TRUE
                  else
                     if( SRec.ctp5 is not null and SRec.ctp5 !=" " and not f5used and notExist(SRec.ctp5))then
                        let NCRec.ctp4=SRec.ctp5 
                        let f5used = TRUE
                     end if
                  end if
               end if
            end if
         end if
      end if

      if( NCRec.ctp5 is null or NCRec.ctp5=" " )then
         if( SRec.ctp1 is not null and SRec.ctp1 !=" " and not f1used and notExist(SRec.ctp1))then
            let NCRec.ctp5=SRec.ctp1 
            let f1used = TRUE
         else
            if( SRec.ctp2 is not null and SRec.ctp2 !=" " and not f2used and notExist(SRec.ctp2))then
               let NCRec.ctp5=SRec.ctp2 
               let f2used = TRUE
            else
               if( SRec.ctp3 is not null and SRec.ctp3 !=" " and not f3used and notExist(SRec.ctp3))then
                  let NCRec.ctp5=SRec.ctp3 
                  let f3used = TRUE
               else
                  if( SRec.ctp4 is not null and SRec.ctp4 !=" " and not f4used and notExist(SRec.ctp4))then
                     let NCRec.ctp5=SRec.ctp4 
                     let f4used = TRUE
                  else
                     if( SRec.ctp5 is not null and SRec.ctp5 !=" " and not f5used and notExist(SRec.ctp5))then
                        let NCRec.ctp5=SRec.ctp5 
                        let f5used = TRUE
                     end if
                  end if
               end if
            end if
         end if
      end if

      display "NEW NC (", NCRec.part_name clipped,"): "
      display NCRec.ctp1
      display NCRec.ctp2
      display NCRec.ctp3
      display NCRec.ctp4
      display NCRec.ctp5

      update coverage_nc set ctp1=NCRec.ctp1,
                             ctp2=NCRec.ctp2,
                             ctp3=NCRec.ctp3,
                             ctp4=NCRec.ctp4,
			     ctp5=NCRec.ctp5,
                             updtime=current
                          where ceid=NCRec.ceid

   end foreach

#commit work
 
end main

function notExist(inctp)
define
   inctp like coverage_nc.ctp1,
   rv smallint

   let rv=TRUE
   if( inctp = NCRec.ctp1 or
       inctp = NCRec.ctp2 or
       inctp = NCRec.ctp3 or
       inctp = NCRec.ctp4 or
       inctp = NCRec.ctp5 )then

      let rv=FALSE
    end if

   return rv

end function  #notExist
