
database partners_na

main
define
   LRec record like library.*,
   SQLStr char(512)

let SQLStr = "select a.* from library a order by dates desc"

prepare LIBID from SQLStr
declare LIBCurs cursor for LIBID

foreach LIBCurs into LRec.*
   display LRec.dates
   display LRec.title clipped
end foreach



end main

