
## April 03, 2014 - John Shoemaker jshoemaker1@cox.net - add skill categories
## November 21, 2014 - John Shoemaker jshoemaker1@cox.net - add last load dates
## November 24, 2014 - John Shoemaker jshoemaker1@cox.net - expand skills to 30
## December 22, 2014 - John Shoemaker jshoemaker1@cox.net - add hidden certifications
## April    07, 2015 - John Shoemaker jshoemaker1@cox.net - add diff feedback person by brand/unit
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #131
## February 15, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #132
## February 16, 2016 - John Shoemaker jshoemaker1@cox.net - create new unit #134
## April    06, 2016 - John Shoemaker jshoemaker1@cox.net - add confidential msg #145
## April    18, 2016 - John Shoemaker jshoemaker1@cox.net - add GetUnitBrandInclStr
## June     09, 2016 - John Shoemaker jshoemaker1@cox.net - add desc for alliance titles
## July     22, 2016 - John Shoemaker jshoemaker1@cox.net - add market/industry support #174
## September 02, 2016 - John Shoemaker jshoemaker1@cox.net - pull ver from master table #187
## December  09, 2016 - John Shoemaker jshoemaker1@cox.net - migrate to competency #192
## June      21, 2017 - John Shoemaker jshoemaker1@cox.net - add pending review indicator, #236
## May       14, 2018 John M. Shoemaker sixshoeter@gmail.com, add MasterRec columns for dirs, #324



globals "globals.4gl"

define
   pendingReviewFlg char(1)

function ProcCmdLn( inprg )
define
   Cnt smallint,
   inprg char(10),
   tmpcnt smallint,
   SQLStr char(256)
   

call OpenDatabase(CLRec.db)

## initialize
let brand_ws = 1
let brand_im = 2
let brand_ti = 3
let brand_ra = 4
let brand_nc = 5
let brand_ba = 6
let brand_se = 7
let brand_is = 8
let brand_em = 9
let brand_sc = 10
let brand_au = 11
let brand_su = 12
let brand_cu = 13
let brand_bu = 14
let brand_hw = 15
let brand_st = 16
let brand_es = 17
let brand_wu = 18
let brand_io = 19

let brand_mc = 25
let brand_md = 26
let brand_mf = 27
let brand_mi = 28
let brand_mp = 29

let SkillsMax = 30
let SkillsMaxU = 30   
let SkillsMaxAll = 1000  
let CertMax = 1000


let allianceBPRStr = "Alliace Rep"
let allianceCTPStr = "Alliance Tech Rep"
let switaStr = "IBM SCA"
let sprStr = "IBM SPR"
let sprHWStr = "IBM SPR-HW"
let sprHWPWStr = "IBM SPR-Power"
let rpcrStr = "Regional PCR"
let pcrStr = "PCR"
let pcrHWStr = "PCR-HW"
let ptaStr = "PTA"
let ptaHWStr = "PTA-HW"

let G_CrossAvail = FALSE    #have not yet looked up cross-brand record

if( inprg != 'master' )then
##

   let SQLStr="select a.* from iots a where a.i_id = '", CLRec.iot clipped, "'"
   prepare IID from SQLStr
   execute IID into IRec.*

#  grab current brand record
   let SQLStr="select a.* from brands a where a.b_id = '", CLRec.brand clipped, "'"
   prepare BID from SQLStr
   execute BID into BRec.*

#  grab current unit record if a Unit
   if( UnitModeYN() )then
      let SQLStr="select a.* from units a where a.u_id = '", CLRec.brand clipped, "'"
      prepare UID from SQLStr
      execute UID into UNITRec.*
   end if

# load entire array for all brands
#display "BEFORE"
  let SQLStr="select a.* from brands a order by a.b_ord"
#display "AFTER ", SQLStr
#whenever error continue
  prepare BRA1ID from SQLStr
#display sqlca.sqlcode
  declare BRA1Curs cursor for BRA1ID
  let Cnt = 0
  foreach BRA1Curs into BrandArr[ Cnt + 1 ].*
     let Cnt = Cnt + 1
  end foreach 

   if( CLRec.CEID is not null )then
      let SQLStr="select a.* from accreditation a where a.a_brand = '", CLRec.brand clipped, "' and a.ceid='", CLRec.CEID clipped, "'"
      prepare ACCID from SQLStr
      declare ACCCurs cursor for ACCID
      let Cnt=0
      initialize G_AccList to NULL

      foreach ACCCurs into ACCArr[Cnt+1].*
         let Cnt=Cnt + 1
         if( G_AccList is not NULL )then
            let G_AccList = G_AccList clipped, ";"
         end if
         let G_AccList = G_AccList clipped, ACCArr[Cnt].level clipped, " in ", ACCArr[Cnt].target clipped
      end foreach

      let G_Acccnt = Cnt
   else
      let G_Acccnt = 0
   end if



