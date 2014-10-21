SELECT
CV1.ACTIVE_IND
	, CV1.CDF_MEANING
	, CV1.CKI
	, CV1.CODE_SET
	, CV1.CODE_VALUE
	, CV1.DEFINITION
	, CV1.DESCRIPTION
	, CV1.DISPLAY
	, CV1.DISPLAY_KEY
	, CV1.END_EFFECTIVE_DT_TM


FROM
	CODE_VALUE   CV1
where cv1.code_set in (72.00, 93.00, 14003.00)
and cv1.display in (
"Arterial MAP From Monitor"
,"CVO2"
,"CVP"
,"CaO2"
,"Calibrated"
,"Cardiac Index"
,"Cardiac Output"
,"Cerebral Oximetry"
,"DBP"
,"DO2"
,"Diastolic BP sitting"
,"Diastolic BP standing"
,"Diastolic BP supine"
,"Diastolic Blood Pressure"
,"ET CO2"
,"EWS CNS Level of Consciousness"
,"EWS Score"
,"HR Site"
,"Heart Rate"
,"Heart Rate- Sitting"
,"Heart Rate- Standing"
,"Heart Rate- Supine"
,"LVSWI"
,"MPAP"
,"Mean BP From Device"
,"O2 Saturation"
,"O2ER"
,"PA DBP"
,"PA SBP"
,"PAWP"
,"PVRI"
,"PaO2"
,"Perfusion Index (Foot)"
,"Perfustion Index (Right Hand)"
,"Post Ductal O2 Saturation"
,"Pre Ductal O2 Saturation"
,"Pulse Ox Site"
,"PvO2"
,"QS/QT"
,"RSWI"
,"Recovery Heart Rate"
,"Recovery O2 Saturation"
,"Respiratory Rate"
,"SBP"
,"SVO2"
,"SVR"
,"SVRI"
,"ScvO2"
,"Site Changed"
,"Somatic Oximetry"
,"Stoke Index"
,"Stroke Volume Variance"
,"Stroke Volume"
,"Systolic BP sitting"
,"Systolic BP standing"
,"Systolic BP supine"
,"Systolic Blood Pressure"
,"Temp C"
,"Transcutaneous Site Temp"
,"VO2"
,"VO21"
,"Vital Signs Comment"
,"Which Test is Being Performed"
,"avDO2"

)
WITH NOCOUNTER, SEPARATOR=" ", FORMAT, time=300
