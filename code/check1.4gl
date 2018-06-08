database partners_na

main
define
   SQLStr char(512),
   tTabname like systables.tabname,
   IRec record like sysindexes.*,
   st_str char(10)
  

   display "*** Checking the Indexes for Coverage ***"

   let SQLStr="select a.tabname, b.* from systables a, sysindexes b where a.tabid = b.tabid and ",
              "a.tabname in (select cov_tab from control where production=1) order by 1"

   prepare cID from SQLStr
   declare cCurs cursor for cID

   foreach cCurs into tTabname, IRec.*
      if( IRec.idxtype = "D" )then
         let st_str = "<===="
      else
         let st_str = " "
      end if
      display tTabname, " ", IRec.idxname, " - ", IRec.idxtype, " "
   end foreach

   display "*** Checking the Indexes for Skills ***"

   let SQLStr="select a.tabname, b.* from systables a, sysindexes b where a.tabid = b.tabid and ",
              "a.tabname in (select skill_tab from control where production=1) order by 1"

   prepare mID from SQLStr
   declare mCurs cursor for mID

   foreach mCurs into tTabname, IRec.*
      if( IRec.idxtype = "D" )then
         let st_str = "<===="
      else
         let st_str = " "
      end if
      display tTabname, " ", IRec.idxname, " - ", IRec.idxtype, " ", st_str
   end foreach

end main
