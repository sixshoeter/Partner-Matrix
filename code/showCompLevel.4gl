
## 12/12/2016  John M. Shoemaker, jshoemaker1@cox.net - created
## 02/07/2017  John M. Shoemaker, jshoemaker1@cox.net - add in sales/tech resources, #205
## May      21, 2017 - John Shoemaker jshoemaker1@cox.net - sync up columns for competency, 231

globals "globals.4gl"

define
   InRec record
      ceid like coverage_au.ceid,
      comp_name like competency.comp_name,
      brand like brands.b_id
   end record

main
define
   CompRec record like competency.*,#
{
ceid char(10),
part_name char(60),
pw_level_curr_yr char(8),
pw_level_next_yr char(8),
pw_level_grace char(8),
num_client_ref smallint,
client_sat_surv char(3),
resale_auth char(3),
bu char(25),
comp_name char(50),
achieved_level char(12),
stat char(12),

certs smallint,
certs_req_spec smallint,
certs_req_exp smallint,
certs_sales smallint,
certs_req_sales_spec smallint,
certs_req_sales_exp smallint,

certs_tech smallint,
certs_req_tech_spec smallint,
certs_req_tech_exp smallint,

res smallint,
res_req_spec smallint,
res_req_exp smallint,

res_tech smallint,
res_req_tech_spec smallint,
res_req_tech_exp smallint,

res_sales smallint,
res_req_sales_spec smallint,
res_req_sales_exp smallint,

res_tech_sales_certs smallint,
res_tech_sales_sols smallint,

sols smallint,
sols_req_spec smallint,
sols_req_exp smallint,
rev_prev_yr integer,
rev_curr_yr integer,
rev_req_spec integer,
rev_prev_yr_exp integer
end record,
}
bgc char(16),  #back ground color
i smallint,
snum, enum smallint,
snum1, enum1 float,
   SQLStr char(1024)
{
   i,j,l,iidx,nidx smallint,
   nSArr array[34] of smallint,
   cmdStr char(2100),
   eidx smallint,
   wStr char(2100),
   kStr char(2100),
   vStr char(2100),
   SQLStr char(2100),
   UPDStr char(2100),
   dStr char(2100),
   multi smallint,
   runStr char(512),
   tStr char(100),
   addTS smallint,
   ossr, nssr like coverage_au.ssr
}

#call ReadCmdLn( "updSkills", 34 )
call ReadCmdLn( "showCompLevel", 5 )
call ProcCmdLn( "showCompLevel" )
#call Header(0, IRec.i_id, BRec.b_id, 1)

## extract the CEID
let InRec.ceid = arg_val(4)
let InRec.comp_name = CleanUp( arg_val(5) )

call ShowTitle( FALSE )


display "<p><br>"
#display "<div dir='ltr' style='text-align: center'> <em><span style='font-size: 20px'>"
display "<div dir='ltr''> <span style='font-size: 20px'>"
display "The <strong>PartnerWorld Competency Framework </strong>provides a single, global capabilities framework supporting our clients, sales teams and our Business Partners." 
display "It recognizes all types of Business Partner business models, including resale, influence, and XaaS."
display "Business Partners qualify based opon skills (certifications) <em>OR</em> approved verified solution or deployments</span></div>"
display "<hr>"

let SQLStr = "select unique a.* ",
     "from competency a where a.ceid='", InRec.ceid clipped, "' and ",
     "a.comp_name='", InRec.comp_name clipped, "' "
{
let SQLStr = "select unique ceid, part_name, pw_level_curr_yr, pw_level_next_yr, pw_level_grace, num_client_ref, ",
     "client_sat_surv, resale_auth, bu, comp_name, achieved_level, stat, certs, certs_req_spec, ",
     "certs_req_exp, certs_sales smallint, certs_req_sales_spec, certs_req_sales_exp, ",
     "certs_tech, certs_req_tech_spec, certs_req_tech_exp, res, res_req_spec, res_req_exp, ",
     "res_tech, res_req_tech_spec, res_req_tech_exp, res_sales, res_req_sales_spec, ",
     "res_req_sales_exp, res_tech_sales_certs, res_tech_sales_sols, sols, sols_req_spec, ",
     "sols_req_exp, rev_prev_yr, rev_curr_yr, rev_req_spec, rev_prev_yr_exp ",
     "from competency a where a.ceid='", InRec.ceid clipped, "' and ",
     "a.comp_name='", InRec.comp_name clipped, "' "
}

#display SQLStr
prepare C1ID from SQLStr
#declare C1Curs cursor for C1ID
initialize CompRec.* to NULL
execute C1ID into CompRec.*

