
database partners

main

define
    ARec record like coverage.*

declare ACurs cursor for
   select * from coverage where coverage.ceid is not null

foreach ACurs into ARec.*
   display "fglgo buildPages ", ARec.ceid clipped
end foreach

end main
