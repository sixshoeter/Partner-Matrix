globals "globals.4gl"

MAIN
define
   SQLStr, SQLStr1, SQLStr2 char(128),
   NRec record like coverage_es.*,
   IRec record like coverage_lo.*,
   chgFlg smallint


let SQLStr = "select a.* from coverage_es a order by a.part_name"

prepare U1 from SQLStr
declare U1Curs cursor for U1

begin work

foreach U1Curs into URec.*
   let chgFlg = FALSE

   let SQLStr1 = "select a.* from coverage_au a where a.ceid='", URec.ceid clipped, "'"
   initialize NRec.* to NULL
   prepare U2ID from SQLStr1
   execute U2ID into NRec.*

   let SQLStr2 = "select a.* from coverage_lo a where a.ceid='", URec.ceid clipped, "'"
   initialize IRec.* to NULL
   prepare U3ID from SQLStr2
   execute U3ID into IRec.*

## look for VAD
   if( URec.vad is NULL or URec.vad = " ")then
      if( NRec.vad is NULL )then
         if( IRec.vad is NULL )then
         else
            let URec.vad = IRec.vad
            let chgFlg = TRUE
         end if
      else
         let URec.vad = NRec.vad
         let chgFlg = TRUE
      end if
   end if

## look for URL
   if( URec.url is NULL or URec.url = " ")then
      if( NRec.url is NULL )then
         if( IRec.url is NULL )then
         else
            let URec.url = IRec.url
            let chgFlg = TRUE
         end if
      else
         let URec.url = NRec.url
         let chgFlg = TRUE
      end if
   end if

## look for pwp
   if( URec.pwp is NULL or URec.pwp = " ")then
      if( NRec.pwp is NULL )then
         if( IRec.pwp is NULL )then
         else
            let URec.pwp = IRec.pwp
         let chgFlg = TRUE
         end if
      else
         let URec.pwp = NRec.pwp
         let chgFlg = TRUE
      end if
   end if

## look for desc
   if( URec.desc is NULL or URec.desc = " ")then
      if( NRec.desc is NULL )then
         if( IRec.desc is NULL )then
         else
            let URec.desc = IRec.desc
         let chgFlg = TRUE
         end if
	 else
	 let URec.desc = NRec.desc
         let chgFlg = TRUE
      end if
   end if

## look for contact
   if( URec.p_name is NULL or URec.p_name = " ")then
      if( NRec.p_name is NULL )then
         if( IRec.p_name is NULL )then
         else
            let URec.p_name = IRec.p_name
            let URec.p_title = IRec.p_title
            let URec.p_email = IRec.p_email
            let URec.p_phone = IRec.p_phone
         let chgFlg = TRUE
         end if
      else
         let URec.p_name = NRec.p_name
         let URec.p_title = NRec.p_title
         let URec.p_email = NRec.p_email
         let URec.p_phone = NRec.p_phone
         let chgFlg = TRUE
      end if
   end if

## look for hq
   if( URec.hq is NULL or URec.p_name = " ")then
      if( NRec.hq is NULL )then
         if( IRec.hq is NULL )then
         else
            let URec.hq = IRec.hq
         let chgFlg = TRUE
         end if
      else
         let URec.hq = NRec.hq
         let chgFlg = TRUE
      end if
   end if


## look for focus1
   if( URec.focus1 is NULL )then
      if( NRec.focus1 is NULL )then
         if( IRec.focus1 is NULL )then
         else
            let URec.focus1 = IRec.focus1
         let chgFlg = TRUE
         end if
      else
         let URec.focus1 = NRec.focus1
         let chgFlg = TRUE
      end if
   end if

## look for focus2
   if( URec.focus2 is NULL )then
      if( NRec.focus2 is NULL )then
         if( IRec.focus2 is NULL )then
         else
            let URec.focus2 = IRec.focus2
         let chgFlg = TRUE
         end if
      else
         let URec.focus2 = NRec.focus2
         let chgFlg = TRUE
      end if
   end if

