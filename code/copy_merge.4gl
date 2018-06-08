
globals "globals.4gl"

MAIN
   define
      ARec record like coverage_nc.*,
      SRec record like coverage_su.*,
      SQLStr char(9000)

   let SQLStr = "select a.*, b.* from coverage_au a, coverage_su b where a.ceid=b.ceid order by a.part_name"
#   let SQLStr = "select a.*, b.* from coverage_au a, coverage_su b where a.ceid=b.ceid and a.ceid='18z7gk2h' order by a.part_name"

#display SQLStr
begin work;

   prepare C1ID from SQLStr
   declare C1Curs cursor for C1ID

   foreach C1Curs into ARec.*, SRec.*
      display ARec.part_name clipped, " / ", SRec.part_name clipped

## industry
      if( SRec.ind_eu > ARec.ind_eu or (SRec.ind_eu is not null and SRec.ind_eu != ' ' and ARec.ind_eu is null and ARec.ind_eu is null ))then let ARec.ind_eu = SRec.ind_eu end if
      if( SRec.ind_tel> ARec.ind_tel or (SRec.ind_tel is not null and SRec.ind_tel != ' ' and ARec.ind_tel is null and ARec.ind_tel is null ))then let ARec.ind_tel= SRec.ind_tel end if
      if( SRec.ind_me > ARec.ind_me  or (SRec.ind_me is not null and SRec.ind_me != ' ' and ARec.ind_me is null and ARec.ind_me is null ))then let ARec.ind_me = SRec.ind_me end if
      if( SRec.ind_ret > ARec.ind_ret  or (SRec.ind_ret is not null and SRec.ind_ret != ' ' and ARec.ind_ret is null and ARec.ind_ret is null ))then let ARec.ind_ret = SRec.ind_ret end if
      if( SRec.ind_wd > ARec.ind_wd  or (SRec.ind_wd is not null and SRec.ind_wd != ' ' and ARec.ind_wd is null and ARec.ind_wd is null ))then let ARec.ind_wd = SRec.ind_wd end if
      if( SRec.ind_trans > ARec.ind_trans  or (SRec.ind_trans is not null and SRec.ind_trans != ' ' and ARec.ind_trans is null and ARec.ind_trans is null ))then let ARec.ind_trans = SRec.ind_trans end if
      if( SRec.ind_bank > ARec.ind_bank  or (SRec.ind_bank is not null and SRec.ind_bank != ' ' and ARec.ind_bank is null and ARec.ind_bank is null ))then let ARec.ind_bank = SRec.ind_bank end if
      if( SRec.ind_ins > ARec.ind_ins or (SRec.ind_ins is not null and SRec.ind_ins != ' ' and ARec.ind_ins is null and ARec.ind_ins is null ))then let ARec.ind_ins = SRec.ind_ins end if
      if( SRec.ind_mfg > ARec.ind_mfg  or (SRec.ind_mfg is not null and SRec.ind_mfg != ' ' and ARec.ind_mfg is null and ARec.ind_mfg is null ))then let ARec.ind_mfg = SRec.ind_mfg end if
      if( SRec.ind_hl > ARec.ind_hl  or (SRec.ind_hl is not null and SRec.ind_hl != ' ' and ARec.ind_hl is null and ARec.ind_hl is null ))then let ARec.ind_hl = SRec.ind_hl end if
      if( SRec.ind_gov > ARec.ind_gov  or (SRec.ind_gov is not null and SRec.ind_gov != ' ' and ARec.ind_gov is null and ARec.ind_gov is null ))then let ARec.ind_gov = SRec.ind_gov end if
      if( SRec.ind_cross > ARec.ind_cross  or (SRec.ind_cross is not null and SRec.ind_cross != ' ' and ARec.ind_cross is null and ARec.ind_cross is null ))then let ARec.ind_cross = SRec.ind_cross end if
      if( SRec.ind_auto > ARec.ind_auto  or (SRec.ind_auto is not null and SRec.ind_auto != ' ' and ARec.ind_auto is null and ARec.ind_auto is null ))then let ARec.ind_auto = SRec.ind_auto end if
      if( SRec.ind_csi > ARec.ind_csi  or (SRec.ind_csi is not null and SRec.ind_csi != ' ' and ARec.ind_csi is null and ARec.ind_csi is null ))then let ARec.ind_csi = SRec.ind_csi end if
      if( SRec.ind_chem > ARec.ind_chem  or (SRec.ind_chem is not null and SRec.ind_chem != ' ' and ARec.ind_chem is null and ARec.ind_chem is null ))then let ARec.ind_chem = SRec.ind_chem end if
      if( SRec.ind_consume > ARec.ind_consume  or (SRec.ind_consume is not null and SRec.ind_consume != ' ' and ARec.ind_consume is null and ARec.ind_consume is null ))then let ARec.ind_consume = SRec.ind_consume end if
      if( SRec.ind_defense > ARec.ind_defense  or (SRec.ind_defense is not null and SRec.ind_defense != ' ' and ARec.ind_defense is null and ARec.ind_defense is null ))then let ARec.ind_defense = SRec.ind_defense end if
      if( SRec.ind_elect > ARec.ind_elect  or (SRec.ind_elect is not null and SRec.ind_elect != ' ' and ARec.ind_elect is null and ARec.ind_elect is null ))then let ARec.ind_elect = SRec.ind_elect end if
      if( SRec.ind_finan > ARec.ind_finan  or (SRec.ind_finan is not null and SRec.ind_finan != ' ' and ARec.ind_finan is null and ARec.ind_finan is null ))then let ARec.ind_finan = SRec.ind_finan end if
      if( SRec.ind_indprod > ARec.ind_indprod  or (SRec.ind_indprod is not null and SRec.ind_indprod != ' ' and ARec.ind_indprod is null and ARec.ind_indprod is null ))then let ARec.ind_indprod = SRec.ind_indprod end if
      if( SRec.ind_lifesci > ARec.ind_lifesci  or (SRec.ind_lifesci is not null and SRec.ind_lifesci != ' ' and ARec.ind_lifesci is null and ARec.ind_lifesci is null ))then let ARec.ind_lifesci = SRec.ind_lifesci end if
      if( SRec.ind_fed > ARec.ind_fed  or (SRec.ind_fed is not null and SRec.ind_fed != ' ' and ARec.ind_fed is null and ARec.ind_fed is null ))then let ARec.ind_fed = SRec.ind_fed end if
      if( SRec.ind_can > ARec.ind_can  or (SRec.ind_can is not null and SRec.ind_can != ' ' and ARec.ind_can is null and ARec.ind_can is null ))then let ARec.ind_can = SRec.ind_can end if
      if( SRec.ind_education > ARec.ind_education  or (SRec.ind_education is not null and SRec.ind_education != ' ' and ARec.ind_education is null and ARec.ind_education is null ))then let ARec.ind_education = SRec.ind_education end if


