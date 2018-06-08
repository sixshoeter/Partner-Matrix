# authorized partners

## August    18, 2016 - John M. Shoemaker, jshoemaker1@cox.net - create #182

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   tRec record like tbptv.*,
   SQLStr, SQLStr2, SQLStr3, BSQLStr char(2048),
   skillStr char(4098),
   AdhocStr char(128),
   wStr char(128),
   str char(20),
   DELIMIT char(1),
   brand char(2),
   tssr, ttss like reps.r_name,
   i,j,si,c smallint,
   last_part_name like coverage_bu.part_name,
   TitleArr array[200] of record
      c_long like skill_cat.c_long,
      skill record like skill.*
   end record,
   DataRec record like skills_b1.*,
   DataArr2 array[900] of record like coverage_bu.*,
   SVPArr array[20] of char(50),
   svpStr char(256),
   tabid smallint,
   BrandRec record like brands.*

call ReadCmdLn( "export20", 3)
call ProcCmdLn( "export20" )

let DELIMIT=","

#let SQLStr = "select a.* from ", cov_tab clipped, " a where a.reseller!='N' order by a.part_name"



let SQLStr2 = "select a.c_long, b.* from unit_brand c, skill b, outer skill_cat a where a.c_id=b.c_id and b.b_id=a.c_brand and c.b_id = b.b_id and c.u_id='", BRec.b_id clipped, "' order by b.b_id, s_num"


#let SQLStr2 = "select b.b_id, a.c_long, b.s_desc from skill b, outer skill_cat a where a.c_id=b.c_id and b.b_id=a.c_brand and b.b_id=c.b_id and s_desc!='Not Used' order by b.b_id, s_num"

prepare DLK1 from SQLStr2
declare DLK1Curs cursor for DLK1
let c = 0

foreach DLK1Curs into TitleArr[c+1].*
   let c = c + 1
end foreach

#display "c: ", c

let i = 0

   let skillStr = 
           '"CEID"', DELIMIT,
           '"Partner Name"', DELIMIT,
	   '"BPR"', DELIMIT
for i = 1 to c
   if( TitleArr[i].skill.s_desc != 'Not Used' )then
      let skillStr = skillStr clipped, " ", "'", TitleArr[i].c_long clipped, ":", TitleArr[i].skill.s_desc clipped, "'", DELIMIT
   end if
end for
let skillStr = skillStr clipped, 
           '"Comm: Energy & Utility"', DELIMIT,
           '"Comm: Media & Entertainment"', DELIMIT,
           '"Comm: Telecommunications"', DELIMIT,
           '"Comm: CSI"', DELIMIT,
           '"Dist: Consumer Product"', DELIMIT,
           '"Dist: Retail"', DELIMIT,
	   '"Dist: Travel & Trans"', DELIMIT,
           '"Fin: Banks"', DELIMIT,
           '"Fin: Financial Markets"', DELIMIT,
           '"Fin: Insurance"', DELIMIT,
           '"Ind: Aerospace & Defense"', DELIMIT,
           '"Ind: Automotive"', DELIMIT,
           '"Ind: Chemical & Petroleum"', DELIMIT,
           '"Ind: Electronics"', DELIMIT,
           '"Ind: Industrial Products"', DELIMIT,
           '"Public: Governmanet"', DELIMIT,
           '"Public: Education"', DELIMIT,
           '"Public: Health"', DELIMIT,
           '"Public: Life Sciences"', DELIMIT,
           '"Federal"', DELIMIT,
           '"Canada"', DELIMIT,
	   '"Last Updated"', DELIMIT
#           '"Revenue"', DELIMIT

display skillStr clipped
let tabid = 1
call LoadSkillArrU( BRec.b_id )

let SQLStr = BuildBaseStr( BRec.b_id, FALSE )
let SQLStr = SQLStr clipped, " where a.ceid = k.ceid "
if( CtlRec.skill_tab2 is not null and CtlRec.skill_tab2 != " " )then
   let SQLStr = SQLStr clipped, " and a.ceid = l.ceid "
