
# March 16, 2015     John M. Shoemaker, convert to Units
# April 22, 2016     John M. Shoemaker, add links to the blog and change requests
# November  28, 2017 John M. Shoemaker, merge Analytics (AU) and Cloud (SU) #289
# March     29, 2018 John M. Shoemaker, add Markters in, #317

globals "globals.4gl"

main
define
   SRepRec record like reps.*,
   TRepRec record like reps.*,
   ActiveColor char(16),
   textColor char(16),
   SQLStr char(512),
   url char(128),
   brandStr char(32),
   j,i smallint,
   print_i smallint,
   CRec record like control.*,
   prodStr char(128)

call ReadCmdLn("start", 4)
call ProcCmdLn("start")

initialize prodStr to NULL 

let SQLStr="select * from reps where r_name = '", BRec.sales_mgr clipped, "'"
prepare SRID from SQLStr
execute SRID into SRepRec.*

let SQLStr="select * from reps where r_name = '", BRec.tech_mgr clipped, "'"
prepare TRID from SQLStr
execute TRID into TRepRec.*

#call Init()
#call Header(0, IRec.i_id, BRec.b_id, 1)
#display " "

call LoadActiveBrands( 0, 0 )

display "<html>"
display "<head>"
display "<title>Partner Matrix</title>"
display "</head>"
display "<h1 align='center'>North America Channels Partner Matrix</h1>"

display "<p dir='ltr' style='text-align: center;'>"

display "Address to this location: <a href='https://ibm.biz/PartnerMatrix-Top'>https://ibm.biz/PartnerMatrix-Top</a></p>"
#display "Address to this location: <a href='http://BP-PartnerMatrix.democentral.ibm.com'>http://BP-PartnerMatrix.democentral.ibm.com</a></p>"

display "<h4 align='center'>"
display "The Channels Partner Matrix is a tool devised to share information to the Regions/Enterprise Units <br />"
display "on the best Geographic-based and Solution-skilled Resellers (Business Partners). <br />"
display "The expectation is the Sales Reps will expand their territory reach <br />"
display "by integrating these Partners into their territory plans." 
display "</h4>"
## hide master list for now (it will need transitioned to Units)
#display "<h2><p style='text-align: center;'><a href='http://ibm.biz/PartnerMatrix' target='_blank'>Master list of Software Partners</a></p></h2>"

#display "<tbody>"
display "<hr style='color=#c00;background-color=#c00;' />"
display "<h1 align='center'>Partner Matrix - by Unit</h1>"
display "<table align='center' border='0' dir='ltr' style='width: 625px;'>"


let j = 1     # to match production flag
while j >= 0  #separate production from non
   let prodStr = ""
   let print_i = 0
for i = 1 to 30
#display j,i
initialize ActiveColor to NULL
initialize CRec.* to NULL

case i
   when brand_nc
      if( ActiveBrand[ brand_nc ])then
