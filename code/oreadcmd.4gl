function ReadCmdLn( inprg )
define
   inprg char(10),
   inIOT char(10),
   inBrand char(10),
   SQLStr char(128)

if ( num_args() != 2 ) then
   display "Usage: ", inprg clipped, " IOT BRAND"
   exit program
end if
let inIOT = arg_val(1)
let inBrand = arg_val(2)

let SQLStr='select a.* from iots a where a.i_id = "', inIOT clipped, '"'
prepare IID from SQLStr
execute IID into IRec.*

let SQLStr='select a.* from brands a where a.b_id = "', inBrand clipped, '"'
prepare BID from SQLStr
execute BID into BRec.*

end function
