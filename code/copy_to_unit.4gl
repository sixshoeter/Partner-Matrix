
globals "globals.4gl"

MAIN
   define
      ARec record like coverage_is.*,
      NRec record like _sunew.*,
      TRec record like coverage_bu.*,
      SQLStr char(9000)

   let SQLStr = "select a.* from coverage_is a  where ",
                " a.ceid not in (select ceid from coverage_bu)"
#display SQLStr

begin work
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
      let TRec.ctp1 = ARec.ctp
      let TRec.eu_pacificnw = ARec.eu_pacificnw
      let TRec.eu_northca = ARec.eu_northca
      let TRec.eu_southwest = ARec.eu_southwest

      if( ARec.eu_chicago = 'H' or ARec.eu_minn = 'H' )then
         let TRec.eu_northern = 'H'
      else
         if(  ARec.eu_chicago = 'Y' or ARec.eu_minn = 'Y' )then
            let TRec.eu_northern = 'Y'
         end if
      end if

      let TRec.eu_plains = ARec.eu_plains
      let TRec.eu_heartland = ARec.eu_heartland

      if( ARec.eu_texas = 'H' or ARec.eu_gulf = 'H' )then
         let TRec.eu_texas = 'H'
      else
         if(  ARec.eu_texas = 'Y' or ARec.eu_gulf = 'Y' )then
            let TRec.eu_texas = 'Y'
         end if
      end if

      let TRec.eu_midamerica = ARec.eu_midamerica
      let TRec.eu_ohio = ARec.eu_ohio
      let TRec.eu_southeast = ARec.eu_southeast
      let TRec.eu_sunshine = ARec.eu_sunshine
      let TRec.eu_northeast = ARec.eu_northeast
      let TRec.eu_garden = ARec.eu_garden
      let TRec.eu_delaware = ARec.eu_delaware
      let TRec.eu_potomac = ARec.eu_potomac
      let TRec.eu_carolinas = ARec.eu_carolinas

      if( ARec.eu_ca_industry = 'H' or ARec.eu_ca_enterprise = 'H' or ARec.eu_ca_midmarket = 'H' )then
         let TRec.eu_ca = 'H'
      else
         if(  ARec.eu_ca_industry = 'Y' or ARec.eu_ca_enterprise = 'Y' or ARec.eu_ca_midmarket = 'Y' )then
            let TRec.eu_ca = 'Y'
         end if
      end if

      if( ARec.eu_fed_civ = 'H' or ARec.eu_fed_dod = 'H' )then
         let TRec.eu_fed = 'H'
      else
         if(  ARec.eu_fed_civ = 'Y' or ARec.eu_fed_dod = 'Y' )then
            let TRec.eu_fed = 'Y'
         end if
      end if


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


      insert into coverage_bu values (TRec.*)
   end foreach
#commit work
END MAIN

