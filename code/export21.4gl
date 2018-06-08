# authorized partners

## August    31, 2016 - John M. Shoemaker, jshoemaker1@cox.net - create #186
## September 06, 2016 - John M. Shoemaker, jshoemaker1@cox.net - include level 4
## December  01, 2016 - John M. Shoemaker, jshoemaker1@cox.net - filter out not-assigned

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
   DataRec record 
      ind_eu array[5] of smallint,
      ind_tel array[5] of smallint,
      ind_me array[5] of smallint,
      ind_ret array[5] of smallint,
      ind_wd array[5] of smallint,
      ind_trans array[5] of smallint,
      ind_bank array[5] of smallint,
      ind_ins array[5] of smallint,
      ind_mfg array[5] of smallint,
      ind_hl array[5] of smallint,
      ind_gov array[5] of smallint,
      ind_auto array[5] of smallint,
      ind_csi array[5] of smallint,
      ind_chem array[5] of smallint,
      ind_consume array[5] of smallint,
      ind_defense array[5] of smallint,
      ind_elect array[5] of smallint,
      ind_finan array[5] of smallint,
      ind_indprod array[5] of smallint,
      ind_lifesci array[5] of smallint,
      ind_education array[5] of smallint
   end record

call ReadCmdLn( "export21", 3)
call ProcCmdLn( "export21" )

let DELIMIT=","


let SQLStr = "select a.* from ", cov_tab clipped, " a where ssr is not null and ssr != ' '"

display "Industry,Level 1, Level 2, Level 3, Level 4, Y"

prepare DLK1 from SQLStr
declare DLK1Curs cursor for DLK1

foreach DLK1Curs into URec.*

## Communications/CSI
   case URec.ind_eu 
      when '1' let DataRec.ind_eu[1] = DataRec.ind_eu[1] + 1
      when '2' let DataRec.ind_eu[2] = DataRec.ind_eu[2] + 1
      when '3' let DataRec.ind_eu[3] = DataRec.ind_eu[3] + 1
      when '4' let DataRec.ind_eu[4] = DataRec.ind_eu[4] + 1
      when 'Y' let DataRec.ind_eu[5] = DataRec.ind_eu[5] + 1
   end case
   case URec.ind_me 
      when '1' let DataRec.ind_me[1] = DataRec.ind_me[1] + 1
      when '2' let DataRec.ind_me[2] = DataRec.ind_me[2] + 1
      when '3' let DataRec.ind_me[3] = DataRec.ind_me[3] + 1
      when '4' let DataRec.ind_me[4] = DataRec.ind_me[4] + 1
      when 'Y' let DataRec.ind_me[5] = DataRec.ind_me[5] + 1
   end case
   case URec.ind_tel 
      when '1' let DataRec.ind_tel[1] = DataRec.ind_tel[1] + 1
      when '2' let DataRec.ind_tel[2] = DataRec.ind_tel[2] + 1
      when '3' let DataRec.ind_tel[3] = DataRec.ind_tel[3] + 1
      when '4' let DataRec.ind_tel[4] = DataRec.ind_tel[4] + 1
      when 'Y' let DataRec.ind_tel[5] = DataRec.ind_tel[5] + 1
   end case
   case URec.ind_csi 
      when '1' let DataRec.ind_csi[1] = DataRec.ind_csi[1] + 1
      when '2' let DataRec.ind_csi[2] = DataRec.ind_csi[2] + 1
      when '3' let DataRec.ind_csi[3] = DataRec.ind_csi[3] + 1
      when '4' let DataRec.ind_csi[4] = DataRec.ind_csi[4] + 1
      when 'Y' let DataRec.ind_csi[5] = DataRec.ind_csi[5] + 1
   end case