end if
if( CtlRec.skill_tab3 is not null and CtlRec.skill_tab3 != " " )then
   let SQLStr = SQLStr clipped, " and a.ceid = m.ceid "
end if
if( CtlRec.skill_tab4 is not null and CtlRec.skill_tab4 != " " )then
   let SQLStr = SQLStr clipped, " and a.ceid = n.ceid "
end if
if( CtlRec.skill_tab5 is not null and CtlRec.skill_tab5 != " " )then
   let SQLStr = SQLStr clipped, " and a.ceid = o.ceid "
end if
let SQLStr = SQLStr clipped, " and a.part_type != 'D' and a.reseller != 'N' and a.reseller != 'X' order by a.part_name "
#display "SQLStr: ", SQLStr clipped
prepare SQID from SQLStr
declare SQCurs cursor for SQID

foreach SQCurs into URec.*, KRec.*, LRec.*, MRec.*, NRec.*

#  let BSQLStr="select unique a.* from brands a, unit_brand b where a.b_id=b.b_id and b.u_id='", BRec.b_id clipped, "' and a.b_id = b.b_id order by a.b_ord"
#  display "BSQLStr: ", BSQLStr clipped
#  prepare GCID3 from BSQLStr
#  declare GCID3Curs cursor for GCID3
#   foreach GCID3Curs into BrandRec.*
#      display "BrandRec.b_ord: ", BrandRec.b_ord
#      call LoadSkillsU( "", BrandRec.b_ord )

   let skillstr = 
           '"', URec.ceid clipped, '"', DELIMIT,
           '"', URec.part_name clipped, '"', DELIMIT,
	   '"', URec.ssr clipped, '"', DELIMIT