## look for focus3
   if( URec.focus3 is NULL )then
      if( NRec.focus3 is NULL )then
         if( IRec.focus3 is NULL )then
         else
            let URec.focus3 = IRec.focus3
         let chgFlg = TRUE
         end if
      else
         let URec.focus3 = NRec.focus3
         let chgFlg = TRUE
      end if
   end if

#let chgFlg = TRUE
if( chgFlg )then
   display URec.part_name clipped, "(", URec.ceid clipped, ") - Pass 1"

   update coverage_es
      set 
         coverage_es.url = URec.url,
         coverage_es.pwp = URec.pwp,
         coverage_es.vad = URec.vad,
         coverage_es.reseller = "R",
         coverage_es.tier = "1",
         coverage_es.part_type = NRec.part_type,
         coverage_es.desc = URec.desc,
         coverage_es.hq = URec.hq,
         coverage_es.p_name = URec.p_name,
         coverage_es.p_title = URec.p_title,
         coverage_es.p_email = URec.p_email,
         coverage_es.p_phone = URec.p_phone,
         coverage_es.focus1 = URec.focus1,
         coverage_es.focus2 = URec.focus2,
         coverage_es.focus3 = URec.focus3,
         coverage_es.updtime = current
   where
      coverage_es.ceid = URec.ceid
end if

let chgFlg = FALSE

## look for industries
   if( URec.ind_eu is NULL )then
      if( NRec.ind_eu is NULL )then
         if( IRec.ind_eu is NULL )then
         else
            let URec.ind_eu = IRec.ind_eu
         let chgFlg = TRUE
         end if
      else
         let URec.ind_eu = NRec.ind_eu
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_tel is NULL )then
      if( NRec.ind_tel is NULL )then
         if( IRec.ind_tel is NULL )then
         else
            let URec.ind_tel = IRec.ind_tel
         let chgFlg = TRUE
         end if
      else
         let URec.ind_tel = NRec.ind_tel
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_me is NULL )then
      if( NRec.ind_me is NULL )then
         if( IRec.ind_me is NULL )then
         else
            let URec.ind_me = IRec.ind_me
         let chgFlg = TRUE
         end if
      else
         let URec.ind_me = NRec.ind_me
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_ret is NULL )then
      if( NRec.ind_ret is NULL )then
         if( IRec.ind_ret is NULL )then
         else
            let URec.ind_ret = IRec.ind_ret
         let chgFlg = TRUE
         end if
      else
         let URec.ind_ret = NRec.ind_ret
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_wd is NULL )then
      if( NRec.ind_wd is NULL )then
         if( IRec.ind_wd is NULL )then
         else
            let URec.ind_wd = IRec.ind_wd
         let chgFlg = TRUE
         end if
      else
         let URec.ind_wd = NRec.ind_wd
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_trans is NULL )then
      if( NRec.ind_trans is NULL )then
         if( IRec.ind_trans is NULL )then
         else
            let URec.ind_trans = IRec.ind_trans
         let chgFlg = TRUE
         end if
      else
         let URec.ind_trans = NRec.ind_trans
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_bank is NULL )then
      if( NRec.ind_bank is NULL )then
         if( IRec.ind_bank is NULL )then
         else
            let URec.ind_bank = IRec.ind_bank
         let chgFlg = TRUE
         end if
      else
         let URec.ind_bank = NRec.ind_bank
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_ins is NULL )then
      if( NRec.ind_ins is NULL )then
         if( IRec.ind_ins is NULL )then
         else
            let URec.ind_ins = IRec.ind_ins
         let chgFlg = TRUE
         end if
      else
         let URec.ind_ins = NRec.ind_ins
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_mfg is NULL )then
      if( NRec.ind_mfg is NULL )then
         if( IRec.ind_mfg is NULL )then
         else
            let URec.ind_mfg = IRec.ind_mfg
         let chgFlg = TRUE
         end if
      else
         let URec.ind_mfg = NRec.ind_mfg
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_hl is NULL )then
      if( NRec.ind_hl is NULL )then
         if( IRec.ind_hl is NULL )then
         else
            let URec.ind_hl = IRec.ind_hl
         let chgFlg = TRUE
         end if
      else
         let URec.ind_hl = NRec.ind_hl
         let chgFlg = TRUE
      end if
   end if