## geo
      if( SRec.eu_pacificnw != " " and (ARec.eu_pacificnw = " " or ARec.eu_pacificnw is null) )then let ARec.eu_pacificnw = SRec.eu_pacificnw end if
      if( SRec.eu_northca != " " and (ARec.eu_northca = " " or ARec.eu_northca is null))then let ARec.eu_northca = SRec.eu_northca end if
      if( SRec.eu_southwest != " " and (ARec.eu_southwest = " " or ARec.eu_southwest is null))then let ARec.eu_southwest = SRec.eu_southwest end if
      if( SRec.eu_northern != " " and (ARec.eu_northern = " " or ARec.eu_northern is null))then let ARec.eu_northern = SRec.eu_northern end if
      if( SRec.eu_plains != " " and (ARec.eu_plains = " " or ARec.eu_plains is null))then let ARec.eu_plains = SRec.eu_plains end if
      if( SRec.eu_heartland != " " and (ARec.eu_heartland = " " or ARec.eu_heartland is null))then let ARec.eu_heartland = SRec.eu_heartland end if
      if( SRec.eu_texas != " " and (ARec.eu_texas = " " or ARec.eu_texas is null))then let ARec.eu_texas = SRec.eu_texas end if
      if( SRec.eu_midamerica != " " and (ARec.eu_midamerica = " " or ARec.eu_midamerica is null))then let ARec.eu_midamerica = SRec.eu_midamerica end if
      if( SRec.eu_ohio != " " and (ARec.eu_ohio = " " or ARec.eu_ohio is null))then let ARec.eu_ohio = SRec.eu_ohio end if
      if( SRec.eu_southeast != " " and (ARec.eu_southeast = " " or ARec.eu_southeast is null))then let ARec.eu_southeast = SRec.eu_southeast end if
      if( SRec.eu_sunshine != " " and (ARec.eu_sunshine = " " or ARec.eu_sunshine is null))then let ARec.eu_sunshine = SRec.eu_sunshine end if
      if( SRec.eu_northeast != " " and (ARec.eu_northeast = " " or ARec.eu_northeast is null))then let ARec.eu_northeast = SRec.eu_northeast end if
      if( SRec.eu_ny != " " and (ARec.eu_ny = " " or ARec.eu_ny is null))then let ARec.eu_ny = SRec.eu_ny end if
      if( SRec.eu_garden != " " and (ARec.eu_garden = " " or ARec.eu_garden is null))then let ARec.eu_garden = SRec.eu_garden end if
      if( SRec.eu_delaware != " " and (ARec.eu_delaware = " " or ARec.eu_delaware is null))then let ARec.eu_delaware = SRec.eu_delaware end if
      if( SRec.eu_potomac != " " and (ARec.eu_potomac = " " or ARec.eu_potomac is null))then let ARec.eu_potomac = SRec.eu_potomac end if
      if( SRec.eu_carolinas != " " and (ARec.eu_carolinas = " " or ARec.eu_carolinas is null))then let ARec.eu_carolinas = SRec.eu_carolinas end if
      if( SRec.eu_ca != " " and (ARec.eu_ca = " " or ARec.eu_ca is null))then let ARec.eu_ca = SRec.eu_ca end if
      if( SRec.eu_fed != " " and (ARec.eu_fed = " " or ARec.eu_fed is null))then let ARec.eu_fed = SRec.eu_fed end if


