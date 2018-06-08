globals "globals.4gl"

function ReadCmdLn( inprg, innum)
define
   inprg char(10),
   innum smallint

if ( num_args() != innum ) then
   display "Usage example: ", inprg clipped, " DB IOT BRAND CEID <other>"
   exit program
end if

let CLRec.db = arg_val(1)
let CLRec.iot = arg_val(2)
let CLRec.brand = arg_val(3)
let CLRec.CEID = arg_val(4)

end function
