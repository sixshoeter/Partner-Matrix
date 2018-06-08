
globals "globals.4gl"


main
define
   ACRec record like access_cnt.*,
   ARec record like access.*,
   tbrand char(2),
   tcnt integer,
   SQLStr char(1024),
   UpdStr char(1024)

#whenever error stop

   begin work;

   delete from access_cnt;

## replace access_page contents
   delete from access_page
   load from '/tmp/home.csv' insert into access_page
#   load from '/tmp/authorization.csv' insert into access_auth
#   load from '/tmp/cover.csv' insert into access_cover
#   load from '/tmp/industries.csv' insert into access_ind
#   load from '/tmp/skills.csv' insert into access_skills

   let SQLStr="select 'AU' brand, count(*) cnt from access_page where target matches '*NA/AU/H/homeU.html' ",
        "union select 'SU' brand, count(*) cnt from access_page where target matches '*NA/SU/H/homeU.html' ",
        "union select 'BU' brand, count(*) cnt from access_page where target matches '*NA/BU/H/homeU.html' ",
        "union select 'CU' brand, count(*) cnt from access_page where target matches '*NA/CU/H/homeU.html' ",
        "union select 'ST' brand, count(*) cnt from access_page where target matches '*NA/ST/H/homeU.html' ",
        "union select 'ES' brand, count(*) cnt from access_page where target matches '*NA/ES/H/homeU.html' ",
        "union select 'IO' brand, count(*) cnt from access_page where target matches '*NA/IO/H/homeU.html' ",
        "union select 'SE' brand, count(*) cnt from access_page where target matches '*NA/SE/H/homeU.html' ",
        "union select 'WU' brand, count(*) cnt from access_page where target matches '*NA/WU/H/homeU.html' "
  
   prepare HID from SQLStr
   declare HCurs cursor for HID

   foreach HCurs into tbrand,tcnt
#      display tbrand, " ", tcnt
      let UpdStr="insert into access_cnt values('", tbrand clipped, "', 'home',", tcnt, ")"
#      display UpdStr clipped
      prepare UpdHID from UpdStr
      execute UpdHID

   end foreach


## replace access_fap contents
   delete from access_fap
   load from '/tmp/fap.csv' insert into access_fap

   let SQLStr="select 'AU' brand, count(*) cnt from access_fap where target matches '*query_AU_eus.html' ",
        "union select 'SU' brand, count(*) cnt from access_fap where target matches '*query_SU_eus.html' ",
        "union select 'BU' brand, count(*) cnt from access_fap where target matches '*query_BU_eus.html' ",
        "union select 'CU' brand, count(*) cnt from access_fap where target matches '*query_CU_eus.html' ",
        "union select 'ST' brand, count(*) cnt from access_fap where target matches '*query_ST_eus.html' ",
        "union select 'ES' brand, count(*) cnt from access_fap where target matches '*query_ES_eus.html' ",
        "union select 'IO' brand, count(*) cnt from access_fap where target matches '*query_IO_eus.html' ",
        "union select 'SE' brand, count(*) cnt from access_fap where target matches '*query_SE_eus.html' ",
	"union select 'WU' brand, count(*) cnt from access_fap where target matches '*query_WU_eus.html' "

#display SQLStr
   prepare FID from SQLStr
   declare FCurs cursor for FID

   foreach FCurs into tbrand,tcnt
#      display tbrand, " ", tcnt
      let UpdStr="insert into access_cnt values('", tbrand clipped, "', 'fap',", tcnt, ")"
#      display UpdStr clipped
      prepare UpdFID from UpdStr
      execute UpdFID

   end foreach

   commit work
end main
