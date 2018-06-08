
database partners_na 

MAIN

define
   DataRec record like coverage_ws.*,
   SkillRec record like skills_ws.*,
   BURec record like bus.*,
   WestIMT, EastIMT, FederalIMT, CanadaIMT smallint,
   DisplayStr char(256)

declare ACurs cursor for
   select a.*
   from coverage_ws a
   where a.part_type != 'D' and a.reseller != 'N'
      and ceid in (select ceid from skills_ws where skill_07=3)
   order by a.part_name

foreach ACurs into DataRec.*
   let WestIMT = FALSE
   let WestIMT = FALSE
   let FederalIMT = FALSE
   let CanadaIMT = FALSE

   if (DataRec.bu_midwest = 'Y' 
    or DataRec.bu_pacifics = 'Y' 
    or DataRec.bu_greatwest = 'Y')then
      let WestIMT = TRUE
   end if

   if (DataRec.bu_southeast = 'Y' 
    or DataRec.bu_midatl = 'Y' 
    or DataRec.bu_ny = 'Y' 
    or DataRec.bu_northeast = 'Y' 
    or DataRec.bu_grtlakes = 'Y')then
      let EastIMT = TRUE
   end if

   if (DataRec.bu_canada = 'Y')then
      let CanadaIMT = TRUE
   end if

   if (DataRec.bu_federal = 'Y')then
      let FederalIMT = TRUE
   end if

   let DisplayStr = DataRec.part_name
   if( WestIMT )then
      let DisplayStr = DisplayStr clipped, " - West IMT"
   end if

   if( EastIMT )then
      let DisplayStr = DisplayStr clipped, " - East IMT"
   end if

   if( CanadaIMT )then
      let DisplayStr = DisplayStr clipped, " - Canada IMT"
   end if

   if( FederalIMT )then
      let DisplayStr = DisplayStr clipped, " - Federal IMT"
   end if

   display DisplayStr clipped

end foreach
 

END MAIN
