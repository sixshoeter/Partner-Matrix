
DBSCHEMA Schema Utility       INFORMIX-SQL Version 12.10.FC7
grant dba to "informix";
grant connect to "root";
grant connect to "public";









{ TABLE "informix".reps row size = 174 number of columns = 4 index size = 59 }

create table "informix".reps 
  (
    r_name char(20),
    r_link char(150),
    r_type char(2),
    b_id char(2)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".reps from "public" as "informix";

{ TABLE "informix".vads row size = 115 number of columns = 4 index size = 15 }

create table "informix".vads 
  (
    vad_ceid char(10),
    v_id char(10),
    v_name char(35),
    v_link char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".vads from "public" as "informix";

{ TABLE "informix".iots row size = 93 number of columns = 3 index size = 0 }

create table "informix".iots 
  (
    i_id char(3),
    i_name char(30),
    i_link char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".iots from "public" as "informix";

{ TABLE "informix".bus row size = 68 number of columns = 6 index size = 7 }

create table "informix".bus 
  (
    b_brand char(2),
    imt char(4),
    b_id smallint,
    b_name char(20),
    b_ssr char(20),
    b_ctp char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".bus from "public" as "informix";

{ TABLE "informix".cov_ws row size = 175 number of columns = 35 index size = 0 }

create table "informix".cov_ws 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    ssr char(20),
    bu char(25),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    bu_midwest char(1),
    bu_pacifics char(1),
    bu_greatwest char(1),
    bu_southeast char(1),
    bu_midatl char(1),
    bu_ny char(1),
    bu_northeast char(1),
    bu_grtlakes char(1),
    bu_canada char(1),
    bu_federal char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".cov_ws from "public" as "informix";

{ TABLE "informix".svp row size = 174 number of columns = 6 index size = 167 }

create table "informix".svp 
  (
    s_brand char(2),
    s_id char(2),
    s_name char(20),
    bptv_name char(50),
    comp_name char(50),
    svp_name char(50)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".svp from "public" as "informix";

{ TABLE "informix".brands row size = 204 number of columns = 7 index size = 14 }

create table "informix".brands 
  (
    b_id char(2),
    b_name char(50),
    b_ord smallint,
    b_menu char(30),
    b_link char(60),
    sales_mgr char(30),
    tech_mgr char(30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".brands from "public" as "informix";

{ TABLE "informix".skill row size = 138 number of columns = 6 index size = 11 }

create table "informix".skill 
  (
    b_id char(2),
    c_id smallint,
    s_num smallint,
    db_num smallint,
    s_name char(30),
    s_desc char(100)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".skill from "public" as "informix";

{ TABLE "informix".bptv_parts row size = 49 number of columns = 8 index size = 31 }

create table "informix".bptv_parts 
  (
    ceid char(10),
    brand char(3),
    rag char(13),
    bptv_01 smallint,
    svp_01 char(3),
    people_01 smallint,
    nlrev_01 float,
    vrrev_01 float
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".bptv_parts from "public" as "informix";

{ TABLE "informix".bptv row size = 478 number of columns = 28 index size = 15 }

create table "informix".bptv 
  (
    ceid char(10),
    iot char(3),
    imt char(10),
    country char(15),
    state char(2),
    cnt smallint,
    part_name char(60),
    pw_level char(3),
    value_pack char(3),
    vad char(10),
    ssr_bp char(20),
    ssr_ba char(20),
    ssr_im char(20),
    ssr_is char(20),
    ssr_lo char(20),
    ssr_ra char(20),
    ssr_ss char(20),
    ssr_ti char(20),
    ssr_ws char(20),
    swita char(20),
    ctp_ws char(20),
    ctp_ba char(20),
    ctp_ics char(20),
    ctp_im char(20),
    ctp_is char(20),
    ctp_ra char(20),
    ctp_ti char(20),
    ctp_sec char(20)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".bptv from "public" as "informix";

{ TABLE "informix".part_details_im row size = 2343 number of columns = 10 index size = 0 }

create table "informix".part_details_im 
  (
    ceid char(10),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_phone char(30),
    p_email char(30),
    focus1 char(15),
    focus2 char(15),
    focus3 char(15)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".part_details_im from "public" as "informix";

{ TABLE "informix".part_details_ws row size = 2343 number of columns = 10 index size = 15 }

create table "informix".part_details_ws 
  (
    ceid char(10),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_phone char(30),
    p_email char(30),
    focus1 char(15),
    focus2 char(15),
    focus3 char(15)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".part_details_ws from "public" as "informix";

{ TABLE "informix".industry row size = 84 number of columns = 5 index size = 9 }

create table "informix".industry 
  (
    i_brand char(2),
    i_id smallint,
    i_short char(10),
    i_name char(35),
    ig_name char(35)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".industry from "public" as "informix";

{ TABLE "informix".load_hist row size = 83 number of columns = 5 index size = 0 }

create table "informix".load_hist 
  (
    lh_imt char(10),
    lh_brand char(3),
    lh_date datetime year to second,
    lh_file char(60),
    lh_num smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".load_hist from "public" as "informix";

{ TABLE "informix".accreditation row size = 66 number of columns = 5 index size = 67 }

create table "informix".accreditation 
  (
    a_brand char(2),
    ceid char(10),
    level char(10),
    target char(40),
    a_dt date
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".accreditation from "public" as "informix";

{ TABLE "informix".imts row size = 34 number of columns = 2 index size = 0 }

create table "informix".imts 
  (
    imt char(4),
    i_name char(30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".imts from "public" as "informix";

{ TABLE "informix".capability_ibm row size = 40 number of columns = 2 index size = 0 }

create table "informix".capability_ibm 
  (
    ceid char(10),
    c_name char(30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".capability_ibm from "public" as "informix";

{ TABLE "informix".capability row size = 92 number of columns = 3 index size = 0 }

create table "informix".capability 
  (
    c_num smallint,
    c_name char(30),
    c_desc char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".capability from "public" as "informix";

{ TABLE "informix".tbptv row size = 220 number of columns = 14 index size = 124 }

create table "informix".tbptv 
  (
    iot char(3),
    imt char(10),
    country char(15),
    ceid char(10),
    part_name char(60),
    vad_ceid char(10),
    vad char(35),
    pw_level char(3),
    rag char(50),
    revdt date,
    bptv_01 smallint,
    people_01 smallint,
    nlrev_01 float,
    vrrev_01 float
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".tbptv from "public" as "informix";

{ TABLE "informix".nbptv row size = 41 number of columns = 5 index size = 28 }

create table "informix".nbptv 
  (
    ceid char(10),
    iot char(3),
    imt char(10),
    country char(15),
    pw_level char(3)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".nbptv from "public" as "informix";

{ TABLE "informix".nbptv_parts row size = 84 number of columns = 7 index size = 0 }

create table "informix".nbptv_parts 
  (
    ceid char(10),
    rag char(50),
    revdt date,
    bptv_01 smallint,
    people_01 smallint,
    nlrev_01 float,
    vrrev_01 float
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".nbptv_parts from "public" as "informix";

{ TABLE "informix".success_ti row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_ti 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_ti from "public" as "informix";

{ TABLE "informix".ntest row size = 84 number of columns = 7 index size = 0 }

create table "informix".ntest 
  (
    ceid char(10),
    rag char(50),
    revdt date,
    bptv_01 smallint,
    people_01 smallint,
    nlrev_01 float,
    vrrev_01 float
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".ntest from "public" as "informix";

{ TABLE "informix".skills_ti row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_ti 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_ti from "public" as "informix";

{ TABLE "informix".success_ra row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_ra 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_ra from "public" as "informix";

{ TABLE "informix".access row size = 151 number of columns = 3 index size = 0 }

create table "informix".access 
  (
    ip char(15),
    dttm datetime year to second,
    target char(128)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".access from "public" as "informix";

{ TABLE "informix".success_lo row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_lo 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_lo from "public" as "informix";

{ TABLE "informix".skills_lo row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_lo 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_lo from "public" as "informix";

{ TABLE "informix".coverage_lo_old row size = 2538 number of columns = 43 index size = 0 }

create table "informix".coverage_lo_old 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    bu_midwest char(1),
    bu_pacifics char(1),
    bu_greatwest char(1),
    bu_southeast char(1),
    bu_midatl char(1),
    bu_ny char(1),
    bu_northeast char(1),
    bu_grtlakes char(1),
    bu_canada char(1),
    bu_federal char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30)
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_lo_old from "public" as "informix";

{ TABLE "informix".oldcoverage_ra row size = 2546 number of columns = 44 index size = 0 }

create table "informix".oldcoverage_ra 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    bu_midwest char(1),
    bu_pacifics char(1),
    bu_greatwest char(1),
    bu_southeast char(1),
    bu_midatl char(1),
    bu_ny char(1),
    bu_northeast char(1),
    bu_grtlakes char(1),
    bu_canada char(1),
    bu_federal char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".oldcoverage_ra from "public" as "informix";

{ TABLE "informix".skills_ra row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_ra 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_ra from "public" as "informix";

{ TABLE "informix".fail row size = 524 number of columns = 3 index size = 0 }

create table "informix".fail 
  (
    brand char(2),
    ceid char(10),
    detail char(512)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".fail from "public" as "informix";

{ TABLE "informix".skills_ba row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_ba 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_ba from "public" as "informix";

{ TABLE "informix".success_ba row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_ba 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_ba from "public" as "informix";

{ TABLE "informix".success_se row size = 394 number of columns = 3 index size = 0 }

create table "informix".success_se 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_se from "public" as "informix";

{ TABLE "informix".skills_is row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_is 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_is from "public" as "informix";

{ TABLE "informix".certs_old row size = 435 number of columns = 22 index size = 0 }

create table "informix".certs_old 
  (
    iot char(3),
    region char(6),
    country char(20),
    ceid char(10),
    part_name char(60),
    loc_ceid char(10),
    loc_part_name char(60),
    city char(20),
    state char(2),
    cert_type_cd char(8),
    cert_desc char(100),
    cert_type char(9),
    brand char(3),
    b_prod_group char(30),
    prod_group char(30),
    achive_dt date,
    current_qtr char(1),
    report_dt date,
    master_vad char(35),
    count_yn char(1),
    expire_dt date,
    withdrawn char(15)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".certs_old from "public" as "informix";

{ TABLE "informix".coverage_ws_preeus row size = 2538 number of columns = 43 index size = 0 }

create table "informix".coverage_ws_preeus 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    bu_midwest char(1),
    bu_pacifics char(1),
    bu_greatwest char(1),
    bu_southeast char(1),
    bu_midatl char(1),
    bu_ny char(1),
    bu_northeast char(1),
    bu_grtlakes char(1),
    bu_canada char(1),
    bu_federal char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30)
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_ws_preeus from "public" as "informix";

{ TABLE "informix".eus row size = 109 number of columns = 7 index size = 131 }

create table "informix".eus 
  (
    e_brand char(2),
    e_region char(20),
    e_id smallint,
    e_name char(25),
    e_ssr char(20),
    e_ctp char(20),
    e_pcr char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".eus from "public" as "informix";

{ TABLE "informix".coverage_im_preeus row size = 2538 number of columns = 43 index size = 0 }

create table "informix".coverage_im_preeus 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    bu_midwest char(1),
    bu_pacifics char(1),
    bu_greatwest char(1),
    bu_southeast char(1),
    bu_midatl char(1),
    bu_ny char(1),
    bu_northeast char(1),
    bu_grtlakes char(1),
    bu_canada char(1),
    bu_federal char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30)
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_im_preeus from "public" as "informix";

{ TABLE "informix".skills_im row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_im 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_im from "public" as "informix";

{ TABLE "informix".success_im row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_im 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_im from "public" as "informix";

{ TABLE "informix".coverage_im row size = 2631 number of columns = 61 index size = 15 }

create table "informix".coverage_im 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".coverage_im from "public" as "informix";

{ TABLE "informix"._eucolnames row size = 22 number of columns = 2 index size = 0 }

create table "informix"._eucolnames 
  (
    idx smallint,
    colname char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._eucolnames from "public" as "informix";

{ TABLE "informix".coverage_ws row size = 2632 number of columns = 62 index size = 65 }

create table "informix".coverage_ws 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".coverage_ws from "public" as "informix";

{ TABLE "informix".skills_ws row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_ws 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_ws from "public" as "informix";

{ TABLE "informix".success_ws row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_ws 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_ws from "public" as "informix";

{ TABLE "informix".sysmenus row size = 78 number of columns = 2 index size = 23 }

create table "informix".sysmenus 
  (
    menuname char(18),
    title char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".sysmenus from "public" as "informix";

{ TABLE "informix".sysmenuitems row size = 143 number of columns = 5 index size = 27 }

create table "informix".sysmenuitems 
  (
    imenuname char(18),
    itemnum integer,
    mtext char(60),
    mtype char(1),
    progname char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".sysmenuitems from "public" as "informix";

{ TABLE "informix".coverage_ti row size = 2601 number of columns = 60 index size = 15 }

create table "informix".coverage_ti 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_ti from "public" as "informix";

{ TABLE "informix".coverage_ra row size = 2631 number of columns = 61 index size = 65 }

create table "informix".coverage_ra 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_ra from "public" as "informix";

{ TABLE "informix".coverage_lo row size = 2631 number of columns = 61 index size = 65 }

create table "informix".coverage_lo 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 2014 next size 2014 lock mode row;

revoke all on "informix".coverage_lo from "public" as "informix";

{ TABLE "informix".control row size = 2006 number of columns = 110 index size = 7 }

create table "informix".control 
  (
    brand char(2),
    debug char(1),
    url char(100),
    menu_str char(30),
    cov_tab char(15),
    skill_tab1 char(15),
    skill_tab2 char(15),
    skill_tab3 char(15),
    skill_tab4 char(15),
    skill_tab5 char(15),
    skill_tab6 char(15),
    skill_tab7 char(15),
    skill_tab8 char(15),
    skill_tab9 char(15),
    skill_tab10 char(15),
    skill_tab11 char(15),
    skill_tab12 char(15),
    success_tab char(15),
    cont_tab char(15),
    coverextend_tab char(15),
    act_tab char(15),
    act_init_tab char(15),
    fcast_tab char(15),
    inactive_color char(16),
    text_color char(16),
    bg_color char(16),
    revbox char(1),
    revflg char(1),
    splitflg char(1),
    pplflg char(1),
    certflg char(1),
    showbrands char(1),
    showhvp char(1),
    showtop char(1),
    eusflg char(1),
    bpr_ltext char(30),
    bpr_stext char(10),
    tss_ltext char(30),
    tss_stext char(10),
    regiononly char(1),
    ctppairflg char(1),
    showvapflg char(1),
    showcrossflg char(1),
    active_brand char(1),
    eudropbox char(1),
    production char(1),
    skill_cat char(1),
    active_color char(16),
    add_contacts char(1),
    refer_text char(50),
    refer_url char(80),
    cflg1 char(1),
    cflg2 char(1),
    cflg3 char(1),
    cflg4 char(1),
    cflg5 char(1),
    showsolutions char(1),
    unitmode char(1),
    expandbrand char(1),
    showgeo char(1),
    seg char(1),
    useaca char(1),
    usesimple char(1),
    useranking char(1),
    newindustry char(1),
    bptvflg char(1),
    onlyshowaca char(1),
    altercover char(1),
    showhunter char(1),
    showcommercial char(1),
    showenterprisealign char(1),
    showindustryalign char(1),
    nosvp char(1),
    showgsi char(1),
    showctplabel char(1),
    showswita char(1),
    showspr char(1),
    showzrep char(1),
    showpcr char(1),
    showflash char(1),
    showpta char(1),
    showstoragecerts char(1),
    searchvad char(1),
    searchdesc char(1),
    showpartnerswell char(1),
    showextend_st char(1),
    showtarget char(1),
    showalliance char(1),
    showcaprov char(1),
    showindustry char(1),
    show_cio char(1),
    showcompetency char(1),
    showcompwithnorev char(1),
    showlap char(1),
    showplanning char(1),
    showdfm char(1),
    showcerts char(1),
    showupdtop char(1),
    allowdownload char(1),
    showreview char(1),
    showssrsearch char(1),
    showfeatsols char(1),
    showaltskills char(1),
    showelite char(1),
    showdescimg char(1),
    skillsearchstart char(1),
    use_reps char(1),
    tss_str char(40),
    home_msg char(400),
    instr char(800)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".control from "public" as "informix";

{ TABLE "pw_level".pw_level row size = 5 number of columns = 2 index size = 0 }

create table "pw_level".pw_level 
  (
    level char(3),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "pw_level".pw_level from "public" as "pw_level";

{ TABLE "informix".cross row size = 298 number of columns = 14 index size = 15 }

create table "informix".cross 
  (
    ceid char(10),
    part_name char(60),
    swita char(20),
    spr char(20),
    spr_hw char(20),
    spr_power char(20),
    zrep char(20),
    pcr char(20),
    flash char(20),
    pta char(20),
    pta_hw char(20),
    alliance_bpr char(20),
    alliance_ctp char(20),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".cross from "public" as "informix";

{ TABLE "informix".skills_em row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_em 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_em from "public" as "informix";

{ TABLE "informix".skills_sc row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_sc 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_sc from "public" as "informix";

{ TABLE "informix".coverage_is row size = 2632 number of columns = 62 index size = 65 }

create table "informix".coverage_is 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_is from "public" as "informix";

{ TABLE "informix".coverage_em row size = 2631 number of columns = 61 index size = 65 }

create table "informix".coverage_em 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_em from "public" as "informix";

{ TABLE "informix".coverage_sc row size = 2631 number of columns = 61 index size = 65 }

create table "informix".coverage_sc 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_sc from "public" as "informix";

{ TABLE "informix".success_em row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_em 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_em from "public" as "informix";

{ TABLE "informix".success_sc row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_sc 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_sc from "public" as "informix";

{ TABLE "informix".success_is row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_is 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".success_is from "public" as "informix";

{ TABLE "informix".coverage_ba row size = 2631 number of columns = 61 index size = 65 }

create table "informix".coverage_ba 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp char(20),
    svp_01 char(1),
    svp_02 char(1),
    svp_03 char(1),
    svp_04 char(1),
    svp_05 char(1),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_rockies char(1),
    eu_chicago char(1),
    eu_minn char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_gulf char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_northeast char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_ca_industry char(1),
    eu_ca_enterprise char(1),
    eu_ca_midmarket char(1),
    eu_fed_civ char(1),
    eu_fed_dod char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 512 next size 512 lock mode row;

revoke all on "informix".coverage_ba from "public" as "informix";

{ TABLE "informix"._worktab row size = 500 number of columns = 5 index size = 0 }

create table "informix"._worktab 
  (
    c1 char(100),
    c2 char(100),
    c3 char(100),
    c4 char(100),
    c5 char(100)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._worktab from "public" as "informix";

{ TABLE "informix".states row size = 22 number of columns = 2 index size = 7 }

create table "informix".states 
  (
    s_id char(2),
    s_name char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".states from "public" as "informix";

{ TABLE "informix".skill_cat row size = 74 number of columns = 4 index size = 9 }

create table "informix".skill_cat 
  (
    c_brand char(2),
    c_id smallint,
    c_short char(20),
    c_long char(50)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".skill_cat from "public" as "informix";

{ TABLE "informix".industry_auth row size = 82 number of columns = 3 index size = 0 }

create table "informix".industry_auth 
  (
    ia_id smallint,
    ia_short char(20),
    ia_desc char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".industry_auth from "public" as "informix";

{ TABLE "informix".field row size = 32 number of columns = 3 index size = 0 }

create table "informix".field 
  (
    b_id char(2),
    ceid char(10),
    ctp char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".field from "public" as "informix";

{ TABLE "informix"._t2 row size = 126 number of columns = 10 index size = 0 }

create table "informix"._t2 
  (
    ssr char(20),
    ctp char(20),
    part_name char(60),
    ceid char(10),
    hq char(2),
    vad char(10),
    s1 char(1),
    s2 char(1),
    s3 char(1),
    s4 char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._t2 from "public" as "informix";

{ TABLE "informix".midwest row size = 793 number of columns = 28 index size = 0 }

create table "informix".midwest 
  (
    part_name char(60),
    ceid char(10),
    exec char(30),
    bue char(30),
    sca_tsm char(30),
    sca_tss char(30),
    ws_tsm char(30),
    ws_tss char(30),
    iscs_tsm char(30),
    iscs_tss char(30),
    ics_tsm char(30),
    ics_tss char(30),
    ti_tsm char(30),
    ti_tss char(30),
    ra_tsm char(30),
    ra_tss char(30),
    se_tsm char(30),
    se_tss char(30),
    ba_tsm char(30),
    ba_tss char(30),
    em_tsm char(30),
    em_tss char(30),
    im_tsm char(30),
    im_tss char(30),
    z_tsm char(30),
    z_tss char(30),
    tmp char(1),
    num smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".midwest from "public" as "informix";

{ TABLE "informix".relations row size = 33 number of columns = 4 index size = 37 }

create table "informix".relations 
  (
    ceid char(10),
    b_id char(2),
    role char(1),
    r_name char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".relations from "public" as "informix";

{ TABLE "informix"._ics row size = 2230 number of columns = 75 index size = 0 }

create table "informix"._ics 
  (
    pa char(30),
    pb char(30),
    pc char(30),
    pd char(30),
    pe char(30),
    ceid char(10),
    pf char(30),
    pg char(30),
    ph char(30),
    p1 char(30),
    p2 char(30),
    p3 char(30),
    p4 char(30),
    p5 char(30),
    p6 char(30),
    p7 char(30),
    p8 char(30),
    p9 char(30),
    p10 char(30),
    p11 char(30),
    p12 char(30),
    p13 char(30),
    p14 char(30),
    i1 char(30),
    i2 char(30),
    i3 char(30),
    i4 char(30),
    i5 char(30),
    i6 char(30),
    i7 char(30),
    i8 char(30),
    i9 char(30),
    h1 char(30),
    h2 char(30),
    h3 char(30),
    o1 char(30),
    o2 char(30),
    o3 char(30),
    o4 char(30),
    o5 char(30),
    o6 char(30),
    o7 char(30),
    o8 char(30),
    o9 char(30),
    o10 char(30),
    c1 char(30),
    c2 char(30),
    c3 char(30),
    r1 char(30),
    r2 char(30),
    r3 char(30),
    r4 char(30),
    r5 char(30),
    r6 char(30),
    r7 char(30),
    r8 char(30),
    r9 char(30),
    r10 char(30),
    k1 char(30),
    k2 char(30),
    k3 char(30),
    k4 char(30),
    k5 char(30),
    k6 char(30),
    k7 char(30),
    k8 char(30),
    k9 char(30),
    k10 char(30),
    k11 char(30),
    k12 char(30),
    k13 char(30),
    k14 char(30),
    k15 char(30),
    k16 char(30),
    k17 char(30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._ics from "public" as "informix";

{ TABLE "informix".reg_eu_state row size = 47 number of columns = 3 index size = 0 }

create table "informix".reg_eu_state 
  (
    r_name char(20),
    e_name char(25),
    s_name char(2)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".reg_eu_state from "public" as "informix";

{ TABLE "informix".contacts row size = 197 number of columns = 8 index size = 92 }

create table "informix".contacts 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(40),
    e_brand char(2),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts from "public" as "informix";

{ TABLE "informix".contacts_lo row size = 205 number of columns = 7 index size = 0 }

create table "informix".contacts_lo 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_lo from "public" as "informix";

{ TABLE "informix".contacts_im row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_im 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_im from "public" as "informix";

{ TABLE "informix".contacts_ws row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_ws 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_ws from "public" as "informix";

{ TABLE "informix".contacts_ba row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_ba 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_ba from "public" as "informix";

{ TABLE "informix".contacts_se row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_se 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_se from "public" as "informix";

{ TABLE "informix".contacts_ti row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_ti 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_ti from "public" as "informix";

{ TABLE "informix".contacts_is row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_is 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_is from "public" as "informix";

{ TABLE "informix".contacts_ra row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_ra 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_ra from "public" as "informix";

{ TABLE "informix".contacts_em row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_em 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_em from "public" as "informix";

{ TABLE "informix".p2p row size = 348 number of columns = 21 index size = 0 }

create table "informix".p2p 
  (
    cust_name char(60),
    seg char(10),
    opp_no char(10),
    opp_name char(60),
    fcast_qtr char(2),
    bu char(22),
    country char(15),
    b_name char(3),
    prod_family char(40),
    sales_stage char(15),
    odds smallint,
    rev float,
    opp_val float,
    fcast_stat char(15),
    systemz char(1),
    opp_age smallint,
    owner char(40),
    bp_ceid char(10),
    ela char(1),
    p2p_score char(14),
    p2p_ceid char(10)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".p2p from "public" as "informix";

{ TABLE "informix".contacts_sc row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_sc 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_sc from "public" as "informix";

{ TABLE "informix".tmp_skill row size = 138 number of columns = 6 index size = 0 }

create table "informix".tmp_skill 
  (
    b_id char(2),
    c_id smallint,
    s_num smallint,
    db_num smallint,
    s_name char(30),
    s_desc char(100)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".tmp_skill from "public" as "informix";

{ TABLE "informix".tmp_skill_cat row size = 64 number of columns = 4 index size = 9 }

create table "informix".tmp_skill_cat 
  (
    c_brand char(2),
    c_id smallint,
    c_short char(10),
    c_long char(50)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".tmp_skill_cat from "public" as "informix";

{ TABLE "informix".old_vap row size = 1043 number of columns = 65 index size = 0 }

create table "informix".old_vap 
  (
    geo char(20),
    region char(20),
    country char(15),
    hc_country char(1),
    svp_country char(1),
    ceid char(10),
    part_name char(60),
    city char(20),
    st char(2),
    url char(50),
    vad_id char(10),
    vad_payer char(10),
    vap_id char(10),
    vap_app_status char(18),
    vap_sub_dt date,
    vap_stat_dt date,
    sol_id char(10),
    sol_name char(50),
    sol_area char(25),
    sol_status char(18),
    sol_sub_dt date,
    sol_status_dt date,
    va_type char(25),
    va_desc char(256),
    ops_contact char(40),
    comments char(256),
    linux char(1),
    ba_open char(1),
    cognos char(1),
    spss_stats char(1),
    sps_enter char(1),
    risk_analy char(1),
    ics_open char(1),
    collab_sol_msg char(1),
    collab_sol_port char(1),
    collab_sol_sswuc char(1),
    sc char(1),
    is_open char(1),
    b2b char(1),
    enter_mm char(1),
    filenet char(1),
    scities char(1),
    commerce char(1),
    im_open char(1),
    im_bd char(1),
    im_info char(1),
    im_optim char(1),
    im_data char(1),
    ra_open char(1),
    ra_auth char(1),
    sec_open char(1),
    sec_sys char(1),
    ti_open char(1),
    ti_ba char(1),
    ti_eam char(1),
    ti_storage char(1),
    ws_open char(1),
    eis char(1),
    ws_bpm char(1),
    ws_core char(1),
    watson char(1),
    watson_open char(1),
    other_open char(1),
    last_updt_by char(40),
    ts char(23)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".old_vap from "public" as "informix";

{ TABLE "informix".lastload row size = 46 number of columns = 3 index size = 31 }

create table "informix".lastload 
  (
    tabname char(18),
    desc char(20),
    datetm datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".lastload from "public" as "informix";

{ TABLE "informix".old_sws row size = 142 number of columns = 35 index size = 0 }

create table "informix".old_sws 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".old_sws from "public" as "informix";

{ TABLE "informix".brand_certs row size = 7 number of columns = 2 index size = 12 }

create table "informix".brand_certs 
  (
    b_id char(2),
    bc_id char(5)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".brand_certs from "public" as "informix";

{ TABLE "informix".brand_certs_det row size = 47 number of columns = 3 index size = 52 }

create table "informix".brand_certs_det 
  (
    b_id char(2),
    bc_id char(5),
    rag char(40)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".brand_certs_det from "public" as "informix";

{ TABLE "informix".coverage_au row size = 3025 number of columns = 79 index size = 182 }

create table "informix".coverage_au 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverage_au from "public" as "informix";

{ TABLE "informix".skills_au row size = 134 number of columns = 34 index size = 15 }

create table "informix".skills_au 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_au from "public" as "informix";

{ TABLE "informix".success_au row size = 394 number of columns = 3 index size = 144 }

create table "informix".success_au 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".success_au from "public" as "informix";

{ TABLE "informix".contacts_au row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_au 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_au from "public" as "informix";

{ TABLE "informix"._w row size = 78 number of columns = 8 index size = 0 }

create table "informix"._w 
  (
    ceid char(10),
    state char(2),
    part_name char(60),
    t1 char(1),
    t2 char(2),
    t3 char(1),
    t4 char(1),
    t5 char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._w from "public" as "informix";

{ TABLE "informix"._w2 row size = 40 number of columns = 2 index size = 0 }

create table "informix"._w2 
  (
    ceid char(10),
    mgr char(30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._w2 from "public" as "informix";

{ TABLE "informix"._auin row size = 197 number of columns = 7 index size = 0 }

create table "informix"._auin 
  (
    part_name char(50),
    mgr char(60),
    ssr char(40),
    ceid char(10),
    hq char(2),
    imt char(15),
    vad char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._auin from "public" as "informix";

{ TABLE "informix"._ac row size = 207 number of columns = 8 index size = 0 }

create table "informix"._ac 
  (
    lead char(5),
    part_name char(50),
    mgr char(50),
    ssr char(50),
    ceid char(10),
    hq char(2),
    imt char(20),
    vad char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._ac from "public" as "informix";

{ TABLE "informix"._aunew row size = 562 number of columns = 12 index size = 0 }

create table "informix"._aunew 
  (
    lead char(2),
    tier smallint,
    part_name char(80),
    mgr char(80),
    ssr char(80),
    ctpim char(80),
    ctpem char(80),
    ctpba char(80),
    ceid char(10),
    hq char(2),
    imt char(6),
    vad char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._aunew from "public" as "informix";

{ TABLE "informix".units row size = 484 number of columns = 13 index size = 0 }

create table "informix".units 
  (
    u_id char(2),
    u_name char(30),
    u_ord smallint,
    u_menu char(30),
    u_link char(60),
    sales_mgr1 char(30),
    sales_mgr1_scope char(60),
    sales_mgr2 char(30),
    sales_mgr2_scope char(60),
    tech_mgr1 char(30),
    tech_mgr1_scope char(60),
    tech_mgr2 char(30),
    tech_mgr2_scope char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".units from "public" as "informix";

{ TABLE "informix".unit_brand row size = 111 number of columns = 8 index size = 11 }

create table "informix".unit_brand 
  (
    u_id char(2),
    b_id char(2),
    ltr char(2),
    ord smallint,
    ordctp smallint,
    include_fap char(1),
    desc char(50),
    sdesc char(50)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".unit_brand from "public" as "informix";

{ TABLE "informix".unit_mgrs row size = 145 number of columns = 6 index size = 0 }

create table "informix".unit_mgrs 
  (
    u_id char(2),
    mgr_ord smallint,
    mgr_type char(1),
    mgr_name char(30),
    mgr_title char(50),
    mgr_scope char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".unit_mgrs from "public" as "informix";

{ TABLE "informix".coverage_su row size = 3025 number of columns = 79 index size = 172 }

create table "informix".coverage_su 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverage_su from "public" as "informix";

{ TABLE "informix".success_su row size = 394 number of columns = 3 index size = 144 }

create table "informix".success_su 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".success_su from "public" as "informix";

{ TABLE "informix".skills_su row size = 134 number of columns = 34 index size = 15 }

create table "informix".skills_su 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_su from "public" as "informix";

{ TABLE "informix"._sunew row size = 341 number of columns = 11 index size = 0 }

create table "informix"._sunew 
  (
    part_name char(50),
    ceid char(10),
    ebu char(50),
    ssr char(50),
    seg char(50),
    spr char(50),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    vad char(20),
    var char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._sunew from "public" as "informix";

{ TABLE "informix"._isnew row size = 210 number of columns = 4 index size = 0 }

create table "informix"._isnew 
  (
    ceid char(10),
    part_name char(80),
    ssr char(60),
    ctp char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._isnew from "public" as "informix";

{ TABLE "informix".skills_s1 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_s1 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_s1 from "public" as "informix";

{ TABLE "informix".skills_s2 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_s2 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_s2 from "public" as "informix";

{ TABLE "informix".skills_s3 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_s3 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_s3 from "public" as "informix";

{ TABLE "informix".skills_s4 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_s4 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_s4 from "public" as "informix";

{ TABLE "informix".skills_s5 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_s5 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_s5 from "public" as "informix";

{ TABLE "informix".contacts_su row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_su 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_su from "public" as "informix";

{ TABLE "informix"._ranew row size = 156 number of columns = 39 index size = 0 }

create table "informix"._ranew 
  (
    ceid char(10),
    vad char(14),
    hq char(2),
    part_name char(80),
    s1 smallint,
    s2 smallint,
    s3 smallint,
    s4 smallint,
    s5 smallint,
    s6 smallint,
    s7 smallint,
    s8 smallint,
    s9 smallint,
    s10 smallint,
    s11 smallint,
    s12 smallint,
    s13 smallint,
    s14 smallint,
    s15 smallint,
    pacnw char(1),
    northca char(1),
    southwest char(1),
    rockies char(1),
    chicago char(1),
    minn char(1),
    plains char(1),
    heart char(1),
    texas char(1),
    gulf char(1),
    ny char(1),
    garden char(1),
    northeast char(1),
    delaware char(1),
    potomac char(1),
    carolinas char(1),
    midamer char(1),
    ohio char(1),
    southeast char(1),
    sunshine char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._ranew from "public" as "informix";

{ TABLE "informix"._eucolnamesu row size = 22 number of columns = 2 index size = 7 }

create table "informix"._eucolnamesu 
  (
    idx smallint,
    colname char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._eucolnamesu from "public" as "informix";

{ TABLE "informix".skills_io row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_io 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_io from "public" as "informix";

{ TABLE "informix".feedback row size = 22 number of columns = 2 index size = 27 }

create table "informix".feedback 
  (
    b_id char(2),
    tsm char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".feedback from "public" as "informix";

{ TABLE "informix".segment_leaders row size = 99 number of columns = 4 index size = 25 }

create table "informix".segment_leaders 
  (
    b_id char(2),
    b_sort smallint,
    seg_lead char(20),
    seg_desc char(75)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".segment_leaders from "public" as "informix";

{ TABLE "informix".ind_colname row size = 30 number of columns = 2 index size = 0 }

create table "informix".ind_colname 
  (
    i_short char(10),
    i_col char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".ind_colname from "public" as "informix";

{ TABLE "informix".ind_group row size = 39 number of columns = 3 index size = 0 }

create table "informix".ind_group 
  (
    ig_brand char(2),
    ig_order smallint,
    ig_name char(35)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".ind_group from "public" as "informix";

{ TABLE "informix".coverage_cu row size = 3025 number of columns = 79 index size = 172 }

create table "informix".coverage_cu 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverage_cu from "public" as "informix";

{ TABLE "informix".align_brand row size = 26 number of columns = 3 index size = 0 }

create table "informix".align_brand 
  (
    u_id char(2),
    ab_id char(4),
    ab_name char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".align_brand from "public" as "informix";

{ TABLE "informix".align_subbrand row size = 50 number of columns = 4 index size = 0 }

create table "informix".align_subbrand 
  (
    u_id char(2),
    ab_id char(4),
    asb_id char(4),
    asb_name char(40)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".align_subbrand from "public" as "informix";

{ TABLE "informix".align_cat row size = 14 number of columns = 5 index size = 0 }

create table "informix".align_cat 
  (
    u_id char(2),
    ab_id char(4),
    asb_id char(4),
    c_brand char(2),
    c_id smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".align_cat from "public" as "informix";

{ TABLE "informix".tbptv_history row size = 224 number of columns = 16 index size = 73 }

create table "informix".tbptv_history 
  (
    q_year smallint,
    q_qtr smallint,
    iot char(3),
    imt char(10),
    country char(15),
    ceid char(10),
    part_name char(60),
    vad_ceid char(10),
    vad char(35),
    pw_level char(3),
    rag char(50),
    revdt date,
    bptv_01 smallint,
    people_01 smallint,
    nlrev_01 float,
    vrrev_01 float
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".tbptv_history from "public" as "informix";

{ TABLE "informix".skills_history row size = 148 number of columns = 38 index size = 21 }

create table "informix".skills_history 
  (
    q_year smallint,
    q_qtr smallint,
    q_brand char(2),
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_history from "public" as "informix";

{ TABLE "informix".coverage_bu row size = 3025 number of columns = 79 index size = 172 }

create table "informix".coverage_bu 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 2048 next size 2048 lock mode row;

revoke all on "informix".coverage_bu from "public" as "informix";

{ TABLE "informix".success_bu row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_bu 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".success_bu from "public" as "informix";

{ TABLE "informix".contacts_bu row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_bu 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_bu from "public" as "informix";

{ TABLE "informix".skills_co row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_co 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 300 next size 300 lock mode row;

revoke all on "informix".skills_co from "public" as "informix";

{ TABLE "informix".skills_bu row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_bu 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 300 next size 300 lock mode row;

revoke all on "informix".skills_bu from "public" as "informix";

{ TABLE "informix".segmentation row size = 16 number of columns = 2 index size = 6 }

create table "informix".segmentation 
  (
    seg_id char(1),
    seg_name char(15)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".segmentation from "public" as "informix";

{ TABLE "informix".success_cu row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_cu 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".success_cu from "public" as "informix";

{ TABLE "informix".contacts_cu row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_cu 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_cu from "public" as "informix";

{ TABLE "informix".skills_c1 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_c1 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_c1 from "public" as "informix";

{ TABLE "informix".tasks row size = 600 number of columns = 8 index size = 9 }

create table "informix".tasks 
  (
    task_num serial not null ,
    task_status char(1),
    task_title char(50),
    task_odt date,
    task_requestor char(25),
    task_desc char(256),
    task_cdt date,
    task_result char(256)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".tasks from "public" as "informix";

{ TABLE "informix".task_ord row size = 3 number of columns = 2 index size = 0 }

create table "informix".task_ord 
  (
    task_status char(1),
    task_ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".task_ord from "public" as "informix";

{ TABLE "informix".coverage_ou row size = 2961 number of columns = 58 index size = 172 }

create table "informix".coverage_ou 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    updtime datetime year to second
  ) extent size 2048 next size 2048 lock mode row;

revoke all on "informix".coverage_ou from "public" as "informix";

{ TABLE "informix".certsoldna row size = 341 number of columns = 15 index size = 0 }

create table "informix".certsoldna 
  (
    geo char(15),
    region char(20),
    country char(20),
    ww_ent_id char(10),
    ceid char(10),
    part_name char(60),
    cert_type char(9),
    cert_num char(8),
    cert_desc char(100),
    person_num char(20),
    achieve_dt char(10),
    report_dt char(10),
    sunset_dt date,
    prod_group char(40),
    brand char(5)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".certsoldna from "public" as "informix";

{ TABLE "informix".in_cloud row size = 3950 number of columns = 73 index size = 0 }

create table "informix".in_cloud 
  (
    a char(50),
    b char(50),
    c char(50),
    d char(50),
    e char(200),
    f char(200),
    g char(50),
    h char(50),
    i char(50),
    j char(50),
    k char(50),
    l char(50),
    m char(50),
    n char(50),
    o char(50),
    p char(50),
    q char(50),
    r char(50),
    s char(50),
    t char(50),
    u char(50),
    v char(50),
    w char(50),
    x char(50),
    y char(50),
    z char(50),
    aa char(50),
    ab char(50),
    ac char(50),
    ad char(50),
    ae char(50),
    af char(50),
    ag char(50),
    ah char(50),
    ai char(50),
    aj char(50),
    ak char(50),
    al char(50),
    am char(50),
    an char(50),
    ao char(50),
    ap char(50),
    aq char(50),
    ar char(50),
    as char(50),
    at char(50),
    au char(50),
    av char(50),
    aw char(50),
    ax char(50),
    ay char(50),
    az char(50),
    ba char(50),
    bb char(50),
    bc char(50),
    bd char(50),
    be char(50),
    bf char(50),
    bg char(50),
    bh char(50),
    bi char(50),
    bj char(50),
    bk char(50),
    bl char(50),
    bm char(50),
    bn char(50),
    bo char(50),
    bp char(50),
    bq char(50),
    br char(50),
    bs char(50),
    bt char(50),
    bu char(50)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".in_cloud from "public" as "informix";

{ TABLE "informix".skills_gba row size = 156 number of columns = 36 index size = 37 }

create table "informix".skills_gba 
  (
    ceid char(10) not null ,
    e_region char(20),
    e_id smallint,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_gba from "public" as "informix";

{ TABLE "informix".coverage_st row size = 3025 number of columns = 79 index size = 115 }

create table "informix".coverage_st 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverage_st from "public" as "informix";

{ TABLE "informix".skills_sw row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_sw 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_sw from "public" as "informix";

{ TABLE "informix".success_st row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_st 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".success_st from "public" as "informix";

{ TABLE "informix".contacts_st row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_st 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_st from "public" as "informix";

{ TABLE "informix".coverage_es row size = 3025 number of columns = 79 index size = 115 }

create table "informix".coverage_es 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverage_es from "public" as "informix";

{ TABLE "informix".skills_es row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_es 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_es from "public" as "informix";

{ TABLE "informix".contacts_es row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_es 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_es from "public" as "informix";

{ TABLE "informix".success_es row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_es 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".success_es from "public" as "informix";

{ TABLE "informix".coverage_wu row size = 3025 number of columns = 79 index size = 115 }

create table "informix".coverage_wu 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverage_wu from "public" as "informix";

{ TABLE "informix".skills_wu row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_wu 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_wu from "public" as "informix";

{ TABLE "informix".contacts_wu row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_wu 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_wu from "public" as "informix";

{ TABLE "informix".success_wu row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_wu 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".success_wu from "public" as "informix";

{ TABLE "informix".solutions row size = 834 number of columns = 18 index size = 25 }

create table "informix".solutions 
  (
    iot char(20),
    imt char(10),
    country_grp char(15),
    country char(15),
    brand char(10),
    delivery char(10),
    class_level char(25),
    targ_ind char(25),
    sector char(75),
    part_name char(60),
    ceid char(10),
    vad_id char(10),
    sol_name char(100),
    bus_app char(75),
    desc char(256),
    gsd char(100),
    asset_type char(10),
    part_type char(8)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".solutions from "public" as "informix";

{ TABLE "informix".coverage_io row size = 3025 number of columns = 79 index size = 115 }

create table "informix".coverage_io 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverage_io from "public" as "informix";

{ TABLE "informix".success_io row size = 394 number of columns = 3 index size = 15 }

create table "informix".success_io 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".success_io from "public" as "informix";

{ TABLE "informix".contacts_io row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_io 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".contacts_io from "public" as "informix";

{ TABLE "informix".skills_cu row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_cu 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_cu from "public" as "informix";

{ TABLE "informix".region row size = 40 number of columns = 4 index size = 53 }

create table "informix".region 
  (
    e_iot char(3),
    e_region char(20),
    e_short char(15),
    e_ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".region from "public" as "informix";

{ TABLE "informix".import1 row size = 412 number of columns = 5 index size = 0 }

create table "informix".import1 
  (
    ceid char(10),
    part_name char(100),
    hq char(2),
    url char(200),
    vad char(100)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".import1 from "public" as "informix";

{ TABLE "informix".svp_sol_auth row size = 27 number of columns = 2 index size = 0 }

create table "informix".svp_sol_auth 
  (
    svp_auth char(25),
    s_ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".svp_sol_auth from "public" as "informix";

{ TABLE "informix".inst2 row size = 232 number of columns = 8 index size = 0 }

create table "informix".inst2 
  (
    part_name char(60),
    ceid char(10),
    loc char(40),
    vad char(20),
    part_type char(1),
    ssr char(50),
    ctp char(50),
    tmp char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".inst2 from "public" as "informix";

{ TABLE "informix".iness2 row size = 210 number of columns = 5 index size = 0 }

create table "informix".iness2 
  (
    ssr char(50),
    ctp char(50),
    region char(50),
    part_name char(50),
    ceid char(10)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".iness2 from "public" as "informix";

{ TABLE "informix".coverage_se row size = 3025 number of columns = 79 index size = 115 }

create table "informix".coverage_se 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverage_se from "public" as "informix";

{ TABLE "informix".skills_se row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_se 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_se from "public" as "informix";

{ TABLE "informix".ssrtab row size = 44 number of columns = 3 index size = 25 }

create table "informix".ssrtab 
  (
    ssr char(20),
    ew char(4),
    ssrtype char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".ssrtab from "public" as "informix";

{ TABLE "informix".skills_b1 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_b1 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_b1 from "public" as "informix";

{ TABLE "informix".skills_b2 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_b2 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_b2 from "public" as "informix";

{ TABLE "informix".skills_b3 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_b3 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_b3 from "public" as "informix";

{ TABLE "informix".skills_b4 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_b4 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_b4 from "public" as "informix";

{ TABLE "informix".tmp_incom row size = 102 number of columns = 5 index size = 0 }

create table "informix".tmp_incom 
  (
    ceid char(10),
    part_name char(50),
    ssr char(20),
    ctp char(20),
    tmp smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".tmp_incom from "public" as "informix";

{ TABLE "informix".upd_log row size = 46 number of columns = 3 index size = 0 }

create table "informix".upd_log 
  (
    b_id char(2),
    datetime char(14),
    email_id char(30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".upd_log from "public" as "informix";

{ TABLE "informix".in_wat row size = 339 number of columns = 18 index size = 0 }

create table "informix".in_wat 
  (
    geo char(20),
    part_type char(1),
    ssr char(30),
    region char(30),
    country char(30),
    ceid char(10),
    part_name char(50),
    s1 char(1),
    s2 char(1),
    s3 char(1),
    s4 char(1),
    s5 char(1),
    s6 char(1),
    hq char(2),
    url char(100),
    vad char(20),
    note char(20),
    pg char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".in_wat from "public" as "informix";

{ TABLE "informix".in_cu row size = 190 number of columns = 8 index size = 0 }

create table "informix".in_cu 
  (
    part_name char(50),
    p_type char(15),
    ceid char(10),
    febmrr char(20),
    ssr char(30),
    imt char(30),
    cmrnum char(20),
    covid char(15)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".in_cu from "public" as "informix";

{ TABLE "informix".storage_cert row size = 241 number of columns = 18 index size = 70 }

create table "informix".storage_cert 
  (
    imt char(16),
    ceid char(10),
    part_name char(60),
    pwlevel char(8),
    agreement char(10),
    legacy char(10),
    vad char(35),
    vad_ceid char(10),
    relationship char(2),
    city char(30),
    hq char(2),
    country char(11),
    prod_cert char(20),
    metrequire char(3),
    sign_dt date,
    start_dt date,
    sales_certs char(3),
    tech_certs char(3)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".storage_cert from "public" as "informix";

{ TABLE "informix".in_st row size = 267 number of columns = 11 index size = 0 }

create table "informix".in_st 
  (
    part_name char(60),
    ceid char(10),
    part_type char(1),
    ssr char(30),
    ctp char(30),
    flash char(30),
    spr char(30),
    pta char(30),
    pcr char(30),
    prog_stat char(15),
    tmp char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".in_st from "public" as "informix";

{ TABLE "informix".skills_sh row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_sh 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_sh from "public" as "informix";

{ TABLE "informix".skills_sv row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_sv 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_sv from "public" as "informix";

{ TABLE "informix".master row size = 22548 number of columns = 38 index size = 0 }

create table "informix".master 
  (
    global_flg char(1),
    global_msg char(50),
    best_msg char(20),
    top_msg char(20),
    middle_msg char(20),
    low_msg char(20),
    top_path_url char(256),
    cgi_dir char(10),
    education_pres char(80),
    education_replay char(80),
    education_intro char(80),
    geo_note char(150),
    market_note char(150),
    skill_note char(150),
    other_note char(150),
    ind_1 char(30),
    ind_2 char(30),
    ind_3 char(30),
    ind_4 char(30),
    updmsg char(35),
    pw_url char(128),
    fap_results smallint,
    home_dir char(20),
    sr_txt char(1500),
    comp_txt char(1500),
    resell_txt char(1500),
    details_txt char(1500),
    plan_txt char(1500),
    target_txt char(1500),
    skill_txt char(1500),
    sol_txt char(1500),
    ref_txt char(1500),
    mkt_txt char(1500),
    geo_txt char(1500),
    cert_txt char(1500),
    cont_txt char(1500),
    social_txt char(1500),
    ver_num char(6)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".master from "public" as "informix";

{ TABLE "informix".coverextend_st_del row size = 70 number of columns = 4 index size = 15 }

create table "informix".coverextend_st_del 
  (
    ceid char(10),
    flash char(20),
    spr char(20),
    pta char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".coverextend_st_del from "public" as "informix";

{ TABLE "informix"._ind_colname row size = 32 number of columns = 3 index size = 17 }

create table "informix"._ind_colname 
  (
    i_short char(10),
    i_col char(20),
    idx smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._ind_colname from "public" as "informix";

{ TABLE "informix"._hci row size = 152 number of columns = 6 index size = 0 }

create table "informix"._hci 
  (
    part_name char(50),
    ceid char(10),
    i1 char(30),
    i2 char(30),
    i3 char(30),
    tmp smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._hci from "public" as "informix";

{ TABLE "informix"._hcc row size = 361 number of columns = 9 index size = 0 }

create table "informix"._hcc 
  (
    part_name char(50),
    ceid char(10),
    ssr char(50),
    ctp1 char(50),
    ctp2 char(50),
    ctp3 char(50),
    ctp4 char(50),
    ctp5 char(50),
    tmp char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._hcc from "public" as "informix";

{ TABLE "informix".gsd_cat row size = 51 number of columns = 2 index size = 0 }

create table "informix".gsd_cat 
  (
    level1 char(1),
    desc char(50)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".gsd_cat from "public" as "informix";

{ TABLE "informix".gsd row size = 86 number of columns = 4 index size = 0 }

create table "informix".gsd 
  (
    level1 char(1),
    level2 char(2),
    name char(75),
    stat char(8)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".gsd from "public" as "informix";

{ TABLE "informix".comp row size = 356 number of columns = 3 index size = 0 }

create table "informix".comp 
  (
    comp_name char(50),
    comp_short char(50),
    comp_desc char(256)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".comp from "public" as "informix";

{ TABLE "informix".competency_v1 row size = 383 number of columns = 44 index size = 70 }

create table "informix".competency_v1 
  (
    iot char(20),
    imt char(10),
    country char(20),
    part_name char(60),
    ceid char(10),
    sw_vad char(35),
    hw_vad char(35),
    pw_level_curr_yr char(8),
    pw_level_next_yr char(8),
    pw_level_grace char(8),
    num_client_ref smallint,
    client_sat_surv char(3),
    resale_auth char(3),
    bu char(25),
    comp_name char(50),
    achieved_level char(12),
    stat char(12),
    certs smallint,
    certs_req_spec smallint,
    certs_req_exp smallint,
    certs_sales smallint,
    certs_req_sales_spec smallint,
    certs_req_sales_exp smallint,
    certs_tech smallint,
    certs_req_tech_spec smallint,
    certs_req_tech_exp smallint,
    res smallint,
    res_req_spec smallint,
    res_req_exp smallint,
    res_tech smallint,
    res_req_tech_spec smallint,
    res_req_tech_exp smallint,
    res_sales smallint,
    res_req_sales_spec smallint,
    res_req_sales_exp smallint,
    res_tech_sales_certs smallint,
    res_tech_sales_sols smallint,
    sols smallint,
    sols_req_spec smallint,
    sols_req_exp smallint,
    rev_prev_yr integer,
    rev_curr_yr integer,
    rev_prev_yr_spec integer,
    rev_prev_yr_exp integer
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".competency_v1 from "public" as "informix";

{ TABLE "informix".brand_bu row size = 27 number of columns = 2 index size = 32 }

create table "informix".brand_bu 
  (
    brand char(2),
    bu char(25)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".brand_bu from "public" as "informix";

{ TABLE "informix".svp_info row size = 735 number of columns = 61 index size = 140 }

create table "informix".svp_info 
  (
    iot char(20),
    imt char(10),
    country char(20),
    hc_country char(1),
    ceid char(10),
    part_name char(60),
    dba_name char(60),
    hqid char(10),
    hqlocname char(60),
    wwid char(10),
    city char(20),
    state char(2),
    zip char(10),
    url char(50),
    sap_cus_no char(10),
    svp_sub_dt char(26),
    svp_upd_dt char(26),
    svp_upder char(50),
    vapid char(10),
    vad char(35),
    vad_payer_num char(10),
    prod_grp_desc char(60),
    remarketer_type char(40),
    prod_grp_stat char(10),
    prod_grp_stat_dt char(26),
    prod_grp_approver char(50),
    type_watson char(1),
    type_adv_analy char(1),
    type_pred_analy char(1),
    type_pres_analy char(1),
    type_risk char(1),
    type_open char(1),
    type_iig char(1),
    type_assets char(1),
    type_datarep char(1),
    type_saferplt char(1),
    type_cust_analy char(1),
    type_telco_analy char(1),
    type_cust_eng_sols char(1),
    type_dig_exp char(1),
    type_part_engage_sols char(1),
    type_watson_health char(1),
    type_app_platform char(1),
    type_process char(1),
    type_iot char(1),
    type_security char(1),
    type_message char(1),
    type_social char(1),
    type_talentmgt char(1),
    type_fopm char(1),
    type_salesperfmgmt char(1),
    type_storage char(1),
    type_saas char(1),
    type_ecm char(1),
    sw_open_dist char(1),
    gov_reseller char(1),
    end_users char(1),
    remarketers char(1),
    publicsector char(1),
    publishtoeu char(3),
    publishtobp char(3)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".svp_info from "public" as "informix";

{ TABLE "informix".tags row size = 85 number of columns = 4 index size = 90 }

create table "informix".tags 
  (
    ceid char(10),
    ig_name char(35),
    i_short char(10),
    tag_desc char(30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".tags from "public" as "informix";

{ TABLE "informix".pod_info row size = 62 number of columns = 3 index size = 35 }

create table "informix".pod_info 
  (
    pod char(30),
    pod_ord smallint,
    pcr char(30)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".pod_info from "public" as "informix";

{ TABLE "informix".pod row size = 206 number of columns = 6 index size = 0 }

create table "informix".pod 
  (
    ceid char(10),
    part_name char(60),
    seg char(15),
    pod char(30),
    pcr char(90),
    tmp char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".pod from "public" as "informix";

{ TABLE "informix"._tmpsu row size = 521 number of columns = 13 index size = 0 }

create table "informix"._tmpsu 
  (
    part_name char(60),
    ceid char(60),
    ssr char(40),
    ctp char(40),
    c1 char(40),
    c2 char(40),
    c3 char(40),
    c4 char(40),
    c5 char(40),
    c6 char(40),
    c7 char(40),
    c8 char(40),
    t char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._tmpsu from "public" as "informix";

{ TABLE "informix"._tmpau row size = 110 number of columns = 4 index size = 0 }

create table "informix"._tmpau 
  (
    ceid char(10),
    part_name char(60),
    ssr char(20),
    hq char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._tmpau from "public" as "informix";

{ TABLE "informix".vap row size = 794 number of columns = 70 index size = 15 }

create table "informix".vap 
  (
    geo char(20),
    region char(20),
    country char(15),
    hc_country char(1),
    ceid char(10),
    part_name char(60),
    wweid char(10),
    city char(20),
    st char(2),
    zip char(10),
    url char(50),
    vad_id char(10),
    vad char(20),
    vad_payer char(10),
    sap_cus_no char(10),
    vap_app_status char(18),
    vap_sub_dt date,
    vap_stat_dt date,
    sol_id char(10),
    sol_name char(50),
    sol_area char(25),
    sol_status char(18),
    sol_sub_dt date,
    sol_status_dt date,
    sol_act char(1),
    va_type char(25),
    va_desc char(256),
    an_cloud_open char(1),
    an_plat_open char(1),
    an_sol_open char(1),
    cloud_open char(1),
    commerce_open char(1),
    healthcare_open char(1),
    iot_open char(1),
    other_open char(1),
    security_open char(1),
    social_open char(1),
    sys_mw_open char(1),
    sys_storage_open char(1),
    watson_open char(1),
    watson char(1),
    adv_an char(1),
    pred_an char(1),
    pres_an char(1),
    risk_comp char(1),
    iig char(1),
    assets_open char(1),
    data_repo char(1),
    safe_plan char(1),
    cust_an char(1),
    telco_nw_an char(1),
    cust_eng_sol char(1),
    digit_exp char(1),
    part_supp_eng_sol char(1),
    watson_health char(1),
    app_plat_int char(1),
    proc_transform char(1),
    iot char(1),
    security char(1),
    msg_col char(1),
    social_uc char(1),
    talent_mgt char(1),
    fopm char(1),
    spm char(1),
    spec_stor char(1),
    saas_entry char(1),
    ecm char(1),
    linux_box char(1),
    vap_last_upd char(26),
    last_updt_by char(40)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".vap from "public" as "informix";

{ TABLE "informix".fcast_au_okdel row size = 1046 number of columns = 37 index size = 0 }

create table "informix".fcast_au_okdel 
  (
    sc char(1),
    cust_name char(60),
    iot char(15),
    market char(35),
    industry char(35),
    country char(15),
    brand_grp char(10),
    brand char(30),
    prod_seg char(50),
    prod_fam char(30),
    brand_desc char(40),
    oppty_name char(50),
    oppty_num char(13),
    partner_led char(1),
    flow_code char(10),
    close_qtr char(2),
    exp_close_dt date,
    bpr_fcast_stat char(11),
    rev float,
    odds smallint,
    ssm_step char(40),
    ceid char(10),
    part_name char(30),
    owning_org char(20),
    iemm char(10),
    report_to_sector char(10),
    crm_rev_type char(20),
    mgr char(40),
    ssr char(40),
    lead_pass char(1),
    slip_deal char(1),
    vad char(10),
    value_prop char(128),
    reason_act char(128),
    final_prop char(128),
    bp_own char(1),
    updtime datetime year to minute
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".fcast_au_okdel from "public" as "informix";

{ TABLE "informix".fcast_comments_au row size = 2612 number of columns = 5 index size = 9 }

create table "informix".fcast_comments_au 
  (
    fcast_id integer,
    fcast_comment_type char(1),
    fcast_comment char(2560),
    updperson char(40),
    updtime datetime year to minute
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".fcast_comments_au from "public" as "informix";

{ TABLE "informix".fcast_bpr row size = 134 number of columns = 7 index size = 0 }

create table "informix".fcast_bpr 
  (
    brand char(2),
    ssr char(20),
    email char(40),
    pin char(6),
    ctp char(20),
    ctp_email char(40),
    ctp_pin char(6)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".fcast_bpr from "public" as "informix";

{ TABLE "informix".flu_flowcode row size = 17 number of columns = 2 index size = 20 }

create table "informix".flu_flowcode 
  (
    flow_code char(15),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_flowcode from "public" as "informix";

{ TABLE "informix".flu_stat row size = 13 number of columns = 2 index size = 16 }

create table "informix".flu_stat 
  (
    fc_status char(11),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_stat from "public" as "informix";

{ TABLE "informix".flu_revtype row size = 22 number of columns = 2 index size = 25 }

create table "informix".flu_revtype 
  (
    rev_type char(20),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_revtype from "public" as "informix";

{ TABLE "informix".flu_iot row size = 15 number of columns = 2 index size = 18 }

create table "informix".flu_iot 
  (
    iot char(13),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_iot from "public" as "informix";

{ TABLE "informix".flu_country row size = 22 number of columns = 2 index size = 25 }

create table "informix".flu_country 
  (
    country char(20),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_country from "public" as "informix";

{ TABLE "informix".flu_brand_grp row size = 12 number of columns = 2 index size = 15 }

create table "informix".flu_brand_grp 
  (
    brand_grp char(10),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_brand_grp from "public" as "informix";

{ TABLE "informix".flu_brand row size = 32 number of columns = 2 index size = 35 }

create table "informix".flu_brand 
  (
    brand char(30),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_brand from "public" as "informix";

{ TABLE "informix".flu_ssmstep row size = 44 number of columns = 4 index size = 45 }

create table "informix".flu_ssmstep 
  (
    ssmstep char(40),
    ord smallint,
    screen_filter char(1),
    export_filter char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_ssmstep from "public" as "informix";

{ TABLE "informix".flu_owning_org row size = 42 number of columns = 2 index size = 45 }

create table "informix".flu_owning_org 
  (
    owning_org char(40),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_owning_org from "public" as "informix";

{ TABLE "informix".flu_prod_seg row size = 52 number of columns = 2 index size = 55 }

create table "informix".flu_prod_seg 
  (
    prod_seg char(50),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_prod_seg from "public" as "informix";

{ TABLE "informix".flu_prod_fam row size = 102 number of columns = 3 index size = 55 }

create table "informix".flu_prod_fam 
  (
    prod_fam char(50),
    prod_seg char(50),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_prod_fam from "public" as "informix";

{ TABLE "informix".fcast_au row size = 1971 number of columns = 47 index size = 9 }

create table "informix".fcast_au 
  (
    fcast_id serial not null ,
    sc char(1),
    cust_name char(60),
    iot char(15),
    market char(35),
    industry char(35),
    country char(15),
    brand_grp char(10),
    brand char(30),
    brand2 char(30),
    brand3 char(30),
    prod_seg char(50),
    prod_seg2 char(50),
    prod_seg3 char(50),
    prod_fam char(30),
    prod_fam2 char(30),
    prod_fam3 char(30),
    brand_desc char(300),
    oppty_name char(60),
    oppty_num char(13),
    partner_led char(1),
    flow_code char(15),
    close_qtr char(2),
    exp_close_dt date,
    bpr_fcast_stat char(11),
    rev float,
    odds smallint,
    ssm_step char(40),
    ceid char(10),
    part_name char(30),
    owning_org char(20),
    iemm char(10),
    report_to_sector char(10),
    crm_rev_type char(20),
    mgr char(40),
    ssr char(40),
    lead_pass char(1),
    slip_deal char(1),
    vad char(10),
    value_prop char(256),
    reason_act char(256),
    final_prop char(256),
    bp_own char(1),
    pass_on char(1),
    ftype char(1),
    updperson char(40),
    updtime datetime year to minute
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".fcast_au from "public" as "informix";

{ TABLE "informix".market row size = 72 number of columns = 3 index size = 0 }

create table "informix".market 
  (
    m_name char(35),
    m_short char(35),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".market from "public" as "informix";

{ TABLE "informix".flu_oppty_stat row size = 22 number of columns = 2 index size = 25 }

create table "informix".flu_oppty_stat 
  (
    oppty_stat char(20),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".flu_oppty_stat from "public" as "informix";

{ TABLE "informix"._inpower row size = 165 number of columns = 34 index size = 0 }

create table "informix"._inpower 
  (
    vad char(20),
    partname char(60),
    ceid char(10),
    spr char(40),
    val char(1),
    hana1 char(1),
    ess1 char(1),
    hpda1 char(1),
    hpc1 char(1),
    rel1 char(1),
    nosql1 char(1),
    ibmi1 char(1),
    aix1 char(1),
    hana2 char(1),
    ess2 char(1),
    hpda2 char(1),
    hpc2 char(1),
    rel2 char(1),
    nosql2 char(1),
    ibmi2 char(1),
    aix2 char(1),
    ind_focus char(1),
    ent_focus char(1),
    com_focus char(1),
    lap char(1),
    country char(6),
    can char(1),
    fin char(1),
    comm char(1),
    dist char(1),
    ind char(1),
    pub char(1),
    fed char(1),
    tmp char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._inpower from "public" as "informix";

{ TABLE "informix".skills_ag row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_ag 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_ag from "public" as "informix";

{ TABLE "informix".tmpt1 row size = 40 number of columns = 1 index size = 0 }

create table "informix".tmpt1 
  (
    email char(40)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".tmpt1 from "public" as "informix";

{ TABLE "informix".authorization row size = 50 number of columns = 3 index size = 0 }

create table "informix".authorization 
  (
    brand char(2),
    id char(40),
    pin char(8)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".authorization from "public" as "informix";

{ TABLE "informix".access_cnt row size = 26 number of columns = 3 index size = 0 }

create table "informix".access_cnt 
  (
    brand char(2),
    page char(20),
    cnt integer
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".access_cnt from "public" as "informix";

{ TABLE "informix".access_page row size = 151 number of columns = 3 index size = 0 }

create table "informix".access_page 
  (
    id char(15),
    dttm datetime year to second,
    target char(128)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".access_page from "public" as "informix";

{ TABLE "informix"._sunew2 row size = 604 number of columns = 41 index size = 0 }

create table "informix"._sunew2 
  (
    part_name char(60),
    ceid char(10),
    esa_gsi char(10),
    part_type char(1),
    focus1 char(20),
    focus2 char(20),
    focus3 char(20),
    p1 char(1),
    p2 char(1),
    p3 char(1),
    p4 char(1),
    p5 char(1),
    p6 char(1),
    p7 char(1),
    p8 char(1),
    saas char(1),
    s1 char(1),
    s2 char(1),
    s3 char(1),
    s4 char(1),
    s5 char(1),
    s6 char(1),
    s7 char(1),
    bm char(1),
    b1 char(1),
    b2 char(1),
    b3 char(1),
    b4 char(1),
    b5 char(1),
    ssr char(40),
    pcs char(40),
    ctp char(40),
    c1 char(40),
    c2 char(40),
    c3 char(40),
    c4 char(40),
    c5 char(40),
    c6 char(40),
    c7 char(40),
    c8 char(40),
    tmp char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._sunew2 from "public" as "informix";

{ TABLE "informix".access_fap row size = 151 number of columns = 3 index size = 0 }

create table "informix".access_fap 
  (
    id char(15),
    dttm datetime year to second,
    target char(128)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".access_fap from "public" as "informix";

{ TABLE "informix".oldcomp row size = 568 number of columns = 61 index size = 0 }

create table "informix".oldcomp 
  (
    iot char(20),
    imt char(10),
    country char(20),
    part_name char(60),
    ceid char(10),
    wweid char(10),
    prc_name char(40),
    prc_email char(40),
    prc_phone char(20),
    vad char(35),
    pw_level char(10),
    pw_mrkg_level char(10),
    pw_achieved_level char(10),
    pw_level_ow_ed char(10),
    num_client_ref smallint,
    client_sat_surv char(3),
    num_resale_auth char(3),
    bu char(25),
    comp_name char(50),
    level char(12),
    achieved_level char(12),
    achieved_dt char(10),
    comp_level_ow_ed char(10),
    certs smallint,
    certs_req_spec smallint,
    certs_req_exp smallint,
    certs_sales smallint,
    certs_req_sales_spec smallint,
    certs_req_sales_exp smallint,
    certs_tech smallint,
    certs_req_tech_spec smallint,
    certs_req_tech_exp smallint,
    res_certs smallint,
    res_sols smallint,
    res_req_spec smallint,
    res_req_exp smallint,
    res_tech_certs smallint,
    res_tech_sols smallint,
    res_req_tech_spec smallint,
    res_req_tech_exp smallint,
    res_sales_certs smallint,
    res_sales_sols smallint,
    res_req_sales_spec smallint,
    res_req_sales_exp smallint,
    sols smallint,
    sols_req_spec smallint,
    sols_req_exp smallint,
    rev_norm_curr_yr integer,
    rev_prev_yr_spec integer,
    rev_prev_yr_exp integer,
    rev_curr_resale_yr integer,
    rev_curr_influence_yr integer,
    rev_curr_xaas_yr integer,
    cert_spec_prog_pct float,
    cert_exp_prog_pct float,
    sol_spec_prog_pct float,
    sol_exp_prog_pct float,
    sales_curr_spec_prog_pct float,
    sales_curr_exp_prog_pct float,
    spec_prog_pct float,
    exp_prog_pct float
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".oldcomp from "public" as "informix";

{ TABLE "informix".review row size = 359 number of columns = 8 index size = 25 }

create table "informix".review 
  (
    ceid char(10),
    brand char(2),
    stat char(1),
    updtime datetime year to second,
    rating smallint,
    reviewer char(40),
    reviewer_email char(40),
    comment varchar(255)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".review from "public" as "informix";

{ TABLE "informix".gsd_solutions row size = 481 number of columns = 6 index size = 69 }

create table "informix".gsd_solutions 
  (
    ceid char(10),
    sol_id integer,
    sol_name varchar(255),
    sol_url varchar(150),
    comp_code char(10),
    comp_name char(50)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".gsd_solutions from "public" as "informix";

{ TABLE "informix".act_initiative row size = 1546 number of columns = 7 index size = 15 }

create table "informix".act_initiative 
  (
    ceid char(10),
    bp_init1 varchar(255),
    bp_init2 varchar(255),
    bp_init3 varchar(255),
    st_init1 varchar(255),
    st_init2 varchar(255),
    st_init3 varchar(255)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".act_initiative from "public" as "informix";

{ TABLE "informix".activity row size = 713 number of columns = 12 index size = 15 }

create table "informix".activity 
  (
    act_sn serial not null ,
    ceid char(10),
    act_name varchar(128),
    act_desc varchar(255),
    act_code char(1),
    act_init varchar(255),
    act_stat char(1),
    act_rev float,
    act_st_dt date,
    act_ed_dt date,
    act_own_ibm char(20),
    act_own_bp char(20)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".activity from "public" as "informix";

{ TABLE "informix".target row size = 543 number of columns = 97 index size = 15 }

create table "informix".target 
  (
    t_geo char(20),
    t_region char(20),
    t_part_name char(60),
    t_ceid char(10),
    t_stg_q1_target integer,
    t_stg_q1_pv integer,
    t_stg_q2_target integer,
    t_stg_q2_pv integer,
    t_stg_q3_target integer,
    t_stg_q3_pv integer,
    t_stg_q4_target integer,
    t_stg_q4_pv integer,
    t_au_q1_target integer,
    t_au_q1_pv integer,
    t_au_q2_target integer,
    t_au_q2_pv integer,
    t_au_q3_target integer,
    t_au_q3_pv integer,
    t_au_q4_target integer,
    t_au_q4_pv integer,
    t_su_q1_target integer,
    t_su_q1_pv integer,
    t_su_q2_target integer,
    t_su_q2_pv integer,
    t_su_q3_target integer,
    t_su_q3_pv integer,
    t_su_q4_target integer,
    t_su_q4_pv integer,
    t_bu_q1_target integer,
    t_bu_q1_pv integer,
    t_bu_q2_target integer,
    t_bu_q2_pv integer,
    t_bu_q3_target integer,
    t_bu_q3_pv integer,
    t_bu_q4_target integer,
    t_bu_q4_pv integer,
    t_se_q1_target integer,
    t_se_q1_pv integer,
    t_se_q2_target integer,
    t_se_q2_pv integer,
    t_se_q3_target integer,
    t_se_q3_pv integer,
    t_se_q4_target integer,
    t_se_q4_pv integer,
    t_es_q1_target integer,
    t_es_q1_pv integer,
    t_es_q2_target integer,
    t_es_q2_pv integer,
    t_es_q3_target integer,
    t_es_q3_pv integer,
    t_es_q4_target integer,
    t_es_q4_pv integer,
    t_st_q1_target integer,
    t_st_q1_pv integer,
    t_st_q2_target integer,
    t_st_q2_pv integer,
    t_st_q3_target integer,
    t_st_q3_pv integer,
    t_st_q4_target integer,
    t_st_q4_pv integer,
    t_gts_q1_target integer,
    t_gts_q1_pv integer,
    t_gts_q2_target integer,
    t_gts_q2_pv integer,
    t_gts_q3_target integer,
    t_gts_q3_pv integer,
    t_gts_q4_target integer,
    t_gts_q4_pv integer,
    t_strg_q1_target integer,
    t_strg_q1_pv integer,
    t_strg_q2_target integer,
    t_strg_q2_pv integer,
    t_strg_q3_target integer,
    t_strg_q3_pv integer,
    t_strg_q4_target integer,
    t_strg_q4_pv integer,
    t_pwr_q1_target integer,
    t_pwr_q1_pv integer,
    t_pwr_q2_target integer,
    t_pwr_q2_pv integer,
    t_pwr_q3_target integer,
    t_pwr_q3_pv integer,
    t_pwr_q4_target integer,
    t_pwr_q4_pv integer,
    t_sysz_q1_target integer,
    t_sysz_q1_pv integer,
    t_sysz_q2_target integer,
    t_sysz_q2_pv integer,
    t_sysz_q3_target integer,
    t_sysz_q3_pv integer,
    t_sysz_q4_target integer,
    t_sysz_q4_pv integer,
    t_pcr char(20),
    t_spr_pwr char(20),
    t_spr_sto char(20),
    t_spr_cross char(20),
    tmp char(1)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".target from "public" as "informix";

{ TABLE "informix".alu_type row size = 33 number of columns = 3 index size = 6 }

create table "informix".alu_type 
  (
    alu_code char(1),
    alu_type char(30),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".alu_type from "public" as "informix";

{ TABLE "informix".alu_status row size = 33 number of columns = 3 index size = 6 }

create table "informix".alu_status 
  (
    alu_stat char(1),
    alu_stat_desc char(30),
    ord smallint
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".alu_status from "public" as "informix";

{ TABLE "informix".library_det row size = 2056 number of columns = 4 index size = 0 }

create table "informix".library_det 
  (
    id integer,
    level smallint,
    ord smallint,
    desc char(2048)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".library_det from "public" as "informix";

{ TABLE "informix".library row size = 275 number of columns = 6 index size = 0 }

create table "informix".library 
  (
    id serial not null ,
    key char(70),
    rev char(70),
    type char(1),
    avail char(1),
    title varchar(128)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".library from "public" as "informix";

{ TABLE "informix".skills_a1 row size = 142 number of columns = 35 index size = 50 }

create table "informix".skills_a1 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_a1 from "public" as "informix";

{ TABLE "informix".skills_a2 row size = 142 number of columns = 35 index size = 36 }

create table "informix".skills_a2 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_a2 from "public" as "informix";

{ TABLE "informix".skills_a3 row size = 142 number of columns = 35 index size = 36 }

create table "informix".skills_a3 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_a3 from "public" as "informix";

{ TABLE "informix".skills_a4 row size = 142 number of columns = 35 index size = 36 }

create table "informix".skills_a4 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_a4 from "public" as "informix";

{ TABLE "informix".skills_a5 row size = 142 number of columns = 35 index size = 36 }

create table "informix".skills_a5 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_a5 from "public" as "informix";

{ TABLE "informix".curr_revenue row size = 20 number of columns = 7 index size = 17 }

create table "informix".curr_revenue 
  (
    brand char(2),
    ceid char(10),
    curr_rev_flg char(1),
    rev integer,
    has_sol char(1),
    has_skill char(1),
    has_contact char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".curr_revenue from "public" as "informix";

{ TABLE "informix"._iness row size = 250 number of columns = 5 index size = 0 }

create table "informix"._iness 
  (
    ceid char(10),
    part_name char(60),
    p_name char(60),
    p_email char(60),
    p_phone char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._iness from "public" as "informix";

{ TABLE "informix".featsols row size = 932 number of columns = 8 index size = 242 }

create table "informix".featsols 
  (
    brand char(2),
    ceid char(10),
    m_name char(35),
    i_name char(35),
    title char(75),
    desc char(512),
    url varchar(255),
    lastshown datetime year to minute
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".featsols from "public" as "informix";

{ TABLE "informix"._inau row size = 192 number of columns = 5 index size = 0 }

create table "informix"._inau 
  (
    part_name char(60),
    ceid char(10),
    hq char(2),
    mgr char(60),
    ssr char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._inau from "public" as "informix";

{ TABLE "informix".coverage_nc row size = 3025 number of columns = 79 index size = 182 }

create table "informix".coverage_nc 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".coverage_nc from "public" as "informix";

{ TABLE "informix".contacts_nc row size = 205 number of columns = 7 index size = 90 }

create table "informix".contacts_nc 
  (
    c_ceid char(10),
    c_name char(30),
    c_title char(40),
    c_phone char(30),
    c_email char(50),
    e_region char(20),
    e_name char(25)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".contacts_nc from "public" as "informix";

{ TABLE "informix".success_nc row size = 394 number of columns = 3 index size = 144 }

create table "informix".success_nc 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".success_nc from "public" as "informix";

{ TABLE "informix"._innc row size = 172 number of columns = 5 index size = 0 }

create table "informix"._innc 
  (
    part_name char(60),
    ceid char(10),
    vad char(40),
    hq char(2),
    ssr char(60)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._innc from "public" as "informix";

{ TABLE "informix".activity_nc row size = 713 number of columns = 12 index size = 15 }

create table "informix".activity_nc 
  (
    act_sn serial not null ,
    ceid char(10),
    act_name varchar(128),
    act_desc varchar(255),
    act_code char(1),
    act_init varchar(255),
    act_stat char(1),
    act_rev float,
    act_st_dt date,
    act_ed_dt date,
    act_own_ibm char(20),
    act_own_bp char(20)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".activity_nc from "public" as "informix";

{ TABLE "informix".act_init_nc row size = 1546 number of columns = 7 index size = 15 }

create table "informix".act_init_nc 
  (
    ceid char(10),
    bp_init1 varchar(255),
    bp_init2 varchar(255),
    bp_init3 varchar(255),
    st_init1 varchar(255),
    st_init2 varchar(255),
    st_init3 varchar(255)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".act_init_nc from "public" as "informix";

{ TABLE "informix"._inst row size = 383 number of columns = 10 index size = 0 }

create table "informix"._inst 
  (
    vad char(20),
    spr char(80),
    part_name char(60),
    pta char(80),
    pam char(80),
    ceid char(10),
    loc char(50),
    cio_sw char(1),
    cio_hw char(1),
    tmp char(1)
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix"._inst from "public" as "informix";

{ TABLE "informix".skills_n1 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_n1 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 4098 next size 1024 lock mode row;

revoke all on "informix".skills_n1 from "public" as "informix";

{ TABLE "informix".skills_n2 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_n2 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 4098 next size 1024 lock mode row;

revoke all on "informix".skills_n2 from "public" as "informix";

{ TABLE "informix".skills_n3 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_n3 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 4098 next size 1024 lock mode row;

revoke all on "informix".skills_n3 from "public" as "informix";

{ TABLE "informix".skills_n4 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_n4 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 4098 next size 1024 lock mode row;

revoke all on "informix".skills_n4 from "public" as "informix";

{ TABLE "informix".skills_n5 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_n5 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 4098 next size 1024 lock mode row;

revoke all on "informix".skills_n5 from "public" as "informix";

{ TABLE "informix".skills_n6 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_n6 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 4098 next size 1024 lock mode row;

revoke all on "informix".skills_n6 from "public" as "informix";

{ TABLE "informix".skills_n7 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_n7 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 4098 next size 1024 lock mode row;

revoke all on "informix".skills_n7 from "public" as "informix";

{ TABLE "informix".competency row size = 567 number of columns = 69 index size = 237 }

create table "informix".competency 
  (
    iot char(20),
    imt char(10),
    country char(20),
    part_name char(60),
    ceid char(10),
    wweid char(10),
    vad char(35),
    prc_name char(40),
    prc_email char(40),
    prc_phone char(20),
    pw_level char(10),
    pw_mrkg_level char(10),
    pw_achieved_level char(10),
    pw_level_ow_ed char(10),
    num_client_ref smallint,
    client_sat_surv char(3),
    num_resale_auth char(3),
    bu char(25),
    comp_name char(50),
    level char(12),
    achieved_level char(12),
    certs smallint,
    certs_req_spec smallint,
    certs_req_exp smallint,
    certs_sales smallint,
    certs_req_sales_spec smallint,
    certs_req_sales_exp smallint,
    certs_tech smallint,
    certs_req_tech_spec smallint,
    certs_req_tech_exp smallint,
    badges smallint,
    badges_req_spec smallint,
    badges_req_exp smallint,
    badges_sales smallint,
    badges_req_sales_spec smallint,
    badges_req_sales_exp smallint,
    badges_tech smallint,
    badges_req_tech_spec smallint,
    badges_req_tech_exp smallint,
    res_certs smallint,
    res_sols smallint,
    res_req_spec smallint,
    res_req_exp smallint,
    res_tech_certs smallint,
    res_tech_sols smallint,
    res_req_tech_spec smallint,
    res_req_tech_exp smallint,
    res_sales_certs smallint,
    res_sales_sols smallint,
    res_req_sales_spec smallint,
    res_req_sales_exp smallint,
    sols smallint,
    sols_req_spec smallint,
    sols_req_exp smallint,
    rev_norm_curr_yr integer,
    rev_req_spec integer,
    rev_req_exp integer,
    rev_curr_resale_yr integer,
    rev_curr_influence_yr integer,
    rev_curr_xaas_yr integer,
    cert_badge_spec_prog_pct float,
    cert_badge_exp_prog_pct float,
    sol_spec_prog_pct float,
    sol_exp_prog_pct float,
    sales_curr_spec_prog_pct float,
    sales_curr_exp_prog_pct float,
    spec_prog_pct float,
    exp_prog_pct float,
    tmp char(1)
  ) extent size 256 next size 256 lock mode row;

revoke all on "informix".competency from "public" as "informix";

{ TABLE "informix".coverage_mc row size = 3025 number of columns = 79 index size = 182 }

create table "informix".coverage_mc 
  (
    ceid char(10),
    vad char(10),
    hq char(2),
    part_type char(1),
    reseller char(1),
    prog_status char(15),
    note char(256),
    lead char(2),
    tier smallint,
    part_name char(60) not null ,
    part_name_abbr char(30),
    ssr char(20),
    ctp1 char(20),
    ctp2 char(20),
    ctp3 char(20),
    ctp4 char(20),
    ctp5 char(20),
    eu_pacificnw char(1),
    eu_northca char(1),
    eu_southwest char(1),
    eu_northern char(1),
    eu_plains char(1),
    eu_heartland char(1),
    eu_texas char(1),
    eu_midamerica char(1),
    eu_ohio char(1),
    eu_southeast char(1),
    eu_sunshine char(1),
    eu_northeast char(1),
    eu_ny char(1),
    eu_garden char(1),
    eu_delaware char(1),
    eu_potomac char(1),
    eu_carolinas char(1),
    eu_ca char(1),
    eu_fed char(1),
    ind_eu char(1),
    ind_tel char(1),
    ind_me char(1),
    ind_ret char(1),
    ind_wd char(1),
    ind_trans char(1),
    ind_bank char(1),
    ind_ins char(1),
    ind_mfg char(1),
    ind_hl char(1),
    ind_gov char(1),
    ind_cross char(1),
    ind_auto char(1),
    ind_csi char(1),
    ind_chem char(1),
    ind_consume char(1),
    ind_defense char(1),
    ind_elect char(1),
    ind_finan char(1),
    ind_indprod char(1),
    ind_lifesci char(1),
    ind_fed char(1),
    ind_can char(1),
    ind_education char(1),
    pod char(30),
    url char(50),
    pwp char(100),
    desc char(2048),
    p_name char(30),
    p_title char(40),
    p_phone char(30),
    p_email char(40),
    focus1 char(30),
    focus2 char(30),
    focus3 char(30),
    partners_well char(1),
    hunter char(1),
    lap char(1),
    dfm char(1),
    commercial char(1),
    enterprise char(1),
    industry char(1),
    updtime datetime year to second
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".coverage_mc from "public" as "informix";

{ TABLE "informix".success_mc row size = 394 number of columns = 3 index size = 144 }

create table "informix".success_mc 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".success_mc from "public" as "informix";

{ TABLE "informix".success_md row size = 394 number of columns = 3 index size = 144 }

create table "informix".success_md 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".success_md from "public" as "informix";

{ TABLE "informix".success_mf row size = 394 number of columns = 3 index size = 144 }

create table "informix".success_mf 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".success_mf from "public" as "informix";

{ TABLE "informix".success_mi row size = 394 number of columns = 3 index size = 144 }

create table "informix".success_mi 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".success_mi from "public" as "informix";

{ TABLE "informix".success_mp row size = 394 number of columns = 3 index size = 144 }

create table "informix".success_mp 
  (
    ceid char(10),
    s_title varchar(128,30),
    s_link varchar(254,30)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".success_mp from "public" as "informix";

{ TABLE "informix".skills_i1 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_i1 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_i1 from "public" as "informix";

{ TABLE "informix".skills_i2 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_i2 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_i2 from "public" as "informix";

{ TABLE "informix".skills_i3 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_i3 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_i3 from "public" as "informix";

{ TABLE "informix".fcast_nc row size = 1971 number of columns = 47 index size = 9 }

create table "informix".fcast_nc 
  (
    fcast_id serial not null ,
    sc char(1),
    cust_name char(60),
    iot char(15),
    market char(35),
    industry char(35),
    country char(15),
    brand_grp char(10),
    brand char(30),
    brand2 char(30),
    brand3 char(30),
    prod_seg char(50),
    prod_seg2 char(50),
    prod_seg3 char(50),
    prod_fam char(30),
    prod_fam2 char(30),
    prod_fam3 char(30),
    brand_desc char(300),
    oppty_name char(60),
    oppty_num char(13),
    partner_led char(1),
    flow_code char(15),
    close_qtr char(2),
    exp_close_dt date,
    bpr_fcast_stat char(11),
    rev float,
    odds smallint,
    ssm_step char(40),
    ceid char(10),
    part_name char(30),
    owning_org char(20),
    iemm char(10),
    report_to_sector char(10),
    crm_rev_type char(20),
    mgr char(40),
    ssr char(40),
    lead_pass char(1),
    slip_deal char(1),
    vad char(10),
    value_prop char(256),
    reason_act char(256),
    final_prop char(256),
    bp_own char(1),
    pass_on char(1),
    ftype char(1),
    updperson char(40),
    updtime datetime year to minute
  ) extent size 16 next size 16 lock mode page;

revoke all on "informix".fcast_nc from "public" as "informix";

{ TABLE "informix".fcast_comments_nc row size = 2612 number of columns = 5 index size = 9 }

create table "informix".fcast_comments_nc 
  (
    fcast_id integer,
    fcast_comment_type char(1),
    fcast_comment char(2560),
    updperson char(40),
    updtime datetime year to minute
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix".fcast_comments_nc from "public" as "informix";

{ TABLE "informix"._iniot row size = 311 number of columns = 7 index size = 0 }

create table "informix"._iniot 
  (
    ceid char(10),
    part_name char(60),
    ssr char(60),
    ctp1 char(60),
    ctp2 char(60),
    ctp3 char(60),
    tmp char(1)
  ) extent size 16 next size 16 lock mode row;

revoke all on "informix"._iniot from "public" as "informix";

{ TABLE "informix".certs row size = 390 number of columns = 18 index size = 176 }

create table "informix".certs 
  (
    geo char(15),
    region char(20),
    country char(20),
    part_name char(60),
    ceid char(10),
    ww_ent_id char(10),
    person_num char(20),
    cert_num char(8),
    cert_desc char(100),
    cert_cat char(4),
    cert_type char(9),
    cert_level char(6),
    sunset_dt date,
    achieve_dt char(10),
    issuedibm char(3),
    prod_group char(40),
    comp_name char(50),
    tmp char(1)
  ) extent size 800 next size 800 lock mode row;

revoke all on "informix".certs from "public" as "informix";

{ TABLE "informix".skills_i4 row size = 142 number of columns = 35 index size = 15 }

create table "informix".skills_i4 
  (
    ceid char(10) not null ,
    skill_01 smallint,
    skill_02 smallint,
    skill_03 smallint,
    skill_04 smallint,
    skill_05 smallint,
    skill_06 smallint,
    skill_07 smallint,
    skill_08 smallint,
    skill_09 smallint,
    skill_10 smallint,
    skill_11 smallint,
    skill_12 smallint,
    skill_13 smallint,
    skill_14 smallint,
    skill_15 smallint,
    skill_16 smallint,
    skill_17 smallint,
    skill_18 smallint,
    skill_19 smallint,
    skill_20 smallint,
    skill_21 smallint,
    skill_22 smallint,
    skill_23 smallint,
    skill_24 smallint,
    skill_25 smallint,
    skill_26 smallint,
    skill_27 smallint,
    skill_28 smallint,
    skill_29 smallint,
    skill_30 smallint,
    skill_other char(60),
    skill_c1 smallint,
    skill_c2 smallint,
    updtime datetime year to second
  ) extent size 64 next size 64 lock mode row;

revoke all on "informix".skills_i4 from "public" as "informix";


grant select on "informix".reps to "public" as "informix";
grant update on "informix".reps to "public" as "informix";
grant insert on "informix".reps to "public" as "informix";
grant delete on "informix".reps to "public" as "informix";
grant index on "informix".reps to "public" as "informix";
grant select on "informix".vads to "public" as "informix";
grant update on "informix".vads to "public" as "informix";
grant insert on "informix".vads to "public" as "informix";
grant delete on "informix".vads to "public" as "informix";
grant index on "informix".vads to "public" as "informix";
grant select on "informix".iots to "public" as "informix";
grant update on "informix".iots to "public" as "informix";
grant insert on "informix".iots to "public" as "informix";
grant delete on "informix".iots to "public" as "informix";
grant index on "informix".iots to "public" as "informix";
grant select on "informix".bus to "public" as "informix";
grant update on "informix".bus to "public" as "informix";
grant insert on "informix".bus to "public" as "informix";
grant delete on "informix".bus to "public" as "informix";
grant index on "informix".bus to "public" as "informix";
grant select on "informix".cov_ws to "public" as "informix";
grant update on "informix".cov_ws to "public" as "informix";
grant insert on "informix".cov_ws to "public" as "informix";
grant delete on "informix".cov_ws to "public" as "informix";
grant index on "informix".cov_ws to "public" as "informix";
grant select on "informix".svp to "public" as "informix";
grant update on "informix".svp to "public" as "informix";
grant insert on "informix".svp to "public" as "informix";
grant delete on "informix".svp to "public" as "informix";
grant index on "informix".svp to "public" as "informix";
grant select on "informix".brands to "public" as "informix";
grant update on "informix".brands to "public" as "informix";
grant insert on "informix".brands to "public" as "informix";
grant delete on "informix".brands to "public" as "informix";
grant index on "informix".brands to "public" as "informix";
grant select on "informix".skill to "public" as "informix";
grant update on "informix".skill to "public" as "informix";
grant insert on "informix".skill to "public" as "informix";
grant delete on "informix".skill to "public" as "informix";
grant index on "informix".skill to "public" as "informix";
grant select on "informix".bptv_parts to "public" as "informix";
grant update on "informix".bptv_parts to "public" as "informix";
grant insert on "informix".bptv_parts to "public" as "informix";
grant delete on "informix".bptv_parts to "public" as "informix";
grant index on "informix".bptv_parts to "public" as "informix";
grant select on "informix".bptv to "public" as "informix";
grant update on "informix".bptv to "public" as "informix";
grant insert on "informix".bptv to "public" as "informix";
grant delete on "informix".bptv to "public" as "informix";
grant index on "informix".bptv to "public" as "informix";
grant select on "informix".part_details_im to "public" as "informix";
grant update on "informix".part_details_im to "public" as "informix";
grant insert on "informix".part_details_im to "public" as "informix";
grant delete on "informix".part_details_im to "public" as "informix";
grant index on "informix".part_details_im to "public" as "informix";
grant select on "informix".part_details_ws to "public" as "informix";
grant update on "informix".part_details_ws to "public" as "informix";
grant insert on "informix".part_details_ws to "public" as "informix";
grant delete on "informix".part_details_ws to "public" as "informix";
grant index on "informix".part_details_ws to "public" as "informix";
grant select on "informix".industry to "public" as "informix";
grant update on "informix".industry to "public" as "informix";
grant insert on "informix".industry to "public" as "informix";
grant delete on "informix".industry to "public" as "informix";
grant index on "informix".industry to "public" as "informix";
grant select on "informix".load_hist to "public" as "informix";
grant update on "informix".load_hist to "public" as "informix";
grant insert on "informix".load_hist to "public" as "informix";
grant delete on "informix".load_hist to "public" as "informix";
grant index on "informix".load_hist to "public" as "informix";
grant select on "informix".accreditation to "public" as "informix";
grant update on "informix".accreditation to "public" as "informix";
grant insert on "informix".accreditation to "public" as "informix";
grant delete on "informix".accreditation to "public" as "informix";
grant index on "informix".accreditation to "public" as "informix";
grant select on "informix".imts to "public" as "informix";
grant update on "informix".imts to "public" as "informix";
grant insert on "informix".imts to "public" as "informix";
grant delete on "informix".imts to "public" as "informix";
grant index on "informix".imts to "public" as "informix";
grant select on "informix".capability_ibm to "public" as "informix";
grant update on "informix".capability_ibm to "public" as "informix";
grant insert on "informix".capability_ibm to "public" as "informix";
grant delete on "informix".capability_ibm to "public" as "informix";
grant index on "informix".capability_ibm to "public" as "informix";
grant select on "informix".capability to "public" as "informix";
grant update on "informix".capability to "public" as "informix";
grant insert on "informix".capability to "public" as "informix";
grant delete on "informix".capability to "public" as "informix";
grant index on "informix".capability to "public" as "informix";
grant select on "informix".tbptv to "public" as "informix";
grant update on "informix".tbptv to "public" as "informix";
grant insert on "informix".tbptv to "public" as "informix";
grant delete on "informix".tbptv to "public" as "informix";
grant index on "informix".tbptv to "public" as "informix";
grant select on "informix".nbptv to "public" as "informix";
grant update on "informix".nbptv to "public" as "informix";
grant insert on "informix".nbptv to "public" as "informix";
grant delete on "informix".nbptv to "public" as "informix";
grant index on "informix".nbptv to "public" as "informix";
grant select on "informix".nbptv_parts to "public" as "informix";
grant update on "informix".nbptv_parts to "public" as "informix";
grant insert on "informix".nbptv_parts to "public" as "informix";
grant delete on "informix".nbptv_parts to "public" as "informix";
grant index on "informix".nbptv_parts to "public" as "informix";
grant select on "informix".success_ti to "public" as "informix";
grant update on "informix".success_ti to "public" as "informix";
grant insert on "informix".success_ti to "public" as "informix";
grant delete on "informix".success_ti to "public" as "informix";
grant index on "informix".success_ti to "public" as "informix";
grant alter on "informix".success_ti to "public" as "informix";
grant references on "informix".success_ti to "public" as "informix";
grant select on "informix".skills_ti to "public" as "informix";
grant update on "informix".skills_ti to "public" as "informix";
grant insert on "informix".skills_ti to "public" as "informix";
grant delete on "informix".skills_ti to "public" as "informix";
grant index on "informix".skills_ti to "public" as "informix";
grant select on "informix".success_ra to "public" as "informix";
grant update on "informix".success_ra to "public" as "informix";
grant insert on "informix".success_ra to "public" as "informix";
grant delete on "informix".success_ra to "public" as "informix";
grant index on "informix".success_ra to "public" as "informix";
grant alter on "informix".success_ra to "public" as "informix";
grant references on "informix".success_ra to "public" as "informix";
grant select on "informix".access to "public" as "informix";
grant update on "informix".access to "public" as "informix";
grant insert on "informix".access to "public" as "informix";
grant delete on "informix".access to "public" as "informix";
grant index on "informix".access to "public" as "informix";
grant select on "informix".success_lo to "public" as "informix";
grant update on "informix".success_lo to "public" as "informix";
grant insert on "informix".success_lo to "public" as "informix";
grant delete on "informix".success_lo to "public" as "informix";
grant index on "informix".success_lo to "public" as "informix";
grant alter on "informix".success_lo to "public" as "informix";
grant references on "informix".success_lo to "public" as "informix";
grant select on "informix".skills_lo to "public" as "informix";
grant update on "informix".skills_lo to "public" as "informix";
grant insert on "informix".skills_lo to "public" as "informix";
grant delete on "informix".skills_lo to "public" as "informix";
grant index on "informix".skills_lo to "public" as "informix";
grant select on "informix".coverage_lo_old to "public" as "informix";
grant update on "informix".coverage_lo_old to "public" as "informix";
grant insert on "informix".coverage_lo_old to "public" as "informix";
grant delete on "informix".coverage_lo_old to "public" as "informix";
grant index on "informix".coverage_lo_old to "public" as "informix";
grant select on "informix".oldcoverage_ra to "public" as "informix";
grant update on "informix".oldcoverage_ra to "public" as "informix";
grant insert on "informix".oldcoverage_ra to "public" as "informix";
grant delete on "informix".oldcoverage_ra to "public" as "informix";
grant index on "informix".oldcoverage_ra to "public" as "informix";
grant select on "informix".skills_ra to "public" as "informix";
grant update on "informix".skills_ra to "public" as "informix";
grant insert on "informix".skills_ra to "public" as "informix";
grant delete on "informix".skills_ra to "public" as "informix";
grant index on "informix".skills_ra to "public" as "informix";
grant select on "informix".fail to "public" as "informix";
grant update on "informix".fail to "public" as "informix";
grant insert on "informix".fail to "public" as "informix";
grant delete on "informix".fail to "public" as "informix";
grant index on "informix".fail to "public" as "informix";
grant select on "informix".skills_ba to "public" as "informix";
grant update on "informix".skills_ba to "public" as "informix";
grant insert on "informix".skills_ba to "public" as "informix";
grant index on "informix".skills_ba to "public" as "informix";
grant alter on "informix".skills_ba to "public" as "informix";
grant references on "informix".skills_ba to "public" as "informix";
grant select on "informix".success_se to "public" as "informix";
grant update on "informix".success_se to "public" as "informix";
grant insert on "informix".success_se to "public" as "informix";
grant delete on "informix".success_se to "public" as "informix";
grant index on "informix".success_se to "public" as "informix";
grant alter on "informix".success_se to "public" as "informix";
grant references on "informix".success_se to "public" as "informix";
grant select on "informix".skills_is to "public" as "informix";
grant update on "informix".skills_is to "public" as "informix";
grant insert on "informix".skills_is to "public" as "informix";
grant index on "informix".skills_is to "public" as "informix";
grant select on "informix".certs_old to "public" as "informix";
grant update on "informix".certs_old to "public" as "informix";
grant insert on "informix".certs_old to "public" as "informix";
grant delete on "informix".certs_old to "public" as "informix";
grant index on "informix".certs_old to "public" as "informix";
grant select on "informix".coverage_ws_preeus to "public" as "informix";
grant update on "informix".coverage_ws_preeus to "public" as "informix";
grant insert on "informix".coverage_ws_preeus to "public" as "informix";
grant delete on "informix".coverage_ws_preeus to "public" as "informix";
grant index on "informix".coverage_ws_preeus to "public" as "informix";
grant select on "informix".eus to "public" as "informix";
grant update on "informix".eus to "public" as "informix";
grant insert on "informix".eus to "public" as "informix";
grant delete on "informix".eus to "public" as "informix";
grant index on "informix".eus to "public" as "informix";
grant select on "informix".coverage_im_preeus to "public" as "informix";
grant update on "informix".coverage_im_preeus to "public" as "informix";
grant insert on "informix".coverage_im_preeus to "public" as "informix";
grant delete on "informix".coverage_im_preeus to "public" as "informix";
grant index on "informix".coverage_im_preeus to "public" as "informix";
grant select on "informix".skills_im to "public" as "informix";
grant update on "informix".skills_im to "public" as "informix";
grant insert on "informix".skills_im to "public" as "informix";
grant index on "informix".skills_im to "public" as "informix";
grant select on "informix".success_im to "public" as "informix";
grant update on "informix".success_im to "public" as "informix";
grant insert on "informix".success_im to "public" as "informix";
grant delete on "informix".success_im to "public" as "informix";
grant index on "informix".success_im to "public" as "informix";
grant select on "informix".coverage_im to "public" as "informix";
grant update on "informix".coverage_im to "public" as "informix";
grant insert on "informix".coverage_im to "public" as "informix";
grant delete on "informix".coverage_im to "public" as "informix";
grant index on "informix".coverage_im to "public" as "informix";
grant select on "informix"._eucolnames to "public" as "informix";
grant update on "informix"._eucolnames to "public" as "informix";
grant insert on "informix"._eucolnames to "public" as "informix";
grant delete on "informix"._eucolnames to "public" as "informix";
grant index on "informix"._eucolnames to "public" as "informix";
grant select on "informix".coverage_ws to "public" as "informix";
grant update on "informix".coverage_ws to "public" as "informix";
grant insert on "informix".coverage_ws to "public" as "informix";
grant delete on "informix".coverage_ws to "public" as "informix";
grant index on "informix".coverage_ws to "public" as "informix";
grant select on "informix".skills_ws to "public" as "informix";
grant update on "informix".skills_ws to "public" as "informix";
grant insert on "informix".skills_ws to "public" as "informix";
grant delete on "informix".skills_ws to "public" as "informix";
grant index on "informix".skills_ws to "public" as "informix";
grant select on "informix".success_ws to "public" as "informix";
grant update on "informix".success_ws to "public" as "informix";
grant insert on "informix".success_ws to "public" as "informix";
grant delete on "informix".success_ws to "public" as "informix";
grant index on "informix".success_ws to "public" as "informix";
grant select on "informix".sysmenus to "public" as "informix";
grant update on "informix".sysmenus to "public" as "informix";
grant insert on "informix".sysmenus to "public" as "informix";
grant delete on "informix".sysmenus to "public" as "informix";
grant index on "informix".sysmenus to "public" as "informix";
grant select on "informix".sysmenuitems to "public" as "informix";
grant update on "informix".sysmenuitems to "public" as "informix";
grant insert on "informix".sysmenuitems to "public" as "informix";
grant delete on "informix".sysmenuitems to "public" as "informix";
grant index on "informix".sysmenuitems to "public" as "informix";
grant select on "informix".coverage_ti to "public" as "informix";
grant update on "informix".coverage_ti to "public" as "informix";
grant insert on "informix".coverage_ti to "public" as "informix";
grant delete on "informix".coverage_ti to "public" as "informix";
grant index on "informix".coverage_ti to "public" as "informix";
grant alter on "informix".coverage_ti to "public" as "informix";
grant references on "informix".coverage_ti to "public" as "informix";
grant select on "informix".coverage_ra to "public" as "informix";
grant update on "informix".coverage_ra to "public" as "informix";
grant insert on "informix".coverage_ra to "public" as "informix";
grant delete on "informix".coverage_ra to "public" as "informix";
grant index on "informix".coverage_ra to "public" as "informix";
grant select on "informix".coverage_lo to "public" as "informix";
grant update on "informix".coverage_lo to "public" as "informix";
grant insert on "informix".coverage_lo to "public" as "informix";
grant delete on "informix".coverage_lo to "public" as "informix";
grant index on "informix".coverage_lo to "public" as "informix";
grant select on "informix".control to "public" as "informix";
grant update on "informix".control to "public" as "informix";
grant insert on "informix".control to "public" as "informix";
grant delete on "informix".control to "public" as "informix";
grant index on "informix".control to "public" as "informix";
grant select on "pw_level".pw_level to "public" as "pw_level";
grant update on "pw_level".pw_level to "public" as "pw_level";
grant insert on "pw_level".pw_level to "public" as "pw_level";
grant delete on "pw_level".pw_level to "public" as "pw_level";
grant index on "pw_level".pw_level to "public" as "pw_level";
grant select on "informix".cross to "public" as "informix";
grant update on "informix".cross to "public" as "informix";
grant insert on "informix".cross to "public" as "informix";
grant delete on "informix".cross to "public" as "informix";
grant index on "informix".cross to "public" as "informix";
grant select on "informix".skills_em to "public" as "informix";
grant update on "informix".skills_em to "public" as "informix";
grant insert on "informix".skills_em to "public" as "informix";
grant index on "informix".skills_em to "public" as "informix";
grant select on "informix".skills_sc to "public" as "informix";
grant update on "informix".skills_sc to "public" as "informix";
grant insert on "informix".skills_sc to "public" as "informix";
grant delete on "informix".skills_sc to "public" as "informix";
grant index on "informix".skills_sc to "public" as "informix";
grant select on "informix".coverage_is to "public" as "informix";
grant update on "informix".coverage_is to "public" as "informix";
grant insert on "informix".coverage_is to "public" as "informix";
grant index on "informix".coverage_is to "public" as "informix";
grant select on "informix".coverage_em to "public" as "informix";
grant update on "informix".coverage_em to "public" as "informix";
grant insert on "informix".coverage_em to "public" as "informix";
grant delete on "informix".coverage_em to "public" as "informix";
grant index on "informix".coverage_em to "public" as "informix";
grant select on "informix".coverage_sc to "public" as "informix";
grant update on "informix".coverage_sc to "public" as "informix";
grant insert on "informix".coverage_sc to "public" as "informix";
grant delete on "informix".coverage_sc to "public" as "informix";
grant index on "informix".coverage_sc to "public" as "informix";
grant select on "informix".success_em to "public" as "informix";
grant update on "informix".success_em to "public" as "informix";
grant insert on "informix".success_em to "public" as "informix";
grant delete on "informix".success_em to "public" as "informix";
grant index on "informix".success_em to "public" as "informix";
grant select on "informix".success_sc to "public" as "informix";
grant update on "informix".success_sc to "public" as "informix";
grant insert on "informix".success_sc to "public" as "informix";
grant delete on "informix".success_sc to "public" as "informix";
grant index on "informix".success_sc to "public" as "informix";
grant select on "informix".success_is to "public" as "informix";
grant update on "informix".success_is to "public" as "informix";
grant insert on "informix".success_is to "public" as "informix";
grant delete on "informix".success_is to "public" as "informix";
grant index on "informix".success_is to "public" as "informix";
grant select on "informix".coverage_ba to "public" as "informix";
grant update on "informix".coverage_ba to "public" as "informix";
grant insert on "informix".coverage_ba to "public" as "informix";
grant delete on "informix".coverage_ba to "public" as "informix";
grant index on "informix".coverage_ba to "public" as "informix";
grant select on "informix"._worktab to "public" as "informix";
grant update on "informix"._worktab to "public" as "informix";
grant insert on "informix"._worktab to "public" as "informix";
grant delete on "informix"._worktab to "public" as "informix";
grant index on "informix"._worktab to "public" as "informix";
grant select on "informix".states to "public" as "informix";
grant update on "informix".states to "public" as "informix";
grant insert on "informix".states to "public" as "informix";
grant delete on "informix".states to "public" as "informix";
grant index on "informix".states to "public" as "informix";
grant select on "informix".skill_cat to "public" as "informix";
grant update on "informix".skill_cat to "public" as "informix";
grant insert on "informix".skill_cat to "public" as "informix";
grant delete on "informix".skill_cat to "public" as "informix";
grant index on "informix".skill_cat to "public" as "informix";
grant select on "informix".industry_auth to "public" as "informix";
grant update on "informix".industry_auth to "public" as "informix";
grant insert on "informix".industry_auth to "public" as "informix";
grant delete on "informix".industry_auth to "public" as "informix";
grant index on "informix".industry_auth to "public" as "informix";
grant select on "informix".field to "public" as "informix";
grant update on "informix".field to "public" as "informix";
grant insert on "informix".field to "public" as "informix";
grant delete on "informix".field to "public" as "informix";
grant index on "informix".field to "public" as "informix";
grant select on "informix"._t2 to "public" as "informix";
grant update on "informix"._t2 to "public" as "informix";
grant insert on "informix"._t2 to "public" as "informix";
grant delete on "informix"._t2 to "public" as "informix";
grant index on "informix"._t2 to "public" as "informix";
grant select on "informix".midwest to "public" as "informix";
grant update on "informix".midwest to "public" as "informix";
grant insert on "informix".midwest to "public" as "informix";
grant delete on "informix".midwest to "public" as "informix";
grant index on "informix".midwest to "public" as "informix";
grant select on "informix".relations to "public" as "informix";
grant update on "informix".relations to "public" as "informix";
grant insert on "informix".relations to "public" as "informix";
grant delete on "informix".relations to "public" as "informix";
grant index on "informix".relations to "public" as "informix";
grant select on "informix"._ics to "public" as "informix";
grant update on "informix"._ics to "public" as "informix";
grant insert on "informix"._ics to "public" as "informix";
grant delete on "informix"._ics to "public" as "informix";
grant index on "informix"._ics to "public" as "informix";
grant select on "informix".reg_eu_state to "public" as "informix";
grant update on "informix".reg_eu_state to "public" as "informix";
grant insert on "informix".reg_eu_state to "public" as "informix";
grant delete on "informix".reg_eu_state to "public" as "informix";
grant index on "informix".reg_eu_state to "public" as "informix";
grant select on "informix".contacts to "public" as "informix";
grant update on "informix".contacts to "public" as "informix";
grant insert on "informix".contacts to "public" as "informix";
grant delete on "informix".contacts to "public" as "informix";
grant index on "informix".contacts to "public" as "informix";
grant select on "informix".contacts_lo to "public" as "informix";
grant update on "informix".contacts_lo to "public" as "informix";
grant insert on "informix".contacts_lo to "public" as "informix";
grant delete on "informix".contacts_lo to "public" as "informix";
grant index on "informix".contacts_lo to "public" as "informix";
grant select on "informix".contacts_im to "public" as "informix";
grant update on "informix".contacts_im to "public" as "informix";
grant insert on "informix".contacts_im to "public" as "informix";
grant delete on "informix".contacts_im to "public" as "informix";
grant index on "informix".contacts_im to "public" as "informix";
grant select on "informix".contacts_ws to "public" as "informix";
grant update on "informix".contacts_ws to "public" as "informix";
grant insert on "informix".contacts_ws to "public" as "informix";
grant delete on "informix".contacts_ws to "public" as "informix";
grant index on "informix".contacts_ws to "public" as "informix";
grant select on "informix".contacts_ba to "public" as "informix";
grant update on "informix".contacts_ba to "public" as "informix";
grant insert on "informix".contacts_ba to "public" as "informix";
grant delete on "informix".contacts_ba to "public" as "informix";
grant index on "informix".contacts_ba to "public" as "informix";
grant select on "informix".contacts_se to "public" as "informix";
grant update on "informix".contacts_se to "public" as "informix";
grant insert on "informix".contacts_se to "public" as "informix";
grant delete on "informix".contacts_se to "public" as "informix";
grant index on "informix".contacts_se to "public" as "informix";
grant select on "informix".contacts_ti to "public" as "informix";
grant update on "informix".contacts_ti to "public" as "informix";
grant insert on "informix".contacts_ti to "public" as "informix";
grant delete on "informix".contacts_ti to "public" as "informix";
grant index on "informix".contacts_ti to "public" as "informix";
grant select on "informix".contacts_is to "public" as "informix";
grant update on "informix".contacts_is to "public" as "informix";
grant insert on "informix".contacts_is to "public" as "informix";
grant delete on "informix".contacts_is to "public" as "informix";
grant index on "informix".contacts_is to "public" as "informix";
grant select on "informix".contacts_ra to "public" as "informix";
grant update on "informix".contacts_ra to "public" as "informix";
grant insert on "informix".contacts_ra to "public" as "informix";
grant delete on "informix".contacts_ra to "public" as "informix";
grant index on "informix".contacts_ra to "public" as "informix";
grant select on "informix".contacts_em to "public" as "informix";
grant update on "informix".contacts_em to "public" as "informix";
grant insert on "informix".contacts_em to "public" as "informix";
grant delete on "informix".contacts_em to "public" as "informix";
grant index on "informix".contacts_em to "public" as "informix";
grant select on "informix".p2p to "public" as "informix";
grant update on "informix".p2p to "public" as "informix";
grant insert on "informix".p2p to "public" as "informix";
grant delete on "informix".p2p to "public" as "informix";
grant index on "informix".p2p to "public" as "informix";
grant select on "informix".contacts_sc to "public" as "informix";
grant update on "informix".contacts_sc to "public" as "informix";
grant insert on "informix".contacts_sc to "public" as "informix";
grant delete on "informix".contacts_sc to "public" as "informix";
grant index on "informix".contacts_sc to "public" as "informix";
grant select on "informix".tmp_skill to "public" as "informix";
grant update on "informix".tmp_skill to "public" as "informix";
grant insert on "informix".tmp_skill to "public" as "informix";
grant delete on "informix".tmp_skill to "public" as "informix";
grant index on "informix".tmp_skill to "public" as "informix";
grant select on "informix".tmp_skill_cat to "public" as "informix";
grant update on "informix".tmp_skill_cat to "public" as "informix";
grant insert on "informix".tmp_skill_cat to "public" as "informix";
grant delete on "informix".tmp_skill_cat to "public" as "informix";
grant index on "informix".tmp_skill_cat to "public" as "informix";
grant select on "informix".old_vap to "public" as "informix";
grant update on "informix".old_vap to "public" as "informix";
grant insert on "informix".old_vap to "public" as "informix";
grant delete on "informix".old_vap to "public" as "informix";
grant index on "informix".old_vap to "public" as "informix";
grant select on "informix".lastload to "public" as "informix";
grant update on "informix".lastload to "public" as "informix";
grant insert on "informix".lastload to "public" as "informix";
grant delete on "informix".lastload to "public" as "informix";
grant index on "informix".lastload to "public" as "informix";
grant select on "informix".old_sws to "public" as "informix";
grant update on "informix".old_sws to "public" as "informix";
grant insert on "informix".old_sws to "public" as "informix";
grant delete on "informix".old_sws to "public" as "informix";
grant index on "informix".old_sws to "public" as "informix";
grant select on "informix".brand_certs to "public" as "informix";
grant update on "informix".brand_certs to "public" as "informix";
grant insert on "informix".brand_certs to "public" as "informix";
grant delete on "informix".brand_certs to "public" as "informix";
grant index on "informix".brand_certs to "public" as "informix";
grant select on "informix".brand_certs_det to "public" as "informix";
grant update on "informix".brand_certs_det to "public" as "informix";
grant insert on "informix".brand_certs_det to "public" as "informix";
grant delete on "informix".brand_certs_det to "public" as "informix";
grant index on "informix".brand_certs_det to "public" as "informix";
grant select on "informix".coverage_au to "public" as "informix";
grant update on "informix".coverage_au to "public" as "informix";
grant insert on "informix".coverage_au to "public" as "informix";
grant index on "informix".coverage_au to "public" as "informix";
grant select on "informix".skills_au to "public" as "informix";
grant update on "informix".skills_au to "public" as "informix";
grant insert on "informix".skills_au to "public" as "informix";
grant delete on "informix".skills_au to "public" as "informix";
grant index on "informix".skills_au to "public" as "informix";
grant select on "informix".success_au to "public" as "informix";
grant update on "informix".success_au to "public" as "informix";
grant insert on "informix".success_au to "public" as "informix";
grant delete on "informix".success_au to "public" as "informix";
grant index on "informix".success_au to "public" as "informix";
grant select on "informix".contacts_au to "public" as "informix";
grant update on "informix".contacts_au to "public" as "informix";
grant insert on "informix".contacts_au to "public" as "informix";
grant delete on "informix".contacts_au to "public" as "informix";
grant index on "informix".contacts_au to "public" as "informix";
grant select on "informix"._w to "public" as "informix";
grant update on "informix"._w to "public" as "informix";
grant insert on "informix"._w to "public" as "informix";
grant delete on "informix"._w to "public" as "informix";
grant index on "informix"._w to "public" as "informix";
grant select on "informix"._w2 to "public" as "informix";
grant update on "informix"._w2 to "public" as "informix";
grant insert on "informix"._w2 to "public" as "informix";
grant delete on "informix"._w2 to "public" as "informix";
grant index on "informix"._w2 to "public" as "informix";
grant select on "informix"._auin to "public" as "informix";
grant update on "informix"._auin to "public" as "informix";
grant insert on "informix"._auin to "public" as "informix";
grant delete on "informix"._auin to "public" as "informix";
grant index on "informix"._auin to "public" as "informix";
grant select on "informix"._ac to "public" as "informix";
grant update on "informix"._ac to "public" as "informix";
grant insert on "informix"._ac to "public" as "informix";
grant delete on "informix"._ac to "public" as "informix";
grant index on "informix"._ac to "public" as "informix";
grant select on "informix"._aunew to "public" as "informix";
grant update on "informix"._aunew to "public" as "informix";
grant insert on "informix"._aunew to "public" as "informix";
grant delete on "informix"._aunew to "public" as "informix";
grant index on "informix"._aunew to "public" as "informix";
grant select on "informix".units to "public" as "informix";
grant update on "informix".units to "public" as "informix";
grant insert on "informix".units to "public" as "informix";
grant delete on "informix".units to "public" as "informix";
grant index on "informix".units to "public" as "informix";
grant select on "informix".unit_brand to "public" as "informix";
grant update on "informix".unit_brand to "public" as "informix";
grant insert on "informix".unit_brand to "public" as "informix";
grant delete on "informix".unit_brand to "public" as "informix";
grant index on "informix".unit_brand to "public" as "informix";
grant select on "informix".unit_mgrs to "public" as "informix";
grant update on "informix".unit_mgrs to "public" as "informix";
grant insert on "informix".unit_mgrs to "public" as "informix";
grant delete on "informix".unit_mgrs to "public" as "informix";
grant index on "informix".unit_mgrs to "public" as "informix";
grant select on "informix".coverage_su to "public" as "informix";
grant update on "informix".coverage_su to "public" as "informix";
grant insert on "informix".coverage_su to "public" as "informix";
grant index on "informix".coverage_su to "public" as "informix";
grant alter on "informix".coverage_su to "public" as "informix";
grant references on "informix".coverage_su to "public" as "informix";
grant select on "informix".success_su to "public" as "informix";
grant update on "informix".success_su to "public" as "informix";
grant insert on "informix".success_su to "public" as "informix";
grant delete on "informix".success_su to "public" as "informix";
grant index on "informix".success_su to "public" as "informix";
grant select on "informix".skills_su to "public" as "informix";
grant update on "informix".skills_su to "public" as "informix";
grant insert on "informix".skills_su to "public" as "informix";
grant delete on "informix".skills_su to "public" as "informix";
grant index on "informix".skills_su to "public" as "informix";
grant select on "informix"._sunew to "public" as "informix";
grant update on "informix"._sunew to "public" as "informix";
grant insert on "informix"._sunew to "public" as "informix";
grant delete on "informix"._sunew to "public" as "informix";
grant index on "informix"._sunew to "public" as "informix";
grant select on "informix"._isnew to "public" as "informix";
grant update on "informix"._isnew to "public" as "informix";
grant insert on "informix"._isnew to "public" as "informix";
grant delete on "informix"._isnew to "public" as "informix";
grant index on "informix"._isnew to "public" as "informix";
grant select on "informix".skills_s1 to "public" as "informix";
grant update on "informix".skills_s1 to "public" as "informix";
grant insert on "informix".skills_s1 to "public" as "informix";
grant index on "informix".skills_s1 to "public" as "informix";
grant select on "informix".skills_s2 to "public" as "informix";
grant update on "informix".skills_s2 to "public" as "informix";
grant insert on "informix".skills_s2 to "public" as "informix";
grant index on "informix".skills_s2 to "public" as "informix";
grant select on "informix".skills_s3 to "public" as "informix";
grant update on "informix".skills_s3 to "public" as "informix";
grant insert on "informix".skills_s3 to "public" as "informix";
grant index on "informix".skills_s3 to "public" as "informix";
grant select on "informix".skills_s4 to "public" as "informix";
grant update on "informix".skills_s4 to "public" as "informix";
grant insert on "informix".skills_s4 to "public" as "informix";
grant index on "informix".skills_s4 to "public" as "informix";
grant select on "informix".skills_s5 to "public" as "informix";
grant update on "informix".skills_s5 to "public" as "informix";
grant insert on "informix".skills_s5 to "public" as "informix";
grant index on "informix".skills_s5 to "public" as "informix";
grant select on "informix".contacts_su to "public" as "informix";
grant update on "informix".contacts_su to "public" as "informix";
grant insert on "informix".contacts_su to "public" as "informix";
grant delete on "informix".contacts_su to "public" as "informix";
grant index on "informix".contacts_su to "public" as "informix";
grant alter on "informix".contacts_su to "public" as "informix";
grant references on "informix".contacts_su to "public" as "informix";
grant select on "informix"._ranew to "public" as "informix";
grant update on "informix"._ranew to "public" as "informix";
grant insert on "informix"._ranew to "public" as "informix";
grant delete on "informix"._ranew to "public" as "informix";
grant index on "informix"._ranew to "public" as "informix";
grant select on "informix"._eucolnamesu to "public" as "informix";
grant update on "informix"._eucolnamesu to "public" as "informix";
grant insert on "informix"._eucolnamesu to "public" as "informix";
grant delete on "informix"._eucolnamesu to "public" as "informix";
grant index on "informix"._eucolnamesu to "public" as "informix";
grant select on "informix".skills_io to "public" as "informix";
grant update on "informix".skills_io to "public" as "informix";
grant insert on "informix".skills_io to "public" as "informix";
grant index on "informix".skills_io to "public" as "informix";
grant select on "informix".feedback to "public" as "informix";
grant update on "informix".feedback to "public" as "informix";
grant insert on "informix".feedback to "public" as "informix";
grant delete on "informix".feedback to "public" as "informix";
grant index on "informix".feedback to "public" as "informix";
grant select on "informix".segment_leaders to "public" as "informix";
grant update on "informix".segment_leaders to "public" as "informix";
grant insert on "informix".segment_leaders to "public" as "informix";
grant delete on "informix".segment_leaders to "public" as "informix";
grant index on "informix".segment_leaders to "public" as "informix";
grant select on "informix".ind_colname to "public" as "informix";
grant update on "informix".ind_colname to "public" as "informix";
grant insert on "informix".ind_colname to "public" as "informix";
grant delete on "informix".ind_colname to "public" as "informix";
grant index on "informix".ind_colname to "public" as "informix";
grant select on "informix".ind_group to "public" as "informix";
grant update on "informix".ind_group to "public" as "informix";
grant insert on "informix".ind_group to "public" as "informix";
grant delete on "informix".ind_group to "public" as "informix";
grant index on "informix".ind_group to "public" as "informix";
grant select on "informix".coverage_cu to "public" as "informix";
grant update on "informix".coverage_cu to "public" as "informix";
grant insert on "informix".coverage_cu to "public" as "informix";
grant delete on "informix".coverage_cu to "public" as "informix";
grant index on "informix".coverage_cu to "public" as "informix";
grant select on "informix".align_brand to "public" as "informix";
grant update on "informix".align_brand to "public" as "informix";
grant insert on "informix".align_brand to "public" as "informix";
grant delete on "informix".align_brand to "public" as "informix";
grant index on "informix".align_brand to "public" as "informix";
grant select on "informix".align_subbrand to "public" as "informix";
grant update on "informix".align_subbrand to "public" as "informix";
grant insert on "informix".align_subbrand to "public" as "informix";
grant delete on "informix".align_subbrand to "public" as "informix";
grant index on "informix".align_subbrand to "public" as "informix";
grant select on "informix".align_cat to "public" as "informix";
grant update on "informix".align_cat to "public" as "informix";
grant insert on "informix".align_cat to "public" as "informix";
grant delete on "informix".align_cat to "public" as "informix";
grant index on "informix".align_cat to "public" as "informix";
grant select on "informix".tbptv_history to "public" as "informix";
grant update on "informix".tbptv_history to "public" as "informix";
grant insert on "informix".tbptv_history to "public" as "informix";
grant delete on "informix".tbptv_history to "public" as "informix";
grant index on "informix".tbptv_history to "public" as "informix";
grant select on "informix".skills_history to "public" as "informix";
grant update on "informix".skills_history to "public" as "informix";
grant insert on "informix".skills_history to "public" as "informix";
grant delete on "informix".skills_history to "public" as "informix";
grant index on "informix".skills_history to "public" as "informix";
grant select on "informix".coverage_bu to "public" as "informix";
grant update on "informix".coverage_bu to "public" as "informix";
grant insert on "informix".coverage_bu to "public" as "informix";
grant delete on "informix".coverage_bu to "public" as "informix";
grant index on "informix".coverage_bu to "public" as "informix";
grant select on "informix".success_bu to "public" as "informix";
grant update on "informix".success_bu to "public" as "informix";
grant insert on "informix".success_bu to "public" as "informix";
grant delete on "informix".success_bu to "public" as "informix";
grant index on "informix".success_bu to "public" as "informix";
grant select on "informix".contacts_bu to "public" as "informix";
grant update on "informix".contacts_bu to "public" as "informix";
grant insert on "informix".contacts_bu to "public" as "informix";
grant delete on "informix".contacts_bu to "public" as "informix";
grant index on "informix".contacts_bu to "public" as "informix";
grant select on "informix".skills_co to "public" as "informix";
grant update on "informix".skills_co to "public" as "informix";
grant insert on "informix".skills_co to "public" as "informix";
grant delete on "informix".skills_co to "public" as "informix";
grant index on "informix".skills_co to "public" as "informix";
grant select on "informix".skills_bu to "public" as "informix";
grant update on "informix".skills_bu to "public" as "informix";
grant insert on "informix".skills_bu to "public" as "informix";
grant delete on "informix".skills_bu to "public" as "informix";
grant index on "informix".skills_bu to "public" as "informix";
grant select on "informix".segmentation to "public" as "informix";
grant update on "informix".segmentation to "public" as "informix";
grant insert on "informix".segmentation to "public" as "informix";
grant delete on "informix".segmentation to "public" as "informix";
grant index on "informix".segmentation to "public" as "informix";
grant select on "informix".success_cu to "public" as "informix";
grant update on "informix".success_cu to "public" as "informix";
grant insert on "informix".success_cu to "public" as "informix";
grant delete on "informix".success_cu to "public" as "informix";
grant index on "informix".success_cu to "public" as "informix";
grant select on "informix".contacts_cu to "public" as "informix";
grant update on "informix".contacts_cu to "public" as "informix";
grant insert on "informix".contacts_cu to "public" as "informix";
grant delete on "informix".contacts_cu to "public" as "informix";
grant index on "informix".contacts_cu to "public" as "informix";
grant select on "informix".skills_c1 to "public" as "informix";
grant update on "informix".skills_c1 to "public" as "informix";
grant insert on "informix".skills_c1 to "public" as "informix";
grant delete on "informix".skills_c1 to "public" as "informix";
grant index on "informix".skills_c1 to "public" as "informix";
grant select on "informix".tasks to "public" as "informix";
grant update on "informix".tasks to "public" as "informix";
grant insert on "informix".tasks to "public" as "informix";
grant delete on "informix".tasks to "public" as "informix";
grant index on "informix".tasks to "public" as "informix";
grant select on "informix".task_ord to "public" as "informix";
grant update on "informix".task_ord to "public" as "informix";
grant insert on "informix".task_ord to "public" as "informix";
grant delete on "informix".task_ord to "public" as "informix";
grant index on "informix".task_ord to "public" as "informix";
grant select on "informix".coverage_ou to "public" as "informix";
grant update on "informix".coverage_ou to "public" as "informix";
grant insert on "informix".coverage_ou to "public" as "informix";
grant delete on "informix".coverage_ou to "public" as "informix";
grant index on "informix".coverage_ou to "public" as "informix";
grant select on "informix".certsoldna to "public" as "informix";
grant update on "informix".certsoldna to "public" as "informix";
grant insert on "informix".certsoldna to "public" as "informix";
grant delete on "informix".certsoldna to "public" as "informix";
grant index on "informix".certsoldna to "public" as "informix";
grant alter on "informix".certsoldna to "public" as "informix";
grant references on "informix".certsoldna to "public" as "informix";
grant select on "informix".in_cloud to "public" as "informix";
grant update on "informix".in_cloud to "public" as "informix";
grant insert on "informix".in_cloud to "public" as "informix";
grant delete on "informix".in_cloud to "public" as "informix";
grant index on "informix".in_cloud to "public" as "informix";
grant select on "informix".coverage_st to "public" as "informix";
grant update on "informix".coverage_st to "public" as "informix";
grant insert on "informix".coverage_st to "public" as "informix";
grant delete on "informix".coverage_st to "public" as "informix";
grant index on "informix".coverage_st to "public" as "informix";
grant alter on "informix".coverage_st to "public" as "informix";
grant references on "informix".coverage_st to "public" as "informix";
grant select on "informix".skills_sw to "public" as "informix";
grant update on "informix".skills_sw to "public" as "informix";
grant insert on "informix".skills_sw to "public" as "informix";
grant delete on "informix".skills_sw to "public" as "informix";
grant index on "informix".skills_sw to "public" as "informix";
grant select on "informix".success_st to "public" as "informix";
grant update on "informix".success_st to "public" as "informix";
grant insert on "informix".success_st to "public" as "informix";
grant delete on "informix".success_st to "public" as "informix";
grant index on "informix".success_st to "public" as "informix";
grant select on "informix".contacts_st to "public" as "informix";
grant update on "informix".contacts_st to "public" as "informix";
grant insert on "informix".contacts_st to "public" as "informix";
grant delete on "informix".contacts_st to "public" as "informix";
grant index on "informix".contacts_st to "public" as "informix";
grant select on "informix".coverage_es to "public" as "informix";
grant update on "informix".coverage_es to "public" as "informix";
grant insert on "informix".coverage_es to "public" as "informix";
grant delete on "informix".coverage_es to "public" as "informix";
grant index on "informix".coverage_es to "public" as "informix";
grant alter on "informix".coverage_es to "public" as "informix";
grant references on "informix".coverage_es to "public" as "informix";
grant select on "informix".skills_es to "public" as "informix";
grant update on "informix".skills_es to "public" as "informix";
grant insert on "informix".skills_es to "public" as "informix";
grant delete on "informix".skills_es to "public" as "informix";
grant index on "informix".skills_es to "public" as "informix";
grant select on "informix".contacts_es to "public" as "informix";
grant update on "informix".contacts_es to "public" as "informix";
grant insert on "informix".contacts_es to "public" as "informix";
grant delete on "informix".contacts_es to "public" as "informix";
grant index on "informix".contacts_es to "public" as "informix";
grant select on "informix".success_es to "public" as "informix";
grant update on "informix".success_es to "public" as "informix";
grant insert on "informix".success_es to "public" as "informix";
grant delete on "informix".success_es to "public" as "informix";
grant index on "informix".success_es to "public" as "informix";
grant select on "informix".coverage_wu to "public" as "informix";
grant update on "informix".coverage_wu to "public" as "informix";
grant insert on "informix".coverage_wu to "public" as "informix";
grant delete on "informix".coverage_wu to "public" as "informix";
grant index on "informix".coverage_wu to "public" as "informix";
grant alter on "informix".coverage_wu to "public" as "informix";
grant references on "informix".coverage_wu to "public" as "informix";
grant select on "informix".skills_wu to "public" as "informix";
grant update on "informix".skills_wu to "public" as "informix";
grant insert on "informix".skills_wu to "public" as "informix";
grant delete on "informix".skills_wu to "public" as "informix";
grant index on "informix".skills_wu to "public" as "informix";
grant select on "informix".contacts_wu to "public" as "informix";
grant update on "informix".contacts_wu to "public" as "informix";
grant insert on "informix".contacts_wu to "public" as "informix";
grant delete on "informix".contacts_wu to "public" as "informix";
grant index on "informix".contacts_wu to "public" as "informix";
grant select on "informix".success_wu to "public" as "informix";
grant update on "informix".success_wu to "public" as "informix";
grant insert on "informix".success_wu to "public" as "informix";
grant delete on "informix".success_wu to "public" as "informix";
grant index on "informix".success_wu to "public" as "informix";
grant select on "informix".solutions to "public" as "informix";
grant update on "informix".solutions to "public" as "informix";
grant insert on "informix".solutions to "public" as "informix";
grant delete on "informix".solutions to "public" as "informix";
grant index on "informix".solutions to "public" as "informix";
grant select on "informix".coverage_io to "public" as "informix";
grant update on "informix".coverage_io to "public" as "informix";
grant insert on "informix".coverage_io to "public" as "informix";
grant delete on "informix".coverage_io to "public" as "informix";
grant index on "informix".coverage_io to "public" as "informix";
grant alter on "informix".coverage_io to "public" as "informix";
grant references on "informix".coverage_io to "public" as "informix";
grant select on "informix".success_io to "public" as "informix";
grant update on "informix".success_io to "public" as "informix";
grant insert on "informix".success_io to "public" as "informix";
grant delete on "informix".success_io to "public" as "informix";
grant index on "informix".success_io to "public" as "informix";
grant select on "informix".contacts_io to "public" as "informix";
grant update on "informix".contacts_io to "public" as "informix";
grant insert on "informix".contacts_io to "public" as "informix";
grant delete on "informix".contacts_io to "public" as "informix";
grant index on "informix".contacts_io to "public" as "informix";
grant select on "informix".skills_cu to "public" as "informix";
grant update on "informix".skills_cu to "public" as "informix";
grant insert on "informix".skills_cu to "public" as "informix";
grant delete on "informix".skills_cu to "public" as "informix";
grant index on "informix".skills_cu to "public" as "informix";
grant select on "informix".region to "public" as "informix";
grant update on "informix".region to "public" as "informix";
grant insert on "informix".region to "public" as "informix";
grant delete on "informix".region to "public" as "informix";
grant index on "informix".region to "public" as "informix";
grant select on "informix".import1 to "public" as "informix";
grant update on "informix".import1 to "public" as "informix";
grant insert on "informix".import1 to "public" as "informix";
grant delete on "informix".import1 to "public" as "informix";
grant index on "informix".import1 to "public" as "informix";
grant select on "informix".svp_sol_auth to "public" as "informix";
grant update on "informix".svp_sol_auth to "public" as "informix";
grant insert on "informix".svp_sol_auth to "public" as "informix";
grant delete on "informix".svp_sol_auth to "public" as "informix";
grant index on "informix".svp_sol_auth to "public" as "informix";
grant select on "informix".inst2 to "public" as "informix";
grant update on "informix".inst2 to "public" as "informix";
grant insert on "informix".inst2 to "public" as "informix";
grant delete on "informix".inst2 to "public" as "informix";
grant index on "informix".inst2 to "public" as "informix";
grant select on "informix".iness2 to "public" as "informix";
grant update on "informix".iness2 to "public" as "informix";
grant insert on "informix".iness2 to "public" as "informix";
grant delete on "informix".iness2 to "public" as "informix";
grant index on "informix".iness2 to "public" as "informix";
grant select on "informix".coverage_se to "public" as "informix";
grant update on "informix".coverage_se to "public" as "informix";
grant insert on "informix".coverage_se to "public" as "informix";
grant delete on "informix".coverage_se to "public" as "informix";
grant index on "informix".coverage_se to "public" as "informix";
grant alter on "informix".coverage_se to "public" as "informix";
grant references on "informix".coverage_se to "public" as "informix";
grant select on "informix".skills_se to "public" as "informix";
grant update on "informix".skills_se to "public" as "informix";
grant insert on "informix".skills_se to "public" as "informix";
grant delete on "informix".skills_se to "public" as "informix";
grant index on "informix".skills_se to "public" as "informix";
grant alter on "informix".skills_se to "public" as "informix";
grant references on "informix".skills_se to "public" as "informix";
grant select on "informix".ssrtab to "public" as "informix";
grant update on "informix".ssrtab to "public" as "informix";
grant insert on "informix".ssrtab to "public" as "informix";
grant delete on "informix".ssrtab to "public" as "informix";
grant index on "informix".ssrtab to "public" as "informix";
grant select on "informix".skills_b1 to "public" as "informix";
grant update on "informix".skills_b1 to "public" as "informix";
grant insert on "informix".skills_b1 to "public" as "informix";
grant delete on "informix".skills_b1 to "public" as "informix";
grant index on "informix".skills_b1 to "public" as "informix";
grant select on "informix".skills_b2 to "public" as "informix";
grant update on "informix".skills_b2 to "public" as "informix";
grant insert on "informix".skills_b2 to "public" as "informix";
grant delete on "informix".skills_b2 to "public" as "informix";
grant index on "informix".skills_b2 to "public" as "informix";
grant select on "informix".skills_b3 to "public" as "informix";
grant update on "informix".skills_b3 to "public" as "informix";
grant insert on "informix".skills_b3 to "public" as "informix";
grant delete on "informix".skills_b3 to "public" as "informix";
grant index on "informix".skills_b3 to "public" as "informix";
grant select on "informix".skills_b4 to "public" as "informix";
grant update on "informix".skills_b4 to "public" as "informix";
grant insert on "informix".skills_b4 to "public" as "informix";
grant delete on "informix".skills_b4 to "public" as "informix";
grant index on "informix".skills_b4 to "public" as "informix";
grant select on "informix".tmp_incom to "public" as "informix";
grant update on "informix".tmp_incom to "public" as "informix";
grant insert on "informix".tmp_incom to "public" as "informix";
grant delete on "informix".tmp_incom to "public" as "informix";
grant index on "informix".tmp_incom to "public" as "informix";
grant select on "informix".upd_log to "public" as "informix";
grant update on "informix".upd_log to "public" as "informix";
grant insert on "informix".upd_log to "public" as "informix";
grant delete on "informix".upd_log to "public" as "informix";
grant index on "informix".upd_log to "public" as "informix";
grant select on "informix".in_wat to "public" as "informix";
grant update on "informix".in_wat to "public" as "informix";
grant insert on "informix".in_wat to "public" as "informix";
grant delete on "informix".in_wat to "public" as "informix";
grant index on "informix".in_wat to "public" as "informix";
grant select on "informix".in_cu to "public" as "informix";
grant update on "informix".in_cu to "public" as "informix";
grant insert on "informix".in_cu to "public" as "informix";
grant delete on "informix".in_cu to "public" as "informix";
grant index on "informix".in_cu to "public" as "informix";
grant select on "informix".storage_cert to "public" as "informix";
grant update on "informix".storage_cert to "public" as "informix";
grant insert on "informix".storage_cert to "public" as "informix";
grant delete on "informix".storage_cert to "public" as "informix";
grant index on "informix".storage_cert to "public" as "informix";
grant select on "informix".in_st to "public" as "informix";
grant update on "informix".in_st to "public" as "informix";
grant insert on "informix".in_st to "public" as "informix";
grant delete on "informix".in_st to "public" as "informix";
grant index on "informix".in_st to "public" as "informix";
grant select on "informix".skills_sh to "public" as "informix";
grant update on "informix".skills_sh to "public" as "informix";
grant insert on "informix".skills_sh to "public" as "informix";
grant delete on "informix".skills_sh to "public" as "informix";
grant index on "informix".skills_sh to "public" as "informix";
grant select on "informix".skills_sv to "public" as "informix";
grant update on "informix".skills_sv to "public" as "informix";
grant insert on "informix".skills_sv to "public" as "informix";
grant delete on "informix".skills_sv to "public" as "informix";
grant index on "informix".skills_sv to "public" as "informix";
grant select on "informix".master to "public" as "informix";
grant update on "informix".master to "public" as "informix";
grant insert on "informix".master to "public" as "informix";
grant delete on "informix".master to "public" as "informix";
grant index on "informix".master to "public" as "informix";
grant select on "informix".coverextend_st_del to "public" as "informix";
grant update on "informix".coverextend_st_del to "public" as "informix";
grant insert on "informix".coverextend_st_del to "public" as "informix";
grant delete on "informix".coverextend_st_del to "public" as "informix";
grant index on "informix".coverextend_st_del to "public" as "informix";
grant select on "informix"._ind_colname to "public" as "informix";
grant update on "informix"._ind_colname to "public" as "informix";
grant insert on "informix"._ind_colname to "public" as "informix";
grant delete on "informix"._ind_colname to "public" as "informix";
grant index on "informix"._ind_colname to "public" as "informix";
grant select on "informix"._hci to "public" as "informix";
grant update on "informix"._hci to "public" as "informix";
grant insert on "informix"._hci to "public" as "informix";
grant delete on "informix"._hci to "public" as "informix";
grant index on "informix"._hci to "public" as "informix";
grant select on "informix"._hcc to "public" as "informix";
grant update on "informix"._hcc to "public" as "informix";
grant insert on "informix"._hcc to "public" as "informix";
grant delete on "informix"._hcc to "public" as "informix";
grant index on "informix"._hcc to "public" as "informix";
grant select on "informix".gsd_cat to "public" as "informix";
grant update on "informix".gsd_cat to "public" as "informix";
grant insert on "informix".gsd_cat to "public" as "informix";
grant delete on "informix".gsd_cat to "public" as "informix";
grant index on "informix".gsd_cat to "public" as "informix";
grant select on "informix".gsd to "public" as "informix";
grant update on "informix".gsd to "public" as "informix";
grant insert on "informix".gsd to "public" as "informix";
grant delete on "informix".gsd to "public" as "informix";
grant index on "informix".gsd to "public" as "informix";
grant select on "informix".comp to "public" as "informix";
grant update on "informix".comp to "public" as "informix";
grant insert on "informix".comp to "public" as "informix";
grant delete on "informix".comp to "public" as "informix";
grant index on "informix".comp to "public" as "informix";
grant select on "informix".competency_v1 to "public" as "informix";
grant update on "informix".competency_v1 to "public" as "informix";
grant insert on "informix".competency_v1 to "public" as "informix";
grant delete on "informix".competency_v1 to "public" as "informix";
grant index on "informix".competency_v1 to "public" as "informix";
grant select on "informix".brand_bu to "public" as "informix";
grant update on "informix".brand_bu to "public" as "informix";
grant insert on "informix".brand_bu to "public" as "informix";
grant delete on "informix".brand_bu to "public" as "informix";
grant index on "informix".brand_bu to "public" as "informix";
grant select on "informix".svp_info to "public" as "informix";
grant update on "informix".svp_info to "public" as "informix";
grant insert on "informix".svp_info to "public" as "informix";
grant delete on "informix".svp_info to "public" as "informix";
grant index on "informix".svp_info to "public" as "informix";
grant select on "informix".tags to "public" as "informix";
grant update on "informix".tags to "public" as "informix";
grant insert on "informix".tags to "public" as "informix";
grant delete on "informix".tags to "public" as "informix";
grant index on "informix".tags to "public" as "informix";
grant select on "informix".pod_info to "public" as "informix";
grant update on "informix".pod_info to "public" as "informix";
grant insert on "informix".pod_info to "public" as "informix";
grant delete on "informix".pod_info to "public" as "informix";
grant index on "informix".pod_info to "public" as "informix";
grant select on "informix".pod to "public" as "informix";
grant update on "informix".pod to "public" as "informix";
grant insert on "informix".pod to "public" as "informix";
grant delete on "informix".pod to "public" as "informix";
grant index on "informix".pod to "public" as "informix";
grant select on "informix"._tmpsu to "public" as "informix";
grant update on "informix"._tmpsu to "public" as "informix";
grant insert on "informix"._tmpsu to "public" as "informix";
grant delete on "informix"._tmpsu to "public" as "informix";
grant index on "informix"._tmpsu to "public" as "informix";
grant select on "informix"._tmpau to "public" as "informix";
grant update on "informix"._tmpau to "public" as "informix";
grant insert on "informix"._tmpau to "public" as "informix";
grant delete on "informix"._tmpau to "public" as "informix";
grant index on "informix"._tmpau to "public" as "informix";
grant select on "informix".vap to "public" as "informix";
grant update on "informix".vap to "public" as "informix";
grant insert on "informix".vap to "public" as "informix";
grant delete on "informix".vap to "public" as "informix";
grant index on "informix".vap to "public" as "informix";
grant select on "informix".fcast_au_okdel to "public" as "informix";
grant update on "informix".fcast_au_okdel to "public" as "informix";
grant insert on "informix".fcast_au_okdel to "public" as "informix";
grant delete on "informix".fcast_au_okdel to "public" as "informix";
grant index on "informix".fcast_au_okdel to "public" as "informix";
grant select on "informix".fcast_comments_au to "public" as "informix";
grant update on "informix".fcast_comments_au to "public" as "informix";
grant insert on "informix".fcast_comments_au to "public" as "informix";
grant delete on "informix".fcast_comments_au to "public" as "informix";
grant index on "informix".fcast_comments_au to "public" as "informix";
grant select on "informix".fcast_bpr to "public" as "informix";
grant update on "informix".fcast_bpr to "public" as "informix";
grant insert on "informix".fcast_bpr to "public" as "informix";
grant delete on "informix".fcast_bpr to "public" as "informix";
grant index on "informix".fcast_bpr to "public" as "informix";
grant select on "informix".flu_flowcode to "public" as "informix";
grant update on "informix".flu_flowcode to "public" as "informix";
grant insert on "informix".flu_flowcode to "public" as "informix";
grant delete on "informix".flu_flowcode to "public" as "informix";
grant index on "informix".flu_flowcode to "public" as "informix";
grant select on "informix".flu_stat to "public" as "informix";
grant update on "informix".flu_stat to "public" as "informix";
grant insert on "informix".flu_stat to "public" as "informix";
grant delete on "informix".flu_stat to "public" as "informix";
grant index on "informix".flu_stat to "public" as "informix";
grant select on "informix".flu_revtype to "public" as "informix";
grant update on "informix".flu_revtype to "public" as "informix";
grant insert on "informix".flu_revtype to "public" as "informix";
grant delete on "informix".flu_revtype to "public" as "informix";
grant index on "informix".flu_revtype to "public" as "informix";
grant select on "informix".flu_iot to "public" as "informix";
grant update on "informix".flu_iot to "public" as "informix";
grant insert on "informix".flu_iot to "public" as "informix";
grant delete on "informix".flu_iot to "public" as "informix";
grant index on "informix".flu_iot to "public" as "informix";
grant select on "informix".flu_country to "public" as "informix";
grant update on "informix".flu_country to "public" as "informix";
grant insert on "informix".flu_country to "public" as "informix";
grant delete on "informix".flu_country to "public" as "informix";
grant index on "informix".flu_country to "public" as "informix";
grant select on "informix".flu_brand_grp to "public" as "informix";
grant update on "informix".flu_brand_grp to "public" as "informix";
grant insert on "informix".flu_brand_grp to "public" as "informix";
grant delete on "informix".flu_brand_grp to "public" as "informix";
grant index on "informix".flu_brand_grp to "public" as "informix";
grant select on "informix".flu_brand to "public" as "informix";
grant update on "informix".flu_brand to "public" as "informix";
grant insert on "informix".flu_brand to "public" as "informix";
grant delete on "informix".flu_brand to "public" as "informix";
grant index on "informix".flu_brand to "public" as "informix";
grant select on "informix".flu_ssmstep to "public" as "informix";
grant update on "informix".flu_ssmstep to "public" as "informix";
grant insert on "informix".flu_ssmstep to "public" as "informix";
grant delete on "informix".flu_ssmstep to "public" as "informix";
grant index on "informix".flu_ssmstep to "public" as "informix";
grant select on "informix".flu_owning_org to "public" as "informix";
grant update on "informix".flu_owning_org to "public" as "informix";
grant insert on "informix".flu_owning_org to "public" as "informix";
grant delete on "informix".flu_owning_org to "public" as "informix";
grant index on "informix".flu_owning_org to "public" as "informix";
grant select on "informix".flu_prod_seg to "public" as "informix";
grant update on "informix".flu_prod_seg to "public" as "informix";
grant insert on "informix".flu_prod_seg to "public" as "informix";
grant delete on "informix".flu_prod_seg to "public" as "informix";
grant index on "informix".flu_prod_seg to "public" as "informix";
grant select on "informix".flu_prod_fam to "public" as "informix";
grant update on "informix".flu_prod_fam to "public" as "informix";
grant insert on "informix".flu_prod_fam to "public" as "informix";
grant delete on "informix".flu_prod_fam to "public" as "informix";
grant index on "informix".flu_prod_fam to "public" as "informix";
grant select on "informix".fcast_au to "public" as "informix";
grant update on "informix".fcast_au to "public" as "informix";
grant insert on "informix".fcast_au to "public" as "informix";
grant delete on "informix".fcast_au to "public" as "informix";
grant index on "informix".fcast_au to "public" as "informix";
grant alter on "informix".fcast_au to "public" as "informix";
grant references on "informix".fcast_au to "public" as "informix";
grant select on "informix".market to "public" as "informix";
grant update on "informix".market to "public" as "informix";
grant insert on "informix".market to "public" as "informix";
grant delete on "informix".market to "public" as "informix";
grant index on "informix".market to "public" as "informix";
grant select on "informix".flu_oppty_stat to "public" as "informix";
grant update on "informix".flu_oppty_stat to "public" as "informix";
grant insert on "informix".flu_oppty_stat to "public" as "informix";
grant delete on "informix".flu_oppty_stat to "public" as "informix";
grant index on "informix".flu_oppty_stat to "public" as "informix";
grant select on "informix"._inpower to "public" as "informix";
grant update on "informix"._inpower to "public" as "informix";
grant insert on "informix"._inpower to "public" as "informix";
grant delete on "informix"._inpower to "public" as "informix";
grant index on "informix"._inpower to "public" as "informix";
grant select on "informix".skills_ag to "public" as "informix";
grant update on "informix".skills_ag to "public" as "informix";
grant insert on "informix".skills_ag to "public" as "informix";
grant delete on "informix".skills_ag to "public" as "informix";
grant index on "informix".skills_ag to "public" as "informix";
grant select on "informix".tmpt1 to "public" as "informix";
grant update on "informix".tmpt1 to "public" as "informix";
grant insert on "informix".tmpt1 to "public" as "informix";
grant delete on "informix".tmpt1 to "public" as "informix";
grant index on "informix".tmpt1 to "public" as "informix";
grant select on "informix".authorization to "public" as "informix";
grant update on "informix".authorization to "public" as "informix";
grant insert on "informix".authorization to "public" as "informix";
grant delete on "informix".authorization to "public" as "informix";
grant index on "informix".authorization to "public" as "informix";
grant select on "informix".access_cnt to "public" as "informix";
grant update on "informix".access_cnt to "public" as "informix";
grant insert on "informix".access_cnt to "public" as "informix";
grant delete on "informix".access_cnt to "public" as "informix";
grant index on "informix".access_cnt to "public" as "informix";
grant select on "informix".access_page to "public" as "informix";
grant update on "informix".access_page to "public" as "informix";
grant insert on "informix".access_page to "public" as "informix";
grant delete on "informix".access_page to "public" as "informix";
grant index on "informix".access_page to "public" as "informix";
grant select on "informix"._sunew2 to "public" as "informix";
grant update on "informix"._sunew2 to "public" as "informix";
grant insert on "informix"._sunew2 to "public" as "informix";
grant delete on "informix"._sunew2 to "public" as "informix";
grant index on "informix"._sunew2 to "public" as "informix";
grant select on "informix".access_fap to "public" as "informix";
grant update on "informix".access_fap to "public" as "informix";
grant insert on "informix".access_fap to "public" as "informix";
grant delete on "informix".access_fap to "public" as "informix";
grant index on "informix".access_fap to "public" as "informix";
grant select on "informix".oldcomp to "public" as "informix";
grant update on "informix".oldcomp to "public" as "informix";
grant insert on "informix".oldcomp to "public" as "informix";
grant delete on "informix".oldcomp to "public" as "informix";
grant index on "informix".oldcomp to "public" as "informix";
grant select on "informix".review to "public" as "informix";
grant update on "informix".review to "public" as "informix";
grant insert on "informix".review to "public" as "informix";
grant delete on "informix".review to "public" as "informix";
grant index on "informix".review to "public" as "informix";
grant select on "informix".gsd_solutions to "public" as "informix";
grant update on "informix".gsd_solutions to "public" as "informix";
grant insert on "informix".gsd_solutions to "public" as "informix";
grant delete on "informix".gsd_solutions to "public" as "informix";
grant index on "informix".gsd_solutions to "public" as "informix";
grant select on "informix".act_initiative to "public" as "informix";
grant update on "informix".act_initiative to "public" as "informix";
grant insert on "informix".act_initiative to "public" as "informix";
grant delete on "informix".act_initiative to "public" as "informix";
grant index on "informix".act_initiative to "public" as "informix";
grant select on "informix".activity to "public" as "informix";
grant update on "informix".activity to "public" as "informix";
grant insert on "informix".activity to "public" as "informix";
grant delete on "informix".activity to "public" as "informix";
grant index on "informix".activity to "public" as "informix";
grant select on "informix".target to "public" as "informix";
grant update on "informix".target to "public" as "informix";
grant insert on "informix".target to "public" as "informix";
grant delete on "informix".target to "public" as "informix";
grant index on "informix".target to "public" as "informix";
grant select on "informix".alu_type to "public" as "informix";
grant update on "informix".alu_type to "public" as "informix";
grant insert on "informix".alu_type to "public" as "informix";
grant delete on "informix".alu_type to "public" as "informix";
grant index on "informix".alu_type to "public" as "informix";
grant select on "informix".alu_status to "public" as "informix";
grant update on "informix".alu_status to "public" as "informix";
grant insert on "informix".alu_status to "public" as "informix";
grant delete on "informix".alu_status to "public" as "informix";
grant index on "informix".alu_status to "public" as "informix";
grant select on "informix".library_det to "public" as "informix";
grant update on "informix".library_det to "public" as "informix";
grant insert on "informix".library_det to "public" as "informix";
grant delete on "informix".library_det to "public" as "informix";
grant index on "informix".library_det to "public" as "informix";
grant select on "informix".library to "public" as "informix";
grant update on "informix".library to "public" as "informix";
grant insert on "informix".library to "public" as "informix";
grant delete on "informix".library to "public" as "informix";
grant index on "informix".library to "public" as "informix";
grant select on "informix".skills_a1 to "public" as "informix";
grant update on "informix".skills_a1 to "public" as "informix";
grant insert on "informix".skills_a1 to "public" as "informix";
grant delete on "informix".skills_a1 to "public" as "informix";
grant index on "informix".skills_a1 to "public" as "informix";
grant select on "informix".skills_a2 to "public" as "informix";
grant update on "informix".skills_a2 to "public" as "informix";
grant insert on "informix".skills_a2 to "public" as "informix";
grant delete on "informix".skills_a2 to "public" as "informix";
grant index on "informix".skills_a2 to "public" as "informix";
grant select on "informix".skills_a3 to "public" as "informix";
grant update on "informix".skills_a3 to "public" as "informix";
grant insert on "informix".skills_a3 to "public" as "informix";
grant delete on "informix".skills_a3 to "public" as "informix";
grant index on "informix".skills_a3 to "public" as "informix";
grant select on "informix".skills_a4 to "public" as "informix";
grant update on "informix".skills_a4 to "public" as "informix";
grant insert on "informix".skills_a4 to "public" as "informix";
grant delete on "informix".skills_a4 to "public" as "informix";
grant index on "informix".skills_a4 to "public" as "informix";
grant select on "informix".skills_a5 to "public" as "informix";
grant update on "informix".skills_a5 to "public" as "informix";
grant insert on "informix".skills_a5 to "public" as "informix";
grant delete on "informix".skills_a5 to "public" as "informix";
grant index on "informix".skills_a5 to "public" as "informix";
grant select on "informix".curr_revenue to "public" as "informix";
grant update on "informix".curr_revenue to "public" as "informix";
grant insert on "informix".curr_revenue to "public" as "informix";
grant delete on "informix".curr_revenue to "public" as "informix";
grant index on "informix".curr_revenue to "public" as "informix";
grant select on "informix"._iness to "public" as "informix";
grant update on "informix"._iness to "public" as "informix";
grant insert on "informix"._iness to "public" as "informix";
grant delete on "informix"._iness to "public" as "informix";
grant index on "informix"._iness to "public" as "informix";
grant select on "informix".featsols to "public" as "informix";
grant update on "informix".featsols to "public" as "informix";
grant insert on "informix".featsols to "public" as "informix";
grant delete on "informix".featsols to "public" as "informix";
grant index on "informix".featsols to "public" as "informix";
grant select on "informix"._inau to "public" as "informix";
grant update on "informix"._inau to "public" as "informix";
grant insert on "informix"._inau to "public" as "informix";
grant delete on "informix"._inau to "public" as "informix";
grant index on "informix"._inau to "public" as "informix";
grant select on "informix".coverage_nc to "public" as "informix";
grant update on "informix".coverage_nc to "public" as "informix";
grant insert on "informix".coverage_nc to "public" as "informix";
grant delete on "informix".coverage_nc to "public" as "informix";
grant index on "informix".coverage_nc to "public" as "informix";
grant select on "informix".contacts_nc to "public" as "informix";
grant update on "informix".contacts_nc to "public" as "informix";
grant insert on "informix".contacts_nc to "public" as "informix";
grant delete on "informix".contacts_nc to "public" as "informix";
grant index on "informix".contacts_nc to "public" as "informix";
grant select on "informix".success_nc to "public" as "informix";
grant update on "informix".success_nc to "public" as "informix";
grant insert on "informix".success_nc to "public" as "informix";
grant delete on "informix".success_nc to "public" as "informix";
grant index on "informix".success_nc to "public" as "informix";
grant select on "informix"._innc to "public" as "informix";
grant update on "informix"._innc to "public" as "informix";
grant insert on "informix"._innc to "public" as "informix";
grant delete on "informix"._innc to "public" as "informix";
grant index on "informix"._innc to "public" as "informix";
grant select on "informix".activity_nc to "public" as "informix";
grant update on "informix".activity_nc to "public" as "informix";
grant insert on "informix".activity_nc to "public" as "informix";
grant delete on "informix".activity_nc to "public" as "informix";
grant index on "informix".activity_nc to "public" as "informix";
grant select on "informix".act_init_nc to "public" as "informix";
grant update on "informix".act_init_nc to "public" as "informix";
grant insert on "informix".act_init_nc to "public" as "informix";
grant delete on "informix".act_init_nc to "public" as "informix";
grant index on "informix".act_init_nc to "public" as "informix";
grant select on "informix"._inst to "public" as "informix";
grant update on "informix"._inst to "public" as "informix";
grant insert on "informix"._inst to "public" as "informix";
grant delete on "informix"._inst to "public" as "informix";
grant index on "informix"._inst to "public" as "informix";
grant select on "informix".skills_n1 to "public" as "informix";
grant update on "informix".skills_n1 to "public" as "informix";
grant insert on "informix".skills_n1 to "public" as "informix";
grant delete on "informix".skills_n1 to "public" as "informix";
grant index on "informix".skills_n1 to "public" as "informix";
grant select on "informix".skills_n2 to "public" as "informix";
grant update on "informix".skills_n2 to "public" as "informix";
grant insert on "informix".skills_n2 to "public" as "informix";
grant delete on "informix".skills_n2 to "public" as "informix";
grant index on "informix".skills_n2 to "public" as "informix";
grant select on "informix".skills_n3 to "public" as "informix";
grant update on "informix".skills_n3 to "public" as "informix";
grant insert on "informix".skills_n3 to "public" as "informix";
grant delete on "informix".skills_n3 to "public" as "informix";
grant index on "informix".skills_n3 to "public" as "informix";
grant select on "informix".skills_n4 to "public" as "informix";
grant update on "informix".skills_n4 to "public" as "informix";
grant insert on "informix".skills_n4 to "public" as "informix";
grant delete on "informix".skills_n4 to "public" as "informix";
grant index on "informix".skills_n4 to "public" as "informix";
grant select on "informix".skills_n5 to "public" as "informix";
grant update on "informix".skills_n5 to "public" as "informix";
grant insert on "informix".skills_n5 to "public" as "informix";
grant delete on "informix".skills_n5 to "public" as "informix";
grant index on "informix".skills_n5 to "public" as "informix";
grant select on "informix".skills_n6 to "public" as "informix";
grant update on "informix".skills_n6 to "public" as "informix";
grant insert on "informix".skills_n6 to "public" as "informix";
grant delete on "informix".skills_n6 to "public" as "informix";
grant index on "informix".skills_n6 to "public" as "informix";
grant select on "informix".skills_n7 to "public" as "informix";
grant update on "informix".skills_n7 to "public" as "informix";
grant insert on "informix".skills_n7 to "public" as "informix";
grant delete on "informix".skills_n7 to "public" as "informix";
grant index on "informix".skills_n7 to "public" as "informix";
grant select on "informix".competency to "public" as "informix";
grant update on "informix".competency to "public" as "informix";
grant insert on "informix".competency to "public" as "informix";
grant delete on "informix".competency to "public" as "informix";
grant index on "informix".competency to "public" as "informix";
grant select on "informix".coverage_mc to "public" as "informix";
grant update on "informix".coverage_mc to "public" as "informix";
grant insert on "informix".coverage_mc to "public" as "informix";
grant delete on "informix".coverage_mc to "public" as "informix";
grant index on "informix".coverage_mc to "public" as "informix";
grant alter on "informix".coverage_mc to "public" as "informix";
grant references on "informix".coverage_mc to "public" as "informix";
grant select on "informix".success_mc to "public" as "informix";
grant update on "informix".success_mc to "public" as "informix";
grant insert on "informix".success_mc to "public" as "informix";
grant delete on "informix".success_mc to "public" as "informix";
grant index on "informix".success_mc to "public" as "informix";
grant alter on "informix".success_mc to "public" as "informix";
grant references on "informix".success_mc to "public" as "informix";
grant select on "informix".success_md to "public" as "informix";
grant update on "informix".success_md to "public" as "informix";
grant insert on "informix".success_md to "public" as "informix";
grant delete on "informix".success_md to "public" as "informix";
grant index on "informix".success_md to "public" as "informix";
grant alter on "informix".success_md to "public" as "informix";
grant references on "informix".success_md to "public" as "informix";
grant select on "informix".success_mf to "public" as "informix";
grant update on "informix".success_mf to "public" as "informix";
grant insert on "informix".success_mf to "public" as "informix";
grant delete on "informix".success_mf to "public" as "informix";
grant index on "informix".success_mf to "public" as "informix";
grant alter on "informix".success_mf to "public" as "informix";
grant references on "informix".success_mf to "public" as "informix";
grant select on "informix".success_mi to "public" as "informix";
grant update on "informix".success_mi to "public" as "informix";
grant insert on "informix".success_mi to "public" as "informix";
grant delete on "informix".success_mi to "public" as "informix";
grant index on "informix".success_mi to "public" as "informix";
grant alter on "informix".success_mi to "public" as "informix";
grant references on "informix".success_mi to "public" as "informix";
grant select on "informix".success_mp to "public" as "informix";
grant update on "informix".success_mp to "public" as "informix";
grant insert on "informix".success_mp to "public" as "informix";
grant delete on "informix".success_mp to "public" as "informix";
grant index on "informix".success_mp to "public" as "informix";
grant alter on "informix".success_mp to "public" as "informix";
grant references on "informix".success_mp to "public" as "informix";
grant select on "informix".skills_i1 to "public" as "informix";
grant update on "informix".skills_i1 to "public" as "informix";
grant insert on "informix".skills_i1 to "public" as "informix";
grant delete on "informix".skills_i1 to "public" as "informix";
grant index on "informix".skills_i1 to "public" as "informix";
grant select on "informix".skills_i2 to "public" as "informix";
grant update on "informix".skills_i2 to "public" as "informix";
grant insert on "informix".skills_i2 to "public" as "informix";
grant delete on "informix".skills_i2 to "public" as "informix";
grant index on "informix".skills_i2 to "public" as "informix";
grant select on "informix".skills_i3 to "public" as "informix";
grant update on "informix".skills_i3 to "public" as "informix";
grant insert on "informix".skills_i3 to "public" as "informix";
grant delete on "informix".skills_i3 to "public" as "informix";
grant index on "informix".skills_i3 to "public" as "informix";
grant select on "informix".fcast_nc to "public" as "informix";
grant update on "informix".fcast_nc to "public" as "informix";
grant insert on "informix".fcast_nc to "public" as "informix";
grant delete on "informix".fcast_nc to "public" as "informix";
grant index on "informix".fcast_nc to "public" as "informix";
grant alter on "informix".fcast_nc to "public" as "informix";
grant references on "informix".fcast_nc to "public" as "informix";
grant select on "informix".fcast_comments_nc to "public" as "informix";
grant update on "informix".fcast_comments_nc to "public" as "informix";
grant insert on "informix".fcast_comments_nc to "public" as "informix";
grant delete on "informix".fcast_comments_nc to "public" as "informix";
grant index on "informix".fcast_comments_nc to "public" as "informix";
grant alter on "informix".fcast_comments_nc to "public" as "informix";
grant references on "informix".fcast_comments_nc to "public" as "informix";
grant select on "informix"._iniot to "public" as "informix";
grant update on "informix"._iniot to "public" as "informix";
grant insert on "informix"._iniot to "public" as "informix";
grant delete on "informix"._iniot to "public" as "informix";
grant index on "informix"._iniot to "public" as "informix";
grant select on "informix".certs to "public" as "informix";
grant update on "informix".certs to "public" as "informix";
grant insert on "informix".certs to "public" as "informix";
grant delete on "informix".certs to "public" as "informix";
grant index on "informix".certs to "public" as "informix";
grant select on "informix".skills_i4 to "public" as "informix";
grant update on "informix".skills_i4 to "public" as "informix";
grant insert on "informix".skills_i4 to "public" as "informix";
grant delete on "informix".skills_i4 to "public" as "informix";
grant index on "informix".skills_i4 to "public" as "informix";

revoke usage on language SPL from public ;

grant usage on language SPL to public ;


create view "informix".reps2 (r_name,r_link) as 
  select x0.r_name ,x0.r_link from "informix".reps x0 ;        
                                                             
                                                             
                                     
create view "informix".eus2 (e_brand,e_region,e_id,e_name,e_ssr,e_ctp) as 
  select x0.e_brand ,x0.e_region ,x0.e_id ,x0.e_name ,x0.e_ssr 
    ,x0.e_ctp from "informix".eus x0 ;                        
                                                             
          
create view "informix".reps3 (r_name,r_link) as 
  select x0.r_name ,x0.r_link from "informix".reps x0 ;        
                                                             
                                                             
                                     
create view "informix".reps4 (r_name,r_link) as 
  select x0.r_name ,x0.r_link from "informix".reps x0 ;        
                                                             
                                                             
                                     
create view "informix".reps6 (r_name,r_link) as 
  select x0.r_name ,x0.r_link from "informix".reps x0 ;        
                                                             
                                                             
                                     
create view "informix".reps5 (r_name,r_link) as 
  select x0.r_name ,x0.r_link from "informix".reps x0 ;        
                                                             
                                                             
                                     
create view "informix".coverage_md (ceid,vad,hq,part_type,reseller,prog_status,note,lead,tier,part_name,part_name_abbr,ssr,ctp1,ctp2,ctp3,ctp4,ctp5,eu_pacificnw,eu_northca,eu_southwest,eu_northern,eu_plains,eu_heartland,eu_texas,eu_midamerica,eu_ohio,eu_southeast,eu_sunshine,eu_northeast,eu_ny,eu_garden,eu_delaware,eu_potomac,eu_carolinas,eu_ca,eu_fed,ind_eu,ind_tel,ind_me,ind_ret,ind_wd,ind_trans,ind_bank,ind_ins,ind_mfg,ind_hl,ind_gov,ind_cross,ind_auto,ind_csi,ind_chem,ind_consume,ind_defense,ind_elect,ind_finan,ind_indprod,ind_lifesci,ind_fed,ind_can,ind_education,pod,url,pwp,desc,p_name,p_title,p_phone,p_email,focus1,focus2,focus3,partners_well,hunter,lap,dfm,commercial,enterprise,industry,updtime) as 
  select x0.ceid ,x0.vad ,x0.hq ,x0.part_type ,x0.reseller ,x0.prog_status 
    ,x0.note ,x0.lead ,x0.tier ,x0.part_name ,x0.part_name_abbr 
    ,x0.ssr ,x0.ctp1 ,x0.ctp2 ,x0.ctp3 ,x0.ctp4 ,x0.ctp5 ,x0.eu_pacificnw 
    ,x0.eu_northca ,x0.eu_southwest ,x0.eu_northern ,x0.eu_plains 
    ,x0.eu_heartland ,x0.eu_texas ,x0.eu_midamerica ,x0.eu_ohio 
    ,x0.eu_southeast ,x0.eu_sunshine ,x0.eu_northeast ,x0.eu_ny 
    ,x0.eu_garden ,x0.eu_delaware ,x0.eu_potomac ,x0.eu_carolinas 
    ,x0.eu_ca ,x0.eu_fed ,x0.ind_eu ,x0.ind_tel ,x0.ind_me ,x0.ind_ret 
    ,x0.ind_wd ,x0.ind_trans ,x0.ind_bank ,x0.ind_ins ,x0.ind_mfg 
    ,x0.ind_hl ,x0.ind_gov ,x0.ind_cross ,x0.ind_auto ,x0.ind_csi 
    ,x0.ind_chem ,x0.ind_consume ,x0.ind_defense ,x0.ind_elect 
    ,x0.ind_finan ,x0.ind_indprod ,x0.ind_lifesci ,x0.ind_fed 
    ,x0.ind_can ,x0.ind_education ,x0.pod ,x0.url ,x0.pwp ,x0.desc 
    ,x0.p_name ,x0.p_title ,x0.p_phone ,x0.p_email ,x0.focus1 
    ,x0.focus2 ,x0.focus3 ,x0.partners_well ,x0.hunter ,x0.lap 
    ,x0.dfm ,x0.commercial ,x0.enterprise ,x0.industry ,x0.updtime 
    from "informix".coverage_mc x0 ;                          
                        
create view "informix".coverage_mf (ceid,vad,hq,part_type,reseller,prog_status,note,lead,tier,part_name,part_name_abbr,ssr,ctp1,ctp2,ctp3,ctp4,ctp5,eu_pacificnw,eu_northca,eu_southwest,eu_northern,eu_plains,eu_heartland,eu_texas,eu_midamerica,eu_ohio,eu_southeast,eu_sunshine,eu_northeast,eu_ny,eu_garden,eu_delaware,eu_potomac,eu_carolinas,eu_ca,eu_fed,ind_eu,ind_tel,ind_me,ind_ret,ind_wd,ind_trans,ind_bank,ind_ins,ind_mfg,ind_hl,ind_gov,ind_cross,ind_auto,ind_csi,ind_chem,ind_consume,ind_defense,ind_elect,ind_finan,ind_indprod,ind_lifesci,ind_fed,ind_can,ind_education,pod,url,pwp,desc,p_name,p_title,p_phone,p_email,focus1,focus2,focus3,partners_well,hunter,lap,dfm,commercial,enterprise,industry,updtime) as 
  select x0.ceid ,x0.vad ,x0.hq ,x0.part_type ,x0.reseller ,x0.prog_status 
    ,x0.note ,x0.lead ,x0.tier ,x0.part_name ,x0.part_name_abbr 
    ,x0.ssr ,x0.ctp1 ,x0.ctp2 ,x0.ctp3 ,x0.ctp4 ,x0.ctp5 ,x0.eu_pacificnw 
    ,x0.eu_northca ,x0.eu_southwest ,x0.eu_northern ,x0.eu_plains 
    ,x0.eu_heartland ,x0.eu_texas ,x0.eu_midamerica ,x0.eu_ohio 
    ,x0.eu_southeast ,x0.eu_sunshine ,x0.eu_northeast ,x0.eu_ny 
    ,x0.eu_garden ,x0.eu_delaware ,x0.eu_potomac ,x0.eu_carolinas 
    ,x0.eu_ca ,x0.eu_fed ,x0.ind_eu ,x0.ind_tel ,x0.ind_me ,x0.ind_ret 
    ,x0.ind_wd ,x0.ind_trans ,x0.ind_bank ,x0.ind_ins ,x0.ind_mfg 
    ,x0.ind_hl ,x0.ind_gov ,x0.ind_cross ,x0.ind_auto ,x0.ind_csi 
    ,x0.ind_chem ,x0.ind_consume ,x0.ind_defense ,x0.ind_elect 
    ,x0.ind_finan ,x0.ind_indprod ,x0.ind_lifesci ,x0.ind_fed 
    ,x0.ind_can ,x0.ind_education ,x0.pod ,x0.url ,x0.pwp ,x0.desc 
    ,x0.p_name ,x0.p_title ,x0.p_phone ,x0.p_email ,x0.focus1 
    ,x0.focus2 ,x0.focus3 ,x0.partners_well ,x0.hunter ,x0.lap 
    ,x0.dfm ,x0.commercial ,x0.enterprise ,x0.industry ,x0.updtime 
    from "informix".coverage_mc x0 ;                          
                        
create view "informix".coverage_mi (ceid,vad,hq,part_type,reseller,prog_status,note,lead,tier,part_name,part_name_abbr,ssr,ctp1,ctp2,ctp3,ctp4,ctp5,eu_pacificnw,eu_northca,eu_southwest,eu_northern,eu_plains,eu_heartland,eu_texas,eu_midamerica,eu_ohio,eu_southeast,eu_sunshine,eu_northeast,eu_ny,eu_garden,eu_delaware,eu_potomac,eu_carolinas,eu_ca,eu_fed,ind_eu,ind_tel,ind_me,ind_ret,ind_wd,ind_trans,ind_bank,ind_ins,ind_mfg,ind_hl,ind_gov,ind_cross,ind_auto,ind_csi,ind_chem,ind_consume,ind_defense,ind_elect,ind_finan,ind_indprod,ind_lifesci,ind_fed,ind_can,ind_education,pod,url,pwp,desc,p_name,p_title,p_phone,p_email,focus1,focus2,focus3,partners_well,hunter,lap,dfm,commercial,enterprise,industry,updtime) as 
  select x0.ceid ,x0.vad ,x0.hq ,x0.part_type ,x0.reseller ,x0.prog_status 
    ,x0.note ,x0.lead ,x0.tier ,x0.part_name ,x0.part_name_abbr 
    ,x0.ssr ,x0.ctp1 ,x0.ctp2 ,x0.ctp3 ,x0.ctp4 ,x0.ctp5 ,x0.eu_pacificnw 
    ,x0.eu_northca ,x0.eu_southwest ,x0.eu_northern ,x0.eu_plains 
    ,x0.eu_heartland ,x0.eu_texas ,x0.eu_midamerica ,x0.eu_ohio 
    ,x0.eu_southeast ,x0.eu_sunshine ,x0.eu_northeast ,x0.eu_ny 
    ,x0.eu_garden ,x0.eu_delaware ,x0.eu_potomac ,x0.eu_carolinas 
    ,x0.eu_ca ,x0.eu_fed ,x0.ind_eu ,x0.ind_tel ,x0.ind_me ,x0.ind_ret 
    ,x0.ind_wd ,x0.ind_trans ,x0.ind_bank ,x0.ind_ins ,x0.ind_mfg 
    ,x0.ind_hl ,x0.ind_gov ,x0.ind_cross ,x0.ind_auto ,x0.ind_csi 
    ,x0.ind_chem ,x0.ind_consume ,x0.ind_defense ,x0.ind_elect 
    ,x0.ind_finan ,x0.ind_indprod ,x0.ind_lifesci ,x0.ind_fed 
    ,x0.ind_can ,x0.ind_education ,x0.pod ,x0.url ,x0.pwp ,x0.desc 
    ,x0.p_name ,x0.p_title ,x0.p_phone ,x0.p_email ,x0.focus1 
    ,x0.focus2 ,x0.focus3 ,x0.partners_well ,x0.hunter ,x0.lap 
    ,x0.dfm ,x0.commercial ,x0.enterprise ,x0.industry ,x0.updtime 
    from "informix".coverage_mc x0 ;                          
                        
create view "informix".coverage_mp (ceid,vad,hq,part_type,reseller,prog_status,note,lead,tier,part_name,part_name_abbr,ssr,ctp1,ctp2,ctp3,ctp4,ctp5,eu_pacificnw,eu_northca,eu_southwest,eu_northern,eu_plains,eu_heartland,eu_texas,eu_midamerica,eu_ohio,eu_southeast,eu_sunshine,eu_northeast,eu_ny,eu_garden,eu_delaware,eu_potomac,eu_carolinas,eu_ca,eu_fed,ind_eu,ind_tel,ind_me,ind_ret,ind_wd,ind_trans,ind_bank,ind_ins,ind_mfg,ind_hl,ind_gov,ind_cross,ind_auto,ind_csi,ind_chem,ind_consume,ind_defense,ind_elect,ind_finan,ind_indprod,ind_lifesci,ind_fed,ind_can,ind_education,pod,url,pwp,desc,p_name,p_title,p_phone,p_email,focus1,focus2,focus3,partners_well,hunter,lap,dfm,commercial,enterprise,industry,updtime) as 
  select x0.ceid ,x0.vad ,x0.hq ,x0.part_type ,x0.reseller ,x0.prog_status 
    ,x0.note ,x0.lead ,x0.tier ,x0.part_name ,x0.part_name_abbr 
    ,x0.ssr ,x0.ctp1 ,x0.ctp2 ,x0.ctp3 ,x0.ctp4 ,x0.ctp5 ,x0.eu_pacificnw 
    ,x0.eu_northca ,x0.eu_southwest ,x0.eu_northern ,x0.eu_plains 
    ,x0.eu_heartland ,x0.eu_texas ,x0.eu_midamerica ,x0.eu_ohio 
    ,x0.eu_southeast ,x0.eu_sunshine ,x0.eu_northeast ,x0.eu_ny 
    ,x0.eu_garden ,x0.eu_delaware ,x0.eu_potomac ,x0.eu_carolinas 
    ,x0.eu_ca ,x0.eu_fed ,x0.ind_eu ,x0.ind_tel ,x0.ind_me ,x0.ind_ret 
    ,x0.ind_wd ,x0.ind_trans ,x0.ind_bank ,x0.ind_ins ,x0.ind_mfg 
    ,x0.ind_hl ,x0.ind_gov ,x0.ind_cross ,x0.ind_auto ,x0.ind_csi 
    ,x0.ind_chem ,x0.ind_consume ,x0.ind_defense ,x0.ind_elect 
    ,x0.ind_finan ,x0.ind_indprod ,x0.ind_lifesci ,x0.ind_fed 
    ,x0.ind_can ,x0.ind_education ,x0.pod ,x0.url ,x0.pwp ,x0.desc 
    ,x0.p_name ,x0.p_title ,x0.p_phone ,x0.p_email ,x0.focus1 
    ,x0.focus2 ,x0.focus3 ,x0.partners_well ,x0.hunter ,x0.lap 
    ,x0.dfm ,x0.commercial ,x0.enterprise ,x0.industry ,x0.updtime 
    from "informix".coverage_mc x0 ;                          
                        

create unique index "informix".r1_idx on "informix".reps (r_name) 
    using btree  in data1dbs;
create unique index "informix".r2_idx on "informix".reps (r_name,
    b_id) using btree  in data1dbs;
create index "informix".r3_idx on "informix".reps (b_id) using 
    btree  in data1dbs;
create unique index "informix".vuid1 on "informix".vads (v_id) 
    using btree  in data1dbs;
create index "informix".busidx1 on "informix".bus (b_brand) using 
    btree  in data1dbs;
create index "informix".svp2 on "informix".svp (bptv_name) using 
    btree  in data1dbs;
create index "informix".svp4 on "informix".svp (svp_name) using 
    btree  in data1dbs;
create index "informix".svpi3 on "informix".svp (s_brand,comp_name) 
    using btree  in data1dbs;
create unique index "informix".bb1 on "informix".brands (b_id) 
    using btree  in data1dbs;
create index "informix".bb1a on "informix".brands (b_ord) using 
    btree  in data1dbs;
create unique index "informix".skillidx1 on "informix".skill (b_id,
    c_id,s_num) using btree  in data1dbs;
create index "informix".bpd1 on "informix".bptv_parts (ceid,rag,
    brand) using btree  in data1dbs;
create unique index "informix".bu1 on "informix".bptv (ceid) using 
    btree  in data1dbs;
create unique index "informix".pdw on "informix".part_details_ws 
    (ceid) using btree  in data1dbs;
create unique index "informix".ib1 on "informix".industry (i_brand,
    i_id) using btree  in data1dbs;
create unique index "informix".accuidx1 on "informix".accreditation 
    (a_brand,ceid,level,target) using btree  in data1dbs;
create index "informix".tidx2 on "informix".tbptv (rag) using 
    btree  in data1dbs;
create unique index "informix".tuidx on "informix".tbptv (ceid,
    rag,revdt) using btree  in data1dbs;
create index "informix".nbptvidx1 on "informix".nbptv (ceid,iot,
    imt) using btree  in data1dbs;
create index "informix".sts1 on "informix".success_ti (ceid) using 
    btree  in data1dbs;
create unique index "informix".st1 on "informix".skills_ti (ceid) 
    using btree  in data1dbs;
create index "informix".srs1 on "informix".success_ra (ceid) using 
    btree  in data1dbs;
create index "informix".sls1 on "informix".success_lo (ceid) using 
    btree  in data1dbs;
create unique index "informix".sl1 on "informix".skills_lo (ceid) 
    using btree  in data1dbs;
create unique index "informix".sr1 on "informix".skills_ra (ceid) 
    using btree  in data1dbs;
create unique index "informix".sbu1 on "informix".skills_ba (ceid) 
    using btree  in data1dbs;
create index "informix".sba1 on "informix".success_ba (ceid) using 
    btree  in data1dbs;
create unique index "informix".sii1 on "informix".skills_is (ceid) 
    using btree  in data1dbs;
create unique index "informix".e1_idx on "informix".eus (e_brand,
    e_region,e_id) using btree  in data1dbs;
create index "informix".e2_idx on "informix".eus (e_ssr) using 
    btree  in data1dbs;
create index "informix".e3_idx on "informix".eus (e_ctp) using 
    btree  in data1dbs;
create index "informix".e4_idx on "informix".eus (e_brand,e_region,
    e_name) using btree  in data1dbs;
create unique index "informix".si1 on "informix".skills_im (ceid) 
    using btree  in data1dbs;
create index "informix".sim1 on "informix".success_im (ceid) using 
    btree  in data1dbs;
create unique index "informix".ciu1_idx on "informix".coverage_im 
    (ceid) using btree  in data1dbs;
create index "informix".cwd2 on "informix".coverage_ws (ssr) using 
    btree  in data1dbs;
create index "informix".cwd3 on "informix".coverage_ws (ctp) using 
    btree  in data1dbs;
create unique index "informix".cwu1_idx on "informix".coverage_ws 
    (ceid) using btree  in data1dbs;
create unique index "informix".sw1 on "informix".skills_ws (ceid) 
    using btree  in data1dbs;
create index "informix".sws1 on "informix".success_ws (ceid) using 
    btree  in data1dbs;
create unique index "informix".sysmenidx on "informix".sysmenus 
    (menuname) using btree  in data1dbs;
create unique index "informix".meniidx on "informix".sysmenuitems 
    (imenuname,itemnum) using btree  in data1dbs;
create unique index "informix".ctu1_idx on "informix".coverage_ti 
    (ceid) using btree  in data1dbs;
create index "informix".crd2 on "informix".coverage_ra (ssr) using 
    btree  in data1dbs;
create index "informix".crd3 on "informix".coverage_ra (ctp) using 
    btree  in data1dbs;
create unique index "informix".cru1_idx on "informix".coverage_ra 
    (ceid) using btree  in data1dbs;
create index "informix".cld2 on "informix".coverage_lo (ssr) using 
    btree  in data1dbs;
create unique index "informix".clu1_idx on "informix".coverage_lo 
    (ceid) using btree  in data1dbs;
create index "informix".ctd3 on "informix".coverage_lo (ctp) using 
    btree  in data1dbs;
create unique index "informix".cidx1 on "informix".control (brand) 
    using btree  in data1dbs;
create unique index "informix".cross1idx on "informix".cross (ceid) 
    using btree  in data1dbs;
create unique index "informix".se1 on "informix".skills_em (ceid) 
    using btree  in data1dbs;
create unique index "informix".sc1 on "informix".skills_sc (ceid) 
    using btree  in data1dbs;
create index "informix".cisd2 on "informix".coverage_is (ssr) 
    using btree  in data1dbs;
create index "informix".cisd3 on "informix".coverage_is (ctp) 
    using btree  in data1dbs;
create unique index "informix".cisu1_idx on "informix".coverage_is 
    (ceid) using btree  in data1dbs;
create index "informix".ced2 on "informix".coverage_em (ssr) using 
    btree  in data1dbs;
create index "informix".ced3 on "informix".coverage_em (ctp) using 
    btree  in data1dbs;
create unique index "informix".ceu1_idx on "informix".coverage_em 
    (ceid) using btree  in data1dbs;
create index "informix".csd2 on "informix".coverage_sc (ssr) using 
    btree  in data1dbs;
create index "informix".csd3 on "informix".coverage_sc (ctp) using 
    btree  in data1dbs;
create unique index "informix".csu1_idx on "informix".coverage_sc 
    (ceid) using btree  in data1dbs;
create index "informix".sems1 on "informix".success_em (ceid) 
    using btree  in data1dbs;
create index "informix".sscs1 on "informix".success_sc (ceid) 
    using btree  in data1dbs;
create index "informix".siss1 on "informix".success_is (ceid) 
    using btree  in data1dbs;
create index "informix".cbad2 on "informix".coverage_ba (ssr) 
    using btree  in data1dbs;
create index "informix".cbad3 on "informix".coverage_ba (ctp) 
    using btree  in data1dbs;
create unique index "informix".cbau1_idx on "informix".coverage_ba 
    (ceid) using btree  in data1dbs;
create unique index "informix".statesidx1 on "informix".states 
    (s_id) using btree  in data1dbs;
create unique index "informix".scu1 on "informix".skill_cat (c_brand,
    c_id) using btree  in data1dbs;
create unique index "informix".ru1 on "informix".relations (ceid,
    b_id,r_name) using btree  in data1dbs;
create unique index "informix".cu1idx on "informix".contacts (c_ceid,
    c_name,e_brand,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cuim1idx on "informix".contacts_im 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cuws1idx on "informix".contacts_ws 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cuba1idx on "informix".contacts_ba 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cuse1idx on "informix".contacts_se 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cuti1idx on "informix".contacts_ti 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cuis1idx on "informix".contacts_is 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cura1idx on "informix".contacts_ra 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cuem1idx on "informix".contacts_em 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".cusc1idx on "informix".contacts_sc 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".tmpscu1 on "informix".tmp_skill_cat 
    (c_brand,c_id) using btree  in data1dbs;
create unique index "informix".llidx1 on "informix".lastload (tabname,
    datetm) using btree  in data1dbs;
create unique index "informix".bcu1 on "informix".brand_certs 
    (b_id,bc_id) using btree  in data1dbs;
create unique index "informix".bcud1 on "informix".brand_certs_det 
    (b_id,bc_id,rag) using btree  in data1dbs;
create index "informix".caud2 on "informix".coverage_au (ssr) 
    using btree  in data1dbs;
create index "informix".caud3 on "informix".coverage_au (ctp1) 
    using btree  in data1dbs;
create index "informix".caud4 on "informix".coverage_au (ctp2) 
    using btree  in data1dbs;
create index "informix".caud5 on "informix".coverage_au (ctp3) 
    using btree  in data1dbs;
create index "informix".caud6 on "informix".coverage_au (ceid,
    reseller,part_type) using btree  in data1dbs;
create index "informix".caud7 on "informix".coverage_au (ctp4) 
    using btree  in data1dbs;
create index "informix".caud8 on "informix".coverage_au (ctp5) 
    using btree  in data1dbs;
create unique index "informix".cauu1_idx on "informix".coverage_au 
    (ceid) using btree  in data1dbs;
create unique index "informix".sau1 on "informix".skills_au (ceid) 
    using btree  in data1dbs;
create unique index "informix".saui1 on "informix".success_au 
    (ceid,s_title) using btree  in data1dbs;
create unique index "informix".cuau1idx on "informix".contacts_au 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".unitbidx1 on "informix".unit_brand 
    (u_id,b_id,ord) using btree  in data1dbs;
create index "informix".csud2 on "informix".coverage_su (ssr) 
    using btree  in data1dbs;
create index "informix".csud3 on "informix".coverage_su (ctp1) 
    using btree  in data1dbs;
create index "informix".csud4 on "informix".coverage_su (ctp2) 
    using btree  in data1dbs;
create index "informix".csud5 on "informix".coverage_su (ctp3) 
    using btree  in data1dbs;
create index "informix".csud6 on "informix".coverage_su (reseller,
    part_type) using btree  in data1dbs;
create index "informix".csud7 on "informix".coverage_su (ctp4) 
    using btree  in data1dbs;
create index "informix".csud8 on "informix".coverage_su (ctp5) 
    using btree  in data1dbs;
create unique index "informix".csuu1_idx on "informix".coverage_su 
    (ceid) using btree  in data1dbs;
create unique index "informix".ssui1 on "informix".success_su 
    (ceid,s_title) using btree  in data1dbs;
create index "informix".ssu2 on "informix".skills_su (ceid) using 
    btree  in data1dbs;
create unique index "informix".ss11 on "informix".skills_s1 (ceid) 
    using btree  in data1dbs;
create unique index "informix".ss21 on "informix".skills_s2 (ceid) 
    using btree  in data1dbs;
create unique index "informix".ss31 on "informix".skills_s3 (ceid) 
    using btree  in data1dbs;
create unique index "informix".ss41 on "informix".skills_s4 (ceid) 
    using btree  in data1dbs;
create unique index "informix".ss51 on "informix".skills_s5 (ceid) 
    using btree  in data1dbs;
create unique index "informix".cusu1idx on "informix".contacts_su 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".eucolidx1 on "informix"._eucolnamesu 
    (idx) using btree  in data1dbs;
create unique index "informix".suoi1 on "informix".skills_io (ceid) 
    using btree  in data1dbs;
create unique index "informix".fdbu1 on "informix".feedback (b_id,
    tsm) using btree  in data1dbs;
create unique index "informix".slui1 on "informix".segment_leaders 
    (seg_lead) using btree  in data1dbs;
create index "informix".ccud2 on "informix".coverage_cu (ssr) 
    using btree  in data1dbs;
create index "informix".ccud3 on "informix".coverage_cu (ctp1) 
    using btree  in data1dbs;
create index "informix".ccud4 on "informix".coverage_cu (ctp2) 
    using btree  in data1dbs;
create index "informix".ccud5 on "informix".coverage_cu (ctp3) 
    using btree  in data1dbs;
create index "informix".ccud6 on "informix".coverage_cu (reseller,
    part_type) using btree  in data1dbs;
create index "informix".ccud7 on "informix".coverage_cu (ctp4) 
    using btree  in data1dbs;
create index "informix".ccud8 on "informix".coverage_cu (ctp5) 
    using btree  in data1dbs;
create unique index "informix".ccuu1_idx on "informix".coverage_cu 
    (ceid) using btree  in data1dbs;
create unique index "informix".tuhidx on "informix".tbptv_history 
    (q_year,q_qtr,ceid,rag,revdt) using btree  in data1dbs;
create unique index "informix".suh1 on "informix".skills_history 
    (q_year,q_qtr,q_brand,ceid) using btree  in data1dbs;
create index "informix".cbud2 on "informix".coverage_bu (ssr) 
    using btree  in data1dbs;
create index "informix".cbud3 on "informix".coverage_bu (ctp1) 
    using btree  in data1dbs;
create index "informix".cbud4 on "informix".coverage_bu (ctp2) 
    using btree  in data1dbs;
create index "informix".cbud5 on "informix".coverage_bu (ctp3) 
    using btree  in data1dbs;
create index "informix".cbud6 on "informix".coverage_bu (reseller,
    part_type) using btree  in data1dbs;
create index "informix".cbud7 on "informix".coverage_bu (ctp4) 
    using btree  in data1dbs;
create index "informix".cbud8 on "informix".coverage_bu (ctp5) 
    using btree  in data1dbs;
create unique index "informix".cbuu1_idx on "informix".coverage_bu 
    (ceid) using btree  in data1dbs;
create index "informix".sbui1 on "informix".success_bu (ceid) 
    using btree  in data1dbs;
create unique index "informix".cubu1idx on "informix".contacts_bu 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".co1 on "informix".skills_co (ceid) 
    using btree  in data1dbs;
create unique index "informix".buu1 on "informix".skills_bu (ceid) 
    using btree  in data1dbs;
create unique index "informix".segu1 on "informix".segmentation 
    (seg_id) using btree  in data1dbs;
create index "informix".scui1 on "informix".success_cu (ceid) 
    using btree  in data1dbs;
create unique index "informix".cucu1idx on "informix".contacts_cu 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create index "informix".sc11 on "informix".skills_c1 (ceid) using 
    btree  in data1dbs;
create unique index "informix".tu1sn on "informix".tasks (task_num) 
    using btree  in data1dbs;
create index "informix".coud2 on "informix".coverage_ou (ssr) 
    using btree  in data1dbs;
create index "informix".coud3 on "informix".coverage_ou (ctp1) 
    using btree  in data1dbs;
create index "informix".coud4 on "informix".coverage_ou (ctp2) 
    using btree  in data1dbs;
create index "informix".coud5 on "informix".coverage_ou (ctp3) 
    using btree  in data1dbs;
create index "informix".coud6 on "informix".coverage_ou (reseller,
    part_type) using btree  in data1dbs;
create index "informix".coud7 on "informix".coverage_ou (ctp4) 
    using btree  in data1dbs;
create index "informix".coud8 on "informix".coverage_ou (ctp5) 
    using btree  in data1dbs;
create unique index "informix".couu1_idx on "informix".coverage_ou 
    (ceid) using btree  in data1dbs;
create unique index "informix".sgbau1 on "informix".skills_gba 
    (ceid,e_region,e_id) using btree  in data1dbs;
create index "informix".cstd2 on "informix".coverage_st (ssr) 
    using btree  in data1dbs;
create index "informix".cstd3 on "informix".coverage_st (ctp1) 
    using btree  in data1dbs;
create index "informix".cstd4 on "informix".coverage_st (ctp2) 
    using btree  in data1dbs;
create index "informix".cstd5 on "informix".coverage_st (ctp3) 
    using btree  in data1dbs;
create unique index "informix".cstu1_idx on "informix".coverage_st 
    (ceid) using btree  in data1dbs;
create unique index "informix".sst1 on "informix".skills_sw (ceid) 
    using btree  in data1dbs;
create index "informix".ssti1 on "informix".success_st (ceid) 
    using btree  in data1dbs;
create unique index "informix".cust1idx on "informix".contacts_st 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create index "informix".cesd2 on "informix".coverage_es (ssr) 
    using btree  in data1dbs;
create index "informix".cesd3 on "informix".coverage_es (ctp1) 
    using btree  in data1dbs;
create index "informix".cesd4 on "informix".coverage_es (ctp2) 
    using btree  in data1dbs;
create index "informix".cesd5 on "informix".coverage_es (ctp3) 
    using btree  in data1dbs;
create unique index "informix".cesu1_idx on "informix".coverage_es 
    (ceid) using btree  in data1dbs;
create unique index "informix".ses1 on "informix".skills_es (ceid) 
    using btree  in data1dbs;
create unique index "informix".cues1idx on "informix".contacts_es 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create index "informix".sesi1 on "informix".success_es (ceid) 
    using btree  in data1dbs;
create index "informix".cwud2 on "informix".coverage_wu (ssr) 
    using btree  in data1dbs;
create index "informix".cwud3 on "informix".coverage_wu (ctp1) 
    using btree  in data1dbs;
create index "informix".cwud4 on "informix".coverage_wu (ctp2) 
    using btree  in data1dbs;
create index "informix".cwud5 on "informix".coverage_wu (ctp3) 
    using btree  in data1dbs;
create unique index "informix".cwuu1_idx on "informix".coverage_wu 
    (ceid) using btree  in data1dbs;
create unique index "informix".swu1 on "informix".skills_wu (ceid) 
    using btree  in data1dbs;
create unique index "informix".cuwu1idx on "informix".contacts_wu 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create index "informix".swui1 on "informix".success_wu (ceid) 
    using btree  in data1dbs;
create index "informix".solidx1 on "informix".solutions (ceid,
    brand) using btree  in data1dbs;
create index "informix".ciod2 on "informix".coverage_io (ssr) 
    using btree  in data1dbs;
create index "informix".ciod3 on "informix".coverage_io (ctp1) 
    using btree  in data1dbs;
create index "informix".ciod4 on "informix".coverage_io (ctp2) 
    using btree  in data1dbs;
create index "informix".ciod5 on "informix".coverage_io (ctp3) 
    using btree  in data1dbs;
create unique index "informix".ciou1_idx on "informix".coverage_io 
    (ceid) using btree  in data1dbs;
create index "informix".sioi1 on "informix".success_io (ceid) 
    using btree  in data1dbs;
create unique index "informix".cuio1idx on "informix".contacts_io 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".scu1a on "informix".skills_cu (ceid) 
    using btree  in data1dbs;
create unique index "informix".regur1 on "informix".region (e_region) 
    using btree  in data1dbs;
create index "informix".regur2 on "informix".region (e_iot,e_region) 
    using btree  in data1dbs;
create index "informix".csed2 on "informix".coverage_se (ssr) 
    using btree  in data1dbs;
create index "informix".csed3 on "informix".coverage_se (ctp1) 
    using btree  in data1dbs;
create index "informix".csed4 on "informix".coverage_se (ctp2) 
    using btree  in data1dbs;
create index "informix".csed5 on "informix".coverage_se (ctp3) 
    using btree  in data1dbs;
create unique index "informix".cseu1_idx on "informix".coverage_se 
    (ceid) using btree  in data1dbs;
create unique index "informix".sse1 on "informix".skills_se (ceid) 
    using btree  in data1dbs;
create unique index "informix".ssru1 on "informix".ssrtab (ssr) 
    using btree  in data1dbs;
create unique index "informix".sb11a on "informix".skills_b1 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sb21a on "informix".skills_b2 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sb31a on "informix".skills_b3 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sb41a on "informix".skills_b4 (ceid) 
    using btree  in data1dbs;
create unique index "informix".scertu1 on "informix".storage_cert 
    (ceid,prod_cert,vad) using btree  in data1dbs;
create index "informix".ssh1a on "informix".skills_sh (ceid) using 
    btree  in data1dbs;
create index "informix".ssv1a on "informix".skills_sv (ceid) using 
    btree  in data1dbs;
create unique index "informix".cestu1 on "informix".coverextend_st_del 
    (ceid) using btree  in data1dbs;
create unique index "informix".indcidx1 on "informix"._ind_colname 
    (idx,i_short) using btree  in data1dbs;
create index "informix".compidx1 on "informix".competency_v1 (ceid) 
    using btree  in data1dbs;
create index "informix".compidx2 on "informix".competency_v1 (comp_name) 
    using btree  in data1dbs;
create unique index "informix".bbu2 on "informix".brand_bu (brand,
    bu) using btree  in data1dbs;
create index "informix".sviidx1 on "informix".svp_info (prod_grp_desc) 
    using btree  in data1dbs;
create index "informix".sviidx2 on "informix".svp_info (ceid,prod_grp_desc) 
    using btree  in data1dbs;
create unique index "informix".taguidx1 on "informix".tags (ceid,
    ig_name,i_short,tag_desc) using btree  in data1dbs;
create unique index "informix".poduidx1 on "informix".pod_info 
    (pod) using btree  in data1dbs;
create index "informix".vapidx on "informix".vap (ceid) using 
    btree  in data1dbs;
create index "informix".fccauidx1 on "informix".fcast_comments_au 
    (fcast_id) using btree  in data1dbs;
create unique index "informix".fluuidx1 on "informix".flu_flowcode 
    (flow_code) using btree  in data1dbs;
create unique index "informix".fluuidx2 on "informix".flu_stat 
    (fc_status) using btree  in data1dbs;
create unique index "informix".fluuidx3 on "informix".flu_revtype 
    (rev_type) using btree  in data1dbs;
create unique index "informix".fluuidx4 on "informix".flu_iot 
    (iot) using btree  in data1dbs;
create unique index "informix".fluuidx5 on "informix".flu_country 
    (country) using btree  in data1dbs;
create unique index "informix".fluuidx6 on "informix".flu_brand_grp 
    (brand_grp) using btree  in data1dbs;
create unique index "informix".fluuidx7 on "informix".flu_brand 
    (brand) using btree  in data1dbs;
create unique index "informix".fluuidx8 on "informix".flu_ssmstep 
    (ssmstep) using btree  in data1dbs;
create unique index "informix".fluuidx9 on "informix".flu_owning_org 
    (owning_org) using btree  in data1dbs;
create unique index "informix".fluuidxa on "informix".flu_prod_seg 
    (prod_seg) using btree  in data1dbs;
create unique index "informix".fluuidxb on "informix".flu_prod_fam 
    (prod_fam) using btree  in data1dbs;
create unique index "informix".fcauidx1 on "informix".fcast_au 
    (fcast_id) using btree  in data1dbs;
create unique index "informix".fluuidxc on "informix".flu_oppty_stat 
    (oppty_stat) using btree  in data1dbs;
create unique index "informix".sag1 on "informix".skills_ag (ceid) 
    using btree  in data1dbs;
create unique index "informix".revui1 on "informix".review (ceid,
    brand,updtime) using btree  in data1dbs;
create unique index "informix".gsdidx1 on "informix".gsd_solutions 
    (ceid,sol_id,comp_name) using btree  in data1dbs;
create unique index "informix".aiu1 on "informix".act_initiative 
    (ceid) using btree  in data1dbs;
create index "informix".actidx1 on "informix".activity (ceid) 
    using btree  in data1dbs;
create unique index "informix".targuidx on "informix".target (t_ceid) 
    using btree  in data1dbs;
create unique index "informix".aluuidx1 on "informix".alu_type 
    (alu_code) using btree  in data1dbs;
create unique index "informix".aluuidx2 on "informix".alu_status 
    (alu_stat) using btree  in data1dbs;
create index "informix".sa1i1 on "informix".skills_a1 (skill_01) 
    using btree  in data1dbs;
create index "informix".sa1i2 on "informix".skills_a1 (skill_02) 
    using btree  in data1dbs;
create index "informix".sa1i3 on "informix".skills_a1 (skill_03) 
    using btree  in data1dbs;
create index "informix".sa1i4 on "informix".skills_a1 (skill_04) 
    using btree  in data1dbs;
create index "informix".sa1i5 on "informix".skills_a1 (skill_05) 
    using btree  in data1dbs;
create unique index "informix".sa1u1 on "informix".skills_a1 (ceid) 
    using btree  in data1dbs;
create index "informix".sa2i1 on "informix".skills_a2 (skill_01) 
    using btree  in data1dbs;
create index "informix".sa2i2 on "informix".skills_a2 (skill_02) 
    using btree  in data1dbs;
create index "informix".sa2i3 on "informix".skills_a2 (skill_03) 
    using btree  in data1dbs;
create unique index "informix".sa2u1 on "informix".skills_a2 (ceid) 
    using btree  in data1dbs;
create index "informix".sa3i1 on "informix".skills_a3 (skill_01) 
    using btree  in data1dbs;
create index "informix".sa3i2 on "informix".skills_a3 (skill_02) 
    using btree  in data1dbs;
create index "informix".sa3i3 on "informix".skills_a3 (skill_03) 
    using btree  in data1dbs;
create unique index "informix".sa3u1 on "informix".skills_a3 (ceid) 
    using btree  in data1dbs;
create index "informix".sa4i1 on "informix".skills_a4 (skill_01) 
    using btree  in data1dbs;
create index "informix".sa4i2 on "informix".skills_a4 (skill_02) 
    using btree  in data1dbs;
create index "informix".sa4i3 on "informix".skills_a4 (skill_03) 
    using btree  in data1dbs;
create unique index "informix".sa4u1 on "informix".skills_a4 (ceid) 
    using btree  in data1dbs;
create index "informix".sa5i1 on "informix".skills_a5 (skill_01) 
    using btree  in data1dbs;
create index "informix".sa5i2 on "informix".skills_a5 (skill_02) 
    using btree  in data1dbs;
create index "informix".sa5i3 on "informix".skills_a5 (skill_03) 
    using btree  in data1dbs;
create unique index "informix".sa5u1 on "informix".skills_a5 (ceid) 
    using btree  in data1dbs;
create unique index "informix".cruidx1 on "informix".curr_revenue 
    (brand,ceid) using btree  in data1dbs;
create index "informix".fsdidx1 on "informix".featsols (m_name) 
    using btree  in data1dbs;
create index "informix".fsdidx2 on "informix".featsols (i_name) 
    using btree  in data1dbs;
create unique index "informix".fsuidx1 on "informix".featsols 
    (brand,ceid,m_name,i_name,title) using btree  in data1dbs;
    
create index "informix".cncd2 on "informix".coverage_nc (ssr) 
    using btree  in data1dbs;
create index "informix".cncd3 on "informix".coverage_nc (ctp1) 
    using btree  in data1dbs;
create index "informix".cncd4 on "informix".coverage_nc (ctp2) 
    using btree  in data1dbs;
create index "informix".cncd5 on "informix".coverage_nc (ctp3) 
    using btree  in data1dbs;
create index "informix".cncd6 on "informix".coverage_nc (ceid,
    reseller,part_type) using btree  in data1dbs;
create index "informix".cncd7 on "informix".coverage_nc (ctp4) 
    using btree  in data1dbs;
create index "informix".cncd8 on "informix".coverage_nc (ctp5) 
    using btree  in data1dbs;
create unique index "informix".cncu1_idx on "informix".coverage_nc 
    (ceid) using btree  in data1dbs;
create unique index "informix".cunc1idx on "informix".contacts_nc 
    (c_ceid,c_name,e_region,e_name) using btree  in data1dbs;
    
create unique index "informix".snci1 on "informix".success_nc 
    (ceid,s_title) using btree  in data1dbs;
create index "informix".actncidx1 on "informix".activity_nc (ceid) 
    using btree  in data1dbs;
create unique index "informix".aincu1 on "informix".act_init_nc 
    (ceid) using btree  in data1dbs;
create unique index "informix".sn1u1 on "informix".skills_n1 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sn2u1 on "informix".skills_n2 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sn3u1 on "informix".skills_n3 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sn4u1 on "informix".skills_n4 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sn5u1 on "informix".skills_n5 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sn6u1 on "informix".skills_n6 (ceid) 
    using btree  in data1dbs;
create unique index "informix".sn7u1 on "informix".skills_n7 (ceid) 
    using btree  in data1dbs;
create index "informix".compidx3 on "informix".competency (ceid,
    bu,comp_name,level) using btree  in data1dbs;
create index "informix".compidx4 on "informix".competency (comp_name) 
    using btree  in data1dbs;
create index "informix".compidx5 on "informix".competency (bu,
    comp_name) using btree  in data1dbs;
create index "informix".cmcd2 on "informix".coverage_mc (ssr) 
    using btree  in data1dbs;
create index "informix".cmcd3 on "informix".coverage_mc (ctp1) 
    using btree  in data1dbs;
create index "informix".cmcd4 on "informix".coverage_mc (ctp2) 
    using btree  in data1dbs;
create index "informix".cmcd5 on "informix".coverage_mc (ctp3) 
    using btree  in data1dbs;
create index "informix".cmcd6 on "informix".coverage_mc (ceid,
    reseller,part_type) using btree  in data1dbs;
create index "informix".cmcd7 on "informix".coverage_mc (ctp4) 
    using btree  in data1dbs;
create index "informix".cmcd8 on "informix".coverage_mc (ctp5) 
    using btree  in data1dbs;
create unique index "informix".cmcu1_idx on "informix".coverage_mc 
    (ceid) using btree  in data1dbs;
create unique index "informix".smci1 on "informix".success_mc 
    (ceid,s_title) using btree  in data1dbs;
create unique index "informix".smdi1 on "informix".success_md 
    (ceid,s_title) using btree  in data1dbs;
create unique index "informix".smfi1 on "informix".success_mf 
    (ceid,s_title) using btree  in data1dbs;
create unique index "informix".smii1 on "informix".success_mi 
    (ceid,s_title) using btree  in data1dbs;
create unique index "informix".smpi1 on "informix".success_mp 
    (ceid,s_title) using btree  in data1dbs;
create unique index "informix".i1oi1 on "informix".skills_i1 (ceid) 
    using btree  in data1dbs;
create unique index "informix".i2oi1 on "informix".skills_i2 (ceid) 
    using btree  in data1dbs;
create unique index "informix".i3oi1 on "informix".skills_i3 (ceid) 
    using btree  in data1dbs;
create unique index "informix".fcncidx1 on "informix".fcast_nc 
    (fcast_id) using btree  in data1dbs;
create index "informix".fccncidx1 on "informix".fcast_comments_nc 
    (fcast_id) using btree  in data1dbs;
create index "informix".cd1 on "informix".certs (prod_group,cert_type,
    cert_num,comp_name) using btree  in data1dbs;
create index "informix".cd2 on "informix".certs (ceid,prod_group,
    cert_type) using btree  in data1dbs;
create unique index "informix".i4oi1 on "informix".skills_i4 (ceid) 
    using btree  in data1dbs;


grant select on "informix".reps2 to "public" as "informix";
grant update on "informix".reps2 to "public" as "informix";
grant insert on "informix".reps2 to "public" as "informix";
grant delete on "informix".reps2 to "public" as "informix";
grant select on "informix".eus2 to "public" as "informix";
grant select on "informix".reps3 to "public" as "informix";
grant select on "informix".reps4 to "public" as "informix";
grant select on "informix".reps6 to "public" as "informix";
grant select on "informix".reps5 to "public" as "informix";
grant select on "informix".coverage_md to "public" as "informix";
grant update on "informix".coverage_md to "public" as "informix";
grant insert on "informix".coverage_md to "public" as "informix";
grant delete on "informix".coverage_md to "public" as "informix";
grant select on "informix".coverage_mf to "public" as "informix";
grant update on "informix".coverage_mf to "public" as "informix";
grant insert on "informix".coverage_mf to "public" as "informix";
grant delete on "informix".coverage_mf to "public" as "informix";
grant select on "informix".coverage_mi to "public" as "informix";
grant update on "informix".coverage_mi to "public" as "informix";
grant insert on "informix".coverage_mi to "public" as "informix";
grant delete on "informix".coverage_mi to "public" as "informix";
grant select on "informix".coverage_mp to "public" as "informix";
grant update on "informix".coverage_mp to "public" as "informix";
grant insert on "informix".coverage_mp to "public" as "informix";
grant delete on "informix".coverage_mp to "public" as "informix";
