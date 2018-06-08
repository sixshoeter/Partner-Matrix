# March      10, 2015   John M. Shoemaker, filter for active CEIDs
# September  08, 2015   John M. Shoemaker, add in not resellers #118

globals "globals.4gl"

main
define
   qtrStr char(512),
   t_ceid like coverage_ws.ceid
  
call ReadCmdLn("loopPages", 4)
call ProcCmdLn("loopPages")

{
case BRec.b_id
   when "WS"
      let cov_tab = "coverage_ws"
   when "IM"
      let cov_tab = "coverage_im"
   when "TI"
      let cov_tab = "coverage_ti"
   when "RA"
      let cov_tab = "coverage_ra"
   when "LO"
      let cov_tab = "coverage_lo"
   when "BA"
      let cov_tab = "coverage_ba"
   when "SE"
      let cov_tab = "coverage_se"
   when "IS"
      let cov_tab = "coverage_is"
   otherwise
      let cov_tab = "coverage"
end case
}

#let qtrStr="select a.ceid from ", cov_tab clipped, " a where a.ceid is not null and reseller!='N'"

# 3/28/2016 - commented out PROD line below and added next line to allow more CEIDs to be included 
#PROD let qtrStr="select unique a.ceid from ", cov_tab clipped, " a, tbptv b, svp c where a.ceid=b.ceid and c.bptv_name=b.rag and c.s_brand='", BRec.b_id clipped, "' and a.ceid is not null "
#
let qtrStr="select unique a.ceid from ", cov_tab clipped, " a where a.ceid is not null and a.reseller != 'X' "

#display qtrStr clipped

prepare QID from qtrStr
declare ACurs cursor for QID

foreach ACurs into t_ceid
   display t_ceid clipped
end foreach

end main