display "<div dir='ltr''> <span style='font-size: 20px'>"
display "<table>"
display "<tr><td>Partner: </td><td>", CompRec.part_name clipped, "<td></tr>"
display "<tr><td>2017 PW Level: </td><td>", CompRec.pw_level clipped, "<td></tr>"
if( CompRec.client_sat_surv = "Yes" )then
   display "<tr><td>Client Satisfaction: </td><td>", CompRec.client_sat_surv clipped, "<td></tr>"
end if
if( CompRec.num_client_ref > 0 )then
   display "<tr><td>Client References: </td><td>", CompRec.num_client_ref clipped, "<td></tr>"
end if
display "<tr><td>Business Unit: </td><td>", CompRec.bu clipped, "<td></tr>"
display "<tr></tr>"
display "<tr><td>Competency: </td><td><strong>", CompRec.comp_name clipped, "</strong><td></tr>"
if( CompRec.level is NULL or CompRec.level = " " )then
display "<tr><td>Achieved Level: </td><td><strong>*NONE*</strong><td></tr>"
else
   display "<tr><td>Achieved Level: </td><td><strong>", CompRec.level clipped, "</strong><td></tr>"
end if
#display "Status: ", CompRec.stat clipped, "<br>"
display "</table>"

display "<br>"
case CompRec.level
   when 'Specialist'
      let enum1 = 1
#      let enum = CompRec.certs_req_sales_exp + CompRec.certs_req_tech_exp + CompRec.res_req_sales_exp + CompRec.res_req_tech_exp + CompRec.sols_req_exp
	let snum1 = CompRec.exp_prog_pct
{
      let snum = normLevel(CompRec.certs_req_sales_exp, CompRec.certs_sales) + 
                 normLevel(CompRec.certs_req_tech_exp, CompRec.certs_tech) + 
                 normLevel(CompRec.res_req_sales_exp, CompRec.res_sales ) + 
                 normLevel(CompRec.res_req_tech_exp, CompRec.res_tech ) + 
                 normLevel(CompRec.sols_req_exp, CompRec.sols )
}
      display "<table><tr><td>Progress towards <strong>Expert Level</strong>:</td>"
      display "<td><progress max='", enum1, "' value='", snum1, "'></progress></td>"
      display "</tr></table>"
#display snum, enum
      display "<table>"
      display "<tr><th>Requirement<th>Required<th>Achieved</tr>"
      display "<tr><td>Sales Certifications:</td><td style='text-align: center;'> ", CompRec.certs_req_sales_exp, "</td><td style='text-align: center;'>", CompRec.certs_sales, "</td></tr>"
      display "<tr><td>Technical Certifications:</td><td style='text-align: center;'>", CompRec.certs_req_tech_exp, "</td><td style='text-align: center;'>", CompRec.certs_tech, "</td></tr>"
      display "<tr><td>Sales Resources (Certs):</td><td style='text-align: center;'>", CompRec.res_req_sales_exp, "</td><td style='text-align: center;'>", CompRec.res_sales_certs, "</td></tr>"
      display "<tr><td>Technical Resources (Certs):</td><td style='text-align: center;'>", CompRec.res_req_tech_exp, "</td><td style='text-align: center;'>", CompRec.res_tech_certs, "</td></tr>"
      display "<tr><td>Sales Resources:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.res_sales_sols, "</td></tr>"
      display "<tr><td>Technical Resources:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.res_tech_sols, "</td></tr>"
      display "<tr><td>Solutions:</td><td style='text-align: center;'>", CompRec.sols_req_exp, "</td><td style='text-align: center;'>", CompRec.sols, "</td></tr>"
      display "<tr><td>Sales Success:</td><td style='text-align: center;'>", CompRec.rev_req_exp using "$$$,$$$,$$$", "</td><td style='text-align: center;'>", CompRec.rev_norm_curr_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>Resell:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_resale_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>Influence:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_influence_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>XaaS:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_xaas_yr using "$$$,$$$,$$$", "</td></tr>"

   when 'Expert'
        let enum1 = 1
	let snum1 = CompRec.exp_prog_pct
{
      let enum = CompRec.certs_req_sales_exp + CompRec.certs_req_tech_exp + CompRec.res_req_sales_exp + CompRec.res_req_tech_exp + CompRec.sols_req_exp
      let snum = normLevel(CompRec.certs_req_sales_exp, CompRec.certs_sales) + 
                 normLevel(CompRec.certs_req_tech_exp, CompRec.certs_tech) + 
                 normLevel(CompRec.res_req_sales_exp, CompRec.res_sales) + 
                 normLevel(CompRec.res_req_tech_exp, CompRec.res_tech) + 
                 normLevel(CompRec.sols_req_exp, CompRec.sols)
}
#display snum, enum
      display "<table><tr><td>Currently at <strong>Expert Level</strong>:</td>"
      display "<td><progress max='", enum1, "' value='", snum1, "'></progress></td>"
      display "</tr></table>"

      display "<table>"
      display "<tr><th>Requirement<th>Required<th>Achieved</tr>"
      display "<tr><td>Sales Certifications:</td><td style='text-align: center;'> ", CompRec.certs_req_sales_exp, "</td><td style='text-align: center;'>", CompRec.certs_sales, "</td></tr>"
      display "<tr><td>Technical Certifications:</td><td style='text-align: center;'>", CompRec.certs_req_tech_exp, "</td><td style='text-align: center;'>", CompRec.certs_tech, "</td></tr>"
      display "<tr><td>Sales Resources (Certs):</td><td style='text-align: center;'>", CompRec.res_req_sales_exp, "</td><td style='text-align: center;'>", CompRec.res_sales_certs, "</td></tr>"
      display "<tr><td>Technical Resources (Certs):</td><td style='text-align: center;'>", CompRec.res_req_tech_exp, "</td><td style='text-align: center;'>", CompRec.res_tech_certs, "</td></tr>"
      display "<tr><td>Sales Resources:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.res_sales_sols, "</td></tr>"
      display "<tr><td>Technical Resources:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.res_tech_sols, "</td></tr>"
      display "<tr><td>Solutions:</td><td style='text-align: center;'>", CompRec.sols_req_exp, "</td><td style='text-align: center;'>", CompRec.sols, "</td></tr>"
      display "<tr><td>Sales Success:</td><td style='text-align: center;'>", CompRec.rev_req_exp using "$$$,$$$,$$$", "</td><td style='text-align: center;'>", CompRec.rev_norm_curr_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>Resell:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_resale_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>Influence:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_influence_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>XaaS:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_xaas_yr using "$$$,$$$,$$$", "</td></tr>"
      

   otherwise
        let enum1 = 1
	let snum1 = CompRec.spec_prog_pct
