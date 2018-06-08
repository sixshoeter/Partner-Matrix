
database partners_na 

MAIN
   define
      ARec record like coverage_au.*,
      SQLStr char(9000)

   let SQLStr = "select a.* from coverage_au a, coverage_wu b where a.ceid = b.ceid "
#display SQLStr
begin work;
   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display ARec.ceid, " - ", ARec.part_name
  
      update coverage_wu set  
                eu_pacificnw = ARec.eu_pacificnw,
		eu_northca = ARec.eu_northca,
		eu_southwest = ARec.eu_southwest,
		eu_northern = ARec.eu_northern,
		eu_plains = ARec.eu_plains,
		eu_heartland = ARec.eu_heartland,
		eu_texas = ARec.eu_texas,
		eu_midamerica = ARec.eu_midamerica,
		eu_ohio = ARec.eu_ohio,
		eu_southeast = ARec.eu_southeast,
		eu_sunshine = ARec.eu_sunshine,
		eu_northeast = ARec.eu_northeast,
		eu_ny = ARec.eu_ny,
		eu_garden = ARec.eu_garden,
		eu_delaware = ARec.eu_delaware,
		eu_potomac = ARec.eu_potomac,
		eu_carolinas = ARec.eu_carolinas,
		eu_ca = ARec.eu_ca,
		eu_fed = ARec.eu_fed,

  		url = ARec.url,
		pwp = ARec.pwp

		where ceid = ARec.ceid 
   end foreach

commit work;

END MAIN