## Distribution
   case URec.ind_consume 
      when '1' let DataRec.ind_consume[1] = DataRec.ind_consume[1] + 1
      when '2' let DataRec.ind_consume[2] = DataRec.ind_consume[2] + 1
      when '3' let DataRec.ind_consume[3] = DataRec.ind_consume[3] + 1
      when '4' let DataRec.ind_consume[4] = DataRec.ind_consume[4] + 1
      when 'Y' let DataRec.ind_consume[5] = DataRec.ind_consume[5] + 1
   end case
   case URec.ind_ret 
      when '1' let DataRec.ind_ret[1] = DataRec.ind_ret[1] + 1
      when '2' let DataRec.ind_ret[2] = DataRec.ind_ret[2] + 1
      when '3' let DataRec.ind_ret[3] = DataRec.ind_ret[3] + 1
      when '4' let DataRec.ind_ret[4] = DataRec.ind_ret[4] + 1
      when 'Y' let DataRec.ind_ret[5] = DataRec.ind_ret[5] + 1
   end case
   case URec.ind_trans 
      when '1' let DataRec.ind_trans[1] = DataRec.ind_trans[1] + 1
      when '2' let DataRec.ind_trans[2] = DataRec.ind_trans[2] + 1
      when '3' let DataRec.ind_trans[3] = DataRec.ind_trans[3] + 1
      when '4' let DataRec.ind_trans[4] = DataRec.ind_trans[4] + 1
      when 'Y' let DataRec.ind_trans[5] = DataRec.ind_trans[5] + 1
   end case
## Financial Services
   case URec.ind_bank 
      when '1' let DataRec.ind_bank[1] = DataRec.ind_bank[1] + 1
      when '2' let DataRec.ind_bank[2] = DataRec.ind_bank[2] + 1
      when '3' let DataRec.ind_bank[3] = DataRec.ind_bank[3] + 1
      when '4' let DataRec.ind_bank[4] = DataRec.ind_bank[4] + 1
      when 'Y' let DataRec.ind_bank[5] = DataRec.ind_bank[5] + 1
   end case
   case URec.ind_finan 
      when '1' let DataRec.ind_finan[1] = DataRec.ind_finan[1] + 1
      when '2' let DataRec.ind_finan[2] = DataRec.ind_finan[2] + 1
      when '3' let DataRec.ind_finan[3] = DataRec.ind_finan[3] + 1
      when '4' let DataRec.ind_finan[4] = DataRec.ind_finan[4] + 1
      when 'Y' let DataRec.ind_finan[5] = DataRec.ind_finan[5] + 1
   end case
   case URec.ind_ins 
      when '1' let DataRec.ind_ins[1] = DataRec.ind_ins[1] + 1
      when '2' let DataRec.ind_ins[2] = DataRec.ind_ins[2] + 1
      when '3' let DataRec.ind_ins[3] = DataRec.ind_ins[3] + 1
      when '4' let DataRec.ind_ins[4] = DataRec.ind_ins[4] + 1
      when 'Y' let DataRec.ind_ins[5] = DataRec.ind_ins[5] + 1
   end case
## Industrial
   case URec.ind_defense 
      when '1' let DataRec.ind_defense[1] = DataRec.ind_defense[1] + 1
      when '2' let DataRec.ind_defense[2] = DataRec.ind_defense[2] + 1
      when '3' let DataRec.ind_defense[3] = DataRec.ind_defense[3] + 1
      when '4' let DataRec.ind_defense[4] = DataRec.ind_defense[4] + 1
      when 'Y' let DataRec.ind_defense[5] = DataRec.ind_defense[5] + 1
   end case
   case URec.ind_auto 
      when '1' let DataRec.ind_auto[1] = DataRec.ind_auto[1] + 1
      when '2' let DataRec.ind_auto[2] = DataRec.ind_auto[2] + 1
      when '3' let DataRec.ind_auto[3] = DataRec.ind_auto[3] + 1
      when '4' let DataRec.ind_auto[4] = DataRec.ind_auto[4] + 1
      when 'Y' let DataRec.ind_auto[5] = DataRec.ind_auto[5] + 1
   end case
   case URec.ind_chem 
      when '1' let DataRec.ind_chem[1] = DataRec.ind_chem[1] + 1
      when '2' let DataRec.ind_chem[2] = DataRec.ind_chem[2] + 1
      when '3' let DataRec.ind_chem[3] = DataRec.ind_chem[3] + 1
      when '4' let DataRec.ind_chem[4] = DataRec.ind_chem[4] + 1
      when 'Y' let DataRec.ind_chem[5] = DataRec.ind_chem[5] + 1
   end case
   case URec.ind_elect 
      when '1' let DataRec.ind_elect[1] = DataRec.ind_elect[1] + 1
      when '2' let DataRec.ind_elect[2] = DataRec.ind_elect[2] + 1
      when '3' let DataRec.ind_elect[3] = DataRec.ind_elect[3] + 1
      when '4' let DataRec.ind_elect[4] = DataRec.ind_elect[4] + 1
      when 'Y' let DataRec.ind_elect[5] = DataRec.ind_elect[5] + 1
   end case
   case URec.ind_indprod 
      when '1' let DataRec.ind_indprod[1] = DataRec.ind_indprod[1] + 1
      when '2' let DataRec.ind_indprod[2] = DataRec.ind_indprod[2] + 1
      when '3' let DataRec.ind_indprod[3] = DataRec.ind_indprod[3] + 1
      when '4' let DataRec.ind_indprod[4] = DataRec.ind_indprod[4] + 1
      when 'Y' let DataRec.ind_indprod[5] = DataRec.ind_indprod[5] + 1
   end case