## determine what should be shown 
   let EUsFlg = FALSE

#Retrieve control
call LoadControlFlags( BRec.b_id )

if( CtlRec.bpr_ltext != " " and CtlRec.bpr_ltext is not NULL )then
   let bprStr = CtlRec.bpr_ltext clipped
else
   let bprStr = "IBM Partner Rep"
end if
if( CtlRec.tss_ltext != " " and CtlRec.tss_ltext is not NULL )then
   let tssStr = CtlRec.tss_ltext clipped
else
   let tssStr = "IBM Technical Rep"
end if


#load the SVPArr which lists the text for each SVP authorization for the brand
#   let SQLStr = "select a.*, 0 flag from svp a where a.s_brand='", BRec.b_id clipped, "' order by s_id"
   let SQLStr = "select a.*, 0 flag from svp a where a.s_brand='", BRec.b_id clipped, "' and s_name is not null and s_name !=' ' order by s_id"
   prepare SVPID from SQLStr
   declare SVPCurs cursor for SVPID
   let Cnt=0

   foreach SVPCurs into SVPArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_SVPcnt = Cnt

#load the BUArr which lists the text for each BU authorization for the brand
   let SQLStr = "select a.* from bus a where a.b_brand='", BRec.b_id clipped, "' order by b_id"
   prepare BUID from SQLStr
   declare BUCurs cursor for BUID
   let Cnt=0

   foreach BUCurs into BUArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach

#load the RegionArr which is common for all implementations
   let SQLStr = "select a.* from region a where a.e_iot='", CLRec.iot clipped, "' order by e_ord"
   prepare REID from SQLStr
   declare RECurs cursor for REID
   let Cnt=0

   foreach RECurs into RegionArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_Regioncnt = Cnt

#load the EUArr which lists the text for each EU authorization for the brand
   let G_EUcnt = 0
   let SQLStr = "select a.* from eus a where a.e_brand='", BRec.b_id clipped, "' and a.e_region != '<none>' and a.e_name != '<none>' order by e_id"
   prepare EUID from SQLStr
   declare EUCurs cursor for EUID
   let Cnt=0

   foreach EUCurs into EUArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   if( EUArr[Cnt].e_region = '<none>' or EUArr[Cnt].e_name = '<none>' )then
      let Cnt = Cnt - 1
   end if
   let G_EUcnt = Cnt

if( UnitModeYN() )then
#load the EUColNamesArr which lists the table colnames for each EU
   let SQLStr = "select a.* from _eucolnamesU a order by a.idx"
   prepare EC1UID from SQLStr
   declare EC1UCurs cursor for EC1UID
   let Cnt=0

   foreach EC1UCurs into EUColNamesArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_NumCols = Cnt
else
#load the EUColNamesArr which lists the table colnames for each EU
   let SQLStr = "select a.* from _eucolnames a order by a.idx"
   prepare EC2UID from SQLStr
   declare EC2UCurs cursor for EC2UID
   let Cnt=0

   foreach EC2UCurs into EUColNamesArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_NumCols = Cnt
end if  #UnitModeYN

#load the MArr
   let G_INDcnt = 0
   let SQLStr = "select a.* from market a order by a.ord"
   prepare MKID from SQLStr
   declare MKCurs cursor for MKID
   let Cnt=0

   foreach MKCurs into MKArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_MKcnt = Cnt

#load the INDArr which lists the text for each Industry authorization for the brand
   let G_INDcnt = 0
   let SQLStr = "select a.* from industry a where a.i_brand='", BRec.b_id clipped, "' order by i_id"
   prepare INDID from SQLStr
   declare INDCurs cursor for INDID
   let Cnt=0

   foreach INDCurs into INDArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_INDcnt = Cnt

