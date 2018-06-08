
#April 09, 2013 John M. Shoemaker, created
#July  18, 2014 John M. Shoemaker, added note about which brands were in production
#October 23, 2014 John M. Shoemaker, corrected color
#December 04, 2014 John M. Shoemaker, use SkillsMax
## February  17, 2016 John M. Shoemaker, filter out reseller X
## April     08, 2016 John M. Shoemaker, bring up to date


globals "globals.4gl"

define
   ARecArr array[1000] of record 
      ceid like coverage_au.ceid,
      part_name like coverage_au.part_name,
      uname like coverage_au.part_name,
      brand1 char(4),
      brand2 char(4),
      brand3 char(4),
      brand4 char(4),
      brand5 char(4),
      brand6 char(4),
      brand7 char(4),
      brand8 char(4),
      brand9 char(4),
      brand0 char(4)
   end record,
#   ARecArr array[500] of record like coverage_au.*,
   G_TotalCnt smallint,
   BrandTitlesArr array[10] of char(15),
   BrandCnt array[19] of smallint
  


main
define
   qtrStr char(512),
   wStr char(512),
   i smallint,
   HVP char(1),
   cnt smallint,
   oe smallint,
   tmpnm char(1),
   BPTV_Cnt smallint,
   ncolor char(15),
   inProdStr char(128)


call ReadCmdLn("master", 4)
#let HVP = arg_val(5)  #only the first 5 values are read via ReadCmdLn
call ProcCmdLn("master")
call Header(2, 'NA', '--', 0)


{
let BrandArr[1] = "WebSphere"
let BrandArr[2] = "Big Data/IM"
let BrandArr[3] = "C&SI"
let BrandArr[4] = "Rational"
let BrandArr[5] = "ICS"
let BrandArr[6] = "Commerce"
let BrandArr[7] = "Smarter Cities"
let BrandArr[8] = "Content Mgmt"
let BrandArr[9] = "BA"
let BrandArr[10] = "Security"
}
let BrandTitlesArr[1] = "Analytics"
let BrandTitlesArr[2] = "Hybrid Cloud"
let BrandTitlesArr[3] = "Commerce"
let BrandTitlesArr[4] = "Storage"
let BrandTitlesArr[5] = "IoT"
let BrandTitlesArr[6] = "Cloud"
let BrandTitlesArr[7] = "Social"
let BrandTitlesArr[8] = "Watson"
let BrandTitlesArr[9] = ""
let BrandTitlesArr[10] = ""

call GetFullProdStr() returning inProdStr  
display " "

display "<div class='centerText' dir='ltr'>"   
#display "<em><span style='font-size: 16px'>The Partners listed below reflect all of our Partners </span></em></div>"
#display "<div dir='ltr' style='text-align: center'>"
#display "<em><span style='font-size: 16px'>that are SVP Approved for resell of IBM Software.</span><br />"
display "<em><span style='font-size: 16px'>"
display MasterRec.top_msg clipped, " Authorized partners are in Bright Green, ", MasterRec.middle_msg clipped, " in Light Green, <br />"
display "and ", MasterRec.low_msg clipped, " partners in Yellow. Partners with white background <br />"
display "are authorized without recognized skills. </span></em></div>"
display "<br />"

#display "Address to this location: <a href='https://ibm.biz/PartnerMatrix'>https://ibm.biz/PartnerMatrix</a><br />"

display "<div dir='ltr' style='text-align: center'>"

display "<em><span style='font-size: 16px'></span></em></div>"

display "<div dir='ltr' style='text-align: center'>"
display "<em><span style='font-size: 20px'>", "Master Partner List - all Brands", "</span></em></div>"
if( inProdStr is not NULL )then
   display "<div dir='ltr' style='text-align: center'>"
   display "<em><span style='font-size: 20px'>", "Brands in Production: ", inProdStr clipped, "</span></em></div>"
end if
display "<p>"

## Load ALL Data (all brands
let cnt = LoadMasterArr()

## create title for the data
#display "<div style='margin:0px auto;display:block'>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 835px; font: 16px/26px Georgia, Garamond, Serif; height: 50px;'>"
display "<table class='centerText' border='0' cellpadding='0' cellspacing='0' dir='ltr' height='50'>"
#display "<table border='0' cellpadding='0' cellspacing='0' dir='ltr' height='78' width='725' align='center'>"
#display "<colgroup>"
#display "<col style='width: 252px' />"
#display "<col span='3' style='width: 65px' />"
#display "</colgroup>"
#display "<tbody>"