#display "enum1: ", enum1, " snum1: ", snum1
{
      let enum = CompRec.certs_req_sales_spec+CompRec.certs_req_tech_spec+CompRec.res_req_sales_spec+CompRec.res_req_tech_spec+CompRec.sols_req_spec
      let snum = normLevel(CompRec.certs_req_sales_spec, CompRec.certs_sales) +
                 normLevel(CompRec.certs_req_tech_spec, CompRec.certs_tech) +
                 normLevel(CompRec.res_req_sales_spec, CompRec.res_sales) +
                 normLevel(CompRec.res_req_tech_spec, CompRec.res_tech) +
		 normLevel(CompRec.sols_req_spec, CompRec.sols)
}
#display snum, enum
      display "<table><tr><td>Progress towards <strong>Specialist Level</strong>:</td>"
      display "<td><progress max='", enum1, "' value='", snum1, "'></progress></td>"
      display "</tr></table>"
      display "<table>"
      display "<tr><th>Requirement<th>Required<th>Achieved</tr>"
      display "<tr><td>Sales Certifications:</td><td style='text-align: center;' >",  CompRec.certs_req_sales_spec, "</td><td style='text-align: center;' >", CompRec.certs_sales, "</tr>"
      display "<tr><td>Technical Certifications:</td><td style='text-align: center;'>",  CompRec.certs_req_tech_spec, "</td><td style='text-align: center;'>", CompRec.certs_tech, "</tr>"
      display "<tr><td>Sales Resources (Certs):</td><td style='text-align: center;'>",  CompRec.res_req_sales_spec, "</td><td style='text-align: center;'>", CompRec.res_sales_certs, "</tr>"
      display "<tr><td>Technical Resources (Certs):</td><td style='text-align: center;'>",  CompRec.res_req_tech_spec, "</td><td style='text-align: center;'>", CompRec.res_tech_certs, "</tr>"
      display "<tr><td>Sales Resources:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.res_sales_sols, "</td></tr>"
      display "<tr><td>Technical Resources:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.res_tech_sols, "</td></tr>"
      display "<tr><td>Solutions:</td><td style='text-align: center;'>",  CompRec.sols_req_spec, "</td><td style='text-align: center;'>", CompRec.sols, "</td></tr>"
      display "<tr><td>Sales Success:</td><td style='text-align: center;'>", CompRec.rev_req_spec using "$$$,$$$,$$$", "</td><td style='text-align: center;'>", CompRec.rev_norm_curr_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>Resell:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_resale_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>Influence:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_influence_yr using "$$$,$$$,$$$", "</td></tr>"
      display "<tr><td>XaaS:</td><td style='text-align: center;'></td><td style='text-align: center;'>", CompRec.rev_curr_xaas_yr using "$$$,$$$,$$$", "</td></tr>"
      display "</table>"
end case

display "</div>"

end main

function normLevel( maxlevel, currlevel )
define
   maxlevel, currlevel smallint,
   retVal smallint

   let retVal = 0
   if( currlevel <= maxlevel )then
      let retVal = currlevel
   else
      let retVal = maxlevel
   end if

   return retVal

end function  #normLevel