#load the INDColNamesArr which lists the table colnames for each Industry
   let SQLStr = "select a.* from _ind_colname a where a.idx > 0 and a.idx is not null order by a.idx"
   prepare IND1UID from SQLStr
   declare IND1UCurs cursor for IND1UID
   let Cnt=0

   foreach IND1UCurs into INDColNamesArr[Cnt+1].*
      let Cnt=Cnt + 1
   end foreach
   let G_INDNumCols = Cnt

## load the Skills Arrays
   if( UnitModeYN() )then
      call LoadSkillArrU( BRec.b_id )
   else
      call LoadSkillArr( BRec.b_id )
   end if

end if  #if not master

## load the POD_INFO Array
   let SQLStr = "select a.* from pod_info a order by a.pod"
   prepare POD1ID from SQLStr
   declare POD1Curs cursor for POD1ID
   let Cnt=0
   foreach POD1Curs into PODINFOArr[Cnt+1].*
      let Cnt = Cnt + 1
   end foreach

## load the master record
   let SQLStr="select * from master"
   prepare MRID from SQLStr
   execute MRID into MasterRec.*

## identify the version and refresh date
if( EUsFlg )then
   let V_Num = MasterRec.ver_num
else
   let V_Num = "3.01"
end if
let V_Dt = current year to second


## load color array
let colorArr[5] = "#0066FF"
let colorArr[4] = "#00FF00"
let colorArr[3] = "#99FF99"
let colorArr[2] = "#FFFFCC"
let colorArr[1] = "#FFFFFF"

## set pendingReviewFlg for pending review comments
let pendingReviewFlg = FALSE
let tmpcnt=0
let SQLStr="select count(*) from review a where a.stat='R'"
prepare PRFID from SQLStr
execute PRFID into tmpcnt
if( tmpcnt > 0 )then
   let pendingReviewFlg = TRUE
end if

end function  #ProcCmdLn


function ShowVer( load_flg )
define
   load_flg smallint,
   loadStr char(256),
   RepRec record like reps.*,
   globStr like master.global_msg,
   colStrS, colStrE char(40)

   if( load_flg )then
      let loadStr = LoadDetails()
   else
      initialize loadStr to null
   end if

   call GetFBRep( BRec.b_id ) returning RepRec.*
   call GetGlobalMsg() returning globStr

   if( pendingReviewFlg )then
      let colStrS="<span style='color: rgb(255,0,0)'>"
      let colStrE="</span>"
   else
      let colStrS=" "
      let colStrE=" "
   end if

   display "<span style='font-size:9px; text-align:left;'>", colStrS clipped, V_Num clipped, colStrE clipped, 
   " <a href='/", MasterRec.cgi_dir clipped, "/snap.ksh' class='no_show' target ='_blank'> - </a>", V_Dt, 
           " <a href='/", MasterRec.cgi_dir clipped, "/regen_", BRec.b_id clipped, ".ksh' class='no_show' target = '_blank'> - </a><em>Please send feedback on the Partner Matrix Tool to ",
           " <a href='", RepRec.r_link clipped, "' target='_blank'>", RepRec.r_name clipped, "</a></em> &nbsp;", 
           loadStr clipped, 
           "&nbsp;", 
           globStr clipped,
           "</span>"

end function  #ShowVer

function GetProgName(inProg)
   define
      inProg smallint,
      retStr char(15)

   case inProg
      when 0
         let retStr = "Home"
      when 1
         let retStr = "Home"
      when 2
         let retStr = "Authorizations"
      when 3
         let retStr = "Skills"
      when 4
         let retStr = "Industries"
      when 5
         if( EUsFlg )then
            let retStr = "Enterprise Units"
         else
            let retStr = "Business Units"
         end if
      when 6
         let retStr = "Find a Partner"
      when 7
         let retStr = "Coverage"
      when 8
         let retStr = "PartnerDetails"
      when 21
         let retStr = "Heat Map"
      when 30
         let retStr = "Forecast"

      otherwise
         let retStr = "Partner Matrix"
   end case

   return retStr
end function  #GetProgName


function AddText( basestr, addstr )
define
   basestr char(512),
   addstr char(20)

   if( basestr is null )then
      let basestr = addstr clipped
   else
      let basestr = basestr clipped, ", ", addstr clipped
   end if
   
   return basestr
end function  #AddText