display "<tr>"
display "<td class='leftText' style='height: 10px; width: 275px; font-size: 10px;'>"
#display "<th class='leftText'; style='background-color: rgb(230,230,250); width: 275px;'>"
#display "<h2>"
display "BP Company Name</h2>"
display "</td>"
for i=1 to 10
   display "<td class='rightText' style='width: 140; font-size: 10px;'>"
   display "<div style='text-align: right'>"
#   display "<h2 style='text-align: right'>"
   display BrandTitlesArr[i] clipped, "</div>"#, "</h2>"
   display "</td>"
end for
display "</table>"
display "</div>"

## create scrollable display of data
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 835px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto'>"
#display "<div dir='ltr' style='border-bottom: #ccc 1px solid; border-left: #ccc 1px solid; width: 600px; font: 16px/26px Georgia, Garamond, Serif; height: 360px; overflow: auto; border-top: #ccc 1px solid; border-right: #ccc 1px solid'>"

display "<table class='centerText' border='0' cellpadding='0' cellspacing='0' dir='ltr'>"

for cnt = 1 to 10
   let BrandCnt[cnt] = 0
end for

let cnt = 0
#foreach ACurs into ARec.*, tmpnm
for cnt = 1 to G_TotalCnt

   display "<tr>"
#   display "<tr style='height: 12px'>"
   display "<td class='leftText' style='height: 10px; width: 275px; font-size: 10px;"
   if( (cnt mod 2) = 0) then
      display " background-color: #E0E0E0'>"
   else
      display "'>"
   end if
   display ARecArr[cnt].part_name clipped, "</td>"
#display "<td>",ARecArr[cnt].ceid clipped, "</td>"
#   display ARecArr[cnt].part_name clipped, " (", ARecArr[cnt].ceid clipped, ") </td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='leftText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"
{
   if( (cnt mod 2) = 0) then
      display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if
}

   if ( ARecArr[cnt].brand1 = 'AU' )then
      let ncolor = GetSkillColor( 'AU', ARecArr[cnt].ceid )
      let BrandCnt[brand_au] = BrandCnt[brand_au] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/AU/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>AU </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"
{
   if( (cnt mod 2) = 0) then
     display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if
}

   if ( ARecArr[cnt].brand2 = 'SU' )then
      let ncolor = GetSkillColor( 'SU', ARecArr[cnt].ceid )
      let BrandCnt[brand_su] = BrandCnt[brand_su] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/SU/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>SU </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"

{
   if( (cnt mod 2) = 0) then
     display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if

}
   if ( ARecArr[cnt].brand3 = 'BU' )then
      let ncolor = GetSkillColor( 'BU', ARecArr[cnt].ceid )
      let BrandCnt[brand_bu] = BrandCnt[brand_bu] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/BU/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>BU </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"
{
   if( (cnt mod 2) = 0) then
     display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if
}

   if ( ARecArr[cnt].brand4 = 'ST' )then
      let ncolor = GetSkillColor( 'ST', ARecArr[cnt].ceid )
      let BrandCnt[brand_st] = BrandCnt[brand_st] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/ST/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>ST </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"
{
   if( (cnt mod 2) = 0) then
     display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if
}

   if ( ARecArr[cnt].brand5 = 'IO' )then
      let ncolor = GetSkillColor( 'IO', ARecArr[cnt].ceid )
      let BrandCnt[brand_io] = BrandCnt[brand_io] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/IO/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>IOT </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"
{
   if( (cnt mod 2) = 0) then
     display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if
}

   if ( ARecArr[cnt].brand6 = 'CU' )then
      let ncolor = GetSkillColor( 'CU', ARecArr[cnt].ceid )
      let BrandCnt[brand_cu] = BrandCnt[brand_cu] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/CU/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>CU </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"
{
   if( (cnt mod 2) = 0) then
     display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if
}

   if ( ARecArr[cnt].brand7 = 'ES' )then
      let ncolor = GetSkillColor( 'ES', ARecArr[cnt].ceid )
      let BrandCnt[brand_es] = BrandCnt[brand_es] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/ES/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>ES </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"
{
   if( (cnt mod 2) = 0) then
     display "; background-color: #E0E0E0'>"
   else
      display "'>"
   end if
}

   if ( ARecArr[cnt].brand8 = 'WU' )then
      let ncolor = GetSkillColor( 'WU', ARecArr[cnt].ceid )
      let BrandCnt[brand_wu] = BrandCnt[brand_wu] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/WU/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>Watson </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
{   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"

#   if( (cnt mod 2) = 0) then
#     display "; background-color: #E0E0E0'>"
#   else
#      display "'>"
#   end if

   if ( ARecArr[cnt].brand9 = 'BA' )then
      let ncolor = GetSkillColor( 'BA', ARecArr[cnt].ceid )
      let BrandCnt[brand_ba] = BrandCnt[brand_ba] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/BA/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>BA </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"

#-------------------------------------------------------------------------------------------------
   display "<td class='centerText' style='text-align: center; width: 140px; border-left: medium none; border-top: medium none; font-size: 10px"
#   if( (cnt mod 2) = 0) then
#     display "; background-color: #E0E0E0'>"
#   else
#      display "'>"
#   end if

   if ( ARecArr[cnt].brand0 = 'SE' )then
      let ncolor = GetSkillColor( 'SE', ARecArr[cnt].ceid )
      let BrandCnt[brand_se] = BrandCnt[brand_se] + 1
      display "; background-color: ", ncolor clipped, "'>"
      display "<a href='/NA/SE/P/", ARecArr[cnt].ceid clipped, ".html' target='_blank'>SE </a>"
   else
      if( (cnt mod 2) = 0) then
         display "; background-color: #E0E0E0'>"
      else
         display "'>"
      end if
      display " "
   end if
   display "</td>"
}

   display "</tr>"
