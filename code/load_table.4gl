
globals "globals.4gl"

main

define
    TabName char(18),
    oTabName char(22),
    nTabName char(22),
    uTabName char(22),
    nCount smallint,
    oCount smallint,
    loadFile char(256),
    SQLStr char(2000),
    SQLStr2 char(256)


whenever error continue

let TabName = arg_val(1)
let loadFile = arg_val(2)

let oTabName = "o", TabName clipped
let nTabName = "n", TabName clipped
let uTabName = "u", TabName clipped, ".unl"

#display oTabName clipped
#display nTabName clipped
#display uTabName clipped

begin work;

## drop existing old table if exists
let SQLStr = "select * from ", oTabName clipped
   unload to uTabName SQLStr
#display sqlca.sqlcode
   let SQLStr = "drop table ", oTabName clipped
   prepare DTID1 from SQLStr
   execute DTID1
#display sqlca.sqlcode

## create the new table existing table
case 
   when TabName = 'coverage_ws' or TabName = 'coverage_im' or TabName = 'coverage_ti' or TabName = 'coverage_ra' or TabName = 'coverage_lo'
   let SQLStr = "create table ", nTabName clipped, " ( ",
       "ceid char(10), ",
       "vad char(10), ",
       "hq char(2), ",
       "part_type char(1), ",
       "reseller char(1), ",
       "part_name char(60) not null , ",
       "ssr char(20), ",
       "ctp char(20), ",
       "svp_01 char(1), ",
       "svp_02 char(1), ",
       "svp_03 char(1), ",
       "svp_04 char(1), ",
       "svp_05 char(1), ",
       "bu_midwest char(1), ",
       "bu_pacifics char(1), ",
       "bu_greatwest char(1), ",
       "bu_southeast char(1), ",
       "bu_midatl char(1), ",
       "bu_ny char(1), ",
       "bu_northeast char(1), ",
       "bu_grtlakes char(1), ",
       "bu_canada char(1), ",
       "bu_federal char(1), ",
       "ind_eu char(1), ",
       "ind_tel char(1), ",
       "ind_me char(1), ",
       "ind_ret char(1), ",
       "ind_wd char(1), ",
       "ind_trans char(1), ",
       "ind_bank char(1), ",
       "ind_ins char(1), ",
       "ind_mfg char(1), ",
       "ind_hl char(1), ",
       "ind_gov char(1), ",
       "url char(50), ",
       "pwp char(100), ",
       "desc char(2048), ",
       "p_name char(30), ",
       "p_phone char(30), ",
       "p_email char(40), ",
       "focus1 char(30), ",
       "focus2 char(30), ",
       "focus3 char(30) ",
     ") in data1dbs extent size 512 next size 512 lock mode row; "

   when TabName = 'skills_ws' or TabName = 'skills_im' or TabName = 'skills_ti' or TabName = 'skills_ra' or TabName = 'skills_lo'
      let SQLStr = "create table ", nTabName clipped, "( ",
        "ceid char(10) not null, ",
        "skill_01 smallint, ",
        "skill_02 smallint, ",
        "skill_03 smallint, ",
        "skill_04 smallint, ",
        "skill_05 smallint, ",
        "skill_06 smallint, ",
        "skill_07 smallint, ",
        "skill_08 smallint, ",
        "skill_09 smallint, ",
        "skill_10 smallint, ",
        "skill_11 smallint, ",
        "skill_12 smallint, ",
        "skill_13 smallint, ",
        "skill_14 smallint, ",
        "skill_15 smallint, ",
        "skill_16 smallint, ",
        "skill_17 smallint, ",
        "skill_18 smallint, ",
        "skill_19 smallint, ",
        "skill_20 smallint, ",
        "skill_21 smallint, ",
        "skill_22 smallint, ",
        "skill_23 smallint, ",
        "skill_24 smallint, ",
        "skill_25 smallint, ",
        "skill_26 smallint, ",
        "skill_27 smallint, ",
        "skill_28 smallint, ",
        "skill_29 smallint, ",
        "skill_30 smallint, ",
        "skill_other char(60), ",
        "skill_c1 smallint, ",
        "skill_c2 smallint ",
        ") in data1dbs extent size 64 next size 64 lock mode row; "

   when TabName = 'success_ws' or TabName = 'success_im' or TabName = 'success_ti' or TabName = 'success_ra' or TabName = 'success_lo'
      let SQLStr = "create table ", nTabName clipped, " ( ",
         "ceid char(10), ",
         "s_title varchar(128,30), ",
         "s_link varchar(254,30) ",
         ") in data1dbs extent size 64 next size 64 lock mode row; "

end case


## create NEW table (that will be loaded into)
#display SQLStr clipped
prepare CTAB from SQLStr
if( sqlca.sqlcode = 0 ) then   #1
   execute CTAB
   if( sqlca.sqlcode = 0 )  then   #2
##    load the new table from the data file
      let SQLStr2 = "insert into ", nTabName clipped
      load from loadFile delimiter '~' SQLStr2
      if( sqlca.sqlcode = 0 ) then  #3
         let SQLStr2 = "select count(*) from ", nTabName clipped
	 prepare SCID1 from SQLStr2
         execute SCID1 into nCount

         let SQLStr2 = "select count(*) from ", TabName clipped
	 prepare SCID2 from SQLStr2
         execute SCID2 into oCount


         display "Table: ", TabName clipped, " Row Counts> Old: ", oCount using "###", " New: ", nCount using "###"
         if( nCount > 0 )  then  #4

##          rename the existing PRODUCTION table to OLD table
            let SQLStr2 = "rename table ", TabName clipped, " to ", oTabName clipped
#            display SQLStr2 clipped
            prepare RID1 from SQLStr2
            if( sqlca.sqlcode = 0 ) then  #5
               execute RID1
               if( sqlca.sqlcode = 0 ) then  #6
##                rename the new loaded table to PRODUCTION table
                  let SQLStr2 = "rename table ", nTabName clipped, " to ", TabName clipped
#                  display SQLStr2 clipped
                  prepare RID2 from SQLStr2
                  if( sqlca.sqlcode = 0 ) then  #7
                     execute RID2
                     if( sqlca.sqlcode = 0 ) then  #8
                        commit work
#                        display "Work COMMITED 8"
                     else
                       rollback work
#                       display "Work ROLLBACKED 8"
                     end if
                  else
                     rollback work
#                     display "Work ROLLBACKED 7"
                  end if
               else
               rollback work
#               display "Work ROLLBACKED 6"
               end if
            else
               rollback work
#               display "Work ROLLBACKED 5"
            end if
      
         else
            rollback work
#            display "Work ROLLBACKED 4"
         end if
      else
#         display sqlca.sqlcode
#         display sqlca.sqlerrd[5]
         rollback work
#         display "Work ROLLBACKED 3"
      end if
   else
      rollback work
#      display "Work ROLLBACKED 2"
   end if
else
   rollback work
#   display "Work ROLLBACKED 1"
end if




end main
