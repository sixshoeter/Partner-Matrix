
globals "globals.4gl"

MAIN
   define
      ARec record like coverage_ra.*,
      TRec record like coverage_su.*,
      SQLStr char(9000)

   let SQLStr = "select a.* from coverage_ra a where a.ceid in ('1tw2imy1', '1yk89z2e', '7qwck', ",
                "'7j2yu', '1ibc5lmw', '6dmds', '7he60', '2rtayy23', '2nsztkko', '18z7gego', ",
                "'85wk4', '7p83j', 'zu1pd5b', '1bx90b0w', '6nbrv', '1a9f683q', '6iys4', ",
                "'82nyt', '7pzb3', '18z7gk87') and a.ceid not in (select ceid from coverage_au)"
#   let SQLStr = "select a.*, b.* from coverage_au a, _sunew b where a.ceid = b.ceid and a.ceid in (select ceid from _sunew) ",
#                " and a.ceid not in (select ceid from coverage_su)"
#display SQLStr clipped

   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*
      display ARec.part_name
      initialize TRec.* to NULL
  
      let TRec.ceid = ARec.ceid
      let TRec.vad = ARec.vad
      let TRec.hq = ARec.hq
      let TRec.part_type = ARec.part_type
      let TRec.reseller = ARec.reseller
      let TRec.part_name = ARec.part_name
      let TRec.ssr = ARec.ssr
      let TRec.ctp4 = ARec.ctp
      let TRec.eu_pacificnw = ARec.eu_pacificnw
      let TRec.eu_northca = ARec.eu_northca
      let TRec.eu_southwest = ARec.eu_southwest
      let TRec.eu_northern = ARec.eu_rockies 
      let TRec.eu_plains = ARec.eu_plains
      let TRec.eu_heartland = ARec.eu_heartland
      let TRec.eu_texas = ARec.eu_texas

      let TRec.eu_midamerica = ARec.eu_midamerica
      let TRec.eu_ohio = ARec.eu_ohio
      let TRec.eu_southeast = ARec.eu_southeast
      let TRec.eu_sunshine = ARec.eu_sunshine
      let TRec.eu_northeast = ARec.eu_northeast
      let TRec.eu_garden = ARec.eu_garden
      let TRec.eu_delaware = ARec.eu_delaware
      let TRec.eu_potomac = ARec.eu_potomac
      let TRec.eu_carolinas = ARec.eu_carolinas
      let TRec.eu_ca = ARec.eu_ca_industry
      let TRec.eu_fed = ARec.eu_fed_dod


      let TRec.ind_eu = ARec.ind_eu
      let TRec.ind_tel = ARec.ind_tel
      let TRec.ind_me = ARec.ind_me
      let TRec.ind_ret = ARec.ind_ret
      let TRec.ind_wd = ARec.ind_wd
      let TRec.ind_trans = ARec.ind_trans
      let TRec.ind_bank = ARec.ind_bank
      let TRec.ind_ins = ARec.ind_ins
      let TRec.ind_mfg = ARec.ind_mfg
      let TRec.ind_hl = ARec.ind_hl
      let TRec.ind_gov = ARec.ind_gov
      let TRec.url = ARec.url
      let TRec.pwp = ARec.pwp
      let TRec.desc = ARec.desc
      let TRec.p_name = ARec.p_name
      let TRec.p_title = ARec.p_title
      let TRec.p_phone = ARec.p_phone
      let TRec.p_email = ARec.p_email
      let TRec.focus1 = ARec.focus1
      let TRec.focus2 = ARec.focus2
      let TRec.focus3 = ARec.focus3
      let TRec.updtime = ARec.updtime


      insert into coverage_au values (TRec.*)
   end foreach

END MAIN