end for
#end foreach

#-------------------------------------------------------------------------------------------------
#display "</tbody>"
## display summary counts
display "<tfoot>"
display "<tr>"
display "<td>", "</td>"
display "<td>", BrandCnt[brand_au] using "##&", "</td>"
display "<td>", BrandCnt[brand_su] using "##&", "</td>"
display "<td>", BrandCnt[brand_bu] using "##&", "</td>"
display "<td>", BrandCnt[brand_st] using "##&", "</td>"
display "<td>", BrandCnt[brand_io] using "##&", "</td>"
display "<td>", BrandCnt[brand_cu] using "##&", "</td>"
display "<td>", BrandCnt[brand_es] using "##&", "</td>"
display "<td>", BrandCnt[brand_wu] using "##&", "</td>"
#display "<td>", BrandCnt[brand_ba] using "##&", "</td>"
#display "<td>", BrandCnt[brand_se] using "##&", "</td>"
display "</tr>"
display "</tfoot>"

display "</table>"
display "</div>"
display "<div dir='ltr' style='margin:0px auto;display:block; border: 1px solid; width: 835px; font: 16px/26px Georgia, Garamond, Serif;'>"
display "Number of "
if( HVP = "Y") then
   display "High Value "
end if
display "Partners: ", cnt using "<<<", "<br />"

display "</div>"
display "<p dir='ltr'> &nbsp;</p>"

call ShowVer( 0 )

end main

function LoadMasterArr()
define
   i smallint,
   SQLStr char(1024)

#display "LoadMasterArr: Start step 1"
let SQLStr = "select a.ceid from coverage_au a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union ",
"select a.ceid from coverage_su a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union ",
"select a.ceid from coverage_bu a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union ",
"select a.ceid from coverage_st a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union ",
"select a.ceid from coverage_io a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union ",
"select a.ceid from coverage_cu a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union ",
"select a.ceid from coverage_es a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' union ",
"select a.ceid from coverage_wu a where a.reseller !='N' and a.reseller !='V' and a.reseller !='X' and a.part_type!='D' ",
"into temp st1;"
prepare LMAS1 from SQLStr
execute LMAS1

#display "LoadMasterArr: Start step 2"
let SQLStr = " select unique ceid, ",
       "'                                          ' part_name, ",
       "'                                          ' uname, ",
       "'  ' brand1, ",
       "'  ' brand2, ",
       "'  ' brand3, ",
       "'  ' brand4, ",
       "'  ' brand5, ",
       "'  ' brand6, ",
       "'  ' brand7, ",
       "'  ' brand8, ",
       "'  ' brand9, ",
       "'  ' brand0 ",
   "from st1 into temp st2; "
prepare LMAS2 from SQLStr
execute LMAS2