function BuildSkillStr( inLevel )
define
   inLevel smallint,
   revLevel smallint,
   skillStr char(96)

   if( inLevel is null or inLevel > 3 or inLevel < 0 )then
      let inLevel = 3
   end if

   let revLevel = inLevel * -1
   let skillStr=null
   if (KRec.skill_01=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[1].s_name)
   end if
   if (KRec.skill_02=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[2].s_name)
   end if
   if (KRec.skill_03=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[3].s_name)
   end if
   if (KRec.skill_04=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[4].s_name)
   end if
   if (KRec.skill_05=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[5].s_name)
   end if
   if (KRec.skill_06=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[6].s_name)
   end if
   if (KRec.skill_07=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[7].s_name)
   end if
   if (KRec.skill_08=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[8].s_name)
   end if
   if (KRec.skill_09=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[9].s_name)
   end if
   if (KRec.skill_10=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[10].s_name)
   end if
   if (KRec.skill_11=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[11].s_name)
   end if
   if (KRec.skill_12=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[12].s_name)
   end if
   if (KRec.skill_13=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[13].s_name)
   end if
   if (KRec.skill_14=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[14].s_name)
   end if
   if (KRec.skill_15=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[15].s_name)
   end if
   if (KRec.skill_16=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[16].s_name)
   end if
   if (KRec.skill_17=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[17].s_name)
   end if
   if (KRec.skill_18=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[18].s_name)
   end if
   if (KRec.skill_19=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[19].s_name)
   end if
   if (KRec.skill_20=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[20].s_name)
   end if
   if (KRec.skill_21=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[21].s_name)
   end if
   if (KRec.skill_22=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[22].s_name)
   end if
   if (KRec.skill_23=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[23].s_name)
   end if
   if (KRec.skill_24=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[24].s_name)
   end if
   if (KRec.skill_25=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[25].s_name)
   end if
   if (KRec.skill_26=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[26].s_name)
   end if
   if (KRec.skill_27=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[27].s_name)
   end if
   if (KRec.skill_28=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[28].s_name)
   end if
   if (KRec.skill_29=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[29].s_name)
   end if
   if (KRec.skill_30=inLevel )then
         let skillStr = AddText( skillStr, SkillArr[30].s_name)
   end if

return skillStr

end function  #BuildSkillStr


