
## September 04, 2017 John M. Shoemaker, revise AU tables, #255
## January   31, 2018 John M. Shoemaker jshoemaker1@cox.net, migrate to sales specialties, #300

database partners_na

globals
define
   G_SVPcnt smallint,
   V_Num char(5),
   V_Dt datetime year to second,
   URec record like coverage_nc.*,
   ARec record like coverage_nc.*,
   KRec record like skills_n1.*,
   LRec record like skills_n1.*,
   MRec record like skills_n1.*,
   NRec record like skills_n1.*,
   IRec record like iots.*,
   BRec record like brands.*,
   UNITRec record like units.*,
   UMgrRec record like unit_mgrs.*,
   SRec record like svp.*,
   VRec record like vap.*,
   CRec record like cross.*,
   TRec record like contacts_nc.*,
   CtlRec record like control.*,
   MasterRec record like master.*,
   G_CrossAvail smallint,
   G_ContactCnt smallint,
   GSkillDt like skills_n1.updtime,
   BrandArr array[70] of record 
      b_id like brands.b_id,
      b_name like brands.b_name,
      b_ord like brands.b_ord,
      b_menu like brands.b_menu,
      b_link like brands.b_link,
      sales_mgr like brands.sales_mgr,
      tech_mgr like brands.tech_mgr
   end record,
   BUArr array[70] of
   record
      b_brand like bus.b_brand,
      b_imt like bus.imt,
      b_id like bus.b_id,
      b_name like bus.b_name,
      b_ssr like bus.b_ssr,
      b_ctp like bus.b_ctp
   end record,
   RegionArr array[10] of record like region.*,
   G_Regioncnt smallint,
   EUArr array[30] of record like eus.*,
   G_EUcnt smallint,
   EUColNamesArr array[30] of
   record
      idx like _eucolnames.idx,
      colname like _eucolnames.colname
   end record,
   G_NumCols smallint,
   G_MKcnt smallint,
   MKArr array[10] of record like market.*,
   INDArr array[25] of record like industry.*,
   G_INDcnt smallint,
   INDColNamesArr array[30] of record like _ind_colname.*,
   G_INDNumCols smallint,
   SVPArr array[50] of
   record
      s_brand like svp.s_brand,
      s_id like svp.s_id,
      s_name like svp.s_name,
      bptv_name like svp.bptv_name,
      comp_name like svp.comp_name,
      svp_name like svp.svp_name,
      flag smallint
   end record,
   SVPInfoArr array[50] of
   record
      prod_grp_desc like svp_info.prod_grp_desc,
      svp_name like svp.svp_name,
      comp_name like svp.comp_name,
      prod_grp_stat like svp_info.prod_grp_stat,
      s_id like svp.s_id
   end record,
   G_SVPinfocnt smallint,
   RepArr array[100] of
   record
      ssr      like reps.r_name,
      ssr_link like reps.r_link,
      ctp      like reps.r_name,
      ctp_link like reps.r_link
    end record,
   RepArr2 array[100] of
   record
      b_brand  like bus.b_brand,
      ssr      like reps.r_name,
      ssr_link like reps.r_link,
      ctp      like reps.r_name,
      ctp_link like reps.r_link
    end record,
    CLRec record
       db char(20),
       iot like iots.i_id,
       brand like brands.b_id,
       CEID like coverage_nc.ceid
    end record,
    SkillArr array[70] of
    record 
       c_id like skill.c_id,
       s_num like skill.s_num,
       db_num like skill.db_num,
       s_name like skill.s_name,
       s_desc like skill.s_desc
       end record,
    SkillArrU array[70,70] of
    record 
       c_id like skill.c_id,
       s_num like skill.s_num,
       db_num like skill.db_num,
       s_name like skill.s_name,
       s_desc like skill.s_desc
    end record,
    SkillCatArr array[30] of record like skill_cat.*,
    BPSkillsArr array[90] of smallint,
    SkillArrAll array[1800] of 
    record
       b_id like skill.b_id,
       s_num like skill.s_num,
       db_num like skill.db_num,
       s_name like skill.s_name,
       s_desc like skill.s_desc
    end record,
    AccArr array[10] of
    record
       a_brand like accreditation.a_brand,
       ceid like accreditation.ceid,
       level like accreditation.level,
       target like accreditation.target,
       a_dt like accreditation.a_dt
    end record,
    G_Acccnt smallint,
    G_AccList char(512),
    BPTVRec record like nbptv.*,
    BPTVArr array[20] of
       record
          rag like nbptv_parts.rag,
          rag_alt like svp.s_name,
          bptv_01 like nbptv_parts.bptv_01,
          people_01 like nbptv_parts.people_01,
          nlrev_01 like nbptv_parts.nlrev_01,
          nlrev_02 like nbptv_parts.nlrev_01,
          vrrev_01 like nbptv_parts.vrrev_01,
          vrrev_02 like nbptv_parts.vrrev_01
       end record,
    VAPArr array[100] of record like vap.*,
    SolutionArr array[100] of record like solutions.*,
    ContactArr array[100] of record like contacts_nc.*,
    CertArr array[1000] of 
       record 
          prod_group like certs.prod_group,
          comp_name like certs.comp_name,
          cert_type like certs.cert_type,
          cert_num like certs.cert_num,
          cert_desc like certs.cert_desc,
          sunset_dt like certs.sunset_dt,
          cnt smallint
       end record,
    G_COMPcnt, G_COMP2cnt smallint,
    CertMax, G_CertCnt smallint,
    CompArr array[100] of
       record
          bu like competency.bu,
          comp_name like competency.comp_name,
          achieved_level like competency.achieved_level,
          sols like competency.sols,
          rev_norm_curr_yr like competency.rev_norm_curr_yr,
          rev_curr_resale_yr like competency.rev_curr_resale_yr,
          rev_curr_influence_yr like competency.rev_curr_influence_yr,
          rev_curr_xaas_yr like competency.rev_curr_xaas_yr,
          spec_prog_pct like competency.spec_prog_pct,
          exp_prog_pct like competency.spec_prog_pct,
          gsd_indicator integer
       end record,
    Comp2Arr array[100] of
       record
          bu like competency.bu,
          comp_name like competency.comp_name
       end record,
    G_FeatSols smallint,   #global - number of featured solutions
    FSArr array[100] of record like featsols.*,
    ShowVAPFlg smallint,
    ShowCrossFlg smallint,
    PODInfoArr array[10] of record like pod_info.*,
    PODArr array[100] of record like pod.*,
    G_VAPcnt smallint,
    ActiveBrand array[70] of smallint,
    ProductionBrand array[70] of smallint,
    brand_au, brand_su, brand_bu, brand_st, brand_io smallint,
    brand_cu, brand_es, brand_wu smallint,
    brand_hw, brand_nc smallint, 
    brand_mc, brand_md, brand_mf, brand_mi, brand_mp smallint,

    brand_ws, brand_im, brand_ti, brand_ra, brand_lo smallint,
    brand_ba, brand_se, brand_is, brand_sc, brand_em smallint,
    brand_ou smallint,
    brand_i1, brandi2, brandi3,
    SkillsMax, SkillsMaxU, SkillsMaxAll smallint,
    colorArr array[10] of char(7),

    ShowHVP smallint,
    bprStr, tssStr, allianceBPRStr, allianceCTPStr, switaStr, sprStr, sprHWStr, sprHWPWStr, rpcrStr, ptaStr, ptaHWStr, pcrStr, pcrHWStr  char(30),
    cov_tab char(25),
    skill_tab char(25),
    success_tab char(25),
    cont_tab char(25),
    RevBox smallint,
    RevFlg smallint,
    SplitFlg smallint,
    PplFlg smallint,
    CertFlg smallint,
    ShowBrands smallint,
    ShowTop smallint,
    EUsFlg smallint,
    CTPPairFlg smallint,
    G_ActiveColor, G_InactiveColor, G_TextColor char(16),
    G_DebugFlg smallint,
    G_eudropbox smallint,  
    G_production smallint, 
    G_skill_cat smallint,  
    G_add_contacts smallint,
    G_url like control.url,
    G_eucontacts like control.cflg1,
    G_includeskills like control.cflg2,
    G_UnitMode like control.unitmode,
    UpdateAllow smallint


end globals