#display "LoadMasterArr: Start step 3"
update st2 set st2.part_name=(select a.part_name from coverage_au a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');
update st2 set st2.brand1=(select 'AU' from coverage_au a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

update st2 set st2.part_name=(select a.part_name from coverage_su a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand2=(select 'SU' from coverage_su a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

update st2 set st2.part_name=(select a.part_name from coverage_bu a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand3=(select 'BU' from coverage_bu a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

update st2 set st2.part_name=(select a.part_name from coverage_st a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand4=(select 'ST' from coverage_st a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

update st2 set st2.part_name=(select a.part_name from coverage_io a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand5=(select 'IO' from coverage_io a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

update st2 set st2.part_name=(select a.part_name from coverage_cu a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand6=(select 'CU' from coverage_cu a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

update st2 set st2.part_name=(select a.part_name from coverage_es a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand7=(select 'ES' from coverage_es a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

update st2 set st2.part_name=(select a.part_name from coverage_wu a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand8=(select 'WU' from coverage_wu a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

{
update st2 set st2.part_name=(select a.part_name from coverage_ba a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand9=(select 'BA' from coverage_ba a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');

update st2 set st2.part_name=(select a.part_name from coverage_se a where st2.ceid=a.ceid and a.reseller !='N' and a.reseller !='X' and a.part_type!='D') where st2.part_name = ' ' or st2.part_name is NULL;
update st2 set st2.brand0=(select 'SE' from coverage_se a where st2.ceid=a.ceid  and a.reseller !='N' and a.reseller !='X' and a.part_type!='D');
}

#let qtrStr = qtrStr clipped, " ", wStr clipped, " into temp _arec"

#display "LoadMasterArr: Start step 4"
update st2 set uname = upper(part_name);

#display "LoadMasterArr: Start step 5"
let SQLStr = "select * from st2 order by uname"

   prepare LMA1 from SQLStr
   declare LMA1Curs cursor for LMA1

   let i = 0
   foreach LMA1Curs into ARecArr[i+1].*
      let i = i + 1
   end foreach

   let G_TotalCnt = i

   return G_TotalCnt


end function  #LoadMasterArr

function GetSkillColor(in_brand, in_ceid)
define
   in_brand char(2),
   in_ceid char(10),
   ret_color char(15),
   i,max_skill smallint,
   SQLStr char(128),
   CtlRec record like control.*

#display in_brand, in_ceid
   call GetControlRec( in_brand ) returning CtlRec.*

   let SQLStr = "select a.* from ", CtlRec.skill_tab1 clipped, " a where a.ceid='", in_ceid clipped, "'"
#display SQLStr
   prepare GSC1 from SQLStr
   execute GSC1 into KRec.*

## load the Skills Arrays
   call LoadSkillArrU( in_brand )

   call LoadSkills()
   let max_skill = 0
   for i = 1 to SkillsMax
      if( BPSkillsArr[i] > max_skill )then
         let max_skill = BPSkillsArr[i]
      end if
   end for
#display "max: ", max_skill

   case max_skill
#     green
      when 3
         let ret_color = "#00FF00"

#     lighter green
      when 2
         let ret_color = "#99EE99"

#     yellow
      when 1
         let ret_color = "#FFFFCC"

#     no-color
      otherwise
         let ret_color = "#FFFFFF"
     
   end case

   return ret_color

end function  #GetSkillColor

function GetFullProdStr()
   define
      i smallint,
      retStr char(128),
      CRec record like control.*

   initialize retStr to NULL

#   return retStr

   for i = 1 to 19
      case i
         when brand_au
            call GetControlRec( "AU" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_su
            call GetControlRec( "SU" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_bu
            call GetControlRec( "BU" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_st
            call GetControlRec( "ST" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_io
            call GetControlRec( "IO" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_cu
            call GetControlRec( "CU" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_es
            call GetControlRec( "ES" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

         when brand_wu
            call GetControlRec( "WU" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)

{
         when brand_is
            call GetControlRec( "IS" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "IS", retStr
         when brand_ti
            call GetControlRec( "TI" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "TI", retStr
         when brand_ra
            call GetControlRec( "RA" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "RA", retStr
         when brand_lo
            call GetControlRec( "LO" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "LO", retStr
         when brand_ba
            call GetControlRec( "BA" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "BA", retStr
         when brand_se
            call GetControlRec( "SE" ) returning CRec.*
            let retStr = BuildProdStr(CRec.production, retStr, CRec.menu_str)
display "SE", retStr
}
      end case
   end for  #i
#display "RETSTR: ", retStr

   return retStr


end function  #GetFullProdStr