function BuildSkillStrU( inLevel )
define
   inLevel smallint,
   revLevel smallint,
   skillStr char(512)

   if( inLevel is null or inLevel > 3 or inLevel < 0 )then
      let inLevel = 3
   end if

   let revLevel = inLevel * -1
   let skillStr=null
   if (KRec.skill_01=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,1].s_name)
   end if
   if (KRec.skill_02=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,2].s_name)
   end if
   if (KRec.skill_03=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,3].s_name)
   end if
   if (KRec.skill_04=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,4].s_name)
   end if
   if (KRec.skill_05=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,5].s_name)
   end if
   if (KRec.skill_06=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,6].s_name)
   end if
   if (KRec.skill_07=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,7].s_name)
   end if
   if (KRec.skill_08=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,8].s_name)
   end if
   if (KRec.skill_09=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,9].s_name)
   end if
   if (KRec.skill_10=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,10].s_name)
   end if
   if (KRec.skill_11=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,11].s_name)
   end if
   if (KRec.skill_12=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,12].s_name)
   end if
   if (KRec.skill_13=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,13].s_name)
   end if
   if (KRec.skill_14=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,14].s_name)
   end if
   if (KRec.skill_15=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,15].s_name)
   end if
   if (KRec.skill_16=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,16].s_name)
   end if
   if (KRec.skill_17=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,17].s_name)
   end if
   if (KRec.skill_18=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,18].s_name)
   end if
   if (KRec.skill_19=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,19].s_name)
   end if
   if (KRec.skill_20=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,20].s_name)
   end if
   if (KRec.skill_21=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,21].s_name)
   end if
   if (KRec.skill_22=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,22].s_name)
   end if
   if (KRec.skill_23=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,23].s_name)
   end if
   if (KRec.skill_24=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,24].s_name)
   end if
   if (KRec.skill_25=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,25].s_name)
   end if
   if (KRec.skill_26=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,26].s_name)
   end if
   if (KRec.skill_27=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,27].s_name)
   end if
   if (KRec.skill_28=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,28].s_name)
   end if
   if (KRec.skill_29=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,29].s_name)
   end if
   if (KRec.skill_30=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[2,30].s_name)
   end if


   if (LRec.skill_01=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,1].s_name)
   end if
   if (LRec.skill_02=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,2].s_name)
   end if
   if (LRec.skill_03=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,3].s_name)
   end if
   if (LRec.skill_04=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,4].s_name)
   end if
   if (LRec.skill_05=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,5].s_name)
   end if
   if (LRec.skill_06=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,6].s_name)
   end if
   if (LRec.skill_07=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,7].s_name)
   end if
   if (LRec.skill_08=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,8].s_name)
   end if
   if (LRec.skill_09=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,9].s_name)
   end if
   if (LRec.skill_10=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,10].s_name)
   end if
   if (LRec.skill_11=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,11].s_name)
   end if
   if (LRec.skill_12=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,12].s_name)
   end if
   if (LRec.skill_13=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,13].s_name)
   end if
   if (LRec.skill_14=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,14].s_name)
   end if
   if (LRec.skill_15=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,15].s_name)
   end if
   if (LRec.skill_16=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,16].s_name)
   end if
   if (LRec.skill_17=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,17].s_name)
   end if
   if (LRec.skill_18=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,18].s_name)
   end if
   if (LRec.skill_19=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,19].s_name)
   end if
   if (LRec.skill_20=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,20].s_name)
   end if
   if (LRec.skill_21=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,21].s_name)
   end if
   if (LRec.skill_22=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,22].s_name)
   end if
   if (LRec.skill_23=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,23].s_name)
   end if
   if (LRec.skill_24=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,24].s_name)
   end if
   if (LRec.skill_25=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,25].s_name)
   end if
   if (LRec.skill_26=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,26].s_name)
   end if
   if (LRec.skill_27=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,27].s_name)
   end if
   if (LRec.skill_28=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,28].s_name)
   end if
   if (LRec.skill_29=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,29].s_name)
   end if
   if (LRec.skill_30=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[9,30].s_name)
   end if

   if (MRec.skill_01=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,1].s_name)
   end if
   if (MRec.skill_02=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,2].s_name)
   end if
   if (MRec.skill_03=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,3].s_name)
   end if
   if (MRec.skill_04=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,4].s_name)
   end if
   if (MRec.skill_05=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,5].s_name)
   end if
   if (MRec.skill_06=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,6].s_name)
   end if
   if (MRec.skill_07=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,7].s_name)
   end if
   if (MRec.skill_08=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,8].s_name)
   end if
   if (MRec.skill_09=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,9].s_name)
   end if
   if (MRec.skill_10=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,10].s_name)
   end if
   if (MRec.skill_11=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,11].s_name)
   end if
   if (MRec.skill_12=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,12].s_name)
   end if
   if (MRec.skill_13=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,13].s_name)
   end if
   if (MRec.skill_14=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,14].s_name)
   end if
   if (MRec.skill_15=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,15].s_name)
   end if
   if (MRec.skill_16=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,16].s_name)
   end if
   if (MRec.skill_17=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,17].s_name)
   end if
   if (MRec.skill_18=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,18].s_name)
   end if
   if (MRec.skill_19=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,19].s_name)
   end if
   if (MRec.skill_20=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,20].s_name)
   end if
   if (MRec.skill_21=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,21].s_name)
   end if
   if (MRec.skill_22=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,22].s_name)
   end if
   if (MRec.skill_23=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,23].s_name)
   end if
   if (MRec.skill_24=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,24].s_name)
   end if
   if (MRec.skill_25=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,25].s_name)
   end if
   if (MRec.skill_26=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,26].s_name)
   end if
   if (MRec.skill_27=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,27].s_name)
   end if
   if (MRec.skill_28=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,28].s_name)
   end if
   if (MRec.skill_29=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,29].s_name)
   end if
   if (MRec.skill_30=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[6,30].s_name)
   end if


   if (NRec.skill_01=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,1].s_name)
   end if
   if (NRec.skill_02=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,2].s_name)
   end if
   if (NRec.skill_03=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,3].s_name)
   end if
   if (NRec.skill_04=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,4].s_name)
   end if
   if (NRec.skill_05=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,5].s_name)
   end if
   if (NRec.skill_06=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,6].s_name)
   end if
   if (NRec.skill_07=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,7].s_name)
   end if
   if (NRec.skill_08=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,8].s_name)
   end if
   if (NRec.skill_09=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,9].s_name)
   end if
   if (NRec.skill_10=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,10].s_name)
   end if
   if (NRec.skill_11=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,11].s_name)
   end if
   if (NRec.skill_12=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,12].s_name)
   end if
   if (NRec.skill_13=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,13].s_name)
   end if
   if (NRec.skill_14=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,14].s_name)
   end if
   if (NRec.skill_15=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,15].s_name)
   end if
   if (NRec.skill_16=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,16].s_name)
   end if
   if (NRec.skill_17=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,17].s_name)
   end if
   if (NRec.skill_18=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,18].s_name)
   end if
   if (NRec.skill_19=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,19].s_name)
   end if
   if (NRec.skill_20=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,20].s_name)
   end if
   if (NRec.skill_21=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,21].s_name)
   end if
   if (NRec.skill_22=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,22].s_name)
   end if
   if (NRec.skill_23=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,23].s_name)
   end if
   if (NRec.skill_24=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,24].s_name)
   end if
   if (NRec.skill_25=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,25].s_name)
   end if
   if (NRec.skill_26=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,26].s_name)
   end if
   if (NRec.skill_27=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,27].s_name)
   end if
   if (NRec.skill_28=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,28].s_name)
   end if
   if (NRec.skill_29=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,29].s_name)
   end if
   if (NRec.skill_30=inLevel )then
         let skillStr = AddText( skillStr, SkillArrU[11,30].s_name)
   end if