## url
      if( (ARec.url is null or ARec.url = " ") and (SRec.url is not null and SRec.url != " "))then let ARec.url = SRec.url end if
      if( (ARec.pwp is null or ARec.pwp = " ") and (SRec.pwp is not null and SRec.pwp != " "))then let ARec.pwp = SRec.pwp end if

## other
      if( (ARec.hq is null or ARec.hq = " ") and (SRec.hq is not null and SRec.hq != " "))then let ARec.hq = SRec.hq end if
      if( (ARec.desc is null or ARec.desc = " ") and (SRec.desc is not null and SRec.desc != " "))then let ARec.desc = SRec.desc end if
      if( (ARec.focus1 is null or ARec.focus1 = " ") and (SRec.focus1 is not null and SRec.focus1 != " "))then let ARec.focus1 = SRec.focus1 end if
      if( (ARec.focus2 is null or ARec.focus2 = " ") and (SRec.focus2 is not null and SRec.focus2 != " "))then let ARec.focus2 = SRec.focus2 end if
      if( (ARec.focus3 is null or ARec.focus3 = " ") and (SRec.focus3 is not null and SRec.focus3 != " "))then let ARec.focus3 = SRec.focus3 end if
      if( (ARec.partners_well is null or ARec.partners_well = " ") and (SRec.partners_well is not null and SRec.partners_well != " "))then let ARec.partners_well = SRec.partners_well end if
      if( (ARec.hunter is null or ARec.hunter = " ") and (SRec.hunter is not null and SRec.hunter != " "))then let ARec.hunter = SRec.hunter end if
      if( (ARec.lap is null or ARec.lap = " ") and (SRec.lap is not null and SRec.lap != " "))then let ARec.lap = SRec.lap end if
      if( (ARec.dfm is null or ARec.dfm = " ") and (SRec.dfm is not null and SRec.dfm != " "))then let ARec.dfm = SRec.dfm end if
      if( (ARec.commercial is null or ARec.commercial = " ") and (SRec.commercial is not null and SRec.commercial != " "))then let ARec.commercial = SRec.commercial end if
      if( (ARec.enterprise is null or ARec.enterprise = " ") and (SRec.enterprise is not null and SRec.enterprise != " "))then let ARec.enterprise = SRec.enterprise end if
      if( (ARec.industry is null or ARec.industry = " ") and (SRec.industry is not null and SRec.industry != " "))then let ARec.industry = SRec.industry end if

## contact
      if( (ARec.p_name is null or ARec.p_name = " ") and (SRec.p_name is not null and SRec.p_name != " "))then let ARec.p_name = SRec.p_name end if
      if( (ARec.p_title is null or ARec.p_title = " ") and (SRec.p_title is not null and SRec.p_title != " "))then let ARec.p_title = SRec.p_title end if
      if( (ARec.p_phone is null or ARec.p_phone = " ") and (SRec.p_phone is not null and SRec.p_phone != " "))then let ARec.p_phone = SRec.p_phone end if
      if( (ARec.p_email is null or ARec.p_email = " ") and (SRec.p_email is not null and SRec.p_email != " "))then let ARec.p_email = SRec.p_email end if

     let ARec.updtime=current

display ARec.*
display SRec.*
      update coverage_nc set 
         coverage_nc.* = ARec.*
      where ceid = ARec.ceid 
   end foreach

#commit work;
END MAIN

