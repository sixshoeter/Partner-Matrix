
globals "globals.4gl"

MAIN
   define
      ARec record like coverage_su.*,
      TRec record like coverage_au.*,
      SQLStr char(9000)

   let SQLStr = "select a.*, b.* from coverage_su a, coverage_au b where a.ceid=b.ceid and b.desc is null and b.ssr is not null and b.ssr != ' ' and date(b.updtime)=today and a.desc is not null order by a.part_name"
#   let SQLStr = "select a.*, b.* from coverage_au a, _sunew b where a.ceid = b.ceid and a.ceid in (select ceid from _sunew) ",
#                " and a.ceid not in (select ceid from coverage_su)"
#display SQLStr clipped

begin work;

   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*, TRec.*
      display ARec.part_name
  
      update coverage_au set
         desc = ARec.desc,
         url = ARec.url,
         pwp = ARec.pwp,
         part_type = ARec.part_type,
         note = ARec.note,
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

         ind_eu = ARec.ind_eu,
         ind_tel = ARec.ind_tel,
         ind_me = ARec.ind_me,
         ind_ret = ARec.ind_ret,
         ind_wd = ARec.ind_wd,
         ind_trans = ARec.ind_trans,
         ind_bank = ARec.ind_bank,
         ind_ins = ARec.ind_ins,
         ind_mfg = ARec.ind_mfg,
         ind_hl = ARec.ind_hl,
         ind_gov = ARec.ind_gov,
         ind_cross = ARec.ind_cross,
         ind_auto = ARec.ind_auto,
         ind_csi = ARec.ind_csi,
         ind_chem = ARec.ind_chem,
         ind_consume = ARec.ind_consume,
         ind_defense = ARec.ind_defense,
         ind_elect = ARec.ind_elect,
         ind_finan = ARec.ind_finan,
         ind_indprod = ARec.ind_indprod,
         ind_lifesci = ARec.ind_lifesci,
         ind_fed = ARec.ind_fed,
         ind_can = ARec.ind_can,
         ind_education = ARec.ind_education,
         pod = ARec.pod,

         p_name = ARec.p_name,
         p_title = ARec.p_title,
         p_phone = ARec.p_phone,
         p_email = ARec.p_email,
         focus1 = ARec.focus1,
         focus2 = ARec.focus2,
         focus3 = ARec.focus3,

         partners_well = ARec.partners_well,
         hunter = ARec.hunter,
         lap = ARec.lap,
         dfm = ARec.dfm,
         commercial = ARec.commercial,
         enterprise = ARec.enterprise,
         industry = ARec.industry,
         updtime = current
         where ceid=TRec.ceid

   end foreach

#commit work;

END MAIN