#         call GetColor( "WS", 0, 0 ) returning ActiveColor, textColor
         call GetControlRec( "NC" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         let url = "http://BP-PartnerMatrix.democentral.ibm.com/NA/WS/H/home.html"
      end if
   when brand_au
      if( ActiveBrand[ brand_au ])then
#         call GetColor( "WS", 0, 0 ) returning ActiveColor, textColor
         call GetControlRec( "AU" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         let url = "http://BP-PartnerMatrix.democentral.ibm.com/NA/WS/H/home.html"
      end if

   when brand_su
      if( ActiveBrand[ brand_su ])then
#         call GetColor( "WS", 0, 0 ) returning ActiveColor, textColor
         call GetControlRec( "SU" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         let url = "http://BP-PartnerMatrix.democentral.ibm.com/NA/WS/H/home.html"
      end if

   when brand_bu
      if( ActiveBrand[ brand_bu ])then
#         call GetColor( "BU", 0, 0 ) returning ActiveColor, textColor
         call GetControlRec( "BU" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         let url = "http://BP-PartnerMatrix.democentral.ibm.com/NA/BU/H/home.html"
      end if

   when brand_es
      if( ActiveBrand[ brand_es ])then
         call GetControlRec( "ES" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_st
      if( ActiveBrand[ brand_st ])then
         call GetControlRec( "ST" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_io
      if( ActiveBrand[ brand_io ])then
         call GetControlRec( "IO" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_wu
      if( ActiveBrand[ brand_wu ])then
         call GetControlRec( "WU" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_se
      if( ActiveBrand[ brand_se ])then
         call GetControlRec( "SE" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_cu
      if( ActiveBrand[ brand_cu ])then
         call GetControlRec( "CU" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_hw
      if( ActiveBrand[ brand_hw ])then
         call GetControlRec( "HW" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if



   when brand_ws
      if( ActiveBrand[ brand_ws ])then
#         call GetColor( "WS", 0, 0 ) returning ActiveColor, textColor
         call GetControlRec( "WS" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         let url = "http://BP-PartnerMatrix.democentral.ibm.com/NA/WS/H/home.html"
      end if

   when brand_im
      if( ActiveBrand[ brand_im ] )then
#         call GetColor( "IM", 0, 0 ) returning ActiveColor, textColor
         call GetControlRec( "IM" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/IM/H/home.html"
      end if

   when brand_ti
      if( ActiveBrand[ brand_ti ] )then
         call GetControlRec( "TI" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         call GetColor( "TI", 0, 0 ) returning ActiveColor, textColor
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/TI/H/home.html"
      end if

   when brand_ra
      if( ActiveBrand[ brand_ra ] )then
         call GetControlRec( "RA" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         call GetColor( "RA", 0, 0 ) returning ActiveColor, textColor
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/RA/H/home.html"
      end if

   when brand_lo
      if( ActiveBrand[ brand_lo ] )then
         call GetControlRec( "LO" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         call GetColor( "LO", 0, 0 ) returning ActiveColor, textColor
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/LO/H/home.html"
      end if

   when brand_ba
      if( ActiveBrand[ brand_ba ] )then
         call GetControlRec( "BA" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         call GetColor( "BA", 0, 0 ) returning ActiveColor, textColor
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/BA/H/home.html"
      end if

   when brand_se
      if( ActiveBrand[ brand_se ] )then
         call GetControlRec( "SE" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         call GetColor( "SE", 0, 0 ) returning ActiveColor, textColor
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/SE/H/home.html"
      end if

   when brand_is
      if( ActiveBrand[ brand_is ] )then
         call GetControlRec( "IS" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         call GetColor( "IS", 0, 0 ) returning ActiveColor, textColor
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/IS/H/home.html"
      end if

   when brand_sc
      if( ActiveBrand[ brand_sc ] )then
         call GetControlRec( "SC" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         call GetColor( "IS", 0, 0 ) returning ActiveColor, textColor
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/IS/H/home.html"
      end if

   when brand_em
      if( ActiveBrand[ brand_em ] )then
         call GetControlRec( "EM" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
#         call GetColor( "IS", 0, 0 ) returning ActiveColor, textColor
#         let url =  "http://BP-PartnerMatrix.democentral.ibm.com/NA/IS/H/home.html"
      end if

   when brand_mc
      if( ActiveBrand[ brand_mc ] )then
         call GetControlRec( "MC" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_md
      if( ActiveBrand[ brand_md ] )then
         call GetControlRec( "MD" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_mf
      if( ActiveBrand[ brand_mf ] )then
         call GetControlRec( "MF" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_mi
      if( ActiveBrand[ brand_mi ] )then
         call GetControlRec( "MI" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   when brand_mp
      if( ActiveBrand[ brand_mp ] )then
         call GetControlRec( "MP" ) returning CRec.*
         let prodStr = BuildProdStr(CRec.production, prodStr, CRec.menu_str)
      end if

   otherwise
   let url =  ""
end case

let brandStr = CRec.menu_str
let ActiveColor = CRec.active_color
let textColor = CRec.text_color
let url = CRec.url

#display i, ActiveColor
##
if( i = 1 )then
   display "<tr>"
end if

if( ActiveColor is not NULL and MatchProd(j, CRec.production) )then
   display "<td style='width: 125px; text-align: center; vertical-align: middle; "
   display "background-color: ", ActiveColor clipped, "; color: ", textColor clipped, "; border-color: rgb(255, 255, 255); border-style: solid; border-width: 2px;'>"
   display "<span style='font-size:14px; style=color: ", textColor clipped, "'><a href='", url clipped, "' style='text-decoration:none'><span style='color: ", textColor clipped, ";'>", 
   brandStr clipped, "</span></a></span></td>"
   let print_i = print_i + 1
end if

if( print_i mod 5 = 0 )then
   display "</tr>"
   display "<tr>"
end if
end for  #i


   let j = j - 1
   display "</tr>"
   display "<tr>"
end while  #j

display "</tr></table>"
#display "</tbody>"

display "<p dir='ltr' style='text-align: center;'>"

display "<i>Only these Units are in production: ", prodStr clipped, "</i></p>"

display "<br /><br />"
display "<span style='font-size:16px;text-align: center;'><p dir='ltr'; 'text-align: center;'><a href='http://ibm.biz/PartnerMatrixBlog' target='_blank'>Partner Matrix Blog</a></span><br />"
display "<span style='font-size:16px;text-align: center;'><p dir='ltr'; 'text-align: center;'><a href='../NA/all/H/tasklist.html' target='_blank'>Change Request Listing</a></span>"


end main

{
function BrandAvail( inBrand )
define
   inBrand char(2),
   cnt smallint,
   ret smallint,
   tabStr char(25),
   SQLStr char(128)

   let ret = FALSE
   let tabStr = "coverage_", inBrand clipped
   let SQLStr = "select count(*) from ", tabStr clipped
   prepare BA1 from SQLStr
   execute BA1 into cnt

   if( cnt > 0 )then
      let ret = TRUE
   end if

  return ret

end function
}