## Public
   case URec.ind_gov 
      when '1' let DataRec.ind_gov[1] = DataRec.ind_gov[1] + 1
      when '2' let DataRec.ind_gov[2] = DataRec.ind_gov[2] + 1
      when '3' let DataRec.ind_gov[3] = DataRec.ind_gov[3] + 1
      when '4' let DataRec.ind_gov[4] = DataRec.ind_gov[4] + 1
      when 'Y' let DataRec.ind_gov[5] = DataRec.ind_gov[5] + 1
   end case
   case URec.ind_education 
      when '1' let DataRec.ind_education[1] = DataRec.ind_education[1] + 1
      when '2' let DataRec.ind_education[2] = DataRec.ind_education[2] + 1
      when '3' let DataRec.ind_education[3] = DataRec.ind_education[3] + 1
      when '4' let DataRec.ind_education[4] = DataRec.ind_education[4] + 1
      when 'Y' let DataRec.ind_education[5] = DataRec.ind_education[5] + 1
   end case
   case URec.ind_hl 
      when '1' let DataRec.ind_hl[1] = DataRec.ind_hl[1] + 1
      when '2' let DataRec.ind_hl[2] = DataRec.ind_hl[2] + 1
      when '3' let DataRec.ind_hl[3] = DataRec.ind_hl[3] + 1
      when '4' let DataRec.ind_hl[4] = DataRec.ind_hl[4] + 1
      when 'Y' let DataRec.ind_hl[5] = DataRec.ind_hl[5] + 1
   end case
   case URec.ind_lifesci 
      when '1' let DataRec.ind_lifesci[1] = DataRec.ind_lifesci[1] + 1
      when '2' let DataRec.ind_lifesci[2] = DataRec.ind_lifesci[2] + 1
      when '3' let DataRec.ind_lifesci[3] = DataRec.ind_lifesci[3] + 1
      when '4' let DataRec.ind_lifesci[4] = DataRec.ind_lifesci[4] + 1
      when 'Y' let DataRec.ind_lifesci[5] = DataRec.ind_lifesci[5] + 1
   end case

end foreach

## Communications/CSI
display "Energy & Utility", DELIMIT,
        DataRec.ind_eu[1], DELIMIT,
        DataRec.ind_eu[2], DELIMIT,
        DataRec.ind_eu[3], DELIMIT,
        DataRec.ind_eu[4], DELIMIT,
        DataRec.ind_eu[5], DELIMIT
display "Media & Entertainment", DELIMIT,
        DataRec.ind_me[1], DELIMIT,
        DataRec.ind_me[2], DELIMIT,
        DataRec.ind_me[3], DELIMIT,
        DataRec.ind_me[4], DELIMIT,
        DataRec.ind_me[5], DELIMIT
display "Telecommunications", DELIMIT,
	DataRec.ind_tel[1], DELIMIT,
        DataRec.ind_tel[2], DELIMIT,
        DataRec.ind_tel[3], DELIMIT,
        DataRec.ind_tel[4], DELIMIT,
        DataRec.ind_tel[5], DELIMIT
display "CSI", DELIMIT,
        DataRec.ind_csi[1], DELIMIT,
        DataRec.ind_csi[2], DELIMIT,
        DataRec.ind_csi[3], DELIMIT,
        DataRec.ind_csi[4], DELIMIT,
        DataRec.ind_csi[5], DELIMIT

## Distribution
display "Consumer Product", DELIMIT,
        DataRec.ind_consume[1], DELIMIT,
        DataRec.ind_consume[2], DELIMIT,
        DataRec.ind_consume[3], DELIMIT,
        DataRec.ind_consume[4], DELIMIT,
        DataRec.ind_consume[5], DELIMIT