## look for industries
   if( URec.ind_gov is NULL )then
      if( NRec.ind_gov is NULL )then
         if( IRec.ind_gov is NULL )then
         else
            let URec.ind_gov = IRec.ind_gov
         let chgFlg = TRUE
         end if
      else
         let URec.ind_gov = NRec.ind_gov
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_pacificnw is NULL )then
      if( NRec.eu_pacificnw is NULL )then
         if( IRec.eu_pacificnw is NULL )then
         else
            let URec.eu_pacificnw = IRec.eu_pacificnw
         let chgFlg = TRUE
         end if
      else
         let URec.eu_pacificnw = NRec.eu_pacificnw
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_northca is NULL )then
      if( NRec.eu_northca is NULL )then
         if( IRec.eu_northca is NULL )then
         else
            let URec.eu_northca = IRec.eu_northca
         let chgFlg = TRUE
         end if
      else
         let URec.eu_northca = NRec.eu_northca
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_southwest is NULL )then
      if( NRec.eu_southwest is NULL )then
         if( IRec.eu_southwest is NULL )then
         else
            let URec.eu_southwest = IRec.eu_southwest
         let chgFlg = TRUE
         end if
      else
         let URec.eu_southwest = NRec.eu_southwest
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_plains is NULL )then
      if( NRec.eu_plains is NULL )then
         if( IRec.eu_plains is NULL )then
         else
            let URec.eu_plains = IRec.eu_plains
         let chgFlg = TRUE
         end if
      else
         let URec.eu_plains = NRec.eu_plains
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_heartland is NULL )then
      if( NRec.eu_heartland is NULL )then
         if( IRec.eu_heartland is NULL )then
         else
            let URec.eu_heartland = IRec.eu_heartland
         let chgFlg = TRUE
         end if
      else
         let URec.eu_heartland = NRec.eu_heartland
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_texas is NULL )then
      if( NRec.eu_texas is NULL )then
         if( IRec.eu_texas is NULL )then
         else
            let URec.eu_texas = IRec.eu_texas
         let chgFlg = TRUE
         end if
      else
         let URec.eu_texas = NRec.eu_texas
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_ny is NULL )then
      if( NRec.eu_ny is NULL )then
         if( IRec.eu_ny is NULL )then
         else
            let URec.eu_ny = IRec.eu_ny
         let chgFlg = TRUE
         end if
      else
         let URec.eu_ny = NRec.eu_ny
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_garden is NULL )then
      if( NRec.eu_garden is NULL )then
         if( IRec.eu_garden is NULL )then
         else
            let URec.eu_garden = IRec.eu_garden
         let chgFlg = TRUE
         end if
      else
         let URec.eu_garden = NRec.eu_garden
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_northeast is NULL )then
      if( NRec.eu_northeast is NULL )then
         if( IRec.eu_northeast is NULL )then
         else
            let URec.eu_northeast = IRec.eu_northeast
         let chgFlg = TRUE
         end if
      else
         let URec.eu_northeast = NRec.eu_northeast
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_delaware is NULL )then
      if( NRec.eu_delaware is NULL )then
         if( IRec.eu_delaware is NULL )then
         else
            let URec.eu_delaware = IRec.eu_delaware
         let chgFlg = TRUE
         end if
      else
         let URec.eu_delaware = NRec.eu_delaware
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_potomac is NULL )then
      if( NRec.eu_potomac is NULL )then
         if( IRec.eu_potomac is NULL )then
         else
            let URec.eu_potomac = IRec.eu_potomac
         let chgFlg = TRUE
         end if
      else
         let URec.eu_potomac = NRec.eu_potomac
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_carolinas is NULL )then
      if( NRec.eu_carolinas is NULL )then
         if( IRec.eu_carolinas is NULL )then
         else
            let URec.eu_carolinas = IRec.eu_carolinas
         let chgFlg = TRUE
         end if
      else
         let URec.eu_carolinas = NRec.eu_carolinas
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_midamerica is NULL )then
      if( NRec.eu_midamerica is NULL )then
         if( IRec.eu_midamerica is NULL )then
         else
            let URec.eu_midamerica = IRec.eu_midamerica
         let chgFlg = TRUE
         end if
      else
         let URec.eu_midamerica = NRec.eu_midamerica
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_ohio is NULL )then
      if( NRec.eu_ohio is NULL )then
         if( IRec.eu_ohio is NULL )then
         else
            let URec.eu_ohio = IRec.eu_ohio
         let chgFlg = TRUE
         end if
      else
         let URec.eu_ohio = NRec.eu_ohio
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_southeast is NULL )then
      if( NRec.eu_southeast is NULL )then
         if( IRec.eu_southeast is NULL )then
         else
            let URec.eu_southeast = IRec.eu_southeast
         let chgFlg = TRUE
         end if
      else
         let URec.eu_southeast = NRec.eu_southeast
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_sunshine is NULL )then
      if( NRec.eu_sunshine is NULL )then
         if( IRec.eu_sunshine is NULL )then
         else
            let URec.eu_sunshine = IRec.eu_sunshine
         let chgFlg = TRUE
         end if
      else
         let URec.eu_sunshine = NRec.eu_sunshine
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_ca is NULL )then
      if( NRec.eu_ca is NULL )then
         if( IRec.eu_ca_industry is NULL )then
         else
            let URec.eu_ca = IRec.eu_ca_industry
         let chgFlg = TRUE
         end if
      else
         let URec.eu_ca = NRec.eu_ca
         let chgFlg = TRUE
      end if
   end if

