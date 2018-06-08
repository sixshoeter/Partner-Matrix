
database partners_na

main
define
   SQLStr char(128),
   KRec record like skills_ws.*,
   NRec record like _ranew.*

   let SQLStr = "select a.* from _ranew a where a.ceid in (select ceid from coverage_su)"
#   let SQLStr = "select a.* from skills_ws a where a.ceid in (select ceid from coverage_su)"

   prepare A1 from SQLStr
   declare A1Curs cursor for A1

   begin work;
   foreach A1Curs into NRec.*
      display NRec.ceid, NRec.part_name

#RTC, DOORS, etc
      update skills_s1 set skills_s1.skill_07 = NRec.s5, updtime=current where skills_s1.ceid = NRec.ceid
#RPE, etc
      update skills_s1 set skills_s1.skill_08 = NRec.s3, updtime=current where skills_s1.ceid = NRec.ceid
#RSA, etc
      update skills_s1 set skills_s1.skill_15 = NRec.s6, updtime=current where skills_s1.ceid = NRec.ceid
#RPT
      update skills_s1 set skills_s1.skill_10 = NRec.s10, updtime=current where skills_s1.ceid = NRec.ceid
#ClearCase, etc
      update skills_s1 set skills_s1.skill_11 = NRec.s11, updtime=current where skills_s1.ceid = NRec.ceid
#HATS,etc
      update skills_s1 set skills_s1.skill_12 = NRec.s12, updtime=current where skills_s1.ceid = NRec.ceid
#Compilers
      update skills_s1 set skills_s1.skill_13 = NRec.s13, updtime=current where skills_s1.ceid = NRec.ceid
#RDz
      update skills_s1 set skills_s1.skill_14 = NRec.s14, updtime=current where skills_s1.ceid = NRec.ceid

{
#WAS
      update skills_s1 set skills_s1.skill_01 = KRec.skill_08, updtime=current where skills_s1.ceid = KRec.ceid
#eXtrene
      update skills_s1 set skills_s1.skill_03 = KRec.skill_10 , updtime=current where skills_s1.ceid = KRec.ceid
#Pure App
      update skills_s1 set skills_s1.skill_12 = KRec.skill_10 , updtime=current where skills_s1.ceid = KRec.ceid

#MQ
      update skills_s2 set skills_s2.skill_01 = KRec.skill_01 , updtime=current where skills_s2.ceid = KRec.ceid
#IIB
      update skills_s2 set skills_s2.skill_02 = KRec.skill_02 , updtime=current where skills_s2.ceid = KRec.ceid
#WSRR
      update skills_s2 set skills_s2.skill_03 = KRec.skill_09 , updtime=current where skills_s2.ceid = KRec.ceid
#WESB
      update skills_s2 set skills_s2.skill_05 = KRec.skill_03 , updtime=current where skills_s2.ceid = KRec.ceid
#DataPower
      update skills_s2 set skills_s2.skill_09 = KRec.skill_06 , updtime=current where skills_s2.ceid = KRec.ceid
#Cast Iron
      update skills_s2 set skills_s2.skill_10 = KRec.skill_07 , updtime=current where skills_s2.ceid = KRec.ceid
#API Mgmt
      update skills_s2 set skills_s2.skill_04 = KRec.skill_14 , updtime=current where skills_s2.ceid = KRec.ceid

#BPM
      update skills_s3 set skills_s3.skill_01 = KRec.skill_04 , updtime=current where skills_s3.ceid = KRec.ceid
#ODM
      update skills_s3 set skills_s3.skill_04 = KRec.skill_05 , updtime=current where skills_s3.ceid = KRec.ceid
#Bus Mon
      update skills_s3 set skills_s3.skill_07 = KRec.skill_16 , updtime=current where skills_s3.ceid = KRec.ceid
#BWL
      update skills_s3 set skills_s3.skill_08 = KRec.skill_15 , updtime=current where skills_s3.ceid = KRec.ceid
}
   end foreach
commit work;
end main
