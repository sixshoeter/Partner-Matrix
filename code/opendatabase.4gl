function OpenDatabase( indb )
define
   indb char(18),
   SQLStr char(32)

let SQLStr = "database ", indb clipped

prepare ODID from SQLStr
execute ODID
   
end function