return skillStr

end function  #BuildSkillStrU

function LoadSkillArr( inBrand )
define
   inBrand like brands.b_id,
   SQLStr char(256),
   Cnt smallint,
   SkillRec record
       c_id like skill.c_id,
       s_num like skill.s_num,
       db_num like skill.db_num,
       s_name like skill.s_name,
       s_desc like skill.s_desc
    end record

#load the SkillArr which lists the mapping for the current brand for each skill name
let SQLStr = "select a.c_id, a.s_num, a.db_num, a.s_name, a.s_desc from skill a where a.b_id='", inBrand clipped

let SQLStr = SQLStr clipped, "' order by a.c_id, a.s_num"
#display "AAA:", SQLStr clipped
prepare SkillID from SQLStr
declare SkillCurs cursor for SkillID
let Cnt=0

foreach SkillCurs into SkillRec.*
   let Cnt = SkillRec.s_num
   let SkillArr[Cnt].* = SkillRec.*
#display "XXX: ", Cnt, "YYY", SkillRec.*
end foreach

#load the SkillArrAll which lists the mapping for each skill name
let SQLStr = "select a.b_id, a.s_num, a.db_num, a.s_name, a.s_desc from skill a order by b_id, c_id, s_num"
prepare SkillAllID from SQLStr
declare SkillAllCurs cursor for SkillAllID
let Cnt=0

foreach SkillAllCurs into SkillArrAll[Cnt+1].*
   let Cnt=Cnt + 1
end foreach

end function  #LoadSkillArr

function LoadSkillArrU( inUnit )
define
   inUnit like brands.b_id,
   bStr char(256),
   SQLStr char(512),
   Cnt smallint,
   bIdx smallint,   #brand idx
   SkillRec record
       c_id like skill.c_id,
       s_num like skill.s_num,
       db_num like skill.db_num,
       s_name like skill.s_name,
       s_desc like skill.s_desc
    end record

#display "LoadSkillArrU CALLED"
   let bStr = GetUnitBrandInclStr( inUnit )

#case inUnit
#   when 'AU'
#      let bStr = "('A1','A2','A3','A4','A5')"
#end case

#display bStr

#load the SkillArr which lists the mapping for the current unit/brands for each skill name
let SQLStr = "select b.b_ord, a.c_id, a.s_num, a.db_num, a.s_name, a.s_desc from skill a, brands b where a.b_id = b.b_id and a.b_id in ", bStr clipped

let SQLStr = SQLStr clipped, " order by b.b_ord, a.c_id, a.s_num"
#display "AAA:", SQLStr clipped
prepare SkillUID from SQLStr
declare SkillUCurs cursor for SkillUID
let Cnt=0

foreach SkillUCurs into bIdx, SkillRec.*
   let Cnt = SkillRec.s_num
#if( BRec.b_id='AU' )then display bIdx, Cnt end if
   let SkillArrU[ bIdx,Cnt ].* = SkillRec.*
#display "Cnt(s_num): ", Cnt, " bIdx: ", bIdx, " SkillRec: ", SkillRec.*
#display "Cnt(s_num): ", Cnt, " bIdx: ", bIdx
end foreach

