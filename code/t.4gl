globals "globals.4gl"

main
define
   nStr char(128),
   oUnit like unit_brand.u_id

   let oUnit = "AU"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "SU"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "BU"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "ES"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "ST"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "IO"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "WU"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "SE"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "CU"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
   let oUnit = "UU"
   let nStr = GetUnitBrandInclStr( oUnit )
   display nStr
end main

function GetUnitBrandInclStr( inUnit )
define
   inUnit like unit_brand.u_id,
   retStr char(128),
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

