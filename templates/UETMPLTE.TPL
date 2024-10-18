<?xml version="1.0"?>
<Templates encode="utf8escenc"><Template Name="mpt_2cern_search_ccl" Description="CCL to search backend files.">Usage:
   execute 2cern_search_ccl "MINE"
 	, value("CCLUSERDIR","CCLSOURCE","CUST_SCRIPT","CER_SCRIPT","CUST_HTML","CER_TEMP")
 	, value("html", "prg", "ekm")
 	, "heartrate" go  

;Example searching .prg files for the term "heartrate" in the CUST_SCRIPT directory: 
execute 2cern_search_ccl "MINE" , value("CUST_SCRIPT")
 	, value("prg")
 	, "heartrate" go  

;Example searching .html files for "IE8" in the CUST_HTML directory: 
execute 2cern_search_ccl "MINE" , value("CUST_HTML")
 	, value("html")
 	, "IE8" go  

;Example searching (rules) .ekm files for "COVID" in the CCLUSERDIR directory: 
execute 2cern_search_ccl "MINE" , value("CCLUSERDIR")
 	, value("ekm") 	, "COVID" go  

;-------------NEW MODIFICATION ALLOWS SPACES--------------- 
execute 1bh_mpage_script_search "MINE" ;param #1 as "MINE"
         , value("CUST_SCRIPT") ;param #2 as logical/path, e.g. "CCLUSERDIR","CCLSOURCE","CUST_SCRIPT","CER_SCRIPT","CUST_HTML","CER_TEMP"
         , value("prg") ;param #3 as program file extension, e.g. "html", "prg", "js"
         , value( ;param #4 as search expression. Limit 289/- in text size. Allow wildcard ".*", white-space and multi-expression.
            "1bh_mpage_"; search expression 1
            ,"1samt_az_"; search expression 2
           )         go  

execute 1bh_mpage_script_search "MINE" ;param #1 as "MINE"
         , value("CUST_HTML") ;param #2 as logical/path, e.g. "CCLUSERDIR","CCLSOURCE","CUST_SCRIPT","CER_SCRIPT","CUST_HTML","CER_TEMP"
         , value("html") ;param #3 as program file extension, e.g. "html", "prg", "js"
         , value( ;param #4 as search expression. Limit 289/- in text size. Allow wildcard ".*", white-space and multi-expression.
            "1bh_mpage_"; search expression 1
            ,"1samt_az_"; search expression 2
           )
         go  

;Example search for pressure ulcer:
execute 1bh_mpage_script_search "MINE"	;param #1 as "MINE"
	, value("CUST_SCRIPT")					;param #2 as logical/path, e.g. "CCLUSERDIR","CCLSOURCE","CUST_SCRIPT","CER_SCRIPT","CUST_HTML","CER_TEMP"
	, value("prg")							;param #3 as program file extension, e.g. "html", "prg", "js"
	, value(								;param #4 as search expression. Limit 289/- in text size. Allow wildcard ".*", white-space and multi-expression.
		"PRESSUREULCER"
		,"Pressure Ulcer"
		,"INCISIONWOUNDPRESSUREULCERSTAGE"
		,"Incision, Wound Pressure"
		,"2304690569"
	  )
	go
^</Template><Template Name="mpt_ambulatory_organizer" Description="Ambulatory Organizer">Troubleshooting Ambulatory Organizer Manually Satisfied Items
Reference: SR: 443841607
Problem: PRB0043557 - Charges Inconsistently Showing Completed on Ambulatory Organizer
  Query To See Who Satisfied
  SELECT
  M.MANUAL_IND
  , M_OPEN_ITEM_TYPE_DISP = UAR_GET_CODE_DISPLAY(M.OPEN_ITEM_TYPE_CD)
  , M.MP_AMB_ORG_SAT_ID
  , M.SATISFIED_PRSNL_ID
  , M.SCH_EVENT_ID
  , P.NAME_FULL_FORMATTED
  FROM
  MP_AMB_ORG_SAT   M
  , PERSON   P
  PLAN M WHERE M.PARENT_ENTITY_ID = ;sch_event_id of the appointment (can be found in Blackbird)
  JOIN P WHERE P.PERSON_ID = M.SATISFIED_PRSNL_ID
  with time = 10
^</Template><Template Name="mpt_Application_ini" Description="Application.ini delete.">;From DA2
;  Application ini reset

;From CCL command prompt:
  BH_IT_INIRESET 0,PERSON_ID, 600005 go ;Powerchart
  BH_IT_INIRESET 0,PERSON_ID, 4250111 go ;FirstNet
  BH_IT_INIRESET 0,PERSON_ID, 3070000 go ;Explorer Menu
  BH_IT_INIRESET 0,PERSON_ID, 800040 go ;SurgiNet
  BH_IT_INIRESET 0,PERSON_ID, 820000 go ;SurgiNet
  BH_IT_INIRESET 0,PERSON_ID, 380000 go ;Ph MedMgr
  BH_IT_INIRESET 0,PERSON_ID, 390000 go ;Pharm Charge/Credit

select
from
	application_ini
where
	person_id = (select x.person_id from prsnl x where x.username = cnvtupper("[+USERNAME+]"))
and
	application_number=600005; Powerchart
	;application_number=4250111; FirstNet
	;application_number=3070000; Explorer Menu
	;application_number=800040; SurgiNet
	;application_number=820000; SurgiNet
	;application_number=390000; Pharm Charge/Credit
	;application_number=380000; Ph MedMgr
go

delete
from
	application_ini
where
	person_id = (select x.person_id from prsnl x where x.username = cnvtupper("[+USERNAME+]"))
and
	application_number=600005; Powerchart
	;application_number=4250111; FirstNet
	;application_number=3070000; Explorer Menu
	;application_number=800040; SurgiNet
	;application_number=820000; SurgiNet
	;application_number=390000; Pharm Charge/Credit
	;application_number=380000; Ph MedMgr
go

;Show what will be deleted before deleting.
select p.name_full_formatted
, p.username
, p.position_cd
, a.parameter_data
, a.section
, a.updt_dt_tm
;, p.*
from application_ini a
, prsnl p	;user info
where p.username = "[+USERNAME+]"
and a.person_id = p.person_id
and a.application_number = 600005 ;PowerChart
;and a.updt_dt_tm &gt; sysdate-60
;and p.name_full_formatted like "*Horst*"
order by p.name_full_formatted, a.updt_dt_tm desc
WITH UAR_CODE(D), FORMAT(DATE,";;Q"), TIME=60, MAXREC=1000
^</Template><Template Name="mpt_ApplicationPrefs" Description="The page was unable to load successfully only for one user">;Page was unable to load successfully error or a white screen displays instead of the mPage view.

;Discern Analytics Report: Update mPage VWP Preferences (1BH_UPDATE_MPAGE_VWP_PREFS.PRG)

;[+USERNAME+] [+THEVIEWNAME+] - Example viewname: VWP|EDNURSINGVIEW
select distinct
n.parent_entity_id
,n.pvc_value
,n.name_value_prefs_id
,a.application_number
,n.pvc_name
,n.active_ind
from
app_prefs a
,name_value_prefs n
plan a
where a.prsnl_id = (select person_id from prsnl p where p.[+USERNAME+] = cnvtupper("[+USERNAME+]"))
join n
where n.parent_entity_id = a.app_prefs_id
and n.parent_entity_name = "APP_PREFS"
and cnvtupper(n.pvc_name) in ("VWP|*","MP_*","VB_*")
;and cnvtupper(n.pvc_name) = "[+THEVIEWNAME+]"; Comment this line to see all view names (n.pvc_name) associated with the [+USERNAME+].
order by n.pvc_name, n.parent_entity_id, n.sequence

delete
from
name_value_prefs n
where n.parent_entity_id in (0000000000.00)
and n.parent_entity_name = "APP_PREFS"
and n.pvc_name = "[+THEVIEWNAME+]"
go
commit go
^
</Template><Template Name="mpt_bedrock_logging" Description="Turn on Bedrock Logging">To turn on Bedrock Logging: 
shift+control+i in Bedrock to turn on logging.
You can then download the log file and search through it.</Template><Template Name="mpt_blackbird" Description="Blackbird">To capture Blackbird logs:
Hold the Control Key and press the Backslash Key and release. Then press the F2 Key.
Hold CTRL + \ and then hit F2
^</Template><Template Name="mpt_callback" Description="COVID-19 Callback">Voicemail Script: leave message on first attempt
Hi, this message is for [+FirstName+].
This is Robert with Banner Health.
We are leaving this message for you to report your recent test results were negative.
You can get a copy of your results through the Sonora Quest portal (www.sonoraquest.com)
and/or visit online portal at mybanner.bannerhealth.com.
If your symptoms worsen call your PCP/Urgent Care prior to arriving in office.
We suggest calling your PCP if you have any questions or to discuss any return to work questions when you are feeling better.
^</Template><Template Name="mpt_Canned_Components" Description="Show canned components">select; into $outdev
	cname = cnvtupper (c.category_name )
	, c.br_datamart_category_id
	, c.category_name
	, c.category_mean
	, c.layout_flag
	, br.report_mean
	, br.report_name
	, br.report_seq

from
	br_datamart_category   c
	, br_datamart_report   br
	, br_datamart_report_filter_r   bfr
	, br_datamart_filter   bf

plan c where c.br_datamart_category_id &gt; 0
join  br
where br.br_datamart_category_id = c.br_datamart_category_id
join bfr
where bfr.br_datamart_report_id = br.br_datamart_report_id
join bf
where bf.br_datamart_filter_id = bfr.br_datamart_filter_id
 and bf.filter_category_mean ="MP_SECT_PARAMS"
order by
	cname
	, bf.filter_seq
^</Template><Template Name="mpt_ccl_between" Description="CCL between">
select ;into tct_p
        p.*
from
        person p
        , prsnl pp
where
        p.person_id = pp.person_id
        and p.name_last between ('A*') and ('C*')
order by
        p.name_last, p.name_first
with
        maxrec= 20000, time = 300;

 o.orig_order_dt_tm BETWEEN cnvtlookbehind("1,Y") and cnvtdatetime(curdate,curtime3)
 AND D.DIAG_DT_TM between cnvtdatetime(curdate-365, curtime3) and cnvtdatetime(curdate, curtime)
 if(p.data_status_dt_tm BETWEEN cnvtdatetime(cnvtdate(09012019),000000)and cnvtdatetime(cnvtdate(04012020),000000))
 where E.BEGIN_DT_TM BETWEEN CNVTDATETIME("01-JAN-2013 00:00") and CNVTDATETIME("03-JAN-2013 00:00")
 where p.birth_dt_tm not between cnvtlookbehind("18,Y",e.reg_dt_tm)
 ce3.event_end_dt_tm between cnvtdatetime(output-&gt;qual[d.seq].arrive_dt_tm)
 E.DISCH_DT_TM between CNVTDATETIME ((curdate - 2), 0) AND CNVTDATETIME ((curdate - 2), 2359)
^</Template><Template Name="mpt_ccl_count" Description="Count number of identical items in table.">;Changing OTS User cust_samt.cust_prsnlauthpos user count higher than 2;
select
  custp.usr_person_id, p.username, p.name_full_formatted, Num_of_Entries=count(*)
from
  cust_samt.cust_prsnlauthpos custp
  ,prsnl p
plan custp
join p where p.person_id = custp.usr_person_id
group by custp.usr_person_id, p.username, p.name_full_formatted
having count(*) &gt; 2
order by count(*) desc;
^</Template><Template Name="mpt_ccl_dateFormatCE" Description="Long Clinical Event Date in Result_Val field">select
  date_vc = ce.result_val
  , date_dq8 = cedr.result_dt_tm
  , date_dq8_formatted = format(cedr.result_dt_tm, "mm/dd/yyyy hh:mm:ss;;q")
  , date_dq8_formatted_tz = datetimezoneformat(cedr.result_dt_tm, cedr.result_tz, "MM/dd/yyyy HH:mm:ss ZZZ")
from
  clinical_event ce
  , ce_date_result cedr
plan ce where ce.event_id = [+THE_EVENT_ID+]
join cedr where cedr.event_id = ce.event_id
with nocounter, separator=" ", format
^</Template><Template Name="mpt_ccl_datetime" Description="Common CCL Time Date Functions">https://wiki.cerner.com/display/public/1101discernHP/Display+Template+Using+Discern+Explorer

select
month_numeric = month(cnvtdatetime(curdate,curtime))
,month_alphabet = substring(4,3,format(cnvtdatetime(curdate,curtime),"DD/MMM/YYYY;;q"))
,month_full_name = trim(substring(4,9,format(cnvtdatetime("01-SEP-2020 23:59:59"),"DD/MMMMMMMMM/YYYY;;q")),3)
,weekday = weekday(cnvtdatetime(curdate,curtime))
,day = day(cnvtdatetime(curdate,curtime))
,year = year(cnvtdatetime(curdate,curtime))
,days = datetimediff(cnvtdatetime("01-JAN-2020 11:30"), cnvtdatetime("31-DEC-2019 11:35"),1) ;Returns difference in Days (Default)
,Weeks = datetimediff(cnvtdatetime("7-JAN-2020 11:30"), cnvtdatetime("31-DEC-2019 11:35"),2) ;Returns difference in Weeks
,Hours = datetimediff(cnvtdatetime("01-JAN-2020 11:30"), cnvtdatetime("31-DEC-2019 11:30"),3) ;Returns difference in Hours
,Minutes= datetimediff(cnvtdatetime("01-JAN-2020 11:30"), cnvtdatetime("31-DEC-2019 11:30"),4) ;Returns difference in Minutes
,Seconds = datetimediff(cnvtdatetime("01-JAN-2020 11:30"), cnvtdatetime("31-DEC-2019 11:30"),5) ;Returns difference in Seconds
,Days_Diff = datetimecmp(cnvtdatetime("01-JAN-2020 11:30"), cnvtdatetime("31-DEC-2019 11:29")) ;Returns difference in  Days, ignores time part

/*Truncate*/
,trunc_date = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "DD"), ";;q") ;Truncates the time portion
,trunc_date1 = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "MI"), ";;q") ;Truncates the seconds portion
,trunc_date2 = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "HH"), ";;q") ;Truncates the minute and second portion
,trunc_date3 = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "J"), ";;q") ;Truncates the time portion
,trunc_date4 = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "DD"), ";;q") ;Truncates the time portion
,trunc_date5 = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "WW"), ";;q") ;Starting day of the week
,trunc_date6 = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "MM"), ";;q") ;Starting day of the month
,trunc_date7 = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "YY"), ";;q") ;Starting Date of the year
,trunc_date8 = format(datetimetrunc(cnvtdatetime("02-DEC-2020 10:55:29"), "Q"), ";;q") ;Starting Date of the Quarter

/*AGE*/
,Get_Date_of_Birth = format(cnvtagedatetime(23,0,0,0),"DD/MMM/YYYY HH:MM:SS ;;q") ;YEAR,MONTH,WEEK,DAY; Use Zero in case of blanks
;Commented the following line because (p.) does not exist in dummyt:
;;,age = cnvtage(p.birth_dt_tm) ;Current Age
;Commented the following line because (p.) does not exist in dummyt:
;;,age_at_registration = cnvtage(p.birth_dt_tm, e.reg_dt_tm,0) ;Age at registration; can be replaced with any other event
;Commented the following line because (charge.) does not exist in dummyt:
;;,add_to_date = datetimeadd(charge.service_dt_tm, 10) ;Adds ten days to service date time
;Commented the following line because of (charge.) does not exist in dummyt:
;;,add_to_date = datetimeadd(charge.service_dt_tm, -3) ;Adds minus three days to the service date time

/*Beginning or end of a period
The following can be used with
"D" -Day
,"W" -Week
,"M" -Month
,"Q" -Quarter
,"Y" -Year
,"C" -Century
*/
,begin_date = format(datetimefind(cnvtdatetime(curdate,0),"w","b","b"),"DD/MMM/YYYY HH:MM:SS ;;q") ;Begnning of the week, beginning of the time on that day
,begin_date1 = format(datetimefind(cnvtdatetime(curdate,0),"w","b","e"),"DD/MMM/YYYY HH:MM:SS ;;q") ;Begnning of the week, end of the time on that day
,end_date = format(datetimefind(cnvtdatetime(curdate,0),"w","e","b"),"DD/MMM/YYYY HH:MM:SS ;;q") ;End of the week, beginning of the time on that day
,end_date1 = format(datetimefind(cnvtdatetime(curdate,0),"w","e","e"),"DD/MMM/YYYY HH:MM:SS ;;q") ;End of the week, end of the time on that day

/*Date time part*/
,Year = datetimepart(cnvtdatetime("02-DEC-2020 10:45:00"),1)
,Year1 = year(cnvtdatetime("02-DEC-2020 10:45:00"))
,Month = datetimepart(cnvtdatetime("02-DEC-2020 10:45:00"),2)
,Month1 = month(cnvtdatetime("02-DEC-2020 10:45:00"))
,Day = datetimepart(cnvtdatetime("02-DEC-2020 10:45:00"),3)
,Day1 = day(cnvtdatetime("02-DEC-2020 10:45:00"))
,Hour = datetimepart(cnvtdatetime("02-DEC-2020 10:45:00"),4)
,Hour1 = hour(cnvtdatetime("02-DEC-2020 10:45:00"))
,Minute = datetimepart(cnvtdatetime("02-DEC-2020 10:13:00"),5)
,Minute1 = minute(cnvtdatetime("02-DEC-2020 10:13:00"))

/*CNVTMIN - Returns number of minutes from 00:00:00*/
,MIN1 = cnvtmin(0100,1)     ;Returns 60
,MIN2 = cnvtmin(1018,1)     ;Returns 618
;Commented the following line because of (ce.):
;;,MIN3 = cnvtmin(ce.event_end_dt_tm,5)     ;if the event_end_dt_tm column is 01-JAN-1998 10:50:00, this will return 650

/*CNVTLOOKAHEAD-CNVTLOOKBEHIND functions*/
,Hour_Ahead = format(cnvtlookahead("1,H", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Day_Ahead = format(cnvtlookahead("1,D", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Week_Ahead = format(cnvtlookahead("1,W", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Month_Ahead = format(cnvtlookahead("1,M", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Year_Ahead = format(cnvtlookahead("1,Y", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Hour_Behind = format(cnvtlookbehind("1,H", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Day_Behind = format(cnvtlookbehind("1,D", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Week_Behind = format(cnvtlookbehind("1,W", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Month_Behind = format(cnvtlookbehind("1,M", cnvtdatetime("02-DEC-2020 11:30")),";;q")
,Year_Behind = format(cnvtlookbehind("1,Y", cnvtdatetime("02-DEC-2020 11:30")),";;q")
from dummyt d1
with time = 10


/*
Length of Stay: (1bh_mpage_hap_org_v1.prg : encounter.reg_dt_tm)
  los = vc

    ,lenstay = if (datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,4) &lt; 60)
    concat(cnvtstring(datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,4)), "Minute(s)")
    elseif (datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,3) &lt; 24)
    concat(cnvtstring(datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,3)), "Hour(s)")
    elseif (datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,3) &gt; 24)
    concat(cnvtstring(datetimecmp(cnvtdatetime(curdate,0), cnvtdatetime(e.reg_dt_tm))), "Day(s)")
    endif

  pat-&gt;pt[pcnt].los = lenstay
*/

/*
;Length of Stay
select
e.encntr_id
,e.person_id
,e.reg_dt_tm";;"
,e.disch_dt_tm";;"
,lenstay = if (e.disch_dt_tm = NULL) ;If there is no discharge date time.
;Calculate from e.reg_dt_tm to current date time.
	if (datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,4) &lt; 60)
    concat(trim(cnvtstring(datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,4)),3), " Minute(s)")
    elseif (datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,3) &lt; 24)
    concat(trim(cnvtstring(datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,3)),3), " Hour(s)")
    elseif (datetimediff(cnvtdatetime(curdate,curtime), e.reg_dt_tm,3) &gt; 24)
    concat(trim(cnvtstring(datetimecmp(cnvtdatetime(curdate,0), cnvtdatetime(e.reg_dt_tm))),3), " Day(s)")
    endif
  else ;If there is a discharge date time. Calculate from e.reg_dt_tm to e.disch_dt_tm.
	if (datetimediff(cnvtdatetime(e.disch_dt_tm), e.reg_dt_tm,4) &lt; 60)
    concat(trim(cnvtstring(datetimediff(cnvtdatetime(e.disch_dt_tm), e.reg_dt_tm,4)),3), " Minute(s)")
    elseif (datetimediff(cnvtdatetime(e.disch_dt_tm), e.reg_dt_tm,3) &lt; 24)
    concat(trim(cnvtstring(datetimediff(cnvtdatetime(e.disch_dt_tm), e.reg_dt_tm,3)),3), " Hour(s)")
    elseif (datetimediff(cnvtdatetime(e.disch_dt_tm), e.reg_dt_tm,3) &gt; 24)
    concat(trim(cnvtstring(datetimecmp(cnvtdatetime(e.disch_dt_tm), cnvtdatetime(e.reg_dt_tm))),3), " Day(s)")
    endif
  endif
;,e.*
from encounter e where e.encntr_id = [+ENCNTR_ID+]
*/

;Clinical_event.result_val field containing long date:
;Join ce_date_result table on event_id.
select
  date_vc = ce.result_val
  , date_dq8 = cedr.result_dt_tm
  , date_dq8_formatted = format(cedr.result_dt_tm, "mm/dd/yyyy hh:mm:ss;;q")
  , date_dq8_formatted_tz = datetimezoneformat(cedr.result_dt_tm, cedr.result_tz, "MM/dd/yyyy HH:mm:ss ZZZ")
from
  clinical_event ce
  , ce_date_result cedr
plan ce where ce.event_id = THE_EVENT_ID
join cedr where cedr.event_id = ce.event_id
with nocounter, separator=" ", format

;Example Date format using piece and substring:
	ce.result_val = "0:2023021610150000:0.000000:54:0"

;Date format:
	ce.result_val = "0:2023021610150000:0.000000:54:0"

;CCL to format date as 0000-00-00 00:00:
		YEAR = SUBSTRING(1,4,PIECE(TRIM(ce.result_val,3),":",2,""));
		2DYR = SUBSTRING(3,2,PIECE(TRIM(ce.result_val,3),":",2,""));
		MONTH = SUBSTRING(5,2,PIECE(TRIM(ce.result_val,3),":",2,""));
		DAY = SUBSTRING(7,2,PIECE(TRIM(ce.result_val,3),":",2,""));
		HOUR = SUBSTRING(9,2,PIECE(TRIM(ce.result_val,3),":",2,""));
		MINUTE = SUBSTRING(11,2,PIECE(TRIM(ce.result_val,3),":",2,""));

		;Year-Month-Day:
			bhts_mp-&gt;pt[pt_cnt].lastcrisiseval_dt = concat(YEAR,"-",MONTH,"-",DAY," ",HOUR,":",DAY);
		;Month-Day-Year (4-Digit)
			;bhts_mp-&gt;pt[pt_cnt].lastcrisiseval_dt = concat(MONTH,"-",DAY,"-",YEAR," ",HOUR,":",DAY);
		;Month/Day/Year (2-Digit)
			;bhts_mp-&gt;pt[pt_cnt].lastcrisiseval_dt = concat(MONTH,"/",DAY,"/",2DYR," ",HOUR,":",DAY);

;The following example qualifies records that have been updated in the past 24 hours:
	WHERE P.UPDT_DT_TM BETWEEN CNVTDATETIME(CURDATE-1, CURTIME3) AND CNVTDATETIME(CURDATE , CURTIME3)
^
</Template><Template Name="mpt_ccl_dml" Description="CCL Data Manipulation Language">Oracle/Millennium Data Type Equivalents - https://community.cerner.com/t5/CCL-Discern-Explorer-Client-and/Millennium-s-convention-for-column-names/m-p/1512422/emcs_t/S2h8ZW1haWx8Ym9hcmRfc3Vic2NyaXB0aW9ufEtRQ1BDSzg2RDRNMjY1fDE1MTI0MjJ8U1VCU0NSSVBUSU9OU3xoSw
See note below about "Select Into" for creating tables and Oragen3.
+--------------------+------------------+---------------+
| class_name         | oracle_data_type | ccl_data_type |
+--------------------+------------------+---------------+
| ACCESSION          | VARCHAR2         | C             |
| ADDR               | VARCHAR2         | VC            |
| AMT                | FLOAT            | F8            |
| BARCODE            | VARCHAR2         | VC            |
| BIN                | RAW              | GC50          |
| BIT                | NUMBER           | I4            |
| BLOB               | BLOB             | ZVGC32000     |
| CD                 | NUMBER           | F8            |
| CKI                | VARCHAR2         | VC            |
| CLOB               | CLOB             | VC32000       |
| CNT                | NUMBER           | I4            |
| CODE               | VARCHAR2         | VC            |
| DAYS               | FLOAT            | F8            |
| DESC               | VARCHAR2         | VC            |
| DT_TM_ISO          | VARCHAR2         | VC            |
| DT_ISO             | VARCHAR2         | VC            |
| DT_NBR             | NUMBER           | I4            |
| DT_TM              | DATE             | DQ8           |
| DT_TXT             | VARCHAR2         | C             |
| ENUM               | NUMBER           |               |
| FLAG               | NUMBER           | I2            |
| GRP_VALUE          | NUMBER           | F8            |
| HASH               | NUMBER           | F8            |
| HRS                | FLOAT            | F8            |
| ID                 | NUMBER           | F8            |
| IDENT              |                  |               |
| IND                | NUMBER           | I2            |
| KEY                | VARCHAR2         | VC            |
| A_NLS              | VARCHAR2         | VC            |
| MASK               | VARCHAR2         | VC            |
| MEAN               | VARCHAR2         | VC            |
| MINS               | FLOAT            | F8            |
| MONTHS             | FLOAT            | F8            |
| MSECS              | FLOAT            | F8            |
| MTHS               | FLOAT            | F8            |
| NACS               | VARCHAR2         | VC            |
| NAME               | VARCHAR2         | VC            |
| NBR                | NUMBER           | I4            |
| NHS                | VARCHAR2         | VC            |
| PARENT_ENTITY_NAME | VARCHAR2         | C30           |
| PCT                | FLOAT            | F8            |
| QTY                | FLOAT            | F8            |
| SECS               | FLOAT            | F8            |
| SEQ                | NUMBER           |               |
| TM_NBR             | NUMBER           | I4            |
| TM_TXT             | VARCHAR2         | C             |
| TOT                | FLOAT            | F8            |
| TXT                | VARCHAR2         | VC            |
| TZ                 | NUMBER           | I4            |
| UID                | VARCHAR2         | VC            |
| UNIT               | VARCHAR2         | VC            |
| UOM                | VARCHAR2         | VC            |
| URI                | VARCHAR2         | VC            |
| URL                | VARCHAR2         | VC            |
| UUID               | VARCHAR2         | VC            |
| VALUE              | NUMBER           | F8            |
| VALUE_TXT          | VARCHAR2         | VC            |
| WEEKS              | FLOAT            | F8            |
| WKS                | FLOAT            | F8            |
| YEARS              | FLOAT            | F8            |
| YRS                | FLOAT            | F8            |
+--------------------+------------------+---------------+

ALTER TABLE:
 alter table custom.cust_hcc_documentation add assess_posted_ind integer;
 ALTER TABLE custom.cust_hcc_documentation MODIFY (condition VARCHAR2(355), diagnoses VARCHAR2(355));
 alter table cust_samt.cust_hcc_preferences modify (preferences_value varchar(355)) go;

CREATE TABLE:
Create tables from within CCL:
  drop program 1bh_mp_aos_cust_tables:dba go
  create program 1bh_mp_aos_cust_tables:dba

  if (checkdic("CUST_ALLOFUS_MEMBER", "T", 0) = 0)
    call echo("Creating CUST_ALLOFUS_MEMBER Table")
    select into table CUST_ALLOFUS_MEMBER
        ,member_id = type("F8")
        ,person_id = type("F8")
        ,encntr_id = type("F8")
        ,loc_facility_cd = type("F8")
        ,member_status_flag = type("I2")
        ,member_status = type("C60")
        ,active_ind = type("I2")
        ,create_dt_tm = type("DQ8")
        ,beg_effective_dt_tm = type("DQ8")
        ,end_effective_dt_tm = type("DQ8")
        ,updt_id = type("F8")
        ,updt_dt_tm = type("DQ8")
        ,updt_cnt   = type("I2")
    with organization="P",
    	indexunique(member_id),
    	index(person_id),
    	index(encntr_id),
    	index(loc_facility_cd),
      index(active_ind),
      index(end_effective_dt_tm, loc_facility_cd),
      index(member_status_flag, end_effective_dt_tm),
      index(person_id, end_effective_dt_tm),
      index(person_id, member_status_flag),
      owner="V500",
      synonym="CUST_ALLOFUS_MEMBER"
    execute oragen3 "CUST_ALLOFUS_MEMBER"
  else
    call echo("CUST_ALLOFUS_MEMBER Table already exists")
  endif


  /*****************************************************
  ;create the sequences for the tables
  *****************************************************/

  select into "NL:" from all_sequences where sequence_name="ALLOFUS_SEQ"
  if (curqual = 0)
      call echo("Creating Sequence ALLOFUS_SEQ")
      call parser("rdb CREATE SEQUENCE ALLOFUS_SEQ START WITH 1000")
  endif

  Commit
  end go

#####Create Table More:
  drop program 1bh_mpage_resrevcycle_gen:dba go
  create program 1bh_mpage_resrevcycle_gen:dba

  rdb
  create table cust_samt.cust_resrevencntr (
  	bh_mp_rrce_id number not null,
  	encntr_id number not null,
  	active_ind number DEFAULT 1 not null,
  	updt_dt_tm  DATE DEFAULT SYSDATE,
  	updt_id number DEFAULT 1,
  	bh_mp_rrc_tab_ind number not null,
  	beg_effective_dt_tm date default sysdate,
  	end_effective_dt_tm date default sysdate
  	constraint cust_pk_resrevencntr primary key(bh_mp_rrce_id)
  )
  end

  rdb CREATE SEQUENCE cust_samt.bh_mp_rrce_seq
  	NOCYCLE
  	NOORDER
  	CACHE 20
  	MAXVALUE 1000000000000000000000000000
  	MINVALUE 1
  	INCREMENT BY 1
  	START WITH 1
  	end

  rdb CREATE PUBLIC SYNONYM
  	bhs_mp_rrce_seq
  FOR cust_samt.bh_mp_rrce_seq
  end

  ;    Your Code Goes Here
  rdb
  create table cust_samt.cust_resrevcycle
  (
  	bh_mp_rrc_id number not null,
  	order_id number not null,
  	active_ind number DEFAULT 1 not null,
  	updt_dt_tm  DATE DEFAULT SYSDATE,
  	updt_id number DEFAULT 1,
  	bh_mp_rrc_value_ind number not null,
  	beg_effective_dt_tm date default sysdate,
  	end_effective_dt_tm date default sysdate
  	constraint cust_pk_resrevcycle primary key(bh_mp_rrc_id)
  )
  end

  rdb CREATE SEQUENCE cust_samt.bhs_mp_rrc_seq
  NOCYCLE
  NOORDER
  CACHE 20
  MAXVALUE 1000000000000000000000000000
  MINVALUE 1
  INCREMENT BY 1
  START WITH 1
  end

  rdb CREATE PUBLIC SYNONYM bhs_mp_rrc_seq
  FOR cust_samt.bh_mp_data_seq
  end
  declare bhmp_next_id = f8 ;
  go

  select into "nl:"
  bhmp_next_id2 = seq(BHS_MP_RRC_SEQ,nextval)
  from dual
  detail bhmp_next_id = bhmp_next_id2
  with nocounter ;
  go
  call echo(bhmp_next_id) ;
  go

  end
  go

DELETE:
	delete from cust_samt.cust_prsnlauthpos where
	usr_person_id = 123456.00
	go
	commit go

  SR: 417886446 Query ran in PROD for Cory Untalan.
  delete from name_value_prefs nv
  where nv.parent_entity_id = 6832609723.00
  and nv.parent_entity_name = "APP_PREFS"
  and cnvtupper(nv.pvc_name) in (
  "MP_AMBULATORY_ORG_RES_FAVS",
  "MP_AMBULATORY_ORG_AMB_ORG_OS",
  "MP_AMBULATORY_ORG_AMB_ORG_POP",
  "MP_AMBULATORY_ORG_AMB_ORG_PT",
  "MP_AMBULATORY_ORG_USERPREFMENU",
  "LONG_PREF_MAPPING",
  "MP_AMBULATORY_ORG_RES_FAVS2",
  "MP_AMBULATORY_ORG",
  "MP_AMBULATORY_ORG_CALENDAR_TAB")
  GO
  commit go

  SR:421421942 For Kavitha Deme:
  delete from br_datamart_value where  BR_DATAMART_FILTER_ID = 5991950.0 go
  commit go

If you need to delete files from the backend, you can use the remove() function.
  Open up a blank CCL window and type:
  &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; For HTML files:
  		SET STAT = REMOVE("cust_html:1bh_mpage_xxxx.html") GO
  &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; For CCL files:
  		SET STAT = REMOVE("cust_script:1bh_mpage_xxxx.prg") GO
  &#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; For CCLUSERDIR files:
  		SET STAT = REMOVE("ccluserdir:1bh_mpage_xxxx.prg") GO
  &#xA0;
  Do an &#x201C;Include/Compile&#x201D; without saving. The file will be deleted from the backend.

DESCRIBE TABLE:
 desc custom.cust_hcc_documentation

DROP PROGRAM/USER: ;Only a group0 can create or modify a group0.
Need to run on each node.
  DROP CCLUSER CERNER_USERNAME go
  commit go
  CREATE CCLUSER CERNER_USERNAME TO DBA go
  commit go

Check for DBA users:
  ;Run on each node:
  select *
  from DUAF
  where
  user_name in ("RLHOLLAND","PRHOLLAND")
  go

  ;Works on node 1:
  CCLUAF go

  drop program 1_utd_init go
  commit go

To see what group access every user has:
	https://wiki.ucern.com/display/public/1101discernHP/CCLUAF+using+Discern+Explorer

To create a Group 0 user if needed:
	https://wiki.ucern.com/display/public/1101discernHP/Discern+Explorer+Security+using+Discern+Explorer

To add a new Discern Explorer user to a Discern Explorer group:
	https://wiki.ucern.com/display/public/1101discernHP/CREATE+CCLUSER+using+Discern+Explorer

DUP WARNING: Usually when group1 user creates a program with the same name as a group0.
  drop program 1_utd_init:group1 go
  commit go

  drop program 1_gic_hcc_component_check:group1 go
  commit go

INSERT:
  	insert into custom.cust_prsnlauthpos
  	(person_id, position_cd)
  	values (555555, 36342858)
  	go
  	commit go

  Example of CCL that inserts data into table from DVDev.
  	1_gic_pref_upload.prg

  Insert using execute from DVDev:
  free define oraclesystem go ;
  define oraclesystem 'custom/perf0rmance@prod2' go ;@prod2 ;
  execute 1_gic_post_hcc_doc MINE,Documented in Encounter,Psychiatric Condition,^,102406222,button,39596649 go

Oragen3:
Run all prod app nodes:
 oragen3 'custom.cust_hcc_documentation' go

SELECT INTO:
 select into table_name - https://wiki.cerner.com/display/public/1101discernHP/SELECT%20INTO%20TABLE%20Table_Name%20Using%20Discern%20Explorer?ssoLogin=false

  The SELECT INTO TABLE Table_Name command allows you to specify the owner
  and tablespace using the OWNER = owner_name, and TABLSSPACE = tablespace_name control
  options in the With clause. It also supports using RDBMSMISC = rdb_create_table_clause
  to create a clause in the RDB create table command that is not provided by an existing control
  option. So I prefer to use the Select into Table Table_Name command along with the TYPE()
  function to create the custom table and specify the data types of the fields. My opinion is that
  better because it eliminates relying on using the field names that Oragen3 depends on.

  Bob Ross | Director Discern Operations

Select into filename:
  select into value("ccluserdir:test.txt")
  from nomenclature
  where nomenclature_id = 1
  detail
  "Test" go

  select into value("ccluserdir:prhollandtest.txt")
  from person p
  where p.person_id = 32913554.00
  detail
  "Test" go

  select into value("ccluserdir:dbargerappendate.txt")
  from nomenclature
  where source_string = "*&lt;?&gt;"
  with separator="~" go ;Tilde separated columns

UPDATE:
	update into custom.cust_prsnlauthpos
	set position_cd = YYY where person_id = 555555 AND position_cd = XXX
	go
	commit go

  Update statement I ran for Dewayne McDaniels and Nick Ernzen
  update into clinical_event
  	set result_val = "39W 4D",
  	event_tag = "39W 4D",
  	updt_id = reqinfo-&gt;updt_id,
  	updt_cnt = updt_cnt +1,
  	updt_task = 0,
  	updt_applctx = 0.00,
  	updt_dt_tm = cnvtdatetime(curdate,curtime3)
  	where event_id = 23794802910.00 go
  commit go
^
</Template><Template Name="mpt_CCL_joke" Description="CCL Joke">select
CAUSE=if (d.rest != " ") replace(d.rest,d.rest,"IT Patient Care Team",0) endif
from dummyt d

select
PERSON=if (d.rest != " ") replace(d.rest,d.rest,"Joebob Jones",0) endif
from dummyt d


select the.cause from problems the where the.issue = "CURRENT" and the.status = "SERIOUS"
select the.person from blame the where  the.issue="CURRENT" and the.status = "BROKEN"
^
</Template><Template Name="mpt_ccl_notrim" Description="Using notrim to retain a space.">; ----------------------------------------------------------------------------
; Script Author: Bob Ross
; Script Name: 1bh_mpage_notrim_example.prg
; Creation Date: Tue Sep 20 2022 12:09:41 GMT-0700 (US Mountain Standard Time)
; Last Modified:
; Copyright (c)2022
; SNOW#:
; Purpose: CCL NOTRIM() Example
; Source: https://community.cerner.com/t5/CCL-Discern-Explorer-Client-and-Cerner-Collaboration/CONCAT-is-not-including-trailing-spaces/m-p/1634779
; ----------------------------------------------------------------------------

record rec(
	1 text = vc
	) with protect go

set rec-&gt;text = "12345 " go
call echo(concat(rec-&gt;text,"6")) go
;123456    ;&lt;&lt;&lt; notice the space that was after the 5 was not retained
set rec-&gt;text = notrim("12345 ") go  ;;;using notrim to retain the space
call echo(concat(rec-&gt;text,"6")) go
;12345 6  ;&lt;&lt;&lt; notice the space is retained
^
</Template><Template Name="mpt_ccl_remove" Description="Delete/Remove CCL from backend Linux.">If you need to delete files from the backend, you can use the remove() function.
  Open up a blank CCL window and type:
  For HTML files:
  	SET STAT = REMOVE("cust_html:1bh_mpage_xxxx.html") GO
  For CCL files:
  	SET STAT = REMOVE("cust_script:1bh_mpage_xxxx.prg") GO
  For CCLUSERDIR files:
  	SET STAT = REMOVE("ccluserdir:1bh_mpage_xxxx.prg") GO
  &#xA0;
  Do an "Include/Compile" without saving. The file will be deleted from the backend.
^</Template><Template Name="mpt_ccl_seq" Description="SEQ Example">https://wiki.cerner.com/display/public/1101discernHP/The%20SEQ%20Pseudo%20Column%20Using%20Discern%20Explorer?ssoLogin=false
^</Template><Template Name="mpt_ccl_snippets" Description="CCL Snippets">Global Display of XXXX_CD display value:
	with uar_get_code(d)

Global Format Date to show time:
	with format(date, ";;q")

	with uar_code(d), format(date,";;q")

UAR_GET_CODE_BY(alias.column_name)
UAR_GET_CODE_BY_CKI("CKI.CODEVALUE!1005613")
UAR_GET_CODE_DESCRIPTION(alias.column_name)
UAR_GET_CODE_DISPLAY(alias.column_name)
UAR_GET_CODE_MEANING(alias.column_name)
UAR_GET_DEFINITION(alias.column_name)
UAR_GET_DISPLAYKEY(alias.column_name)
UAR_GET_MEANING_BY_CODESET(alias.column_name)

Example:
	display_key=UAR_GET_DISPLAYKEY(ce.event_cd)

Export data with custom delimiter between columns:
This works with a program, not AdHoc.
	WITH 	MAXREC=100, format, PCFORMAT("",#,1,1), format=stream

If you want to use a separator with an AdHoc query, you will have to run the query from the backend.
	with separator="#"

Translate:
	https://wiki.cerner.com/display/public/1101discernHP/TRANSLATE+Using+Discern+Explorer
	translate MP_GET_CARE_TEAM_ASSIGN with query go

Blob data that is compressed:
	1bh_mpage_getblob
	uar_ocf_uncompress
^</Template><Template Name="mpt_CheckCustomTables" Description="Check custom tables.">
select * from cust_samt.bhs_mp_data_seq
select * from cust_samt.cust_hcc_documentation with maxrec = 100;
select * from cust_samt.cust_hcc_preferences with maxrec = 100;
select * from cust_samt.cust_mig_meds with maxrec = 100;
select * from cust_samt.cust_mpage_utilization with maxrec = 100;
select * from cust_samt.cust_mp_pref with maxrec = 100;
select * from cust_samt.cust_prsnlauthpos with maxrec = 100;

select * from dba_objects where object_name = "BHS_MP_DATA_SEQ" go
select * from dba_sequences where sequence_name = 'BHS_MP_DATA_SEQ' go;
select * from dba_sequences where sequence_owner = 'CUST_SAMT' go;

;cust_samt.cust_hcc_documentation table.
declare mp_next_id = f8
go
  select into "nl:"
    seq_id = seq(cust_hcc_documentation_seq,nextval)
  from dual
  detail
    mp_next_id = seq_id
  with nocounter
go
call echo(mp_next_id)
go

;cust_samt.cust_prsnlauthpos table
declare bhmp_next_id = f8
go
select into "nl:"
bhmp_next_id2 = seq(BHS_MP_DATA_SEQ,nextval)
from dual
detail
bhmp_next_id = bhmp_next_id2
with nocounter
go
call echo(bhmp_next_id)
go

create table cust_samt.cust_prsnlauthpos
(
	bh_mp_pref_id number not null,
	usr_person_id number not null,
	position_cd number not null,
	active_ind number DEFAULT 1 not null,
	updt_applctx  number DEFAULT 0,
	updt_cnt number DEFAULT 0,
	updt_dt_tm  DATE DEFAULT SYSDATE,
	updt_id number DEFAULT 1,
	updt_task number DEFAULT 99999,
	bh_mp_pref_id number not null,
	beg_effective_dt_tm date default sysdate,
	end_effective_dt_tm date default sysdate
	constraint cust_pk_prsnlauthpos primary key(bh_mp_pref_id)
);

;Turn off HCC Prompt:
update into cust_samt.cust_hcc_preferences
	set preference_value = "0"; Turn off prompt
	where preference_id = 67.00
	go
commit go

Notes from Calvin Boswell (Cerner) 816-201-1162
SQL+ - Backend command prompt.
select * from dba_users go; Shows the table users. Should see the CUST_SAMT user.
select * from dba_objects where owner = "CUST_SAMT" go; Shows all of the tables owned by CUST_SAMT.
select * from v$database go; Shows database name/id, read/write status.
select * from v$instance go; Shows instance name, host name, version, startup time, status.
select * from dba_tables where table_name = "CUST*" go; DM = Data Management
select * from dba_tab_privs where owner = 'CUST_SAMT'; Shows select, update, insert, and delete privileges.
select last_analyzed";;", * from dba_tables where table_name = "CUST*" go
reset; if you make a mistake while typing on the backend.
;The following method does not understand "=" so you have to use "like" and "%" for the wildcard.
rdb
	select * from dba_tables where table_name like "CUST%" go; Shows the same information as the select with asterisk.


ORAGEN3 - SCHEMA is stored in the CCL dic.dat. Refresh (CCLDIR1 and CCLDIR2 directories), There is a third logical CCLDIR that controls which CCLDIR1 or CCLDIR2 that is being used.
When the server starts up it uses CCLDIR
Users CCLDIRACCESS - Shows the number at the beginning, has Read or Write display, and numbers at the end which shows how many times the CCLDIR has been toggled (failover).

From: noreply@cerner.com &lt;noreply@cerner.com&gt;
Sent: Thursday, May 27, 2021 7:31 AM
To: Holland, Robert L &lt;Robert.Holland@bannerhealth.com&gt;
Cc: cernersupport@cerner.com
Subject: [EXTERNAL] Ticket 437197895 : Status has been updated to resolved

The following incident or request has been closed by the assigned IT support team:

Ticket:    437197895
Assigned To:    Michael Lang
Summary:    %CCL-E-284-VCCL_RUN_PROGRAM(0,0,74)210520:1459{}[ORA-00942]ORA-00942: table or view does not exist..
Resolution:    Imported SAMT_CUST schema from P1805 and ran oragen3 to update CCL. Synonyms, sequences, and tables should now exist in M1805.

Please do not reply to this email. This email account is not monitored.
-----Original Message-----
From: Cerner Support &lt;cernersupport@cerner.com&gt;
Sent: Tuesday, January 24, 2023 9:55 AM
To: Holland, Robert L &lt;Robert.Holland@bannerhealth.com&gt;; Xie, Mike &lt;Mike.Xie@bannerhealth.com&gt;
Subject: 447819721 Service Record Update - Client Reference #

Hello Robert,

The sequence "BHS_MP_DATA_SEQ" is a custom sequence. In TB1805, the sequence is owned by CUST_SAMT and was created on 01/18/23. In P1805, the sequence is also owned by CUST_SAMT and was created on 11/29/18.

Since the sequence owner is not V500, any replicate/refresh process will not copy the sequence from the SOURCE environment.

The difference between P1805 and TB1805 is that P1805 has a public synonym that references the custom synonym. This synonym allows the V500 user access the sequence owned by CUST_SAMT.

The TB1805 database does not have that public synonym and V500 user has no access to the synonym.

ccl&gt;
select * from dba_objects where object_name = "BHS_MP_DATA_SEQ" go

Give me a call at 816-201-1162 if there are questions.

Thank you,
Calvin Boswell | Cerner Corporation | 19133043436 | calvin.boswell@cerner.com
^
</Template><Template Name="mpt_CheckSequence" Description="Check table sequence.">
;Check if custom tables exist:
  select * from cust_samt.cust_mig_meds with maxrec = 100;
  select * from cust_samt.cust_mpage_utilization with maxrec = 100;
  select * from cust_samt.cust_mp_pref with maxrec = 100;
  select * from cust_samt.cust_prsnlauthpos with maxrec = 100;

  select * from dba_objects where object_name = "BHS_MP_DATA_SEQ" go
  select * from dba_sequences where sequence_name = 'BHS_MP_DATA_SEQ' go;
  select * from dba_sequences where sequence_owner = 'CUST_SAMT' go;
  select * from dba_tables where owner="CUST_SAMT" go; Displays tables owned by CUST_SAMT.
  select * from dba_synonyms where table_owner = "CUST_SAMT" order by owner; Displays synonyms owned by CUST_SAMT.

;cust_samt.cust_prsnlauthpos table
  declare bhmp_next_id = f8
  go
  select into "nl:"
  bhmp_next_id2 = seq(BHS_MP_DATA_SEQ,nextval)
  from dual
  detail
  bhmp_next_id = bhmp_next_id2
  with nocounter
  go
  call echo(bhmp_next_id)
  go

;Create table cust_samt.cust_prsnlauthpos:
create table cust_samt.cust_prsnlauthpos
(
	bh_mp_pref_id number not null,
	usr_person_id number not null,
	position_cd number not null,
	active_ind number DEFAULT 1 not null,
	updt_applctx  number DEFAULT 0,
	updt_cnt number DEFAULT 0,
	updt_dt_tm  DATE DEFAULT SYSDATE,
	updt_id number DEFAULT 1,
	updt_task number DEFAULT 99999,
	bh_mp_pref_id number not null,
	beg_effective_dt_tm date default sysdate,
	end_effective_dt_tm date default sysdate
	constraint cust_pk_prsnlauthpos primary key(bh_mp_pref_id)
);

Notes from Calvin Boswell (Cerner) 816-201-1162
SQL+ - Backend command prompt.
  select * from dba_users go; Shows the table users. Should see the CUST_SAMT user.
  select * from dba_objects where owner = "CUST_SAMT" go; Shows all of the tables owned by CUST_SAMT.
  select * from v$database go; Shows database name/id, read/write status.
  select * from v$instance go; Shows instance name, host name, version, startup time, status.
  select * from dba_tables where table_name = "CUST*" go; DM = Data Management
  select * from dba_tab_privs where owner = 'CUST_SAMT'; Shows select, update, insert, and delete privileges.
  select last_analyzed";;", * from dba_tables where table_name = "CUST*" go

If you make a mistake while typing on the backend type:
	reset go;

;The following method does not understand "=" so you have to use "like" and "%" for the wildcard.
rdb
	select * from dba_tables where table_name like "CUST%" go; Shows the same information as the select with asterisk.

ORAGEN3 - SCHEMA is stored in the CCL dic.dat. Refresh (CCLDIR1 and CCLDIR2 directories), There is a third logical CCLDIR that controls which CCLDIR1 or CCLDIR2 that is being used.
When the server starts up it uses CCLDIR
Users CCLDIRACCESS - Shows the number at the beginning, has Read or Write display, and numbers at the end which shows how many times the CCLDIR has been toggled (failover).

;Create Table cust_samt.cust_resrevencntr:
rdb
create table cust_samt.cust_resrevencntr (
	bh_mp_rrce_id number not null,
	encntr_id number not null,
	active_ind number DEFAULT 1 not null,
	updt_dt_tm  DATE DEFAULT SYSDATE,
	updt_id number DEFAULT 1,
	bh_mp_rrc_tab_ind number not null,
	beg_effective_dt_tm date default sysdate,
	end_effective_dt_tm date default sysdate
	constraint cust_pk_resrevencntr primary key(bh_mp_rrce_id)
)
end

;Create sequence:
  rdb CREATE SEQUENCE cust_samt.bhs_mp_rrc_seq NOCYCLE NOORDER CACHE 20 MAXVALUE 1000000000000000000000000000 MINVALUE 1 INCREMENT BY 1 START WITH 1 end
  rdb CREATE PUBLIC SYNONYM bhs_mp_rrc_seq FOR cust_samt.bh_mp_data_seq end declare bhmp_next_id = f8 ;go

;Check if sequence increments:
  select into "nl:"
  bhmp_next_id2 = seq(BHS_MP_RRC_SEQ,nextval)
  from dual
  detail
  bhmp_next_id = bhmp_next_id2
  with nocounter ;go &lt;-- Does this need to be commented?
  call echo(bhmp_next_id) ;
  go

;cust_samt.cust_resrevcycle:
  declare bhmp_next_id = f8
  go
  select into "nl:"
  bhmp_next_id2 = seq(BHS_MP_RRC_SEQ,nextval)
  from dual
  detail
  bhmp_next_id = bhmp_next_id2
  with nocounter
  go
  call echo(bhmp_next_id)
  go
  -- cust_samt.cust_pk_resrevcycle

I found this link on UCern which suggests a few things to try (Cycling server 58 and/or creating public synonym): https://connect.ucern.com/thread/134132

;Create the Sequence: If the sequence is missing, you will see (%CCL-E-288-CCL) errors.
	CREATE SEQUENCE cust_samt.bhs_mp_data_seq NOCYCLE NOORDER CACHE 20 MAXVALUE 1000000000000000000000000000 MINVALUE 1 INCREMENT BY 1 START WITH 1;

;Create Public Synonym: If the public synonym is missing, the sequence will not increment (you will see 			sequence does not exist messages from the backend CCL (%CCL-E-284-CCL)):
	CREATE PUBLIC SYNONYM bhs_mp_data_seq FOR cust_samt.bh_mp_data_seq;

;Enable front end applications (DVDev) to access the table.
	oragen3 cust_samt.cust_prsnlauthpos go

From: noreply@cerner.com &lt;noreply@cerner.com&gt;
Sent: Thursday, May 27, 2021 7:31 AM
To: Holland, Robert L &lt;Robert.Holland@bannerhealth.com&gt;
Cc: cernersupport@cerner.com
Subject: [EXTERNAL] Ticket 437197895 : Status has been updated to resolved

The following incident or request has been closed by the assigned IT support team:

Ticket:    437197895
Assigned To:    Michael Lang
Summary:    %CCL-E-284-VCCL_RUN_PROGRAM(0,0,74)210520:1459{}[ORA-00942]ORA-00942: table or view does not exist..
Resolution:    Imported SAMT_CUST schema from P1805 and ran oragen3 to update CCL. Synonyms, sequences, and tables should now exist in M1805.

Please do not reply to this email. This email account is not monitored.
-----Original Message-----
From: Cerner Support &lt;cernersupport@cerner.com&gt;
Sent: Tuesday, January 24, 2023 9:55 AM
To: Holland, Robert L &lt;Robert.Holland@bannerhealth.com&gt;; Xie, Mike &lt;Mike.Xie@bannerhealth.com&gt;
Subject: 447819721 Service Record Update - Client Reference #

Hello Robert,

The sequence "BHS_MP_DATA_SEQ" is a custom sequence. In TB1805, the sequence is owned by CUST_SAMT and was created on 01/18/23. In P1805, the sequence is also owned by CUST_SAMT and was created on 11/29/18.

Since the sequence owner is not V500, any replicate/refresh process will not copy the sequence from the SOURCE environment.

The difference between P1805 and TB1805 is that P1805 has a public synonym that references the custom synonym. This synonym allows the V500 user access the sequence owned by CUST_SAMT.

The TB1805 database does not have that public synonym and V500 user has no access to the synonym.

ccl&gt;
select * from dba_objects where object_name = "BHS_MP_DATA_SEQ" go

Give me a call at 816-201-1162 if there are questions.

Thank you,
Calvin Boswell | Cerner Corporation | 19133043436 | calvin.boswell@cerner.com

;Create custom table:
  select into table CUST_BGR_TABLE
  name = type("VC")
  ,id = type("f8")
  ,dt = type("dq8")
  ,deptno = type("i4")
  ,dept = type("c10")
  from
  dummyt   d1
  with indexunique(id),
  index(name,dt)
  ,organization = p
  ,constraint(id,"not null")
  ,constraint(deptno," not null check(deptno between 1 and 10 )")
  ,constraint(dept,"check(dept in('d1', 'd2', 'd3'))")
  ,owner = "cust_samt"
  , synonym = "CUST_BGR_TABLE"
  go

;Check if table is valid:
	select * from cust_bgr_table go

;Insert data into the custom table;
  insert into cust_samt.cust_bgr_table
  (id, name, dt, deptno, dept)
  values
  (1,"Robert Holland",CNVTDATETIME(CURDATE, CURTIME3),1,"d1")
  go
  commit
  go

;Show some data from the custom table:
	select * from cust_samt.cust_bgr_table with format(date,";;q") go


;Create sequence:
  rdb CREATE SEQUENCE cust_samt.bhs_mp_rrc_seq NOCYCLE NOORDER CACHE 20 MAXVALUE 1000000000000000000000000000 MINVALUE 1 INCREMENT BY 1 START WITH 1 end
  rdb CREATE PUBLIC SYNONYM bhs_mp_rrc_seq FOR cust_samt.bh_mp_data_seq end declare bhmp_next_id = f8 ;go

;Create the Sequence: If the sequence is missing, you will see (%CCL-E-288-CCL) errors.
	CREATE SEQUENCE cust_samt.bhs_mp_data_seq NOCYCLE NOORDER CACHE 20 MAXVALUE 1000000000000000000000000000 MINVALUE 1 INCREMENT BY 1 START WITH 1;

;Create Public Synonym: If the public synonym is missing, the sequence will not increment (you will see sequence does not exist messages from the backend CCL (%CCL-E-284-CCL)):
	CREATE PUBLIC SYNONYM bhs_mp_data_seq FOR cust_samt.bh_mp_data_seq;

declare bhmp_next_id = f8
  go
  select into "nl:"
  bhmp_next_id2 = seq(BHS_MP_DATA_SEQ,nextval)
  from dual
  detail
  bhmp_next_id = bhmp_next_id2
  with nocounter
  go
  call echo(bhmp_next_id)
  go


select * from dba_objects where object_name = "BHS_MP_DATA_SEQ" go
select * from dba_objects where object_name = "BHS_MP_DATA_SEQ" with separator = "#" go
select domain=curdomain, owner, object_type, object_name, created, last_ddl_time, timestamp, status from dba_objects where object_name = "BHS_MP_DATA_SEQ" go
select * from dba_objects where object_name not = "BHS_MP_DATA_SEQ" go

^</Template><Template Name="mpt_combine" Description="Check if a Combine was done.">;Check if a combine was done.
select
p.active_ind
, p_active_status_disp = uar_get_code_display(p.active_status_cd)
, p.active_status_dt_tm
, p.active_status_prsnl_id
, p.application_flag
, p.cmb_dt_tm
, p.cmb_updt_id
, p_combine_action_disp = uar_get_code_display(p.combine_action_cd)
, p.from_person_id
, p.person_combine_id
, p.prev_active_ind
, p_prev_active_status_disp = uar_get_code_display(p.prev_active_status_cd)
, p.to_person_id
, p.transaction_type
, p.ucb_dt_tm
, p.updt_dt_tm
, p.updt_id
from
person_combine p
where p.to_person_id = 1234;
with nocounter, separator=" ", format
^</Template><Template Name="mpt_cpoe_list" Description="CPOE">;From Vincent McLang select 	l_facility_accn_prefix_disp = uar_get_code_display(l.facility_accn_prefix_cd) 	, l_location_disp = uar_get_code_display(l.location_cd) 	, pc.description 	, pc.display_description 	, pc.active_ind from 	pw_cat_flex p 	, location l 	, pathway_catalog pc plan p join l where l.location_cd = p.parent_entity_id join pc where pc.pathway_catalog_id = p.pathway_catalog_id and pc.active_ind = 1.00 and pc.display_description != "" and not pc.description in ("*RSCH*", "*ONC*")  order by l_location_disp , pc.description  with nocounter, separator=" ", format, time = 30; ^</Template><Template Name="mpt_createTablefromCCL" Description="Create table from CCL - Kasie Sly">;Create table using CCL program:
drop program 1bh_mp_aos_cust_tables:dba go
create program 1bh_mp_aos_cust_tables:dba

if (checkdic("CUST_ALLOFUS_MEMBER", "T", 0) = 0)
  call echo("Creating CUST_ALLOFUS_MEMBER Table")
  select into table CUST_ALLOFUS_MEMBER
      ,member_id = type("F8")
      ,person_id = type("F8")
      ,encntr_id = type("F8")
      ,loc_facility_cd = type("F8")
      ,member_status_flag = type("I2")
      ,member_status = type("C60")
      ,active_ind = type("I2")
      ,create_dt_tm = type("DQ8")
      ,beg_effective_dt_tm = type("DQ8")
      ,end_effective_dt_tm = type("DQ8")
      ,updt_id = type("F8")
      ,updt_dt_tm = type("DQ8")
      ,updt_cnt   = type("I2")
  with organization="P", indexunique(member_id), index(person_id),index(encntr_id),index(loc_facility_cd),
    index(active_ind),index(end_effective_dt_tm, loc_facility_cd),index(member_status_flag, end_effective_dt_tm),
    index(person_id, end_effective_dt_tm), index(person_id, member_status_flag),owner="V500",synonym="CUST_ALLOFUS_MEMBER"
  execute oragen3 "CUST_ALLOFUS_MEMBER"
else
  call echo("CUST_ALLOFUS_MEMBER Table already exists")
endif


/*****************************************************
;create the sequences for the tables
*****************************************************/

select into "NL:" from all_sequences where sequence_name="ALLOFUS_SEQ"
if (curqual = 0)
    call echo("Creating Sequence ALLOFUS_SEQ")
    call parser("rdb CREATE SEQUENCE ALLOFUS_SEQ START WITH 1000")
endif
^</Template><Template Name="mpt_cycle_servers" Description="Cycle Servers">Olympus Server Cycle Schedule Map:
	https://bannerhealth.sharepoint.com/:x:/r/teams/GRP_ITClinApps-ProductOwners/Shared Documents/Environments/Olympus Server Cycle Schedule Map.xlsx?d=w3012a20abb6d44be9b55d6329a089f21&amp;csf=1&amp;web=1&amp;e=ce6XJa

Send SNOW Cycle Request:
	https://svcnowprod.service-now.com/sp?id=sc_cat_item&amp;sys_id=0b92f2aadbfec9908dce4a2813961911

MPages 79
Bedrock 535
User Defined Tokens (UDT) 3003
548 (Suggested by Cerner for Canned Worklist Component update SR:433320166)

Type: scpview at the commandline.
scpview Canned Worklist Component:
	cycle -entry 548
	cycle -query

scpview mPages:
	cycle -entry 505
	cycle -entry 362
	cycle -entry 386
	cycle -entry 178
	cycle -entry 535
	cycle -entry 79
	cycle -query

scpview Rules:
	cycle -entry 150
	cycle -entry 151
	cycle -entry 152
	cycle -entry 153
	cycle -entry 175
	cycle -query

scpview User Defined Tokens:
	cycle -entry 3003
	cycle -query
^</Template><Template Name="mpt_DeclareVariables" Description="Generate delcared variables from code values">;From: Bannerman,Pat &lt;Pat.Bannerman@Cerner.com&gt;
;Sent: Friday, June 28, 2019 7:06 AM
;To: Soliman, Raphael &lt;Rouphail.Soliman@bannerhealth.com&gt;; Aluko, Adebiyi &lt;Adebiyi.Aluko@bannerhealth.com&gt;; Deme, Kavitha &lt;Kavitha.Deme@bannerhealth.com&gt;; Holland, Robert L &lt;Robert.Holland@bannerhealth.com&gt;; Untalan, Cory A &lt;Cory.Untalan@bannerhealth.com&gt;; Xie, Mike &lt;michael.xie@bannerhealth.com&gt;
;Subject: [EXTERNAL] RE: sql to capture prefmaint
;
;Here's another one for you
select
DECLARE_LIST = build2("declare "
                ,trim(cv.display_key)
                ,"_CD = f8 with protect, constant(UAR_GET_CODE_BY(",char(34),"DISPLAYKEY",char(34),","
,trim(CNVTSTRING(cv.code_set)),",",char(34),trim(cv.display_key),char(34),"))"
)

from code_value cv
where cv.code_value in (
3139256.00
,3074207.00
,1675021548.00
,549276179.00
,1049068668.00
,1049069275.00
,6943362.00
,639136995.00
,553088905.00
,322114254.00
,3075430.00
)
order by cv.display_key

;Will give you
declare DISCHARGETO_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "DISCHARGETO"))
declare TRANSFERTO_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "TRANSFERTO"))
declare ADMITTOINPATIENT_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "ADMITTOINPATIENT"))
declare PATIENTPLACEMENTCOMMUNICATION_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "PATIENTPLACEMENTCOMMUNICATION"))
declare REGISTRATIONCORRECTIONCOMMUNICATION_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "REGISTRATIONCORRECTIONCOMMUNICATION"))
declare EDPOTENTIALADMITOROBSERVATIONCOMMUN_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "EDPOTENTIALADMITOROBSERVATIONCOMMUN"))
declare PLACEINOBSERVATION_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "PLACEINOBSERVATION"))
declare PLACEINEXTENDEDRECOVERY_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "PLACEINEXTENDEDRECOVERY"))
declare EDTRANSITIONTOOB_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "EDTRANSITIONTOOB"))
declare EDTRANSITIONTOOROUTPATIENT_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "EDTRANSITIONTOOROUTPATIENT"))
declare EDHIGHPRIORITYCRITICALCAREPATIENT_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",200, "EDHIGHPRIORITYCRITICALCAREPATIENT"))

;It is recommended to declare variables for codes which are used more than once, as it is more efficient.  In addition, this will handle multiple environment in the (rare) case that the code_value values are different.

;Pat
^</Template><Template Name="mpt_deleteAOPreferences" Description="Delete Ambulatory Organizer Preferences">;SR: 431309485; INC2109675
;Ambulatory Organizer ERROR: "The page encountered an unknown error. Try refreshing the page. If the problem persists please contact a system administrator".

;Find the parent_entity_id for the customer person_id or username:
select n.parent_entity_id, a.*, n.*
 	from app_prefs a, name_value_prefs n
 	plan a where a.prsnl_id = [+PRSNL_ID+]
 	;plan a where a.prsnl_id = (select x.person_id from prsnl x where x.username = cnvtupper("[+THE_USERNAME+]"))
 		and a.application_number = 600005
 	join n where n.parent_entity_id = a.app_prefs_id
 		and n.parent_entity_name = "APP_PREFS"
 		and cnvtupper(n.pvc_name) IN(
		"MP_AMBULATORY_ORG_RES_FAVS",
		"MP_AMBULATORY_ORG_AMB_ORG_OS",
 		"MP_AMBULATORY_ORG_AMB_ORG_POP",
		"MP_AMBULATORY_ORG_AMB_ORG_PT",
		"MP_AMBULATORY_ORG_USERPREFMENU",
 		"LONG_PREF_MAPPING",
		"MP_AMBULATORY_ORG_CALENDAR_TAB",
		"MP_AMBULATORY_ORG_RES_FAVS2")
	order by n.pvc_name, n.sequence

;Display the preferences that will be deleted:
select * from name_value_prefs nv where
nv.parent_entity_id = [+PARENT_ENTITY_ID+]
and nv.parent_entity_name = "APP_PREFS"
and cnvtupper(nv.pvc_name) IN(
		"MP_AMBULATORY_ORG_RES_FAVS",
		"MP_AMBULATORY_ORG_AMB_ORG_OS",
 		"MP_AMBULATORY_ORG_AMB_ORG_POP",
		"MP_AMBULATORY_ORG_AMB_ORG_PT",
		"MP_AMBULATORY_ORG_USERPREFMENU",
 		"LONG_PREF_MAPPING",
		"MP_AMBULATORY_ORG_CALENDAR_TAB",
		"MP_AMBULATORY_ORG_RES_FAVS2")
go commit go

;Delete the preferences:
delete from name_value_prefs nv where
nv.parent_entity_id = [+PARENT_ENTITY_ID+]
and nv.parent_entity_name = "APP_PREFS"
and cnvtupper(nv.pvc_name) IN(
		"MP_AMBULATORY_ORG_RES_FAVS",
		"MP_AMBULATORY_ORG_AMB_ORG_OS",
 		"MP_AMBULATORY_ORG_AMB_ORG_POP",
		"MP_AMBULATORY_ORG_AMB_ORG_PT",
		"MP_AMBULATORY_ORG_USERPREFMENU",
 		"LONG_PREF_MAPPING",
		"MP_AMBULATORY_ORG_CALENDAR_TAB",
		"MP_AMBULATORY_ORG_RES_FAVS2")
go commit go
^
</Template><Template Name="mpt_deprod_mpage_steps" Description="Deprod steps for mPages.">##########PHASE 1

In the refresh TARGET domain, in DiscernVisualDeveloper, execute the following command to determine what code warehouse Cerner MPages is utilizing in the refresh TARGET domain:
select di.info_char from dm_info di where di.info_name = "FE_WH" go
If a value such as the following is returned, move on to step #3 below: &lt;Drive Letter&gt;:\
Ex: I:\, D:\, L:\ etc.

If one of the following two values is returned, contact CWx and tell them that they need to update the value for the Cerner MPages code warehouse for the refresh TARGET domain. 
a.&#xA0;
&lt;Some value&gt;\&lt;Some value&gt;\...\...\&lt;TARGET DOMAIN NAME&gt;
b.&#xA0;
&lt;Some value&gt;\&lt;Some value&gt;\...\...\&lt;SOURCE DOMAIN NAME&gt;

Once CWx has made the update, rerun the SELECT statement in the refresh TARGET domain again to verify that the Cerner MPages code warehouse for the refresh TARGET domain was indeed updated. 
DO NOT PROCEED TO STEP #2 until the Cerner MPages code warehouse is set correctly in the refresh TARGET domain.


##########PHASE 2

In the refresh TARGET domain, in DiscernVisualDeveloper, execute the following command to determine how the Cerner MPage CONTENT_SERVICE_URL is defined on the DM_INFO table:
select d.info_char from dm_info d where d.info_domain = "INS" and d.info_name = "CONTENT_SERVICE_URL" go
If the value returned is http://&lt;TARGET DOMAIN CERNER MPAGES WEBSPHERE LOAD BALANCER ADDRESS&gt;/mpage-content/&lt;Fully Qualified TARGET DOMAIN Name&gt;, move on to step #4 below.

If the value returned is http://&lt;SOURCE DOMAIN CERNER MPAGES WEBSPHERE LOAD BALANCER ADDRESS&gt;/mpage-content/&lt;Fully Qualified SOURCE DOMAIN Name&gt;, contact CWx and tell them that they need to update the value for the Cerner MPage CONTENT_SERVICE_URL for the refresh TARGET domain. 
Once CWx has made the update, rerun the SELECT statement in the refresh TARGET domain again to verify that the Cerner MPage CONTENT_SERVICE_URL for the refresh TARGET domain was indeed updated. 
DO NOT PROCEED TO STEP #3 until the Cerner MPage CONTENT_SERVICE_URL is set correctly in the refresh TARGET domain.

If blank:
update into dm_info 
set info_char="http://samtazeanp/mpage-content/s1805.samt_az.cernerasp.com"
where info_domain="INS"
and info_name="CONTENT_SERVICE_URL"
go
..and then cycle static content

##########PHASE 3 (must run query below on the backend)  
In the refresh TARGET domain, in DiscernVisualDeveloper, execute the following command to determine the path used by Physicaian Handoff to load the Consolidatd Problems view MPage:
select&#xA0;
MPAGE = bdc.category_name
,COMPONENT = bdr.report_name
,FILTER = bdf.filter_display
,bdv.freetext_desc
from&#xA0;
br_datamart_category bdc
,br_datamart_report bdr
,br_datamart_report_filter_r brfr
,br_datamart_filter bdf
,br_datamart_value bdv
plan bdc
where bdc.br_datamart_category_id =
( select br_datamart_category_id&#xA0;
from br_datamart_category&#xA0;
where category_mean = "MP_PHYS_HANDOFF"
)
join bdr
where bdr.br_datamart_category_id = bdc.br_datamart_category_id
and bdr.report_name = "Diagnosis Configuration" ; to filter by specific component&#xA0;
join brfr
where brfr.br_datamart_report_id = bdr.br_datamart_report_id&#xA0;
join bdf
where bdf.br_datamart_filter_id = brfr.br_datamart_filter_id&#xA0;
join bdv
where bdv.br_datamart_filter_id = bdf.br_datamart_filter_id
go

If one of the following three values is returned for the FREETEXT_DESC field, you are done de-proding Cerner MPages:
a. &lt;Drive Letter&gt;:\&lt;A directory path that does not contain a domain name in it&gt;
b.&#xA0;&lt;Some value&gt;\&lt;Some value&gt;\...\...\&lt;TARGET DOMAIN NAME&gt;\...
c. If the value for the path used by Physicaian Handoff to load the Consolidatd Problems view is BLANK (i.e. there is no value listed), you are done de-proding Cerner MPages.

If one of the following two values is returned contact CWx and tell them that they need to update the value for the Diagnosis Configuration component's "Static Content location link" filter in Bedrock in the refresh TARGET domain. 
a. &lt;Drive Letter&gt;:\&lt;A directory path that contains the SOURCE domain name in it&gt;
b.&#xA0;&lt;Some value&gt;\&lt;Some value&gt;\...\...\&lt;SOURCE DOMAIN NAME&gt;\...

Once CWx has made the update, rerun the SELECT statement in the refresh TARGET domain again to verify that the value for the Diagnosis Configuration component's "Static Content location link" filter in Bedrock for the refresh TARGET domain was indeed updated.

##########END OF PHASE 3

1. In the refresh TARGET domain, in DiscernVisualDeveloper, execute the following command for each of your client's domains, except the refresh TARGET domain, to determine how many rows in the NAME_VALUE_PREFS table contain references to Cerner MPages in a domain other than TARGET:
select * from name_value_prefs where pvc_value like "&lt;Domain Name&gt;" go

Ex: (See modified version below this paragraph).
The domain that has been refreshed that I am currently deproding is C1345.
In this case, I should run the following SELECT commands one at a time:
rdb select * from name_value_prefs where pvc_value like "%p1805%" go
rdb select * from name_value_prefs where pvc_value like "%b1805%" go
rdb select * from name_value_prefs where pvc_value like "%tm1805%" go
rdb select * from name_value_prefs where pvc_value like "%M1805%" go
Take note of how many rows are returned by the select statements.

Modified Robert Holland: Unneccessary to select all.
  rdb select pvc_value from name_value_prefs where pvc_value like "%b1805%" go
  rdb select pvc_value from name_value_prefs where pvc_value like "%p1805%" go
  rdb select pvc_value from name_value_prefs where pvc_value like "%tm1805%" go
  rdb select pvc_value from name_value_prefs where pvc_value like "%M1805%" go

Counting the rows is faster than selecting all or a string field.
  rdb select count(*) as B1805 from name_value_prefs where pvc_value like "%b1805%" go; 21 rows
  rdb select count(*) as P1805 from name_value_prefs where pvc_value like "%p1805%" go; 923 rows
  rdb select count(*) as M1805 from name_value_prefs where pvc_value like "%M1805%" go; 0 rows
  rdb select count(*) as TM1805 from name_value_prefs where pvc_value like "%TM1805%" go; 0 rows

4/25/22: 888 rows returned for p1805, all of them are in BH_Docs or for Commonwell, which can be ignored.
[#0C#];</Template><Template Name="mpt_deprod_rules_steps" Description="Rules Deprod Steps">;STEP 1:  Expire rules that send data out of domain
UPDATE INTO&#xA0; eks_module e
  SET e.maint_validation = "EXPIRED"
where e.active_flag = "A"
and e.module_name in (
  SELECT S.MODULE_NAME
  FROM EKS_MODULE&#xA0; M ,EKS_MODULESTORAGE&#xA0; S
  WHERE M.MODULE_NAME=S.MODULE_NAME
  AND M.ACTIVE_FLAG="A"
  AND M.MAINT_VALIDATION = "PRODUCTION"
  AND M.VERSION=S.VERSION
  AND S.EKM_INFO ="*EKS_BUILD_MESSAGE_A*"
  OR S.EKM_INFO ="*EKS_EXEC_CCL_A*"
  OR S.EKM_INFO ="*EKS_MESSENGER_A*"
  OR S.EKM_INFO ="*EKS_MESSENGER_ESC_A*"
)
go
commit go

;STEP 2: Turn on rules that are necessary for operational workflow and training
;Run this statement in backend CCL
update into eks_module em
  set MAINT_VALIDATION = "PRODUCTION"
  , updt_dt_tm = sysdate
  , updt_id = 32913554.00; RLHOLLAND
  , updt_task=123123123
where em.module_name in (
  "BHCMS_SAFE_OD"
  ,"BHCMS_SEPSIS_OD_ABX"
  ,"BHANC_RT_INH_PHARM_SYNC"
  ,"BHPHY_CCG_MED_EWS"
  ,"BHNRS_RESTRAINT_PHY_WARN"
  ,"BCC_RESTRAINTVIOLENT_DP_2"
  ,"BCC_RESTRAINT_DCMONITOR_3"
  ,"BHNRS_SPONT_VENT_DC"
  ,"BHPHY_DEPART_DME_ORD"
  ,"BHPHY_DEPART_DME_EQUIP5"
  ,"BHPHY_DEPART_DME_EQUIP3"
  ,"BHPHY_DEPART_DME_DEFIB"
  ,"BHPHY_DEPART_DME_CM_NTFY"
  ,"BHPED_SEPSIS_ED_DEPART"
  ,"BHPHY_DEPART_PROC_PND_DC"
  ,"BHPHY_DEPART_PROC_DC_ORD"
  ,"BHCMS_SAFE_SIRS"
  ,"BHNRS_SEDATION_DELIRIUM"
  ,"BHNRS_SEDATION_DELIRPROB"
  ,"BHPHY_CCG_MED_EWS_INCRSE"
  ,"BHPHY_CCG_MED_EWS_EVAL"
  ,"BHPHY_CCG_MED_EWS_CS_EX"
  ,"BHPHY_CCG_MED_EWS_CRT_EVT"
  ,"BHADVSR_VTE_RISK_SYNCH"
  ,"BHADVSR_VTE_RISK_CONTRA_M"
  ,"BHADVSR_VTE_POSTOP_SYNCH"
  ,"BHADVSR_VTE_PO_NP"
  ,"BHADVSR_VTE_ADM_NP"
  ,"BHNRS_SPONT_QDORD"
  ,"BHPHY_DEPART_DME_ORD_CL"
  ,"BHPHY_DEPART_DME_ORD_ASY2"
  ,"BHPHY_DEPART_DME_EQUIP6"
  ,"BHPHY_DEPART_DME_EQUIP2"
  ,"BHPHY_DEPART_DME_EQUIP"
  ,"BHPHY_DEPART_DME_CM_NTFY2"
  ,"BHPHY_CCG_MED_EWS_CC_DOC"
  ,"BHPHY_CCG_MED_EWS_CANCEL"
  ,"BHPHY_CCG_MED_EWS_ALERT"
  ,"EBP_RESTRAINT_FACETOFACE"
  ,"BCC_RESTRAINT_DCMONITOR_4"
  ,"BHADVSR_VTE_RISK_SPD_ORD"
  ,"BHADVSR_VTE_RISK_POSTPONE"
  ,"BHADVSR_VTE_RISK"
  ,"BHADVSR_VTE_CONTRA_TMR"
  ,"BHADVSR_VTE_CONTRA_RA"
  ,"BHPHY_DEPART_DME_RX_O2"
  ,"BHPHY_DEPART_DME_ORD_ASY"
  ,"BHPHY_DEPART_DME_EQUIP8"
  ,"BHPHY_DEPART_DME_EQUIP4"
  ,"BHPHY_DEPART_DCSUMM_RQST"
  ,"BHANC_RT_INH_NOTIFY"
  ,"BHANC_RT_INH_PHARM"
  ,"BHPHY_CCG_MED_EWS_NEURO"
  ,"BHNRS_IPOC_RESTRAINT_USE"
  ,"BHNRS_IPOC_RESTRAINT"
  ,"BCC_RESTRAINT_DC_NONVIOL"
  ,"BHADVSR_VTE_RISK_CONTRA_P"
  ,"BHADVSR_VTE_ORDER_CANCEL"
  ,"BHNRS_SPONT_SBT"
  ,"BHNRS_SPONT_QDORD_IVIEW"
  ,"BHPHY_DEPART_DME_ORD_ASY1"
  ,"BHPHY_DEPART_DME_ADDHOC"
  ,"BHPHY_DEPART_DFIB_CM_NTFY"
  ,"BHNRS_DEPART_DISPOSITION"
  ,"BHNRS_CM_SCREENING"
  ,"BHNRS_ALLERGY_ORDER"
  ,"EBP_RESTRAINT_FACE_EXALRT"
  ,"BCC_RESTRAINT_DC_VIOLENT"
  ,"BHADVSR_VTE_RISK_CLOSE"
  ,"BHNRS_SPONT_SBS"
  ,"BHNRS_SPONT_SAT"
  ,"BHNRS_SPONT_RPWEAN"
  ,"BHNRS_SPONT_CANCEL"
  ,"BHPHY_DEPART_DME_MISC"
  ,"BHPHY_DEPART_DME_EQUIP7"
  ,"BHPHY_DEPART_DME_EQUIP1"
  ,"BHPHY_DEPART_DME_CM_NTFY3"
  ,"LH_IC_WKLST_ADMIT_1"
  ,"LH_IC_WKLST_CE_1"
  ,"LH_IC_WKLST_CE_VIRO"
  ,"LH_IC_WKLST_ORD_1"
  ,"BHCMS_SAFE_ALERT"
  ,"BHCMS_SAFE_ED_CARESET"
  ,"BHCMS_SAFE_ED_DEN"
  ,"BHCMS_SAFE_ED_DEPART"
  ,"BHCMS_SAFE_ED_NOTIFY"
  ,"BHCMS_SAFE_ED_NOTIFY_SY"
  ,"BHCMS_SAFE_IP_CARESET"
  ,"BHCMS_SAFE_IP_CARESET24H"
  ,"BHCMS_SAFE_IP_DEN"
  ,"BHTST_SAFE_OB_EXCLUDE"
  ,"BHWIS_SAFE_OB_ALERT"
  ,"BHWIS_SAFE_OB_OD"
  ,"BHWIS_SAFE_OB_SIRS"
  ,"BHPED_SEPSIS_ED_DC"
  ,"BHPED_SEPSIS_ED_DEN"
  ,"BHADVSR_HIT_SYNCH"
  ,"BHADVSR_NALOXONE"
  ,"BHADVSR_RAD_IODINE_CONT_P"
  ,"BHADVSR_RX_PRN_DUP_CANCEL"
  ,"BHADVSR_UPDATE_REFERID"
  ,"BHADVSR_TORSADES"
)
and em.maint_dur_end_dt_tm &gt; sysdate
and em.active_flag = "A" 
go
commit go

;Cycle Rules servers.

;For TM1805, turn on this additional rule:
;Run this statement in backend CCL
update into eks_module em
  set MAINT_VALIDATION = "PRODUCTION"
  , updt_dt_tm = sysdate
  , updt_id = 32913554.00; RLHOLLAND
  , updt_task=123123123
where em.module_name = "BHEMD_CE_FIRSTNET_NC_B_U"
go
commit go

;Step 3: Check Discern Developer to make sure the expected changes show on the front end
;Open Discern Developer and make sure the rules you expect to show as expired show that way.
;We want to make sure that no changes were made to BHLAB* rules. 
;Note: the changes show on the front end, but we haven't dropped the modules, so they would still be firing at this point

;Step 4: Drop expired modules from CCL dictionary
;Run this statement in backend CCL
select into "drop_ekms.ccl"
  drop_ekm = concat("drop ekmodule ",trim(e.module_name)," go") from dprotect d,
  eks_module e
  plan d where d.object = "E"
  join e where d.object_name = e.module_name
  and e.active_flag = "A"
  and e.maint_validation = "EXPIRED"
  order e.module_name
detail
  col 0, drop_ekm, row+1
with noheading, maxrow=1, maxcol=80 go

;Open ccluserdir:drop_ekms.ccl in DVDev to make sure the correct rules are listed.

;Run the following command in backend ccl.
  %i ccluserdir:drop_ekms.ccl

;Cycle all EKS servers
;scpview Rules:
	cycle -entry 150
	cycle -entry 151
	cycle -entry 152
	cycle -entry 153
	cycle -entry 175
	cycle -query

;Step 5: Validate rules are expired
;Check CCLPROT with module name or try evoking a rule we turned off to make sure they are not firing.
^</Template><Template Name="mpt_discern_rule_expire" Description="2374_Discern Rule Expire">2374_Discern Rule Expire
Source: https://wiki.cerner.com/pages/releaseview.action?spaceKey=Proactive&amp;title=2374_Discern+Rule+Expire-WI

Brief Summary
This check finds all Discern Rules whose Validation status is in "PRODUCTION" but its Duration end date is less than 365 days from current date. Rules will not fire once it has passed its End date/time even though that Validation status is still "PRODUCTION". It is important to review rules upon their end date/time and determine if the rule is still necessary

Benefits
Anticipated Benefit

Rules will not get expired unexpectedly and cause patient safety issues.

Evaluation of Benefit

This query identifies how many times the rules in question have fired in the last 30 days

Benefit Example

Identified XX rules that triggered XX times during a XX day span that are set to expire in less than a year. Reviewing rules that are set to expire ensures that rules will continue to fire as expected preventing potential patient safety and workflow issues.

If this query does not produce results, try looking back further than SYSDATE - 30

select
e.module_name,
times_fired = count(e.module_name)
from eks_module_audit e
where e.begin_dt_tm != e.end_dt_tm
and e.updt_dt_tm &gt; sysdate - 30
and e.module_name in (
    SELECT
    E.MODULE_NAME
    FROM EKS_MODULE E
    where e.active_flag = "A"
    and e.maint_validation = "PRODUCTION"
    and e.maint_dur_end_dt_tm &lt; sysdate+365
    and not exists (select 'x'
    from eks_modulestorage ems
    where ems.module_name = e.module_name
    and ems.version = e.version
    and ems.data_type = 3
    and cnvtupper(ems.ekm_info) = "*AUDIT2374REVIEWED*"))
group by e.module_name go

Due to the unique nature of domains and build, you may not see a significant improvement or benefit.

Discovery
In some domains, ekm_info field is created as a long data type and that is causing the following error: ORA-00932: inconsistent datatypes: expected CHAR got LONG. This will cause the Kart Tool to display the check as a fail. Since Oracle 8i, Oracle advised against using the LONG datatype. Users should convert to CLOB or NCLOB types, so the audit can run properly and reflect the correct result.

Discovery Audit Query

SELECT
Count (E.MODULE_NAME)
FROM EKS_MODULE E
where e.active_flag = "A"
and e.maint_validation = "PRODUCTION"
and e.maint_dur_end_dt_tm &lt; sysdate+365
and not exists (select 'x'
from eks_modulestorage ems
where ems.module_name = e.module_name
and ems.version = e.version
and ems.data_type = 3
and cnvtupper(ems.ekm_info) = "*AUDIT2374REVIEWED*") ;This is the Keyword section on the Library tab of the rule.
WITH format(date,";;q") go

Detailed Audit Query

WARNING:

Ensure detailed query results are reviewed for patient information (especially for multi-tenet and CommunityWorks) and PHI protocol is followed. It is suggested that data be saved in separate spreadsheets with passwords.

SELECT
E.MODULE_NAME,
E.MAINT_SPECIALIST,
E.MAINT_AUTHOR,
E.MAINT_VALIDATION,
E.MAINT_DUR_BEGIN_DT_TM,
E.MAINT_DUR_END_DT_TM,
e.updt_dt_tm,
e.updt_id
FROM EKS_MODULE E
where e.active_flag = "A"
and e.maint_validation = "PRODUCTION"
and e.maint_dur_end_dt_tm &lt; sysdate+365
and not exists (select 'x'
from eks_modulestorage ems
where ems.module_name = e.module_name
and ems.version = e.version
and ems.data_type = 3
and cnvtupper(ems.ekm_info) = "*AUDIT2374REVIEWED*") ;This is the Keyword section on the Library tab of the rule.
WITH format(date,";;q") go

Investigation
Rules will not fire once they have passed their End date/time even though that Validation status is still "PRODUCTION". It is important to review rules upon their end/date and time and determine if the rule is still necessary. If it is determined that a rule is still necessary, then the end date/time should either be updated to a future date or, if there is no intention of expiring the rule, then the date 12/31/2100 can be used.  If the rule is no longer necessary, then the Validation Status should be updated to 'Expired'"

The below query can be used to see all rules that have been previously reviewed and excluded from this audit.

SELECT
E.MODULE_NAME,
E.MAINT_SPECIALIST,
E.MAINT_AUTHOR,
E.MAINT_VALIDATION,
E.MAINT_DUR_BEGIN_DT_TM,
E.MAINT_DUR_END_DT_TM,
ems.ekm_info
FROM EKS_MODULE E,
eks_modulestorage ems
where e.active_flag = "A"
and e.maint_validation = "PRODUCTION"
and e.maint_dur_end_dt_tm &lt; sysdate+365
and ems.module_name = e.module_name
and ems.version = e.version
and ems.data_type = 3
and cnvtupper(ems.ekm_info) = "*AUDIT2374REVIEWED*" ;This is the Keyword section on the Library tab of the rule.
WITH format(date,";;q") go

There are screenshots on the website.
Cycle servers 150, 151, 152, 175, and 176 after changing the expiration date.
^
</Template><Template Name="mpt_duplicate_program_check" Description="Duplicate Program Check PRB0043702">PRB0043702
CWXPI 1395 Duplicate CCL Program Check
First Reported: Friday, 06-Sep-2013 (3273 Days ago)
Different versions of the same CCL program may exist in a Cerner Millennium domain's CCL Dictionary. This can result in the program returning different results, depending on which version is executed.
Different versions of a program are created depending on the group a user belongs to (0=DBA, 1=non-DBA). If d_prod is a group 0 user and jdoe is a group 1 user and they each create a program called "cerner_test", there will be two different versions in the CCL dictionary. All group 0 users will execute the version created by d_prod while all group 1 users will execute the version created by jdoe. If these programs are not identical, users executing the same programs could see different results depending on what group they belong to.
Details:
Severity:	High	Last Run:	Sunday, 21-Aug-2022
Solution:	Discern Explorer	Frequency:	Weekly
Category:	Workflow	Check Type:	Solutions
Check Status Details:
2792
Days Failed
25.3%
81 of 320
Environments
Passing
Failure Reason:
Failed SAMT_AZ SAMTAZAPP1.CERNERASP.COM for CCL programs in both group 0 and 1: 'OBJECT_NAME' == 'None', Failed SAMT_AZ SAMTAZAPP1.CERNERASP.COM for CCL programs in both group 0 and 1: '1BH_APP_GRP_BY_POS' == 'None', Failed SAMT_AZ SAMTAZAPP1.CERNERASP.CO

Action Required:
https://wiki.cerner.com/x/ii_ZeQ
To check for duplicate CCL programs, run the following query in CCL on each node in the domain:
  select d.object_name
  from dprotect d,
  dprotect d2
  plan d where d.object = "P"
  and d.group = 0
  join d2 where d.object= d2.object
  and d.object_name = d2.object_name
  and d.group != d2.group
  go

This provides a list of programs that have both a group 0 version and group 1 version. Any programs that have both a group 0 and a group 1 version should involve a custom version. Work with the client to determine which is the version they are wanting to keep.
If the group 0 version is the version they want, the group 1 version of the programs should be dropped with the following command:
drop program &lt;program_name&gt;:group1 go
For example, to remove the program named cerner_test, run the following in CCL:
drop program cerner_test:group1 go
If the group 1 version is the version they want, the source code for the group 1 version should be included by a group 0 user. This will create the group 0 version of the program and the group 1 version can then be dropped with the same commands.
^</Template><Template Name="mpt_facesheet" Description="Facesheet">QA/TEST System:
http://intranet7qa.bhs.bannerhealth.com/CernerMPages/ms4Facesheet.aspx?CPI=PATIENT_FIN&amp;Facility=3_MS4_DIGIT_FACILITY_CODE

P1805:
http://intranet7.bhs.bannerhealth.com/CernerMPages/ms4Facesheet.aspx?CPI=PATIENT_FIN&amp;Facility=3_MS4_DIGIT_FACILITY_CODE

CCL: 1bh_mpage_facesheet.prg
NameSpace: banner.facesheet
^</Template><Template Name="mpt_facility_codes" Description="Show Facility Codes.">See also:
	mpt_locations_facilities_acute
	mpt_locations_facilities_ambulatory

;---------Facilities and Units----------------------------------------------

SELECT INTO "NL:"
L.LOCATION_CD
, Facility_Description = UAR_GET_CODE_DESCRIPTION(L.LOCATION_CD)
, L_LOCATION_DISP = UAR_GET_CODE_DISPLAY(L.LOCATION_CD) ;Facility name
, ","
, LO.LOCATION_CD
, ";"
	, LO_LOCATION_DISP = UAR_GET_CODE_DISPLAY(LO.LOCATION_CD) ;Unit name
	, L_FACILITY_ACCN_PREFIX_DISP = UAR_GET_CODE_DISPLAY(L.FACILITY_ACCN_PREFIX_CD)

FROM
	LOCATION   L
	, LOCATION   LO
	, CODE_VALUE CV1
	, CODE_VALUE CV_LO

PLAN L
	WHERE	L.LOCATION_TYPE_CD = 783.00 ;Facility(s)
	AND		L.ACTIVE_IND = 1
	AND		L.PATCARE_NODE_IND = 1

; 	and l.location_cd =  4298880175.00	;BUMCS

JOIN LO
	WHERE	LO.ORGANIZATION_ID = L.ORGANIZATION_ID
	AND 	LO.ACTIVE_IND = 1
	AND		LO.LOCATION_TYPE_CD = 794.00 ;Nurse Unit(s)

JOIN CV1
	WHERE	CV1.CODE_VALUE = L.LOCATION_CD
	AND		CV1.DISPLAY_KEY NOT IN ("BANNERHEALTH","STARTORGANIZAT","BPC")

JOIN CV_LO
	WHERE	CV_LO.CODE_VALUE = LO.LOCATION_CD
;	AND		CV_LO.DISPLAY NOT IN ("*Test*","*TEST*") ;enabled when go live

ORDER BY
	L_LOCATION_DISP
	, LO_LOCATION_DISP

WITH NOCOUNTER, FORMAT, TIME=30

;---------Facilities Only----------------------------------------------

SELECT ;INTO "NL:"
distinct(L.LOCATION_CD)
, Facility_Description = UAR_GET_CODE_DESCRIPTION(L.LOCATION_CD)
, Facility_Acronym = UAR_GET_CODE_DISPLAY(L.LOCATION_CD) ;
, Facility_Number = UAR_GET_CODE_DISPLAY(L.FACILITY_ACCN_PREFIX_CD)

FROM
	LOCATION   L
	, LOCATION   LO
	, CODE_VALUE CV1
	, CODE_VALUE CV_LO

PLAN L
	WHERE	L.LOCATION_TYPE_CD = 783.00 ;Facility(s)
	AND		L.ACTIVE_IND = 1
	AND		L.PATCARE_NODE_IND = 1

; 	and l.location_cd =  4298880175.00	;BUMCS

JOIN LO
	WHERE	LO.ORGANIZATION_ID = L.ORGANIZATION_ID
	AND 	LO.ACTIVE_IND = 1
	AND		LO.LOCATION_TYPE_CD = 794.00 ;Nurse Unit(s)

JOIN CV1
	WHERE	CV1.CODE_VALUE = L.LOCATION_CD
	AND		CV1.DISPLAY_KEY NOT IN ("BANNERHEALTH","STARTORGANIZAT","BPC")

JOIN CV_LO
	WHERE	CV_LO.CODE_VALUE = LO.LOCATION_CD
;	AND		CV_LO.DISPLAY NOT IN ("*Test*","*TEST*") ;enabled when go live

ORDER BY
	Facility_Number

WITH NOCOUNTER, FORMAT, TIME=30
^</Template><Template Name="mpt_find_cerner_user_groups" Description="Find Cerner User Group">select
    p.person_id
    ,p.prsnl_group_id
    ,p.active_ind
    ,pg.prsnl_group_type_cd
    ;,p.*

from
     prsnl_group_reltn p
     , prsnl_group pg
plan p
     where p.person_id = (select x.person_id from prsnl x where x.username = "[+USERNAME+]")
and p.active_ind = 1
join pg
where p.prsnl_group_id = pg.prsnl_group_id
with uar_code(d)

;Groups code_set = 357
select
	cv.display
	, cv.code_set
	, cv.code_value
	, pg.prsnl_group_id
	, cv.definition
	, cv.description
	, cv.display_key
from
	code_value cv
    , prsnl_group pg
plan cv
where
	cv.code_set = 357
and
	cv.active_ind = 1
join pg
where cv.code_value = pg.prsnl_group_type_cd
order by cv.display

;select display, code_value from code_value where display like "*Medical Staff" or display like "*MEDICAL STAFF" order by display
;select display, code_value from code_value where cdf_meaning = "DCPTEAM" order by display
^</Template><Template Name="mpt_find_emergency_contact_info" Description="Find emergency contact info">SELECT INTO "nl:"
&#xA0;&#xA0;&#xA0; patient = p.name_full_formatted
&#xA0;&#xA0;&#xA0; ,updated_by = pr.name_full_formatted
&#xA0;&#xA0;&#xA0; ,updated_on = epr.updt_dt_tm
&#xA0;&#xA0;&#xA0; , phone_number =
&#xA0;&#xA0;&#xA0; IF (findstring("(",ph.phone_num,1,0)=0
&#xA0;&#xA0;&#xA0;&#xA0; AND findstring(")",ph.phone_num,1,0)=0) cnvtphone(ph.phone_num,ph.phone_format_cd,2)
&#xA0;&#xA0;&#xA0; ELSE ph.phone_num
&#xA0;&#xA0;&#xA0; ENDIF
&#xA0;&#xA0;&#xA0; , phone_sort = cnvtalphanum(ph.phone_num), phone_type = uar_get_code_display(ph.phone_type_cd);,
;&#xA0;&#xA0;&#xA0; sort_val = getecsortvalue(ph.phone_type_cd)
&#xA0;&#xA0;&#xA0; ,epr.*
&#xA0;&#xA0;&#xA0; FROM encntr_person_reltn epr,
&#xA0;&#xA0;&#xA0;&#xA0; phone ph,
&#xA0;&#xA0;&#xA0;&#xA0; person p,
&#xA0;&#xA0;&#xA0;&#xA0; prsnl pr
&#xA0;&#xA0;&#xA0; PLAN (epr
&#xA0;&#xA0;&#xA0;&#xA0; WHERE epr.encntr_id in ([+encntr_id+]) ;encntrid
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.person_reltn_type_cd=1152.00&#xA0;&#xA0;&#xA0; ;Emergency Contact ;emc_cd
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.related_person_id &gt; 0.0
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.beg_effective_dt_tm &lt; cnvtdatetime(sysdate)
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.end_effective_dt_tm &gt;= cnvtdatetime(sysdate)
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.active_ind=1)
&#xA0;&#xA0;&#xA0;&#xA0; JOIN (p
&#xA0;&#xA0;&#xA0;&#xA0; WHERE p.person_id=epr.related_person_id)
&#xA0;&#xA0;&#xA0;&#xA0; JOIN (ph
&#xA0;&#xA0;&#xA0;&#xA0; WHERE (ph.parent_entity_id= Outerjoin(epr.related_person_id))
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND (ph.parent_entity_name= Outerjoin("PERSON"))
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND (ph.beg_effective_dt_tm&lt;= Outerjoin(cnvtdatetime(sysdate)))
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND (ph.end_effective_dt_tm&gt;= Outerjoin(cnvtdatetime(sysdate)))
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND (ph.active_ind= Outerjoin(1)) )
&#xA0;&#xA0;&#xA0;&#xA0; JOIN pr
&#xA0;&#xA0;&#xA0;&#xA0; WHERE pr.person_id = epr.updt_id
&#xA0;&#xA0;&#xA0;&#xA0; AND pr.active_ind = 1
&#xA0;&#xA0;&#xA0; ORDER BY p.person_id, ph.parent_entity_id, epr.priority_seq,
&#xA0;&#xA0;&#xA0;&#xA0; phone_type, ph.phone_type_seq,
&#xA0;&#xA0;&#xA0;&#xA0; phone_sort
WITH UAR_CODE(D), FORMAT(DATE,";;Q"), TIME=60</Template><Template Name="mpt_findAvailableBedrockFilterName" Description="Find mPages with a specific filter listed in Bedrock (case-sensitive)">;CHG0105345: Bedrock: An unexpected error has occurred. Please contact your system administrator and provide the log file. Bedrock Logging

;Find mPages with a specific filter listed in Bedrock (case-sensitive)
[+Available Filters+]; eg: "PowerForms to chart vitals", "Heart rate results", "Vital Signs chart launch indicator"
[+mPage Name+] (eg. "Oncology Nursing Handoff", "Oncology Ambulatory Workflow")

;Display mPages that have the [+Available Filters+] filter.
select  DISTINCT INTO "NL:"
	[+mPage Name+]=bdc.category_name,
	mPage_Layout =
if (bdc.layout_flag = 0 )	"Summary"
elseif(bdc.layout_flag = 1)	"Workflow"
elseif(bdc.layout_flag = 2)	"Smart Template"
elseif(bdc.layout_flag = 3)	"Quick Orders and Charges"
elseif(bdc.layout_flag = 4)	"Patient Organizer View"
elseif(bdc.layout_flag = 5)	"Dashboard"
elseif(bdc.layout_flag = 6)	"Organizer View - Provider"
elseif(bdc.layout_flag = 7)	"Emergent Event"
elseif(bdc.layout_flag = 8)	"SCM Purchase Order Organizer"
elseif(bdc.layout_flag = 9)	"SCM Inventory Management Organizer" endif,
	bdc.category_mean ,
	bdv.mpage_param_value,
	bdv.freetext_desc,
	bdf.filter_mean ,
	bdf.filter_display,
	bdf.filter_seq,
	bdc.layout_flag,
	bdc.*,
	bdv.*,
	bdf.*
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_display = "[+Available Filters+]"
order by bdc.category_name, bdc.layout_flag


;Get BR_DATAMART_FILTER_IDs for Bedrock settings.
select  DISTINCT
	[+mPage Name+]=bdc.category_name,
	bdc.category_mean ,
	bdf.filter_mean ,
	bdf.filter_display,
	bdv.br_datamart_filter_id,
	DTA = bdv.freetext_desc
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_display = "[+Available Filters+]"
;and bdc.category_name = "Oncology Ambulatory Workflow"
;and bdc.category_name = "[+mPage Name+]"
order by bdv.freetext_desc, bdc.category_name, bdc.layout_flag

;Documents specialty groups filter:
select  DISTINCT
	[+mPage Name+]=bdc.category_name,
	bdc.category_mean ,
	bdf.filter_mean ,
	bdf.filter_display,
	bdv.br_datamart_filter_id,
	DTA = bdv.freetext_desc
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_display like "[+Available Filters+]*"
;and bdc.category_name = "Oncology Ambulatory Workflow"
and bdc.category_name = "[+mPage Name+]"
order by bdv.freetext_desc, bdc.category_name, bdc.layout_flag

;Delete statement:
	delete from br_datamart_value where br_datamart_filter_id = xxxxxxx.00 go
commit go
^</Template><Template Name="mpt_findAvailableFilterTested" Description="Find Bedrock filter DTAs.">;MULTIPURPOSE CCL: Find mPages using a DTA in an available filter. Need to know the available filter name and DTA.
;This shows all mPages with "CM Transition Plan Initial Assess Form" configured in the "Clinical Documentation" available filter.
[+&lt;AVAILABLE_FILTER_NAME&gt;+] ; (ex. "Clinical documentation specialty group #1 results", "Temperature results").
[+&lt;DTA_NAME&gt;+] ; (ex. "CM Transition Plan Initial Assess Form", "Phone Message/Call").
[+&lt;mPAGE_NAME&gt;+] ; (ex. "Primary Care Amb Workflow", "Pharmacy Workflow").
[+&lt;the_filter_id&gt;+] ; Run Bedrock with Control + Shift + I.

select  DISTINCT
            mPage_Name=bdc.category_name,
            bdc.category_mean ,
            bdf.filter_mean ,
            bdf.filter_display,
            bdv.br_datamart_filter_id,
            ;WRONG_DTA = bdv.freetext_desc,
            CORRECT_DTA = uar_get_code_display(bdv.parent_entity_id),
            ;description=uar_get_code_description(bdv.parent_entity_id),
            ;meaning=uar_get_code_meaning(bdv.parent_entity_id),
            ;definition=uar_get_definition(bdv.parent_entity_id),
            ;displaykey=uar_get_displaykey(bdv.parent_entity_id),
            bdv.parent_entity_id
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
;Available Filter Name:
	and bdf.filter_display like "[+&lt;AVAILABLE_FILTER_NAME&gt;+]";Available filter.
	;and bdf.filter_display like "Clinical Documentation";Available filter.
	;and bdf.filter_display like "Clinical documentation specialty group #*";Available filter.
	;and bdf.filter_display like "Home medication class grouping #*";Available filter.
	;and bdf.filter_display like "Score event set selection*";Available filter.
	;and bdf.filter_display like "Sequence scales and assessments results";Available filter.
;mPage Name:
	;and bdc.category_name = "[+&lt;mPAGE_NAME&gt;+]" ;Comment this line to show all mPages with the above available filter
;Search by Code Value Display Name:
	;and bdv.parent_entity_id = (select cv.code_value from code_value cv where cv.display = "[+&lt;DTA_NAME&gt;+]");CM Transition Plan Initial Assess Form
order by bdc.category_name, bdf.filter_mean, bdv.freetext_desc

;-----------------
;List DTA's configured for a particular filter.
;I used this to find the DTA configured on all mPages that have the "Confirmation applied to diagnosis" Available filter.
select
  bdv.br_datamart_value_id
  ,sequence_order = value_seq
  ,code_value = parent_entity_id; This could also be nomenclature_id
  ,cv_display = uar_get_code_display(parent_entity_id)
  ,bdv.br_datamart_filter_id
  ,bdv.br_datamart_category_id
  ,bdv.parent_entity_name
  ;,*
from
	br_datamart_value bdv
where
	bdv.br_datamart_filter_id = (
		select  DISTINCT
            bdv1.br_datamart_filter_id
		from
			BR_DATAMART_CATEGORY BDC,
			br_datamart_value bdv1,
			br_datamart_filter bdf
		where bdc.br_datamart_category_id = bdv1.br_datamart_category_id
		and bdf.br_datamart_filter_id = bdv1.br_datamart_filter_id
		;Available Filter Name:
			and bdf.filter_display like "[+&lt;AVAILABLE_FILTER_NAME&gt;+]";Available filter (ex. "Previous Overdose", "Confirmation applied to diagnosis").
		;mPage Name: (ex. "Primary Care Amb Workflow", "Pharmacy Workflow")
			and bdc.category_name = "[+&lt;mPAGE_NAME&gt;+]" ;Comment this line to show all mPages with the above available filter
		)

;-----------------
Get filter_id from query above. What is [+&lt;the_filter_id&gt;+]?
To get the necessary information from the log file, run Bedrock with Control + Shift + I and reproduce the error.
Open the log file and look for the name of the filter that is producing the error. You should see the br_datamart_filter_id a few lines above the filter name.

	select
  	bdv.br_datamart_value_id
  	,bdv.freetext_desc
  	,sequence_order = value_seq
  	,code_value = parent_entity_id
  	,cv_display = uar_get_code_display(parent_entity_id)
  	,bdv.br_datamart_filter_id
  	,bdv.br_datamart_category_id
  	,bdv.parent_entity_name
  	;,bdv.*
	from
		br_datamart_value bdv
	where
		bdv.br_datamart_filter_id = [+&lt;the_filter_id&gt;+]
	order by
		cv_display

Make a copy of the data before deleting it
After running the delete statement cycle server 535 then update the filter

	delete from br_datamart_value bdv where bdv.br_datamart_filter_id = [+&lt;the_filter_id&gt;+] go
	commit go
^</Template><Template Name="mpt_findComponent" Description="Find mPage Component">;Custom Components or Columns:
;____"Diagnostic Insights"___________________________________________________________;
select  DISTINCT INTO "NL:"
	mPage_Name=bdc.category_name,
	mPage_Layout_Type =
if (bdc.layout_flag = 0 )	"Summary"
elseif(bdc.layout_flag = 1)	"Workflow"
elseif(bdc.layout_flag = 2)	"Smart Template"
elseif(bdc.layout_flag = 3)	"Quick Orders and Charges"
elseif(bdc.layout_flag = 4)	"Patient Organizer View"
elseif(bdc.layout_flag = 5)	"Dashboard"
elseif(bdc.layout_flag = 6)	"Organizer View - Provider"
elseif(bdc.layout_flag = 7)	"Emergent Event"
elseif(bdc.layout_flag = 8)	"SCM Purchase Order Organizer"
elseif(bdc.layout_flag = 9)	"SCM Inventory Management Organizer" endif,
	mpage_identifier=bdc.category_mean ,
	component_name=bdv.mpage_param_value,
	;bdv.freetext_desc,
	component_type=bdf.filter_mean ,
	component_filter_display=bdf.filter_display
	;bdf.filter_seq,
	;bdc.layout_flag,
	;bdc.*
	;bdv.*
	;bdf.*
from BR_DATAMART_CATEGORY BDC, br_datamart_value bdv,  br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdv.mpage_param_value = "[+Component Name+]"
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
order by bdc.category_name, bdc.layout_flag

/*
;Display Layout Flag Types:
SELECT
	DM.FLAG_VALUE,
	DM.DESCRIPTION,
	DM.DEFINITION
FROM DM_FLAGS DM
WHERE DM.TABLE_NAME = "BR_DATAMART_CATEGORY"
	AND DM.COLUMN_NAME = "LAYOUT_FLAG"
WITH  FORMAT, TIME = 60
*/


;Canned Components:
;_______________________________________________________________;
select ;into $outdev
	mpage_name = c.category_name
	, mpage_identifier=c.category_mean
	, component_name = br.report_name
	;, br.report_mean
	, component_filter_display=bf.filter_display

from
	br_datamart_category   c
	, br_datamart_report   br
	, br_datamart_report_filter_r   bfr
	, br_datamart_filter   bf

plan c where c.br_datamart_category_id &gt; 0
join  br
where br.br_datamart_category_id = c.br_datamart_category_id
join bfr
where bfr.br_datamart_report_id = br.br_datamart_report_id
join bf
where bf.br_datamart_filter_id = bfr.br_datamart_filter_id
 and bf.filter_category_mean ="MP_SECT_PARAMS"
and br.report_name = "[+Component Name+]"
order by
	mpage_name
	, bf.filter_seq

with nocounter, separator=" ", format, time = 300

;_______________________________________________________________;
SELECT distinct
	mpage_name=C.CATEGORY_NAME
	, mPage_Identifier = C.CATEGORY_MEAN
	, BR.REPORT_NAME
	,component_name=bdv.mpage_param_value
	,layout_type = dm.definition
 
FROM
	BR_DATAMART_CATEGORY   C
	, BR_DATAMART_REPORT   BR
	, BR_DATAMART_REPORT_FILTER_R   BFR
	, BR_DATAMART_FILTER   BF
	, BR_DATAMART_VALUE BDV
	, DM_FLAGS DM
 
plan C where C.BR_DATAMART_CATEGORY_ID &gt; 0
;Comment both lines below to see all mPages:
	;and C.CATEGORY_MEAN = "[+VB_ZZZPRIMARYCAREWORKLFOWTEST+]" ;mPage View Builder Identifier
	;and C.CATEGORY_NAME = "[+zzz Primary Care Workflow Test+]" ;mPage View Builder Display Name
join  BR
WHERE BR.BR_DATAMART_CATEGORY_ID = c.br_datamart_category_id
join BFR
WHERE BFR.BR_DATAMART_REPORT_ID = BR.BR_DATAMART_REPORT_ID
join BF
WHERE BF.BR_DATAMART_FILTER_ID = BFR.BR_DATAMART_FILTER_ID
 AND BF.FILTER_CATEGORY_MEAN ="MP_SECT_PARAMS"
join bdv
where bf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdv.mpage_param_mean = "mp_label"
;Comment below to search by name or identifier above.
	and bdv.mpage_param_value = "[+Component Name+]" ;Component layout parameter
join dm
WHERE dm.flag_value = c.layout_flag
;where c.layout_flag = dm.flag_value
	and dm.column_name = "LAYOUT_FLAG"
ORDER BY
	C.CATEGORY_NAME
	, BF.FILTER_SEQ
 
WITH NOCOUNTER, SEPARATOR=" ", FORMAT, time = 300

**SEE mpt_findNameSpace for query that displays all.
^</Template><Template Name="mpt_findComponentUsingCCL" Description="Find component that is using a CCL">;Find components using ccl:
select  DISTINCT
	mPage_Name=bdc.category_name,
	bdc.category_mean ,
	bdf.filter_mean ,
	bdf.filter_display,
	bdv.br_datamart_filter_id,
	DTA = bdv.freetext_desc
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_display like "[+Custom Column * CCL Script+]"
;and bdc.category_name = "[+CV19 Hospitalist Worklist+]"
order by bdc.category_name, bdf.filter_mean, bdv.freetext_desc
^</Template><Template Name="mpt_findDTA" Description="Find DTA on mPages">"[+DTA+]" - Example: "Eye, Left Visual Acuity" or "Heart Rate"

select  DISTINCT INTO "NL:"
	mPage_Name=bdc.category_name,
	mPage_Layout =
if (bdc.layout_flag = 0 )	"Summary"
elseif(bdc.layout_flag = 1)	"Workflow"
elseif(bdc.layout_flag = 2)	"Smart Template"
elseif(bdc.layout_flag = 3)	"Quick Orders and Charges"
elseif(bdc.layout_flag = 4)	"Patient Organizer View"
elseif(bdc.layout_flag = 5)	"Dashboard"
elseif(bdc.layout_flag = 6)	"Organizer View - Provider"
elseif(bdc.layout_flag = 7)	"Emergent Event"
elseif(bdc.layout_flag = 8)	"SCM Purchase Order Organizer"
elseif(bdc.layout_flag = 9)	"SCM Inventory Management Organizer" endif,
	bdc.category_mean ,
	bdv.mpage_param_value,
	bdv.freetext_desc,
	bdf.filter_mean ,
	bdf.filter_seq,
	bdc.layout_flag,
	;bdc.*
	;bdv.*
	bdf.*
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdv.freetext_desc = "[+DTA+]"
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
order by bdc.category_name, bdc.layout_flag
^
</Template><Template Name="mpt_findDTAinCannedmPages" Description="Find/Search DTA in Canned mPages.">/*  Bedrock settings research */
 
; find mpage base group
select group = mg.group_ident
, mg.description
, version = mg.version_txt
, update_on = mg.updt_dt_tm "@SHORTDATETIME"
, updated_by = p.name_full_formatted
;, mg.*
from mp_group mg, prsnl p
where mg.mp_release_id &gt; 0
and p.person_id = outerjoin(mg.updt_id)
order by mg.updt_dt_tm desc
WITH UAR_CODE(D), FORMAT(DATE,";;Q"), TIME=120
 
; find mpages in viewpoint
select mv.viewpoint_name
;, vw_updated_on = mv.updt_dt_tm "@SHORTDATETIME"
;, vw_updated_by = p.name_full_formatted
;, mv.*
, mv.updt_cnt
, vn.updt_cnt
, mpages_in_viewpoint = bc.category_name
, mp_updated_on = vn.updt_dt_tm "@SHORTDATETIME"
, mp_updated_by = p2.name_full_formatted
from mp_viewpoint mv
, mp_viewpoint_reltn vn
, br_datamart_category bc
, prsnl p
, prsnl p2
plan mv where mv.active_ind = 1
join p where p.person_id = mv.updt_id
join vn where vn.mp_viewpoint_id = mv.mp_viewpoint_id
join bc where bc.br_datamart_category_id = vn.br_datamart_category_id
join p2 where p2.person_id = vn.updt_id
order by mv.viewpoint_name
WITH UAR_CODE(D), FORMAT(DATE,";;Q"), TIME=120
 
/* search Bedrock  */
select distinct
;  v.br_datamart_value_id
  mpage = bdc.category_name
  , ves.event_set_cd_definition
  , component = b.report_name
;  , REPORTID = b.br_datamart_report_id
  , filter = bdf.filter_display
  , flex_position = evaluate2(
      if(nullind(f.br_datamart_flex_id) = 0)
        if(f.parent_entity_type_flag = 1)
         uar_get_code_display(f.parent_entity_id)
        elseif(f.parent_entity_type_flag = 2)
         uar_get_code_display(f_parent.parent_entity_id)
        endif
      else
         "Default"
      endif
    )
  , flex_location = evaluate2(
      if(nullind(f_parent.br_datamart_flex_id) = 0)
        uar_get_code_display(f.parent_entity_id)
      elseif(f.parent_entity_type_flag = 1)
       "All Facilities"
      else
       "Default"
      endif
    )
  , combined_filter_value = trim(build2((evaluate2(
      if(nullcheck(v.freetext_desc,"TRUE",NULLIND(v.freetext_desc)) &gt; " ")
        if(v.parent_entity_id = 0.00 and v.freetext_desc = "1")
          "Yes"
        elseif(v.parent_entity_id = 0.00 and v.freetext_desc = "0")
          "No"
        elseif(v.parent_entity_name = "CODE_VALUE")
          if(v.parent_entity_id = vcv.code_value and vcv.code_set = 93)
;           trim(ves.event_set_cd_disp)
           build2("L36 - ",trim(ves.event_set_cd_disp))
          else
;           trim(v.freetext_desc)
			build2("L39 - ",(trim(v.freetext_desc)))
          endif
        else
;          trim(v.freetext_desc)
          build2("L46 - ",(trim(v.freetext_desc)))
        endif
      elseif(cnvtupper(v.mpage_param_mean) in ("MP_LOOK_BACK_UNITS","MP_LOOK_BACK_CUR_ENC"))
        if(nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) &gt; " ")
          if(v.value_type_flag = 1)
            build2("L48 All encounters - Specified time period: ",(trim(v.mpage_param_value)))
          elseif(v.value_type_flag = 2)
            build2("L50 Current encounter only - Specified time period: ",(trim(v.mpage_param_value)))
          endif
        else
          if(v.value_type_flag = 1)
            "All encounters"
          elseif(v.value_type_flag = 2)
            "Current encounter only"
          endif
        endif
      elseif(nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) &gt; " ")
;       trim(v.mpage_param_value)
       build2("L265 - ",(trim(v.mpage_param_value)))
      elseif(v.parent_entity_name = "NOMENCLATURE")
       trim(n.source_string)
      elseif(v.parent_entity_name = "CODE_VALUE")
        if(vcv.code_set = 93)
;          trim(ves.event_set_cd_disp)
          build2("L271 - ",(trim(ves.event_set_cd_disp)))
        else
          trim(vcv.display)
;          build2("L274 - ",(trim(vcv.display)))
        endif
      elseif(v.parent_entity_name = "DCP_FORMS_REF")
       trim(d.definition)
;       build2("L73 - ",(trim(d.definition)))
      elseif(v.parent_entity_name = "ALT_SEL_CAT")
       trim(alc.long_description)
      elseif(v.parent_entity_name = "MLTM_DRUG_CATEGORIES")
       trim(mdc.category_name)
      elseif(v.parent_entity_name = "cr_report_template")
       trim(crt.template_name)
      elseif(v.parent_entity_name = "BR_EVENT_GROUPER")
       trim(breg.grouper_name)
      elseif(v.parent_entity_name = "ORDER_CATALOG_SYNONYM")
       trim(ocs.mnemonic)
      elseif(v.parent_entity_name = "PATHWAY_CATALOG")
       trim(pc.description)
      elseif(v.parent_entity_name = "DMS_CONTENT_TYPE")
       trim(dct.display)
      elseif(v.parent_entity_name = "MLTM_ALR_CATEGORY")
       trim(mac.category_description)
      elseif(v.parent_entity_name = "PRSNL")
       trim(pr.name_full_formatted)
      elseif(v.parent_entity_name = "BR_CCN")
       trim(brc.ccn_name)
      elseif(v.parent_entity_name = "BR_HCO")
       trim(bh.hco_name)
      elseif(v.parent_entity_name = "PERSON")
       trim(per.name_full_formatted)
      elseif(v.parent_entity_name = "WORKING_VIEW")
       trim(wv.display_name)
      elseif(v.parent_entity_name = "HM_EXPECT_SAT")
       trim(hes.expect_sat_name)
      elseif(v.parent_entity_name = "OE_FIELD_MEANING")
       trim(ofm.oe_field_meaning)
      elseif(nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) = " ")
        if(cnvtupper(v.mpage_param_mean) in ("MP_LOOK_BACK_UNITS","MP_LOOK_BACK_CUR_ENC"))
          if(v.value_type_flag = 1)
            "All encounters"
          elseif(v.value_type_flag = 2)
            "Current encounter only"
          endif
        endif
      endif))
  , (evaluate2(
     if(((nullcheck(v.freetext_desc,"TRUE",NULLIND(v.freetext_desc)) &gt; " ")
          or
          (nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) &gt; " "))
        and v.parent_entity_name = "CODE_VALUE"
        and v.parent_entity_id = vcv.code_value
        and vcv.code_set = 54)
        " "
      else
        ""
       endif))
  , (evaluate2(
     if(((nullcheck(v.freetext_desc,"TRUE",NULLIND(v.freetext_desc)) &gt; " ")
          or
          (nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) &gt; " "))
        and v.parent_entity_name = "CODE_VALUE"
        and v.parent_entity_id = vcv.code_value
        and vcv.code_set = 54)
;        trim(vcv.display)
        build2("L132 - ",(trim(vcv.display)))
      else
        ""
       endif))
   ))
  , v.freetext_desc
;  , v.mpage_param_value
;  , v.mpage_param_mean
;  , v.parent_entity_name
;  , v.parent_entity_id
;  , v.parent_entity_name2
;  , v.parent_entity_id2
;, v.*
, Last_Update = v.updt_dt_tm
, last_Update_By = pr2.name_full_formatted
 
from
  br_datamart_category bdc
  , br_datamart_report b
  , br_datamart_report_filter_r r
  , br_datamart_filter bdf
  , br_datamart_value v
  , br_datamart_flex f
  , br_datamart_flex f_parent
  , code_value vcv
  , nomenclature n
  , dcp_forms_ref d
  , alt_sel_cat alc
  , mltm_drug_categories mdc
  , cr_report_template crt
  , br_event_grouper breg
  , order_catalog_synonym ocs
  , pathway_catalog pc
  , dms_content_type dct
  , mltm_alr_category mac
  , prsnl pr
  , br_ccn brc
  , br_hco bh
  , person per
  , working_view wv
  , hm_expect_sat hes
  , oe_field_meaning ofm
  , v500_event_set_code ves
  , prsnl pr2
plan bdc
  where bdc.layout_flag in(0,1,3,4)
  and bdc.category_type_flag = 1
;  and bdc.category_name = "Oncology Ambulatory Workflow"
;  and bdc.category_mean = "VB_GENERALSURGPROVIDERHANDOFF" ;"[VIEW IDENTIFIER]" ;;;;          &lt;-----          this is where you put MPage Identifier.
;  and bdc.category_mean like "*GEN*"
join b
  where b.br_datamart_category_id = bdc.br_datamart_category_id
;  and b.report_name like "Scales and Assessments" ;"Consolidated Problems" ;"Problem List"     ;;;;;;; &lt;----- Component name goes here
;  and b.report_name like "*Custom Component*" ;
join r
  where r.br_datamart_report_id = b.br_datamart_report_id
join bdf
  where bdf.br_datamart_filter_id = outerjoin(r.br_datamart_filter_id)
;  and bdf.filter_display in ("Score event set selection")
;  and bdf.filter_display in ("Custom Component * Namespace")
;  and bdf.filter_display in ("Chart*earch" )    ;;;;; &lt;----- Filter name goes here, e.g. "Confirmation applied to diagnosis"
join v
  where v.br_datamart_filter_id = outerjoin(bdf.br_datamart_filter_id)
  ;and v.mpage_param_mean = "mp_label"
;  and v.mpage_param_value in ("Lines/Tubes/Drains*") ;"[Component Label name]"
;  and v.freetext_desc in ("*DME*","*Durable Medical Equipment*") ;("mp_wlfw_custom_column_pcaution")
;;  and v.parent_entity_id in (2870727415) ;Incision, Wound Pressure Ulcer Stage
;  and v.updt_id = outerjoin(49254860.00) ;
join f
  where f.br_datamart_flex_id = outerjoin(v.br_datamart_flex_id)
  and f.br_datamart_flex_id &gt; outerjoin(0.00)
join f_parent
  where f_parent.br_datamart_flex_id = outerjoin(f.grouper_flex_id)
  and f_parent.br_datamart_flex_id &gt; outerjoin(0.00)
join vcv
  where vcv.code_value = outerjoin(v.parent_entity_id)
  and vcv.active_ind = outerjoin(1)
;  and vcv.display = outerjoin("mp_wlfw_custom_column_pcaution")
join n
  where n.nomenclature_id = outerjoin(v.parent_entity_id)
join d
  where d.dcp_forms_ref_id = outerjoin(v.parent_entity_id)
;  and d.definition in ("Folstein's MMSE*", "Instrumental*", "Insomnia*")
join alc
  where alc.alt_sel_category_id = outerjoin(v.parent_entity_id)
join mdc
  where mdc.multum_category_id = outerjoin(v.parent_entity_id)
join crt
  where crt.report_template_id = outerjoin(v.parent_entity_id)
join breg
  where breg.br_event_grouper_id = outerjoin(v.parent_entity_id)
join ocs
  where ocs.synonym_id = outerjoin(v.parent_entity_id)
join pc
  where pc.pathway_catalog_id = outerjoin(v.parent_entity_id)
join dct
  where dct.dms_content_type_id = outerjoin(v.parent_entity_id)
join mac
  where mac.alr_category_id = outerjoin(v.parent_entity_id)
join pr
  where pr.person_id = outerjoin(v.parent_entity_id)
join brc
  where brc.br_ccn_id = outerjoin(v.parent_entity_id)
join bh
  where bh.br_hco_id = outerjoin(v.parent_entity_id)
join per
  where per.person_id = outerjoin(v.parent_entity_id)
join wv
  where wv.working_view_id = outerjoin(v.parent_entity_id)
join hes
  where hes.expect_sat_id = outerjoin(v.parent_entity_id)
join ofm
  where ofm.oe_field_meaning_id = outerjoin(v.parent_entity_id)
join ves
  where ves.event_set_cd = outerjoin(v.parent_entity_id) ;DTA or Selected Primitive Event Set in Bedrock
;  where ves.event_set_cd = outerjoin(v.parent_entity_id) ;DTA or Selected Primitive Event Set in Bedrock
;  and ves.event_set_cd_definition in (
;  	"*Blood*Unit*A*"
;  	"EVENT_SET_CD_DEFINITION",
;	"Endotracheal Tube Comment:",
;	"Endotracheal Tube Insertion Date/Time:",
;	"Endotracheal Tube Pt Indicated Response:",
;	"Endotracheal Tube Today's Date/Time:",
;	"Pharyngeal Airway Activity:",
;	"Pharyngeal Airway Comment:",
;	"Pharyngeal Airway Days:",
;	"Pharyngeal Airway Insertion Date/Time:",
;	"Pharyngeal Airway Pt Indicated Response:",
;	"Pharyngeal Airway Today's Date/Time:",
;	"Pharyngeal Intubat/Extubat Assist Units:",
;	"Pharyngeal Pt, Intubated,  General Unit:",
;	"Tracheostomy Bedside Nurse Contacted:",
;	"Tracheostomy Tube Activity Performed By:",
;	"Tracheostomy Tube Activity:",
;	"Tracheostomy Tube Comments:",
;	"Tracheostomy Tube Days:",
;	"Tracheostomy Tube Insertion Date/Time:",
;	"Tracheostomy Tube Pt Indicated Response:",
;	"Tracheostomy Tube Today's Date/Time:"
;  )
;  and ves.event_set_cd in (
;
; 			 2870734343.00	 ;	Respiratory Symptoms
;		,	 2870734363.00	 ;	Suction Method
;		,	 1586514368.00	 ;	Suction Tolerance
;
;;  			 2870719113.00	 ;	Head of Bed Position
;;		,	 2870719111.00	 ;	Patient Position
;;
;;  			 2325021291.00	 ;	Chest Tube Days:
;;		,	 2325021289.00	 ;	Chest Tube Insertion Date/Time:
;;		,	 5011114811.00	 ;	Chest Tube Signs of Infection:
;;		,	 2325021290.00	 ;	Chest Tube Today's DateTime:
;;		,	 5011114803.00	 ;	Chest Tube Water Seal Centimeters:
;;		,	 2421491705.00	 ;	Chest Tube Laterality:
;;		,	 2421491706.00	 ;	Chest Tube Location Descriptors:
;;		,	 2421491704.00	 ;	Chest Tube Type:
;
;;		  	 2325019260.00	 ;	Endotracheal Tube Comment:
;;		,	 2325019255.00	 ;	Endotracheal Tube Insertion Date/Time:
;;		,	 5011115235.00	 ;	Endotracheal Tube Pt Indicated Response:
;;		,	 2325019256.00	 ;	Endotracheal Tube Today's Date/Time:
;;		,	 2325019279.00	 ;	Pharyngeal Airway Activity:
;;		,	 2325019285.00	 ;	Pharyngeal Airway Comment:
;;		,	 2325019282.00	 ;	Pharyngeal Airway Days:
;;		,	 2325019280.00	 ;	Pharyngeal Airway Insertion Date/Time:
;;		,	 5011115267.00	 ;	Pharyngeal Airway Pt Indicated Response:
;;		,	 2325019281.00	 ;	Pharyngeal Airway Today's Date/Time:
;;		,	 5011115265.00	 ;	Pharyngeal Intubat/Extubat Assist Units:
;;		,	 5011115263.00	 ;	Pharyngeal Pt, Intubated,  General Unit:
;;		,	 5011115251.00	 ;	Tracheostomy Bedside Nurse Contacted:
;;		,	 5011115257.00	 ;	Tracheostomy Tube Activity Performed By:
;;		,	 2325019272.00	 ;	Tracheostomy Tube Activity:
;;		,	 2325019275.00	 ;	Tracheostomy Tube Comments:
;;		,	 2325019271.00	 ;	Tracheostomy Tube Days:
;;		,	 2325019269.00	 ;	Tracheostomy Tube Insertion Date/Time:
;;		,	 5011115253.00	 ;	Tracheostomy Tube Pt Indicated Response:
;;		,	 2325019270.00	 ;	Tracheostomy Tube Today's Date/Time:
;	)
join pr2
  where pr2.person_id = outerjoin(v.updt_id)
  and pr2.active_ind = 1
 
; 4223272445.00	Oxygen Therapy
; 2870731617.00	Oxygen Therapy
;and ves.event_set_cd = 2870719189.00	;Numeric Rating Score
; 4267024529.00	Body Fat %;
; 6387701091.00	Last Dental Visit
; 3007830281.00	Date of Last Pap Smear
; 2517077427.00	Fall Risk
; 3995388041.00	Have You Fallen in the Past Year?, Fall Risk Past Year (DEFINITION)
; 2800676451.00	Fall Risk Score, Fall Score (DEFINITION)
; 5833737745.00	Home Diet.
; 3172609853.00	Last 6 mos, Lost Weight Without Trying
; 5859240943.00	Muscle Pain
; 3995388385.00	Number of Falls
; 5833737743.00	Nutritional Risk Factors
; 3172616431.00	Total Nutrition Score
; 3505853609.00	Vital(s) Exclusion Reason
; 3789209055.00	Within One Year Postpartum
; 2870726003.00	Nutrition Risk Factors
;  100255430.00	EDC
; 2870719187.00	Numeric Rating, Numberic Rating Pain Scale (DEFINITION)
; 2870719189.00	Numeric Rating Score, Numberic Rating Pain Score (DEFINITION)
;  385380056.00	Mean BP
 
;CODE_VALUE		DISPLAY		DESCRIPTION				DISPLAY_KEY		DEFINITION
;2870720405.00	Laterality	Primary Pain Laterality	LATERALITY		Primary Pain Laterality
;CODE_VALUE		DISPLAY		DESCRIPTION				DISPLAY_KEY		DEFINITION
;2870720403.00	Location	Primary Pain Location	LOCATION		Primary Pain Location
;  and ves.event_set_cd in ( 2870727415.00 ) ;Incision, Wound Pressure Ulcer Stage:	INCISIONWOUNDPRESSUREULCERSTAGE		Incision, Wound Pressure Ulcer Stage:
 
order by
  mpage
  , ves.event_set_cd_definition
  , component
  , filter
  , flex_position
;  , flex_location
  , combined_filter_value
 
WITH  UAR_CODE(D), FORMAT(DATE,""), TIME=60
;
;
;Solution script to run with DBA:
;test or validation query script
select v2.br_datamart_value_id
, mpage = c.category_name
, component = f.filter_mean
, component_label = v2.mpage_param_value
, updated = f.updt_dt_tm "@SHORTDATETIME"
;, dm_value_dt = v2.updt_dt_tm "@SHORTDATETIME"
, updated_by = p.name_full_formatted
;,f.*
;, "************"
;, v2.*
from br_datamart_filter f
, br_datamart_value v2
, br_datamart_category c
, prsnl p
where f.filter_mean like "CUSTOM_COMP_*"
;and f.filter_display in ("Custom Component*section layout parameters") ;change if needed
and f.filter_category_mean = "MP_SECT_PARAMS"
and v2.br_datamart_filter_id = f.br_datamart_filter_id
and v2.end_effective_dt_tm &gt;= cnvtdatetime(curdate,curtime)
and v2.mpage_param_mean = "mp_label"
and v2.mpage_param_value in ("Directives*Legal") ;affected value or component lable
and c.br_datamart_category_id = f.br_datamart_category_id
and c.category_type_flag = 1
;and c.category_name not in ("zzz*") ;make change this if needed
and p.person_id = outerjoin(v2.updt_id)
order by f.updt_dt_tm desc, v2.updt_dt_tm desc
WITH UAR_CODE(D), FORMAT(DATE,";;Q"), TIME=60
 
/** TASK0908411: Advance Directives custom component updates  **/
update into br_datamart_value v
set
v.mpage_param_value = "Advance Directives" ; change to
v.updt_dt_tm = cnvtdatetime(curdate,curtime),
v.updt_id = REQINFO-&gt;UPDT_ID, ; insert your PERSON_ID here
v.updt_cnt = updt_cnt +1
where v.br_datamart_value_id
in (
	select v2.br_datamart_value_id
	from br_datamart_filter f, br_datamart_value v2
	where f.filter_display in ("Custom Component*section layout parameters")
	and f.filter_mean like "CUSTOM_COMP_*"
	and f.filter_category_mean = "MP_SECT_PARAMS"
	and v2.br_datamart_filter_id = f.br_datamart_filter_id
	and v2.end_effective_dt_tm &gt;= cnvtdatetime(curdate,curtime)
	and v2.mpage_param_mean = "mp_label"
	and v2.mpage_param_value in ("Directives*Legal") ; change from
)
commit
go;
/** end of TASK0908411: Advance Directives custom component updates  **/
 
/** CHG0135743/INC2684390: revert back CCL - 1bh_mpage_setChartSearch  **/
update into br_datamart_value bdv
set
;bdv.freetext_desc= "0",
bdv.freetext_desc= "1", ;Revert back
bdv.updt_dt_tm = cnvtdatetime(curdate,curtime),
bdv.updt_id = REQINFO-&gt;UPDT_ID, ; insert your PERSON_ID here
bdv.updt_cnt = updt_cnt +1
where bdv.br_datamart_value_id
in
(
select v.br_datamart_value_id
from br_datamart_filter f, br_datamart_value v
where f.filter_mean = "CHART_SEARCH"
and v.br_datamart_filter_id = f.br_datamart_filter_id
;and v. freetext_desc = "1"
and v. freetext_desc = "0"
and v.updt_id in ( 49254860.00 );Saiz, Marcelino
and v.updt_dt_tm = cnvtdatetime("17-MAY-2021 1159")
)
commit
/** CHG0135743/INC2684390: revert back CCL - 1bh_mpage_setChartSearch  **/
 
 
 
 
; RITM0699882- AZURE Story 86247 Allow for Long haul adhoc forms to pull into the office note under scales and assessments
select distinct
;  v.br_datamart_value_id
  mpage = bdc.category_name
  , ves.event_set_cd_definition
  , ves.event_set_name
  , component = b.report_name
  , REPORTID = b.br_datamart_report_id
  , filter = bdf.filter_display
  , flex_position = evaluate2(
      if(nullind(f.br_datamart_flex_id) = 0)
        if(f.parent_entity_type_flag = 1)
         uar_get_code_display(f.parent_entity_id)
        elseif(f.parent_entity_type_flag = 2)
         uar_get_code_display(f_parent.parent_entity_id)
        endif
      else
         "Default"
      endif
    )
  , flex_location = evaluate2(
      if(nullind(f_parent.br_datamart_flex_id) = 0)
        uar_get_code_display(f.parent_entity_id)
      elseif(f.parent_entity_type_flag = 1)
       "All Facilities"
      else
       "Default"
      endif
    )
  , combined_filter_value = trim(build2((evaluate2(
      if(nullcheck(v.freetext_desc,"TRUE",NULLIND(v.freetext_desc)) &gt; " ")
        if(v.parent_entity_id = 0.00 and v.freetext_desc = "1")
          "Yes"
        elseif(v.parent_entity_id = 0.00 and v.freetext_desc = "0")
          "No"
        elseif(v.parent_entity_name = "CODE_VALUE")
          if(v.parent_entity_id = vcv.code_value and vcv.code_set = 93)
           trim(ves.event_set_cd_disp)
;           build2("L36 - ",trim(ves.event_set_cd_disp))
          else
;           trim(v.freetext_desc)
			build2("L39 - ",(trim(v.freetext_desc)))
          endif
        else
;          trim(v.freetext_desc)
          build2("L43 - ",(trim(v.freetext_desc)))
        endif
      elseif(cnvtupper(v.mpage_param_mean) in ("MP_LOOK_BACK_UNITS","MP_LOOK_BACK_CUR_ENC"))
        if(nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) &gt; " ")
          if(v.value_type_flag = 1)
            build2("L48 All encounters - Specified time period: ",(trim(v.mpage_param_value)))
          elseif(v.value_type_flag = 2)
            build2("L50 Current encounter only - Specified time period: ",(trim(v.mpage_param_value)))
          endif
        else
          if(v.value_type_flag = 1)
            "All encounters"
          elseif(v.value_type_flag = 2)
            "Current encounter only"
          endif
        endif
      elseif(nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) &gt; " ")
       trim(v.mpage_param_value)
      elseif(v.parent_entity_name = "NOMENCLATURE")
       trim(n.source_string)
      elseif(v.parent_entity_name = "CODE_VALUE")
        if(vcv.code_set = 93)
          trim(ves.event_set_cd_disp)
;          build2("L66 - ",(trim(ves.event_set_cd_disp)))
        else
;          trim(vcv.display)
          build2("L69 - ",(trim(vcv.display)))
        endif
      elseif(v.parent_entity_name = "DCP_FORMS_REF")
       trim(d.definition)
;       build2("L73 - ",(trim(d.definition)))
      elseif(v.parent_entity_name = "ALT_SEL_CAT")
       trim(alc.long_description)
      elseif(v.parent_entity_name = "MLTM_DRUG_CATEGORIES")
       trim(mdc.category_name)
      elseif(v.parent_entity_name = "cr_report_template")
       trim(crt.template_name)
      elseif(v.parent_entity_name = "BR_EVENT_GROUPER")
       trim(breg.grouper_name)
      elseif(v.parent_entity_name = "ORDER_CATALOG_SYNONYM")
       trim(ocs.mnemonic)
      elseif(v.parent_entity_name = "PATHWAY_CATALOG")
       trim(pc.description)
      elseif(v.parent_entity_name = "DMS_CONTENT_TYPE")
       trim(dct.display)
      elseif(v.parent_entity_name = "MLTM_ALR_CATEGORY")
       trim(mac.category_description)
      elseif(v.parent_entity_name = "PRSNL")
       trim(pr.name_full_formatted)
      elseif(v.parent_entity_name = "BR_CCN")
       trim(brc.ccn_name)
      elseif(v.parent_entity_name = "BR_HCO")
       trim(bh.hco_name)
      elseif(v.parent_entity_name = "PERSON")
       trim(per.name_full_formatted)
      elseif(v.parent_entity_name = "WORKING_VIEW")
       trim(wv.display_name)
      elseif(v.parent_entity_name = "HM_EXPECT_SAT")
       trim(hes.expect_sat_name)
      elseif(v.parent_entity_name = "OE_FIELD_MEANING")
       trim(ofm.oe_field_meaning)
      elseif(nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) = " ")
        if(cnvtupper(v.mpage_param_mean) in ("MP_LOOK_BACK_UNITS","MP_LOOK_BACK_CUR_ENC"))
          if(v.value_type_flag = 1)
            "All encounters"
          elseif(v.value_type_flag = 2)
            "Current encounter only"
          endif
        endif
      endif))
  , (evaluate2(
     if(((nullcheck(v.freetext_desc,"TRUE",NULLIND(v.freetext_desc)) &gt; " ")
          or
          (nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) &gt; " "))
        and v.parent_entity_name = "CODE_VALUE"
        and v.parent_entity_id = vcv.code_value
        and vcv.code_set = 54)
        " "
      else
        ""
       endif))
  , (evaluate2(
     if(((nullcheck(v.freetext_desc,"TRUE",NULLIND(v.freetext_desc)) &gt; " ")
          or
          (nullcheck(v.mpage_param_value,"TRUE",NULLIND(v.mpage_param_value)) &gt; " "))
        and v.parent_entity_name = "CODE_VALUE"
        and v.parent_entity_id = vcv.code_value
        and vcv.code_set = 54)
;        trim(vcv.display)
        build2("L132 - ",(trim(vcv.display)))
      else
        ""
       endif))
   ))
;  , v.freetext_desc
;  , v.mpage_param_value
;  , v.mpage_param_mean
;  , v.parent_entity_name
;  , v.parent_entity_id
;  , v.parent_entity_name2
;  , v.parent_entity_id2
;, bdc.*
, Last_Update = v.updt_dt_tm
, last_Update_By = pr2.name_full_formatted
 
from
  br_datamart_category bdc
  , br_datamart_report b
  , br_datamart_report_filter_r r
  , br_datamart_filter bdf
  , br_datamart_value v
  , br_datamart_flex f
  , br_datamart_flex f_parent
  , code_value vcv
  , nomenclature n
  , dcp_forms_ref d
  , alt_sel_cat alc
  , mltm_drug_categories mdc
  , cr_report_template crt
  , br_event_grouper breg
  , order_catalog_synonym ocs
  , pathway_catalog pc
  , dms_content_type dct
  , mltm_alr_category mac
  , prsnl pr
  , br_ccn brc
  , br_hco bh
  , person per
  , working_view wv
  , hm_expect_sat hes
  , oe_field_meaning ofm
  , v500_event_set_code ves
  , prsnl pr2
plan bdc
  where bdc.layout_flag in(0,1,3,4)
  and bdc.category_type_flag = 1
;  and bdc.category_mean LIKE "VB_PRIM*" ;"[VIEW IDENTIFIER]" ;;;;          &lt;-----          this is where you put MPage Identifier.
;  and bdc.category_name LIKE "Primary Care Amb Workflow"
;  and bdc.category_mean like "PRIM*"
join b
  where b.br_datamart_category_id = bdc.br_datamart_category_id
;  and b.report_name = "Workflow MPage-level Settings" ;"Scales and Assessments" ;"Consolidated Problems" ;"Problem List"     ;;;;;;; &lt;----- Component name goes here
join r
  where r.br_datamart_report_id = b.br_datamart_report_id
join bdf
  where bdf.br_datamart_filter_id = outerjoin(r.br_datamart_filter_id)
;  and bdf.filter_display in ("Note Type/Dynamic Doc Template Associations" )    ;;;;; &lt;----- Filter name goes here, e.g. "Confirmation applied to diagnosis"
join v
  where v.br_datamart_filter_id = outerjoin(bdf.br_datamart_filter_id)
;  and v.freetext_desc in ("*Blood Unit Activities*")
  ;and v.mpage_param_mean = "mp_label"
  ;and v.mpage_param_value = "[Component Label name]"
;  and v.parent_entity_id in (3505903005) ;i.e. event_set_cd - Blood Unit Activities
;  and v.updt_id = outerjoin(49254860.00) ;
join f
  where f.br_datamart_flex_id = outerjoin(v.br_datamart_flex_id)
  and f.br_datamart_flex_id &gt; outerjoin(0.00)
join f_parent
  where f_parent.br_datamart_flex_id = outerjoin(f.grouper_flex_id)
  and f_parent.br_datamart_flex_id &gt; outerjoin(0.00)
join vcv
  where vcv.code_value = outerjoin(v.parent_entity_id)
  and vcv.active_ind = outerjoin(1)
join n
  where n.nomenclature_id = outerjoin(v.parent_entity_id)
join d
  where d.dcp_forms_ref_id = outerjoin(v.parent_entity_id)
;  and d.definition in ("Folstein's MMSE*", "Instrumental*", "Insomnia*")
join alc
  where alc.alt_sel_category_id = outerjoin(v.parent_entity_id)
join mdc
  where mdc.multum_category_id = outerjoin(v.parent_entity_id)
join crt
  where crt.report_template_id = outerjoin(v.parent_entity_id)
join breg
  where breg.br_event_grouper_id = outerjoin(v.parent_entity_id)
join ocs
  where ocs.synonym_id = outerjoin(v.parent_entity_id)
join pc
  where pc.pathway_catalog_id = outerjoin(v.parent_entity_id)
join dct
  where dct.dms_content_type_id = outerjoin(v.parent_entity_id)
join mac
  where mac.alr_category_id = outerjoin(v.parent_entity_id)
join pr
  where pr.person_id = outerjoin(v.parent_entity_id)
join brc
  where brc.br_ccn_id = outerjoin(v.parent_entity_id)
join bh
  where bh.br_hco_id = outerjoin(v.parent_entity_id)
join per
  where per.person_id = outerjoin(v.parent_entity_id)
join wv
  where wv.working_view_id = outerjoin(v.parent_entity_id)
join hes
  where hes.expect_sat_id = outerjoin(v.parent_entity_id)
join ofm
  where ofm.oe_field_meaning_id = outerjoin(v.parent_entity_id)
join ves
  where ves.event_set_cd = outerjoin(v.parent_entity_id) ;DTA or Selected Primitive Event Set in Bedrock
;  and ves.event_set_cd = 3505903005 ;outerjoin(v.parent_entity_id) ;DTA or Selected Primitive Event Set in Bedrock
  and ves.event_set_cd_definition in (
  	"*[+DTA+]*"
;  	"EVENT_SET_CD_DEFINITION",
;	"Endotracheal Tube Comment:",
;	"Endotracheal Tube Insertion Date/Time:",
;	"Endotracheal Tube Pt Indicated Response:",
;	"Endotracheal Tube Today's Date/Time:",
;	"Pharyngeal Airway Activity:",
;	"Pharyngeal Airway Comment:",
;	"Pharyngeal Airway Days:",
;	"Pharyngeal Airway Insertion Date/Time:",
;	"Pharyngeal Airway Pt Indicated Response:",
;	"Pharyngeal Airway Today's Date/Time:",
;	"Pharyngeal Intubat/Extubat Assist Units:",
;	"Pharyngeal Pt, Intubated,  General Unit:",
;	"Tracheostomy Bedside Nurse Contacted:",
;	"Tracheostomy Tube Activity Performed By:",
;	"Tracheostomy Tube Activity:",
;	"Tracheostomy Tube Comments:",
;	"Tracheostomy Tube Days:",
;	"Tracheostomy Tube Insertion Date/Time:",
;	"Tracheostomy Tube Pt Indicated Response:",
;	"Tracheostomy Tube Today's Date/Time:"
;  )
;  and ves.event_set_cd in ( 3505903005.00
;
;		  	 2870734343.00	 ;	Respiratory Symptoms
;		,	 2870734363.00	 ;	Suction Method
;		,	 1586514368.00	 ;	Suction Tolerance
;
;  		,	 2870719113.00	 ;	Head of Bed Position
;		,	 2870719111.00	 ;	Patient Position
;
;  		,	 2325021291.00	 ;	Chest Tube Days:
;		,	 2325021289.00	 ;	Chest Tube Insertion Date/Time:
;		,	 5011114811.00	 ;	Chest Tube Signs of Infection:
;		,	 2325021290.00	 ;	Chest Tube Today's DateTime:
;		,	 5011114803.00	 ;	Chest Tube Water Seal Centimeters:
;		,	 2421491705.00	 ;	Chest Tube Laterality:
;		,	 2421491706.00	 ;	Chest Tube Location Descriptors:
;		,	 2421491704.00	 ;	Chest Tube Type:
;
;
;;		  	 2325019260.00	 ;	Endotracheal Tube Comment:
;;		,	 2325019255.00	 ;	Endotracheal Tube Insertion Date/Time:
;;		,	 5011115235.00	 ;	Endotracheal Tube Pt Indicated Response:
;;		,	 2325019256.00	 ;	Endotracheal Tube Today's Date/Time:
;;		,	 2325019279.00	 ;	Pharyngeal Airway Activity:
;;		,	 2325019285.00	 ;	Pharyngeal Airway Comment:
;;		,	 2325019282.00	 ;	Pharyngeal Airway Days:
;;		,	 2325019280.00	 ;	Pharyngeal Airway Insertion Date/Time:
;;		,	 5011115267.00	 ;	Pharyngeal Airway Pt Indicated Response:
;;		,	 2325019281.00	 ;	Pharyngeal Airway Today's Date/Time:
;;		,	 5011115265.00	 ;	Pharyngeal Intubat/Extubat Assist Units:
;;		,	 5011115263.00	 ;	Pharyngeal Pt, Intubated,  General Unit:
;;		,	 5011115251.00	 ;	Tracheostomy Bedside Nurse Contacted:
;;		,	 5011115257.00	 ;	Tracheostomy Tube Activity Performed By:
;;		,	 2325019272.00	 ;	Tracheostomy Tube Activity:
;;		,	 2325019275.00	 ;	Tracheostomy Tube Comments:
;;		,	 2325019271.00	 ;	Tracheostomy Tube Days:
;;		,	 2325019269.00	 ;	Tracheostomy Tube Insertion Date/Time:
;;		,	 5011115253.00	 ;	Tracheostomy Tube Pt Indicated Response:
;;		,	 2325019270.00	 ;	Tracheostomy Tube Today's Date/Time:
	)
join pr2
  where pr2.person_id = outerjoin(v.updt_id)
  and pr2.active_ind = 1
 
; 4223272445.00	Oxygen Therapy
; 2870731617.00	Oxygen Therapy
;and ves.event_set_cd = 2870719189.00	;Numeric Rating Score
; 4267024529.00	Body Fat %;
; 6387701091.00	Last Dental Visit
; 3007830281.00	Date of Last Pap Smear
; 2517077427.00	Fall Risk
; 3995388041.00	Have You Fallen in the Past Year?, Fall Risk Past Year (DEFINITION)
; 2800676451.00	Fall Risk Score, Fall Score (DEFINITION)
; 5833737745.00	Home Diet.
; 3172609853.00	Last 6 mos, Lost Weight Without Trying
; 5859240943.00	Muscle Pain
; 3995388385.00	Number of Falls
; 5833737743.00	Nutritional Risk Factors
; 3172616431.00	Total Nutrition Score
; 3505853609.00	Vital(s) Exclusion Reason
; 3789209055.00	Within One Year Postpartum
; 2870726003.00	Nutrition Risk Factors
;  100255430.00	EDC
; 2870719187.00	Numeric Rating, Numberic Rating Pain Scale (DEFINITION)
; 2870719189.00	Numeric Rating Score, Numberic Rating Pain Score (DEFINITION)
;  385380056.00	Mean BP
 
;CODE_VALUE		DISPLAY		DESCRIPTION				DISPLAY_KEY		DEFINITION
;2870720405.00	Laterality	Primary Pain Laterality	LATERALITY		Primary Pain Laterality
;CODE_VALUE		DISPLAY		DESCRIPTION				DISPLAY_KEY		DEFINITION
;2870720403.00	Location	Primary Pain Location	LOCATION		Primary Pain Location
;  and ves.event_set_cd in ( 2870727415.00 ) ;Incision, Wound Pressure Ulcer Stage:	INCISIONWOUNDPRESSUREULCERSTAGE		Incision, Wound Pressure Ulcer Stage:
 
order by
  ves.event_set_cd_definition
;  , component
  , filter
  , flex_position
;  , flex_location
  , combined_filter_value
 
WITH  UAR_CODE(D), FORMAT(DATE,""), TIME=60
 </Template><Template Name="mpt_findListDTAsInAvailableFilter" Description="List DTAs in Available Filters">select
  DISTINCT
 	mPage_Name=bdc.category_name
, 	bdc.category_mean 
, 	bdf.filter_mean 
, 	bdf.filter_display
, 	bdv.br_datamart_filter_id
, 	WRONG_DTA = bdv.freetext_desc
, 	CORRECT_DTA = uar_get_code_display(bdv.parent_entity_id) 
from 
BR_DATAMART_CATEGORY BDC
, br_datamart_value bdv
, br_datamart_filter bdf 
where 
bdc.br_datamart_category_id = bdv.br_datamart_category_id 
and 
bdf.br_datamart_filter_id = bdv.br_datamart_filter_id 
and 
bdf.filter_display like "[+Name of available filter*+]" ; Ex. "Generic Events Column 1 Sequence*" 
and 
bdc.category_name = "[+Neme of mPage+]" ; Ex. "CV19 Hospitalist Worklist" 
order by bdv.freetext_desc, bdc.category_name, bdc.layout_flag   

Get filter_id from query above. What is the [+filter_id+] 
To get the necessary information from the log file, run Bedrock with Control + Shift + I and reproduce the error. 
Open the log file and look for the name of the filter that is producing the error. 
You should see the br_datamart_filter_id a few lines above the filter name.

select
    	br_datamart_value_id
   	,freetext_desc
   	,sequence_order = value_seq
   	,code_value = parent_entity_id
   	,cv_display = uar_get_code_display(parent_entity_id)
   	,br_datamart_filter_id
   	,br_datamart_category_id
   	,parent_entity_name
   	;,* 	
from
  		br_datamart_value
  	where
  		br_datamart_filter_id = [+filter_id+]

Make a copy of the data before deleting it. 
After running the delete statement cycle server 535 then update the filter.

delete 
  	from br_datamart_value 
where br_datamart_filter_id = [+filter_id+] 
go
commit go 
^
</Template><Template Name="mpt_findmPageDisplayName" Description="Find mPage Display Name">mPage display name: [+mPage Display Name+] ;eg. Discharge Summary, EMR Migration, ICU Graph 
select  DISTINCT INTO "NL:"
	mPage_Name=bdc.category_name,
	mPage_Layout =
if (bdc.layout_flag = 0 )	"Summary"
elseif(bdc.layout_flag = 1)	"Workflow"
elseif(bdc.layout_flag = 2)	"Smart Template"
elseif(bdc.layout_flag = 3)	"Quick Orders and Charges"
elseif(bdc.layout_flag = 4)	"Patient Organizer View"
elseif(bdc.layout_flag = 5)	"Dashboard"
elseif(bdc.layout_flag = 6)	"Organizer View - Provider"
elseif(bdc.layout_flag = 7)	"Emergent Event"
elseif(bdc.layout_flag = 8)	"SCM Purchase Order Organizer"
elseif(bdc.layout_flag = 9)	"SCM Inventory Management Organizer" endif,
	bdc.category_mean ,
	bdv.mpage_param_value,
	bdv.freetext_desc,
	bdf.filter_mean ,
	bdf.filter_seq,
	bdc.layout_flag,
	;bdc.*
	;bdv.*
	bdf.*
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdv.freetext_desc = "[+mPage Display Name+]"
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_mean = "VIEWPOINT_LABEL"
order by bdc.category_name, bdc.layout_flag
^</Template><Template Name="mpt_findmPageVersion" Description="Find mPage Version">select group = mg.group_ident
, mg.description
, version = mg.version_txt
, update_on = mg.updt_dt_tm "@SHORTDATETIME"
;, updated_by = p.name_full_formatted
, mg.mp_release_id
;, mg.*
from mp_group mg;, prsnl p
where mg.mp_release_id &gt; 0
and mg.group_ident like "MPAGE_*"
;and p.person_id = outerjoin(mg.updt_id)
order by mg.mp_release_id desc, mg.updt_dt_tm desc
with uar_code(d), format(date,";;q"), time=120, maxrec=2

OR

https://distributions.cerner.com/package-dashboard.asp
^</Template><Template Name="mpt_findmPageViewPoints" Description="mPage Viewpoint Audit">;Viewpoint Audit
select; into $outdev
viewpoint_name = cnvtupper (m.viewpoint_name ) ,
view_name = cnvtupper (c.category_name ),
Blackbird_Line_5 = c.category_mean
from (mp_viewpoint m ) ,
(mp_viewpoint_reltn r ) ,
(br_datamart_category c )
plan (m
where (m.active_ind = 1 ) )
and (r
where (r.mp_viewpoint_id = m.mp_viewpoint_id ) )
and (c
where (c.br_datamart_category_id = r.br_datamart_category_id ) )
order by viewpoint_name ,
view_name

</Template><Template Name="mpt_findMRNFIN" Description="Find MRN and FIN from encntr_id">select 
	ea.encntr_id
	, fin=concat(trim(cnvtstring(ea.alias),3),".00")
	, mrn=concat(trim(cnvtstring(ea1.alias),3),".00")
	;, alias_type=uar_get_code_display(ea1.encntr_alias_type_cd) 
from 
	encntr_alias ea
	,encntr_alias ea1 
	;,person p
plan ea where 
	ea.encntr_id in (
	[+encntr_id+]
	)
and
	ea.encntr_alias_type_cd in (1077.00);FIN
join ea1 where ea.encntr_id = ea1.encntr_id
and
	ea1.encntr_alias_type_cd in (1079.00);MRN
^
</Template><Template Name="mpt_findNameSpace" Description="Find NameSpace, custom worklist, and custom components">;Find mPages using a "banner." namespace
select
	mPage_name = bdc.category_name; mPage_name
	, Component_Name = bdf.filter_mean; , bdf.filter_display;
	, Namespace = bdv.freetext_desc; banner.namespace
	, View_Builder_Name = bdc.category_mean; view_builder_name
from
	BR_DATAMART_VALUE bdv;BR_DATAMART_VALUE_ID (PK)
	, BR_DATAMART_CATEGORY   BDC
	, br_datamart_filter bdf
plan bdv where bdv.freetext_desc like "banner.[+NameSpace+]"
join bdc where bdc.br_datamart_category_id = bdv.br_datamart_category_id
join bdf where bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
order by mpage_name

;------------------------------------------------------------------------------------
;This query will get all custom components and custom worklist columns in use:
;Source https://community.cerner.com/t5/MPages-Technical-Development/Search-for-MPages-that-use-a-namespace/m-p/1630446/emcs_t/S2h8ZW1haWx8dG9waWNfc3Vic2NyaXB0aW9ufEw3SjZOSjg1NjdWMzlWfDE2MzA0NDZ8U1VCU0NSSVBUSU9OU3xoSw
select 
  MPage=bdc.category_name,
  component=bdr.report_name,
  CCL_Or_Namespace_Entry=bdv.freetext_desc,
  bdf.filter_category_mean,
  bdf.filter_display
from
  br_datamart_filter bdf,
  br_datamart_value bdv,
  br_datamart_category bdc,
  br_datamart_report_filter_r bdrfr,
  br_datamart_report bdr
plan bdf
  where bdf.filter_category_mean = "LINK_ENTRY"
  and (
    (bdf.filter_mean = "*CUSTOM_COMP_PRG*")
    or
    (bdf.filter_mean = "CUSTOM_COLUMN_SCRIPT*")
  )
join bdv
  where bdv.br_datamart_filter_id = bdf.br_datamart_filter_id
  and bdv.br_datamart_flex_id = 0
join bdc
  where bdc.br_datamart_category_id = bdv.br_datamart_category_id
join bdrfr
  where bdrfr.br_datamart_filter_id = bdf.br_datamart_filter_id
join bdr
  where bdr.br_datamart_report_id = bdrfr.br_datamart_report_id
order by bdr.report_name, bdc.category_name
^</Template><Template Name="mpt_findPatientLocation" Description="Find patient location.">;Find patient location
select
p.name_full_formatted
,e.person_id
,e.encntr_id
,e.loc_facility_cd
,e.loc_building_cd
,e.loc_nurse_unit_cd
,e.loc_room_cd
,e.loc_bed_cd
,e.disch_dt_tm
,e.organization_id
,e.encntr_financial_id
from
	encounter e
	,person p
plan e
where
	e.encntr_id = [+Encntr_ID+]
join p where e.person_id = p.person_id
with uar_code(d), format(date,";;q")
^</Template><Template Name="mpt_findPerson_ID_from_FIN" Description="Find Person_ID from FIN.">;Find person_id from FIN#:
select 
ea.encntr_id
,e.person_id 
,p.name_full_formatted
,FIN=ea.alias
,MRN=ea1.alias
;,ea.*
,p.birth_dt_tm
,age = cnvtage(p.birth_dt_tm)
,race = uar_get_code_display(p.race_cd)

from 
	encntr_alias ea 
	,encounter e
	,person p
	,encntr_alias ea1

plan ea
where 
	ea.alias = "[+FIN_NUMBER+]" ; FIN#
join e
	where e.encntr_id = ea.encntr_id
join p
	where e.person_id = p.person_id
join ea1
	where ea.txn_id_text = ea1.txn_id_text
and
	ea1.encntr_alias_type_cd = 1079
with time=60, uar_code(d), format(date,";;q")
^</Template><Template Name="mpt_findPerson_ID_from_MRN" Description="Find person and encounter ID from MRN.">;Find person and encounter ID from MRN.
select 
ea.encntr_id
,e.person_id 
,p.name_full_formatted
,FIN=ea1.alias
,MRN=ea.alias
;,ea.*
,p.birth_dt_tm
,age = cnvtage(p.birth_dt_tm)
,race = uar_get_code_display(p.race_cd)
;,p.*

from 
	encntr_alias ea 
	,encounter e
	,person p
	,encntr_alias ea1

plan ea
where 
	ea.alias = "[+MRN_IDENTIFIER+]" ; MRN#
join e
	where e.encntr_id = ea.encntr_id
join p
	where e.person_id = p.person_id
join ea1
	where ea.txn_id_text = ea1.txn_id_text
and
	ea1.encntr_alias_type_cd = 1077
with time=60, uar_code(d), format(date,";;q")
^</Template><Template Name="mpt_findPowerForms" Description="Find Powerform ID">Find form id (form_id)
[+Form_Name+]
[+put_dcp_forms_ref_id_here+] 
[+Form_event_code+]

;If you know the name of the form:
select
distinct d.dcp_forms_ref_id
,d.description
,d.event_cd
from dcp_forms_ref d
where d.description like "[+Form_Name+]*" ;Form name.
or
d.dcp_forms_ref_id = [+put_dcp_forms_ref_id_here+] ;Form ID.
and active_ind = 1with maxrec=1, time=60

;Find the form and chart some data on it.
;Run the Clinical Event Quick Code and look for the form name. Usually has "PF" in the name.
;Get the ce.event_cd and plug it into d.event_cd below.
;This will show you the dcp_forms_ref_id from the dcp_forms_activity table.

select
	distinct dfr.dcp_forms_activity_id
	, form_dttm_res = FORMAT (dfr.form_dt_tm,  "mm/dd/yy hh:mm;;d")
	, dcp_forms_ref_id=trim(cnvtstring(dfr.dcp_forms_ref_id),3)
	, dfr.description
from
	dcp_forms_activity dfr
	, dcp_forms_ref d
plan dfr
where
	dfr.encntr_id = [+the_encntr_id+];
and
	dfr.person_id = [+the_encntr_id+];
;and
;	dfr.dcp_forms_ref_id = [+put_dcp_forms_ref_id_here+]
and
	dfr.form_status_cd not in(26.00,28.00, 29.00, 30.00, 31.00, 654643.00)
join d where d.dcp_forms_ref_id = dfr.dcp_forms_ref_id
and d.event_cd = [+Form_event_code+];
order by
	dfr.last_activity_dt_tm desc

;Plug the dcp_forms_ref_id into this js code.
var personid1 = this.getProperty("personId");
var encntrid1 = this.getProperty("encounterId");
var form = "&lt;a id='Add' class='add-plus' href='javascript:MPAGES_EVENT(\"POWERFORM\",\""+personid1+"|"+encntrid1+"|[+put_dcp_forms_ref_id_here+]|0|0\")'&gt;&lt;span class='add-icon'&gt; &lt;/span&gt;&lt;span class='add-text'&gt;Add&lt;/span&gt;&lt;/a&gt;";
MPage.getCustomComp(compid).setProperty("headerSubTitle",form);
^</Template><Template Name="mpt_findShow_components" Description="Show the components on mPage">;Show components on mPage:
SELECT ;into $OUTDEV
	mPage_Name = C.CATEGORY_NAME
	, mPage_Identifier = C.CATEGORY_MEAN
	, BR.REPORT_NAME
	,component_name=bdv.mpage_param_value
	;,bdv.*
 
FROM
	BR_DATAMART_CATEGORY   C
	, BR_DATAMART_REPORT   BR
	, BR_DATAMART_REPORT_FILTER_R   BFR
	, BR_DATAMART_FILTER   BF
	, BR_DATAMART_VALUE BDV
 
plan C where C.BR_DATAMART_CATEGORY_ID &gt; 0
;Comment both lines below to see all mPages:
	;and C.CATEGORY_MEAN = "[+VB_ZZZPRIMARYCAREWORKLFOWTEST+]" ;mPage Identifier
	and C.CATEGORY_NAME = "[+zzz Primary Care Worklfow Test+]" ;mPage Name
join  BR
WHERE BR.BR_DATAMART_CATEGORY_ID = c.br_datamart_category_id
join BFR
WHERE BFR.BR_DATAMART_REPORT_ID = BR.BR_DATAMART_REPORT_ID
join BF
WHERE BF.BR_DATAMART_FILTER_ID = BFR.BR_DATAMART_FILTER_ID
 AND BF.FILTER_CATEGORY_MEAN ="MP_SECT_PARAMS"
join bdv
where bf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdv.mpage_param_mean = "mp_label"
ORDER BY
	mPage_Name
	, BF.FILTER_SEQ
 
WITH NOCOUNTER, SEPARATOR=" ", FORMAT, time = 300</Template><Template Name="mpt_findViewPointsBymPageName" Description="Find Viewpoints by mPage name">;CHG0105345: Bedrock: An unexpected error has occurred. Please contact your system administrator and provide the log file. Bedrock Logging

;Find mPages with a specific filter listed in Bedrock (case-sensitive)
[+Available Filters+]; eg: "PowerForms to chart vitals", "Heart rate results", "Vital Signs chart launch indicator"
[+mPage Name+] (eg. "Oncology Nursing Handoff", "Oncology Ambulatory Workflow")

;Display mPages that have the [+Available Filters+] filter.
select  DISTINCT INTO "NL:"
	[+mPage Name+]=bdc.category_name,
	mPage_Layout =
if (bdc.layout_flag = 0 )	"Summary"
elseif(bdc.layout_flag = 1)	"Workflow"
elseif(bdc.layout_flag = 2)	"Smart Template"
elseif(bdc.layout_flag = 3)	"Quick Orders and Charges"
elseif(bdc.layout_flag = 4)	"Patient Organizer View"
elseif(bdc.layout_flag = 5)	"Dashboard"
elseif(bdc.layout_flag = 6)	"Organizer View - Provider"
elseif(bdc.layout_flag = 7)	"Emergent Event"
elseif(bdc.layout_flag = 8)	"SCM Purchase Order Organizer"
elseif(bdc.layout_flag = 9)	"SCM Inventory Management Organizer" endif,
	bdc.category_mean ,
	bdv.mpage_param_value,
	bdv.freetext_desc,
	bdf.filter_mean ,
	bdf.filter_display,
	bdf.filter_seq,
	bdc.layout_flag,
	bdc.*,
	bdv.*,
	bdf.*
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_display = "[+Available Filters+]"
order by bdc.category_name, bdc.layout_flag


;Get BR_DATAMART_FILTER_IDs for Bedrock settings.
select  DISTINCT
	[+mPage Name+]=bdc.category_name,
	bdc.category_mean ,
	bdf.filter_mean ,
	bdf.filter_display,
	bdv.br_datamart_filter_id,
	DTA = bdv.freetext_desc
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_display = "[+Available Filters+]"
;and bdc.category_name = "Oncology Ambulatory Workflow"
;and bdc.category_name = "[+mPage Name+]"
order by bdv.freetext_desc, bdc.category_name, bdc.layout_flag

;Documents specialty groups filter:
select  DISTINCT
	[+mPage Name+]=bdc.category_name,
	bdc.category_mean ,
	bdf.filter_mean ,
	bdf.filter_display,
	bdv.br_datamart_filter_id,
	DTA = bdv.freetext_desc
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_display like "[+Available Filters+]*"
;and bdc.category_name = "Oncology Ambulatory Workflow"
and bdc.category_name = "[+mPage Name+]"
order by bdv.freetext_desc, bdc.category_name, bdc.layout_flag

;Delete statement:
	delete from br_datamart_value where br_datamart_filter_id = xxxxxxx.00 go
commit go
^</Template><Template Name="mpt_findViewPointsByViewIdentifier" Description=";Find view name by view identifier in Blackbird output.">;Find view name by view identifier in Blackbird output.
select
	viewpoint_name = cnvtupper (m.viewpoint_name ) ,
	view_name = cnvtupper (c.category_name ),
	Identifier = c.category_mean
from
	mp_viewpoint m,
	mp_viewpoint_reltn r,
	br_datamart_category c
plan m
where
	m.active_ind = 1
join r
where
	r.mp_viewpoint_id = m.mp_viewpoint_id
join c
where
	c.br_datamart_category_id = r.br_datamart_category_id
and
	c.category_mean = "[+VB_xxxxxxx+]"
order by
	viewpoint_name ,
	view_name
^</Template><Template Name="mpt_generate_declare" Description="Generate declare variables from code_values">;This will generate a "Declared variables list" from code_values entered.

;From: Bannerman,Pat &lt;Pat.Bannerman@Cerner.com&gt; 
;Sent: Friday, June 28, 2019 7:06 AM
;To: Soliman, Raphael &lt;Rouphail.Soliman@bannerhealth.com&gt;; Aluko, Adebiyi &lt;Adebiyi.Aluko@bannerhealth.com&gt;; Deme, Kavitha &lt;Kavitha.Deme@bannerhealth.com&gt;; Holland, Robert L &lt;Robert.Holland@bannerhealth.com&gt;; Untalan, Cory A &lt;Cory.Untalan@bannerhealth.com&gt;; Xie, Mike &lt;michael.xie@bannerhealth.com&gt;
;Subject: [EXTERNAL] RE: sql to capture prefmaint
;
;Here's another one for you

;-----------------------------------------------------------------------------------
select 
ONE = build2(^^declare ^^
                ,trim(cv.display_key)
                ,^^_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",^^
                ,trim(CNVTSTRING(cv.code_set))
                ,^^, "^^
                ,trim(cv.display_key)
                ,^^"))^^)
from code_value cv
where cv.display_key like "DME*"
and
cv.display like "DME *"
and
cv.code_set = 72
and
cv.active_ind = 1

;-----------------------------------------------------------------------------------
select 
ONE = build2(^^declare ^^
                ,trim(cv.display_key)
                ,^^_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",^^
                ,trim(CNVTSTRING(cv.code_set))
                ,^^, "^^
                ,trim(cv.display_key)
                ,^^"))^^)
from code_value cv
where cv.code_value in (
	1018224715.00;	Durable Medical Equipment (DME)
	,1018224278.00;	Home Health
	,1793360133.00;	Outpatient Therapy/Orders
)
and
cv.active_ind = 1

;-----------------------------------------------------------------------------------
select 
ONE = concat(",",trim(cnvtstring(cv.code_value),3),".00 ;",display)
from code_value cv
where cv.display_key like "DME*"
and
cv.display like "DME *"
and
cv.code_set = 72
and
cv.active_ind = 1
^</Template><Template Name="mpt_git_mpages" Description="Get mPage files from backend for Git.">cd ~
cp //Client/h/Bashrc.tar.gz .
tar -zxvf Bashrc.tar.gz
. .bashrc
cd -
cd //Client/c$/Users/rlholland/Downloads/Github/banner/mpages/
sh getfiles.sh

#Azure: url = https://rlholland@dev.azure.com/Holland1/mPages/_git/prod_custom_components

[gui]
	wmstate = normal
	geometry = 1075x394+59+41 152 169
^</Template><Template Name="mpt_gitRHO" Description="Setup stand-alone Git profile in RHO.">cd ~;cp //Client/h/FromHDrive/Bashrc.tar.gz .;tar -zxvf Bashrc.tar.gz;. .bashrc

cd ~;cp //Client/c/Hold/Bashrc.tar.gz .;tar -zxvf Bashrc.tar.gz;. .bashrc

#Azure: url = https://rlholland@dev.azure.com/Holland1/mPages/_git/prod_custom_components
^</Template><Template Name="mpt_hide_Nonbillable" Description="Hide Non-billable ICD-10 codes">For Donna Barger (Hide non-billable ICD10 codes):
;Display the data
select n.disallowed_ind, n.*
from nomenclature n
where n.source_vocabulary_cd = 1232054373.00 ; ICD-10-CM
and n.active_ind = 1
and n.end_effective_dt_tm &gt;= cnvtdatetime(curdate,curtime3)
and n.contributor_system_cd != 467
and n.concept_cki = (select cce.concept_cki
from cmt_concept_extension cce
where cce.active_ind = 1
and cce.beg_effective_dt_tm &lt;= cnvtdatetime(curdate,curtime3)
and cce.end_effective_dt_tm &gt;= cnvtdatetime(curdate,curtime3)
and cce.EXTENSION_TYPE_MEAN = "BILLABLE"
and cce.EXTENSION_VALUE = "N")
go


**************the update statement for the disallowed_ind column*************

free define oraclesystem go
define oraclesystem 'custom/perf0rmance@azb1' go

update from nomenclature n
set n.disallowed_ind = 1,
n.updt_id = 32913554,     ;Robert Holland's person_id
n.updt_task = 1234567890,
n.updt_dt_tm = cnvtdatetime(curdate,curtime3)
where n.source_vocabulary_cd = 1232054373.00 ; ICD-10-CM  in PROD
and n.active_ind = 1
and n.end_effective_dt_tm &gt;= cnvtdatetime(curdate,curtime3)
and n.contributor_system_cd != 467
and n.concept_cki = (select cce.concept_cki
from cmt_concept_extension cce
where cce.active_ind = 1
and cce.beg_effective_dt_tm &lt;= cnvtdatetime(curdate,curtime3)   ; if I run this before 10/1, I&#x2019;ll have to comment this line out
and cce.end_effective_dt_tm &gt;= cnvtdatetime(curdate,curtime3)
and cce.EXTENSION_TYPE_MEAN = "BILLABLE"
AND cce.EXTENSION_VALUE = "N")
go
commit go
^</Template><Template Name="mpt_HTMLDomainUpdate" Description="Update the domain path in HTML files.">#!/bin/bash
# ----------------------------------------------------------------------------
# Script Author: Robert Holland
# Script Name: doit.ksh
# Creation Date: Fri Nov 02 2018 10:06:49 GMT-0700 (US Mountain Standard Time)
# Last Modified:
# Copyright (c)2018
# Purpose: Purpose: Change the mPage .html files to point to the Websphere server in the correct RHO domain environmenronment.
# Note: For some reason, there were some files that were missed during the first run. I had to create a second RHO directory and run this again.
# ----------------------------------------------------------------------------

#Copy files to the zz directory for processing.
	#cp `grep -i "p1805" *.html|cut -d ":" -f1|sort|uniq` ./zz/

#Check for files that have both forward slash and backward slash on the same line.
	#grep "/[Cc]ustom_[Mm]page_[Cc]ontent/advisor/" *.html | cut -d ":" -f1 | sort | uniq


tgt="x" #Type the target directory here.
if [ ! -d "./$tgt" ]
then
echo "The target directory $tgt does not exist."
else
for file in *.html
do
#Good:
#cat "$file" | sed 's/[Pp]1805/[+DomainName+]/' | sed 's/samtazea\.cernerasp/samtazeanp\.cernerasp/' | sed 's/\\\\samtaznas\\samtaz\\[+DomainName+]\\winintel\\static_content\\custom_mpage_content\\mpages\\/I\:\\winintel\\static_content\\custom_mpage_content\\mpages\\/' | sed 's/\\\\samtaznas\\samtaz\\[+DomainName+]\\Winintel\\Static_Content\\custom_mpage_content\\advisor\\/I:\\winintel\\static_content\\custom_mpage_content\\advisor\\/' | sed 's/http:\/\/requestcenter\.bhs\.bannerhealth\.com\/Pages\/GeneralRequest\.aspx?formID=285/https:\/\/svcnowprod\.service-now\.com\/sp\/?id=sc_cat_item\&amp;sys_id=d6697f5ddb317c148dce4a28139619e6/' &gt; $tgt/"$file"
#cat "$file" | sed 's/[Pp]1805/[+DomainName+]/' | sed 's/samtazea\.cernerasp/samtazeanp\.cernerasp/' | sed 's/\\\\samtaznas\\samtaz\\[+DomainName+]\\[Ww]inintel\\[Ss]tatic_[Cc]ontent\\[Cc]ustom_mpage_content\\/I\:\\winintel\\static_content\\custom_mpage_content\\/' | sed 's/http:\/\/requestcenter\.bhs\.bannerhealth\.com\/Pages\/GeneralRequest\.aspx?formID=285/https:\/\/svcnowprod\.service-now\.com\/sp\/?id=sc_cat_item\&amp;sys_id=d6697f5ddb317c148dce4a28139619e6/' &gt; $tgt/"$file"

cat "$file" | sed 's/[Pp]1805/[+DomainName+]/' | sed 's/samtazea\.cernerasp/samtazeanp\.cernerasp/' | sed 's/\\\\[Ss]amtaznas\\[Ss]amtaz\\[+DomainName+]\\[Ww]inintel\\[Ss]tatic_[Cc]ontent\\[Cc]ustom_mpage_content\\/I\:\\winintel\\static_content\\custom_mpage_content\\/' | sed 's/http:\/\/requestcenter\.bhs\.bannerhealth\.com\/Pages\/GeneralRequest\.aspx?formID=285/https:\/\/svcnowprod\.service-now\.com\/sp\/?id=sc_cat_item\&amp;sys_id=d6697f5ddb317c148dce4a28139619e6/' &gt; $tgt/"$file"


#samtaznas\\samtaz\\[+DomainName+]\\winintel\\static_content\\custom_mpage_content\\
#\\samtaznas\samtaz\[+DomainName+]\Winintel\Static_Content\custom_mpage_content\

#The following will update the URL but the forward slashes around the custom folder and filenames need to be changed manually.
#sed 's/http:\/\/samtazea.cernerasp.com\/mpage-content\/[+DomainName+].samt_az.cernerasp.com\/custom_mpage_content\/advisor\/\\/I:\\winintel\\static_content\\custom_mpage_content\\advisor\\/' | sed 's/\\\\samtaznas\\samtaz\\[+DomainName+]\\winintel\\static_content\\custom_mpage_content\\mpages\\/I\:\\winintel\\static_content\\custom_mpage_content\\mpages\\/' | sed 's/\\\\samtaznas\\samtaz\\[+DomainName+]\\Winintel\\Static_Content\\custom_mpage_content\\advisor\\/I:\\winintel\\static_content\\custom_mpage_content\\advisor\\/' | sed 's/[Pp]1805/[+DomainName+]/' | sed 's/[Pp]1805/[+DomainName+]/' &gt; x/"$file"
done
fi
^</Template><Template Name="mpt_idrive_path_Applink" Description="I Drive Path - Applink">CSS I: Drive Example:
	&lt;link rel="stylesheet" type="text/css" href="I:\winintel\static_content\custom_mpage_content\mpages\telemetry_org\css\[+cssfile+].css" /&gt;

JavaScript I: Drive Example:
	&lt;script type="text/javascript" src="I:\winintel\static_content\custom_mpage_content\mpages\telemetry_org\js\[+jsfile+].js"&gt;&lt;/script&gt;

Mapped Path:
javascript: APPLINK(100, 'file:I:\\winintel\\Static_Content\\custom_mpage_content\\advisor\\VTE\\VTE_Advisor_Ordering.pdf', '');

UNC Path:
javascript: APPLINK(100, 'file://samtaznas/samtaz/P1805/winintel/Static_Content/custom_mpage_content/advisor/VTE/ui-anim_basic_16x16.gif', '');

Image Source:
document.getElementById('status_span').innerHTML = "&lt;img src='//phx00027/azb/Custom/advisor/VTE/ui-anim_basic_16x16.gif' border=0 alt='Closing Advisor...' /&gt;&lt;div class='text1'&gt;VTE Advisor Closing. Please Wait...&lt;/div&gt;";
to:
document.getElementById('status_span').innerHTML = "&lt;img src='I:\\winintel\\Static_Content\\custom_mpage_content\\advisor\\VTE\\ui-anim_basic_16x16.gif' border=0 alt='Closing Advisor...' /&gt;&lt;div class='text1'&gt;VTE Advisor Closing. Please Wait...&lt;/div&gt;";
^</Template><Template Name="mpt_include_compile" Description="Include and compile from backend.">%i ccluserdir:update_ekms_b1805.ccl
go
commit go

/*
Snippet of the contents of update_ekms_b1805.ccl:
	execute eks_util_make_ekm "WH_PPH_DELIVERY_EVAL" go
	%i ccluserdir:wh_pph_delivery_eval.ekm
	execute eks_util_make_ekm "WH_PPH_LABOR_EVAL" go
	%i ccluserdir:wh_pph_labor_eval.ekm
	execute eks_util_make_ekm "WH_PPH_RISK_ORD_1" go
	%i ccluserdir:wh_pph_risk_ord_1.ekm
*/
^
</Template><Template Name="mpt_insurance_error" Description="An unexpected exception occurred">;SR:433687551 ;INC2332068
;Error in Cerner Rev Cycle with insurance
;An unexpected exception occurred  (OAF_GET_PERSON_PLAN_RELTN).

[+SR_INCIDENT+]; NUMBER ONLY SR or Incident.
[+PERSON_ID+]; Person that was affected by the issue.
[+HEALTH PLAN ID+]; Health Plan ID

;Get related Health Plan ID:
select
ppr.health_plan_id
,hp.plan_name
,hp.active_ind
,ppr.active_ind
,hp.financial_class_cd
,hp.plan_type_cd,ppr.*
from person_plan_reltn ppr
, health_plan hp
where ppr.health_plan_id=hp.health_plan_id
and ppr.person_id = [+PERSON_ID+];40005515.00
with uar_code(d), format(date, ";;")

;BEFORE - Save data before running update statement:
select
*
from
	person_plan_reltn
where person_plan_reltn_id in (select DISTINCT ppr.person_plan_reltn_id from person_plan_reltn ppr, health_plan_alias hpa
where ppr.health_plan_id = [+HEALTH PLAN ID+]; Health Plan ID from above.
and ppr.active_ind = 1
and ppr.health_plan_id = hpa.health_plan_id
and hpa.plan_alias_type_cd = 0
and hpa.active_ind = 1); Sub-query shows all persons affected by issue.
with separator=";" ;Semi-colon delimited
go
;Save as: ccluserdir/rh_[+SR_INCIDENT+]_before.dat

;AFTER - After running update statement:
select
*
from
	person_plan_reltn
where person_plan_reltn_id in (select DISTINCT ppr.person_plan_reltn_id from person_plan_reltn ppr, health_plan_alias hpa
where ppr.health_plan_id = [+HEALTH PLAN ID+]; Health Plan ID from above.
and ppr.active_ind = 0
and ppr.health_plan_id = hpa.health_plan_id
and ppr.person_id = [+PERSON_ID+]; Person that was affected by the issue.
and hpa.plan_alias_type_cd = 0
and hpa.active_ind = 1); Sub-query shows only one person affected by issue ([+PERSON_ID+]).
with separator=";" ;Semi-colon delimited
go

;UPDATE Statement:
update into person_plan_reltn
set active_ind = 0,
updt_id = 2.00,
updt_task= 433687551,
updt_dt_tm=sysdate
where person_plan_reltn_id in (select DISTINCT ppr.person_plan_reltn_id from person_plan_reltn ppr, health_plan_alias hpa
where ppr.health_plan_id = [+HEALTH PLAN ID+]; Health Plan ID from above.
and ppr.active_ind = 1
and ppr.health_plan_id = hpa.health_plan_id
and hpa.plan_alias_type_cd = 0
and hpa.active_ind = 1)
go commit go
^</Template><Template Name="mpt_internal_team_links" Description="Access to the internal team links.">;Who has access to the internal team links.
select
	pgr.person_id
	,pgr.prsnl_group_id
	,p.name_full_formatted
from
	prsnl_group_reltn pgr
	,prsnl p
plan pgr
where
pgr.PRSNL_GROUP_ID in (
   15091786.00
   ,16516649.00
   ,16516650.00
)
and
	pgr.active_ind = 1
join 
	p where pgr.person_id = p.person_id
with uar_code(d)</Template><Template Name="mpt_js" Description="home1 and user_chk.js">[+cerner_username+]
[+functionname+]
[+Link_Name+]
[+VB_Bedrock_Identifier+]
[+RITM_REQ_TASK+]

//[+Link_Name+] 3/19/2020 4:13:57 PM
//----1bh_mpage_home1.js----
function [+functionname+]() { //[+RITM_REQ_TASK+] [DATE_TEXT] [TIME] RH
  CCLLINK("mp_unified_driver","^^MINE^^,value($PAT_PERSONID$),value($VIS_ENCNTRID$),value($USR_PERSONID$),value($USR_PositionCd$),value($PAT_PPRCode$) ,^^$APP_AppName$^^,^^^^,^^[+VB_Bedrock_Identifier+]^^",1);
}
//----1bh_mpage_home1.js----

//----user_chk.js----
				//[+RITM_REQ_TASK+] [DATE_TEXT] [TIME] RH
				if (recordData.POSITION_USR.match(/^^\b(DBA|Onsite Tech Support|Information Services Staff 5)\b$/)){
				aObj.style.display="";
				$("#mainTable tbody").append("&lt;tr style='height:30px'&gt;&lt;td&gt;&lt;a href='javascript:[+functionname+]();'&gt;[+Link_Name+]&lt;/a&gt;&lt;/td&gt;&lt;/tr&gt;");
		};
				//[+RITM_REQ_TASK+] [DATE_TEXT] [TIME] RH
				if (recordData.USERNAME.toLowerCase().match(/(prholland|[+cerner_username+])/)){
				aObj.style.display="";
				$("#mainTable tbody").append("&lt;tr style='height:30px'&gt;&lt;td&gt;&lt;a href='javascript:[+functionname+]();'&gt;[+Link_Name+]&lt;/a&gt;&lt;/td&gt;&lt;/tr&gt;");
		};
//----user_chk.js----
^</Template><Template Name="mpt_link_to_Powerchart_example" Description="Link to Powerchart example">Link to Powerchart example:1bh_mpage_cm_screening.prg
Record structure declaration:
1 meds_result = vc

Value assignment for meds_result:
cm_screening-&gt;meds_result = BUILD2(^&lt;a href='javascript::APPLINK(0,"Powerchart.exe","\/PERSONID=^,TRIM(CNVTSTRING($per_id)),^ \/ENCNTRID=^
											,TRIM(CNVTSTRING($enc_id)),^ \/FIRSTTAB=^,^Medication List^,^")'&gt;^,cm_screening-&gt;meds_cnt,^&lt;/a&gt;^)

Looks like this in the listing:
 1 MEDS_RESULT=VC134   {&lt;a href='javascript::APPLINK(0,"Powerchart.exe","\/PERSONID=8285172 \/ENCNTRID=2}
                       {20390629 \/FIRSTTAB=Medication List")'&gt;          6&lt;/a&gt;}
</Template><Template Name="mpt_locations_facilities_acute" Description="Acute locations and facilities">See also:
    mpt_facility_codes
; ----------------------------------------------------------------------------
; Script Author: Vince Woolery
; Script Name: 1bh_orgs_and_locs.prg
; Creation Date: Fri Sep 16 2022 15:39:24 GMT-0700 (US Mountain Standard Time)
; Last Modified:
; Copyright (c)2022
; SNOW#:
; Purpose: CCL is used in "Banner Orgs and Locations ACUTE" and "Banner Orgs and Locations AMBULATORY" reports.
; ----------------------------------------------------------------------------

select 	DISTINCT ;INTO $1  ;o.*
	ORG_NAME = SUBSTRING(1,50,o.org_name)
	,prefix = substring(1,5,uar_get_code_display(l.FACILITY_ACCN_PREFIX_CD))
	,client = substring(1,7,oa.alias)
	,org_id = o.organization_id "#########"
	,loc_cd = l.location_cd "############"
	,loc_disp = substring(1,10,uar_get_code_display(l.location_cd))

	,ADDR1         = substring(1,30,A.STREET_ADDR)
;	,ADDR2         = substring(1,20,(A.STREET_ADDR2))
	,CSZ           = substring(1,30,CONCAT(TRIM(A.CITY), ", ",
                         TRIM(A.STATE), "  ", TRIM(A.ZIPCODE)))
;        ,addr_stat = uar_get_code_display(a.ACTIVE_STATUS_CD)
        ,PHONE         = PH.PHONE_NUM "(###) ### - ####"
;        ,ph_stat = substring(1,10,uar_get_code_display(PH.ACTIVE_STATUS_CD))
	,org_npi= oa.alias
	,NPI_CHECK1=concat("https://npiregistry.cms.hhs.gov/provider-view/",oa.alias)
	;,NPI_CHECK2=concat("https://npiprofile.com/validation/",oa.alias)

from	organization o
	,organization_alias oa
	,org_type_reltn otr
	,location l
 	,address a
 	,phone ph


plan	o
where
		o.ORG_CLASS_CD = 1211    ; organization
  and	O.DATA_STATUS_CD = 25.00    ;Auth (Verified)  cs  8  ;39 = Unauth
  and   o.org_name != "Banner Health*"    ;NO CLINICS
  and	o.active_ind = 1

join	l
where
		O.ORGANIZATION_ID = l.organization_id
  and	l.LOCATION_TYPE_CD = 783.00   ; FACILITY
  and	l.active_ind = 1
; and     l.facility_accn_prefix_cd != 0.00
  and     l.patcare_node_ind = 1
; and     l.updt_task in (18007, 13001, 3202004 )

join otr
where 		l.organization_id = otr.organization_id
  and 		otr.org_type_cd = 870.00     ;cdf_meaning = HOSPITAL, cs 278
  and 		otr.active_ind = 1
  and 		otr.end_effective_dt_tm &gt; cnvtdatetime(curdate, curtime3)

join 	oa
where
		o.organization_id = oa.organization_id
  and	oa.alias_pool_cd = 673908.00    ;cs 263 Encounter Org
  and   oa.end_effective_dt_tm &gt; cnvtdatetime(curdate, curtime3)
  and   not substring(1,3,oa.alias) = "000"
  and	not substring(1,4,oa.alias) = "NCMC"  ;NCMC ISSUE
  and	not substring(1,2,oa.alias) = "  "    ;no blanks
  and   oa.active_ind = 1.00

JOIN A
  WHERE outerjoin(O.ORGANIZATION_ID) = A.PARENT_ENTITY_ID
    AND A.ADDRESS_TYPE_CD = outerjoin(754.00)   ;BUSINESS  CS 212
    and a.parent_entity_name = outerjoin("ORGANIZATION")
    and a.active_ind = outerjoin(1)

JOIN PH
  WHERE outerjoin(O.ORGANIZATION_ID) = PH.PARENT_ENTITY_ID
    and ph.phone_type_cd + 0 = outerjoin(163.00)  ;cs 43 business
    and ph.parent_entity_name = outerjoin("ORGANIZATION")
    and ph.active_ind = outerjoin(1)

ORDER	O.ORG_NAME,
		o.organization_id

WITH 	MAXREC=10000, format, SEPARATOR="#"
^</Template><Template Name="mpt_locations_facilities_ambulatory" Description="Ambulatory locations and facilities">; ----------------------------------------------------------------------------
; Script Author: Vince Woolery
; Script Name: 1bh_orgs_and_locs_amb.prg
; Creation Date: Fri Sep 16 2022 15:39:24 GMT-0700 (US Mountain Standard Time)
; Last Modified:
; Copyright (c)2022
; SNOW#:
; Purpose: CCL is used in "Banner Orgs and Locations AMBULATORY" report.
; ----------------------------------------------------------------------------

select 	DISTINCT ;INTO $1  ;o.*
	ORG_NAME = SUBSTRING(1,60,o.org_name)
	,prefix = substring(1,5,uar_get_code_display(l.FACILITY_ACCN_PREFIX_CD))
	,client = substring(1,7,oa.alias)
	,org_id = o.organization_id "#########"
	,loc_cd = l.location_cd "############"
	,loc_disp = substring(1,40,uar_get_code_display(l.location_cd))
	,ADDR1 = trim(replace(replace(A.street_addr, char(13), " " ,0), char(10), " ",0))
;	,ADDR1         = substring(1,30,A.STREET_ADDR)
;	,ADDR2         = substring(1,20,(A.STREET_ADDR2))
	,CSZ           = substring(1,30,CONCAT(TRIM(A.CITY), ", ",
                         TRIM(A.STATE), "  ", TRIM(A.ZIPCODE)))
;        ,addr_stat = uar_get_code_display(a.ACTIVE_STATUS_CD)
        ,PHONE         = PH.PHONE_NUM "(###) ### - ####"
;        ,ph_stat = substring(1,10,uar_get_code_display(PH.ACTIVE_STATUS_CD))
	,org_npi= oa.alias
	,NPI_CHECK1=concat("https://npiregistry.cms.hhs.gov/provider-view/",oa.alias)
	;,NPI_CHECK2=concat("https://npiprofile.com/validation/",oa.alias)

from
     organization 		o
	,organization_alias oa
	,org_type_reltn 	otr
	,location 			l
 	,address 			a
 	,phone 				ph


plan	o
where
		o.ORG_CLASS_CD = 1211    ; organization
  and	O.DATA_STATUS_CD = 25.00    ;Auth (Verified)  cs  8  ;39 = Unauth
  and   o.org_name != "*HX Mig*"    ;NO History Migration Only
  and   o.org_name != "*HX MIg*"    ;NO History Migration Only (alt spelling)
  and	o.org_name != "zzz*"		;no zzz test orgs
  and	o.active_ind = 1.00

join otr
where 	o.organization_id = otr.organization_id
  and  	otr.org_type_cd = 709684485.00	;RCA Clinic Organizations
  and 	otr.active_ind = 1
  and 	otr.end_effective_dt_tm &gt; cnvtdatetime(curdate, curtime3)
  and	otr.active_ind = 1.00

JOIN A
  WHERE outerjoin(O.ORGANIZATION_ID) = A.PARENT_ENTITY_ID
    AND A.ADDRESS_TYPE_CD = outerjoin(754.00)   ;BUSINESS  CS 212
    and a.parent_entity_name = outerjoin("ORGANIZATION")
    and a.active_ind = outerjoin(1.00)

JOIN PH
  WHERE outerjoin(O.ORGANIZATION_ID) = PH.PARENT_ENTITY_ID
    and ph.phone_type_cd + 0 = outerjoin(163.00)  ;cs 43 business
    and ph.parent_entity_name = outerjoin("ORGANIZATION")
    and ph.active_ind = outerjoin(1.00)

join	l
where
		outerjoin(O.ORGANIZATION_ID) = l.organization_id
  and	l.LOCATION_TYPE_CD = outerjoin(783.00)   ; FACILITY
; and     l.facility_accn_prefix_cd != outerjoin(0.00)
 and     l.patcare_node_ind = outerjoin(1.00)
; and     l.updt_task in (18007, 13001, 3202004 )
  and	l.active_ind = outerjoin(1.00)

join 	oa
where
		outerjoin(o.organization_id) = oa.organization_id
;  and	oa.alias_pool_cd = 673908.00    ;cs 263 Encounter Org
  and   oa.end_effective_dt_tm &gt; outerjoin(cnvtdatetime(curdate, curtime3))
  and   not substring(1,3,oa.alias) = outerjoin("000")
  and	not substring(1,4,oa.alias) = outerjoin("NCMC")  ;NCMC ISSUE
  and	not substring(1,2,oa.alias) = outerjoin("  ")    ;no blanks
  and   oa.active_ind = outerjoin(1.00)


ORDER	O.ORG_NAME,
		o.organization_id

WITH 	MAXREC=10000, SEPARATOR="#", format
^</Template><Template Name="mpt_mapH" Description="Map OneDrive to H:">@echo off
REM ----------------------------------------------------------------------------
REM Author: Robert Holland
REM Name: MapH.cmd
REM Creation Date: Thu Oct 14 2021 08:53:25 GMT-0700 (US Mountain Standard Time)
REM Last Modified:
REM Copyright (c)2021
REM Purpose: Locally Map H: drive to OneDrive
REM ----------------------------------------------------------------------------

subst H: "C:\Users\%username%\OneDrive - Banner Health\"
^</Template><Template Name="mpt_mpage_timer" Description="mPage Timers">	/* Custom MPage Timer - Start */
	var mpageName = "[+MPageTimerExampleUniqueId+]";
	Clear the previous results if there are any
	var timerPane = document.getElementById("timerPane");
	timerPane.innerHTML = "";

	checkpoint = window.external.DiscernObjectFactory("CHECKPOINT");

	capture the page level capability timer which will be used to aggregate the individual sub components below
	checkpoint.EventName = "CAP:CUST:MPG LAUNCH MPAGE";
	checkpoint.SubEventName = "Start-Stop";
	checkpoint.Metadata("rtms.legacy.subtimerName") = mpageName; "MPageTimerExampleUniqueId";
	checkpoint.Metadata("rtms.legacy.metadata.1") = "[+mPage_Name+]";
	checkpoint.Metadata("rtms.legacy.metadata.2") = "Shows up in LON";
	checkpoint.Publish();

	/* Only for testing the front UI response, and optional for use in production */
	appendInformation("MPage View capability timer: "+mpageName+" captured");

	Create a check point that signifies the start of this component's timer
	checkpoint.EventName = "USR:CUST:MPG.COMPONENT";
	checkpoint.SubEventName = "Start";
	checkpoint.Metadata("rtms.legacy.subtimerName") = mpageName; "MPageTimerExampleUniqueId";
	checkpoint.Metadata("rtms.legacy.metadata.1") = "Custom display for sub component " + mpageName;
	checkpoint.Metadata("rtms.legacy.metadata.2") = "Shows up in LON";
	checkpoint.Publish();

	/* Below code lines are for testing only, and optional for use in production */
	appendInformation("&lt;span id='" + mpageName + "'&gt;Timer started for component " + mpageName + "&lt;/span&gt;");
	/* Custom MPage Timer - Start */

//Bottom of code:
	/* Custom MPage Timer - End*/
	checkpoint.EventName = "USR:CUST:MPG.COMPONENT";
	checkpoint.SubEventName = "Stop";
	checkpoint.Metadata("rtms.legacy.subtimerName") = mpageName; "MPageTimerExampleUniqueId";
	checkpoint.Metadata("rtms.legacy.metadata.1") = "Custom display for sub component " + mpageName;
	checkpoint.Metadata("rtms.legacy.metadata.2") = "Shows up in LON";
	checkpoint.Publish();
	updateCompletedTimer(mpageName);  Only for testing the front UI response
	appendInformation("-&gt; Completed to load");
  debugMessage("calling stopCustMPageTimer(mPageTitle)",getLineNum(),debug);
  stopCustMPageTimer(mPageTitle);
  debugMessage("end calling stopCustMPageTimer(mPageTitle)",getLineNum(),debug);
	/* Custom MPage Timer - End */</Template><Template Name="mpt_mpage_version" Description="mPage Version">select group = mg.group_ident
, mg.description
, version = mg.version_txt
, update_on = mg.updt_dt_tm "@SHORTDATETIME"
;, updated_by = p.name_full_formatted
, mg.mp_release_id
;, mg.*
from mp_group mg;, prsnl p
where mg.mp_release_id &gt; 0
and mg.group_ident like "MPAGE_*"
;and p.person_id = outerjoin(mg.updt_id)
order by mg.mp_release_id desc, mg.updt_dt_tm desc
with uar_code(d), format(date,";;q"), time=120, maxrec=2
^</Template><Template Name="mpt_my_cerner_ids" Description="My Cerner ID">IT ID:
Name: Holland RN, Robert L   	
Cerner ID: RLHOLLAND
PID: 32913554.00

Nursing ID:
Name: Holland RN, Robert L
Cerner ID: 2CN241630
PID: 47635127.00
^</Template><Template Name="mpt_npi" Description="Check NPI Number">
select
p.username,
p.name_full_formatted,
p.person_id,
alias_cd=uar_get_code_display(pa.prsnl_alias_type_cd),
alias=uar_get_code_display(pa.alias_pool_cd),
npi_number=pa.alias,
url1=concat("https://npiregistry.cms.hhs.gov/provider-view/",pa.alias),
url2=concat("https://npiprofile.com/validation/",pa.alias),
pa.updt_dt_tm;,
;pa.*
from
	prsnl p,
	Prsnl_alias pa
plan p
where
	p.person_id = (select person_id from prsnl where username = cnvtupper("[+USERNAME+]"))
	;p.person_id = [+123456.00+]
join pa where p.person_id = pa.person_id
and pa.prsnl_alias_type_cd = 28769904.00 
and pa.alias_pool_cd = 498265387.00
and pa.active_ind = 1
with nocounter, separator="#", format, maxrec = 20

#Check NPI Number:
https://npiprofile.com/validation/[+NPI Number+]
https://npiregistry.cms.hhs.gov/provider-view/[+NPI Number+]

National Plan &amp; Provider Enumeration System: (Users can update their information here).
https://nppes.cms.hhs.gov/

#See also mpt_PMP
^
</Template><Template Name="mpt_opioid_review_previous_overdose" Description="Opioid Review Component Previous Overdose">; ----------------------------------------------------------------------------
; Script Author: Robert Holland 
; Script Name: 1bh_mpage_OpioidReviewPreviousOverdose.prg
; Creation Date: Mon Aug 23 2021 12:09:57 GMT-0700 (US Mountain Standard Time)
; Last Modified: 
; Copyright (c)2021
; SNOW#: None
; Purpose: Display the Opioid Review Component Previous Overdose DTA's in Bedrock.
; ----------------------------------------------------------------------------

select n.nomenclature_id, n.source_string
from
nomenclature n
where
n.nomenclature_id in (
	select 
  		code_value_or_nomenclature_id = parent_entity_id; This could also be nomenclature_id. ; nomenclature.source_string
	from 
		br_datamart_value bdv
	where 
		bdv.br_datamart_filter_id = (
			select distinct
            	bdv1.br_datamart_filter_id
			from
				br_datamart_category bdc,
				br_datamart_value bdv1,
				br_datamart_filter bdf
			where bdc.br_datamart_category_id = bdv1.br_datamart_category_id
			and bdf.br_datamart_filter_id = bdv1.br_datamart_filter_id
			;Available Filter Name:
				and bdf.filter_display like "Previous Overdose";Available filter (ex. "Previous Overdose", "Confirmation applied to diagnosis").
			;mPage Name: (ex. "Primary Care Amb Workflow", "Pharmacy Workflow")
				and bdc.category_name = "Pharmacy Workflow" ;Comment this line to show all mPages with the above available filter
			)
	)
order by n.source_string</Template><Template Name="mpt_OTS" Description="Changing OTS User">;Enter [+123456.00+] or [+USERNAME+]
select
	p.username,
	p.name_full_formatted,
	cp.usr_person_id,
	cp.rowid,
	cp.position_cd,
	position_name=uar_get_code_display(cp.position_cd),
	cp.active_ind,
	cp.updt_cnt,
	cp.updt_dt_tm";;",
	cp.bh_mp_pref_id,
	cp.beg_effective_dt_tm";;",
	cp.end_effective_dt_tm";;"
from
	cust_samt.cust_prsnlauthpos cp,
	prsnl p
plan cp
where cp.usr_person_id = (select person_id from prsnl where username = cnvtupper("[+USERNAME+]"));
join p where p.person_id = cp.usr_person_id
order by cp.bh_mp_pref_id desc

---------------------
select
	p.username,
	p.name_full_formatted,
	cp.usr_person_id,
	cp.rowid,
	cp.position_cd,
	position_name=uar_get_code_display(cp.position_cd),
	cp.active_ind,
	cp.updt_cnt,
	cp.updt_dt_tm";;",
	cp.bh_mp_pref_id,
	cp.beg_effective_dt_tm";;",
	cp.end_effective_dt_tm";;"
from
	cust_samt.cust_prsnlauthpos cp,
	prsnl p
plan cp
where cp.usr_person_id = [+123456.00+];
join p where p.person_id = cp.usr_person_id
order by cp.bh_mp_pref_id desc

---------------------
delete from cust_samt.cust_prsnlauthpos
where usr_person_id = [+123456.00+]
go
commit go

---------------------
delete from cust_samt.cust_prsnlauthpos
where usr_person_id = (select person_id from prsnl where username = cnvtupper("[+USERNAME+]"))
go
commit go

---------------------
select * from cust_samt.cust_prsnlauthpos where usr_person_id = [+123456.00+] go

---------------------
select * from cust_samt.cust_prsnlauthpos
where usr_person_id = (select person_id from prsnl where username = cnvtupper("[+USERNAME+]"))
go

---------Change Back To Code------------
SELECT into "NL:"
	C.ACTIVE_IND
	, C.BEG_EFFECTIVE_DT_TM "@SHORTDATETIME"
	, C.BH_MP_PREF_ID
	, C.END_EFFECTIVE_DT_TM "@SHORTDATETIME"
	, C_POSITION_DISP = UAR_GET_CODE_DISPLAY(C.POSITION_CD)
  	, C.ROWID
	, C.UPDT_APPLCTX
	, C.UPDT_CNT
	, C.UPDT_DT_TM
	, C.UPDT_ID
	, C.UPDT_TASK
	, C.USR_PERSON_ID

FROM
	cust_samt.CUST_PRSNLAUTHPOS   C

where c.usr_person_id = (select person_id from prsnl where username = cnvtupper("[+USERNAME+]")); REQINFO-&gt;UPDT_ID
and C.END_EFFECTIVE_DT_TM &gt;CNVTDATETIME(CURDATE, curtime3)
and C.ACTIVE_IND = 1

ORDER BY
	C.BH_MP_PREF_ID desc
^</Template><Template Name="mpt_packages" Description="Check if package numbers exist">select version_number, package_nbr, *
from cmt_content_version
where package_nbr in (
[+package_number+]
)
^
</Template><Template Name="mpt_parseBedrockCSVexport" Description="Parse Bedrock CSV Export">#Convert the (",") to (*), then cut by column number and sort.

#Example: 
grep "Discharge Planning Event Sets selection" 202202101744_B1805_Nursing_Discharge.csv|sed 's/\",\"/*/g'|cut -d "*" -f8|sort &gt; b.txt

grep "[+Column Value+]" [+CSV Name+]|sed 's/\",\"/*/g'|cut -d "*" -f[+Column Number+]|sort &gt; [+Output Filename+].txt
^</Template><Template Name="mpt_phone" Description="Phone number information">SELECT INTO "nl:"
&#xA0;&#xA0;&#xA0; patient = p.name_full_formatted
&#xA0;&#xA0;&#xA0; ,updated_by = pr.name_full_formatted
&#xA0;&#xA0;&#xA0; ,updated_on = epr.updt_dt_tm
&#xA0;&#xA0;&#xA0; , phone_number =
&#xA0;&#xA0;&#xA0; IF (findstring("(",ph.phone_num,1,0)=0
&#xA0;&#xA0;&#xA0;&#xA0; AND findstring(")",ph.phone_num,1,0)=0) cnvtphone(ph.phone_num,ph.phone_format_cd,2)
&#xA0;&#xA0;&#xA0; ELSE ph.phone_num
&#xA0;&#xA0;&#xA0; ENDIF
&#xA0;&#xA0;&#xA0; , phone_sort = cnvtalphanum(ph.phone_num), phone_type = uar_get_code_display(ph.phone_type_cd);,
;&#xA0;&#xA0;&#xA0; sort_val = getecsortvalue(ph.phone_type_cd)
&#xA0;&#xA0;&#xA0; ,epr.*
&#xA0;&#xA0;&#xA0; FROM encntr_person_reltn epr,
&#xA0;&#xA0;&#xA0;&#xA0; phone ph,
&#xA0;&#xA0;&#xA0;&#xA0; person p,
&#xA0;&#xA0;&#xA0;&#xA0; prsnl pr
&#xA0;&#xA0;&#xA0; PLAN (epr
&#xA0;&#xA0;&#xA0;&#xA0; WHERE epr.encntr_id in (211846819.0,211383621.0) ;encntrid
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.person_reltn_type_cd=1152.00&#xA0;&#xA0;&#xA0; ;Emergency Contact ;emc_cd
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.related_person_id &gt; 0.0
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.beg_effective_dt_tm &lt; cnvtdatetime(sysdate)
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.end_effective_dt_tm &gt;= cnvtdatetime(sysdate)
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND epr.active_ind=1)
&#xA0;&#xA0;&#xA0;&#xA0; JOIN (p
&#xA0;&#xA0;&#xA0;&#xA0; WHERE p.person_id=epr.related_person_id)
&#xA0;&#xA0;&#xA0;&#xA0; JOIN (ph
&#xA0;&#xA0;&#xA0;&#xA0; WHERE (ph.parent_entity_id= Outerjoin(epr.related_person_id))
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND (ph.parent_entity_name= Outerjoin("PERSON"))
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND (ph.beg_effective_dt_tm&lt;= Outerjoin(cnvtdatetime(sysdate)))
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND (ph.end_effective_dt_tm&gt;= Outerjoin(cnvtdatetime(sysdate)))
&#xA0;&#xA0;&#xA0;&#xA0;&#xA0; AND (ph.active_ind= Outerjoin(1)) )
&#xA0;&#xA0;&#xA0;&#xA0; JOIN pr
&#xA0;&#xA0;&#xA0;&#xA0; WHERE pr.person_id = epr.updt_id
&#xA0;&#xA0;&#xA0;&#xA0; AND pr.active_ind = 1
&#xA0;&#xA0;&#xA0; ORDER BY p.person_id, ph.parent_entity_id, epr.priority_seq,
&#xA0;&#xA0;&#xA0;&#xA0; phone_type, ph.phone_type_seq,
&#xA0;&#xA0;&#xA0;&#xA0; phone_sort
WITH UAR_CODE(D), FORMAT(DATE,";;Q"), TIME=60
^</Template><Template Name="mpt_PMP" Description="PMP NPI">;Find provider NPI by username or person_id:
;Enter: [+USERNAME+] or [+123456.00+]

select
p.username,
p.name_full_formatted,
p.person_id,
alias_cd=uar_get_code_display(pa.prsnl_alias_type_cd),
alias=uar_get_code_display(pa.alias_pool_cd),
npi_number=pa.alias,
url1=concat("https://npiregistry.cms.hhs.gov/provider-view/",pa.alias),
url2=concat("https://npiprofile.com/validation/",pa.alias),
pa.updt_dt_tm;,
;pa.*
from
	prsnl p,
	Prsnl_alias pa
plan p
where
	p.person_id = (select person_id from prsnl where username = cnvtupper("[+USERNAME+]"))
	;p.person_id = [+123456.00+]
join pa where p.person_id = pa.person_id
and pa.prsnl_alias_type_cd = 28769904.00 
and pa.alias_pool_cd = 498265387.00
and pa.active_ind = 1
with nocounter, separator="#", format, maxrec = 20

National Plan &amp; Provider Enumeration System: (Users can update their information here).
https://nppes.cms.hhs.gov/

Hi XXXXXX,

We have seen several instances similar to this one where the&#xA0;State Pharmacy&#xA0;Board does not have the correct NPI number. You may need to email the Arizona State Pharmacy Board at PMP@azpharmacy.gov or call phone number 855-929-4767 and verify your NPI number with them. We show your NPI number as: YYYYYYYY.
&#xA0;
You can also check the Arizona PMP Website: https://pharmacypmp.az.gov/integration/statewide-integration-resources or the PMP Aware website: https://arizona.pmpaware.net/login.


Robert-
^ </Template><Template Name="mpt_PMP_Clinic_List" Description="List PMP Clinic Locations allowed to access PMP Gateway">;List PMP Clinic Locations allowed to access PMP Gateway.
select  DISTINCT
	mPage_Name=bdc.category_name,
	bdf.filter_display,
	bdc.category_mean ,
	bdf.filter_mean ,
	;bdv.br_datamart_filter_id,
	clinics = uar_get_code_display(bdv.parent_entity_id)
from
	br_datamart_category bdc,
	br_datamart_value bdv,
	br_datamart_filter bdf
where 
	bdc.br_datamart_category_id = bdv.br_datamart_category_id
and 
	bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and 
	bdf.filter_display like "PDMP - Locations allowed to access"
and 
	bdc.category_name = "Prescription Drug Monitoring (PMP) Component"
order by 
	clinics, bdv.freetext_desc, bdc.category_name, bdc.layout_flag
^</Template><Template Name="mpt_prefmaint_by_mPageTabName" Description="Show positions that have access to an mPage.">;[+mPage Tab Name+] ; Example: Acute View or eCoach

select
Application = app.description
, n.updt_dt_tm";;"
;, v.updt_dt_tm
;, n2.updt_dt_tm
;, n3.updt_dt_tm
;, dp.updt_dt_tm
,v.position_cd
, Position_Display = evaluate(
  uar_get_code_display(v.position_cd)
  , " ", "-GLOBAL-"
  , uar_get_code_display(v.position_cd), uar_get_code_display(v.position_cd)
  )
, Tab_Name = n.pvc_value
, v.frame_type
, Report_Name = evaluate(
  n3.pvc_value
  , " ", "-Not Set-"
  , n3.pvc_value, n3.pvc_value
  )
, n3.name_value_prefs_id
, n2.name_value_prefs_id
, Updated_By = p.name_full_formatted
, Report_Param = evaluate(  ;;;;;;;;;;;;;;;;;;;;;;;;;  Parameter with detail
  n2.pvc_value
  , " ", "-Not Set-"
  , n2.pvc_value, n2.pvc_value
  )

from
name_value_prefs n
, view_prefs v
, code_value cv
, application app
, name_value_prefs n2
, name_value_prefs n3
, detail_prefs dp
, person p
plan n where n.pvc_name = outerjoin("VIEW_CAPTION")
join v where n.parent_entity_id = v.view_prefs_id and n.pvc_value = "[+mPage Tab Name+]"
and v.view_name IN ( "DISCERNRPT" , "MCDISCERNRPT")
and  v.frame_type in ("CHART","ORG") ;Updated to show both. RH
join app where v.application_number = app.application_number
join cv where cv.code_value = v.position_cd
	and (
		(
			cv.active_ind = 1
			and cv.display_key != "ZZ*"
		)
			or cv.code_value = 0
		)
join dp where dp.application_number = v.application_number
and dp.position_cd = v.position_cd
and dp.view_name IN ( "DISCERNRPT" , "MCDISCERNRPT")
and dp.view_seq = v.view_seq
and dp.person_id = 0
join n2 where n2.parent_entity_id = outerjoin(dp.detail_prefs_id)
and n2.pvc_name = outerjoin("REPORT_PARAM")
join n3 where n3.parent_entity_id = dp.detail_prefs_id
and n3.pvc_value like "*driver*" ;Wildcard to show all drivers. RH
and n3.pvc_name = "REPORT_NAME"
join p where n3.updt_id = p.person_id
order by Position_Display
with time = 90
^</Template><Template Name="mpt_prefmaint_example_reportparam" Description="Prefmaint Report Params">[+HNA_POSITION+] ; DBA, Onsite Support Tech, Information Services Staff 5, IME Physician, Navigator/Coordinator RN
[+mPage Identifier+] - Example: VB_ARCHIVEDRECORDS, ONCOLOGYAMBULATORYWORKFLOW, VB_ACUTECAREMANAGEMENTWORKLIST
Chart Level mPage:
REPORT_PARAM:
Connect to Chart Level View (CHT):
REPORT_NAME: &lt;url&gt;$DM_INFO:CONTENT_SERVICE_URL$/mp-content/idx.html?m=^^CHT^^&amp;pId=$PAT_PERSONID$&amp;eId=$VIS_ENCNTRID$&amp;uId=$USR_PERSONID$&amp;pCd=$USR_PositionCd$&amp;ppr=$PAT_PPRCode$&amp;app=^^$APP_AppName$^^&amp;vId="ONCOLOGYAMBULATORYWORKFLOW"&amp;sLoc=""
REPORT_NAME: &lt;url&gt;$DM_INFO:CONTENT_SERVICE_URL$/mp-content/idx.html?m=^^CHT^^&amp;pId=$PAT_PERSONID$&amp;eId=$VIS_ENCNTRID$&amp;uId=$USR_PERSONID$&amp;pCd=$USR_PositionCd$&amp;ppr=$PAT_PPRCode$&amp;app=^^$APP_AppName$^^&amp;vId="[+mPage Identifier+]"&amp;sLoc=""

Organizer Level mPage (ORG):
REPORT_NAME:

Organizer Worklist (ORG):
REPORT_NAME: &lt;url&gt;$DM_INFO:CONTENT_SERVICE_URL$/mp-content/idx.html?m=^^ORG^^&amp;uId=$USR_PERSONID$&amp;pCd=$USR_PositionCd$&amp;app=^^$APP_AppName$^^&amp;vId="VB_ACUTECAREMANAGEMENTWORKLIST"&amp;sLoc=""
REPORT_NAME: &lt;url&gt;$DM_INFO:CONTENT_SERVICE_URL$/mp-content/idx.html?m=^^ORG^^&amp;uId=$USR_PERSONID$&amp;pCd=$USR_PositionCd$&amp;app=^^$APP_AppName$^^&amp;vId="[+mPage Identifier+]"&amp;sLoc=""

Point to a webpage:
REPORT_NAME    1samt_az_run_mpage
REPORT_PARAM    "MINE",$pat_personid$,$vis_encntrid$,0,"cust_html:1samt_az_pedcode_calc.html"

;Query to find REPORT_PARAM examples:
select
position_name = uar_get_code_display(d.position_cd)
;,n.pvc_name
,application = app.description
,frame_type=if (piece(n.pvc_value, "^",2,"") = "CHT") "CHART" 
elseif (piece(n.pvc_value, "^",2,"") = "ORG") "ORGANIZER"
elseif (piece(n.pvc_value, "/",4,"") = "smart") "SMART" endif
,viewpoint=piece(piece(piece(n.pvc_value, 'vId=',2,""), "=",2,""),"&amp;sLoc",1,"")
;,d.application_number
,n.pvc_value
from
name_value_prefs n
,detail_prefs d
,application app
;,view_prefs v
plan n
where n.pvc_name = 'REPORT_NAME'
and n.pvc_value like '&lt;url&gt;*' ;Views
join d where d.detail_prefs_id = n.parent_entity_id
and d.position_cd = (select x.code_value from code_value x where display in ("[+HNA_POSITION+]") and x.code_set = 88 and x.active_ind = 1) ;Position Name
join app where app.application_number = d.application_number
;join v where v.view_prefs_id = n.parent_entity_id
and d.position_cd != 0.00
order by
n.pvc_value
with nocounter, separator=" ", format
^</Template><Template Name="mpt_prefmaint_positions_by_viewpoint" Description="Prefmaint URL/views by position.">;Find Prefmaint Positions using [+VIEWPOINT_NAME+]
select
position_name = uar_get_code_display(d.position_cd)
;,n.pvc_name
,application = app.description
,viewpoint=piece(piece(piece(n.pvc_value, 'vId=',2,""), "=",2,""),"&amp;sLoc",1,"")
;,d.application_number
,n.pvc_value
from
name_value_prefs n
,detail_prefs d
,application app
plan n
where n.pvc_name = 'REPORT_NAME'
and n.pvc_value like '*[+VIEWPOINT_NAME+]*' ;Name of viewpoint
join d where d.detail_prefs_id = n.parent_entity_id
join app where app.application_number = d.application_number
and d.position_cd != 0.00
order by
position_name
with nocounter, separator=" ", format
^</Template><Template Name="mpt_prefmaint_stuff" Description="">[+mPage_VIEWPOINT_Name+]; Ex. HOSPITALISTVIEWPOINT, ONCOLOGYAMBULATORYSUMMARY, ONCOLOGYAMBULATORYWORKFLOW
[+mPage_TAB_DisplayName+]; Ex. ED Chronological, Ambulatory View, FM/IM QO, BUCS CO QO, Neonate Workflow, Discharge
[+mPage Name on TOC+] Examples: Acute View, Oncology View, PMP Gateway (AZ/NV Only), Nurse View
[+POSITION_NAME+] Examples: DBA, Information Services Staff 5, IME Physician, Navigator/Coordinator RN, Onsite Tech Support

select
TOC_Name = n.pvc_value
,Application = app.description
;, v.updt_dt_tm
;, n2.updt_dt_tm
;, n3.updt_dt_tm
;, dp.updt_dt_tm
,v.position_cd
, Position_Display = evaluate(
  uar_get_code_display(v.position_cd)
  , " ", "-GLOBAL-"
  , uar_get_code_display(v.position_cd), uar_get_code_display(v.position_cd)
  )
, v.frame_type
;, n3.name_value_prefs_id
;, n2.name_value_prefs_id
, Updated_By = p.name_full_formatted
, n.updt_dt_tm";;"
, Report_Param = evaluate(  ;;;;;;;;;;;;;;;;;;;;;;;;;  Parameter with detail
  n2.pvc_value
  , " ", "-Not Set-"
  , n2.pvc_value, n2.pvc_value
  )
, Report_Name = evaluate(
  n3.pvc_value
  , " ", "-Not Set-"
  , n3.pvc_value, n3.pvc_value
  )

from
name_value_prefs n
, view_prefs v
, code_value cv
, application app
, name_value_prefs n2
, name_value_prefs n3
, detail_prefs dp
, person p
plan n where n.pvc_name = outerjoin("VIEW_CAPTION"); and n.pvc_value = "TOC NAME"
join v where n.parent_entity_id = v.view_prefs_id and n.pvc_value = "[+mPage Name on TOC+]" ; MPAGE NAME ON TOC
and v.view_name IN ( "DISCERNRPT" , "MCDISCERNRPT")
and  v.frame_type in ("CHART","ORG") ;Updated to show both. RH
join app where v.application_number = app.application_number
join cv where cv.code_value = v.position_cd
	and (
		(
			cv.active_ind = 1
			and cv.display_key != "ZZ*"
		)
			or cv.code_value = 0
		)
join dp where dp.application_number = v.application_number
and dp.position_cd = v.position_cd
and dp.view_name IN ( "DISCERNRPT" , "MCDISCERNRPT")
and dp.view_seq = v.view_seq
and dp.person_id = 0
join n2 where n2.parent_entity_id = outerjoin(dp.detail_prefs_id)
and n2.pvc_name = outerjoin("REPORT_PARAM")
;Look for view identifier (comment position_cd):
;and n2.pvc_name = outerjoin("REPORT_PARAM") and n2.pvc_value like "*ONCOLOGYAMBULATORYSUMMARY*"
join n3 where n3.parent_entity_id = dp.detail_prefs_id
;and n3.pvc_value like "*driver*" ;Wildcard to show all drivers. RH
and n3.pvc_name = "REPORT_NAME"
join p where n3.updt_id = p.person_id
order by Position_Display
with time = 90;

;Find Prefmaint Positions using VIEWPOINT_NAME
select
position_name = uar_get_code_display(d.position_cd)
;,n.pvc_name
,application = app.description
,viewpoint=piece(piece(piece(n.pvc_value, 'vId=',2,""), "=",2,""),"&amp;sLoc",1,"")
;,d.application_number
,n.pvc_value
from
name_value_prefs n
,detail_prefs d
,application app
plan n
where n.pvc_name = 'REPORT_NAME'
and n.pvc_value like '*[+mPage_VIEWPOINT_Name+]*' ;Name of viewpoint
join d where d.detail_prefs_id = n.parent_entity_id
join app where app.application_number = d.application_number
and d.position_cd != 0.00
order by
position_name
with nocounter, separator=" ", format

select
position_name = uar_get_code_display(d.position_cd)
;,n.pvc_name
,application = app.description
,frame_type=if (piece(n.pvc_value, "^",2,"") = "CHT") "CHART" 
elseif (piece(n.pvc_value, "^",2,"") = "ORG") "ORGANIZER"
elseif (piece(n.pvc_value, "/",4,"") = "smart") "SMART" endif
,viewpoint=piece(piece(piece(n.pvc_value, 'vId=',2,""), "=",2,""),"&amp;sLoc",1,"")
;,d.application_number
,n.pvc_value
from
name_value_prefs n
,detail_prefs d
,application app
;,view_prefs v
plan n
where n.pvc_name = 'REPORT_NAME'
and n.pvc_value like '&lt;url&gt;*' ;Views
join d where d.detail_prefs_id = n.parent_entity_id
and d.position_cd = (select x.code_value from code_value x where display in ("[+POSITION_NAME+]") and x.code_set = 88 and x.active_ind = 1) ;Position Name
join app where app.application_number = d.application_number
;join v where v.view_prefs_id = n.parent_entity_id
and d.position_cd != 0.00
order by
n.pvc_value
with nocounter, separator=" ", format

;mPage display name: Discharge ;eg. Discharge Summary, EMR Migration, ICU Graph 
select  DISTINCT INTO "NL:"
	mPage_Name=bdc.category_name,
	mPage_Layout =
if (bdc.layout_flag = 0 )	"Summary"
elseif(bdc.layout_flag = 1)	"Workflow"
elseif(bdc.layout_flag = 2)	"Smart Template"
elseif(bdc.layout_flag = 3)	"Quick Orders and Charges"
elseif(bdc.layout_flag = 4)	"Patient Organizer View"
elseif(bdc.layout_flag = 5)	"Dashboard"
elseif(bdc.layout_flag = 6)	"Organizer View - Provider"
elseif(bdc.layout_flag = 7)	"Emergent Event"
elseif(bdc.layout_flag = 8)	"SCM Purchase Order Organizer"
elseif(bdc.layout_flag = 9)	"SCM Inventory Management Organizer" endif,
	bdc.category_mean ,
	bdv.mpage_param_value,
	bdv.freetext_desc,
	bdf.filter_mean ,
	bdf.filter_seq,
	bdc.layout_flag,
	;bdc.*
	;bdv.*
	bdf.*
from
BR_DATAMART_CATEGORY BDC,
br_datamart_value bdv,
br_datamart_filter bdf
where bdc.br_datamart_category_id = bdv.br_datamart_category_id
and bdv.freetext_desc = "[+mPage_TAB_DisplayName+]"
and bdf.br_datamart_filter_id = bdv.br_datamart_filter_id
and bdf.filter_mean = "VIEWPOINT_LABEL"
order by bdc.category_name, bdc.layout_flag
^</Template><Template Name="mpt_prefmaint_view_by_postion" Description="View by Position Name (Not Viewpoint)">;Need to create a CCL that displays the views (VB_*) that the position name has access to.
</Template><Template Name="mpt_prefmaint_viewpoint_by_postion" Description="Prefmaint URL/views by position.">;Display Prefmaint URL/views by position
;Enter [+POSITION_NAME+]. Example: Information Services Staff 5, IME Physician, Navigator/Coordinator RN, Onsite Tech Support

select
position_name = uar_get_code_display(d.position_cd)
;,n.pvc_name
,application = app.description
,frame_type=if (piece(n.pvc_value, "^^",2,"") = "CHT") "CHART" 
elseif (piece(n.pvc_value, "^^",2,"") = "ORG") "ORGANIZER"
elseif (piece(n.pvc_value, "/",4,"") = "smart") "SMART" endif
,viewpoint=piece(piece(piece(n.pvc_value, 'vId=',2,""), "=",2,""),"&amp;sLoc",1,"")
;,d.application_number
,n.pvc_value
from
name_value_prefs n
,detail_prefs d
,application app
;,view_prefs v
plan n
where n.pvc_name = 'REPORT_NAME'
and n.pvc_value like '&lt;url&gt;*' ;Views
join d where d.detail_prefs_id = n.parent_entity_id
and d.position_cd = (select x.code_value from code_value x where display in ("[+POSITION_NAME+]") and x.code_set = 88 and x.active_ind = 1) ;Position Name
join app where app.application_number = d.application_number
;join v where v.view_prefs_id = n.parent_entity_id
and d.position_cd != 0.00
order by
n.pvc_value
with nocounter, separator=" ", format^</Template><Template Name="mpt_ProgramUsage" Description="Find how much a program is being used.">;Program Usage Count/Display
select into 'nl:'
            c.begin_dt_tm
            , c.end_dt_tm
            , c.object_name
            , c.object_params
            , c.output_device
            , c.updt_dt_tm
            , c.updt_id
            , p.username
            , p.name_full_formatted

from
            ccl_report_audit   c
            , prsnl   p

plan c
where cnvtupper(c.object_name) = '[+CCL PROGRAMNAME+]*' ;

and  c.updt_dt_tm &gt; sysdate - 1

join p
where p.person_id = c.updt_id
;and p.username = 'prholland'
with maxrec = 100 </Template><Template Name="mpt_referral_status_not_changing" Description="Referral status not changing.">INC3451701--&gt;SR:443247658--&gt;PRB0043502
"The requirements to change a Referral's status to Scheduled when you associate an appointment are below:
	When a Referral is in an Accepted status and it was sent to an internal provider, the system will update the status of the case to Scheduled when the referral is associated with an appointment in a Confirmed status in an inbound worklist."

Enter the Referral_ID/Case Number here: [+ENTER CASE # HERE+]
select uar_get_code_display(rh.last_performed_action_cd)
  , uar_get_code_display(rh.referral_status_cd)
  , p.name_full_formatted
  , rh.last_performed_action_dt_tm
  , rh.external_scheduled_dt_tm
  , * 
from 
	referral_hist rh 
	, prsnl p
where 
	rh.referral_id in ([+ENTER CASE # HERE+]) ;ENTER CASE # HERE
and 
	p.person_id = rh.updt_id
order by 
	rh.last_performed_action_dt_tm
with format(date, ";;q"), time = 15, maxrec = 1000;
^</Template><Template Name="mpt_remove_ccl" Description="Remove - Delete CCL from backend">;Delete [+Name of CCL program+].prg CCL program
SET STAT = REMOVE("cust_script:[+Name of CCL program+].prg") GO
set STAT = REMOVE("[+Name of CCL program+].prg") go
^</Template><Template Name="mpt_renameComponent" Description="Rename Components">[+Old Component Name+] --&gt; [+New Component Name+]
;Workflow components will also need to have the headerTitle changed.
;Cycle server 535
/** TASK0908411: Advance Directives custom component updates **/
;LIST COMPONENTS TO BE UPDATED
select v2.br_datamart_value_id
, mpage = c.category_name
, component = f.filter_mean
, component_label = v2.mpage_param_value
, updated = f.updt_dt_tm "@SHORTDATETIME"
;, dm_value_dt = v2.updt_dt_tm "@SHORTDATETIME"
, updated_by = p.name_full_formatted
;,f.*
;, "************"
;, v2.*
from br_datamart_filter f
, br_datamart_value v2
, br_datamart_category c
, prsnl p
where f.filter_mean like "CUSTOM_COMP_*"
;and f.filter_display in ("Custom Component*section layout parameters") ;change if needed
and f.filter_category_mean = "MP_SECT_PARAMS"
and v2.br_datamart_filter_id = f.br_datamart_filter_id
and v2.end_effective_dt_tm &gt;= cnvtdatetime(curdate,curtime)
and v2.mpage_param_mean = "mp_label"
and v2.mpage_param_value in ("[+Old Component Name+]") ;affected value or component lable
and c.br_datamart_category_id = f.br_datamart_category_id
and c.category_type_flag = 1
;and c.category_name not in ("zzz*") ;make change this if needed
and p.person_id = outerjoin(v2.updt_id)
order by f.updt_dt_tm desc, v2.updt_dt_tm desc
WITH UAR_CODE(D), FORMAT(DATE,";;Q"), TIME=60


;UPDATE COMPONENTS
update into br_datamart_value v
set
;v.mpage_param_value = "Advance Directives", ; change to
v.mpage_param_value = "[+New Component Name+]",
v.updt_dt_tm = cnvtdatetime(curdate,curtime),
v.updt_id = 32913554.00,; REQINFO-&gt;UPDT_ID 
v.updt_cnt = v.updt_cnt +1
where v.br_datamart_value_id
in (
select v2.br_datamart_value_id
from br_datamart_filter f, br_datamart_value v2
where f.filter_display in ("Custom Component*section layout parameters")
and f.filter_mean like "CUSTOM_COMP_*"
and f.filter_category_mean = "MP_SECT_PARAMS"
and v2.br_datamart_filter_id = f.br_datamart_filter_id
and v2.end_effective_dt_tm &gt;= cnvtdatetime(curdate,curtime)
and v2.mpage_param_mean = "mp_label"
;and v2.mpage_param_value in ("Directives*Legal") ; change from
and v2.mpage_param_value in ("[+Old Component Name+]") ; change from
)
go commit
go
/** end of TASK0908411: Advance Directives custom component updates **/</Template><Template Name="mpt_request_number" Description="Requst Number Lookup in MTA files.">select
R.DESCRIPTION
, R.REQUEST_NAME
, R.REQUEST_NUMBER
, R.TEXT
, T.TASK_NUMBER
from
REQUEST   R
, TASK_REQUEST_R   T
plan r
join t where t.request_number = r.request_number

WITH NOCOUNTER, SEPARATOR="|", FORMAT
^</Template><Template Name="mpt_rule_tables" Description="Rule table information.">By default the EKS_ALERT_FLEX_A writes a row to the EKS_DLG_EVENT table.

EKS_LOG_ACTION_A writes to the EKS_DLG_AUDIT table.

Cerner suggests removing the EKS_LOG_ACTION_A from any synchronous rules that are already using the EKS_ALERT_* templates.

------------------ This information obtained through Cerner SR 451588921 Begin
 
Service Record: 451588921
Summary: EKS_DLG_AUDIT report retrieves an odd result
Description: john.arross@bannerhealth.com 
I ran the EKS_DLG_AUDIT for a rule we installed last month and got a curious result which I am hoping you can help me understand.
The report shows two trigger actions for what looks like a single firing of the rule. Asynch and Message.
Screenshot in the PHI section of this SR.
Since this is a rule using an openchart evoke, i'm not sure what is going on. Thank you in advance for the assistance.
Assigned To: Todd Willemsen 

It is probably because the rule uses the EKS_LOG_ACTION_A.  There is no need to use the EKS_LOG_ACTION_A in this rule.  
By default the EKS_ALERT_FLEX_A writes a row to the EKS_DLG_EVENT table.  This is a really important point. If you need a PREVIOUS_ACTION_L for synchronous rules in your logic, there is NO NEED to put LOG_ACTION in your actions. 
Asynch rules are a different story.They do need the log action for previous action to work

By adding in the EKS_LOG_ACTION_A you are actually writing two rows for every time the rule fires and results in the weird row in the EKS_DLG_AUDIT since that is the table it reads.
 
This was actually brought up yesterday by someone monitoring your system and seeing large numbers of writes to the EKS_DLG_EVENT table.  There is a large amount coming from EKS_LOG_ACTION_A templates in rules.  In a lot of cases they are there and don't need to be.  There are over 1200 uses of EKS_LOG_ACTION_A in active rules in the Prod domain.
 
I would suggest removing the EKS_LOG_ACTION_A from any synchronous rules that are already using the EKS_ALERT_* templates and also it seems like maybe it is added to lots of asynchronous rules when it really isn't necessary.  For instance the BHNRS_HEMODIALYSIS_TASK rule is on Order_event but then has the EKS_LOG_ACTION_A but doesn't have the EKS_PREVIOUS_ACTION_L in the logic.  Do you know why that would be included?  

Only the EKS_DLG_AUDIT reads the EKS_DLG_EVENT table.  Everything else like EKS_MONITOR and EKS_PERF_AUDIT are reading the EKS_MODULE_AUDIT and EKS_MODULE_AUDIT_DET tables which all rules write to regardless of event or templates used.
 
I would argue that if the EKS_DLG_EVENT table is being used to report on asynchronous rules that is against recommendations.  The EKS_MODULE_AUDIT should be used for that.  I'm sure there is some reason why it was thought to do this but long term I see this causing problems.

------------------ This information obtained through Cerner SR 451588921 End
^
</Template><Template Name="mpt_rules_CDSDB" Description="Discern Rules CDS Database">/*
CDS Database on PHX08794
To use: 
     execute [BHS\RLHolland].[GetRuleData3] @rulename1='BHADVSR_HIT', @begin_date = '2021/11/01', @end_date = '2022/01/31';
     execute [GetRuleData3] @rulename1='BHADVSR_HIT', @begin_date = '2021/11/01', @end_date = '2022/01/31';
*/

create procedure GetRuleData3
      @RuleName1 varchar(255) = 'xyzpdq',
      @begin_date datetime = NULL,     
      @end_date datetime = NULL  
AS    
SELECT
     rtrim(ltrim(replace(replace([AGE], char(10),''), char(13),''))) age            
     ,rtrim(ltrim(replace(replace([MED1], char(10),''), char(13),''))) med1            
     ,rtrim(ltrim(replace(replace([MED2], char(10),''), char(13),''))) med2            
     ,rtrim(ltrim(replace(replace([LAB1], char(10),''), char(13),''))) lab1            
     ,rtrim(ltrim(replace(replace([LAB2], char(10),''), char(13),''))) lab2            
     ,rtrim(ltrim(replace(replace([SCR], char(10),''), char(13),''))) scr            
     ,rtrim(ltrim(replace(replace([CRCL_M], char(10),''), char(13),''))) crcl_m            
     ,rtrim(ltrim(replace(replace([CRCL_F], char(10),''), char(13),''))) crcl_f            
     ,rtrim(ltrim(replace(replace([ACT_GRP_DESC], char(10),''), char(13),''))) act_grp_desc            
     ,rtrim(ltrim(replace(replace([PATIENT], char(10),''), char(13),''))) patient            
     ,rtrim(ltrim(replace(replace([UNIT], char(10),''), char(13),''))) unit            
     ,rtrim(ltrim(replace(replace([ROOM], char(10),''), char(13),''))) room            
     ,rtrim(ltrim(replace(replace([FACILITY], char(10),''), char(13),''))) facility            
     ,rtrim(ltrim(replace(replace([MRN], char(10),''), char(13),''))) mrn            
     ,rtrim(ltrim(replace(replace([ENCNTR_ID], char(10),''), char(13),''))) encntr_id            
     ,rtrim(ltrim(replace(replace([Discern_Rule], char(10),''), char(13),''))) discern_rule           
     ,rtrim(ltrim(replace(replace([begin_dt_tm], char(10),''), char(13),''))) begin_dt_tm            
     ,cast(rtrim(ltrim(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([BEGIN_DT_TM], char(10),''), char(13),''),'AEST', '') ,'AGT', '') ,'AKDT', '') ,'AKST', '') ,'AWST', '') ,'CDT', '') ,'CST', '') ,'EDT', '') ,'EEST', '') ,'EET', '') ,'ERR', '') ,'EST', '') ,'HST', '') ,'MDT', '') ,'MEST', '') ,'MET', '') ,'MSK', '') ,'MST', '') ,'PDT', '') ,'PST', '') ,'US/Arizona', '') ,'WEST', '') ,'WET', ''))) as datetime) begin_dt_tm_converted         
     ,parsename(replace(replace(replace(begin_dt_tm, ' ', '.'), ':',''),',.',''), 1) as TimeZone    
     ,rtrim(ltrim(replace(replace(cast([subject] as varchar(255)), char(10),''), char(13),''))) subject -- Cannot use replace on Text datatype.            
     ,rtrim(ltrim(replace(replace(cast([body] as varchar(255)), char(10),''), char(13),''))) body -- Cannot use replace on Text datatype.            
     ,[EMAIL_ID] email_id    
from    [BHS\RLHolland].[vw_discern_email]   -- The view ownership is now [dbo].[vw_discern_email]
where
    discern_rule   
in    (@RuleName1)   
and    begin_dt_tm_converted between @begin_date and @end_date   
order by
    begin_dt_tm_converted;

-- Create stored procedure GetRuleData4:
/*
create procedure GetRuleData4
      @RuleName1 varchar(255) = 'xyzpdq',
      @begin_date datetime = NULL,     
      @end_date datetime = NULL  
AS    
SELECT
     rtrim(ltrim(replace(replace([AGE], char(10),''), char(13),''))) age            
     ,rtrim(ltrim(replace(replace([MED1], char(10),''), char(13),''))) med1            
     ,rtrim(ltrim(replace(replace([MED2], char(10),''), char(13),''))) med2            
     ,rtrim(ltrim(replace(replace([LAB1], char(10),''), char(13),''))) lab1            
     ,rtrim(ltrim(replace(replace([LAB2], char(10),''), char(13),''))) lab2            
     ,rtrim(ltrim(replace(replace([SCR], char(10),''), char(13),''))) scr            
     ,rtrim(ltrim(replace(replace([CRCL_M], char(10),''), char(13),''))) crcl_m            
     ,rtrim(ltrim(replace(replace([CRCL_F], char(10),''), char(13),''))) crcl_f            
     ,rtrim(ltrim(replace(replace([ACT_GRP_DESC], char(10),''), char(13),''))) act_grp_desc            
     ,rtrim(ltrim(replace(replace([PATIENT], char(10),''), char(13),''))) patient            
     ,rtrim(ltrim(replace(replace([UNIT], char(10),''), char(13),''))) unit            
     ,rtrim(ltrim(replace(replace([ROOM], char(10),''), char(13),''))) room            
     ,rtrim(ltrim(replace(replace([FACILITY], char(10),''), char(13),''))) facility            
     ,rtrim(ltrim(replace(replace([MRN], char(10),''), char(13),''))) mrn            
     ,rtrim(ltrim(replace(replace([ENCNTR_ID], char(10),''), char(13),''))) encntr_id            
     ,rtrim(ltrim(replace(replace([Discern_Rule], char(10),''), char(13),''))) discern_rule           
     ,rtrim(ltrim(replace(replace([begin_dt_tm], char(10),''), char(13),''))) begin_dt_tm            
     ,cast(rtrim(ltrim(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([BEGIN_DT_TM], char(10),''), char(13),''),'AEST', '') ,'AGT', '') ,'AKDT', '') ,'AKST', '') ,'AWST', '') ,'CDT', '') ,'CST', '') ,'EDT', '') ,'EEST', '') ,'EET', '') ,'ERR', '') ,'EST', '') ,'HST', '') ,'MDT', '') ,'MEST', '') ,'MET', '') ,'MSK', '') ,'MST', '') ,'PDT', '') ,'PST', '') ,'US/Arizona', '') ,'WEST', '') ,'WET', ''))) as datetime) begin_dt_tm_converted         
     ,parsename(replace(replace(replace(begin_dt_tm, ' ', '.'), ':',''),',.',''), 1) as TimeZone    
     ,rtrim(ltrim(replace(replace(cast([subject] as varchar(255)), char(10),''), char(13),''))) subject -- Cannot use replace on Text datatype.            
     ,rtrim(ltrim(replace(replace(cast([body] as varchar(255)), char(10),''), char(13),''))) body -- Cannot use replace on Text datatype.            
     ,[EMAIL_ID] email_id    
from    [dbo].[vw_discern_email]   
where
    discern_rule   
in    (@RuleName1)   
and    begin_dt_tm_converted between @begin_date and @end_date   
order by
    begin_dt_tm_converted;

  execute show_storedprocedures;
  execute [GetRuleData4] @rulename1='BHADVSR_HIT', @begin_date = '2023/05/10', @end_date = '2023/05/11';
*/

SELECT
     rtrim(ltrim(replace(replace([AGE], char(10),''), char(13),''))) age            
     ,rtrim(ltrim(replace(replace([MED1], char(10),''), char(13),''))) med1            
     ,rtrim(ltrim(replace(replace([MED2], char(10),''), char(13),''))) med2            
     ,rtrim(ltrim(replace(replace([LAB1], char(10),''), char(13),''))) lab1            
     ,rtrim(ltrim(replace(replace([LAB2], char(10),''), char(13),''))) lab2            
     ,rtrim(ltrim(replace(replace([SCR], char(10),''), char(13),''))) scr            
     ,rtrim(ltrim(replace(replace([CRCL_M], char(10),''), char(13),''))) crcl_m            
     ,rtrim(ltrim(replace(replace([CRCL_F], char(10),''), char(13),''))) crcl_f            
     ,rtrim(ltrim(replace(replace([ACT_GRP_DESC], char(10),''), char(13),''))) act_grp_desc            
     ,rtrim(ltrim(replace(replace([PATIENT], char(10),''), char(13),''))) patient            
     ,rtrim(ltrim(replace(replace([UNIT], char(10),''), char(13),''))) unit            
     ,rtrim(ltrim(replace(replace([ROOM], char(10),''), char(13),''))) room            
     ,rtrim(ltrim(replace(replace([FACILITY], char(10),''), char(13),''))) facility            
     ,rtrim(ltrim(replace(replace([MRN], char(10),''), char(13),''))) mrn            
     ,rtrim(ltrim(replace(replace([ENCNTR_ID], char(10),''), char(13),''))) encntr_id            
     ,rtrim(ltrim(replace(replace([Discern_Rule], char(10),''), char(13),''))) discern_rule           
     ,rtrim(ltrim(replace(replace([begin_dt_tm], char(10),''), char(13),''))) begin_dt_tm            
     ,cast(rtrim(ltrim(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace([BEGIN_DT_TM], char(10),''), char(13),''),'AEST', '') ,'AGT', '') ,'AKDT', '') ,'AKST', '') ,'AWST', '') ,'CDT', '') ,'CST', '') ,'EDT', '') ,'EEST', '') ,'EET', '') ,'ERR', '') ,'EST', '') ,'HST', '') ,'MDT', '') ,'MEST', '') ,'MET', '') ,'MSK', '') ,'MST', '') ,'PDT', '') ,'PST', '') ,'US/Arizona', '') ,'WEST', '') ,'WET', ''))) as datetime) begin_dt_tm_converted         
     ,parsename(replace(replace(replace(begin_dt_tm, ' ', '.'), ':',''),',.',''), 1) as TimeZone    
     ,rtrim(ltrim(replace(replace(cast([subject] as varchar(255)), char(10),''), char(13),''))) subject -- Cannot use replace on Text datatype.            
     ,rtrim(ltrim(replace(replace(cast([body] as varchar(255)), char(10),''), char(13),''))) body -- Cannot use replace on Text datatype.            
     ,[EMAIL_ID] email_id    
from    [dbo].[vw_discern_email]   
where
    discern_rule   
in    ('BHADVSR_HIT')   
and    begin_dt_tm_converted between '2023-05-10 00:00:00.000' and '2023-05-11 23:59:00.000'   
order by
    begin_dt_tm_converted;
^</Template><Template Name="mpt_scp" Description="mpt_scp"># ----------------------------------------------------------------------------
# Script Author: Robert Holland 
# Script Name: getfiles.sh
# Creation Date: Wed May 31 2023 11:15:05 GMT-0700 (US Mountain Standard Time)
# Last Modified: 
# Copyright (c)2023
# Purpose: Copy necessary files from the backend.
# ----------------------------------------------------------------------------

scp rlholland@samtazapp14:/cerner/w_custom/b1805_cust/code/html/[+htmlfile+].html ./html/
scp rlholland@samtazapp14:/cerner/w_custom/b1805_cust/code/script/[+prg+].prg ./prg/
^</Template><Template Name="mpt_showFacilites" Description="mpt_showFacilites">;mx_test.prg
select ;into "nl:"
distinct(l.location_cd),
facility_name = uar_get_code_display(l.location_cd) ;facility name
, Facility_Code = uar_get_code_display(l.facility_accn_prefix_cd)
 
from
	location   l
	, location   lo
	, code_value cv1
	, code_value cv_lo
 
plan l
	where	l.location_type_cd = 783.00 ;facility(s)
	and		l.active_ind = 1
	and		l.patcare_node_ind = 1
 
; 	and l.location_cd =  4298880175.00	;bumcs
 
join lo
	where	lo.organization_id = l.organization_id
	and 	lo.active_ind = 1
	and		lo.location_type_cd = 794.00 ;nurse unit(s)
 
join cv1
	where	cv1.code_value = l.location_cd
	and		cv1.display_key not in ("BANNERHEALTH","STARTORGANIZAT","BPC")
 
join cv_lo
	where	cv_lo.code_value = lo.location_cd
;	and		cv_lo.display not in ("*TEST*","*TEST*") ;enabled when go live
 
order by
	facility_name
 
with nocounter, format, time=30
^</Template><Template Name="mpt_showFacilitiesUnits" Description="Show Facilities and Units">;mx_test.prg
select ;into "nl:"
l.location_cd,
l_location_disp = uar_get_code_display(l.location_cd) ;facility name
, ","
, lo.location_cd
, ";"
	, lo_location_disp = uar_get_code_display(lo.location_cd) ;unit name
	, l_facility_accn_prefix_disp = uar_get_code_display(l.facility_accn_prefix_cd)
 
from
	location   l
	, location   lo
	, code_value cv1
	, code_value cv_lo
 
plan l
	where	l.location_type_cd = 783.00 ;facility(s)
	and		l.active_ind = 1
	and		l.patcare_node_ind = 1
 
; 	and l.location_cd =  4298880175.00	;bumcs
 
join lo
	where	lo.organization_id = l.organization_id
	and 	lo.active_ind = 1
	and		lo.location_type_cd = 794.00 ;nurse unit(s)
 
join cv1
	where	cv1.code_value = l.location_cd
	and		cv1.display_key not in ("BANNERHEALTH","STARTORGANIZAT","BPC")
 
join cv_lo
	where	cv_lo.code_value = lo.location_cd
;	and		cv_lo.display not in ("*test*","*test*") ;enabled when go live
 
order by
	l_location_disp
	, lo_location_disp
 
with nocounter, format, time=30
^</Template><Template Name="mpt_sNow" Description="SNOW requests">Saved Cycle Templates:
	https://svcnowprod.service-now.com/sp/?id=catalog_saved_templates&amp;favorites=true
Accounts and Access:
	https://svcnowprod.service-now.com/sp?id=mc_category&amp;sys_id=c348533bdb952e043ca171dabf9619c3&amp;catalog_sys_id=e0d08b13c3330100c8b837659bba8fb4
Cerner Backend Account Creation/Password Reset:
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=6c6adfabdb3f81d08dce4a28139619ea
Cerner FirstNet request:
	https://svcnowprod.service-now.com/nav_to.do?uri=%2Fcom.glideapp.servicecatalog_cat_item_view.do%3Fv%3D1%26sysparm_id%3D51ea3f77db8674508dce4a2813961976%26sysparm_link_parent%3D9d92b51ddbf376003ca171dabf961999%26sysparm_catalog%3De0d08b13c3330100c8b837659bba8fb4%26sysparm_catalog_view%3Dcatalog_default%26sysparm_view%3Dtext_search
Cerner Functionality Investigation:
	https://svcnowprod.service-now.com/sp?id=sc_cat_item&amp;sys_id=db7c453c1b0cb150245f4009dc4bcba9
Nursing Informatics:
	https://svcnowprod.service-now.com/sp?id=sc_cat_item&amp;sys_id=af4ff8431b4c31d0245f4009dc4bcb6d
Cerner Olympus Account Creation
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=b5f64379db8899541c32255c8a96194b
Cerner Silent MTA (SMTA)
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=5d227510db4059d08dce4a2813961969	
Cycle Request Templates:
	https://svcnowprod.service-now.com/sp/?id=catalog_saved_templates&amp;favorites=true
Cybersecurity: BIM Administrators (for access to Diagnosis Insights content)
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=eccdd8f5db34b8908dce4a28139619d3
Discern Notification
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=4e193498dbb1c5508dce4a281396192b
Discern Rule or Advisor:
	https://svcnowprod.service-now.com/nav_to.do?uri=%2Fcatalog_find.do%3Fsysparm_parent%3D%26sysparm_catalog%3De0d08b13c3330100c8b837659bba8fb4%26sysparm_catalog_view%3Dcatalog_default%26sysparm_processing_hint%3Dsetfield%253Arequest.parent%2526%252361%253B39c19a60975465d8508fbdb0f053af37%26sysparm_tsgroups%3D%26sysparm_view%3Dtext_search%26sysparm_parent_sys_id%3D%26sysparm_parent_table%3D%26sysparm_view%3Dtext_search%26sysparm_collection%3D%26sysparm_collectionID%3D%26sysparm_collection_key%3D%26sysparm_search%3DNew%2BDiscern%2BRule%2Bor%2BAdvisor
IT Clinical: CCP/CDS/mPages Request:
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=d6697f5ddb317c148dce4a28139619e6
IT Clinical: Cerner Discern Rules Modify Discern Rule or Advisor
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=ab8fa8e0db4281181c32255c8a9619a3
IT Clinical: Cerner Discern Rules New Discern Rule or Advisor
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=04207c6cdbcac1548dce4a28139619a0
Request Catalogs:
	https://svcnowprod.service-now.com/sp/?id=bhs_catalogs
Server Access Request:
	https://svcnowprod.service-now.com/sp?id=sc_cat_item&amp;sys_id=fafcdfa3db8da9108dce4a2813961923
SQL Server:
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=b3929cd9dbe1c78092807aa9bf9619a1
SQL Server (Server Build: New or Refresh Server-Virtual, Physical and Vendor):
	https://svcnowprod.service-now.com/sp?id=sc_cat_item&amp;sys_id=aa7c1a5edbfdf1d08dce4a2813961978
Server Team:
	https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=d110473ddb3499108dce4a28139619bc

IT Clinical: Cerner Position Security
IT Clinical: Cerner Reporting
IT Clinical: CCP/CDS/mPages
IT Clinical: Environments Core
IT Clinical: Foundations Core
ISM: AD/DNS/IP
^</Template><Template Name="mpt_taskObjectLaunchIView" Description="Launch IView Bands using TaskObjectLaunchIView Function">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;meta name="author" content="Robert Holland"&gt;
  &lt;meta name="description" content="Template HTML Document"&gt;
  &lt;meta name="keywords" content="comma,separated,keywords"&gt;
  &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
  &lt;meta charset="UTF-8"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;script type="text/javascript" src="http://example.com/js/filename.js"&gt;&lt;/script&gt;
&lt;link rel="stylesheet" href="http://example.com/css/filename.css" /&gt;
&lt;/head&gt;

&lt;style&gt;
.green {background-color:#ABCC2A;}
&lt;/style&gt;

&lt;body&gt;

&lt;div&gt;
&lt;p&gt;
&lt;b&gt;Example 1:&lt;/b&gt;&lt;br /&gt;
taskObject.LaunchIView("adult care and treatment", "Notification Record", "Clinical", perID, encID ); //launches IView application for provided patientId and encounterId&lt;br /&gt;
&lt;br /&gt;
&lt;b&gt;Example 2:&lt;/b&gt;&lt;br /&gt;
// open iVew form item - Cerner API: LaunchIView&lt;br /&gt;
		$('.iView').click(function(){&lt;br /&gt;
&lt;br /&gt;
			var patientId = $(this).attr("id").toString();&lt;br /&gt;
			var encounterId = $(this).attr("val").toString();&lt;br /&gt;
			var bandName = "adult care and treatment"; // all in lower cases&lt;br /&gt;
			var sectionName = "Activities of Daily Living";&lt;br /&gt;
			var eventSetName = ""; //"Ambulation Total Current Day"; // it does not matter what is here?&lt;br /&gt;
&lt;br /&gt;
			var taskObject = window.external.DiscernObjectFactory("TASKDOC"); //creates task documentation object&lt;br /&gt;
			taskObject.LaunchIView(&lt;span class="green"&gt;bandName, sectionName, eventSetName,&lt;/span&gt; patientId, encounterId);&lt;br /&gt;
		});&lt;br /&gt;
&lt;br /&gt;
&lt;b&gt;Example 3:&lt;/b&gt;&lt;br /&gt;
custom-components.js:&lt;br /&gt;
tempStr.push("&lt;tr&gt;&lt;td&gt;&lt;a class ='xxxxxxx'&gt;Link To IView Band&lt;/a&gt;&lt;/td&gt; &lt;/tr&gt;");&lt;br /&gt;
	$(".xxxxxxx").click(function() {&lt;br /&gt;
	var taskObject = window.external.DiscernObjectFactory("TASKDOC"); //creates task documentation object&lt;br /&gt;
	taskObject.LaunchIView("adult care and treatment", "Notification Record", "Clinical", personID, encID); //launches IView application for provided patientId and encounterId&lt;br /&gt;
	});&lt;br /&gt;
&lt;/p&gt;
&lt;b&gt;Example of Powerchart Table of Contents:&lt;/b&gt;&lt;br /&gt;
&lt;img src='data:image/png;base64,
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
' /&gt;
&lt;br /&gt;
&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;</Template><Template Name="mpt_TempBedrock" Description="Bedrock mPage Template">;Program Author: [+Author+]
;Program Name: 1bh_mpage_[+NameSpace+].prg
;Creation Date: [DATE_TEXT] [TIME]
;Last Modified:
;Copyright (c)[DATE_USER]yyyy[DATE_USER_END]
;Purpose:
;Request #:
;Namespace: banner.[+NameSpace+]
;Delete this line: [+NAMESPACEUPPERCASE+]
;----------------------------------------------------------------------------
;free record request go
;/*Add any fields and data type in your "record request" that your CCL will need to run.*/
;
;record request
;( 	;1 encntr_id = i4
;	1 per_id = i4
;	1 enc_id = i4
;	;1 cvalue = i4
;) go
;
;/*Setting the request equal to the Encounter ID that will be sent from PowerChart.
;This information is manually entered here when testing. */
;
;	set request-&gt;per_id = 123456789.00 go
;	set request-&gt;enc_id = 987654321.00 go
;
;/*The CCL that you want to execute to produce the data. */
;
;	execute 1bh_mpage_[+NameSpace+] "MINE", request-&gt;per_id, request-&gt;enc_id go

;----------------------------------------------------------------------------

drop program 1bh_mpage_[+NameSpace+]:dba go
create program 1bh_mpage_[+NameSpace+]:dba

prompt
	"Output to File/Printer/MINE" = "MINE"   ;* Enter or select the printer or file name to send this report to.
	, "per_id" = 0
	, "enc_id" = 0

with OUTDEV, per_id, enc_id

%i cust_script:1samt_az_common.inc
;%i cust_script:1samt_az_common_cds.inc
;PROGRAM HEADER ABOVE

/*Begin Record Structure*/
;Record structure elements can be lowercase here but must be uppercase in your .js.
free record [+NameSpace+]_structure
record [+NameSpace+]_structure (
1 [+NameSpace+]_structure_cnt=i4
1 [+NameSpace+]_structure_array[*]
/*Create record structure aliases and assign the proper data type that will match the columns in your query*/
	2 returned_person_id = f8 ; Assiging a name and data type to a value returned from the select statement.
	2 returned_name_full_formatted = vc ; Assiging a name and data type to a value returned from the select statement.
	2 returned_encounter_id = f8 ; Assiging a name and data type to a value returned from the select statement.
	2 returned_encounter_type = vc ; Assiging a name and data type to a value returned from the select statement.
	2 returned_mrn = vc ;
	2 returned_fin = vc ;


%i cclsource:status_block.inc
)
/*End Record Structure*/

set [+NameSpace+]_structure-&gt;status_data.status ="F"
set debug_ind = 1

declare fin_alias = vc
declare mrn_alias = vc

select
	ea.alias

from
	encntr_alias ea

where ea.encntr_id = $enc_id;72958204.00;$enc_id;
and ea.encntr_alias_type_cd in (1077.00, 1079.00);FIN Number and MRN Number
detail
case (ea.encntr_alias_type_cd)
	of 1077.00 : fin_alias = trim(ea.alias)
	of 1079.00 : mrn_alias = trim(ea.alias)
endcase

/*Select Query Begin*/

select ;into "NL"
	p.person_id
	,p.name_full_formatted
	,e.encntr_id
	,Encounter_Type = uar_get_code_display(e.encntr_type_cd)

from
	person p
	, encounter e

plan p where p.person_id = $per_id ;37298420.00
join e where e.person_id = p.person_id and e.encntr_id = $enc_id ;54975811.00

/*Select Query End*/

head report
x=1
rec_cnt = 0 ; Setting record count to zero.

/*The "Head" section is most important part of what you are pulling from your query. Example:
You could have "head p.person_id" and under that you need to return data from the query into it. */

head p.person_id ;alias.fieldname | Opening the header. Should be an indexed column.
rec_cnt=rec_cnt+1

   if (size([+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array,5)&lt;rec_cnt ) ; Checking the size of the [+NameSpace+]_structure_array array
      stat= alterlist([+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array, rec_cnt+10) ; this is increasing the size of the [+NameSpace+]_structure_array array by 10 if needed.
   endif

/*Returning column data from the query into the record structure aliases*/
[+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array[rec_cnt].returned_person_id = cnvtreal(p.person_id)
[+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array[rec_cnt].returned_name_full_formatted = trim(p.name_full_formatted)
[+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array[rec_cnt].returned_encounter_id = cnvtreal(e.encntr_id)
[+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array[rec_cnt].returned_encounter_type = trim(Encounter_Type)
[+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array[rec_cnt].returned_mrn = mrn_alias
[+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array[rec_cnt].returned_fin = fin_alias

foot p.person_id ;alias.fieldname | Closing the header. Same name as head.
x=1
foot report
x=1
stat= alterlist([+NameSpace+]_structure-&gt;[+NameSpace+]_structure_array, rec_cnt)
[+NameSpace+]_structure-&gt;[+NameSpace+]_structure_cnt = rec_cnt
with nocounter

set [+NameSpace+]_structure-&gt;status_data.status = "S"   ;info_point (Sets status to S for Success)

#exit_script   ;  ID for end of PRG

call ajax_reply([+NameSpace+]_structure) 	; info_point (ajax_reply is a function that changes the
							;record structure to a string.

call echo(cnvtrectojson([+NameSpace+]_structure)) 	; info_point (cnvtrectojson is a function that changes the
							;record structure to a JSON string and returns the string to the JS).

if (debug_ind)
	call echorecord([+NameSpace+]_structure)  ;info_point (displays record structure in listing - troubleshooting)
else
	free record [+NameSpace+]_structure  ;info_point (clears record structure)
endif

CALL log_end_script("1bh_mpage_[+NameSpace+]", debug_ind) ; info_point (For log files)

end
go

/*JS NAMESPACE BELOW*/
//BEGIN [+NameSpace+]
/**
* Project:
* Version: 1.0
* Released:	[DATE_TEXT] [TIME]
* Updated:
* Purpose:
* @author: [+Author+]
* Request#:
*/

MPage.namespace("banner");
banner.[+NameSpace+] = function(){};
banner.[+NameSpace+].prototype = new MPage.Component();
banner.[+NameSpace+].prototype.constructor = MPage.Component();
banner.[+NameSpace+].prototype.base = MPage.Component.prototype;
banner.[+NameSpace+].prototype.name = "banner.[+NameSpace+]";
banner.[+NameSpace+].prototype.cclProgram = "1bh_mpage_[+NameSpace+]";
banner.[+NameSpace+].prototype.cclParams = [];
banner.[+NameSpace+].prototype.cclDataType = "JSON";

banner.[+NameSpace+].prototype.init = function(options)
{
//	// Check cookie for param update
//	if(readCookie("bldgltframe") == null){
//		createCookie("bldgltframe","72,H",1);
//	}

	var params = [];
	params.push("mine");
	params.push(this.getProperty("personId"));
	params.push(this.getProperty("encounterId"));
//	params.push(readCookie("bldgltframe"));
	params.push(300);
	this.cclParams = params;
};

banner.[+NameSpace+].prototype.render = function()
{
	var tempStr=[];
	var element = this.getTarget();
	var jsonObj = this.data;
    var recordData = jsonObj.RECORD_DATA;
	var compid = this.getComponentUid();
	MPage.getCustomComp(compid).setProperty("headerSubTitle","");

//alert("Hello World");
	tempStr.push("&lt;div&gt;");
	tempStr.push("&lt;table&gt;");
	tempStr.push("&lt;tr&gt;&lt;td&gt;",this.name,"&lt;/td&gt;&lt;/tr&gt;");
	tempStr.push("&lt;tr&gt;&lt;td&gt;PID: ",this.getProperty("personId"),"&lt;/td&gt;&lt;/tr&gt;");
	tempStr.push("&lt;tr&gt;&lt;td&gt;EID: ",this.getProperty("encounterId"),"&lt;/td&gt;&lt;/tr&gt;");
	tempStr.push("&lt;tr&gt;&lt;td&gt;",recordData.STATUS_DATA.STATUS,"&lt;/td&gt;&lt;/tr&gt;");
	tempStr.push("&lt;tr&gt;&lt;td&gt;",recordData.[+NAMESPACEUPPERCASE+]_STRUCTURE_ARRAY_CNT,"&lt;/td&gt;&lt;/tr&gt;");
	tempStr.push("&lt;tr&gt;&lt;td&gt;",recordData.[+NAMESPACEUPPERCASE+]_STRUCTURE_ARRAY[0].RETURNED_MRN,"&lt;/td&gt;&lt;/tr&gt;");
		for (var a = 0, aa = recordData.[+NAMESPACEUPPERCASE+]_STRUCTURE_CNT; a &lt; aa; a++) {
			tempStr.push("&lt;tr&gt;&lt;td&gt;",recordData.[+NAMESPACEUPPERCASE+]_STRUCTURE_ARRAY[a].RETURNED_MRN,"&lt;/td&gt;&lt;/tr&gt;");
		}
	tempStr.push("&lt;/table&gt;");
	tempStr.push("&lt;/div&gt;");
	element.innerHTML = tempStr.join("");

};

// END [+NameSpace+] </Template><Template Name="mpt_TempCustom" Description="Custom mPage Template">Template
Script Author: [+Author+]
Program Name: [+Component mPage Name+].prg
Program Name: [+Component mPage Name Uppercase+].prg
Foldername on SAMTAZNAS: [+Component mPage Folder+]
CAPITALIZED FOLDERNAME [+Component mPage Folder Capitalized+]
After development the JavaScript can be placed in \\samtaznas\samtaz\b1805\winintel\static_content\custom_mpage_content\mpages\1bh_master_lib\js\1samt_az_javascript.js
;----------------------------------------------------------------------------

###MPAGE TEMPLATE [DATE_TEXT] [TIME]

###HTML SECTION FOR LINUX NODE BEGIN:
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
&lt;?xml version="1.0" encoding="UTF-8" ?&gt;
&lt;html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en"&gt;
&lt;!-- [+Component mPage Name+].html --&gt;
&lt;!-- Author: [+Author+] --&gt;
&lt;!-- Creation Date: [DATE_TEXT] [TIME] --&gt;

&lt;head&gt;
	&lt;title&gt;&lt;/title&gt;
    &lt;meta http-equiv="Content-Type" content="APPLINK,CCLLINK,MPAGES_EVENT,XMLCCLREQUEST,CCLLINKPOPUP,CCLNEWSESSIONWINDOW" name="discern"/&gt;
	&lt;link rel="stylesheet" type="text/css" href="\\samtaznas\samtaz\b1805\winintel\static_content\custom_mpage_content\mpages\1bh_master_lib\css\1samt_az_css.css" /&gt;
	&lt;link rel="stylesheet" type="text/css" href="\\samtaznas\samtaz\b1805\winintel\static_content\custom_mpage_content\mpages\[+Component mPage Folder+]\css\[+Component mPage Name+].css" /&gt;

&lt;/head&gt;
&lt;body onload="javascript:RenderPage2();"&gt;
&lt;h1&gt;&lt;/h1&gt;
&lt;hr/&gt;
&lt;div id="demo_bar"&gt;&lt;/div&gt;

&lt;a href="javascript:feedbackLink()"&gt;Feedback&lt;/a&gt;
&lt;!-- ******************* --&gt;
&lt;DIV id="componentPlaceHolder" class="col-group-2"&gt;&lt;!--Set class to 2 column mpage --&gt;
&lt;DIV id="col1PlaceHolder" class="col1"&gt;&lt;!--Set class for 1st column on page --&gt;
&lt;div id="[+Component mPage Folder+]" class="component2"&gt;&lt;/div&gt;

&lt;/DIV&gt;


&lt;DIV id="col2PlaceHolder" class="col2"&gt;&lt;!--Set class for 2nd column on page --&gt;
&lt;div id="1bh_mpage_programtemplate" class="component2"&gt;&lt;/div&gt;
&lt;/DIV&gt;
&lt;/DIV&gt;

&lt;/body&gt;
&lt;script type="text/javascript" src="\\samtaznas\samtaz\b1805\winintel\static_content\custom_mpage_content\mpages\[+Component mPage Folder+]\js\[+Component mPage Name+].js"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="\\samtaznas\samtaz\b1805\winintel\static_content\custom_mpage_content\mpages\1bh_master_lib\js\1samt_az_javascript.js"&gt;&lt;/script&gt;


&lt;script type="text/javascript"&gt;
var mpage_data_JSON = &lt;$MPAGE_DATA$&gt;;
var MP_DATA = mpage_data_JSON.MPAGE_DATA;
&lt;/script&gt;
&lt;script type="text/javascript"&gt;

function feedbackLink()
{
var url="http://intranet7.bannerhealth.com/CernerFeedBack/Default.aspx?typ=1&amp;fb=[+Component mPage Folder+]";
url +="(ENCNTR_ID: $vis_encntrid$\/"
url +="PERSON_ID: $pat_personid$\/"
url +="PRSNL_ID: $usr_personid$)"
var obj = APPLINK(100,url,"");
}
&lt;/script&gt;
&lt;/html&gt;

###HTML SECTION FOR AIX NODE END:

###JAVASCRIPT SECTION BEGIN:
// ----------------------------------------------------------------------------
// Script Author: [+Author+]
// Program Name: [+Component mPage Name+].js
// Related Files: [+Component mPage Name+].html, [+Component mPage Name+].prg
// Creation Date: [DATE_TEXT] [TIME]
// Last Modified:
// Copyright: (c)[DATE_USER]yyyy[DATE_USER_END]
// Purpose:
// Request #:
// ----------------------------------------------------------------------------


function Run[+Component mPage Folder+]Component()
{
	var COMPONENT = new Component("[+Component mPage Folder+]", "[+Component mPage Name Uppercase+]", "CCL Program Template");
	COMPONENT.HandleSuccess = function(recordData)
	{ //The [+Component mPage Folder Capitalized+]_STRUCTURE_CNT and [+Component mPage Folder Capitalized+]_STRUCTURE_ARRAY must be uppercase.
		var tempStr = ["&lt;h3 class='header'&gt;",this.headerName," count(",recordData.[+Component mPage Folder Capitalized+]_STRUCTURE_CNT,")&lt;span class='ce' id='",this.id,"_ce'&gt;&lt;/span&gt;&lt;/h3&gt;&lt;div class='component-content'&gt;&lt;table&gt;"];
	if(recordData.[+Component mPage Folder Capitalized+]_STRUCTURE_CNT&gt;0)
	{
//alert(recordData.[+Component mPage Folder Capitalized+]_STRUCTURE_CNT);

//BEGIN TABLE DATA
		for(var i=0,all_cnt=recordData.[+Component mPage Folder Capitalized+]_STRUCTURE_CNT;i&lt;all_cnt;i++)
		{
var xxyy=recordData.[+Component mPage Folder Capitalized+]_STRUCTURE_ARRAY[i].RETURNED_PERSON_ID;
//alert(xxyy);
		tempStr.push("&lt;tr&gt;&lt;th&gt;Bold Column Header&lt;/th&gt;&lt;/tr&gt;");
		tempStr.push("&lt;tr&gt;&lt;td&gt;Normal Column data&lt;/td&gt;&lt;/tr&gt;");
		tempStr.push("&lt;tr&gt;&lt;td class='bold'&gt;Bold Column data&lt;/td&gt;&lt;/tr&gt;");
		tempStr.push("&lt;tr&gt;&lt;td&gt;",xxyy,"&lt;/td&gt;&lt;/tr&gt;");

			alert(recordData.[+Component mPage Folder Capitalized+]_STRUCTURE_CNT);
			alert(recordData.[+Component mPage Folder Capitalized+]_STRUCTURE_ARRAY[i].RETURNED_PERSON_ID);
		}

	}
	else
	{
	tempStr.push("&lt;tr&gt;&lt;td colspan='3' class='bold'&gt;No Data Documented&lt;/td&gt;&lt;/tr&gt;");
	}
		tempStr.push("&lt;/table&gt;&lt;/div&gt;");
		var aObj = SAMT_AZ._g(COMPONENT.id);
		aObj.style.display = "";
		aObj.innerHTML = tempStr.join("");
		this.setupToggle("E");
		this.setupTooltips();
	};
	COMPONENT.HandleNoData = function(recordData)
	{
		var aObj = SAMT_AZ._g(COMPONENT.id);
		aObj.style.display = "";
		aObj.innerHTML = ["&lt;h3 class='header'&gt;",this.headerName,"&lt;span class='ce' id='",this.id,"_ce'&gt;&lt;/span&gt;&lt;/h3&gt;&lt;div class='component-content'&gt;No Data Found&lt;/div&gt;"].join("");
		this.setupToggle("E");
	};
	COMPONENT.HandleDataError = function(recordData)
	{
		var aObj = SAMT_AZ._g(COMPONENT.id);
		aObj.style.display = "";
		aObj.innerHTML = ["&lt;h3 class='header'&gt;",this.headerName,"&lt;span class='ce' id='",this.id,"_ce'&gt;&lt;/span&gt;&lt;/h3&gt;&lt;div class='component-content'&gt;Error Retrieving Results&lt;/div&gt;"].join("");
		this.setupToggle("E");
	};
	var sendArr = ["^^MINE^^",MP_DATA.PERSON_ID,MP_DATA.ENCNTR_ID];
//	alert(sendArr);
	SAMT_AZ.XMLCclRequestWrapper(COMPONENT, sendArr);
}

###JAVASCRIPT SECTION END:

###CCL PROGRAM SECTION BEGIN:
;Script Author: [+Author+]
;Program Name: [+Component mPage Name+].prg
;Related Files: [+Component mPage Name+].html, [+Component mPage Name+].js
;Creation Date: [DATE_TEXT] [TIME]
;Last Modified:
;Copyright: (c)[DATE_USER]yyyy[DATE_USER_END]
;Purpose:
;Request #:
;Foldername on PHX00027: [+Component mPage Folder+]
;----------------------------------------------------------------------------
;free record request go
;/*Add any fields and data type in your "record request" that your CCL will need to run.*/
;
;record request
;( 	;1 encntr_id = i4
;	1 per_id = i4
;	1 enc_id = i4
;	;1 cvalue = i4
;) go
;
;/*Setting the request equal to the Encounter ID that will be sent from PowerChart.
;This information is manually entered here when testing. */
;
;	set request-&gt;per_id = 123456789.00 go
;	set request-&gt;enc_id = 987654321.00 go
;
;/*The CCL that you want to execute to produce the data. */
;
;	execute [+Component mPage Name+] "MINE", request-&gt;per_id, request-&gt;enc_id go

;----------------------------------------------------------------------------

drop program [+Component mPage Name+]:dba go
create program [+Component mPage Name+]:dba

prompt
	"Output to File/Printer/MINE" = "MINE"   ;* Enter or select the printer or file name to send this report to.
	, "per_id" = 0
	, "enc_id" = 0

with OUTDEV, per_id, enc_id

%i cust_script:1samt_az_common.inc
;%i cust_script:1samt_az_common_cds.inc
;PROGRAM HEADER ABOVE

/*Begin Record Structure*/
;Record structure elements can be lowercase here but must be uppercase in your .js.
free record [+Component mPage Folder+]_structure
record [+Component mPage Folder+]_structure (
1 [+Component mPage Folder+]_structure_cnt=i4
1 [+Component mPage Folder+]_structure_array[*]
/*Create record structure aliases and assign the proper data type that will match the columns in your query*/
	2 returned_person_id = f8 ; Assiging a name and data type to a value returned from the select statement.
	2 returned_name_full_formatted = vc ; Assiging a name and data type to a value returned from the select statement.
	2 returned_encounter_id = f8 ; Assiging a name and data type to a value returned from the select statement.
	2 returned_encounter_type = vc ; Assiging a name and data type to a value returned from the select statement.
	2 returned_mrn = vc ;
	2 returned_fin = vc ;


%i cclsource:status_block.inc
)
/*End Record Structure*/

set [+Component mPage Folder+]_structure-&gt;status_data.status ="F"
set debug_ind = 1

declare fin_alias = vc
declare mrn_alias = vc

select
	ea.alias

from
	encntr_alias ea

where ea.encntr_id = $enc_id;72958204.00;$enc_id;
and ea.encntr_alias_type_cd in (1077.00, 1079.00);FIN Number and MRN Number
detail
case (ea.encntr_alias_type_cd)
	of 1077.00 : fin_alias = trim(ea.alias)
	of 1079.00 : mrn_alias = trim(ea.alias)
endcase

/*Select Query Begin*/

select ;into "NL"
	p.person_id
	,p.name_full_formatted
	,e.encntr_id
	,Encounter_Type = uar_get_code_display(e.encntr_type_cd)

from
	person p
	, encounter e

plan p where p.person_id = $per_id ;37298420.00
join e where e.person_id = p.person_id and e.encntr_id = $enc_id ;54975811.00

/*Select Query End*/

head report
x=1
rec_cnt = 0 ; Setting record count to zero.

/*The "Head" section is most important part of what you are pulling from your query. Example:
You could have "head p.person_id" and under that you need to return data from the query into it. */

head p.person_id ;alias.fieldname | Opening the header. Should be an indexed column.
rec_cnt=rec_cnt+1

   if (size([+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array,5)&lt;rec_cnt ) ; Checking the size of the foldername_structure_array array
      stat= alterlist([+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array, rec_cnt+10) ; this is increasing the size of the foldername_structure_array array by 10 if needed.
   endif

/*Returning column data from the query into the record structure aliases*/
[+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array[rec_cnt].returned_person_id = cnvtreal(p.person_id)
[+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array[rec_cnt].returned_name_full_formatted = trim(p.name_full_formatted)
[+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array[rec_cnt].returned_encounter_id = cnvtreal(e.encntr_id)
[+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array[rec_cnt].returned_encounter_type = trim(Encounter_Type)
[+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array[rec_cnt].returned_mrn = mrn_alias
[+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array[rec_cnt].returned_fin = fin_alias

foot p.person_id ;alias.fieldname | Closing the header. Same name as head.
x=1
foot report
x=1
stat= alterlist([+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_array, rec_cnt)
[+Component mPage Folder+]_structure-&gt;[+Component mPage Folder+]_structure_cnt = rec_cnt
with nocounter


set [+Component mPage Folder+]_structure-&gt;status_data.status = "S"   ;info_point (Sets status to S for Success)

#exit_script   ;  ID for end of PRG

call ajax_reply([+Component mPage Folder+]_structure) 	; info_point (ajax_reply is a function that changes the
							;record structure to a string.

call echo(cnvtrectojson([+Component mPage Folder+]_structure)) 	; info_point (cnvtrectojson is a function that changes the
							;record structure to a JSON string and returns the string to the JS).

if (debug_ind)
	call echorecord([+Component mPage Folder+]_structure)  ;info_point (displays record structure in listing - troubleshooting)
else
	free record [+Component mPage Folder+]_structure  ;info_point (clears record structure)
endif

CALL log_end_script("[+Component mPage Name+]", debug_ind) ; info_point (For log files)

end
go

###CCL PROGRAM SECTION END:

###1BH_MPAGE_HOME1.JS FILE BEGIN:
function [+Component mPage Folder+](){
		 CCLLINK("1samt_az_run_mpage","^^MINE^^,value($pat_personid$),value($vis_encntrid$),0,^^cust_html:[+Component mPage Name+].html^^",1);
}
###1BH_MPAGE_HOME1.JS FILE END:

###TESTLINK.JS FILE BEGIN:
tempStr.push("&lt;p&gt;&lt;a href='javascript:[+Component mPage Folder+]();'&gt;[+Component mPage Folder+]&lt;/a&gt;&lt;/p&gt;");
###TESTLINK.JS FILE END:

###WINDOWS COMMAND PROMPT BEGIN:
md [+Component mPage Folder+]\js [+Component mPage Folder+]\css [+Component mPage Folder+]\prg [+Component mPage Folder+]\img
###WINDOWS COMMAND PROMPT END: 
^
</Template><Template Name="mpt_TOCPositions_by_Name" Description="Find positions that have access to TOC mPage Name.">Seems to work on buttons as well.

[+mPage Name on TOC+] Examples: Acute View, Oncology View, PMP Gateway (AZ/NV Only)
[+The Position Name+]
[+The Position Code+]
Seems to work on buttons as well.

select
TOC_Name = n.pvc_value
,Application = app.description
;, n.updt_dt_tm";;"
;, v.updt_dt_tm
;, n2.updt_dt_tm
;, n3.updt_dt_tm
;, dp.updt_dt_tm
;,v.position_cd
, Position_Display = evaluate(
  uar_get_code_display(v.position_cd)
  , " ", "-GLOBAL-"
  , uar_get_code_display(v.position_cd), uar_get_code_display(v.position_cd)
  )
, v.frame_type
;, n3.name_value_prefs_id
;, n2.name_value_prefs_id
, Updated_By = p.name_full_formatted
, Report_Param = evaluate(  ;;;;;;;;;;;;;;;;;;;;;;;;;  Parameter with detail
  n2.pvc_value
  , " ", "-Not Set-"
  , n2.pvc_value, n2.pvc_value
  )
, Report_Name = evaluate(
  n3.pvc_value
  , " ", "-Not Set-"
  , n3.pvc_value, n3.pvc_value
  )

from
name_value_prefs n
, view_prefs v
, code_value cv
, application app
, name_value_prefs n2
, name_value_prefs n3
, detail_prefs dp
, person p
plan n where n.pvc_name = outerjoin("VIEW_CAPTION"); and n.pvc_value = "TOC NAME"
join v where n.parent_entity_id = v.view_prefs_id and n.pvc_value = "[+mPage Name on TOC+]" ;Name on TOC or Button
;and v.position_cd = (select x.code_value from code_value x where x.display = "[+The Position Name+]" and x.code_set = 88); Show TOC links for the position name.
;and v.position_cd = [+The Position Code+]; Show TOC links for the position code.
and v.view_name IN ( "DISCERNRPT" , "MCDISCERNRPT")
and  v.frame_type in ("CHART","ORG") ;Updated to show both. RH
join app where v.application_number = app.application_number
join cv where cv.code_value = v.position_cd
	and (
		(
			cv.active_ind = 1
			and cv.display_key != "ZZ*"
		)
			or cv.code_value = 0
		)
join dp where dp.application_number = v.application_number
and dp.position_cd = v.position_cd
and dp.view_name IN ( "DISCERNRPT" , "MCDISCERNRPT")
and dp.view_seq = v.view_seq
and dp.person_id = 0
join n2 where n2.parent_entity_id = outerjoin(dp.detail_prefs_id)
and n2.pvc_name = outerjoin("REPORT_PARAM")
;Look for view identifier (comment position_cd):
;and n2.pvc_name = outerjoin("REPORT_PARAM") and n2.pvc_value like "*ONCOLOGYAMBULATORYSUMMARY*"
join n3 where n3.parent_entity_id = dp.detail_prefs_id
;and n3.pvc_value like "*driver*" ;Wildcard to show all drivers. RH
and n3.pvc_name = "REPORT_NAME"
join p where n3.updt_id = p.person_id
order by Position_Display
with time = 90;
^</Template><Template Name="mpt_uar" Description="UAR_GET_">with uar_code(d), format(date,";;q")
display_key=UAR_GET_DISPLAYKEY(ce.event_cd)

UAR_GET_CODE_BY(alias.column_name)
UAR_GET_CODE_BY_CKI("CKI.CODEVALUE!1005613")
UAR_GET_CODE_DESCRIPTION(alias.column_name)
UAR_GET_CODE_DISPLAY(alias.column_name)
UAR_GET_CODE_MEANING(alias.column_name)
UAR_GET_DEFINITION(alias.column_name)
UAR_GET_DISPLAYKEY(alias.column_name)
UAR_GET_MEANING_BY_CODESET(alias.column_name)
^
</Template><Template Name="mpt_unexpectedErrorOnBedrockFilter" Description="mpt_unexpectedErrorOnBedrockFilter">; ----------------------------------------------------------------------------
; Script Author: Robert Holland
; Script Name:
; Creation Date: Thu Jun 18 2020 15:58:21 GMT-0700 (US Mountain Standard Time)
; Last Modified:
; Copyright (c)2020
; Purpose: Delete rows from br_datamart_value table that are causing the following error on component filters.
; An unexpected error has occurred. Please contact your system administrator and provide the log file.
; ----------------------------------------------------------------------------

What is the [+filter_id+]
To get the necessary information from the log file, run Bedrock with Control + Shift + I and reproduce the error.
Open the log file and look for the name of the filter that is producing the error. You should see the br_datamart_filter_id a few lines above the filter name.

	select 
  	br_datamart_value_id
  	,freetext_desc
  	,sequence_order = value_seq
  	,code_value = parent_entity_id
  	,cv_display = uar_get_code_display(parent_entity_id)
  	,br_datamart_filter_id
  	,br_datamart_category_id
  	,parent_entity_name
  	;,*
	from 
		br_datamart_value 
	where 
		br_datamart_filter_id = [+filter_id+]

Make a copy of the data before deleting it
After running the delete statement cycle server 535 then update the filter

	delete from br_datamart_value where br_datamart_filter_id = [+filter_id+] go
	commit go
^
</Template><Template Name="mpt_usergroups" Description="Display groups for user.">select
	pgr.person_id
	, pgr.prsnl_group_id
	, pg.prsnl_group_desc
	, pg.prsnl_group_type_cd
	, p.name_full_formatted
	, pr_position_disp = uar_get_code_display(pr.position_cd)
	, pg.*
 
from
	prsnl_group   pg
	, prsnl_group_reltn   pgr
	, person   p
	, dummyt   d1
	, prsnl   pr
 
;	, dummyt   d2
plan p where p.person_id in (
   [+Person_ID+]
)
join pr where pr.person_id = p.person_id
join d1
join pgr where pgr.person_id = pr.person_id  and pgr.active_ind=1
 
;join d2
join pg where pg.prsnl_group_id = pgr.prsnl_group_id
order by pgr.prsnl_group_id
with uar_code(d), format(date,";;q")
^</Template><Template Name="mpt_UserToDBA" Description="Drop and create user as DBA">;Drop/Create User as DBA
drop program user_to_dba go
create program user_to_dba

prompt "MINE" = "MINE"

with outdev
DROP CCLUSER [+USERNAME+]
commit
CREATE CCLUSER [+USERNAME+] TO DBA
commit
end go

;Only a group0 can create or modify a group0
;create ccluser [+USERNAME+] to GROUP0 go

;Backend (Node specific) - run on each node):
DROP CCLUSER [+USERNAME+] go
commit go
CREATE CCLUSER [+USERNAME+] TO DBA go
commit go

;Run on each node:
select * 
from DUAF 
where
user_name = "[+USERNAME+]"
go

;https://wiki.cerner.com/display/public/1101discernHP/CCLUAF+using+Discern+Explorer
CCLUAF GO

;Current user can run this (https://connect.ucern.com/message/1819510#1819510):
;Include compile:
call echo(curgroup) go ;Need to run on each server.

;On the DVDev dropdown menu, go to Build--&gt;Run Prompt Program, and type "CCLUAF" then click "Run". **Need to run on each server.

;Search for multiple users. Run on each server.
select
	d.platform,
	d.rcode,
	d.user_name,
	d.group,
	d.group_name,
	d.datestamp,
	d.stat,
	d.cclcount,
	nodename=build2(curnode)
from duaf d
where
user_name in (
	"RLHOLLAND"
	, "PRHOLLAND"
	, "PCAUNTALAN"
	, "VENAALUKO"
	, "PMXIE"
	, "MXIE"
	, "KDEME"
	, "RSOLIMAN"
	, "TMDIAZ2"
	, "VENBANNER"
	, "MLASHWAY"
	)
order by d.user_name
go
^</Template><Template Name="mpt_ViewSource" Description="mPage View Source JSON">&lt;html&gt;
&lt;head&gt;
	&lt;meta charset="UTF-8"&gt;
  &lt;meta name="description" content="Default mPage Information"&gt;
  &lt;meta name="keywords" content="UE Studio mPageViewSource.mac"&gt;
  &lt;meta name="author" content="Robert Holland"&gt;
  &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;

&lt;p&gt;This page requires data from three variables from the "View Source" of an mPage.&lt;br /&gt;
The &lt;b&gt;"var m_viewpointJSON"&lt;/b&gt;, the &lt;b&gt;var m_criterionJSON&lt;/b&gt;, and the &lt;b&gt;"var m_mpageSettingsJSON"&lt;/b&gt;.&lt;br /&gt;
&lt;hr /&gt;
&lt;/p&gt;
&lt;title&gt;mPage JSON Testing&lt;/title&gt;
&lt;script language="javascript" src="./json2.js"&gt;&lt;/script&gt;
&lt;script src="http://code.jquery.com/jquery-1.11.1.min.js"&gt;&lt;/script&gt;

&lt;/head&gt;
&lt;style&gt;
	table, th, td {border-collapse:collapse; border: 1px solid black; background-color: #FFFF00}

&lt;/style&gt;
&lt;body&gt;
&lt;div&gt;
&lt;p id="output"&gt;&lt;/p&gt;&lt;hr /&gt;
&lt;/div&gt;
&lt;div&gt;
	&lt;p id="output1"&gt;&lt;/p&gt;&lt;hr /&gt;
&lt;/div&gt;
&lt;div&gt;
	&lt;p id="output2"&gt;&lt;/p&gt;&lt;hr /&gt;
&lt;/div&gt;

&lt;script&gt;
//*********************************************Use mPageViewSource macro and paste JSON below here:*********************************************/



//************************************************************Paste JSON above here:************************************************************/

//JSON setup.
var VP = JSON.parse(m_viewpointJSON);
var viewpoint = VP.VP_INFO;
var CR = JSON.parse(m_criterionJSON);
var criterion = CR.CRITERION;
var MP = JSON.parse(m_mpageSettingsJSON);
var mpage = MP.MP_SETTINGS;

//alert(viewpoint.VIEWS.length);
//alert(viewpoint.VIEWS[0].VIEW_NAME);
var spc0='&amp;nbsp;&amp;nbsp;';
var spc1='&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;';
var tempStr=[];
	tempStr.push('&lt;b&gt;',viewpoint.VIEWPOINT_NAME,'&lt;/b&gt;&lt;br /&gt;');
	tempStr.push('mPages in ',viewpoint.VIEWPOINT_NAME, ' (',viewpoint.VIEWPOINT_NAME_KEY,')&lt;br /&gt;');
for(var i=0,all_cnt=viewpoint.VIEWS.length;i&lt;all_cnt;i++){
//alert(i);

	tempStr.push(spc0,'View Name: &lt;b&gt;',viewpoint.VIEWS[i].VIEW_NAME,'&lt;/b&gt; (',viewpoint.VIEWS[i].VIEW_CAT_MEAN,')&lt;br /&gt;');
//	tempStr.push(spc1,'View Sequence: ',viewpoint.VIEWS[i].VIEW_SEQUENCE,'&lt;br /&gt;');
//	tempStr.push(spc1,'View Cat Mean: ',viewpoint.VIEWS[i].VIEW_CAT_MEAN,'&lt;br /&gt;');
//	tempStr.push(spc1,'View Cat ID: ',viewpoint.VIEWS[i].VIEW_CAT_ID,'&lt;br /&gt;');
//	tempStr.push(spc1,'User Defined IND: ',viewpoint.VIEWS[i].USER_DEFINED_IND,'&lt;br /&gt;');
//	tempStr.push(spc1,'Shown IND: ',viewpoint.VIEWS[i].SHOWN_IND,'&lt;br /&gt;');
//	tempStr.push(spc1,'Menu Item: ',viewpoint.VIEWS[i].MENU_ITEM,'&lt;br /&gt;');
//	tempStr.push(spc1,'View Type: ',viewpoint.VIEWS[i].VIEW_TYPE,'&lt;br /&gt;');
//	tempStr.push(spc1,'View Type Mean: ',viewpoint.VIEWS[i].VIEW_TYPE_MEAN,'&lt;br /&gt;');
//	tempStr.push(spc1,'Grouped View Viewpoint ID: ',viewpoint.VIEWS[i].GROUPED_VIEW_VIEWPOINT_ID,'&lt;br /&gt;&lt;br /&gt;');
//	tempStr.push();
//	tempStr.push(&lt;/ul&gt;);

document.getElementById("output").innerHTML = tempStr.join("");
}


var tempStr=[];
//
	tempStr.push('&lt;b&gt;Person NAME:&lt;/b&gt; ',criterion.PERSON_INFO.PERSON_NAME,'&lt;br /&gt;');
	tempStr.push('&lt;b&gt;Person DOB:&lt;/b&gt; ',criterion.PERSON_INFO.DOB,'&lt;br /&gt;');
	tempStr.push('&lt;b&gt;Person ID:&lt;/b&gt; ',criterion.PERSON_ID,'&lt;br /&gt;');
	tempStr.push('&lt;b&gt;Encounter ID:&lt;/b&gt; ',criterion.ENCNTRS[0].ENCNTR_ID,'&lt;br /&gt;');
	tempStr.push('&lt;b&gt;Username:&lt;/b&gt; ',criterion.USERNAME,'&lt;br /&gt;');
	tempStr.push('&lt;b&gt;Personnel ID:&lt;/b&gt; ',criterion.PRSNL_ID,' (select pr.name_full_formatted from prsnl pr where pr.person_id = ',criterion.PRSNL_ID,'.00)&lt;br /&gt;');
	tempStr.push('&lt;b&gt;Position Code:&lt;/b&gt; ',criterion.POSITION_CD,' (select cv.display from code_value cv where cv.code_value = ',criterion.POSITION_CD,'.00)&lt;br /&gt;');
	tempStr.push('&lt;b&gt;Release Identifier:&lt;/b&gt; ',criterion.RELEASE_IDENTIFIER,'&lt;br /&gt;');
	tempStr.push('&lt;b&gt;Release Version:&lt;/b&gt; ',criterion.RELEASE_VERSION,'&lt;br /&gt;');
//	for(var i=0,all_cnt=criterion.CRITERION.length;i&lt;all_cnt;i++){
//
document.getElementById("output1").innerHTML = tempStr.join("");
//}

var tempStr=[];
//	tempStr.push('m_mpageSettingsJSON&lt;br /&gt;');
for(var i=0,all_cnt=mpage.MPAGE.length;i&lt;all_cnt;i++){
//	tempStr.push(mpage.MPAGE[i].SETTINGS.C_MN,'&lt;br /&gt;');
	tempStr.push('&lt;b&gt;',mpage.MPAGE[i].SETTINGS.BR_SET.LBL,' components:&lt;/b&gt;&lt;br /&gt;');
//	tempStr.push(mpage.MPAGE[i].SETTINGS.BR_SET.CS.length,'&lt;br /&gt;');
	for(var j=0,all_cnt=mpage.MPAGE[i].SETTINGS.BR_SET.CS.length;j&lt;all_cnt;j++){
		tempStr.push(spc0,mpage.MPAGE[i].SETTINGS.BR_SET.CS[j].LBL,'&lt;br /&gt;');
	}
//	tempStr.push(mpage.MPAGE[i].SETTINGS.BR_SET.CS[i].LBL,'&lt;br /&gt;');
//	tempStr.push();
//	tempStr.push();
document.getElementById("output2").innerHTML = tempStr.join("");
}

&lt;/script&gt;
&lt;/body&gt;
&lt;/html&gt;
</Template><Template Name="tmp_apache_upload" Description="Set SELinux permissions to allow upload documents from browswer.">sudo chown apache:apache -R [+foldername+]
sudo chcon -Rv --type=httpd_sys_rw_content_t [+foldername+]
^</Template><Template Name="tmp_appData" Description="Path to appData folder.">#Hidden appData folder.
"%userprofile%\AppData"
"%userprofile%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\"
cd "%userprofile%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\"
</Template><Template Name="tmp_Base64toWeb" Description="Base64 images to webfile.">##Make the Base64 images (encode):
#for imagefile in *.png
#do
#perl -MMIME::Base64 -0777ne 'print encode_base64($_)' $imagefile &gt; $imagefile.b64
#done

##Make the images from Base64 (decode):
#for imagefile in *.b64
#do
#perl -MMIME::Base64 -0777ne 'print decode_base64($_)' $imagefile &gt; $imagefile.png
#done

#Make the webfile from the Base64 images:
webfile=y.html
echo "&lt;table&gt;" &gt; $webfile
for file in *.b64
do
	echo "&lt;tr&gt;&lt;td&gt;$file&lt;/td&gt;&lt;td&gt;&lt;img src='data:image/png;base64," &gt;&gt; $webfile
	cat $file &gt;&gt; $webfile
	echo	"' /&gt;&lt;br /&gt;&lt;br /&gt;&lt;/td&gt;&lt;/tr&gt;" &gt;&gt; $webfile
done
echo "&lt;/table&gt;" &gt;&gt; $webfile

#Make the webfile from the Base64 videos:
webfile=z.html
echo "&lt;table&gt;" &gt; $webfile
for file in *.b64
do
	echo "&lt;tr&gt;&lt;td&gt;$file&lt;/td&gt;&lt;td&gt;&lt;video width='320' height='240' controls&gt;&lt;source type='video/mp4' src='data:video/mp4;base64," &gt;&gt; $webfile
	cat $file &gt;&gt; $webfile
	echo	"' alt='Alt_Text' /&gt;&lt;br /&gt;&lt;br /&gt;&lt;/td&gt;&lt;/tr&gt;" &gt;&gt; $webfile
done
echo "&lt;/table&gt;" &gt;&gt; $webfile

#Bashrc function
b64(){
if [ $# -eq 0 ]
then
clear
        echo "Usage: "
        echo "   b64 encode filename"
        echo "   b64 decode filename"
        echo "   b64 allD b64extension newextension"
        echo "   b64 allE extension"
        echo "   b64 html"
        echo "   b64 html filename.html"
else
case $1 in
        encode)
        perl -MMIME::Base64 -0777ne 'print encode_base64($_)' $2 &gt; $2.b64
        echo "Created $2.b64"
        ;;
        decode)
        perl -MMIME::Base64 -0777ne 'print decode_base64($_)' $2 &gt; $2.decoded
        echo "Created $2.decoded"
        ;;
        allD)
        for imagefile in *.$2
        do
        perl -MMIME::Base64 -0777ne 'print decode_base64($_)' $imagefile &gt; $imagefile.$3
        done
        ;;
        allE)
        for imagefile in *.$2
        do
        perl -MMIME::Base64 -0777ne 'print encode_base64($_)' $imagefile &gt; $imagefile.b64
        done
        ;;
        html)
        #Make the webfile from the Base64 images:
        webfile=$2
        echo "&lt;!doctype html&gt;&lt;html&gt;&lt;head&gt;&lt;title&gt;&lt;/title&gt;&lt;/head&gt;&lt;table&gt;" &gt; $webfile
        for file in *.b64
        do
        #echo "&lt;tr&gt;&lt;td&gt;$file&lt;/td&gt;&lt;td&gt;&lt;img src='data:image/png;base64," &gt;&gt; $webfile
        echo "&lt;tr&gt;&lt;td&gt;&lt;img src='data:image/png;base64," &gt;&gt; $webfile
        cat $file &gt;&gt; $webfile
        echo	"' /&gt;&lt;br /&gt;&lt;br /&gt;&lt;/td&gt;&lt;/tr&gt;" &gt;&gt; $webfile
        done
        echo "&lt;/table&gt;&lt;/html&gt;" &gt;&gt; $webfile
        ls -alFh $webfile
        #fi
        ;;
esac
fi
}
^</Template><Template Name="tmp_bitvise" Description="Standalone Bitvise command">Standalone Bitvise command:
	Syntax if you do not have a profile:
		BvSsh.exe -noRegistry

	Syntax if you do have a profile:
		BvSsh.exe -noRegistry -profile=U:\Profile.bscp

	Example:
	"C:\Program Files (x86)\Bitvise SSH Client\bvssh.exe" -noRegistry -profile="C:\Users\rlholland\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\MyLinks\BitVise\zsftp.crimsonservices.com.tlp"
^</Template><Template Name="tmp_Blanklines" Description="Remove blank lines.">https://www.ultraedit.com/support/tutorials-power-tips/ultraedit/remove-blank-lines.html

Find What: 
  %[^^t ]++[^^r^^n]+

Replace With:
 "" (without the quotes)

Check "Regular Expressions"
Select "UltraEdit" regex type.

Put cursor at top of file and run.
Note: For Mac formatted-files not converted to DOS on load 
the UltraEdit regular expression find string must 
be "^^r[^^t ]++^^r" and the replace string "^^r" 
(both without the quotes).
^
</Template><Template Name="tmp_charcode" Description="Character Codes">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;meta charset="UTF-8"&gt;
  &lt;meta name="description" content="Template HTML Document"&gt;
  &lt;meta name="keywords" content="comma,separated,keywords"&gt;
  &lt;meta name="author" content="Robert Holland"&gt;
  &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;script src="http://code.jquery.com/jquery-latest.min.js"&gt;&lt;/script&gt;
&lt;!-- &lt;script type="text/javascript" src="http://example.com/js/filename.js"&gt;&lt;/script&gt;
&lt;link rel="stylesheet" href="http://example.com/css/filname.css" /&gt; --&gt;
&lt;script&gt;
var str, i, j, k, qq, alertmsg;
var qq=String.fromCharCode(34);
var end=");"

function clearski() {
//if (confirm("Are you sure you want to clear form?")) {
document.form1.reset();
//}
}

function showascii1()
{
var str	= document.form1.str.value;
var i = parseInt=((str.length)-(str.length));
var j = parseInt=(str.length);
var k;
var L;

//New One
var ii = parseInt=((str.length)-(str.length));
var a = parseInt=(str.length)-1;
var b = (str.charCodeAt(a));
//var b = (str.charCodeAt(str.length-1));
	document.write("&lt;html&gt;&lt;head&gt;&lt;link rel=" + qq + "stylesheet" + qq + " type=" + qq + "text/css" + qq + " href=" + qq + "./css/CharCode.css" + qq + " /&gt;&lt;/head&gt;&lt;body&gt;");
	document.write("&lt;style type='text/css'&gt;td {text-align:center}&lt;/style&gt;");
	document.write("&lt;table bgcolor=" + qq + "ffffff" + qq + " font color=" + qq + "ffffff" + qq + " border=" + qq + "0" + qq + "&gt;");
	document.write("&lt;caption&gt;JavaScript&lt;/caption&gt;");
	document.write("&lt;tr&gt;&lt;td&gt;document.write(String.fromCharCode(");
for (ii=ii;ii&lt;a;ii++)
{
	var c = str.charCodeAt(ii);
  document.write(c + ", ");
}
	document.write(b + "));&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;&lt;br /&gt;&lt;hr /&gt;");
// End First Table
	document.write("&lt;table bgcolor=" + qq + "C0C0C0" + qq + " font color=" + qq + "ffffff" + qq + " border=" + qq + "1" + qq + "&gt;");
	document.write("&lt;caption&gt;ASCII Codes&lt;/caption&gt;&lt;tr&gt;&lt;th&gt;ASCII Character&lt;/th&gt;&lt;th&gt;ASCII Character Code&lt;/th&gt;&lt;/tr&gt;");
for (i=i;i&lt;j;i++)
{
	k = String.fromCharCode(parseInt=(str.charCodeAt(i)));
	L = str.charCodeAt(i);
	document.write("&lt;tr&gt;&lt;td&gt;");
	document.write(k + "&lt;/td&gt;&lt;td&gt;" + str.charCodeAt(i));
	document.write("&lt;/td&gt;&lt;/tr&gt;");
}
	document.write("&lt;/table&gt;&lt;/body&gt;&lt;html&gt;");
// End Second Table
}

function showascii2()
{
var i, j;
var qq=String.fromCharCode(34);
var i	= parseInt(document.form1.codebox1.value);
var j	= parseInt(document.form1.codebox2.value);
//	document.write("&lt;html&gt;&lt;head&gt;&lt;/head&gt;&lt;body&gt;");
	document.write("&lt;html&gt;&lt;head&gt;&lt;link rel=" + qq + "stylesheet" + qq + " type=" + qq + "text/css" + qq + " href=" + qq + "./css/CharCode.css" + qq + " /&gt;&lt;/head&gt;&lt;body&gt;");
	document.write("&lt;style type='text/css'&gt;td {text-align:center}&lt;/style&gt;");
	document.write("&lt;table bgcolor=" + qq + "C0C0C0" + qq + " font color=" + qq + "ffffff" + qq + " border=" + qq + "1" + qq + "&gt;");
	document.write("&lt;caption&gt;ASCII Character Codes Between " + i + " - " + j + "&lt;/caption&gt;");
	document.write("&lt;tr&gt;&lt;th&gt;ASCII Character Code&lt;/th&gt;&lt;th&gt;ASCII Character&lt;/th&gt;&lt;/tr&gt;");
for (i=i;i&lt;=j;i++)
{
	document.write("&lt;tr&gt;&lt;td&gt;");
	document.write(i + " " + "&lt;/td&gt;&lt;td&gt;" + String.fromCharCode(i) + "&lt;/td&gt;&lt;/tr&gt;");
}
	document.write("&lt;/table&gt;&lt;/body&gt;&lt;html&gt;");
}

function validateForm()
{
 var x=document.forms["form1"]["codebox1"].value
 var y=document.forms["form1"]["codebox2"].value
if ((isNaN(x)) || (isNaN(y)))
	{
	alert("Is Not a Number!");
	return false;
	}
else
   {
   showascii2()
   }
}
//$(document).ready(function(){
//  $("#reset").click(function(){
//  	$(document.getElementById("form1").reset());
//  });
//});

$(document).ready(function(){
  $("#reset").click(function(){
  	$(clearski);
  });
});

$(document).ready(function(){
$("#box1").click(function(){
		$(showascii1());
  });
});

$(document).ready(function(){
$("#box2").click(function(){
		$(validateForm());
  });
});

xxx = "&lt;meta http-equiv='Refresh' content='5;url=mailto:rob@robholland.com' /&gt;"
$(document).ready(function(){
$("#feedback").click(function(){
		$(xxx);
  });
});

&lt;/script&gt;

&lt;/head&gt;

&lt;style&gt;
/*common css*/
table, th, td {border-collapse:collapse; border: 1px solid black;}
th {background-color:#ffff00;}
tr:nth-child(even) {background: #CCC;}
tr:nth-child(odd) {background: #FFF;}
a:link {text-decoration: none;}
a:visited {text-decoration: none;}
a:hover {text-decoration: underline;}
a:active {text-decoration: underline;}
.tBodyA {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: normal;
	color: #000000;
	padding-left: 5px;
	line-height: normal;
	padding-bottom: 5px;
	padding-top: 5px;
	background-color: #c0c0c0;
}
.tBodyB {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: normal;
	color: #55B23C;
	padding-left: 5px;
	line-height: normal;
	padding-bottom: 5px;
	padding-top: 5px;
	background-color: #55B23C;
}
.tBodyC {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: normal;
	color: #000000;
	padding-left: 5px;
	line-height: normal;
	padding-bottom: 5px;
	padding-top: 5px;
	background-color: #EEECE2;
}
.tBodyCa {
	padding-left: 5px;
	line-height: normal;
	padding-bottom: 5px;
	padding-top: 5px;
	background-color: #EEECE2;
}
table,td,th
{
border:1px solid black;
}
table
{
width:40%;
border-collapse:collapse;
}
th
{
height:50px;
}
#symbol{font: normal 22px Georgia,serif;;}
&lt;/style&gt;

&lt;body&gt;

&lt;form name="form1" size="30%"&gt;
&lt;table border="1"&gt;
&lt;caption&gt;Translate keyboard characters into JavaScript ASCII Character Code&lt;/caption&gt;
&lt;tr&gt;&lt;td class="tBodyC" colspan="2"&gt;Please type some characters in the box below and click go.&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td class="tBodyC"&gt;&lt;input id="strbox" name="str" size="60"&gt;&lt;/td&gt;&lt;td class="tBodyB"&gt;&lt;center&gt;&lt;i id="box1" style="font-family:verdana;font-size:110%;color:green"&gt;GO!&lt;/i&gt;&lt;/center&gt;&lt;/td&gt;&lt;tr&gt;
&lt;tr&gt;&lt;td class="tBodyA" colspan="2"&gt;Enter a range of numbers below. (A large range will be slow)&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td class="tBodyC" colspan="2"&gt;List ASCII characters by number:&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td class="tBodyC"&gt;Enter a number between &lt;input id="showcodes1" name="codebox1" size="5"/&gt; and	&lt;input id="showcodes2" name="codebox2" size="5"/&gt; then click&lt;/td&gt;
&lt;td class="tBodyB"&gt;&lt;center&gt;&lt;i id="box2" style="font-family:verdana;font-size:110%;color:green"&gt;GO!&lt;/i&gt;&lt;/center&gt;&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td class="tBodyC" align="left"&gt;&lt;i id="reset" type="reset" style="font-family:verdana;font-size:110%;color:red"&gt;Reset&lt;/i&gt;&lt;/td&gt;&lt;td class="tBodyC" id="feedback"&gt;
&lt;/table&gt;
&lt;/form&gt;

&lt;p id="demo"&gt;&lt;/p&gt;
&lt;/table&gt;
&lt;script&gt;
const charcodes = [126, 96, 33, 64, 35, 36, 37, 94, 38, 42, 40, 41, 43, 61, 8800, 8801, 8802, 8803, 8804, 8805, 8806, 8807, 8808, 8809, 8810, 8811, 42, 45, 91, 93, 123, 125, 92, 124, 58, 59, 34, 39, 60, 62, 44, 46, 63, 47, 95, 169, 167, 171, 187, 174, 176, 177, 186, 8304, 185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313, 8314, 8315, 8316, 8317, 8318, 8320, 8321, 8322, 8323, 8324, 8325, 8326, 8327, 8328, 8329, 8330, 8331, 8332, 8333, 8334, 247, 248, 508, 509, 916, 931, 934, 936, 937, 940, 946, 960, 1632, 1633, 1634, 1635, 1636, 1637, 1638, 1639, 1640, 1641, 8240, 8230, 8539, 188, 8531, 8540, 189, 8541, 8532, 190, 8542, 8482, 8453, 8364, 8356, 8592, 8593, 8594, 8595, 8596, 8597, 8730, 8734, 10017, 9770, 9650, 9658, 9660, 9668, 9786, 9787, 9792, 9794, 9824, 9827, 9829, 9830, 9835, 162, 165, 8853, 8854, 8855, 8856, 8857, 8858, 8859, 8860, 8861, 8862, 8863, 8864, 8865, 7491, 7495, 7580, 7496, 7497, 7584, 7501, 688, 8305, 690, 7503, 737, 7504, 8319, 7506, 7510, 691, 738, 7511, 7512, 7515, 695, 739, 696, 7611, 7468, 7470, 7472, 7473, 7475, 7476, 7477, 7478, 7479, 7480, 7481, 7482, 7484, 7486, 7487, 7488, 7489, 11389, 7490, 9193, 9194, 9195, 9196, 9197, 9198, 9199, 9204, 9205, 9206, 9207, 9208, 9209, 9210, 9749, 9760, 9775, 9803, 9855, 9889, 9898, 9899, 9940, 9994, 9995, 9996, 9997, 9964, 9200, 9203];

let codeout = "&lt;table border='1'&gt;&lt;caption&gt;Common Characters and Codes&lt;/caption&gt;&lt;tr&gt;&lt;th&gt;ASCII Character&lt;/th&gt;&lt;th&gt;ASCII Character Code&lt;/th&gt;&lt;th&gt;JavaScript Syntax&lt;/th&gt;&lt;/tr&gt;";
charcodes.forEach(showChCodes);
document.getElementById("demo").innerHTML = codeout;

function showChCodes(value, index, array) {
codeout += "&lt;tr&gt;&lt;td id='symbol'&gt;"+String.fromCharCode(value)+"&lt;/td&gt;&lt;td&gt;"+value+"&lt;/td&gt;&lt;td&gt;document.write(String.fromCharCode("+value+"));&lt;/td&gt;&lt;tr&gt;"
}
codeout += "&lt;/table&gt;";
&lt;/script&gt;

&lt;/body&gt;
&lt;/html&gt;
^</Template><Template Name="tmp_code_signing" Description="tmp_code_signing"># ----------------------------------------------------------------------------
#Program Author: Robert Holland
#Program Name: [+Program+]
#Creation Date: [DATE_TEXT] [TIME]
#Last Modified:  
#Copyright (c)[DATE_USER]yyyy[DATE_USER_END]
#Purpose: 
#Request #: 
# Usage: .\[+Program+]
# List keys: Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
# Show non-expired keys: Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert |where{ $_.NotAfter -gt [datetime]::Now}
# Verify signature: signtool verify /pa /v &lt;thefilename&gt;
# List of free timestamp servers: https://gist.github.com/Manouchehri/fd754e402d98430243455713efada710
# List certificates expiring within 366 days: Get-ChildItem -Path cert: -Recurse -ExpiringInDays 365
# Get-ChildItem -Path cert: -Recurse -ExpiringInDays 366 | Select-Object Issuer, NotAfter, Subject, FriendlyName, Thumbprint
# Get-ChildItem -Path Cert:CurrentUser\\MY -CodeSigningCert -recurse -Expiringindays 366 | Where-Object {$_.Subject -Match "$MySubjectName"}
# ----------------------------------------------------------------------------

#param(
   [string]$executable = $( Read-Host "Input executable that needs to be signed")
#    )

#If you only have one code-signing key use this:
#$rh=Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert 

#If you have multiple code-signing keys you will have to specify which one to use:
$rh=Get-ChildItem Cert:\CurrentUser\My\ab071687e64851a266cc671a0fe1af8203813d08

#Set-AuthenticodeSignature -FilePath "$executable" -Certificate $rh -HashAlgorithm SHA256 -TimeStampServer &lt;If the timestamp server is unavailable you will get errors when signing&gt;
Set-AuthenticodeSignature -FilePath "$executable" -Certificate $rh -HashAlgorithm SHA256 -TimeStampServer http://timestamp.digicert.com
^</Template><Template Name="tmp_codesign" Description="PowerShell Code Siging">Windows PowerShell Code Signing Notes.
Assign certificate thumbprint to a variable:
	$rh=Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
	or
	$rh=get-childitem Cert:\CurrentUser\My\ab071687e64851a266cc671a0fe1af8203813d08

Use the $rh variable to sign a file:
	Set-AuthenticodeSignature -Certificate $rh -FilePath .\TheFileName.exe
	or sign all executables (.vbs, .ps1, .cmd, .bat)
	Set-AuthenticodeSignature -Certificate $rh -FilePath .\*.exe

Dump your certificate information:
	certutil -dump

RH.PS1 File -----Begin
	#Get user input filename and assign to $executable.
	#param(
	   [string]$executable = $( Read-Host "Input executable that needs to be signed")
	#    )

	#Get code signing certificate and assign to $rh the run the signing process.
	$rh=Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
	Set-AuthenticodeSignature -FilePath "$executable" -Certificate $rh -HashAlgorithm SHA256 -TimeStampServer http://timestamp.globalsign.com/scripts/timestamp.dll
RH.PS1 File -----End

Batch files do not need to be signed unless they access protected applications. 

signtool sign /debug /n $rh /fd sha256 tr http://timestamp.globalsign.com/scripts/timestamp.dll /td sha256 /fd sha256 "SOUTHBUMCS.exe"
^</Template><Template Name="tmp_css_js_import" Description="Import css and js into current file.">From inside .css file: 
@import url("I:\\Winintel\\Static_Content\\custom_mpage_content\\custom-components\\css\\robertdev.css");

From inside .js file:
var robertUrl = "I:\\Winintel\\Static_Content\\custom_mpage_content\\custom-components\\js\\robertdev\\robertdev.js";
$.getScript(robertUrl);
</Template><Template Name="tmp_css_rotating" Description="Rotating object">&lt;style&gt;
@-webkit-keyframes rotating /* Safari and Chrome */ {
	/*https://stackoverflow.com/questions/6410730/css-endless-rotation-animation*/
  from {
    -webkit-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  to {
    -webkit-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
@keyframes rotating {
  from {
    -ms-transform: rotate(0deg);
    -moz-transform: rotate(0deg);
    -webkit-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  to {
    -ms-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -webkit-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
.rotating {
  -webkit-animation: rotating 2s linear infinite;
  -moz-animation: rotating 2s linear infinite;
  -ms-animation: rotating 2s linear infinite;
  -o-animation: rotating 2s linear infinite;
  animation: rotating 2s linear infinite;
}
&lt;/style&gt;</Template><Template Name="tmp_delete_blank_lines" Description="Delete blank empty lines.">Links:
	https://www.ultraedit.com/support/tutorials-power-tips/ultraedit/remove-blank-lines.html
	See also tmp_regex_examples

User Perl Regualar Expressions:
	Find What: "^^(?:[\t ]*(?:\r?\n|\r))+" (without the quotes)
	Replace With: "" (without the quotes - i.e., nothing).

See tmp_Blanklines for more details on Mac files.
^
</Template><Template Name="tmp_excel_delimeter" Description="Change the delimeter in Microsoft Excel">Question:
How to change the field separator (delimiter) in Excel when saving as a CSV file:
Need to change the field separators (delimiter) from comma to another character, such as a pipe.

Answer:
The comma is the most often used field separator (delimiter) for text files. However, if the field needs to be changed in Excel, this is based on a Microsoft Windows setting under the Region and Language settings:
In Microsoft Windows, click the 
Start button --&gt; Control Panel --&gt; Regional and Language settings.
Look for the List separator setting. (Location may vary based on Windows version. You may need to open Additional settings... on the Format tab to find it.)
Enter the desired list separator.
Click Apply and then click OK. (Or Click OK, then click Apply and then click OK.)
^
</Template><Template Name="tmp_gitDiffSHA" Description="Diff on same file between two different commits.">Example:
git diff [+Old_SHA+]..[+New_SHA+] -- [+path/to/filename+]
git diff [+Old_SHA+] [+New_SHA+] -- [+path/to/filename+]

https://stackoverflow.com/questions/25497881/git-diff-is-it-possible-to-show-only-changed-lines
#Only show new lines that have been added:
git diff HEAD --no-ext-diff --unified=0 --exit-code -a --no-prefix | egrep "^\+"

#Only show new lines that have been added:
git diff bb3f38e3cf..cba410a3ce -- UETMPLTE.TPL --no-ext-diff --unified=0 --exit-code -a --no-prefix | egrep "^\+"

#Only show lines that have been removed:
git diff bb3f38e3cf..cba410a3ce -- UETMPLTE.TPL --no-ext-diff --unified=0 --exit-code -a --no-prefix | egrep "^\-"
^</Template><Template Name="tmp_grep" Description="Create HTML table from grep results and send via email.">#Create HTML table from grep results and send via email:
	grep -nirH "Consult Specialty" *.prg|sed 's/&lt;//g'|sed 's/&gt;//g'|sed 's/\///g'|sed 's/&gt;//g'|sed 's/^/&lt;tr&gt;&lt;td&gt;/g'|sed 's/\.prg:/\.prg&lt;\/td&gt;&lt;td&gt;/g'|sed 's/.$/&lt;\/td&gt;&lt;\/tr&gt;/g' | mailx -r "robert.holland@bannerhealth.com (Robert Holland)" -s "Search Result" robert.holland@bannerhealth.com
</Template><Template Name="tmp_html_img" Description="HTML Image template">&lt;img src='data:image/png;base64,
{base64 data goes here without the braces}' /&gt;
&lt;br /&gt;

&lt;!-- PDF Documents in iframe. --&gt;
&lt;iframe src="data:application/pdf;base64,
...B64 PDF Data Here...
" height="600px" width="100%"&gt;
^</Template><Template Name="tmp_HTMLBasic" Description="Basic HTML">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;meta name="author" content="Robert Holland"&gt;
  &lt;meta name="description" content="Template HTML Document"&gt;
  &lt;meta name="keywords" content="comma,separated,keywords"&gt;
  &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
  &lt;meta charset="UTF-8"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;script type="text/javascript" src="http://example.com/js/filename.js"&gt;&lt;/script&gt;
&lt;link rel="stylesheet" href="http://example.com/css/filename.css" /&gt;
&lt;/head&gt;

&lt;style&gt;
/*common css*/
table, th, td {border-collapse:collapse; border: 1px solid black;}
th {background-color:#ffff00;}
tr:nth-child(even) {background: #CCC;}
tr:nth-child(odd) {background: #FFF;}
a:link {text-decoration: none;}
a:visited {text-decoration: none;}
a:hover {text-decoration: underline;}
a:active {text-decoration: underline;}
th, td {padding: 5px;}
&lt;/style&gt;

&lt;body&gt;
&lt;img src='data:image/png;base64,
{base64 data goes here without the braces}' /&gt;
&lt;br /&gt;
&lt;body&gt;
&lt;!-- &lt;img src='data:application/pdf;base64, --&gt;
&lt;iframe src="data:application/pdf;base64,
...B64 PDF Data Here...
" height="600px" width="100%"&gt;

&lt;div&gt;
&lt;p&gt;Blah blah blah&lt;/p&gt;

&lt;table&gt;&lt;caption&gt;Table Caption&lt;/caption&gt;
&lt;tr&gt;&lt;th&gt;One&lt;/th&gt;&lt;th&gt;Two&lt;/th&gt;&lt;th&gt;Three&lt;/th&gt;&lt;th&gt;Four&lt;/th&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;1&lt;/td&gt;&lt;td&gt;2&lt;/td&gt;&lt;td&gt;3&lt;/td&gt;&lt;td&gt;4&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;1&lt;/td&gt;&lt;td&gt;2&lt;/td&gt;&lt;td&gt;3&lt;/td&gt;&lt;td&gt;4&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;1&lt;/td&gt;&lt;td&gt;2&lt;/td&gt;&lt;td&gt;3&lt;/td&gt;&lt;td&gt;4&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;1&lt;/td&gt;&lt;td&gt;2&lt;/td&gt;&lt;td&gt;3&lt;/td&gt;&lt;td&gt;4&lt;/td&gt;&lt;/tr&gt;
&lt;/table&gt;

&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
</Template><Template Name="tmp_HTMLDigitalClock" Description="HTML Digital Clock">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta name="author" content="Robert Holland"&gt;
&lt;meta name="description" content="Template HTML JS Date Document"&gt;
&lt;meta name="keywords" content="JavaScript date"&gt;
&lt;meta name="source1" content="https://stackoverflow.com/questions/14638018/current-time-formatting-with-javascript"&gt;
&lt;meta name="source2" content="https://www.w3schools.com/js/tryit.asp?filename=tryjs_timing_clock"&gt;
&lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;Tick Tock&lt;/title&gt;
&lt;script type="text/javascript" src="http://example.com/js/filename.js"&gt;&lt;/script&gt;
&lt;link rel="stylesheet" href="http://example.com/css/filename.css" /&gt;

&lt;script&gt;
function formatTheDate(date, format, utc){
	//https://stackoverflow.com/questions/14638018/current-time-formatting-with-javascript
        var MMMM = ["\x00", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
        var MMM = ["\x01", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var dddd = ["\x02", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        var ddd = ["\x03", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
        function ii(i, len) { var s = i + ""; len = len || 2; while (s.length &lt; len) s = "0" + s; return s; }

        var y = utc ? date.getUTCFullYear() : date.getFullYear();
        format = format.replace(/(^|[^\\])yyyy+/g, "$1" + y);
        format = format.replace(/(^|[^\\])yy/g, "$1" + y.toString().substr(2, 2));
        format = format.replace(/(^|[^\\])y/g, "$1" + y);

        var M = (utc ? date.getUTCMonth() : date.getMonth()) + 1;
        format = format.replace(/(^|[^\\])MMMM+/g, "$1" + MMMM[0]);
        format = format.replace(/(^|[^\\])MMM/g, "$1" + MMM[0]);
        format = format.replace(/(^|[^\\])MM/g, "$1" + ii(M));
        format = format.replace(/(^|[^\\])M/g, "$1" + M);

        var d = utc ? date.getUTCDate() : date.getDate();
        format = format.replace(/(^|[^\\])dddd+/g, "$1" + dddd[0]);
        format = format.replace(/(^|[^\\])ddd/g, "$1" + ddd[0]);
        format = format.replace(/(^|[^\\])dd/g, "$1" + ii(d));
        format = format.replace(/(^|[^\\])d/g, "$1" + d);

        var H = utc ? date.getUTCHours() : date.getHours();
        format = format.replace(/(^|[^\\])HH+/g, "$1" + ii(H));
        format = format.replace(/(^|[^\\])H/g, "$1" + H);

        var h = H &gt; 12 ? H - 12 : H == 0 ? 12 : H;
        format = format.replace(/(^|[^\\])hh+/g, "$1" + ii(h));
        format = format.replace(/(^|[^\\])h/g, "$1" + h);

        var m = utc ? date.getUTCMinutes() : date.getMinutes();
        format = format.replace(/(^|[^\\])mm+/g, "$1" + ii(m));
        format = format.replace(/(^|[^\\])m/g, "$1" + m);

        var s = utc ? date.getUTCSeconds() : date.getSeconds();
        format = format.replace(/(^|[^\\])ss+/g, "$1" + ii(s));
        format = format.replace(/(^|[^\\])s/g, "$1" + s);

        var f = utc ? date.getUTCMilliseconds() : date.getMilliseconds();
        format = format.replace(/(^|[^\\])fff+/g, "$1" + ii(f, 3));
        f = Math.round(f / 10);
        format = format.replace(/(^|[^\\])ff/g, "$1" + ii(f));
        f = Math.round(f / 10);
        format = format.replace(/(^|[^\\])f/g, "$1" + f);

        var T = H &lt; 12 ? "AM" : "PM";
        format = format.replace(/(^|[^\\])TT+/g, "$1" + T);
        format = format.replace(/(^|[^\\])T/g, "$1" + T.charAt(0));

        var t = T.toLowerCase();
        format = format.replace(/(^|[^\\])tt+/g, "$1" + t);
        format = format.replace(/(^|[^\\])t/g, "$1" + t.charAt(0));

        var tz = -date.getTimezoneOffset();
        var K = utc || !tz ? "Z" : tz &gt; 0 ? "+" : "-";
        if (!utc)
        {
            tz = Math.abs(tz);
            var tzHrs = Math.floor(tz / 60);
            var tzMin = tz % 60;
            K += ii(tzHrs) + ":" + ii(tzMin);
        }
        format = format.replace(/(^|[^\\])K/g, "$1" + K);

        var day = (utc ? date.getUTCDay() : date.getDay()) + 1;
        format = format.replace(new RegExp(dddd[0], "g"), dddd[day]);
        format = format.replace(new RegExp(ddd[0], "g"), ddd[day]);

        format = format.replace(new RegExp(MMMM[0], "g"), MMMM[M]);
        format = format.replace(new RegExp(MMM[0], "g"), MMM[M]);

        format = format.replace(/\\(.)/g, "$1");

        return format;
    };

function getTheDateTime() {
        var now     = new Date(); 
        var year    = now.getFullYear();
        var month   = now.getMonth()+1; 
        var day     = now.getDate();
        var hour    = now.getHours();
        var minute  = now.getMinutes();
        var second  = now.getSeconds(); 
        if(month.toString().length == 1) {
             month = '0'+month;
        }
        if(day.toString().length == 1) {
             day = '0'+day;
        }   
        if(hour.toString().length == 1) {
             hour = '0'+hour;
        }
        if(minute.toString().length == 1) {
             minute = '0'+minute;
        }
        if(second.toString().length == 1) {
             second = '0'+second;
        }   
        var dateTime = year+'-'+month+'-'+day+' '+hour+':'+minute+':'+second;   
         return dateTime;
    }

    // example usage: realtime clock
    setInterval(function(){
        currentTime = getTheDateTime();
        document.getElementById("digital-clock").innerHTML = currentTime;
    }, 1000);

function startTheTime() {
	var dttm = new Date();
	var y = dttm.getFullYear();
	var M = checkTime(dttm.getMonth()+1);
	var d = checkTime(dttm.getDate());
	var h = checkTime(dttm.getHours());
	var m = checkTime(dttm.getMinutes());
	var s = checkTime(dttm.getSeconds());
	document.getElementById('clock').innerHTML =
	y + "-" + M + "-" + d + " " + h + ":" + m + ":" + s; //Full formatted date/time.
	var t = setTimeout(startTheTime, 500);
}
function checkTime(i) {  //Check if less than 10;
	if (i &lt; 10) {i = "0" + i};  // add zero in front of numbers &lt; 10
	return i;
}
&lt;/script&gt;
&lt;/head&gt;

&lt;style&gt;
/*common css*/
table, th, td {border-collapse:collapse; border: 1px solid black;}
th {background-color:#ffff00;}
tr:nth-child(even) {background: #CCC;}
tr:nth-child(odd) {background: #FFF;}
a:link {text-decoration: none;}
a:visited {text-decoration: none;}
a:hover {text-decoration: underline;}
a:active {text-decoration: underline;}
th, td {padding: 5px;}
&lt;/style&gt;

&lt;body onload="startTheTime()"&gt;
&lt;table&gt;
&lt;tr&gt;&lt;td&gt;formatTheDate function: &lt;span id="time"&gt;&lt;/span&gt;&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;getTheDateTime function: &lt;span id="digital-clock"&gt;&lt;/span&gt;&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;startTheTime function: &lt;span id="clock"&gt;&lt;/span&gt;&lt;/td&gt;&lt;/tr&gt;
&lt;/table&gt;
&lt;div&gt;
&lt;script&gt;
var d = new Date();
var x = document.getElementById("time");
//x.innerHTML = formatTheDate(d, "dddd dd MMM yyyy HH:mm:ss");
x.innerHTML = formatTheDate(d, "dddd dd MMMM yyyy HH:mm:ss");
&lt;/script&gt;
&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
^</Template><Template Name="tmp_HTMLLinks" Description="HTML Link Examples">&lt;!-- Email link: https://www.w3docs.com/tools/code-editor/1181 --&gt;
&lt;a href="mailto:info@w3docs.com?cc=secondemail@example.com, anotheremail@example.com, &amp;bcc=lastemail@example.com&amp;subject=Mail from our Website&amp;body=Dear W3docs Team"&gt;Send Email&lt;/a&gt;
&lt;A HREF="microsoft-edge:http://www.itworld.com/blog/readme-file"&gt;Open README file with Edge&lt;/A&gt;
^
</Template><Template Name="tmp_HTMLSort" Description="Sortable HTML table">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;meta name="author" content="Robert Holland"&gt;
  &lt;meta name="description" content="Template HTML Document"&gt;
  &lt;meta name="keywords" content="comma,separated,keywords"&gt;
  &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
  &lt;meta charset="UTF-8"&gt;
&lt;title&gt;&lt;/title&gt;
&lt;link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css" /&gt;
&lt;script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"&gt;&lt;/script&gt;
&lt;script type="text/javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"&gt;&lt;/script&gt;
&lt;script&gt;
//$(document).ready(function() {
//    $('#example').DataTable();
//} );
$(document).ready(function() {
    $('#example').DataTable( {
        //scrollX:        '50vh', //On a small table, this will center the table data and leave the table headers left adjustes.
        scrollY:        '50vh',
        scrollCollapse: true,
        paging:         false
    } );
} );
&lt;/script&gt;
&lt;/head&gt;

&lt;style&gt;
/*common css*/
th {background-color:#c0c0c0;}
table, th, td {border-collapse:collapse; border: 1px solid black;}
a:link {text-decoration: none;}
a:visited {text-decoration: none;}
a:hover {text-decoration: underline;}
a:active {text-decoration: underline;}
th, td {padding: 5px;}
&lt;/style&gt;

&lt;body&gt;
&lt;img src='data:image/png;base64,
 {base64 data goes here without the braces}' /&gt;
&lt;br /&gt;

&lt;table id="example" class="display" width="50%"&gt;&lt;caption&gt;Table Caption&lt;/caption&gt;
&lt;thead&gt;
&lt;tr&gt;&lt;th&gt;One&lt;/th&gt;&lt;th&gt;Two&lt;/th&gt;&lt;th&gt;Three&lt;/th&gt;&lt;th&gt;Four&lt;/th&gt;&lt;/tr&gt;
&lt;/thead&gt;
&lt;tfoot&gt;
&lt;tr&gt;&lt;th&gt;One&lt;/th&gt;&lt;th&gt;Two&lt;/th&gt;&lt;th&gt;Three&lt;/th&gt;&lt;th&gt;Four&lt;/th&gt;&lt;/tr&gt;
&lt;/tfoot&gt;
&lt;tbody&gt;
&lt;tr&gt;&lt;td&gt;1&lt;/td&gt;&lt;td&gt;A&lt;/td&gt;&lt;td&gt;D&lt;/td&gt;&lt;td&gt;4&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;2&lt;/td&gt;&lt;td&gt;B&lt;/td&gt;&lt;td&gt;C&lt;/td&gt;&lt;td&gt;3&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;3&lt;/td&gt;&lt;td&gt;C&lt;/td&gt;&lt;td&gt;B&lt;/td&gt;&lt;td&gt;2&lt;/td&gt;&lt;/tr&gt;
&lt;tr&gt;&lt;td&gt;4&lt;/td&gt;&lt;td&gt;D&lt;/td&gt;&lt;td&gt;A&lt;/td&gt;&lt;td&gt;1&lt;/td&gt;&lt;/tr&gt;
&lt;/tbody&gt;
&lt;/table&gt;

&lt;a href="http://example.com"&gt;Example Anchor Link&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</Template><Template Name="tmp_ie_browser" Description="IE Content Type">&lt;meta http-equiv="X-UA-Compatible" content="IE=7;" /&gt;
&lt;meta http-equiv="X-UA-Compatible" content="IE=8" /&gt;
&lt;meta http-equiv="X-UA-Compatible" content="IE=9;" /&gt;
&lt;meta http-equiv="X-UA-Compatible" content="IE=11;" /&gt;
&lt;meta http-equiv="X-UA-Compatible" content="IE=edge" /&gt;
^</Template><Template Name="tmp_JavaScript" Description="JavaScript Snippets">Replace String:
	[XYZ].replace(/'/g, "&amp;#39;").replace(/"/g, "&amp;#34;");

  &lt;script&gt;
  	var p = "The dog's are not cat's!";
  	console.log(p.replaceAll("'", "&amp;#39;"));
  	document.write(p.replaceAll("'", "&amp;#39;"));
  &lt;/script&gt;

Introduction
  Replacing text in strings is a common task in JavaScript. In this article, you&#x2019;ll look at using&#xA0;replace&#xA0;and regular expressions to replace text.
  Note:&#xA0;Visit this companion tutorial for a detailed overview of how to use&#xA0;grep&#xA0;and regular expressions to search for text patterns in Linux.
  Prerequisites
  	&#x2022; A familiarity with the Javascript programming language. Visit our tutorial series,&#xA0;How To Code in Javascript, to learn the basics.

Replacing a Single Instance
  Normally JavaScript&#x2019;s&#xA0;String replace()&#xA0;function only replaces the first instance it finds in a string:
  app.js
  const myMessage = 'this is the sentence to end all sentences';
  const newMessage = myMessage.replace('sentence', 'message');
  console.log(newMessage); // this is the message to end all sentences
  &#xA0;
  In this example, only the first instance of&#xA0;sentence&#xA0;was replaced.

Replacing Multiple Instances
  If you want JavaScript to replace all instances, you&#x2019;ll have to use a regular expression using the&#xA0;/g&#xA0;operator:
  app.js
  const myMessage = 'this is the sentence to end all sentences';
  const newMessage = myMessage.replace(/sentence/g, 'message');
  console.log(newMessage); // this is the message to end all messages
  &#xA0;
  This time both instances are changed.
  In addition to using the inline&#xA0;/g&#xA0;, you can use the constructor function of the&#xA0;RegExp&#xA0;object:
  app.js
  const myMessage = 'this is the sentence to end all sentences';
  const newMessage = myMessage.replace(new RegExp('sentence', 'g'), 'message');
  console.log(newMessage); // this is the message to end all messages
&#xA0;
Replacing Special Characters
  To replace special characters like&#xA0;-/\^$*+?.()|[]{}), we&#x2019;ll need to use a backslash to escape them.
  Here&#x2019;s an example. Given the string&#xA0;this\-is\-my\-url, let&#x2019;s replace all the escaped dashes (\-) with an unescaped dash (-).
  You can do this with&#xA0;replace():
  app.js
  const myUrl = 'this\-is\-my\-url';
  const newUrl = myMessage.replace(/\\-/g, '-');
  console.log(newUrl); // this-is-my-url
  &#xA0;
  Alternatively, use&#xA0;new Regexp():
  app.js
  const myUrl = 'this\-is\-my\-url';
  const newUrl = myUrl.replace(new RegExp('\-', 'g'), '-');
  console.log(newUrl); // this-is-my-url
  &#xA0;
  In this second example, you don&#x2019;t have to use a backslash to escape the backslash.

Conclusion
	In this article, you saw how to replace single instances, multiple instances, and how to handle strings with special characters.

Source: https://www.digitalocean.com/community/tutorials/replace-all-instances-of-a-string-in-javascript

Replace last character in a string:
https://stackoverflow.com/questions/5497318/replace-last-occurrence-of-character-in-string
  var str = 'a_b_c';
  console.log(  str.replace(/_([^^_]*)$/, '$1')  ) //a_bc

  This will replace it with the contents of the variable replacement:
  var str = 'a_b_c', replacement = '!';
  console.log(str.replace(/_([^^_]*)$/, replacement + '$1')) //a_b!c

This is a recursive way that removes multiple occurrences of "endchar":
  function TrimEnd(str, endchar) {
    while (str.endsWith(endchar) &amp;&amp; str !== "" &amp;&amp; endchar !== "") {
      str = str.slice(0, -1);
    }
    return str;
  }

  var res = TrimEnd("Look at me. I'm a string without dots at the end...", ".");
  console.log("Look at me. I'm a string with dots at the end...");
  console.log(res);

Compare Dates:
	&lt;p&gt;valueOf() returns the primitive value of a date object:&lt;/p&gt;

	&lt;p id="demo"&gt;&lt;/p&gt;
	&lt;script&gt;
	let ms = new Date('1900-05-10 00:00:01').valueOf();
	let mt = new Date('1900/05/10 00:00:00').valueOf();
	if (ms &lt; mt){
	document.getElementById("demo").innerHTML = "MS is older";
	}
	else {
	document.getElementById("demo").innerHTML = "MT is older";
	}
	//document.getElementById("demo").innerHTML = ms;
	&lt;/script&gt;

User Feedback:
  &lt;a href="javascript:feedbackLink()"&gt;User Feedback&lt;/a&gt;
  &lt;script type="text/javascript"&gt;
  function feedbackLink()
    {
    url="https://svcnowprod.service-now.com/sp/?id=sc_cat_item&amp;sys_id=d6697f5ddb317c148dce4a28139619e6";
    //var obj = APPLINK(100,url,"");
    location.href = url;
    }
  &lt;/script&gt;

Even or Odd:
  function isEven(n) {
     return n % 2 == 0;
  }

  function isOdd(n) {
     return Math.abs(n % 2) == 1;
  }

	Usage:
			if(isEven(i))
		   {
					var medRow = 'normalMedRow';
		   }
			else{
					var medRow = 'coloredMedRow';
		   }
		   
			if(isOdd(i))
		   {
					var medRow = 'normalMedRow';
		   }
			else{
					var medRow = 'coloredMedRow';
		   }
		   
^</Template><Template Name="tmp_JavaScript_dateCounter" Description="Display Days Hours Minutes Seconds">&lt;script&gt;
//var countUpDate = localStorage.getItem('startDate'); //Stores the startDate.
//var countUpDate = Date.parse('2019-05-15 07:11:10.673Z'); //Testing manually inputted date.
var countUpDate = Date.parse('01/12/2023 09:32'); //Pull this date value from the database.
if (countUpDate) {
    countUpDate = new Date(countUpDate);
} else {
    countUpDate = new Date();
    localStorage.setItem('startDate', countUpDate);
}

// Update the count up every 1 second
var x = setInterval(function() {

    // Get todays date and time
    var now = new Date().getTime();

    // Find the distance between now and the count up date
    var distance = now - countUpDate.getTime();

    // Time calculations for days, hours, minutes and seconds
    var days = appendZero(Math.floor(distance / (1000 * 60 * 60 * 24)));
    var hours = appendZero(Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)));
    var minutes = appendZero(Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60)));
    var seconds = appendZero(Math.floor((distance % (1000 * 60)) / 1000));

    // Output the result in an element with id="demo"
    document.getElementById("demo").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";
    //Put zero in front numbers that are less than 10.
}, 1000);

function appendZero(i) {  //Check if less than 10;
if (i &lt; 10) {i = "0" + i};  // add zero in front of numbers &lt; 10
return i;
}
&lt;/script&gt;</Template><Template Name="tmp_linux" Description="Linux">#!/bin/bash
#!/bin/ksh

#Lookup select command in Linux to create menus that run commands.
#https://www.geeksforgeeks.org/select-command-in-linux-with-examples/?ref=rp
#https://linuxhint.com/bash_select_command/
#https://www.youtube.com/channel/UCIa6d3QPq7Ulqz8Ha2WRf3A

#Change Shell:
chsh
	You will be prompted to enter the shell you wish to use. Log out and back in to see the changes.

#Basic script example:
for file in *.prg
do
echo $file
done

#Array - Connect to specifically numbered servers:
rho_hosts=(1 2 3 4 5 6 7 8 9 10 11 12 19 20 22)
for i in ${rho_hosts[@]}
do
  echo "Searching samtazapp${i}: "
  ssh rholland@samtazapp"$i" "ls -alFh /cerner/w_custom/p1805_cust/code/$1/$2"
  #echo "$i"
done

#Connect to specifically numbered servers:
i=1
while [[ $i -le 22 ]]
do
  echo "Searching samtazapp$i: "
  scp rholland@samtazapp"$i":/cerner/w_custom/p1805_cust/code/html/1bh_mpage_ams_jdm.html 1bh_mpage_ams_jdm_"$i".html
  # echo "$i"
   let i=i+1
done

#Create 10 sequentially numbered files:
for i in `seq 1 10`;
do
touch filename$i.txt
done

#Create 10 sequentially numbered files:
printf '\nHello\ World%s' {1..10}.txt |xargs touch

#Create sequentially numbered or lettered files:
#https://stackoverflow.com/questions/4140822/creating-multiple-files-with-content-from-shell
touch {a..z}.txt
touch {{a..z},{A..Z},{0..99}}.txt

#Loop to create 100 files:
  for f in {a..z} {A..Z} {0..99}
    do
      echo hello &gt; "$f.txt"
    done

#You can do numbered files with leading zeros:
  for i in {0..100}
    do
        echo hello &gt; "File$(printf "%03d" "$i").txt"
    done

#or, in Bash 4:
    for i in {000..100}
    do
        echo hello &gt; "File${i}.txt"
    done

    for f in {0000..1000}
    do
        ls -al &gt; "${f}.txt"
    done

#Create 10 files with 1MB of random data:
    for i in {1..10};
    do
        #dd if=/dev/urandom of=./path/filename${i} bs=1M count=1;
        dd if=/dev/urandom of=./filename${i} bs=1M count=1;
    done

#Another while example:
#!/bin/bash
COUNTER=0
while [  $COUNTER -lt 10 ]; do
echo The counter is $COUNTER
let COUNTER=COUNTER+1
done

#Until example:
#!/bin/bash
COUNTER=20
until [  $COUNTER -lt 10 ]; do
echo COUNTER $COUNTER
let COUNTER-=1
done

#If Else conditions:
if [ $# -eq 0 ]
then
echo 'Message'
else
echo 'Run some code'
fi

#Change file extension:
for x in *.txt
do cat ${x} &gt; a/${x%%txt}dat
done

#Case:
DF() {
case $1 in
        size)
                df -h|sort -nk2
        ;;
        used)
                df -h|sort -nk3
        ;;
        available)
                df -h|sort -nk4
        ;;
        percent_used)
                df -h|sort -nk5
        ;;
        *)
                echo "Usage:"
                echo "     [DF blocks | DF used | DF available | percent_used]"
        ;;
esac
}

#Create Empty Files:
dummyfiles(){
if [ $# -eq 0 ]
then
echo "dummyfiles 30"
else
#printf '%s ' {1..$1}.txt |xargs touch
for ((i=1; i&lt;=$1; i++)); do : &gt;&gt; dummyfile_"$i".txt; done
fi
}

#Echo carriage return:
toclientsite (){
if [ $# -eq 0 ]
then
local string
string+='To send a file to the Windows pickup directory on Node1: \\\\PHX00435\\adhoc\\'
string+=$'\n'
string+='Example: toclientsite filename.txt'
clear
echo "$string"
else
        cp $1 /mnt/astream/to_client_site/p1805/adhoc/
fi
}

#Find the longest line in a delimited file:
cat req_num1.csv |cut -d "|" -f4|awk '{print length}'|sort|uniq

#Find the longest line in a file:
cat req_num1.csv |awk '{print length}'|sort|uniq

#Find the longest line with the characters /10011/ in a file:
cat req_num1.csv |awk '/10011/ {print length}'|sort|uniq

#Symbolic Link:
ln -s /path/to/file linkname

#Local Port redirect:
ssh -f username@servername -L:6868:remotecomputerIP:80 -N
	This allows you to connect to port 6868 on your local computer and it will be redirected to port 80 on the remote computer.

#Remote Port redirect:
ssh -R 8080:localhost:80 public.example.com
	This allows anyone on the remote server to connect to TCP port 8080 on the remote server. The connection will then be tunneled back to the client host, and the client then makes a TCP connection to port 80 on localhost. Any other host name or IP address could be used instead of localhost to specify the host to connect to.

#Tar files in current directory (put tarball outside of current directory otherwise it will be included in the archive):
tar -zcvf ../NameOfTarball.tar.gz .

#Email:
Email File Attachment:
mailx -a TheFileName.txt -r "robert.holland@example.com (Robert Holland)" -s "$1" $2 &lt; /dev/null

Email File Contents:
mailx -r "robert.holland@example.com (Robert Holland)" -s "RH_SearchResults.RITM00000.txt" robert.holland@example.com &lt; RH_SearchResults.RITM00000.txt

mailx -r "robert.holland@example.com (Robert Holland)" -s "$1" $2

#Email file content from RHO Linux environment
email() {
if [ $# -eq 0 ]
then
echo Usage: email filename.xxx person@example.com
else
cat $1 |mailx -r "robert.holland@example.com (Robert Holland)" -s "$1" $2
fi
}

#Email file attachment from RHO Linux environment
emailattachment() {
if [ $# -eq 0 ]
then
echo Usage: emailattachment filename.xxx person@example.com
else
mailx -a $1 -r "robert.holland@example.com (Robert Holland)" -s "$1" $2 &lt; /dev/null
fi
}

#uue a file then email it.
UUE() {
if [ $# -eq 0 ]
then
echo Usage: UUE filename.xxx person@example.com
else
uuencode $1 $1 | mailx -r "robert.holland@example.com (Robert Holland)" -s "$1" $2
#mailx -a $1 -s "$1" $2
fi
}

#uue a ccl or prg then email it.
UUECCL() {
if [ $# -eq 0 ]
then
echo Usage: UUECCL cclfilename.xxx person@example.com
else
cat $1 &gt; $1.txt; uuencode $1.txt $1.txt | mailx -r "robert.holland@example.com (Robert Holland)" -s "Rename $1.txt to .prg" $2; rm -f $1.txt
fi
}

#Change Environments:
Environment Set: envset d_b1805
New Group: newgrp - d_b1805

# ----------------------------------------------------------------------------
# Script Author: Robert Holland
# Script Name: update2.sh
# Creation Date: Fri Apr 29 2022 17:09:32 GMT-0700 (US Mountain Standard Time)
# Last Modified:
# Copyright (c)2022
# Purpose: Update the original files from the x directory: (run from inside the x directory)
# ----------------------------------------------------------------------------

#!/bin/bash
	for file in *.html
	do
	cat $file &gt; ../$file
done


# ----------------------------------------------------------------------------
# Script Author: Robert Holland
# Creation Date: Thu Jun 01 2017 10:40:29 GMT-0700 (US Mountain Standard Time)
# Last Modified:
# Copyright (c)2017
# Purpose: Delete zero byte files.
# ----------------------------------------------------------------------------

#Delete zero byte files that start with RH_
typeset minimumsize=1
typeset FILECHECK=RH_*
#If there are no RH_* files exit the script.
if [ ! -f $FILECHECK ]; then
  exit
else
#If there are files, delete the empty (zero byte) ones.
for f in $FILECHECK;
do
        actualsize=$(wc -c &lt; $f)
        if [ $actualsize -le $minimumsize ]; then
    #echo "Size is: ($actualsize bytes). Deleted $f." &gt;&gt; $FILE13
    rm -f $f
  fi
done
fi

ls -al RH_*


find / -iname 'filename*.txt'
^
</Template><Template Name="tmp_linux_getfiles" Description="Get files from Linux system.">if [ $# -eq 0 ]
then
echo "USAGE: ./getfiles.sh username"
else
cd html;scp $1@samtazapp1.cernerasp.com:/cerner/w_custom/p1805_cust/code/html/1samt_az_bhts_org_testx.html .;cd ../
cd prg; scp $1@samtazapp1.cernerasp.com:/cerner/w_custom/p1805_cust/code/script/1bh_mpage_bhts_org_testx.prg .;cd ../
#cd html;scp $1@samtazapp14.cernerasp.com:/mnt/astreamnp/custom_warehouses/b1805/code/html/1samt_az_bhts_org_testx.html .;cd ../
#cd prg;scp $1@samtazapp14.cernerasp.com:/mnt/astreamnp/custom_warehouses/b1805/code/script/1bh_mpage_bhts_org_testx.prg .;cd ../
fi</Template><Template Name="tmp_linux_remove_cr" Description="Remove carriage returns, join lines together">https://www.baeldung.com/linux/join-multiple-lines
#Join lines together:
	(readarray -t ARRAY &lt; xxxyyy.txt; IFS=''; echo "${ARRAY[*]}") &gt; xxxyyy1.txt
	(readarray -t ARRAY &lt; j.json; IFS=''; echo "${ARRAY[*]}") &gt; j1.json
^</Template><Template Name="tmp_linux_remove_whitespace" Description="Remove whitespace from around a delimiter.">#Purpose: Delete whitespace from around the specified delimiter.
# Example delimiter is ~: 
# 	cat rh_banner_orgs_and_locs.dat | sed 's/[[:space:]]*~[[:space:]]*/~/g' &gt; rh_banner_orgs_and_locs1.dat

#The delimiter is: [+delimiter+]

Remove space before and after the delimiter:
	sed 's/[[:space:]]*[+delimiter+][[:space:]]*/[+delimiter+]/g'

Remove space before the delimiter:
	sed 's/[[:space:]]*[+delimiter+]/[+delimiter+]/g'

Remove space after the delimiter:
	sed 's/[+delimiter+][[:space:]]*/[+delimiter+]/g'
^</Template><Template Name="tmp_linux_rename_extension" Description="Rename file extension">#Rename extension [+from+] [+to+] dat.
for x in *.[+from+]
do cat ${x} &gt; a/${x%%[+from+]}[+to+]
done
^</Template><Template Name="tmp_linux_sed" Description="sed">
#Update a group of files:
for file in *.html
do
cat $file|sed 's/samtazea\./samtazeanp\./g'| sed 's/SAMTAZEA\./SAMTAZEANP\./g'| sed 's/b1805/m1805/g'| sed 's/B1805/M1805/g'| sed 's/p1805/m1805/g'| sed 's/P1805/M1805/g' &gt; x/$file
done

#Update a group of files:
#!/bin/bash
for file in *.txt
do
   cat $file| sed 's/[Rr][Oo][Bb][Ee][Rr][Tt]/Robert_H/g' &gt; foldername/$file
done


#!/bin/bash
# ----------------------------------------------------------------------------
# Script Author: Robert Holland
# Script Name: doit.ksh
# Creation Date: Fri Nov 02 2018 10:06:49 GMT-0700 (US Mountain Standard Time)
# Last Modified:
# Copyright (c)2018
# Purpose: Purpose: Change the mPage .html files to point to the Websphere server in the correct RHO domain environmenronment.
# Note: For some reason, there were some files that were missed during the first run. I had to create a second RHO directory and run this again.
# ----------------------------------------------------------------------------

for file in *.html
do
#cat "$file" | sed 's/samtazea\.cernerasp\.com/samtazeanp\.cernerasp\.com/' | sed 's/[Pp]1805/x1805/' &gt; x/"$file"
#cat "$file" | sed 's/samtazeanp\.cernerasp.com/samtazea\.cernerasp.com/' | sed 's/[Bb]1805/x1805/' &gt; x/"$file"
#cat "$file" | sed 's/http:\/\/requestcenter\.bhs\.bannerhealth\.com\/Pages\/GeneralRequest.aspx?formID=285/https:\/\/svcnowprod\.service-now\.com\/sp\/?id=sc_cat_item\&amp;sys_id=d6697f5ddb317c148dce4a28139619e6/' &gt; x/$file
done

This script is a quick way to update all of the files in the html directory on the backend.
You will first need to create a folder named "x" in the html directory.


# ----------------------------------------------------------------------------
# Script Author: Robert Holland
# Script Name: update1.sh
# Creation Date: Fri Apr 29 2022 17:09:32 GMT-0700 (US Mountain Standard Time)
# Last Modified:
# Copyright (c)2022
# Purpose: Saves updated files to the x directory: (run from the html directory)
# ----------------------------------------------------------------------------

#!/bin/bash
	for file in *.html
	do
	cat "$file" | sed 's/b1805/m1805/' &gt; x/$file
	done


Remove the spaces before each "#". "i" means input from a file.
	sed -i 's/\s*#/#/g' rh_testing1234.txt

Remove the spaces after each "#"
	sed -i 's/\s#*/#/g' rh_testing1234.txt

https://www.unix.com/unix-for-beginners-questions-and-answers/277826-remove-whitespaces-between-delimiter-characters.html
sed ':L; s/| \+|/|0|/; tL; s/ *| */|/g'

Remove spaces before and after "#" but leave spaces between words.
For example: This # is # a # sentence # that has the pound sign # in # it.
The following sed command will create: This#is#a#sentence#that has the pound sign#in#it.
	sed ':L; s/# \+#/#/; tL; s/ *# */#/g' rh_testing1234.txt


#Author: Robert Holland
#Creation Date: Thu Jun 01 2017 10:40:29 GMT-0700 (US Mountain Standard Time)
#Last Modified:
#Copyright (c)2017
#Purpose: Delete whitespace from around the specified delimiter.
# cat rh_banner_orgs_and_locs.dat | sed 's/[[:space:]]*~[[:space:]]*/~/g' &gt; rh_banner_orgs_and_locs1.dat

#Set delimeter on next line:
typeset DELIMETER="~" #Change this delimiter if needed. DO NOT use an asterisks as the delimeter. Also, make sure the SED delimeter below does not match the delimeter here.

#Should not need to edit below this line unless your delimeter is a "#" sign.
typeset FILECHECK=$1
#If file does not exist, exit the script.
if [ ! -f $FILECHECK ]; then
  echo "$FILECHECK file not found!"
  exit
else
#If file does exist:
#SED within scripts will need to be run inside quotes and change the delimeter to something other than the forward slash.
#I am using the pound or hash sign (#) below as the SED delimeter. If the typeset DELIMETER above is a "#" sign you will need to change the SED delimeter below to something different.

#Create new file with no spaces and ".delimited" extension.
sed "s#[[:space:]]*$DELIMETER[[:space:]]*#$DELIMETER#g" $FILECHECK &gt; $1.delimited
echo $1.delimited has been created.
fi


Replace a word with new line /carriage return.
https://unix.stackexchange.com/questions/194050/how-to-replace-a-word-with-new-line
Example: replacing "id=" with carriage return "id=".
 grep -nirH "id=" 1samt_az_pedcode_calc.html|sed 's/[Ii][Dd]=/\nid=/g'|grep -v 1samt_az_pedcode_calc|cut -d '"' -f2|sort &gt; rh_calc_ids.txt

Make a renaming file:
	ls |awk '{print "mv " $9 " " $9"_"}'

Remove the second instance of "=" and replace it with "_":
	cat renamefiles.sh | sed 's/=/_/2' &gt; rename2.sh

Change the second instance of the filename so there is only one letter "i" in the filename:
	cat rename2.sh |sed 's/Banner_Patient_Meds_InActive/BPM_i/2' &gt; rename1.sh

Change the second instance of ".csv" to nothing:
	cat rename1.sh |sed 's/\.csv//2'

Remove leading whitespace before a particular word.
sed 's/^.*POWERFORM/POWERFORM/g'

Remove double quotes:
sed 's/\x22//g' infile.txt  &gt; outfile.txt

Remove the double apostrophe by using the octal representation (\o047) of the apostrophe (Source):
cat Medication_List_20161001_20170430_20170519_092131.txt |sed 's/\o047\o047//g' &gt; yyyy.txt
^</Template><Template Name="tmp_loggedon" Description="Who is logged on">query user /server:[+COMPUTERNAME+]

psloggedon.exe \\[+COMPUTERNAME+]</Template><Template Name="tmp_mariadb_grant" Description="Grant username privileges on databases.">&lt;?php
// ----------------------------------------------------------------------------
// Script Author: Robert Holland
// Script Name: mariadb_grant.php
// Creation Date: Fri Jan 20 2023 23:20:08 GMT-0700 (MST)
// Last Modified: 20230120232231
// Version: 1.0.0
// Purpose: Generate MariaDB GRANT statements for databases (You will need to manually remove system DBs).
// ----------------------------------------------------------------------------

//How to write prepare and execute statements in OOP PDO?
//https://stackoverflow.com/questions/42551050/how-to-write-prepare-and-execute-statements-in-oop-pdo
//https://stackoverflow.com/questions/18679448/pdo-class-is-this-technically-correct
//https://stackoverflow.com/questions/369602/deleting-an-element-from-an-array-in-php
//https://stackoverflow.com/questions/4356289/php-random-string-generator/4356295#4356295

include'pw.php';

$dbshow = new Connection(); //Instantiate a new connection.
$dbshow-&gt;myQuery("show databases;");
$rows = $dbshow-&gt;All();

//Generate random string of specified length.
function generateRandomString($length) {
$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
//$characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'; //Random uppercase and lowercase letters only.
//$characters = 'abcdefghijklmnopqrstuvwxyz'; //Random lowercase letters only.
//$characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; //Random uppercase letters only.
//$characters = '0123456789'; //Random numbers only.
$charactersLength = strlen($characters);
$randomString = '';
for ($i = 0; $i &lt; $length; $i++) {
$randomString .= $characters[rand(0, $charactersLength - 1)];
}
return $randomString;
}
//$ThePassword = generateRandomString(64); //Pass the number of random characters to generate.
//echo $ThePassword . "\r\n";

function myfunction($value,$key)
{
$dbusername = "[+TheDB_Username+]";
$ThePassword = generateRandomString(8); //Random 8 characters.
//echo "The key $key has the value $value. ";
//echo "CREATE USER '$dbusername'@'%' IDENTIFIED VIA mysql_native_password USING '$ThePassword'; &lt;br /&gt;";
echo "GRANT USAGE ON $value.* TO '$dbusername'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0; GRANT ALL PRIVILEGES ON `$value`.* TO '$dbusername'@'%'; GRANT ALL PRIVILEGES ON `$value\_%`.* TO '$dbusername'@'%'; &lt;br /&gt;&lt;br /&gt;";
//Example:
//GRANT USAGE ON robdba3.* TO 'robdba5'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0; GRANT ALL PRIVILEGES ON `robdba3`.* TO 'robdba5'@'%'; GRANT ALL PRIVILEGES ON `robdba3\_%`.* TO 'robdba5'@'%';
}
$i=count($rows);
for($x = 0; $x &lt; $i; $x++){
$y=$rows[$x]; //Reduce the array.
//array_diff to remove critical databases from the output.
//This prevents accidentally assigning permissions to critical system databases.
$y = array_diff($y, array("information_schema", "performance_schema","mysql","sys"));
array_walk($y,"myfunction");
}

//Remove these critical system databases from the output.
//information_schema
//mysql
//performance_schema
//sys - The sys database is in mysql.

?&gt;</Template><Template Name="tmp_mariadb_user" Description="Create a MariaDB user and grant access to a database.">[+TheUserName+], [+ThePassword+], [+TheDatabaseName+]
-- CREATE USER '[+TheUserName+]'@'%' IDENTIFIED VIA mysql_native_password USING '[+ThePassword+]';
CREATE USER '[+TheUserName+]'@'%';
CREATE USER '[+TheUserName+]'@'localhost';
SET PASSWORD FOR '[+TheUserName+]'@'%' = PASSWORD('[+ThePassword+]');
SET PASSWORD FOR '[+TheUserName+]'@'localhost' = PASSWORD('[+ThePassword+]');
GRANT USAGE ON [+TheDatabaseName+].* TO '[+TheUserName+]'@'%' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
GRANT USAGE ON [+TheDatabaseName+].* TO '[+TheUserName+]'@'localhost' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;
GRANT ALL PRIVILEGES ON `[+TheDatabaseName+]`.* TO '[+TheUserName+]'@'%';
GRANT ALL PRIVILEGES ON `[+TheDatabaseName+]`.* TO '[+TheUserName+]'@'localhost';
GRANT ALL PRIVILEGES ON `[+TheDatabaseName+]\_%`.* TO '[+TheUserName+]'@'%';
GRANT ALL PRIVILEGES ON `[+TheDatabaseName+]\_%`.* TO '[+TheUserName+]'@'localhost';

-- My User Grant Begin
-- Note: The use of backticks are needed. `%`.* instead of *.* 
-- GRANT ALL PRIVILEGES ON `%`.* TO 'rob'@'localhost' WITH GRANT OPTION;
-- GRANT ALL PRIVILEGES ON `%`.* TO 'rob'@'%' WITH GRANT OPTION;
-- My User Grant End
^
</Template><Template Name="tmp_MSSQL_arrays_list" Description="MSSQL Arrays and Lists">https://www.sommarskog.se/arrays-in-sql.html</Template><Template Name="tmp_MSSQL_between" Description="Between two dates">select * from test
-- Older date first;
where some_dt_tm &gt;= '1995/03/17 16:50:00' and some_dt_tm &lt;= '1995/03/18 17:40:00';
or
where some_dt_tm &gt;= 'September 08, 2021%' and some_dt_tm &lt;= 'September 27, 2021%';

https://stackoverflow.com/questions/5125076/sql-query-to-select-dates-between-two-dates
and begin_dt_tm between '2011/02/25' and '2011/02/27'
^
</Template><Template Name="tmp_MSSQL_check_if_tables_have_rows" Description="tmp_MSSQL_check_if_tables_have_rows">--Create query to check user created tables and views for existing rows of data. Basically, checking if they are empty.
select concat('select count(*) ',name,'_NumOfRows from ',name,';') checknumrows from sysobjects where xtype in ('u','v');
select concat('select FORMAT(count(*), ''N'') num_rows_in_',replace(name,' ','_'),'_table from "',name,'";') as TblRowCount from sysobjects where xtype = 'u';
^</Template><Template Name="tmp_MSSQL_common" Description="SQL Common">-- Show top number of rows.
	select top (100) * from TheTableName;
	select top (100) [column1], [column2] from TheTableName;

-- Show number of rows with comma delimited result:
	https://database.guide/how-to-format-numbers-with-commas-in-sql/
	select format(count(*),'N') 'NumRows' FROM dbo.TheTableName;

-- Show table information.
	exec sp_help thetablename

-- Show the size of the database:
	exec sp_spaceused;
	exec sp_spaceused @oneresultset = 1

-- Show database size and owner information:
	exec sp_helpdb;

--View Connection information:
	exec sp_who

-- Show linked servers:
	EXEC sys.sp_linkedservers 

--https://stackoverflow.com/questions/189422/how-do-i-create-and-query-linked-database-servers-in-sql-server
--Set up the link:
	exec sp_addlinkedserver  @server='10.10.0.10\MyDS';

----Set up the access for remote user, example below:
	exec sp_addlinkedsrvlogin  '10.10.0.10\MyDS', 'false', null, 'adm', 'pwd';

--See the linked servers and user logins:
	exec sp_linkedservers;

	select * from sys.servers;

	select * from  sys.linked_logins;

--Run the remote query:
	select * from [10.10.0.10\MyDS].MyDB.dbo.TestTable;

--Drop the linked server and the created login users (adm/pwd)
	exec sp_dropserver '10.10.0.10\MyDS', 'droplogins'; -- drops server and logins

--Rename column:
 This function checks if the table &#x2018;DimEmployee&#x2019; exists in the database AdventureWorksDW2017, if yes, it renames the column &#x2018;Title&#x2019; to &#x2018;Title Name&#x2019;
use adventureworks;
if object_id(N'dbo.DimEmployee', N'U') is not null
exec sp_rename 'DimEmployee.Title', 'Title Name', 'COLUMN');
another example:
exec sp_rename 'timezone_abbr.offset_int','offset_hour', 'column';

-- Alter Table:
	--Add column:
	alter table test add begin_dt_tm1 datetime null;

	--Change datatype:
	alter table test1 alter column encntr_id int;

-- REMOVE AND REPLACE CARRIAGE RETURNS AND LINE BREAKS IN SQL
	--https://tarsolutions.co.uk/blog/remove-a-line-feed-carriage-return-from-a-string/
	--Using SQL to remove a line feed or carriage return means using the CHAR function.
	--A line feed is CHAR(10); a carriage return is CHAR(13).
	--The following code will remove linefeed characters in SQL and replace them with a zero-length string:
	UPDATE TableName SET FieldName = REPLACE(FieldName,CHAR(10),'')

	--Cannot use replace on Text datatype so you will have to cast as varchar or something else.
replace(replace([Discern_Rule], char(10),''), char(13),'') discern_rule
	replace(replace(cast([subject] as varchar), char(10),''), char(13),'') as subject

-- Convert varchar(date) to datetime: This way you can use between on the dates.
-- https://stackoverflow.com/questions/18568410/how-to-convert-date-to-a-format-mm-dd-yyyy
-- https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles
	-- The varchar date field must be time data only and cannot have "EST", "MST", "PST" timezones in the field or you will get the following error: 
	-- Msg 241, Level 16, State 1, Line 2
	-- Conversion failed when converting date and/or time from character string.
	convert(varchar(25), cast([BEGIN_DT_TM1] as datetime), 21) begin_dt_tm2
		-- varchar(25) - covers the display of time with millseconds
		-- cast([BEGIN_DT_TM1] as datetime - Will cast the varchar datatype to datetime
		-- , 21 - is the date type style "yyyy-mm-dd hh:mi:ss.mmm (24h)". Look at the URL above.

		-- This works too: cast(replace([BEGIN_DT_TM], 'MST','') as datetime) begin_dt_tm2

-- Get the definition of a view:
https://docs.microsoft.com/en-us/sql/relational-databases/views/get-information-about-a-view?view=sql-server-ver15
  SELECT definition, uses_ansi_nulls, uses_quoted_identifier, is_schema_bound  
  FROM sys.sql_modules  
  WHERE object_id = OBJECT_ID('TheNameOfTheView');

	-- Can also use: 
		exec sp_helptext TheNameOfTheView

-- Parsename - Is really great for IPv4 addresses because it looks at 4 fields separated by a dot. You can use it for other data but you will have to get the data into 4 fields separated by a dot. 

	-- This example I replaced spaces and colons with a dot so that I can get 4 fields. The 1 at the end is to show the last field of the 4. A 2 will show the second to last field, 3 shows the third to last field, etc.
	
		parsename(replace(replace(begin_dt_tm, ' ', '.'), ':','.'), 1)
		
	-- This is what I used to display a unique list of all of the timezones that were at the end of a date time field that was varchar(255) instead of datetime.
	
  select distinct(parsename(replace(replace(replace(begin_dt_tm, ' ', '.'), ':',''),',.',''), 1)) as TimeZones from [CDS].[dbo].[DISCERN_EMAIL] order by TimeZones; --Find all timezones.
		
select @@version;
select @@servername;
select db_name();

use master;
  select name, crdate from sysdatabases;

select name, crdate from sysobjects where xtype = 'u' order by name;
^</Template><Template Name="tmp_MSSQL_Create_User" Description="Create User, Password, and DB assignment.">User Roles:
  accessadmin
  backupoperator
  datareader
  datawriter
  ddladmin
  denydatareader
  denydatawriter
  owner
  securttyadmin
  public

-- Password Expiration and policy ON
USE [master]
GO
CREATE LOGIN [+THEDBUSERNAME+] WITH PASSWORD=N'[+TheDBUserPaSsW0rD+]' MUST_CHANGE, DEFAULT_DATABASE=[+DEFFAULTDATABASE+], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
use [+DEFFAULTDATABASE+];
GO
use [+OTHERDATABASE_1+];
GO
USE [+DEFFAULTDATABASE+]
GO
CREATE USER [+THEDBUSERNAME+] FOR LOGIN [+THEDBUSERNAME+]
GO
USE [+DEFFAULTDATABASE+]
GO
ALTER ROLE [+USERROLE_1+] ADD MEMBER [+THEDBUSERNAME+]
GO
USE [+DEFFAULTDATABASE+]
GO
ALTER ROLE [+USERROLE_2+] ADD MEMBER [+THEDBUSERNAME+]
GO
use [+OTHERDATABASE_1+];
GO
use [+DEFFAULTDATABASE+];
GO
USE [+OTHERDATABASE_1+]
GO
CREATE USER [+THEDBUSERNAME+] FOR LOGIN [+THEDBUSERNAME+]
GO
USE [+OTHERDATABASE_1+]
GO
ALTER ROLE [+USERROLE_1+] ADD MEMBER [+THEDBUSERNAME+]
GO
USE [+OTHERDATABASE_1+]
GO
ALTER ROLE [+USERROLE_2+] ADD MEMBER [+THEDBUSERNAME+]
GO

-- Password Expiration and policy OFF
USE [master]
GO
CREATE LOGIN [+THEDBUSERNAME+] WITH PASSWORD=N'[+TheDBUserPaSsW0rD+]' MUST_CHANGE, DEFAULT_DATABASE=[+DEFFAULTDATABASE+], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
use [+DEFFAULTDATABASE+];
GO
use [+OTHERDATABASE_1+];
GO
USE [+DEFFAULTDATABASE+]
GO
CREATE USER [+THEDBUSERNAME+] FOR LOGIN [+THEDBUSERNAME+]
GO
USE [+DEFFAULTDATABASE+]
GO
ALTER ROLE [+USERROLE_1+] ADD MEMBER [+THEDBUSERNAME+]
GO
USE [+DEFFAULTDATABASE+]
GO
ALTER ROLE [+USERROLE_2+] ADD MEMBER [+THEDBUSERNAME+]
GO
use [+OTHERDATABASE_1+];
GO
use [+DEFFAULTDATABASE+];
GO
USE [+OTHERDATABASE_1+]
GO
CREATE USER [+THEDBUSERNAME+] FOR LOGIN [+THEDBUSERNAME+]
GO
USE [+OTHERDATABASE_1+]
GO
ALTER ROLE [+USERROLE_1+] ADD MEMBER [+THEDBUSERNAME+]
GO
USE [+OTHERDATABASE_1+]
GO
ALTER ROLE [+USERROLE_2+] ADD MEMBER [+THEDBUSERNAME+]
GO</Template><Template Name="tmp_MSSQL_LinuxConnect" Description="MSSQL Connect from Linux">Connecting to MSSQL from Fedora (and then Python)
FEBRUARY 11TH, 2015
With a heavy heart, I find myself having to talk to an MSSQL database. Fortunately, I can do this from a Linux (Fedora) VPS, so all is not lost.

For the following write-up (which are really just notes to myself), these links were helpful :

ububtu instructions - clear but not directly applicable
Helpful hints from Stackoverflow
Fedora notes - wrong target language, though
Step 1 : Check there&#x2019;s no firewall in the way
Try the port to check that the response differs from one with no server sitting on it :

telnet 192.168.x.y 1433
Step 2 : Install FreeTDS
The FreeTDS package is the one that Fedora uses :

yum install freetds freetds-devel unixODBC unixODBC-devel 
Step 3 : Check that simple queries run (command line - direct)
Using the tsql utility (from FreeTDS), test that the basic connection works (each SQL command needs to be followed by &#x2018;go&#x2019; on a separate line to get it to execute) :

tsql -H hostname.of.the.server -p 1433 -U username-for-db
#(enter password here not on command line to avoid it appearing in history, or in process list)
When the tsql prompt comes up,

# Do a fully-qualified query 
select count(*) from DATABASENAME.dbo.TABLENAME

# Do the same, drilled down
use DATABASENAME
select count(*) from TABLENAME

# Get a listing of the tables available
SELECT * FROM information_schema.tables where TABLE_TYPE = 'BASE TABLE'
Step 4 : Check that simple queries run (command line - named server)
In order to connect to the database by &#x2018;name&#x2019;, add it as an entry into /etc/freetds.conf :

[arbitrary-tds-server-title]
  host = hostname.of.the.server
  port = 1433
  tds version = 7.0
Then queries can be run using the given name (which will then be able to pick out the appropriate hostname and port from the configuration file) :

tsql -S arbitrary-tds-server-title -U username-for-db
#(enter password, not-in-history)
Step 5 : Set up ODBC configurations
Firstly, find the driver locations (on disk!) to put into /etc/odbcinst.ini :

find / -iname 'libtds*.so'
Then, create a suitable entry in /etc/odbcinst.ini, so that ODBC know to talk to the FreeTDS drivers :

[FreeTDS]
Description = MS SQL database access with Free TDS
Driver64    = /usr/lib64/libtdsodbc.so
Setup64     = /usr/lib64/libtdsS.so
FileUsage   = 1
Then, create an entry in /etc/odbc.ini (which may have to be created) :

[sqlserverdatasource-name-is-arbitrary]
Driver      = FreeTDS
Description = ODBC connection via FreeTDS
Trace       = No
Servername  = arbitrary-tds-server-title
#Database    = &lt;name of your database - may be useful to restrict usage&gt;
Step 6 : Set up Python connection to ODBC
yum install pyodbc
And then one can use it in the Python shell :

python
&gt;&gt;&gt; import pyodbc
&gt;&gt;&gt; dsn='sqlserverdatasource-name-is-arbitrary'
&gt;&gt;&gt; user='username-for-db'
&gt;&gt;&gt; password='XXXXXXXX'
&gt;&gt;&gt; database='DATABASENAME'
&gt;&gt;&gt; con_string='DSN=%s;UID=%s;PWD=%s;DATABASE=%s;' % (dsn, user, password, database)
&gt;&gt;&gt; cnxn = pyodbc.connect(con_string)
&gt;&gt;&gt; cursor = cnxn.cursor()
&gt;&gt;&gt; cursor.execute("select count(*) from TABLENAME")
&lt;pyodbc.Cursor object at 0x7fe4fd2a0b10&gt;
&gt;&gt;&gt; row=cursor.fetchone()
&gt;&gt;&gt; row
(249619, )
Step 7 : Read up on ODBC databases in Python
For more, see the PyODBC getting started guide.
^
</Template><Template Name="tmp_MSSQL_Null" Description="Selecting for NULL">Selecting for null: (Null is not the same thing as empty).
	select * from test3 where (not [t2] is not null);
	select * from test3 where ([t2] is null);
^
</Template><Template Name="tmp_MSSQL_StoredProcedures" Description="Stored procedures">-- https://database.guide/3-ways-to-list-all-stored-procedures-in-a-sql-server-database/
Here is what each type means.
  P = SQL Stored Procedure
  X = Extended stored procedure
  RF = Replication-filter-procedure
  PC = Assembly (CLR) stored-procedure

Sql Queries for getting the  list of tables and Stored Procedure.
  For Tables:
  	SELECT TABLE_NAME  FROM INFORMATION_SCHEMA.TABLES

  For Stored Procedure:
  	Select [NAME] from sysobjects where type = 'P' and category = 0
  	Select [NAME] from sysobjects where type in ('P','X','RF','PC') and category = 0

  For Views:
  	Select [NAME] from sysobjects where type = 'V' and category = 0

-- Show store procedure name and schema 1:
  SELECT
    ROUTINE_SCHEMA,
    ROUTINE_NAME
  FROM INFORMATION_SCHEMA.ROUTINES
  WHERE ROUTINE_TYPE = 'PROCEDURE'
  order by routine_name;

-- Create a stored procedure that shows the stored procedures:
  create procedure show_storedprocedures as
  SELECT 
    ROUTINE_SCHEMA,
    ROUTINE_NAME
  FROM INFORMATION_SCHEMA.ROUTINES
  WHERE ROUTINE_TYPE = 'PROCEDURE'
  order by routine_name;

-- Run the stored procedure named show_storedprocedures:
  exec show_storedprocedures;

-- Show store procedure name and schema 2:
  SELECT
    SCHEMA_NAME(schema_id) AS [Schema],
    name
  FROM sys.objects
  WHERE type = 'P'
  order by name;

-- Show the stored procedure definition:
  create procedure show_storedprocedure_definition as
  SELECT definition
  FROM sys.objects o
  INNER JOIN sys.sql_modules m
  ON o.object_id = m.object_id
  WHERE type = 'P'
  order by definition;

  exec show_storedprocedure_definition;

-- Get the definition of a view:
https://docs.microsoft.com/en-us/sql/relational-databases/views/get-information-about-a-view?view=sql-server-ver15
  SELECT definition, uses_ansi_nulls, uses_quoted_identifier, is_schema_bound  
  FROM sys.sql_modules  
  WHERE object_id = OBJECT_ID('TheNameOfTheView');

  -- Can also use: 
    exec sp_helptext TheNameOfTheView
^</Template><Template Name="tmp_MSSQL_top" Description="Select top number of rows from a table.">-- Show top number of rows.
	select top (100) * from TheTableName;
	select top (100) [column1], [column2] from TheTableName;
</Template><Template Name="tmp_MySQL_FieldType_to_JSON" Description="How to convert mysql table field type from blob to json">https://www.tutorialspoint.com/how-to-convert-mysql-table-field-type-from-blob-to-json

Steps to convert a MySQL table field type from BLOB to JSON
**Data format ? The data in the BLOB field must be in a format that can be parsed as JSON, otherwise the conversion process will fail. It's important to check and validate the data in the BLOB field to ensure it is in the correct format before attempting the conversion.

  Create a new column with the desired data type ?

  ALTER TABLE mytable ADD new_column JSON;
  Copy the data from the old column to the new column ?

  UPDATE mytable SET new_column = CAST(old_column AS JSON);
  Drop the old column ?

  ALTER TABLE mytable DROP COLUMN old_column;
  Rename the new column to the original column name ?

  ALTER TABLE mytable CHANGE new_column old_column JSON;


Example 1
Converting a BLOB field named "data" to a JSON field named "json_data" in a table named "mytable" ?

  SQL Query
  ALTER TABLE mytable ADD json_data JSON;
  UPDATE mytable SET json_data = CAST(data AS JSON);
  ALTER TABLE mytable DROP COLUMN data;
  ALTER TABLE mytable CHANGE json_data data JSON;

Example 2
Converting a BLOB field named "blob_col" to a JSON field named "json_col" in a table named "example_table" and also rename the column name.

  SQL Query
  ALTER TABLE example_table ADD json_col JSON;
  UPDATE example_table SET json_col = CAST(blob_col AS JSON);
  ALTER TABLE example_table DROP COLUMN blob_col;
  ALTER TABLE example_table CHANGE json_col json_col JSON;

Example 3
Converting a BLOB field named "data" to a JSON field named "json_data" in a table named "mytable" and creating a temp table.

  SQL Query
  CREATE TEMPORARY TABLE temp_mytable AS SELECT * FROM mytable;
  ALTER TABLE temp_mytable ADD json_data JSON;
  UPDATE temp_mytable SET json_data = CAST(data AS JSON);
  ALTER TABLE temp_mytable DROP COLUMN data;
  ALTER TABLE temp_mytable CHANGE json_data data JSON;
  RENAME TABLE mytable TO mytable_old, temp_mytable TO mytable;
^</Template><Template Name="tmp_MySQLDBBasicTable" Description="Basic MySQL Table with timestamp columns.">create table display_test (id int unsigned auto_increment primary key,
column1 varchar(100) not null,
column2 varchar(100) not null,
dt_tm datetime default now(),
updt_dt_tm datetime not null default current_timestamp on update current_timestamp,
active_ind int not null default 1
)engine=innodb;
^</Template><Template Name="tmp_MySQLDBPasswordChange" Description="Change MySQL password for user.">/*
-- Change user password.
-- Find current user: SELECT CURRENT_USER();
//Database Username: [+dbusername+]
//Database Password: [+dbpassword+]
//----------------------------------------------------------------------------
*/

use mysql;
-- Method 1 (Deprecated):
update mysql.user set password('[+dbpassword+]') where user = '[+dbusername+]';
FLUSH PRIVILEGES;

-- Method 2 (MySQL 5.7+):
update mysql.user set authentication_string=PASSWORD('[+dbpassword+]') where user='[+dbusername+]';
FLUSH PRIVILEGES;

-- Method 3 (Preferred method for current user.):
alter user set password = '[+dbpassword+]';
FLUSH PRIVILEGES;

-- MySQL 5.7:
alter user '[+dbusername+]'@'localhost' identified by '[+dbpassword+]';
alter user '[+dbusername+]'@'%' identified by '[+dbpassword+]';

-- Method 4 (Preferred method for another user.):
alter user set password for '[+dbusername+]'@'localhost' = '[+dbpassword+]';
FLUSH PRIVILEGES;

-- Remote user password change:
alter user set password for '[+dbusername+]'@'%' = '[+dbpassword+]';
FLUSH PRIVILEGES;

-- ALTER USER EXAMPLES ==
ERROR 1820 (HY000): You must reset your password using ALTER USER statement before executing this statement.

-- This worked for me from the MySQL DB prompt:
	SET PASSWORD = PASSWORD('[+dbpassword+]');
-- Source: http://stackoverflow.com/questions/33467337/reset-mysql-root-password-using-alter-user-statement-after-install-on-mac

-- This syntax enables changing your own password without naming your account literally.
	ALTER USER USER() IDENTIFIED BY '[+dbusername+]';

-- This statement changes the password for [+dbusername+] but leaves that for someother[+dbusername+] unchanged. 
-- For both accounts, connections are required to use SSL and each account can be used for a maximum of two simultaneous connections:
	ALTER USER
  	'[+dbusername+]'@'localhost' IDENTIFIED BY '[+dbpassword+]',
  	'someother[+dbusername+]'@'localhost'
  	REQUIRE SSL WITH MAX_USER_CONNECTIONS 2;

-- Example 1: Change an account's password and expire it. As a result, the user must connect with the named password and choose a new one at the next connection:
	ALTER USER '[+dbusername+]'@'localhost'
  	IDENTIFIED BY '[+dbpassword+]' PASSWORD EXPIRE;

-- Example 2: Modify an account to use the sha256_password authentication plugin and the given password. Require that a new password be chosen every 180 days:
	ALTER USER '[+dbusername+]'@'localhost'
  	IDENTIFIED WITH sha256_password BY '[+dbpassword+]'  (SHA256 may require an SSL connection on some systems)
  	PASSWORD EXPIRE INTERVAL 180 DAY;

-- Example 3: Lock or unlock an account:
	ALTER USER '[+dbusername+]'@'localhost' ACCOUNT LOCK;
		ALTER USER '[+dbusername+]'@'localhost' ACCOUNT UNLOCK;

-- Example 4: Require an account to connect using SSL and establish a limit of 20 connections per hour:
	ALTER USER '[+dbusername+]'@'localhost'
  	REQUIRE SSL WITH MAX_CONNECTIONS_PER_HOUR 20;
-- http://dev.mysql.com/doc/refman/5.7/en/alter-user.html
</Template><Template Name="tmp_MySQLDBUser" Description="Create MySQL DB user and password.">/*
-- Create local user.
//Database Username: [+dbusername+]
//Database Password: [+dbpassword+]
//----------------------------------------------------------------------------
*/

-- Create local user.
CREATE USER '[+dbusername+]'@'localhost' IDENTIFIED BY '[+dbpassword+]';
-- Create remote user.
CREATE USER '[+dbusername+]'@'%' IDENTIFIED BY '[+dbpassword+]';
-- Tell the server to reload the GRANT TABLES.
FLUSH PRIVILEGES;
</Template><Template Name="tmp_MySQLDBUserandDatabase" Description="Create MySQL DB user and database.">/*
-- Create user and database with the same name.
//Database Username: [+dbusername+]
//Database Password: [+dbpassword+]
//----------------------------------------------------------------------------
*/

CREATE DATABASE [+dbusername+];
-- Create local user.
CREATE USER '[+dbusername+]'@'localhost' IDENTIFIED BY '[+dbpassword+]';
GRANT ALL PRIVILEGES ON [+dbusername+].* TO '[+dbusername+]'@'localhost' WITH GRANT OPTION;
-- Create remote user.
CREATE USER '[+dbusername+]'@'%' IDENTIFIED BY '[+dbpassword+]';
GRANT ALL PRIVILEGES ON [+dbusername+].* TO '[+dbusername+]'@'%' WITH GRANT OPTION;
-- Tell the server to reload the GRANT TABLES.
FLUSH PRIVILEGES;
</Template><Template Name="tmp_MySQLDBUserDBAccess" Description="Create MySQL DB user and grant access to existing DB.">/*
--Create user and grant access to database.
//Database Username: [+dbusername+]
//Database Password: [+dbpassword+]
//Database Name: [+dbname+]
//----------------------------------------------------------------------------
*/

-- Create local user.
CREATE USER '[+dbusername+]'@'localhost' IDENTIFIED BY '[+dbpassword+]';
GRANT ALL PRIVILEGES ON [+dbname+].* TO '[+dbusername+]'@'localhost' WITH GRANT OPTION;
-- Create remote user.
CREATE USER '[+dbusername+]'@'%' IDENTIFIED BY '[+dbpassword+]';
GRANT ALL PRIVILEGES ON [+dbname+].* TO '[+dbusername+]'@'%' WITH GRANT OPTION;
-- Tell the server to reload the GRANT TABLES.
FLUSH PRIVILEGES;</Template><Template Name="tmp_MySQLFKReferences" Description="Display MySQL foreign key references.">-- To run from the command prompt type:
-- mysql -u rob -p &lt; display_foreign_key_references.sql &gt; current_fk_refs.txt

use information_schema;
select 
	concat(table_schema,'.',table_name,'.',column_name) as this_db_table_and_column,
	concat(table_schema,'.',referenced_table_name,'.',referenced_column_name) as references_this_db_table_and_column,
	constraint_name
from key_column_usage
where referenced_table_name is not null
order by this_db_table_and_column;

-- The order by clause may not work on all DB's. If there is an error remove it and run again.

-- Same query but this one shows the cascade rules.
use information_schema;
select
	concat(kcu.table_schema,'.',kcu.table_name,'.',kcu.column_name) as this_db_table_and_column,
	concat(kcu.table_schema,'.',kcu.referenced_table_name,'.',kcu.referenced_column_name) as references_this_db_table_and_column,
	kcu.constraint_name,
	rc.update_rule,
	rc.delete_rule
from
	key_column_usage kcu
join referential_constraints rc on (rc.constraint_name= kcu.constraint_name)
where kcu.referenced_table_name is not null order by this_db_table_and_column;

-- The order by clause may not work on all DB's. If there is an error remove it and run again.

-- On Tracy's Ubuntu MySQL server I got this error message: Unknown column 'kcu.TABLE_SCHEMA' in 'field list' because the alias in the from clause was in uppercase and lowercase in the select portion.

-- This is a quick way to view all of the contraints:
select * from information_schema.referential_constraints;

-- This is a quick way to view constraints from a specific database:
select * from information_schema.referential_constraints where constraint_schema = 'thedatabasename';
</Template><Template Name="tmp_notepad++" Description="Notepad++ Backup Directory">Settings-&gt;Preferences-&gt;Backup-&gt;Verbose Backup-&gt;Custom Backup Directory
I:\Winintel\Static_Content\custom_mpage_content\NPP_Backup</Template><Template Name="tmp_Oracle" Description="Oracle Client Download">Oracle Client Download 20230224:
Oracle Download Link from StackExchange(https://stackoverflow.com/questions/68935361/where-can-i-download-the-oracle-11g-client-installer-for-windows):
	https://edelivery.oracle.com/osdc/faces/SoftwareDelivery

https://stackoverflow.com/questions/39434052/unable-to-connect-sqlstate-08004-oracleodbcoraora-12154-tnscould-not-res

Where Is the TNSNAMES.ORA File Located?
The location of the TNSNAMES.ORA file is:

    $ORACLE_HOME\network\admin\

What Order Does Oracle Check These Locations In?
Because there are several locations for the TNSNAMES.ORA file, they are checked in a certain order:

    1. If TNS_ADMIN is set, then this location is checked first. If the file is not found in this directory, it is assumed the file does not exist. You may need to create one.
    2. In Windows, if the TNS_ADMIN environment variable is not set, then the registry is checked for the TNS_ADMIN parameter and checks that directory.
    3. If the TNS_ADMIN variable is not set, then the ORACLE_HOME\network\admin directory is checked.

Set TNSNames variable in Windows:
    Open System Properties-&gt;Environment Variables
    Look for ORACLE_HOME 
    or
    TNS_ADMIN
    or
    echo %ORACLE_HOME%
    or
    echo %TNS_ADMIN%

Locate TNSNames in the Windows Registry:
    HKEY_LOCAL_MACHINE\SOFTWARE\ORACLE

UNIX/LINUX
    env | grep ORACLE_HOME
    or
    echo $ORACLE_HOME

What Is The Syntax of the TNSNAMES.ORA File?
This file contains a series of entries, where each of them represents a connection string to the database.

An entry will look like this:

net_service_name =
  (DESCRIPTION=
    (ADDRESS = (PROTOCOL = TCP)(HOST = xxx.xxx.com)(PORT = 1521)
  )
  (CONNECT_DATA =
    (SERVICE_NAME=service_name)
  )
)
What does this mean?

    net_service_name: This is the name that you use for a connection string later. You can choose what this is. It&#x2019;s like a name you give to this set of connection details.
    host: The IP address or server name where the database lives or that you want to connect to.
    port: The port that is required for the connection. In most cases the default port of 1521 will be fine.
    service_name: This is the name of the database you want to connect to.
What about the SID? The SID parameter was used in older versions of Oracle in this file (Oracle 8 and earlier). The service_name parameter should be used instead.

tnsnames.ora Banner example:
#samtaz-p1805-scan.cernerasp.com
rhoprod.world =
(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 137.252.75.140)(PORT = 1521))
    (LOAD_BALANCE = no)
    (ENABLE = BROKEN)
    (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = cust_rpt_p1805.world)  )
)
https://www.databasestar.com/tnsnames-ora-file/
^
</Template><Template Name="tmp_permissions_icacls_cacls" Description="Grant permissions from the commandline using icacls.">Grant Permissions:
https://stackoverflow.com/questions/2928738/how-to-grant-permission-to-users-for-a-directory-using-command-line-in-windows
The /T is needed to update the permissions of existing files and folders. The (OI) and (CI) only applies to files and folders created in the future.

If you run this in Powershell in Windows 10, you will get the error about "OI not recognized". Solution: Put the user+perms argument in quotes. For example: C:\&gt;icacls "D:\test" /grant "John:(OI)(CI)F" /T

Example: icacls "UpdateLogs" /grant "bhs\rlholland:(OI)(CI)F" /T
 icacls "[+Folder or Filename+]" /grant "bhs\[+Username+]:(OI)(CI)F" /T

More Examples:
 To grant the Users group Full Control to a folder:
  icacls "C:\MyFolder" /grant "Users:(OI)(CI)F" /T

 To grant Modify permission to IIS users for C:\MyFolder (if you need your IIS has ability to R/W files into specific folder):
  icacls "C:\MyFolder" /grant IIS_IUSRS:M

  icacls "c:\somelocation\of\path" /q /c /t /grant Users:F
    F gives Full Access.
    /q /c /t applies the permissions to subfolders.
    Note: Sometimes "Run as Administrator" will help.

  For Windows 7 if you are locked-out of a folder by corrupted permission settings:
    icacls "c:\folder" /remove:d /grant:r Everyone:(OI)(CI)F /T  
  For Windows 10 the user/SID must be specified after the /remove:d option:
    icacls "c:\folder" /remove:d Everyone /grant:r Everyone:(OI)(CI)F /T


See also "cacls"

attrib +r +a +s +h &lt;folder name&gt; &lt;file name&gt; to hide
attrib -r -a -s -h &lt;folder name&gt; &lt;file name&gt; to unhide

^</Template><Template Name="tmp_pgp_commands" Description="PGP Commands">gpg --edit-key 5DD98B3E
pgp ascii textfile (gpg -a -e thefilename)
pgp clearsign textfile (gpg --clearsign thefilename)
pgp decrypt outputfile.tar encryptedfile.tar.gpg (gpg -o outputfile -d encryptedfile)
pgp delete-keys 5DD98B3E (gpg --delete-keys keyname)
pgp detachedsig filename (gpg --output doc.sig --detach-sig doc.txt)
pgp encrypt filename (gpg --encrypt thefilename)
pgp exportpublic keyname (gpg --export --armor thekeyname)
pgp exportprivate keyname (gpg --export-secret-keys --armor ABCD1234 &gt;&gt; ABCD1234.asc)
pgp fingerprint 5DD98B3E (gpg --fingerprint key)
pgp fingerprint_from_file file_with_key (gpg --with-fingerprint thefilename)
pgp import filename.asc (gpg --import keyfile / gpg2 --import keyfile)
pgp list (gpg --list-keys)
pgp listdirs (gpgconf --list-dirs)
pgp message
pgp passencrypt textfile (gpg -c -s thefilename)
pgp receivekeys theservername thekeyname (gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 6EE89C2D)
pgp releasecache (gpgconf --kill gpg-agent;gpgconf --launch gpg-agent)
pgp revoke_key (gpg --gen-revoke thekeyname &gt; revoke.thekeyname.asc)
pgp sendkeys theservername thekeyname (gpg --keyserver hkps://pgp.mit.edu --send-keys 6EE89C2D)
pgp showphoto 6EE89C2D (gpg --list-options show-photos --fingerprint 6EE89C2D)
pgp sign textfile (gpg --sign thefilename)
pgp update (gpg --update-trustdb)
pgp uue filename (uuencode thefilename thefilename &gt; thefilename.uue;gpg -a -e thefilename.uue)
pgp uuedecrypt filename (gpg --decrypt thefilename &gt; thefilename.uue;uudecode thefilename.uue)
pgp uuegpg filename (uuencode thefilename thefilename &gt; thefilename.uue;gpg --encrypt thefilename.uue)
pgp verify filename (gpg --verify signaturefile)
^</Template><Template Name="tmp_pgp_gpgconf" Description="PGP gpg.conf"># These first three lines are not copied to the gpg.conf file in
# the users home directory.
# $Id$
# Options for GnuPG
# Copyright 1998, 1999, 2000, 2001, 2002, 2003,
#           2010 Free Software Foundation, Inc.
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This file is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# Unless you specify which option file to use (with the command line
# option "--options filename"), GnuPG uses the file ~/.gnupg/gpg.conf
# by default.
#
# An options file can contain any long options which are available in
# GnuPG. If the first non white space character of a line is a '#',
# this line is ignored.  Empty lines are also ignored.
#
# See the man page for a list of options.

# Uncomment the following option to get rid of the copyright notice

#no-greeting

# If you have more than 1 secret key in your keyring, you may want to
# uncomment the following option and set your preferred keyid.

#default-key 621CC013
default-key F9A65972
encrypt-to F9A65972


# If you do not pass a recipient to gpg, it will ask for one.  Using
# this option you can encrypt to a default key.  Key validation will
# not be done in this case.  The second form uses the default key as
# default recipient.

#default-recipient some-user-id
#default-recipient-self
#default-recipient F9A65972

# By default GnuPG creates version 4 signatures for data files as
# specified by OpenPGP.  Some earlier (PGP 6, PGP 7) versions of PGP
# require the older version 3 signatures.  Setting this option forces
# GnuPG to create version 3 signatures.

#force-v3-sigs

# Because some mailers change lines starting with "From " to "&gt;From "
# it is good to handle such lines in a special way when creating
# cleartext signatures; all other PGP versions do it this way too.
# To enable full OpenPGP compliance you may want to use this option.

no-escape-from-lines

# When verifying a signature made from a subkey, ensure that the cross
# certification "back signature" on the subkey is present and valid.
# This protects against a subtle attack against subkeys that can sign.
# Defaults to --no-require-cross-certification.  However for new
# installations it should be enabled.

require-cross-certification


# If you do not use the Latin-1 (ISO-8859-1) charset, you should tell
# GnuPG which is the native character set.  Please check the man page
# for supported character sets.  This character set is only used for
# metadata and not for the actual message which does not undergo any
# translation.  Note that future version of GnuPG will change to UTF-8
# as default character set.

#charset utf-8

# Group names may be defined like this:
#   group mynames = paige 0x12345678 joe patti
#
# Any time "mynames" is a recipient (-r or --recipient), it will be
# expanded to the names "paige", "joe", and "patti", and the key ID
# "0x12345678".  Note there is only one level of expansion - you
# cannot make an group that points to another group.  Note also that
# if there are spaces in the recipient name, this will appear as two
# recipients.  In these cases it is better to use the key ID.

#group mynames = paige 0x12345678 joe patti
group brothers = BB4054DAC61AB7BB D1BD917D4AF9F0EC

#no-mangle-dos-filenames

# Lock the file only once for the lifetime of a process.  If you do
# not define this, the lock will be obtained and released every time
# it is needed - normally this is not needed.

#lock-once

# GnuPG can send and receive keys to and from a keyserver.  These
# servers can be HKP, email, or LDAP (if GnuPG is built with LDAP
# support).
#
# Example HKP keyservers:
#      hkp://keys.gnupg.net
#
# Example LDAP keyservers:
#      ldap://pgp.surfnet.nl:11370
#
# Regular URL syntax applies, and you can set an alternate port
# through the usual method:
#      hkp://keyserver.example.net:22742
#
# If you have problems connecting to a HKP server through a buggy http
# proxy, you can use keyserver option broken-http-proxy (see below),
# but first you should make sure that you have read the man page
# regarding proxies (keyserver option honor-http-proxy)
#
# Most users just set the name and type of their preferred keyserver.
# Note that most servers (with the notable exception of
# ldap://keyserver.pgp.com) synchronize changes with each other.  Note
# also that a single server name may actually point to multiple
# servers via DNS round-robin.  hkp://keys.gnupg.net is an example of
# such a "server", which spreads the load over a number of physical
# servers.  To see the IP address of the server actually used, you may use
# the "--keyserver-options debug".

keyserver hkp://pgp.mit.edu
#keyserver hkps://hkps.pool.sks-keyservers.net
#keyserver http://http-keys.gnupg.net
#keyserver mailto:pgp-public-keys@keys.nl.pgp.net

# Common options for keyserver functions:
#
# include-disabled = when searching, include keys marked as "disabled"
#                    on the keyserver (not all keyservers support this).
#
# no-include-revoked = when searching, do not include keys marked as
#                      "revoked" on the keyserver.
#
# verbose = show more information as the keys are fetched.
#           Can be used more than once to increase the amount
#           of information shown.
#
# use-temp-files = use temporary files instead of a pipe to talk to the
#                  keyserver.  Some platforms (Win32 for one) always
#                  have this on.
#
# keep-temp-files = do not delete temporary files after using them
#                   (really only useful for debugging)
#
# honor-http-proxy = if the keyserver uses HTTP, honor the http_proxy
#                    environment variable
#
# broken-http-proxy = try to work around a buggy HTTP proxy
#
# auto-key-retrieve = automatically fetch keys as needed from the keyserver
#                     when verifying signatures or when importing keys that
#                     have been revoked by a revocation key that is not
#                     present on the keyring.
#
# no-include-attributes = do not include attribute IDs (aka "photo IDs")
#                         when sending keys to the keyserver.

keyserver-options auto-key-retrieve

# Uncomment this line to display photo user IDs in key listings and
# when a signature from a key with a photo is verified.

#show-photos

# Use this program to display photo user IDs
#
# %i is expanded to a temporary file that contains the photo.
# %I is the same as %i, but the file isn't deleted afterwards by GnuPG.
# %k is expanded to the key ID of the key.
# %K is expanded to the long OpenPGP key ID of the key.
# %t is expanded to the extension of the image (e.g. "jpg").
# %T is expanded to the MIME type of the image (e.g. "image/jpeg").
# %f is expanded to the fingerprint of the key.
# %% is %, of course.
#
# If %i or %I are not present, then the photo is supplied to the
# viewer on standard input.  If your platform supports it, standard
# input is the best way to do this as it avoids the time and effort in
# generating and then cleaning up a secure temp file.
#
# The default program is "xloadimage -fork -quiet -title 'KeyID 0x%k' stdin"
# On Mac OS X and Windows, the default is to use your regular JPEG image
# viewer.
#
# Some other viewers:
# photo-viewer "qiv %i"
# photo-viewer "ee %i"
# photo-viewer "display -title 'KeyID 0x%k'"
#
# This one saves a copy of the photo ID in your home directory:
# photo-viewer "cat &gt; ~/photoid-for-key-%k.%t"
#
# Use your MIME handler to view photos:
# photo-viewer "metamail -q -d -b -c %T -s 'KeyID 0x%k' -f GnuPG"

#  *** Options for GPGTools ***

# Automatic key location
#
# GnuPG can automatically locate and retrieve keys as needed using the
# auto-key-locate option.  This happens when encrypting to an email
# address (in the "user@example.com" form), and there are no
# user@example.com keys on the local keyring.  This option takes the
# following arguments, in the order they are to be tried:
#
# cert = locate a key using DNS CERT, as specified in RFC-4398.
#        GnuPG can handle both the PGP (key) and IPGP (URL + fingerprint)
#        CERT methods.
#
# pka = locate a key using DNS PKA.
#
# ldap = locate a key using the PGP Universal method of checking
#        "ldap://keys.(thedomain)".  For example, encrypting to
#        user@example.com will check ldap://keys.example.com.
#
# keyserver = locate a key using whatever keyserver is defined using
#             the keyserver option.
#
# You may also list arbitrary keyservers here by URL.
#
# Try CERT, then PKA, then LDAP, then hkp://keys.gnupg.net:
auto-key-locate keyserver

comment An encrypted message received, deserves an encrypted reply!
cert-digest-algo SHA512
default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed
personal-digest-preferences SHA512 SHA384 SHA256 SHA224

no-emit-version

cipher-algo AES256
digest-algo SHA512

#pinentry-program /usr/bin/pinentry-curses
^
</Template><Template Name="tmp_pgp_pubbanner" Description="My Banner PGP pubic key">-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBFg/KoYBEACmsZf5+nEeGrVRPWGpfmGOh1gh/wi6tLJZ4v/4bmD58gQLk9C5
kgdv9tOPofKqaFQy1Oq1Y4ouw9xQAdQkZLeUL+VIfPARjp5KReJAK2wM5n25qN9c
/0pmxpWL4RgrCHXUAi2zjE7naQbXJCNIxQCojjBo1ngz6hy3eyNlxx8q3j4FUmMn
DxEVRfrVm7/wtGMRySSvpPHtSzXroQjbBJ08KnTicVkGvNERkh8gk1xpYctyvy3W
cOImph6akiyZINHuhVBm7m20enY20GYHNzM4bv7WtHI74NyS7nr1gm2t6Aj3PObv
QJ63qN5opBshHcIlbxnCx9THgi8x4Un46EpPtWwpwcy2V01LZsn93ub/n8UNCHWh
QSTQRj5ssAoXjDzFL/1NE627i2Jj4XGy1LNE53xaqC3z76wgTL274XEPhSaJs1kc
AkEbiEsjBAV0hfS1/go6xtnVQ57zwndXGewpeLQI+I+ClsR3SwLTFWtc0LF/u9hY
hbxhgidTqQayqgDzjd0O6TUDnTvLlSUhO2vzMIfEiPaa8vIg3NhjSeb7MDiH9uRR
kJhYdAakj4c2EAs/+aYQkv+YxcBJ2JBkrKZLJtuUQPhhkYA/RgCFhNIZux4G/RFR
RQKcGdcEqsUaaCVMIGkjgXSssKHb1dMWT3dcFpAP2VEDrIujOE19XsoGIwARAQAB
tG9Sb2JlcnQgSG9sbGFuZCAoQW4gZW5jcnlwdGVkIG1lc3NhZ2UgcmVjZWl2ZWQs
IGRlc2VydmVzIGFuZCBlbmNyeXB0ZWQgcmVwbHkhKSA8cm9iZXJ0LmhvbGxhbmRA
YmFubmVyaGVhbHRoLmNvbT6JAjgEEwECACIFAlg/KoYCGwMGCwkIBwMCBhUIAgkK
CwQWAgMBAh4BAheAAAoJELLtcCvoqpStJ3EP/0ktopiA9QXFXSXOesugqxGb5eLV
W0RZp/sApf0h4MqNosgZpWkBPvyV2ooXh9SIf/vuksuboYPbuqs37Puz8PmXdclY
KcSOzPutKTykAdtTL18I/0gTAMu3cnVZwLfv2AvD5GWQcX1Bl0MS9dIqDmmjjaOL
TN8yNS0NR6CEkmcwx1UaabcSPf10JaVFyTQa2KCBpWjbYSUCJJ5HnD+DLqYApwPH
d2GhlP5mxaqfLf1Q1Pd7iE5s95oo7J+mcCeg056yx36zw6eDmRGf6vw7s/KaWVvo
qsRKX7ID3DFy3IC1osdXyyBrOMqCmfQGqH4S+tiTM0+2wofd4d8B0WTGa7XX9MJF
VllvksFlUElOxYOEaB3bpyOLqByoInf84dbJCR5bK/aVzeEpfKfPNii2UYvSF6Xi
jO2n2eFbqmZCHBxdV3DKue+rKzwU8YCqD6ZGigHhScwa/QDHS9ynTACjep+7UDnc
D9fFAl89I8V/ZHgiuZGFk/dJS24eh3CJhkT89l1xg8mD0mZkSXrk2L42o2m3JbX7
aZvicx8s2PsoM4iv8R8uJQyN+Eto3n0pu6uIxSUTUbtHAGNKLgdxUxSutA4l0d3P
1MNAOg0hQaJdTruQzU8Zoqx43CXObKodvReJEcBlI67HAQfqF4S0DOO/OzY1y32X
paiJes+AnsbT9G2OuQINBFg/KoYBEADgW6Mu1BIX72Vz4g80TFz3wJWgEvQ/9K18
2xAQuZizD9Hejl0OGBmC1Wz8N9dkFr1v4Q+KBOOvCo9MFVAIuD47+uKkvl1iK6Tm
do46JaD9Kcp9vwMF31juL8KknqlMBBVlvkNw1gbo9Gu9aTWXc0Dyml/2+qWKxKkj
pGPn5hCdrwf2mxmj/RxcEhfeA+j3XM+lFyLkkRrSlU4Cp2iAuD5YeXhxc5mxS94I
fPxoO7fLCdoRmyLWiXNtjQCtjnVbRday63oAnjN1dqmEew8AO+Pqk+lDQ922Ktid
zthviJf4IZB5MnKaNkJgE7QkvxxIEM+lA5np6qsgyTuxdHYDVTouCUgUrdI19AsO
nSzDc3lGAVsNQGQaMu8+D2R8QV8iyKgks+qI0/rrZb2q0oU1BvwFWRTpqWK6X+Dd
1708/hzPUFi/3oMPeisX37jd281Bbnd0NbVZjuIm2EjdeaWA8Gv3/V9Sbwx2WFOu
ejbqQ3mEYO/GxIWLC/LCxk0lINdSEjikWoPaBr7Y+PyCCzhDd/O7Hvw9cpPr98q6
8e4jwnxOMirYw+0t0ZZwdIuHrL1OkjJlr2Rl+3+BCmuX1QPzHtqOFFCXDzLh8Ekm
PAuVH8NG+tAq2tHnISLrMLIqNMJ7eB1383q7N/PG10orj7K4HdYtWkAEojKHGLSj
Df7wNwq8gwARAQABiQIfBBgBAgAJBQJYPyqGAhsMAAoJELLtcCvoqpStT3EP/jr0
bJw286KUwsQT4eOYx6GI9hbxuw+S/NgsGlu/PmYl4MF6voHVDoi8MpzFHRyfsRsI
RTJXbXXsiOCHejlMXgaP3tOZr3LiVlV1jrZM7IOClmyA52d8yyzx+a/SenCbCW7D
y9MdBIJXt07mpFuiOM9iKXg6xOUvwEWCMJaT9+HQQ19KKxUsXlmsV2XYperAyvar
rqNkK8cf/tM4ZD7ZRM0RaqItRV/d1DERlMXilqGLxL1Z/XmyNgj2w6bZqs+BvMPu
HqyeK3l/mhlcdkjO/mSctjPBPNawfdhbhJp34Q23cSR3UrhwFwS2Cifz1JFoQsPg
DmBYt3LDIGx6qN8mW76VM0N/XDLnaVPob1V4PZJtlLOornBBNvDYr9Vn6UhJJlvo
4inZcyMUi56BIDdFhm85Z7hNhhpGOfu+GmCmobyHwR+b9do7FIuddSZQeS4f1zr7
Fg8f6Pq7Y4f7+pauRR9vgrSWLTGZ7aoG0RQGB6BIEiMHwmEIKLFEnlddrQobf4hU
v46eKQtsV0MB7gmWnCThdyObqz76BTNiN+atSaOic+UYUXhTV+vej7rZBMc/Bu+2
74T+B1YSyf3C98h9Gi7+QIrCu6CK2BYdhSh60ZFcjt1iEBpQ326GKuhhf0t6ydNz
lHjggfNQaNwOB5431W7C3XHmUm0A5RNJN00lTjsN
=KdSB
-----END PGP PUBLIC KEY BLOCK-----</Template><Template Name="tmp_pgp_pubrobholland" Description="My PGP Public Key">-----BEGIN PGP PUBLIC KEY BLOCK-----
Comment: An encrypted message received, deserves an encrypted reply!

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
JDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hp
anN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TF
xsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+v/EAB8BAAMBAQEBAQEB
AQEAAAAAAAABAgMEBQYHCAkKC//EALURAAIBAgQEAwQHBQQEAAECdwABAgMRBAUh
MQYSQVEHYXETIjKBCBRCkaGxwQkjM1LwFWJy0QoWJDThJfEXGBkaJicoKSo1Njc4
OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoKDhIWGh4iJipKTlJWW
l5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uLj5OXm5+jp
6vLz9PX29/j5+v/aAAwDAQACEQMRAD8A9CFSAUwD8qkFZljgKeKatPFMBRTqr3l7
bafaSXV3MsMMYyzt/nk+1eX+I/Hup6s5h04y2Np0KrgSScggk/w9Bwp7kEkdC9gS
uelXevaPYO8d1qdrFJH9+NpRvHGfu5z0/nS2eu6RqEkcVpqVrNLL9yJZRvbjJwvX
pz0rwyGyYoCqcjtin/Y2xhk3AD0rN1Eaqk2fQApcV5PonjHV9IcLNJJe2xILRzsS
yj/ZY8/gePT1r0rRtastcsxc2cmQDh0PDIfQiqjNMiUHHcvUuKXrRirIG45pMU7F
GOKQDCKKUiigZQFPFMWnikA9fpTyVVSzEBQMkk8CmCsDx3qR07wvOql1ku2FuhVQ
RzksDnsVDD8aYHE+KvELeINQZIpWOnQN+4QDaHOMFyPU84z0HYEnOZbwI3VPbkVT
hByBzWrYpk/41yVJNndSikXba1U7W4IB9KkubOPA2jH0WrNojKQM/j3FNnUqeDnn
0rnaR0J6mJMio2MArU2manLoWpJfWjMB0lQciRfQj+VNu4mLkgZwaoynjBzx1rSD
6GdRJ6nuGn30OpWcdzA2VcevQ1ZxXn3w11JlabT2LFeo9BnJ/o35ivQ/xrtpy5lq
ebOPKxuMdqQinYzzRitCRhGKKUiikMzRTxTFp4qBkgrk/iSN2hWi8c3q8f8AAHrq
wPbiuU8dazaQWLaTJBI9zMgljbaNqDJyc9c4BH403sOKuzzlGWJz8u5j0UVat9WS
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
=nJUF
-----END PGP PUBLIC KEY BLOCK-----
^</Template><Template Name="tmp_phpMSSQLPDOconnect" Description="MSSQL PDO Connect">&lt;?php
/*
*Program Author: [+Author+]
*Program Name: [+Program+]
*Creation Date: [DATE_TEXT] [TIME]
*Last Modified:  
*Copyright (c)[DATE_USER]yyyy[DATE_USER_END]
*Purpose: 
*Request #: 
*/

$serverName = "MSSQL_ServerFQDN";

try {
	$handler = new PDO("sqlsrv:server=$serverName; Database=[+databasename+]", "[+username+]", "[+password+]");
	$handler-&gt;setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); //Setting the attributes for the handler that we want to see if exception error.
}

catch(PDOException $e) { //Return the PDO exception and naming it $e.
//	echo 'Caught';
//	die('Sorry database problem.'); //Production message.
	echo $e-&gt;getMessage(); //Show specific error message. Development.
}

$query0 = $handler-&gt;query('select * from tablename');
//ONE: Output each column as row of data.
//	while($r = $query0-&gt;fetch()) {
//		echo $r[1]
//		, ' ', $r[2]
//		, ' ', $r[3]
//		, ' ', $r[4]
//		, ' ', $r[5]
//		, ' ', $r[6]
//		, ' ', $r[7]
//		, ' ', $r[8]
//		, ' ', $r[9]
//		, ' ', $r[10]
//		, ' ', $r[11]
//		, ' ', $r[12]
//		, ' ', $r[13]
//		, ' ', $r[14]
//		, ' ', $r[15]
//		, ' ', $r[16]
//		, ' ', $r[17]
//		, ' ', $r[18]
//		, ' ', $r[19]
//		, ' ', $r[20]
//		, ' ', $r[21]
//		, '\r\n';
//	}

//TWO: Prints one array.
//	$r = $query0-&gt;fetch(PDO::FETCH_ASSOC); //Will fetch the associative array only.
//	echo '&lt;pre&gt;', print_r($r), '&lt;/pre&gt;';

//THREE: Column 1 followed by dashes.
//	foreach($query0 as $r){
//		echo $r[0] . "-----";
//
//	}

//FOUR: Key value.
//	foreach($query0 as $key =&gt; $value){
//		$out = array_values($value);
//		echo json_encode($out);
//}

//FIVE: Proper JSON.
	$r = $query0-&gt;fetchAll(PDO::FETCH_ASSOC);
	//echo '&lt;pre&gt;', print_r($r), '&lt;/pre&gt;';
	echo json_encode($r);
?&gt; </Template><Template Name="tmp_phpMSSQLsqlsrv_connect" Description="MSSQL sqlsrv_connect">&lt;?php
//AZURE Connection and regular MS database connection.

//$FQDN_DB = "tcp:robertholland.database.windows.net,1433";
//$database = "RobertHolland";
//$username = "robertholland";
//$password = "";
//
//// SQL Server Extension Sample Code:
//$connectionInfo = array("UID" =&gt; $username, "pwd" =&gt; $password, "Database" =&gt; $database, "LoginTimeout" =&gt; 30, "Encrypt" =&gt; 1, "TrustServerCertificate" =&gt; 0);
//$serverName = $FQDN_DB;
//$conn = sqlsrv_connect($serverName, $connectionInfo);
////Everything above works.
//
//if ($conn){
//    //echo "connected";
//    if(($result = sqlsrv_query($conn,"SELECT * FROM test")) !== false){
//        while( $obj = sqlsrv_fetch_object( $result )) {
//              //Example: echo $obj-&gt;colName.'&lt;br /&gt;';
//              //Example: echo $x=json_encode($obj);
//              echo $obj-&gt;lastname . ", " . $obj-&gt;firstname . " : ";
//        }
//    }
//}else{
//    die(print_r(sqlsrv_errors(), true));
//}
?&gt;

&lt;?php
//$FQDN_DB = "tcp:phx04134.bhs.bannerhealth.com,1433";
$FQDN_DB = "tcp:phx07555.bhs.bannerhealth.com,1433";
$database = "[+Canned_mPage+]";
$username = "[+db_username+]";
$password = "[+db_userpassword+]";

// SQL Server Extension Sample Code:
$connectionInfo = array("UID" =&gt; $username, "pwd" =&gt; $password, "Database" =&gt; $database, "LoginTimeout" =&gt; 30, "Encrypt" =&gt; 1, "TrustServerCertificate" =&gt; 1);
$serverName = $FQDN_DB;
$conn = sqlsrv_connect($serverName, $connectionInfo);

////Method 1:
//if ($conn){
//    //echo "connected";
//    if(($result = sqlsrv_query($conn,"SELECT * FROM test")) !== false){
//        while( $obj = sqlsrv_fetch_object( $result )) {
//          //Example: echo $obj-&gt;colName.'&lt;br /&gt;';
//          //Example: echo $x=json_encode($obj);
//              echo
//              	//Pad zero using "str_pad".
//                str_pad($obj-&gt;id,2,'0',STR_PAD_LEFT) . ": " .
//                $obj-&gt;data1 . ", " .
//                $obj-&gt;data2 . ", " .
//                //Convert date to string using "format('')"
//                $obj-&gt;some_dt_tm-&gt;format('Y-m-d H:i:s') . ", " .
//                $obj-&gt;the_dt_tm-&gt;format('Y-m-d H:i:s') . "\r\n";
//        }
//    }
//}else{
//    die(print_r(sqlsrv_errors(), true));
//}

////Method 2:
//if ($conn){
//    //echo "connected";
//    if(($result = sqlsrv_query($conn,"SELECT * FROM test")) !== false){
//			while( $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC) ) {
//    		echo $row['data1'].", ".$row['data2']."\r\n";
//			}
//		}
//else{
//    die(print_r(sqlsrv_errors(), true));
//	}
//}

//Method 3:
//if ($conn){
//    //echo "connected";
//    if(($result = sqlsrv_query($conn,"SELECT * FROM test")) !== false){
//			while( $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_BOTH) ) {
//    		echo $row[0].", ".
//    		$row['data1'].", ".
//    		$row[2].", ".
//    		$row['some_dt_tm']-&gt;format('Y-m-d H:i:s').", ".
//    		$row[4]-&gt;format('Y-m-d H:i:s')."\r\n";
//    		//echo json_encode($row);
//			}
//		}
//else{
//    die(print_r(sqlsrv_errors(), true));
//	}
//}

//Method 4:
if ($conn){
    //echo "connected";
    if(($result = sqlsrv_query($conn,"SELECT * FROM test")) !== false){
			while( $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_NUMERIC) ) {
    		echo $row[0].", ".
    		$row[1].", ".
    		$row[2].", ".
    		$row[3]-&gt;format('Y-m-d H:i:s').", ".
    		$row[4]-&gt;format('Y-m-d H:i:s')."\r\n";
    		//echo json_encode($row);
			}
		}
else{
    die(print_r(sqlsrv_errors(), true));
	}
}

////Method JSON:
//if ($conn){
//    //echo "connected";
//    if(($result = sqlsrv_query($conn,"SELECT * FROM test")) !== false){
//			while( $row = sqlsrv_fetch_array($result, SQLSRV_FETCH_ASSOC) ) {
//    		echo json_encode($row);
//			}
//		}
//else{
//    die(print_r(sqlsrv_errors(), true));
//	}
//}

?&gt;
^</Template><Template Name="tmp_phpMySQL_PDOClassConnect" Description="OOP PDO Class Connect">&lt;?php
//How to write prepare and execute statements in OOP PDO?
//https://stackoverflow.com/questions/42551050/how-to-write-prepare-and-execute-statements-in-oop-pdo

class Connection
{
private $host = "[+TheServerName+]";
private $dbName = "[+TheDatabaseName+]";
private $user = "[+TheUserName+]";
private $pass = "[+ThePassWord+]";
private $charset = 'utf8';

private $dbh;
private $error;
private $stmt;

//connection
public function __construct()
{
$dsn = "mysql:host=" . $this-&gt;host . ";dbname=" . $this-&gt;dbName . ";charset=" . $this-&gt;charset;
$options = array(
PDO::ATTR_ERRMODE =&gt; PDO::ERRMODE_EXCEPTION,
PDO::ATTR_DEFAULT_FETCH_MODE =&gt; PDO::FETCH_ASSOC,
PDO::ATTR_EMULATE_PREPARES =&gt; false
);

try {
// setup connection
$this-&gt;dbh = new PDO($dsn, $this-&gt;user, $this-&gt;pass, $options);
}
//catch any errors
catch (PDOException $e) {
$this-&gt;error = $e-&gt;getMessage();
}

}

//prepare statement
public function myQuery($query)
{
$this-&gt;stmt = $this-&gt;dbh-&gt;prepare($query);
}

//bind values
public function bind($param, $value, $type = null)
{
if (is_null($type)) {
switch (true) {
case is_int($value):
$type = PDO::PARAM_INT;
break;
case is_bool($value):
$type = PDO::PARAM_BOOL;
break;
case is_null($value):
$type = PDO::PARAM_NULL;
break;
default:
$type = PDO::PARAM_STR;
}
}
//actual value binding
$this-&gt;stmt-&gt;bindValue($param, $value, $type);
}
//execute statement
public function run()
{
return $this-&gt;stmt-&gt;execute();
}

//Return a single row of data.
public function SingleRow(){
$this-&gt;run();
return $this-&gt;stmt-&gt;fetch();
}

//Return multiple rows of data.
public function All(){
$this-&gt;run();
return $this-&gt;stmt-&gt;fetchall();
}

//Return last_InsertId.
public function lastInsertId(){
return $this-&gt;dbh-&gt;lastInsertId();
}

}

?&gt;^</Template><Template Name="tmp_phpMySQL_PDOClassCrud" Description="PHP Class CRUD">&lt;?php
//How to write prepare and execute statements in OOP PDO?
//https://stackoverflow.com/questions/42551050/how-to-write-prepare-and-execute-statements-in-oop-pdo
//https://stackoverflow.com/questions/18679448/pdo-class-is-this-technically-correct

include'[+connection.php+]';


$[+connection_object+] = new Connection(); //Instantiate a new connection.
//Insert user data.
//$[+connection_object+]-&gt;myQuery('INSERT INTO users (userid, first_name, last_name, gender) VALUES(:uid,:fname,:lname,:gender)');
//$[+connection_object+]-&gt;bind(':uid', 118); //bind each value
//$[+connection_object+]-&gt;bind(':fname', 'Happy'); // bind
//$[+connection_object+]-&gt;bind(':lname', 'Holland');
//$[+connection_object+]-&gt;bind(':gender', 1);
//Execute the query.
//if($[+connection_object+]-&gt;run()){
//
//echo "record inserted";
//$lastid = $[+connection_object+]-&gt;lastInsertId(); //Getting the last inserted ID
//echo "Last ID = " . $lastid . "\r\n";
//}

////Retrieve a single row of data from the database using the SingleRow method.
//$[+connection_object+]-&gt;myQuery("SELECT table_name, is_updatable FROM information_schema.views WHERE is_updatable = :is_updatable");
//$[+connection_object+]-&gt;bind(':is_updatable','YES');
//$row = $[+connection_object+]-&gt;SingleRow();

//echo '&lt;pre&gt;';
//print_r($row);
//echo '&lt;/pre&gt;';

////Works1:
//foreach($row as $key){
// echo "$key: "; //Values separated by carriage return.
//}

////Works2:
//foreach($row as $key){
// echo "$key,"; //Values separated by a comma.
//}

////Works3:
//foreach($row as $key =&gt; $value){
// echo "$key: $value ";
//}

////Retrieve multiple rows of data from the database using the All method.
//$[+connection_object+]-&gt;myQuery("show databases;");
//$[+connection_object+]-&gt;myQuery("SELECT table_name, is_updatable FROM information_schema.views WHERE is_updatable = :is_updatable");
//$[+connection_object+]-&gt;bind(':is_updatable','YES');
//$rows = $[+connection_object+]-&gt;All();

//echo '&lt;pre&gt;';
//print_r($rows);
//echo '&lt;/pre&gt;';

/*
&lt;pre&gt;Array
(
[0] =&gt; Array
(
[TABLE_NAME] =&gt; vw_customer_display_nodocs
[IS_UPDATABLE] =&gt; YES
)

[1] =&gt; Array
(
[TABLE_NAME] =&gt; vw_ffl_book1
[IS_UPDATABLE] =&gt; YES
)

[2] =&gt; Array
(
[TABLE_NAME] =&gt; vw_ffl_book2
[IS_UPDATABLE] =&gt; YES
)

[3] =&gt; Array
(
[TABLE_NAME] =&gt; vw_ffl_bustax_docs
[IS_UPDATABLE] =&gt; YES
)

[4] =&gt; Array
(
[TABLE_NAME] =&gt; vw_ffl_license_docs
[IS_UPDATABLE] =&gt; YES
)

[5] =&gt; Array
(
[TABLE_NAME] =&gt; vw_ffl_ntn_inv_num
[IS_UPDATABLE] =&gt; YES
)

[6] =&gt; Array
(
[TABLE_NAME] =&gt; vw_ffl_weapondocs
[IS_UPDATABLE] =&gt; YES
)

[7] =&gt; Array
(
[TABLE_NAME] =&gt; vw_fflbook_transaction_number
[IS_UPDATABLE] =&gt; YES
)

[8] =&gt; Array
(
[TABLE_NAME] =&gt; vw_ffl_not_disposed
[IS_UPDATABLE] =&gt; YES
)

[9] =&gt; Array
(
[TABLE_NAME] =&gt; vw_ffl_disposed
[IS_UPDATABLE] =&gt; YES
)

)
*/

//var_dump($rows)

////https://www.w3schools.com/php/php_arrays_multidimensional.asp
////Works1:
// echo $rows[0]['TABLE_NAME'] . " ";

////Works:
//foreach ($rows[0] as $key[0] =&gt; $value) {
// echo "$key[0]: $value ";
//}

////Works2:
//function myfunction($value,$key)
// {
// echo "The key $key has the value $value. ";
// }
// $i=count($rows);
// for($x = 0; $x &lt; $i; $x++){
// array_walk($rows[$x],"myfunction");
// }

////Works3:
// $x=0;
// $i=count($rows);
// while ($x&lt;$i){
// //echo $x;
// echo $rows[$x]['TABLE_NAME'] . " ";
// $x++;
// }

////Works4:
// $x=0;
// $i=count($rows);
// while ($x&lt;$i){
// //echo $x;
// foreach($rows[$x] as $key =&gt; $value){
// echo "$key: $value ";
// };
// $x++;
// }

////Works5:
// $i=count($rows);
// for($x = 0; $x &lt; $i; $x++){
// foreach($rows[$x] as $key =&gt; $value){
// echo "$key: $value ";
// }
// }

////Works6:
// $i=count($rows);
// for($x = 0; $x &lt; $i; $x++){
// echo $rows[$x]['TABLE_NAME'] . " ";
// }

////Works7:
// $i=count($rows);
// for($x = 0; $x &lt; $i; $x++){
// echo $rows[$x]['TABLE_NAME'] . " " . $rows[$x]['IS_UPDATABLE'] . " ";
// }


?&gt;^</Template><Template Name="tmp_phpMySQLconnect" Description="PHP MySQL connect">&lt;?php  
/* 
*Program Author: [+Author+] 
*Program Name: [+Program+] 
*Creation Date: [DATE_TEXT] [TIME] 
*Last Modified:   
*Copyright (c)[DATE_USER]yyyy[DATE_USER_END] 
*Purpose:  
*Request #:  
*/ //----------------------------------------------------------------------------  
//database server  
define('db_server', 'db_servername_or_ip');   

//user, password, and database variables    
$db_user = '[+db_username+]';  
$db_password = '[+db_userpassword+]';  
$db_dbname = '[+db_name+]';    
//echo $q;  
$con = mysql_connect($db_server, $db_user, $db_password);   
if (!$con)
    {
     	die('Could not connect: ' . mysql_error());
     	}   	mysql_select_db($db_dbname, $con);   
?&gt; </Template><Template Name="tmp_phpMySQLiconnect" Description="PHP MySQLi Connect">&lt;?php //Program Author: [+Author+] 
//Program Name: [+connect.php+] 
//Creation Date: [DATE_TEXT] [TIME] 
//Last Modified: 
//Purpose: //Request #: 
//---------------------------------------------------------------------------- 
//MySQLi Connect  
$db_server = '[+database_servername+]'; 
$db_user = '[+database_username+]'; 
$db_password = '[+database_userpassword+]'; 
$db_dbname = '[+database_name+]';
  
$con = mysqli_connect($db_server, $db_user, $db_password, $db_dbname);
if(!$con){
 die("Failed to connect to the database: " . mysqli_error($con));
 }
if (mysqli_connect_errno()){
 die("Error data : " . mysqli_connect_errno()." : ". mysqli_connect_error());
 } 
//else {
//echo "Connected successfully! &lt;br /&gt;\r\n";
//}
?&gt;</Template><Template Name="tmp_phpMySQLPDOconnect" Description="MySQL PDO Connect">&lt;?php 
//Program Author: [+Author+] 
//Program Name: [+connect.php+] 
//Creation Date: [DATE_TEXT] [TIME] 
//Last Modified: 
//Purpose: 
//Request #: 
//---------------------------------------------------------------------------- 
//PDO connect 
try {
 	$handler = new PDO('mysql:host=[+servername+]; dbname=[+databasename+]', '[+dbusername+]', '[+dbpassword+]');
 	$handler-&gt;setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
 } 

catch(PDOException $e) { //Return the PDO exception "$e".
  	//die('Sorry database problem.'); //Production message.
 	echo $e-&gt;getMessage(); //Show specific error message. Development.
 }  

//No carriage return after the end. It screws up header information when included.  
?&gt;</Template><Template Name="tmp_phpMySQLPDOInsert" Description="MySQL PDO Insert">// ---------------------------------------------------------------------------- 
//Program Author: [+Author+] 
//Program Name: [+Program+] 
//Creation Date: [DATE_TEXT] [TIME] 
//Last Modified:   
//Copyright (c)[DATE_USER]yyyy[DATE_USER_END] 
//Purpose:  
//Request #:  
// ----------------------------------------------------------------------------  
&lt;?php 
include('[+connect.php+]');  
$fname = htmlentities($_POST['firstname']); 
$mname = htmlentities($_POST['middlename']); 
$lname = htmlentities($_POST['lastname']); 
$bdate = htmlentities($_POST['birthdate']);  
$stmt = $handler-&gt;prepare("insert into test (firstname, middlename, lastname, birthdate) values (:firstname, :middlename, :lastname, :birthdate);"); 
$stmt-&gt;bindParam(':firstname', $fname); 
$stmt-&gt;bindParam(':middlename', $mname); 
$stmt-&gt;bindParam(':lastname', $lname); 
$stmt-&gt;bindParam(':birthdate', $bdate); 
$stmt-&gt;execute(); 
//header('Location: ../index.php'); 
?&gt;</Template><Template Name="tmp_phpMySQLPDOOutput" Description="PHP MySQL PDO Output">&lt;?php
//Program Author: [+Author+]
//Program Name: [+Program+]
//Creation Date: [DATE_TEXT] [TIME]
//Last Modified:  
//Copyright (c)[DATE_USER]yyyy[DATE_USER_END]
//Purpose: 
//Request #: 
//----------------------------------------------------------------------------
//MySQL PDO Output

require('[+pdoconnect.php+]');
//$statement = $handler-&gt;prepare("select * from thetablename order by id;"); 

$statement = $handler-&gt;prepare("select this from that order by this_id; "); 
$statement-&gt;execute(); //Run the prepared query. Prevents MySQL injection.

$RowCount = $statement-&gt;rowCount(); //Count the number of rows returned.

//Send records to HTML table in browser.
echo "
&lt;html&gt;
&lt;head&gt;
	&lt;script type='text/javascript' src='../js/jquery-1.11.3.js'&gt;&lt;/script&gt;
	&lt;script type='text/javascript' src='js/custom.js'&gt;&lt;/script&gt; &lt;/head&gt; &lt;style&gt;
	th {text-align: left; background-color: #d0e4fe;}
	table, th, td {border-collapse:collapse; border: 1px solid black;}

/* Tooltip container */
.tooltip {
    position: relative;
    display: inline-block;
/*     border-bottom: 1px dotted black;  If you want dots under the hoverable text */
}

/* Tooltip text */
.tooltip .tooltiptext {
    visibility: hidden;
    width: 120px;
    background-color: black;
    color: #fff;
    text-align: center;
    padding: 5px 0;
    border-radius: 6px;

    /* Position the tooltip text - see examples below! */
    position: absolute;
    z-index: 1;
}

/* Show the tooltip text when you mouse over the tooltip container */ .tooltip:hover .tooltiptext {
    visibility: visible;
}
&lt;/style&gt;

&lt;body&gt;
&lt;table id='us_states' class='tablesorter'&gt; &lt;thead&gt; &lt;tr&gt;
	&lt;th&gt;&lt;/th&gt;
	&lt;th&gt;State&lt;/th&gt;
	&lt;th&gt;Capital&lt;/th&gt;
	&lt;th&gt;Date Formed&lt;/th&gt;
	&lt;th&gt;Size&lt;/th&gt;
	&lt;th&gt;Edit&lt;/th&gt;
&lt;tr&gt;
&lt;/thead&gt;
&lt;tbody&gt;
&lt;tr&gt;
";

			while($r = $statement-&gt;fetch(PDO::FETCH_OBJ)){
			$id_column = $r-&gt;id;
			$state_column = $r-&gt;state;
			$capital_column = $r-&gt;capital;
			$date_formed_column = $r-&gt;date_formed;
			$statedata_column = $r-&gt;data;
			$sq_miles_column = $r-&gt;sq_miles;
			echo "&lt;tr&gt;&lt;td&gt;" . $id_column . "&lt;/td&gt;
			&lt;td&gt;" . $state_column . "&lt;/td&gt;
			&lt;td&gt;" . $capital_column . "&lt;/td&gt;
			&lt;td class='tooltip'&gt;&lt;span class='tooltiptext'&gt;" . $statedata_column . "&lt;/span&gt;" . $date_formed_column . "&lt;/td&gt;
			&lt;td&gt;" . number_format($sq_miles_column) . " sqm.&lt;/td&gt;
			&lt;td&gt;&lt;input type='radio' name='edit' id='" . $id_column . "'&gt;&lt;/td&gt;
			&lt;/tr&gt;";
			}

echo "&lt;/tbody&gt;&lt;/table&gt;
&lt;!-- &lt;div class='tooltip'&gt;Hover over me
  &lt;span class='tooltiptext'&gt;Tooltip text&lt;/span&gt; &lt;/div&gt; --&gt; "; 
?&gt;</Template><Template Name="tmp_phpServer" Description="PHP Server">php -S computername:portnumber

Exampl:
    php -S 127.0.0.1:8080
    php -S localhost:8080
</Template><Template Name="tmp_powershell" Description="Powershell">#Check if current user is an administrator:
(New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
</Template><Template Name="tmp_pstools" Description="PSTools">pslist \\[+ComputerName+] -m [+AppNameProcessName+] 
pslist \\[+ComputerName+] -m [+AppNameProcessName+] | sort

pskill -t \\[+ComputerName+] [+AppNameProcessName+]
^</Template><Template Name="tmp_regex_examples" Description="Regex examples">Links:
	https://www.ultraedit.com/support/tutorials-power-tips/ultraedit/perl-regular-expressions.html
	https://www.ultraedit.com/support/tutorials-power-tips/ultraedit/perl-regular-expressions-digging-deeper.html
	https://www.ultraedit.com/support/tutorials-power-tips/ultraedit/remove-blank-lines.html
	https://www.ultraedit.com/support/tutorials-power-tips/ultraedit/non-greedy-perl-regex.html
	See also tmp_delete_blank_lines

Regex in UltraEdit / UEStudio
UltraEdit symbol	Unix symbol	Function
			%									^^		Matches beginning of line (positional match).
			$									$			Matches end of line (positional match).
			?									.			Matches any single character except a new line character. Does not match repeated new lines.
			*												Matches any number of occurrences of any character except new line.
			+									+			Matches one or more of the preceding single character/character set. At least one occurrence of the preceding character or at least one of the characters in preceding character set must be found.
			++								*			Matches the preceding single character/character set zero or more times.
			^^								\			Indicates the next character has a special meaning. "n" on its own matches the character "n". "^^n" (UE syntax) or "\n" (Unix syntax) matches a line feed (LF, or hex 0A) character. See examples below.
			[ ]								[ ]		Matches any single character or range in the brackets.
			[~xyz]				[^^xyz]		A negative character set. Matches any characters NOT between brackets.
			^^b								\f		Matches a page break/form feed character.
			^[#0C#];								\p		Matches a newline (CR/LF, or hex 0D 0A) (paragraph) (Windows line terminators).
			^^r								\r		Matches a newline (CR, or hex 0D) (Mac legacy line terminators).
			^^n								\n		Matches a newline (LF, or hex 0A) (Unix line terminators).
			^^t								\t		Matches a tabstop.
			[0-9]							\d		Matches any digit character.
			[~0-9]						\D		Matches any non-digit character.
			[ ^^t^^b]					\s		Matches any whitespace including space, tab, form feed, etc., but not new line characters.
			[~ ^^t^^b]				\S		Matches any non-whitespace character but will still match new line characters.
												\v		Matches a vertical tab character.
			[0-9a-z_]					\w		Matches any alphanumeric character including underscore.
			[~0-9a-z_]				\W		Matches any character except alphanumeric characters and underscore.
			^^{A^^}^^{B^^}	(A|B)		Matches expression A or B.
			^^								\			Overrides the following regular expression character.
			^^(...^^)				(...)		Brackets or tags an expression to use in the replace command. A regular expression may have up to 9 tagged expressions, numbered according to their order in the regular expression.
			^^1	\1									Numerical reference to tagged expressions. Text matched with tagged expressions may be used in replace commands with this format.
			Note: ^^ refers to the character '^^', not Ctrl + value.


UltraEdit / Unix regular expressions examples
Simple string matching
Simple string matching is probably the most basic form of regular expressions but can allow you to quickly exploit different patterns so that you can search for more than one string at a time rather than doing multiple Find operations.

UltraEdit legacy regex:
  Find what: m?n
  Matches: "man" and "men" but not "moon"

  Find what: t*t
  Matches: "test", "tonight" and "tea time" (the "tea t" portion) but not "tea
  time" (newline between "tea " and "time").

  Find what: Te+st
  Matches: "test", "teest", "teeeest", etc. but does not match "tst"

  Unix regex:
  Find what: m.n
  Matches: "man" and "men" but not "moon"

  Find what: t.*t
  Matches: "test", "tonight" and "tea time" (the "tea t" portion) but not "tea
  time" (newline between "tea " and "time").

  Find what: Te+st
  Matches: "test", "teest", "teeeest", etc. but does not match "tst"

Character Sets
  A character set is a group of characters encapsulated by "[" and "]". These may be used to designate specific characters to be matched or ranges, for example [aeud] or [a-z].

  UltraEdit legacy regex:
  Find what: [aeiou]
  Matches: every vowel

  NOTE: Regular expressions in UltraEdit are not case-sensitive unless Match case is enabled in the find dialog.

  Find what: [,.^^?]
  Matches: a literal ",", "." or "?".

  Because the "?" is a symbol used in expressions it must be "escaped" for the literal character to be matched rather than interpreted as an expression.

  Find what: [0-9a-z]
  Matches: any digit or letter

  Find what: [~0-9]
  Matches: any character except a digit (~ means NOT the following)

Unix regex:
  Find what: [aeiou]
  Matches: every vowel

  Find what: [,\.?]
  Matches: a literal ",", "." or "?".

  Because the "." is a special symbol used in expressions it must be "escaped" for the literal character to be matched rather than interpreted as an expression.

  Find what: [0-9a-z]
  Matches: any digit or letter

  Find what: [^^0-9]
  Matches: any character except a digit (^^ means NOT the following)

"Or" Expressions
  Currently UltraEdit legacy regex allows for only two strings in an "or" expression.

  UltraEdit legacy regex:
  Find what: ^^{John^^}^^{Tom^^}
  Unix regex:
  Find what: (John|Tom|Dick|Harry)
  There should be nothing between the two expressions. You may combine "A or B" and "C or D" in the same search as follows:

  UltraEdit legacy regex:
  Find what: ^^{John^^}^^{Tom^^} ^^{Smith^^}^^{Jones^^}
  Unix regex:
  Find what: (John|Tom) (Smith|Jone)
  This will search for "John" or "Tom" followed by "Smith" or "Jones".

Deleting blank lines
  With regular expressions selected in the replace dialog this will match the a CR/LF (DOS line terminator) immediately followed by the end of a line (i.e., a blank line) and replace it with nothing, effectively deleting it:

  UltraEdit legacy regex:
  Find what: ^[#0C#];$
  Replace With: (literally nothing)

  Unix regex:
  Find what: \p$
  Replace With: (literally nothing)

Reformatting text with tagged expressions
  Example 1:
  Tagged expressions may be used to mark various data members so that they may be reorganized, reformatting the data. For example, it might be useful to be able to rearrange:

  John Smith, 385 Central Ave., Cincinnati, OH, 45238

  into:

  45238, Smith, John, 385 Central Ave., Cincinnati, OH

  UltraEdit legacy regex:
  Find what: %^^([a-z]+^^) ^^([a-z]+^^), ^^(*^^), ^^(*^^), ^^(*^^), ^^([0-9]+^^)
  Replace With: ^^6, ^^2, ^^1, ^^3, ^^4, ^^5

  Unix regex:
  Find what: ^^([a-z]+) ([a-z]+), (.*), (.*), (.*), ([0-9]+)
  Replace With: \6, \2, \1, \3, \4, \5

  Example 2:
  If you have a web-based registration system it might be useful to rearrange the order data into a format easily used by a database:

  name = John Smith
  address1 = 385 Central Ave.
  address2 =
  city = Cincinnati
  state = OH
  zip = 45238
  into:

  John Smith, 385 Central Ave.,, Cincinnati, OH, 45238,

  This can be done with the following expression:

  UltraEdit legacy regex:
  Find what: name = ^^([a-z ]+^^)^[#0C#];address1 = ^^([a-z 0-9.,]+^^)^[#0C#];address2 = ^^([a-z 0-9.,]++^^)^[#0C#];city = ^^([a-z]+^^)^[#0C#];state = ^^([a-z]+^^)^[#0C#];zip = ^^([0-9^^-]+^^)
  Replace With:^^1, ^^2, ^^3, ^^4, ^^5, ^^6

  Unix regex:
  Find what: name = ([a-z ]+)\paddress1 = ([a-z 0-9.,]+)\paddress2 = ([a-z 0-9.,]*)\pcity = ([a-z]+)\pstate = ([a-z]+)\pzip = ([0-9^^-]+)
  Replace With:\1, \2, \3, \4, \5, \6

Perl regex techniques and samples
	.*	Match zero or more of any characters (except new line). Note: Perl regex are greedy, meaning they will match as much data as possible. For more information, see the non-greedy regex tutorial.
	.+	Match one or more of any character (except new line)
	[\r\n]+	Match new line character(s) regardless of terminator format
	&lt;a href=(".+?")&gt;(.+?)&lt;/a&gt;	Match hyperlinked text and preserve both the URL and link text for backreferencing
	^^(.+)$[\r\n]+\1$	Match two duplicate consecutive lines
	^^.*[ \t]+$	Match lines ending in one ore more spaces or tabs
^</Template><Template Name="tmp_rhts" Description="Timestamp">[DATE_TEXT] [TIME]
</Template><Template Name="tmp_runas" Description="Run As">runas /noprofile /user:BHS\a-rlholland "[+CommandToRun.exe+]"  
^</Template><Template Name="tmp_Shell" Description="Common AIX/Linux shell stuff" Comments="0" Strings="0">#WHILE loop
i=1
while [[ $i -le 10 ]]
do
echo "Searching Node $i: "
ssh rholland@pcma"$i"p.bdcm.bannerhealth.com "ls -al /cerner/w_custom/
cust_wh/code/$1/$2"
# echo "$i"
let i=i+1
done

#FOR Loop
for file in *.txt
do
cat "$file" &gt;&gt; OneBigFile.txt
done

# Rename all *.txt to *.text
for file in *.txt; do
mv -- "$file" "${file%.txt}.text"
done

#Rename, If you have to use basename, your syntax would be:
for file in *.txt; do
mv -- "$file" "$(basename -- "$file" .txt).text"
done

Use the Perl "rename" utility:
rename "s/\.txt/\.text/" *.txt

Rename when your files don't have any extension and you want to add one:
rename 's/$/.txt/' *

#AIX Array:
set -A profileup 2 3 4 5 6 7 8 9 10
for i in ${profileup[@]}
do
echo "Updating .profile on pcma${i}: "
scp ~/.profile rlholland@pcma"$i"p.bdcm.bannerhealth.com:~/
#echo "$i"
done

LINUX Array:
rho_hosts=(2 3 4 5 6 7 8 9 10 11 12 19 20 22) #Skipping Node 1 in the array
for i in ${rho_hosts[@]}
do
echo "Updating .bashrc on samtazapp${i}: "
scp ~/.bashrc rlholland@samtazapp"$i":~/
#  #echo "$i"
done

Make Dummy Files:
dummyfiles(){
	if [ $# -eq 0 ]
	then
	echo "dummyfiles 30"
	else
	#printf '%s ' {1..$1}.txt |xargs touch
	for ((i=1; i&lt;=$1; i++)); do : &gt;&gt; dummyfile_"$i".txt; done
	fi
} functionname(){
	if [ $# -eq 0 ]
	then
	echo "Message"
	else
	case $1 in
	argument1)
	echo "Doing something"
	Do Something
	;;
	argument2)
	echo "Doing something"
	Do Something
	;;
	argument3)
	echo "Doing something"
	Do Something
	;;
	argument4)
	echo "Doing something"
	Do Something
	;;
	*)
	message00="The message"
	echo $message00
	;;
	esac
	fi
}

https://www.commandlinefu.com/commands/view/694/it-decripts-all-pgp-files-in-a-selection-folder-and-move-the-output-into-a-file.
This looks pretty broken. First off, go read about useless use of cat: http://partmaps.org/era/unix/award.html 
Here's a version that should actually work:
for x in *.pgp ;
 do gpg --batch --no-tty --yes --passphrase-fd=0 --decrypt ${x} &lt; file_with_passphrase &gt; ${x%%pgp}txt ; 
 done
Also, it concerns me a bit that you're storing a passphrase in a file on your filesystem. Hopefully you use shred or srm or similar when you're done (dd with /dev/urandom or /dev/zero works, too), otherwise there isn't much point in using gpg.

#Extensions
for x in *.pgp
do
gpg --batch --no-tty --yes --passphrase-fd=0 --decrypt ${x} &lt; file_with_passphrase &gt; ${x%%pgp}txt
done
^</Template><Template Name="tmp_Shutdown" Description="Shutdown computer, Register DNS">[+TargetComputer+] [+incident+]
Old School:
	shutdown -m \\[+TargetComputer+] -r -t 0 -f &amp; ping [+TargetComputer+] -t
	 or
	runas /noprofile /user:BHS\a-rlholland "shutdown -m \\[+TargetComputer+] -r -t 0 -f" &amp; ping [+TargetComputer+] -t

New School:
Event Viewer Data for shutdown:
Level=Information; Event ID=1074; Source=User32
	shutdown /m \\[+TargetComputer+] /c "[+incident+]" /d p:4:1 /r /t 0 /f &amp; ping [+TargetComputer+] -t
	 or
	runas /noprofile /user:BHS\a-rlholland "shutdown /m \\[+TargetComputer+] /c \"[+incident+]\" /d p:4:1 /r /t 0 /f" &amp; ping [+TargetComputer+] -t

From Administrator Command Prompt:
	net use A: \\[+TargetComputer+]\c$

Remember to Flush and Register the computer in DNS.
Tucson DNS 10.109.0.202 (TUSNS01) and 10.109.64.202 (TUSNS02) are the ones to use.
	runas /noprofile /user:BHS\a-rlholland "ipconfig /flushdns"
	runas /noprofile /user:BHS\a-rlholland "ipconfig /registerdns"
^</Template><Template Name="tmp_ssh" Description="SSH Keys">ssh-keygen -t rsa
ssh-keygen -t rsa -b 4096
(Copy id_rsa.pub to the target server .ssh/authorized_keys file.)

openssl genrsa -out myprivkey.pem 4096
openssl rsa -in myprivkey.pem -pubout &gt; mypubkey.pub

#Port redirect:
ssh -f username@servername -L:6868:remotecomputerIP:80 -N

#Redirect function from local host:
otun(){
if [ $# -eq 0 ]
then
clear
        echo "Usage: "
        echo "   otun servername"
else
case $1 in
        samtazapp1)
        echo "Opening port 6868 to samtazapp1 (P1805)"
        ssh rholland@pcma1p.bdcm.bannerhealth.com "ssh -f rholland@samtazapp1.bhs.bannerhealth.com -L:6868:127.0.0.1:22 -N" #(P1805)
        ;;
        samtazapp13)
        echo "Opening port 6767 to samtazapp13 (TM1805)"
        ssh rholland@pcma1p.bdcm.bannerhealth.com "ssh -f rholland@samtazapp13.bhs.bannerhealth.com -L:6767:127.0.0.1:22 -N" #(TM1805)
        ;;
        samtazapp14)
        echo "Opening port 6969 to samtazapp14 (B1805)"
        ssh rholland@pcma1p.bdcm.bannerhealth.com "ssh -f rholland@samtazapp14.bhs.bannerhealth.com -L:6969:127.0.0.1:22 -N" #(B1805)
        ;;
        samtazapp15)
        echo "Opening port 6666 to samtazapp15 (D1805)"
        ssh rholland@pcma1p.bdcm.bannerhealth.com "ssh -f rholland@samtazapp15.bhs.bannerhealth.com -L:6666:127.0.0.1:22 -N" #(D1805)
        ;;
#       *)
#       echo "Catch-All"
#       ;;
esac
fi
}

^</Template><Template Name="tmp_TaskbarLocation" Description="Taskbar location">C:\Users\%username%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar
\\%computername%\c$\Users\%username%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar
^</Template><Template Name="tmp_tasklist-taskkill" Description="tmp_tasklist-taskkill">Source: https://4sysops.com/archives/query-and-kill-a-process-on-a-remote-computer-using-powershell-and-wmi/
PowerShell:
Get-Process -ComputerName [+ComputerName+] -Name [+ProgramName.exe+]*

Command Prompt:
tasklist /s [+ComputerName+] |find /I "[+ProgramName.exe+]"
taskkill /s [+ComputerName+] /F /IM [+ProgramName.exe+] /T
TASKKILL /PID [+PID+] /PID [+PID1+] /PID [+PID2+] /T 

Examples:
    TASKKILL /IM [+ProgramName.exe+]
    TASKKILL /PID 1230 /PID 1241 /PID 1253 /T
    TASKKILL /F /IM [+ProgramName.exe+] /T
    TASKKILL /F /FI "PID ge 1000" /FI "WINDOWTITLE ne untitle*"
    TASKKILL /F /FI "USERNAME eq NT AUTHORITY\SYSTEM" /IM [+ProgramName.exe+]
    TASKKILL /S system /U domain\username /FI "USERNAME ne NT*" /IM *
    TASKKILL /S system /U username /P password /FI "IMAGENAME eq [+ProgramName.exe+]*"
    taskkill /s [+ComputerName+] /F /IM [+ProgramName.exe+]* /T
    Do Not Use a wildcard "*" on find:
    runas /noprofile /user:BHS\a-rlholland "taskkill /s [+ComputerName+] /F /IM [+ProgramName.exe+]* /T" &amp; tasklist /s [+ComputerName+] |find /I "[+ProgramName.exe+]"

    wmic /node:[+ComputerName+] process where name="[+ProgramName.exe+]" call terminate
    wmic /node:[+ComputerName+] process where name="[+ProgramName.exe+]" call terminate

LOCAL TASKKILL: Observation Tracking Board:
    tasklist /V &gt; tasktest.txt
    tasklist /FI "IMAGENAME eq msedge.exe" /FI "WINDOWTITLE eq Observation Tracking Board*"
    taskkill /F /FI "IMAGENAME eq msedge.exe" /FI "WINDOWTITLE eq Observation Tracking Board*"

REMOTE TASKKILL:
    taskkill /s [+ComputerName+] /u bhs\a-rlholland /F /FI "IMAGENAME eq msedge.exe" /FI "WINDOWTITLE eq Observation Tracking Board*"

Query all computers in an AD domain for list of running processes:
Get-ADComputer | ForEach-Object {Get-WmiObject -Class Win32_Process -Computer $_.Name}


This manual describes actions to create a list of running processes.
Source: https://www.action1.com/kb/list_of_running_processes_on_remote_computer.html

Manually:
1. Execute WMI Query in ROOT\CIMV2 Namespace:

   - Launch WMI Explorer or any other tool which can run WMI queries.
   - Run WMI query: SELECT * FROM Win32_Process
2. Open WMIC Command-line Interface:

   - Press WIN+R
   - Type "wmic", press Enter
   - In wmic command line tool type: /node:RemoteComputerName process
3. Run This Simple Windows Powershell Script:

   - thru WMI object: Get-WmiObject -Namespace ROOT\CIMV2 -Class Win32_Process -Computer RemoteComputerName
4. Use Following Code to Select Specific Columns:

   - execute: Get-WmiObject -Namespace ROOT\CIMV2 -Class Win32_Process -Computer RemoteComputerName | Select-Object Name, ProcessId, PSComputerName
5. Sort the Results Using the Line Below:

   - invoke command: Get-WmiObject -Namespace ROOT\CIMV2 -Class Win32_Process -Computer RemoteComputerName | Select-Object Name, ProcessId, PSComputerName | Sort-Object Name
6. The Next Code Helps to Filter Results:

   - use it: Get-WmiObject -Namespace ROOT\CIMV2 -Class Win32_Process -Computer RemoteComputerName | Select-Object Name, ProcessId, PSComputerName | Where-Object -FilterScript {$_.Name -like "putty.exe"}
7. Save Results to CSV File:

   - run: Get-WmiObject -Namespace ROOT\CIMV2 -Class Win32_Process -Computer RemoteComputerName | Select-Object Name, ProcessId, PSComputerName | Export-CSV "c:\file.csv" -Append -NoTypeInformation
8. The Next Step Is to Query Multiple Computers:

   - computers from a text file: Get-Content -Path c:\computers.txt | ForEach-Object {Get-WmiObject -Namespace ROOT\CIMV2 -Class Win32_Process -Computer $_}
   - computers from AD domain: Get-ADComputer -Filter {OperatingSystem -Like 'Windows 10*'} | ForEach-Object {Get-WmiObject -Namespace ROOT\CIMV2 -Class Win32_Process -Computer $_.Name}
^
</Template><Template Name="tmp_tnsnames.ora" Description="TNSNames.ora example"># Every line that begins with # is a comment line
#
# Create Oracle net service names, or aliases, for each database server
# you need to connect to.
#
# TNSNames.ora sample entry
#
# alias =
#  (DESCRIPTION =
#    (ADDRESS = (PROTOCOL = TCP)(HOST = myserver.mycompany.com)(PORT = 1521))
#    (CONNECT_DATA =
#      (SERVER = DEDICATED)
#      (SERVICE_NAME = orcl)
#    )
#  )
#
# You can modify the entry below for your own database.
# &lt;data source alias&gt; = Name to use in the connection string Data Source
# &lt;hostname or IP&gt; = name or IP of the database server machine
# &lt;port&gt; = database server machine port to use
# &lt;database service name&gt; = name of the database service on the server


BUILD1.WORLD =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(Host = dcmd3vip.bdcp.bannerhealth.com)(Port = 1521))
    )
    (CONNECT_DATA =
      (SID = build1)
    )
  )


AZB1.bdcp.bannerhealth.com =
  (DESCRIPTION =
    (ADDRESS_LIST=(ADDRESS = (PROTOCOL = TCP)
                (HOST = DCMD3VIP.bdcp.bannerhealth.com)(PORT = 1521)))
    (CONNECT_DATA=(SID = AZB1))
)



AZBLD1.bdcp.bannerhealth.com =
  (DESCRIPTION =
    (ADDRESS_LIST=(ADDRESS = (PROTOCOL = TCP)
                (HOST = DCMD3VIP.bdcp.bannerhealth.com)(PORT = 1521)))
    (CONNECT_DATA=(SID = AZBLD1))
)
AZB1.world =
(DESCRIPTION =
  (ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)
    (Host=dcmd3vip.bdcp.bannerhealth.com)(Port=1521)))
  (CONNECT_DATA=(SID=AZB1))
)

AZBLD1.world =
(DESCRIPTION =
  (ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)
    (Host=dcmd3vip.bdcp.bannerhealth.com)(Port=1521)))
  (CONNECT_DATA=(SID=AZBLD1))
)

PROD1.world =
(DESCRIPTION =
  (ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)
    (Host=pcmd1vip.bdcm.bannerhealth.com)(Port=1521)))
  (CONNECT_DATA=(SID=prod1))
)
STBY1.world =
(DESCRIPTION =
   (ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)
     (Host=pcmd3vip.bdcp.bannerhealth.com)(Port=1521)))
   (CONNECT_DATA=(SID=sdcprod1))
   )
sdcprod1.world =
(DESCRIPTION =
   (ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)
     (Host=pcmd3vip.bdcp.bannerhealth.com)(Port=1521)))
   (CONNECT_DATA=(SID=sdcprod1))
   )
sdcprod2.world =
(DESCRIPTION =
   (ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)
     (Host=pcmd4vip.bdcp.bannerhealth.com)(Port=1521)))
   (CONNECT_DATA=(SID=sdcprod2))
   )

rhononprod.world =
(DESCRIPTION =
   (ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)
     (Host=137.252.120.138)(Port=1521)))
   (CONNECT_DATA=(SID=b18051))
   )

rhoprod.world =
(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = 137.252.75.140)(PORT = 1521))
    (LOAD_BALANCE = no)
    (ENABLE = BROKEN)
    (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = cust_rpt_p1805.world)  )
)
^</Template><Template Name="tmp_ue" Description="UltraEdit Shortcuts">UE Command Palette: Control + Shift + P
 	01. Can just type what you are looking for.
 	02. Type : to access Goto options.
 	03. Use backslash to search through previously open files.

  Keyboard Shortcuts:
 	01. Control + Up or Down arrow to move the entire page up or down.
 	02. Wordwrap - Control + w
 	03. Control . highlights all words under the file.
 	04. Control ; select all words under the caret.
 	05. Control , select all words under the caret so you can edit them.
 	06. Alt + -
 	07. Alt + F3 Find dialogue
 	08. Alt + C enter column mode.
 	09. control + H Toggle HEX Mode.

  Regular Expressions:
     https://www.ultraedit.com/support/tutorials-power-tips/ultraedit/regular-expressions.html

Note on cleaning up double-spaced templates.
  Open UETMPLTE.TPL then do a find/replace:
    Find: &amp;#xD;&amp;#xD;&amp;#xD;
    Replace with: &amp;#xD;&amp;#xD;

^</Template><Template Name="tmp_url_encoded_characters" Description="URL Encoded Characters">https://www.degraeve.com/reference/urlencoding.php

URL Encoded Characters
       backspace      %08
       tab            %09
       linefeed       %0A
       creturn        %0D
       space          %20
       !              %21
       "              %22
       #              %23
       $              %24
       %              %25
       &amp;              %26
       '              %27
       (              %28
       )              %29
       *              %2A
       +              %2B
       ,              %2C
       -              %2D
       .              %2E
       /              %2F
       0              %30
       1              %31
       2              %32
       3              %33
       4              %34
       5              %35
       6              %36
       7              %37
       8              %38
       9              %39
       :              %3A
       ;              %3B
       &lt;              %3C
       =              %3D
       &gt;              %3E
       ?              %3F
       @              %40
       A              %41
       B              %42
       C              %43
       D              %44
       E              %45
       F              %46
       G              %47
       H              %48
       I              %49
       J              %4A
       K              %4B
       L              %4C
       M              %4D
       N              %4E
       O              %4F
       P              %50
       Q              %51
       R              %52
       S              %53
       T              %54
       U              %55
       V              %56
       W              %57
       X              %58
       Y              %59
       Z              %5A
       [              %5B
       \              %5C
       ]              %5D
       ^              %5E
       _              %5F
       `              %60
       a              %61
       b              %62
       c              %63
       d              %64
       e              %65
       f              %66
       g              %67
       h              %68
       i              %69
       j              %6A
       k              %6B
       l              %6C
       m              %6D
       n              %6E
       o              %6F
       p              %70
       q              %71
       r              %72
       s              %73
       t              %74
       u              %75
       v              %76
       w              %77
       x              %78
       y              %79
       z              %7A
       {              %7B
       |              %7C
       }              %7D
       ~              %7E
       &#xA2;              %A2
       &#xA3;              %A3
       &#xA5;              %A5
       |              %A6
       &#xA7;              %A7
       &#xAB;              %AB
       &#xAC;              %AC
       &#xAF;              %AD
       &#xBA;              %B0
       &#xB1;              %B1
       &#xAA;              %B2
       ,              %B4
       &#xB5;              %B5
       &#xBB;              %BB
       &#xBC;              %BC
       &#xBD;              %BD
       &#xBF;              %BF
       &#xC0;              %C0
       &#xC1;              %C1
       &#xC2;              %C2
       &#xC3;              %C3
       &#xC4;              %C4
       &#xC5;              %C5
       &#xC6;              %C6
       &#xC7;              %C7
       &#xC8;              %C8
       &#xC9;              %C9
       &#xCA;              %CA
       &#xCB;              %CB
       &#xCC;              %CC
       &#xCD;              %CD
       &#xCE;              %CE
       &#xCF;              %CF
       &#xD0;              %D0
       &#xD1;              %D1
       &#xD2;              %D2
       &#xD3;              %D3
       &#xD4;              %D4
       &#xD5;              %D5
       &#xD6;              %D6
       &#xD8;              %D8
       &#xD9;              %D9
       &#xDA;              %DA
       &#xDB;              %DB
       &#xDC;              %DC
       &#xDD;              %DD
       &#xDE;              %DE
       &#xDF;              %DF
       &#xE0;              %E0
       &#xE1;              %E1
       &#xE2;              %E2
       &#xE3;              %E3
       &#xE4;              %E4
       &#xE5;              %E5
       &#xE6;              %E6
       &#xE7;              %E7
       &#xE8;              %E8
       &#xE9;              %E9
       &#xEA;              %EA
       &#xEB;              %EB
       &#xEC;              %EC
       &#xED;              %ED
       &#xEE;              %EE
       &#xEF;              %EF
       &#xF0;              %F0
       &#xF1;              %F1
       &#xF2;              %F2
       &#xF3;              %F3
       &#xF4;              %F4
       &#xF5;              %F5
       &#xF6;              %F6
       &#xF7;              %F7
       &#xF8;              %F8
       &#xF9;              %F9
       &#xFA;              %FA
       &#xFB;              %FB
       &#xFC;              %FC
       &#xFD;              %FD
       &#xFE;              %FE
       &#xFF;              %FF
^</Template><Template Name="tmp_Windows_DeleteLocalProfile" Description="Delete local Windows profile.">The easiest way of deleting a user profile is deleting it from System Properties, please follow the instructions below:

Press Windows + R together on your keyboard to open the Run box.
Type "SystemPropertiesAdvanced" into the text area and hit Enter.
In the System properties dialog box, under the User profile section, click on Settings button.
In the User profiles window, select the user profile you want to delete and click Delete button.
Confirm the request by clicking on Yes option and your profile will be deleted.
^</Template><Template Name="tmp_Windows_msc" Description="Miscellaneous Windows Stuff">Windows Security EventID 4625  Windows 10 MSC files: 
	adsiedit.msc 
	azman.msc 
	certlm.msc 
	certmgr.msc 
	certsrv.msc 
	certtmpl.msc 
	CluAdmin.msc 
	comexp.msc 
	compmgmt.msc 
	Data61x4_2_2.msc 
	Data9377_2_0.msc 
	devmgmt.msc 
	DevModeRunAsUserConfig.msc 
	dfsmgmt.msc 
	dhcpmgmt.msc 
	diskmgmt.msc 
	domain.msc 
	dsa.msc 
	dssite.msc 
	eventvwr.msc 
	FailoverClusters.SnapInHelper.msc 
	fsmgmt.msc 
	fsrm.msc 
	gpedit.msc 
	gpmc.msc 
	gpme.msc 
	gptedit.msc 
	lsdiag.msc 
	lusrmgr.msc 
	ocsp.msc 
	perfmon.msc 
	pkiview.msc 
	printmanagement.msc 
	rrasmgmt.msc 
	rsop.msc 
	secpol.msc 
	services.msc 
	taskschd.msc 
	tpm.msc 
	tsgateway.msc 
	WF.msc 
	WmiMgmt.msc 
 ^</Template><Template Name="tmpTest" Description="">;This will generate a "Declared variables list" from code_values entered.

;From: Bannerman,Pat &lt;Pat.Bannerman@Cerner.com&gt; 
;Sent: Friday, June 28, 2019 7:06 AM
;To: Soliman, Raphael &lt;Rouphail.Soliman@bannerhealth.com&gt;; Aluko, Adebiyi &lt;Adebiyi.Aluko@bannerhealth.com&gt;; Deme, Kavitha &lt;Kavitha.Deme@bannerhealth.com&gt;; Holland, Robert L &lt;Robert.Holland@bannerhealth.com&gt;; Untalan, Cory A &lt;Cory.Untalan@bannerhealth.com&gt;; Xie, Mike &lt;michael.xie@bannerhealth.com&gt;
;Subject: [EXTERNAL] RE: sql to capture prefmaint
;
;Here's another one for you

select 
ONE = build2(^^declare ^^
                ,trim(cv.display_key)
                ,^^_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",^^
                ,trim(CNVTSTRING(cv.code_set))
                ,^^, "^^
                ,trim(cv.display_key)
                ,^^"))^^)
from code_value cv
where cv.display_key like "DME*"
and
cv.display like "DME *"
and
cv.code_set = 72

select 
ONE = build2(^^declare ^^
                ,trim(cv.display_key)
                ,^^_CD = f8 with protect, constant(UAR_GET_CODE_BY("DISPLAYKEY",^^
                ,trim(CNVTSTRING(cv.code_set))
                ,^^, "^^
                ,trim(cv.display_key)
                ,^^"))^^)
from code_value cv
where cv.code_value in (
	1018224715.00;	Durable Medical Equipment (DME)
	,1018224278.00;	Home Health
	,1793360133.00;	Outpatient Therapy/Orders
)
^</Template></Templates>