end function  #LoadSkillArrU

function LoadControlFlags( inBrand )
define
   inBrand like brands.b_id,
   SQLStr char(128)

call GetControlRec( inBrand ) returning CtlRec.*

let G_DebugFlg = CtlRec.debug

let cov_tab = CtlRec.cov_tab
let skill_tab = CtlRec.skill_tab1
let success_tab = CtlRec.success_tab
let cont_tab = CtlRec.cont_tab
let G_url = CtlRec.url
let G_ActiveColor = CtlRec.active_color
let G_InActiveColor = CtlRec.inactive_color
let G_TextColor = CtlRec.text_color
let RevBox = CtlRec.revbox
let RevFlg = CtlRec.revflg
let SplitFlg = CtlRec.splitflg
let PplFlg = CtlRec.pplflg
let CertFlg = CtlRec.certflg
let ShowBrands = CtlRec.showbrands
let ShowHVP = CtlRec.showhvp
let ShowTop = CtlRec.showtop
let EUsFlg = CtlRec.eusflg
let CTPPairFlg = CtlRec.ctppairflg
let ShowVAPFlg = CtlRec.showvapflg
let ShowCrossFlg = CtlRec.showcrossflg
let G_eudropbox = CtlRec.eudropbox
let G_production = CtlRec.production
let G_skill_cat = CtlRec.skill_cat
let G_add_contacts = CtlRec.add_contacts
let G_eucontacts = CtlRec.cflg1
let G_includeskills = CtlRec.cflg2
let G_UnitMode = CtlRec.unitmode

end function  #LoadControlFlags

function GetControlRec( inBrand )
define
   inBrand like brands.b_id,
   ControlRec record like control.*,
   SQLStr char(128)

let SQLStr = "select a.* from control a where a.brand='", inBrand clipped, "'"
prepare gcfID from SQLStr
execute gcfID into ControlRec.*

return ControlRec.*

end function  #GetControlRec

function LoadDetails()
define
   SQLStr char(128),
   retStr char(256),
   i smallint,
   ldRec record like lastload.*
   
let retStr ="Data Loaded: "
let i = 0
let SQLStr = "select a.* from lastload a "

prepare ldID from SQLStr
declare ldCurs cursor for ldID

foreach ldCurs into ldRec.*
   if( i > 0 )then
      let retStr = retStr clipped, ", "
   end if
   let retStr = retStr clipped, " ", ldRec.desc clipped, ": ", ldRec.datetm
#          year(ldRec.datetm),"-", 
#          month(ldRec.datetm),"-", 
#          day(ldRec.datetm)," "
#          hours(ldRec.datetm),":", 
#          minutes(ldRec.datetm),"-"
#using "YYYY-mm-dd hh:mm"
   let i = i + 1
end foreach

return retStr

end function  #LoadDetails

function GetFBRep( inBrand )
define
   inBrand like brands.b_id,
   SQLStr char(128),
   retRec record like reps.*

   let SQLStr = "select a.* from reps a, feedback b where a.r_name=b.tsm and b.b_id='", inBrand clipped, "'"
   prepare GFBRID from SQLStr
   execute GFBRID into retRec.*

   if( retRec.r_name is null or retRec.r_link is null )then
      let retRec.r_name = "John Shoemaker"
      let retRec.r_link = "http://faces.tap.ibm.com/#uid:5A8702897/john%20shoemaker/John%20Shoemaker"
   end if
 
   return retRec.* 

end function  #GetFBRep

function GetUnitBrandInclStr( inUnit )
define
   inUnit like unit_brand.u_id,
   retStr char(256),
   ubRec record like unit_brand.*,
   SQLStr char(512)

   initialize retStr to NULL
   if( inUnit is not NULL and inUnit != " " )then
      let SQLStr = "select a.* from unit_brand a where a.u_id='", inUnit clipped, "' order by a.ord "
      prepare GUBID from SQLStr
      declare GUBCurs cursor for GUBID
      let retStr = "( "
      foreach GUBCurs into ubRec.*
         if( retStr != "( " )then
            let retStr = retStr clipped, ","
         end if
         let retStr=retStr clipped, "'", ubRec.b_id clipped, "'"
      end foreach
      if( retStr = "( " )then
         initialize retStr to NULL
      else
         let retStr = retStr clipped, ")"
      end if

   end if  #inUnit valid

   return retStr

end function  #GetUnitBrandInclStr

