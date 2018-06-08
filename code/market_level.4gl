
globals "globals.4gl"

main
define
   MCRec, NCRec, SERec, CURec, BURec, STRec, ESRec, IORec record like coverage_mc.*,
   uc smallint,
   SQLStr, UpdStr char(1024)

   let SQLStr="select mc.*, nc.*, se.*, cu.*, bu.*, st.*, es.*, io.* from coverage_mc mc, ",
              "outer coverage_nc nc, ",
              "outer coverage_se se, ",
              "outer coverage_cu cu, ",
              "outer coverage_bu bu, ",
              "outer coverage_st st, ",
              "outer coverage_es es, ",
              "outer coverage_io io ",
              "where mc.ceid=nc.ceid and nc.reseller!='N' and ",
              "      mc.ceid=se.ceid and se.reseller!='N' and ",
              "      mc.ceid=cu.ceid and cu.reseller!='N' and ",
              "      mc.ceid=bu.ceid and bu.reseller!='N' and ",
              "      mc.ceid=st.ceid and st.reseller!='N' and ",
              "      mc.ceid=es.ceid and es.reseller!='N' and ",
              "      mc.ceid=io.ceid and io.reseller!='N' "

   prepare ID from SQLStr
   declare myCurs cursor for ID

   foreach myCurs into MCRec.*, NCRec.*, SERec.*, CURec.*, BURec.*, STRec.*, ESRec.*, IORec.*

##############################################################
##           MARKETS - AVERAGE
##############################################################
##############################################################
      let UpdStr="update coverage_mc set "

      let uc=FALSE
##    determine market settings 
      