## check the Krecs
   if( TitleArr[1].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_01, DELIMIT
   end if
   if( TitleArr[2].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_02, DELIMIT
   end if
   if( TitleArr[3].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_03, DELIMIT
   end if
   if( TitleArr[4].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_04, DELIMIT
   end if
   if( TitleArr[5].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_05, DELIMIT
   end if
   if( TitleArr[6].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_06, DELIMIT
   end if
   if( TitleArr[7].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_07, DELIMIT
   end if
   if( TitleArr[8].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_08, DELIMIT
   end if
   if( TitleArr[9].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_09, DELIMIT
   end if
   if( TitleArr[10].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_10, DELIMIT
   end if
   if( TitleArr[11].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_11, DELIMIT
   end if
   if( TitleArr[12].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_12, DELIMIT
   end if
   if( TitleArr[13].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_13, DELIMIT
   end if
   if( TitleArr[14].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_14, DELIMIT
   end if
   if( TitleArr[15].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_15, DELIMIT
   end if
   if( TitleArr[16].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_16, DELIMIT
   end if
   if( TitleArr[17].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_17, DELIMIT
   end if
   if( TitleArr[18].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_18, DELIMIT
   end if
   if( TitleArr[19].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_19, DELIMIT
   end if
   if( TitleArr[20].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_20, DELIMIT
   end if
   if( TitleArr[21].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_21, DELIMIT
   end if
   if( TitleArr[22].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_22, DELIMIT
   end if
   if( TitleArr[23].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_23, DELIMIT
   end if
   if( TitleArr[24].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_24, DELIMIT
   end if
   if( TitleArr[25].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_25, DELIMIT
   end if
   if( TitleArr[26].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_26, DELIMIT
   end if
   if( TitleArr[27].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_27, DELIMIT
   end if
   if( TitleArr[28].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_28, DELIMIT
   end if
   if( TitleArr[29].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_29, DELIMIT
   end if
   if( TitleArr[30].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, KRec.skill_30, DELIMIT
   end if


## check the Lrecs
if( c > 30 )then
   if( TitleArr[31].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_01, DELIMIT
   end if
   if( TitleArr[32].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_02, DELIMIT
   end if
   if( TitleArr[33].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_03, DELIMIT
   end if
   if( TitleArr[34].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_04, DELIMIT
   end if
   if( TitleArr[35].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_05, DELIMIT
   end if
   if( TitleArr[36].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_06, DELIMIT
   end if
   if( TitleArr[37].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_07, DELIMIT
   end if
   if( TitleArr[38].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_08, DELIMIT
   end if
   if( TitleArr[39].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_09, DELIMIT
   end if
   if( TitleArr[40].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_10, DELIMIT
   end if
   if( TitleArr[41].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_11, DELIMIT
   end if
   if( TitleArr[42].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_12, DELIMIT
   end if
   if( TitleArr[43].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_13, DELIMIT
   end if
   if( TitleArr[44].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_14, DELIMIT
   end if
   if( TitleArr[45].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_15, DELIMIT
   end if
   if( TitleArr[46].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_16, DELIMIT
   end if
   if( TitleArr[47].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_17, DELIMIT
   end if
   if( TitleArr[48].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_18, DELIMIT
   end if
   if( TitleArr[49].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_19, DELIMIT
   end if
   if( TitleArr[50].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_20, DELIMIT
   end if
   if( TitleArr[51].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_21, DELIMIT
   end if
   if( TitleArr[52].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_22, DELIMIT
   end if
   if( TitleArr[53].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_23, DELIMIT
   end if
   if( TitleArr[54].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_24, DELIMIT
   end if
   if( TitleArr[55].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_25, DELIMIT
   end if
   if( TitleArr[56].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_26, DELIMIT
   end if
   if( TitleArr[57].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_27, DELIMIT
   end if
   if( TitleArr[58].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_28, DELIMIT
   end if
   if( TitleArr[59].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_29, DELIMIT
   end if
   if( TitleArr[60].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, LRec.skill_30, DELIMIT
   end if
end if  #c>30

## check the Mrecs
if( c > 60 )then
   if( TitleArr[61].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_01, DELIMIT
   end if
   if( TitleArr[62].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_02, DELIMIT
   end if
   if( TitleArr[63].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_03, DELIMIT
   end if
   if( TitleArr[64].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_04, DELIMIT
   end if
   if( TitleArr[65].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_05, DELIMIT
   end if
   if( TitleArr[66].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_06, DELIMIT
   end if
   if( TitleArr[67].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_07, DELIMIT
   end if
   if( TitleArr[68].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_08, DELIMIT
   end if
   if( TitleArr[69].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_09, DELIMIT
   end if
   if( TitleArr[70].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_10, DELIMIT
   end if
   if( TitleArr[71].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_11, DELIMIT
   end if
   if( TitleArr[72].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_12, DELIMIT
   end if
   if( TitleArr[73].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_13, DELIMIT
   end if
   if( TitleArr[74].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_14, DELIMIT
   end if
   if( TitleArr[75].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_15, DELIMIT
   end if
   if( TitleArr[76].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_16, DELIMIT
   end if
   if( TitleArr[77].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_17, DELIMIT
   end if
   if( TitleArr[78].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_18, DELIMIT
   end if
   if( TitleArr[79].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_19, DELIMIT
   end if
   if( TitleArr[80].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_20, DELIMIT
   end if
   if( TitleArr[81].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_21, DELIMIT
   end if
   if( TitleArr[82].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_22, DELIMIT
   end if
   if( TitleArr[83].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_23, DELIMIT
   end if
   if( TitleArr[84].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_24, DELIMIT
   end if
   if( TitleArr[85].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_25, DELIMIT
   end if
   if( TitleArr[86].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_26, DELIMIT
   end if
   if( TitleArr[87].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_27, DELIMIT
   end if
   if( TitleArr[88].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_28, DELIMIT
   end if
   if( TitleArr[89].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_29, DELIMIT
   end if
   if( TitleArr[90].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, MRec.skill_30, DELIMIT
   end if
end if  ## c>60

## check the Nrecs
if( c>90 )then
   if( TitleArr[91].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_01, DELIMIT
   end if
   if( TitleArr[92].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_02, DELIMIT
   end if
   if( TitleArr[93].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_03, DELIMIT
   end if
   if( TitleArr[94].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_04, DELIMIT
   end if
   if( TitleArr[95].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_05, DELIMIT
   end if
   if( TitleArr[96].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_06, DELIMIT
   end if
   if( TitleArr[97].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_07, DELIMIT
   end if
   if( TitleArr[98].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_08, DELIMIT
   end if
   if( TitleArr[99].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_09, DELIMIT
   end if
   if( TitleArr[100].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_10, DELIMIT
   end if
   if( TitleArr[101].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_11, DELIMIT
   end if
   if( TitleArr[102].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_12, DELIMIT
   end if
   if( TitleArr[103].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_13, DELIMIT
   end if
   if( TitleArr[104].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_14, DELIMIT
   end if
   if( TitleArr[105].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_15, DELIMIT
   end if
   if( TitleArr[106].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_16, DELIMIT
   end if
   if( TitleArr[107].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_17, DELIMIT
   end if
   if( TitleArr[108].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_18, DELIMIT
   end if
   if( TitleArr[109].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_19, DELIMIT
   end if
   if( TitleArr[110].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_20, DELIMIT
   end if
   if( TitleArr[111].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_21, DELIMIT
   end if
   if( TitleArr[112].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_22, DELIMIT
   end if
   if( TitleArr[113].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_23, DELIMIT
   end if
   if( TitleArr[114].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_24, DELIMIT
   end if
   if( TitleArr[115].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_25, DELIMIT
   end if
   if( TitleArr[116].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_26, DELIMIT
   end if
   if( TitleArr[117].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_27, DELIMIT
   end if
   if( TitleArr[118].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_28, DELIMIT
   end if
   if( TitleArr[119].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_29, DELIMIT
   end if
   if( TitleArr[120].skill.s_desc != 'Not Used' )then
      let skillstr = skillstr clipped, NRec.skill_30, DELIMIT
   end if
end if  ## c>90

display skillstr clipped, 

           '"', URec.ind_eu clipped, '"', DELIMIT,
           '"', URec.ind_me clipped, '"', DELIMIT,
           '"', URec.ind_tel clipped, '"', DELIMIT,
           '"', URec.ind_csi clipped, '"', DELIMIT,

           '"', URec.ind_consume clipped, '"', DELIMIT,
           '"', URec.ind_ret clipped, '"', DELIMIT,
           '"', URec.ind_trans clipped, '"', DELIMIT,

           '"', URec.ind_bank clipped, '"', DELIMIT,
           '"', URec.ind_finan clipped, '"', DELIMIT,
           '"', URec.ind_ins clipped, '"', DELIMIT,

           '"', URec.ind_defense clipped, '"', DELIMIT,
           '"', URec.ind_auto clipped, '"', DELIMIT,
           '"', URec.ind_chem clipped, '"', DELIMIT,
           '"', URec.ind_elect clipped, '"', DELIMIT,
           '"', URec.ind_indprod clipped, '"', DELIMIT,

           '"', URec.ind_gov clipped, '"', DELIMIT,
           '"', URec.ind_education clipped, '"', DELIMIT,
           '"', URec.ind_hl clipped, '"', DELIMIT,
           '"', URec.ind_lifesci clipped, '"', DELIMIT,

           '"', URec.eu_fed clipped, '"', DELIMIT,
           '"', URec.eu_ca clipped, '"', DELIMIT, 

           '"', URec.updtime clipped, '"', DELIMIT

end foreach


#let str = DOWNSHIFT(BRec.b_id)

#call ShowVer( 0 )

end main

function addSkillStr( instr, innum, inrate )
define
   instr char(2048),
   innum smallint,
   inrate smallint,
   retstr char(2048)

   if( inrate is not null AND inrate > 0 )then
   end if

   return retstr

end function  #addSkillStr