## look for region
   if( URec.eu_fed is NULL )then
      if( NRec.eu_fed is NULL )then
         if( IRec.eu_fed_civ is NULL )then
         else
            let URec.eu_fed = IRec.eu_fed_civ
         let chgFlg = TRUE
         end if
      else
         let URec.eu_fed = NRec.eu_fed
         let chgFlg = TRUE
      end if
   end if

let chgFlg = FALSE
if( chgFlg )then
   display URec.part_name clipped, "(", URec.ceid clipped, ") - pass 2"
   update coverage_es
      set 
         coverage_es.ind_eu = URec.ind_eu,
         coverage_es.ind_tel = URec.ind_tel,
         coverage_es.ind_me = URec.ind_me,
         coverage_es.ind_ret = URec.ind_ret,
         coverage_es.ind_wd = URec.ind_wd,
         coverage_es.ind_trans = URec.ind_trans,
         coverage_es.ind_bank = URec.ind_bank,
         coverage_es.ind_ins = URec.ind_ins,
         coverage_es.ind_mfg = URec.ind_mfg,
         coverage_es.ind_hl = URec.ind_hl,
         coverage_es.eu_pacificnw = URec.eu_pacificnw,
         coverage_es.eu_northca = URec.eu_northca,
         coverage_es.eu_southwest = URec.eu_southwest,
         coverage_es.eu_northern = URec.eu_northern,
         coverage_es.eu_plains = URec.eu_plains,
         coverage_es.eu_heartland = URec.eu_heartland,
         coverage_es.eu_texas = URec.eu_texas,
         coverage_es.eu_midamerica = URec.eu_midamerica,
         coverage_es.eu_ohio = URec.eu_ohio,
         coverage_es.eu_southeast = URec.eu_southeast,
         coverage_es.eu_sunshine = URec.eu_sunshine,
         coverage_es.eu_northeast = URec.eu_northeast,
         coverage_es.eu_ny = URec.eu_ny,
         coverage_es.eu_garden = URec.eu_garden,
         coverage_es.eu_delaware = URec.eu_delaware,
         coverage_es.eu_potomac = URec.eu_potomac,
         coverage_es.eu_carolinas = URec.eu_carolinas,
         coverage_es.eu_ca = URec.eu_ca,
         coverage_es.eu_fed = URec.eu_fed,
         coverage_es.updtime = current
   where
      coverage_es.ceid = URec.ceid
end if


end foreach

commit work;

END MAIN