display "Retail", DELIMIT,
        DataRec.ind_ret[1], DELIMIT,
        DataRec.ind_ret[2], DELIMIT,
        DataRec.ind_ret[3], DELIMIT,
        DataRec.ind_ret[4], DELIMIT,
        DataRec.ind_ret[5], DELIMIT
display "Travel & Transportation", DELIMIT,
        DataRec.ind_trans[1], DELIMIT,
        DataRec.ind_trans[2], DELIMIT,
        DataRec.ind_trans[3], DELIMIT,
        DataRec.ind_trans[4], DELIMIT,
        DataRec.ind_trans[5], DELIMIT
## Financial Services
display "Banks", DELIMIT,
        DataRec.ind_bank[1], DELIMIT,
        DataRec.ind_bank[2], DELIMIT,
        DataRec.ind_bank[3], DELIMIT,
        DataRec.ind_bank[4], DELIMIT,
        DataRec.ind_bank[5], DELIMIT
display "Financial Markets", DELIMIT,
        DataRec.ind_finan[1], DELIMIT,
        DataRec.ind_finan[2], DELIMIT,
        DataRec.ind_finan[3], DELIMIT,
        DataRec.ind_finan[4], DELIMIT,
        DataRec.ind_finan[5], DELIMIT
display "Insurance", DELIMIT,
        DataRec.ind_ins[1], DELIMIT,
        DataRec.ind_ins[2], DELIMIT,
        DataRec.ind_ins[3], DELIMIT,
        DataRec.ind_ins[4], DELIMIT,
        DataRec.ind_ins[5], DELIMIT
## Industrial
display "Aerospace & Defense", DELIMIT,
        DataRec.ind_defense[1], DELIMIT,
        DataRec.ind_defense[2], DELIMIT,
        DataRec.ind_defense[3], DELIMIT,
        DataRec.ind_defense[4], DELIMIT,
        DataRec.ind_defense[5], DELIMIT
display "Automotive", DELIMIT,
        DataRec.ind_auto[1], DELIMIT,
        DataRec.ind_auto[2], DELIMIT,
        DataRec.ind_auto[3], DELIMIT,
        DataRec.ind_auto[4], DELIMIT,
        DataRec.ind_auto[5], DELIMIT
display "Chemical & Petroleum", DELIMIT,
        DataRec.ind_chem[1], DELIMIT,
        DataRec.ind_chem[2], DELIMIT,
        DataRec.ind_chem[3], DELIMIT,
        DataRec.ind_chem[4], DELIMIT,
        DataRec.ind_chem[5], DELIMIT
display "Electronics", DELIMIT,
        DataRec.ind_elect[1], DELIMIT,
        DataRec.ind_elect[2], DELIMIT,
        DataRec.ind_elect[3], DELIMIT,
        DataRec.ind_elect[4], DELIMIT,
        DataRec.ind_elect[5], DELIMIT
display "Industrial Products", DELIMIT,
        DataRec.ind_indprod[1], DELIMIT,
        DataRec.ind_indprod[2], DELIMIT,
        DataRec.ind_indprod[3], DELIMIT,
        DataRec.ind_indprod[4], DELIMIT,
        DataRec.ind_indprod[5], DELIMIT
## Public
display "Government", DELIMIT,
        DataRec.ind_gov[1], DELIMIT,
        DataRec.ind_gov[2], DELIMIT,
        DataRec.ind_gov[3], DELIMIT,
        DataRec.ind_gov[4], DELIMIT,
        DataRec.ind_gov[5], DELIMIT
display "Education", DELIMIT,
        DataRec.ind_education[1], DELIMIT,
        DataRec.ind_education[2], DELIMIT,
        DataRec.ind_education[3], DELIMIT,
        DataRec.ind_education[4], DELIMIT,
        DataRec.ind_education[5], DELIMIT
display "Health", DELIMIT,
        DataRec.ind_hl[1], DELIMIT,
        DataRec.ind_hl[2], DELIMIT,
        DataRec.ind_hl[3], DELIMIT,
        DataRec.ind_hl[4], DELIMIT,
        DataRec.ind_hl[5], DELIMIT
display "Life Sciences", DELIMIT,
        DataRec.ind_lifesci[1], DELIMIT,
        DataRec.ind_lifesci[2], DELIMIT,
        DataRec.ind_lifesci[3], DELIMIT,
        DataRec.ind_lifesci[4], DELIMIT,
        DataRec.ind_lifesci[5], DELIMIT
end main