##    ind_eu
      let MCRec.ind_eu = addIfGood(NCRec.ind_eu,
                                   SERec.ind_eu,
                                   CURec.ind_eu,
                                   BURec.ind_eu,
                                   STRec.ind_eu,
                                   ESRec.ind_eu,
                                   IORec.ind_eu)
      if( MCRec.ind_eu > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " ind_eu='", MCRec.ind_eu using "&", "', "
          let uc=TRUE
      end if

##    ind_tel
      let MCRec.ind_tel = addIfGood(NCRec.ind_tel,
                                   SERec.ind_tel,
                                   CURec.ind_tel,
                                   BURec.ind_tel,
                                   STRec.ind_tel,
                                   ESRec.ind_tel,
                                   IORec.ind_tel)
      if( MCRec.ind_tel > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_tel
          let UpdStr=UpdStr clipped, " ind_tel='", MCRec.ind_tel using "&", "', "
          let uc=TRUE
      end if

##    ind_me
      let MCRec.ind_me = addIfGood(NCRec.ind_me,
                                   SERec.ind_me,
                                   CURec.ind_me,
                                   BURec.ind_me,
                                   STRec.ind_me,
                                   ESRec.ind_me,
                                   IORec.ind_me)
      if( MCRec.ind_me > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_me
          let UpdStr=UpdStr clipped, " ind_me='", MCRec.ind_me using "&", "', "
          let uc=TRUE
      end if
##    ind_ret
      let MCRec.ind_ret = addIfGood(NCRec.ind_ret,
                                   SERec.ind_ret,
                                   CURec.ind_ret,
                                   BURec.ind_ret,
                                   STRec.ind_ret,
                                   ESRec.ind_ret,
                                   IORec.ind_ret)
      if( MCRec.ind_ret > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_ret
          let UpdStr=UpdStr clipped, " ind_ret='", MCRec.ind_ret using "&", "', "
          let uc=TRUE
      end if
##    ind_wd
      let MCRec.ind_wd = addIfGood(NCRec.ind_wd,
                                   SERec.ind_wd,
                                   CURec.ind_wd,
                                   BURec.ind_wd,
                                   STRec.ind_wd,
                                   ESRec.ind_wd,
                                   IORec.ind_wd)
      if( MCRec.ind_wd > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_wd
          let UpdStr=UpdStr clipped, " ind_wd='", MCRec.ind_wd using "&", "', "
          let uc=TRUE
      end if
##    ind_trans
      let MCRec.ind_trans = addIfGood(NCRec.ind_trans,
                                   SERec.ind_trans,
                                   CURec.ind_trans,
                                   BURec.ind_trans,
                                   STRec.ind_trans,
                                   ESRec.ind_trans,
                                   IORec.ind_trans)
      if( MCRec.ind_trans > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_trans
          let UpdStr=UpdStr clipped, " ind_trans='", MCRec.ind_trans using "&", "', "
          let uc=TRUE
      end if
##    ind_bank
      let MCRec.ind_bank = addIfGood(NCRec.ind_bank,
                                   SERec.ind_bank,
                                   CURec.ind_bank,
                                   BURec.ind_bank,
                                   STRec.ind_bank,
                                   ESRec.ind_bank,
                                   IORec.ind_bank)
      if( MCRec.ind_bank > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_bank
          let UpdStr=UpdStr clipped, " ind_bank='", MCRec.ind_bank using "&", "', "
          let uc=TRUE
      end if
##    ind_ins
      let MCRec.ind_ins = addIfGood(NCRec.ind_ins,
                                   SERec.ind_ins,
                                   CURec.ind_ins,
                                   BURec.ind_ins,
                                   STRec.ind_ins,
                                   ESRec.ind_ins,
                                   IORec.ind_ins)
      if( MCRec.ind_ins > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_ins
          let UpdStr=UpdStr clipped, " ind_ins='", MCRec.ind_ins using "&", "', "
          let uc=TRUE
      end if
##    ind_mfg
      let MCRec.ind_mfg = addIfGood(NCRec.ind_mfg,
                                   SERec.ind_mfg,
                                   CURec.ind_mfg,
                                   BURec.ind_mfg,
                                   STRec.ind_mfg,
                                   ESRec.ind_mfg,
                                   IORec.ind_mfg)
      if( MCRec.ind_mfg > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_mfg
          let UpdStr=UpdStr clipped, " ind_mfg='", MCRec.ind_mfg using "&", "', "
          let uc=TRUE
      end if
##    ind_hl
      let MCRec.ind_hl = addIfGood(NCRec.ind_hl,
                                   SERec.ind_hl,
                                   CURec.ind_hl,
                                   BURec.ind_hl,
                                   STRec.ind_hl,
                                   ESRec.ind_hl,
                                   IORec.ind_hl)
      if( MCRec.ind_hl > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_hl
          let UpdStr=UpdStr clipped, " ind_hl='", MCRec.ind_hl using "&", "', "
          let uc=TRUE
      end if
##    ind_gov
      let MCRec.ind_gov = addIfGood(NCRec.ind_gov,
                                   SERec.ind_gov,
                                   CURec.ind_gov,
                                   BURec.ind_gov,
                                   STRec.ind_gov,
                                   ESRec.ind_gov,
                                   IORec.ind_gov)
      if( MCRec.ind_gov > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_gov
          let UpdStr=UpdStr clipped, " ind_gov='", MCRec.ind_gov using "&", "', "
          let uc=TRUE
      end if
##    ind_cross
      let MCRec.ind_cross = addIfGood(NCRec.ind_cross,
                                   SERec.ind_cross,
                                   CURec.ind_cross,
                                   BURec.ind_cross,
                                   STRec.ind_cross,
                                   ESRec.ind_cross,
                                   IORec.ind_cross)
      if( MCRec.ind_cross > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_cross
          let UpdStr=UpdStr clipped, " ind_cross='", MCRec.ind_cross using "&", "', "
          let uc=TRUE
      end if
##    ind_auto
      let MCRec.ind_auto = addIfGood(NCRec.ind_auto,
                                   SERec.ind_auto,
                                   CURec.ind_auto,
                                   BURec.ind_auto,
                                   STRec.ind_auto,
                                   ESRec.ind_auto,
                                   IORec.ind_auto)
      if( MCRec.ind_auto > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_auto
          let UpdStr=UpdStr clipped, " ind_auto='", MCRec.ind_auto using "&", "', "
          let uc=TRUE
      end if
##    ind_csi
      let MCRec.ind_csi = addIfGood(NCRec.ind_csi,
                                   SERec.ind_csi,
                                   CURec.ind_csi,
                                   BURec.ind_csi,
                                   STRec.ind_csi,
                                   ESRec.ind_csi,
                                   IORec.ind_csi)
      if( MCRec.ind_csi > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_csi
          let UpdStr=UpdStr clipped, " ind_csi='", MCRec.ind_csi using "&", "', "
          let uc=TRUE
      end if
##    ind_chem
      let MCRec.ind_chem = addIfGood(NCRec.ind_chem,
                                   SERec.ind_chem,
                                   CURec.ind_chem,
                                   BURec.ind_chem,
                                   STRec.ind_chem,
                                   ESRec.ind_chem,
                                   IORec.ind_chem)
      if( MCRec.ind_chem > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_chem
          let UpdStr=UpdStr clipped, " ind_chem='", MCRec.ind_chem using "&", "', "
          let uc=TRUE
      end if
##    ind_consume
      let MCRec.ind_consume = addIfGood(NCRec.ind_consume,
                                   SERec.ind_consume,
                                   CURec.ind_consume,
                                   BURec.ind_consume,
                                   STRec.ind_consume,
                                   ESRec.ind_consume,
                                   IORec.ind_consume)
      if( MCRec.ind_consume > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_consume
          let UpdStr=UpdStr clipped, " ind_consume='", MCRec.ind_consume using "&", "', "
          let uc=TRUE
      end if
##    ind_defense
      let MCRec.ind_defense = addIfGood(NCRec.ind_defense,
                                   SERec.ind_defense,
                                   CURec.ind_defense,
                                   BURec.ind_defense,
                                   STRec.ind_defense,
                                   ESRec.ind_defense,
                                   IORec.ind_defense)
      if( MCRec.ind_defense > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_defense
          let UpdStr=UpdStr clipped, " ind_defense='", MCRec.ind_defense using "&", "', "
          let uc=TRUE
      end if
##    ind_elect
      let MCRec.ind_elect = addIfGood(NCRec.ind_elect,
                                   SERec.ind_elect,
                                   CURec.ind_elect,
                                   BURec.ind_elect,
                                   STRec.ind_elect,
                                   ESRec.ind_elect,
                                   IORec.ind_elect)
      if( MCRec.ind_elect > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_elect
          let UpdStr=UpdStr clipped, " ind_elect='", MCRec.ind_elect using "&", "', "
          let uc=TRUE
      end if
##    ind_finan
      let MCRec.ind_finan = addIfGood(NCRec.ind_finan,
                                   SERec.ind_finan,
                                   CURec.ind_finan,
                                   BURec.ind_finan,
                                   STRec.ind_finan,
                                   ESRec.ind_finan,
                                   IORec.ind_finan)
      if( MCRec.ind_finan > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_finan
          let UpdStr=UpdStr clipped, " ind_finan='", MCRec.ind_finan using "&", "', "
          let uc=TRUE
      end if
##    ind_indprod
      let MCRec.ind_indprod = addIfGood(NCRec.ind_indprod,
                                   SERec.ind_indprod,
                                   CURec.ind_indprod,
                                   BURec.ind_indprod,
                                   STRec.ind_indprod,
                                   ESRec.ind_indprod,
                                   IORec.ind_indprod)
      if( MCRec.ind_indprod > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_indprod
          let UpdStr=UpdStr clipped, " ind_indprod='", MCRec.ind_indprod using "&", "', "
          let uc=TRUE
      end if
##    ind_lifesci
      let MCRec.ind_lifesci = addIfGood(NCRec.ind_lifesci,
                                   SERec.ind_lifesci,
                                   CURec.ind_lifesci,
                                   BURec.ind_lifesci,
                                   STRec.ind_lifesci,
                                   ESRec.ind_lifesci,
                                   IORec.ind_lifesci)
      if( MCRec.ind_lifesci > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_lifesci
          let UpdStr=UpdStr clipped, " ind_lifesci='", MCRec.ind_lifesci using "&", "', "
          let uc=TRUE
      end if
##    ind_fed
      let MCRec.ind_fed = addIfGood(NCRec.ind_fed,
                                   SERec.ind_fed,
                                   CURec.ind_fed,
                                   BURec.ind_fed,
                                   STRec.ind_fed,
                                   ESRec.ind_fed,
                                   IORec.ind_fed)
      if( MCRec.ind_fed > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_fed
          let UpdStr=UpdStr clipped, " ind_fed='", MCRec.ind_fed using "&", "', "
          let uc=TRUE
      end if
##    ind_can
      let MCRec.ind_can = addIfGood(NCRec.ind_can,
                                   SERec.ind_can,
                                   CURec.ind_can,
                                   BURec.ind_can,
                                   STRec.ind_can,
                                   ESRec.ind_can,
                                   IORec.ind_can)
      if( MCRec.ind_can > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_can
          let UpdStr=UpdStr clipped, " ind_can='", MCRec.ind_can using "&", "', "
          let uc=TRUE
      end if
##    ind_education
      let MCRec.ind_education = addIfGood(NCRec.ind_education,
                                   SERec.ind_education,
                                   CURec.ind_education,
                                   BURec.ind_education,
                                   STRec.ind_education,
                                   ESRec.ind_education,
                                   IORec.ind_education)
      if( MCRec.ind_education > 0 )then
#         display MCRec.part_name clipped, " ", MCRec.ind_education
          let UpdStr=UpdStr clipped, " ind_education='", MCRec.ind_education using "&", "', "
          let uc=TRUE
      end if


      if( uc )then
         let UpdStr=UpdStr clipped, " updtime=current where ceid='", MCRec.ceid clipped, "';"
         prepare UID from UpdStr
         execute UID
         display UpdStr clipped
      end if  #uc



##############################################################
##           GEO - MERGE VALUES
##############################################################
##############################################################

      let UpdStr="update coverage_mc set "

      let uc=FALSE
##    determine market settings 
      
##    eu_pacificnw
      let MCRec.eu_pacificnw = addIfGoodGeo(NCRec.eu_pacificnw,
                                            SERec.eu_pacificnw,
                                            CURec.eu_pacificnw,
                                            BURec.eu_pacificnw,
                                            STRec.eu_pacificnw,
                                            ESRec.eu_pacificnw,
                                            IORec.eu_pacificnw)
      if( MCRec.eu_pacificnw ='H' or MCRec.eu_pacificnw='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_pacificnw='", MCRec.eu_pacificnw, "', "
          let uc=TRUE
      end if

##    eu_northca
      let MCRec.eu_northca = addIfGoodGeo(NCRec.eu_northca,
                                            SERec.eu_northca,
                                            CURec.eu_northca,
                                            BURec.eu_northca,
                                            STRec.eu_northca,
                                            ESRec.eu_northca,
                                            IORec.eu_northca)
      if( MCRec.eu_northca ='H' or MCRec.eu_northca='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_northca='", MCRec.eu_northca, "', "
          let uc=TRUE
      end if

##    eu_southwest
      let MCRec.eu_southwest = addIfGoodGeo(NCRec.eu_southwest,
                                            SERec.eu_southwest,
                                            CURec.eu_southwest,
                                            BURec.eu_southwest,
                                            STRec.eu_southwest,
                                            ESRec.eu_southwest,
                                            IORec.eu_southwest)
      if( MCRec.eu_southwest ='H' or MCRec.eu_southwest='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_southwest='", MCRec.eu_southwest, "', "
          let uc=TRUE
      end if

##    eu_northern
      let MCRec.eu_northern = addIfGoodGeo(NCRec.eu_northern,
                                            SERec.eu_northern,
                                            CURec.eu_northern,
                                            BURec.eu_northern,
                                            STRec.eu_northern,
                                            ESRec.eu_northern,
                                            IORec.eu_northern)
      if( MCRec.eu_northern ='H' or MCRec.eu_northern='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_northern='", MCRec.eu_northern, "', "
          let uc=TRUE
      end if

##    eu_plains
      let MCRec.eu_plains = addIfGoodGeo(NCRec.eu_plains,
                                            SERec.eu_plains,
                                            CURec.eu_plains,
                                            BURec.eu_plains,
                                            STRec.eu_plains,
                                            ESRec.eu_plains,
                                            IORec.eu_plains)
      if( MCRec.eu_plains ='H' or MCRec.eu_plains='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_plains='", MCRec.eu_plains, "', "
          let uc=TRUE
      end if

##    eu_heartland
      let MCRec.eu_heartland = addIfGoodGeo(NCRec.eu_heartland,
                                            SERec.eu_heartland,
                                            CURec.eu_heartland,
                                            BURec.eu_heartland,
                                            STRec.eu_heartland,
                                            ESRec.eu_heartland,
                                            IORec.eu_heartland)
      if( MCRec.eu_heartland ='H' or MCRec.eu_heartland='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_heartland='", MCRec.eu_heartland, "', "
          let uc=TRUE
      end if

##    eu_texas
      let MCRec.eu_texas = addIfGoodGeo(NCRec.eu_texas,
                                            SERec.eu_texas,
                                            CURec.eu_texas,
                                            BURec.eu_texas,
                                            STRec.eu_texas,
                                            ESRec.eu_texas,
                                            IORec.eu_texas)
      if( MCRec.eu_texas ='H' or MCRec.eu_texas='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_texas='", MCRec.eu_texas, "', "
          let uc=TRUE
      end if

##    eu_midamerica
      let MCRec.eu_midamerica = addIfGoodGeo(NCRec.eu_midamerica,
                                            SERec.eu_midamerica,
                                            CURec.eu_midamerica,
                                            BURec.eu_midamerica,
                                            STRec.eu_midamerica,
                                            ESRec.eu_midamerica,
                                            IORec.eu_midamerica)
      if( MCRec.eu_midamerica ='H' or MCRec.eu_midamerica='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_midamerica='", MCRec.eu_midamerica, "', "
          let uc=TRUE
      end if

##    eu_ohio
      let MCRec.eu_ohio = addIfGoodGeo(NCRec.eu_ohio,
                                            SERec.eu_ohio,
                                            CURec.eu_ohio,
                                            BURec.eu_ohio,
                                            STRec.eu_ohio,
                                            ESRec.eu_ohio,
                                            IORec.eu_ohio)
      if( MCRec.eu_ohio ='H' or MCRec.eu_ohio='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_ohio='", MCRec.eu_ohio, "', "
          let uc=TRUE
      end if

##    eu_southeast
      let MCRec.eu_southeast = addIfGoodGeo(NCRec.eu_southeast,
                                            SERec.eu_southeast,
                                            CURec.eu_southeast,
                                            BURec.eu_southeast,
                                            STRec.eu_southeast,
                                            ESRec.eu_southeast,
                                            IORec.eu_southeast)
      if( MCRec.eu_southeast ='H' or MCRec.eu_southeast='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_southeast='", MCRec.eu_southeast, "', "
          let uc=TRUE
      end if

##    eu_sunshine
      let MCRec.eu_sunshine = addIfGoodGeo(NCRec.eu_sunshine,
                                            SERec.eu_sunshine,
                                            CURec.eu_sunshine,
                                            BURec.eu_sunshine,
                                            STRec.eu_sunshine,
                                            ESRec.eu_sunshine,
                                            IORec.eu_sunshine)
      if( MCRec.eu_sunshine ='H' or MCRec.eu_sunshine='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_sunshine='", MCRec.eu_sunshine, "', "
          let uc=TRUE
      end if

##    eu_northeast
      let MCRec.eu_northeast = addIfGoodGeo(NCRec.eu_northeast,
                                            SERec.eu_northeast,
                                            CURec.eu_northeast,
                                            BURec.eu_northeast,
                                            STRec.eu_northeast,
                                            ESRec.eu_northeast,
                                            IORec.eu_northeast)
      if( MCRec.eu_northeast ='H' or MCRec.eu_northeast='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_northeast='", MCRec.eu_northeast, "', "
          let uc=TRUE
      end if

##    eu_ny
      let MCRec.eu_ny = addIfGoodGeo(NCRec.eu_ny,
                                            SERec.eu_ny,
                                            CURec.eu_ny,
                                            BURec.eu_ny,
                                            STRec.eu_ny,
                                            ESRec.eu_ny,
                                            IORec.eu_ny)
      if( MCRec.eu_ny ='H' or MCRec.eu_ny='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_ny='", MCRec.eu_ny, "', "
          let uc=TRUE
      end if

##    eu_garden
      let MCRec.eu_garden = addIfGoodGeo(NCRec.eu_garden,
                                            SERec.eu_garden,
                                            CURec.eu_garden,
                                            BURec.eu_garden,
                                            STRec.eu_garden,
                                            ESRec.eu_garden,
                                            IORec.eu_garden)
      if( MCRec.eu_garden ='H' or MCRec.eu_garden='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_garden='", MCRec.eu_garden, "', "
          let uc=TRUE
      end if

##    eu_delaware
      let MCRec.eu_delaware = addIfGoodGeo(NCRec.eu_delaware,
                                            SERec.eu_delaware,
                                            CURec.eu_delaware,
                                            BURec.eu_delaware,
                                            STRec.eu_delaware,
                                            ESRec.eu_delaware,
                                            IORec.eu_delaware)
      if( MCRec.eu_delaware ='H' or MCRec.eu_delaware='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_delaware='", MCRec.eu_delaware, "', "
          let uc=TRUE
      end if

##    eu_potomac
      let MCRec.eu_potomac = addIfGoodGeo(NCRec.eu_potomac,
                                            SERec.eu_potomac,
                                            CURec.eu_potomac,
                                            BURec.eu_potomac,
                                            STRec.eu_potomac,
                                            ESRec.eu_potomac,
                                            IORec.eu_potomac)
      if( MCRec.eu_potomac ='H' or MCRec.eu_potomac='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_potomac='", MCRec.eu_potomac, "', "
          let uc=TRUE
      end if

##    eu_carolinas
      let MCRec.eu_carolinas = addIfGoodGeo(NCRec.eu_carolinas,
                                            SERec.eu_carolinas,
                                            CURec.eu_carolinas,
                                            BURec.eu_carolinas,
                                            STRec.eu_carolinas,
                                            ESRec.eu_carolinas,
                                            IORec.eu_carolinas)
      if( MCRec.eu_carolinas ='H' or MCRec.eu_carolinas='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_carolinas='", MCRec.eu_carolinas, "', "
          let uc=TRUE
      end if

##    eu_ca
      let MCRec.eu_ca = addIfGoodGeo(NCRec.eu_ca,
                                            SERec.eu_ca,
                                            CURec.eu_ca,
                                            BURec.eu_ca,
                                            STRec.eu_ca,
                                            ESRec.eu_ca,
                                            IORec.eu_ca)
      if( MCRec.eu_ca ='H' or MCRec.eu_ca='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_ca='", MCRec.eu_ca, "', "
          let uc=TRUE
      end if

##    eu_fed
      let MCRec.eu_fed = addIfGoodGeo(NCRec.eu_fed,
                                            SERec.eu_fed,
                                            CURec.eu_fed,
                                            BURec.eu_fed,
                                            STRec.eu_fed,
                                            ESRec.eu_fed,
                                            IORec.eu_fed)
      if( MCRec.eu_fed ='H' or MCRec.eu_fed='Y' )then
#         display MCRec.part_name clipped, " ", MCRec.ind_eu
          let UpdStr=UpdStr clipped, " eu_fed='", MCRec.eu_fed, "', "
          let uc=TRUE
      end if


      if( uc )then
         let UpdStr=UpdStr clipped, " updtime=current where ceid='", MCRec.ceid clipped, "';"
         prepare UGID from UpdStr
         execute UGID
         display UpdStr clipped
      end if  #uc

   end foreach

end main

function addIfGood( num1, num2, num3, num4, num5, num6, num7 )
define
   num1, num2, num3, num4, num5, num6, num7 smallfloat,
   cnt smallint,
   retVal smallfloat

   let cnt=0
   let retVal=0
   if( num1 is not null and num1 > 0 )then
      let retVal=retVal+num1
#display "num1"
      let cnt=cnt+1
   end if  #valid innum
   if( num2 is not null and num2 > 0 )then
      let retVal=retVal+num2
#display "num2"
      let cnt=cnt+1
   end if  #valid innum
   if( num3 is not null and num3 > 0 )then
      let retVal=retVal+num3
#display "num3"
      let cnt=cnt+1
   end if  #valid innum
   if( num4 is not null and num4 > 0 )then
      let retVal=retVal+num4
#display "num4"
      let cnt=cnt+1
   end if  #valid innum
   if( num5 is not null and num5 > 0 )then
      let retVal=retVal+num5
#display "num5"
      let cnt=cnt+1
   end if  #valid innum
   if( num6 is not null and num6 > 0 )then
      let retVal=retVal+num6
#display "num6"
      let cnt=cnt+1
   end if  #valid innum
   if( num7 is not null and num7 > 0 )then
      let retVal=retVal+num7
#display "num7"
      let cnt=cnt+1
   end if  #valid innum

#display "cnt: ", cnt, " retVal: ", retVal
   if( cnt > 0)then
      let retVal=(retVal/cnt)
      if( retVal > 4.0 )then
         let retVal=4.0
      else
         if( retVal > 3.0 )then
            let retVal=4.0
         else
            if( retVal > 2.0 )then
               let retVal=3.0
            else
               if( retVal > 1.0 )then
                  let retVal=2.0
               else
                  if( retVal > 0.0 )then
                     let retVal=1.0
                  end if
               end if
            end if
         end if
      end if
   end if

   return retVal

end function  #addIfGood

function addIfGoodGeo( num1, num2, num3, num4, num5, num6, num7 )
define
   num1, num2, num3, num4, num5, num6, num7 char(1),
   retVal char(1)

   let retVal=' '
   if( num1='H' or num2='H' or num3='H' or num4='H' or num5='H' or num6='H' or num7='H' )then
      let retVal = 'H'
   else
      if( num1='Y' or num2='Y' or num3='Y' or num4='Y' or num5='Y' or num6='Y' or num7='Y' )then
         let retVal = 'Y'
      end if  #Y
   end if  #H

   return retVal

end function  #addIfGoodGeo

