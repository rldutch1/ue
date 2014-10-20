# ----------------------------------------------------------------------------
# Script Author: Robert Holland
# Program Name: RHSearch.ksh
# Creation Date: Sat Oct 18 2014 21:04:17 GMT-0700 (US Mountain Standard Time)
# Last Modified:
# Copyright (c)2014
# Purpose: Search for specific terms in .prg files and output the .prg filename.
# Filenames correspond to spreadsheet cells where the search term can be found.
# For instance RH1.1 is the first column first cell.
# Spreadsheet is located: http://www.robholland.net/php/play/iview.php.
# It was easier for me to use PHP and MySQL to generate the information needed.
# Request #: Ben Burris requested on 17 Oct 2014.
# ----------------------------------------------------------------------------

grep -i "3145187" *.prg |cut -d : -f1 > RH1.1
grep -i "CVP" *.prg |cut -d : -f1 > RH1.2
grep -i "CVP" *.prg |cut -d : -f1 > RH1.3
grep -i "CVP" *.prg |cut -d : -f1 > RH1.4
grep -i "CVP" *.prg |cut -d : -f1 > RH1.5
grep -i "3144514" *.prg |cut -d : -f1 > RH2.1
grep -i "CaO2" *.prg |cut -d : -f1 > RH2.2
grep -i "CaO2" *.prg |cut -d : -f1 > RH2.3
grep -i "CaO2" *.prg |cut -d : -f1 > RH2.4
grep -i "CAO2" *.prg |cut -d : -f1 > RH2.5
grep -i "434437369" *.prg |cut -d : -f1 > RH3.1
grep -i "Calibrated" *.prg |cut -d : -f1 > RH3.2
grep -i "Calibrated" *.prg |cut -d : -f1 > RH3.3
grep -i "Calibrated" *.prg |cut -d : -f1 > RH3.4
grep -i "CALIBRATED" *.prg |cut -d : -f1 > RH3.5
grep -i "3144486" *.prg |cut -d : -f1 > RH4.1
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH4.2
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH4.3
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH4.4
grep -i "CARDIACINDEX" *.prg |cut -d : -f1 > RH4.5
grep -i "3144307" *.prg |cut -d : -f1 > RH5.1
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH5.2
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH5.3
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH5.4
grep -i "CARDIACOUTPUT" *.prg |cut -d : -f1 > RH5.5
grep -i "1191411606" *.prg |cut -d : -f1 > RH6.1
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH6.2
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH6.3
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH6.4
grep -i "CEREBRALOXIMETRY" *.prg |cut -d : -f1 > RH6.5
grep -i "3047195" *.prg |cut -d : -f1 > RH7.1
grep -i "DBP" *.prg |cut -d : -f1 > RH7.2
grep -i "DBP" *.prg |cut -d : -f1 > RH7.3
grep -i "DBP" *.prg |cut -d : -f1 > RH7.4
grep -i "DBP" *.prg |cut -d : -f1 > RH7.5
grep -i "3144520" *.prg |cut -d : -f1 > RH8.1
grep -i "DO2" *.prg |cut -d : -f1 > RH8.2
grep -i "DO2" *.prg |cut -d : -f1 > RH8.3
grep -i "DO2" *.prg |cut -d : -f1 > RH8.4
grep -i "DO2" *.prg |cut -d : -f1 > RH8.5
grep -i "3059689" *.prg |cut -d : -f1 > RH9.1
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH9.2
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH9.3
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH9.4
grep -i "DIASTOLICBLOODPRESSURE" *.prg |cut -d : -f1 > RH9.5
grep -i "1486606679" *.prg |cut -d : -f1 > RH10.1
grep -i "EWS CNS Level of Consciousness" *.prg |cut -d : -f1 > RH10.2
grep -i "EWS CNS Level of Consciousness" *.prg |cut -d : -f1 > RH10.3
grep -i "EWS CNS Level of Consciousness" *.prg |cut -d : -f1 > RH10.4
grep -i "EWSCNSLEVELOFCONSCIOUSNESS" *.prg |cut -d : -f1 > RH10.5
grep -i "1527287574" *.prg |cut -d : -f1 > RH11.1
grep -i "EWS Score" *.prg |cut -d : -f1 > RH11.2
grep -i "EWS Score" *.prg |cut -d : -f1 > RH11.3
grep -i "EWS Score" *.prg |cut -d : -f1 > RH11.4
grep -i "EWSSCORE" *.prg |cut -d : -f1 > RH11.5
grep -i "3049505" *.prg |cut -d : -f1 > RH12.1
grep -i "HR Site" *.prg |cut -d : -f1 > RH12.2
grep -i "HR Site" *.prg |cut -d : -f1 > RH12.3
grep -i "HR Site" *.prg |cut -d : -f1 > RH12.4
grep -i "HRSITE" *.prg |cut -d : -f1 > RH12.5
grep -i "3049471" *.prg |cut -d : -f1 > RH13.1
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH13.2
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH13.3
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH13.4
grep -i "HEARTRATE" *.prg |cut -d : -f1 > RH13.5
grep -i "3145329" *.prg |cut -d : -f1 > RH14.1
grep -i "MPAP" *.prg |cut -d : -f1 > RH14.2
grep -i "MPAP" *.prg |cut -d : -f1 > RH14.3
grep -i "MPAP" *.prg |cut -d : -f1 > RH14.4
grep -i "MPAP" *.prg |cut -d : -f1 > RH14.5
grep -i "3053467" *.prg |cut -d : -f1 > RH15.1
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH15.2
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH15.3
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH15.4
grep -i "O2SATURATION" *.prg |cut -d : -f1 > RH15.5
grep -i "3144718" *.prg |cut -d : -f1 > RH16.1
grep -i "O2ER" *.prg |cut -d : -f1 > RH16.2
grep -i "O2ER" *.prg |cut -d : -f1 > RH16.3
grep -i "O2ER" *.prg |cut -d : -f1 > RH16.4
grep -i "O2ER" *.prg |cut -d : -f1 > RH16.5
grep -i "3145326" *.prg |cut -d : -f1 > RH17.1
grep -i "PA DBP" *.prg |cut -d : -f1 > RH17.2
grep -i "PA DBP" *.prg |cut -d : -f1 > RH17.3
grep -i "PA DBP" *.prg |cut -d : -f1 > RH17.4
grep -i "PADBP" *.prg |cut -d : -f1 > RH17.5
grep -i "3145191" *.prg |cut -d : -f1 > RH18.1
grep -i "PA SBP" *.prg |cut -d : -f1 > RH18.2
grep -i "PA SBP" *.prg |cut -d : -f1 > RH18.3
grep -i "PA SBP" *.prg |cut -d : -f1 > RH18.4
grep -i "PASBP" *.prg |cut -d : -f1 > RH18.5
grep -i "3145332" *.prg |cut -d : -f1 > RH19.1
grep -i "PAWP" *.prg |cut -d : -f1 > RH19.2
grep -i "PAWP" *.prg |cut -d : -f1 > RH19.3
grep -i "PAWP" *.prg |cut -d : -f1 > RH19.4
grep -i "PAWP" *.prg |cut -d : -f1 > RH19.5
grep -i "6201160" *.prg |cut -d : -f1 > RH20.1
grep -i "PVRI" *.prg |cut -d : -f1 > RH20.2
grep -i "PVRI" *.prg |cut -d : -f1 > RH20.3
grep -i "PVRI" *.prg |cut -d : -f1 > RH20.4
grep -i "PVRI" *.prg |cut -d : -f1 > RH20.5
grep -i "1993624594" *.prg |cut -d : -f1 > RH21.1
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH21.2
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH21.3
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH21.4
grep -i "PERFUSIONINDEXFOOT" *.prg |cut -d : -f1 > RH21.5
grep -i "100136688" *.prg |cut -d : -f1 > RH22.1
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH22.2
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH22.3
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH22.4
grep -i "POSTDUCTALO2SATURATION" *.prg |cut -d : -f1 > RH22.5
grep -i "100136685" *.prg |cut -d : -f1 > RH23.1
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH23.2
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH23.3
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH23.4
grep -i "PREDUCTALO2SATURATION" *.prg |cut -d : -f1 > RH23.5
grep -i "6201207" *.prg |cut -d : -f1 > RH24.1
grep -i "PvO2" *.prg |cut -d : -f1 > RH24.2
grep -i "PvO2" *.prg |cut -d : -f1 > RH24.3
grep -i "PvO2" *.prg |cut -d : -f1 > RH24.4
grep -i "PVO2" *.prg |cut -d : -f1 > RH24.5
grep -i "6201191" *.prg |cut -d : -f1 > RH25.1
grep -i "RSWI" *.prg |cut -d : -f1 > RH25.2
grep -i "RSWI" *.prg |cut -d : -f1 > RH25.3
grep -i "RSWI" *.prg |cut -d : -f1 > RH25.4
grep -i "RSWI" *.prg |cut -d : -f1 > RH25.5
grep -i "3056784" *.prg |cut -d : -f1 > RH26.1
grep -i "Recovery Heart Rate" *.prg |cut -d : -f1 > RH26.2
grep -i "Recovery Heart Rate" *.prg |cut -d : -f1 > RH26.3
grep -i "Recovery Heart Rate" *.prg |cut -d : -f1 > RH26.4
grep -i "RECOVERYHEARTRATE" *.prg |cut -d : -f1 > RH26.5
grep -i "3056775" *.prg |cut -d : -f1 > RH27.1
grep -i "Recovery O2 Saturation" *.prg |cut -d : -f1 > RH27.2
grep -i "Recovery O2 Saturation" *.prg |cut -d : -f1 > RH27.3
grep -i "Recovery O2 Saturation" *.prg |cut -d : -f1 > RH27.4
grep -i "RECOVERYO2SATURATION" *.prg |cut -d : -f1 > RH27.5
grep -i "3049550" *.prg |cut -d : -f1 > RH28.1
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH28.2
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH28.3
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH28.4
grep -i "RESPIRATORYRATE" *.prg |cut -d : -f1 > RH28.5
grep -i "3047191" *.prg |cut -d : -f1 > RH29.1
grep -i "SBP" *.prg |cut -d : -f1 > RH29.2
grep -i "SBP" *.prg |cut -d : -f1 > RH29.3
grep -i "SBP" *.prg |cut -d : -f1 > RH29.4
grep -i "SBP" *.prg |cut -d : -f1 > RH29.5
grep -i "3144807" *.prg |cut -d : -f1 > RH30.1
grep -i "SVO2" *.prg |cut -d : -f1 > RH30.2
grep -i "SVO2" *.prg |cut -d : -f1 > RH30.3
grep -i "SVO2" *.prg |cut -d : -f1 > RH30.4
grep -i "SVO2" *.prg |cut -d : -f1 > RH30.5
grep -i "3144498" *.prg |cut -d : -f1 > RH31.1
grep -i "SVR" *.prg |cut -d : -f1 > RH31.2
grep -i "SVR" *.prg |cut -d : -f1 > RH31.3
grep -i "SVR" *.prg |cut -d : -f1 > RH31.4
grep -i "SVR" *.prg |cut -d : -f1 > RH31.5
grep -i "3144502" *.prg |cut -d : -f1 > RH32.1
grep -i "SVRI" *.prg |cut -d : -f1 > RH32.2
grep -i "SVRI" *.prg |cut -d : -f1 > RH32.3
grep -i "SVRI" *.prg |cut -d : -f1 > RH32.4
grep -i "SVRI" *.prg |cut -d : -f1 > RH32.5
grep -i "122153480" *.prg |cut -d : -f1 > RH33.1
grep -i "ScvO2" *.prg |cut -d : -f1 > RH33.2
grep -i "ScvO2" *.prg |cut -d : -f1 > RH33.3
grep -i "ScvO2" *.prg |cut -d : -f1 > RH33.4
grep -i "SCVO2" *.prg |cut -d : -f1 > RH33.5
grep -i "434438022" *.prg |cut -d : -f1 > RH34.1
grep -i "Site Changed" *.prg |cut -d : -f1 > RH34.2
grep -i "Site Changed" *.prg |cut -d : -f1 > RH34.3
grep -i "Site Changed" *.prg |cut -d : -f1 > RH34.4
grep -i "SITECHANGED" *.prg |cut -d : -f1 > RH34.5
grep -i "1191411687" *.prg |cut -d : -f1 > RH35.1
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH35.2
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH35.3
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH35.4
grep -i "SOMATICOXIMETRY" *.prg |cut -d : -f1 > RH35.5
grep -i "3144495" *.prg |cut -d : -f1 > RH36.1
grep -i "Stroke Volume" *.prg |cut -d : -f1 > RH36.2
grep -i "Stroke Volume" *.prg |cut -d : -f1 > RH36.3
grep -i "Stroke Volume" *.prg |cut -d : -f1 > RH36.4
grep -i "STROKEVOLUME" *.prg |cut -d : -f1 > RH36.5
grep -i "237812059" *.prg |cut -d : -f1 > RH37.1
grep -i "Stroke Volume Variance" *.prg |cut -d : -f1 > RH37.2
grep -i "Stroke Volume Variance" *.prg |cut -d : -f1 > RH37.3
grep -i "Stroke Volume Variance" *.prg |cut -d : -f1 > RH37.4
grep -i "STROKEVOLUMEVARIANCE" *.prg |cut -d : -f1 > RH37.5
grep -i "3059679" *.prg |cut -d : -f1 > RH38.1
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH38.2
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH38.3
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH38.4
grep -i "SYSTOLICBLOODPRESSURE" *.prg |cut -d : -f1 > RH38.5
grep -i "3144901" *.prg |cut -d : -f1 > RH39.1
grep -i "Temp C" *.prg |cut -d : -f1 > RH39.2
grep -i "Temp C" *.prg |cut -d : -f1 > RH39.3
grep -i "Temp C" *.prg |cut -d : -f1 > RH39.4
grep -i "TEMPC" *.prg |cut -d : -f1 > RH39.5
grep -i "434436051" *.prg |cut -d : -f1 > RH40.1
grep -i "Transcutaneous Site Temp" *.prg |cut -d : -f1 > RH40.2
grep -i "Transcutaneous Site Temp" *.prg |cut -d : -f1 > RH40.3
grep -i "Transcutaneous Site Temp" *.prg |cut -d : -f1 > RH40.4
grep -i "TRANSCUTANEOUSSITETEMP" *.prg |cut -d : -f1 > RH40.5
grep -i "3144526" *.prg |cut -d : -f1 > RH41.1
grep -i "VO2" *.prg |cut -d : -f1 > RH41.2
grep -i "VO2" *.prg |cut -d : -f1 > RH41.3
grep -i "VO2" *.prg |cut -d : -f1 > RH41.4
grep -i "VO2" *.prg |cut -d : -f1 > RH41.5
grep -i "1993624379" *.prg |cut -d : -f1 > RH42.1
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH42.2
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH42.3
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH42.4
grep -i "WHICHTESTISBEINGPERFORMED" *.prg |cut -d : -f1 > RH42.5
grep -i "6201258" *.prg |cut -d : -f1 > RH43.1
grep -i "avDO2" *.prg |cut -d : -f1 > RH43.2
grep -i "avDO2" *.prg |cut -d : -f1 > RH43.3
grep -i "avDO2" *.prg |cut -d : -f1 > RH43.4
grep -i "AVDO2" *.prg |cut -d : -f1 > RH43.5
grep -i "17476881" *.prg |cut -d : -f1 > RH44.1
grep -i "CVO2" *.prg |cut -d : -f1 > RH44.2
grep -i "CVO2" *.prg |cut -d : -f1 > RH44.3
grep -i "CVO2" *.prg |cut -d : -f1 > RH44.4
grep -i "CVO2" *.prg |cut -d : -f1 > RH44.5
grep -i "17476861" *.prg |cut -d : -f1 > RH45.1
grep -i "CVP" *.prg |cut -d : -f1 > RH45.2
grep -i "CVP" *.prg |cut -d : -f1 > RH45.3
grep -i "CVP" *.prg |cut -d : -f1 > RH45.4
grep -i "CVP" *.prg |cut -d : -f1 > RH45.5
grep -i "17476879" *.prg |cut -d : -f1 > RH46.1
grep -i "CAO2" *.prg |cut -d : -f1 > RH46.2
grep -i "CAO2" *.prg |cut -d : -f1 > RH46.3
grep -i "CaO2" *.prg |cut -d : -f1 > RH46.4
grep -i "CAO2" *.prg |cut -d : -f1 > RH46.5
grep -i "1961361981" *.prg |cut -d : -f1 > RH47.1
grep -i "Cardiac Index - Anesthesia" *.prg |cut -d : -f1 > RH47.2
grep -i "Cardiac Index - Anesthesia" *.prg |cut -d : -f1 > RH47.3
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH47.4
grep -i "CARDIACINDEX" *.prg |cut -d : -f1 > RH47.5
grep -i "17476869" *.prg |cut -d : -f1 > RH48.1
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH48.2
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH48.3
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH48.4
grep -i "CARDIACINDEX" *.prg |cut -d : -f1 > RH48.5
grep -i "1961361229" *.prg |cut -d : -f1 > RH49.1
grep -i "Cardiac Output - Anesthesia" *.prg |cut -d : -f1 > RH49.2
grep -i "Cardiac Output - Anesthesia" *.prg |cut -d : -f1 > RH49.3
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH49.4
grep -i "CARDIACOUTPUT" *.prg |cut -d : -f1 > RH49.5
grep -i "17476868" *.prg |cut -d : -f1 > RH50.1
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH50.2
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH50.3
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH50.4
grep -i "CARDIACOUTPUT" *.prg |cut -d : -f1 > RH50.5
grep -i "1961450770" *.prg |cut -d : -f1 > RH51.1
grep -i "Cerebral Oximetry - Anesthesia" *.prg |cut -d : -f1 > RH51.2
grep -i "Cerebral Oximetry - Anesthesia" *.prg |cut -d : -f1 > RH51.3
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH51.4
grep -i "CEREBRALOXIMETRY" *.prg |cut -d : -f1 > RH51.5
grep -i "1252247752" *.prg |cut -d : -f1 > RH52.1
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH52.2
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH52.3
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH52.4
grep -i "CEREBRALOXIMETRY" *.prg |cut -d : -f1 > RH52.5
grep -i "17476882" *.prg |cut -d : -f1 > RH53.1
grep -i "DO2" *.prg |cut -d : -f1 > RH53.2
grep -i "DO2" *.prg |cut -d : -f1 > RH53.3
grep -i "DO2" *.prg |cut -d : -f1 > RH53.4
grep -i "DO2" *.prg |cut -d : -f1 > RH53.5
grep -i "17473337" *.prg |cut -d : -f1 > RH54.1
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH54.2
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH54.3
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH54.4
grep -i "DIASTOLICBLOODPRESSURE" *.prg |cut -d : -f1 > RH54.5
grep -i "250770447" *.prg |cut -d : -f1 > RH55.1
grep -i "Peds ET CO2" *.prg |cut -d : -f1 > RH55.2
grep -i "Peds ET CO2" *.prg |cut -d : -f1 > RH55.3
grep -i "ET CO2" *.prg |cut -d : -f1 > RH55.4
grep -i "ETCO2" *.prg |cut -d : -f1 > RH55.5
grep -i "1533668540" *.prg |cut -d : -f1 > RH56.1
grep -i "EWS Score" *.prg |cut -d : -f1 > RH56.2
grep -i "EWS Score" *.prg |cut -d : -f1 > RH56.3
grep -i "EWS Score" *.prg |cut -d : -f1 > RH56.4
grep -i "EWSSCORE" *.prg |cut -d : -f1 > RH56.5
grep -i "17473330" *.prg |cut -d : -f1 > RH57.1
grep -i "HR Site" *.prg |cut -d : -f1 > RH57.2
grep -i "HR Site" *.prg |cut -d : -f1 > RH57.3
grep -i "HR Site" *.prg |cut -d : -f1 > RH57.4
grep -i "HRSITE" *.prg |cut -d : -f1 > RH57.5
grep -i "1961262755" *.prg |cut -d : -f1 > RH58.1
grep -i "Heart Rate - Anesthesia" *.prg |cut -d : -f1 > RH58.2
grep -i "Heart Rate - Anesthesia" *.prg |cut -d : -f1 > RH58.3
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH58.4
grep -i "HEARTRATE" *.prg |cut -d : -f1 > RH58.5
grep -i "17473329" *.prg |cut -d : -f1 > RH59.1
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH59.2
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH59.3
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH59.4
grep -i "HEARTRATE" *.prg |cut -d : -f1 > RH59.5
grep -i "284968990" *.prg |cut -d : -f1 > RH60.1
grep -i "Apnea/Bradycardia Heart Rate" *.prg |cut -d : -f1 > RH60.2
grep -i "Apnea/Bradycardia Heart Rate" *.prg |cut -d : -f1 > RH60.3
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH60.4
grep -i "HEARTRATE" *.prg |cut -d : -f1 > RH60.5
grep -i "17476875" *.prg |cut -d : -f1 > RH61.1
grep -i "LSWI" *.prg |cut -d : -f1 > RH61.2
grep -i "LSWI" *.prg |cut -d : -f1 > RH61.3
grep -i "LVSWI" *.prg |cut -d : -f1 > RH61.4
grep -i "LVSWI" *.prg |cut -d : -f1 > RH61.5
grep -i "17476865" *.prg |cut -d : -f1 > RH62.1
grep -i "MPAP" *.prg |cut -d : -f1 > RH62.2
grep -i "MPAP" *.prg |cut -d : -f1 > RH62.3
grep -i "MPAP" *.prg |cut -d : -f1 > RH62.4
grep -i "MPAP" *.prg |cut -d : -f1 > RH62.5
grep -i "17473332" *.prg |cut -d : -f1 > RH63.1
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH63.2
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH63.3
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH63.4
grep -i "O2SATURATION" *.prg |cut -d : -f1 > RH63.5
grep -i "17476886" *.prg |cut -d : -f1 > RH64.1
grep -i "O2ER" *.prg |cut -d : -f1 > RH64.2
grep -i "O2ER" *.prg |cut -d : -f1 > RH64.3
grep -i "O2ER" *.prg |cut -d : -f1 > RH64.4
grep -i "O2ER" *.prg |cut -d : -f1 > RH64.5
grep -i "17476864" *.prg |cut -d : -f1 > RH65.1
grep -i "PA DBP" *.prg |cut -d : -f1 > RH65.2
grep -i "PA DBP" *.prg |cut -d : -f1 > RH65.3
grep -i "PA DBP" *.prg |cut -d : -f1 > RH65.4
grep -i "PADBP" *.prg |cut -d : -f1 > RH65.5
grep -i "17476863" *.prg |cut -d : -f1 > RH66.1
grep -i "PA SBP" *.prg |cut -d : -f1 > RH66.2
grep -i "PA SBP" *.prg |cut -d : -f1 > RH66.3
grep -i "PA SBP" *.prg |cut -d : -f1 > RH66.4
grep -i "PASBP" *.prg |cut -d : -f1 > RH66.5
grep -i "17476866" *.prg |cut -d : -f1 > RH67.1
grep -i "PAWP" *.prg |cut -d : -f1 > RH67.2
grep -i "PAWP" *.prg |cut -d : -f1 > RH67.3
grep -i "PAWP" *.prg |cut -d : -f1 > RH67.4
grep -i "PAWP" *.prg |cut -d : -f1 > RH67.5
grep -i "17476872" *.prg |cut -d : -f1 > RH68.1
grep -i "PVRI" *.prg |cut -d : -f1 > RH68.2
grep -i "PVRI" *.prg |cut -d : -f1 > RH68.3
grep -i "PVRI" *.prg |cut -d : -f1 > RH68.4
grep -i "PVRI" *.prg |cut -d : -f1 > RH68.5
grep -i "17476878" *.prg |cut -d : -f1 > RH69.1
grep -i "PAO2" *.prg |cut -d : -f1 > RH69.2
grep -i "PAO2" *.prg |cut -d : -f1 > RH69.3
grep -i "PaO2" *.prg |cut -d : -f1 > RH69.4
grep -i "PAO2" *.prg |cut -d : -f1 > RH69.5
grep -i "2001568867" *.prg |cut -d : -f1 > RH70.1
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH70.2
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH70.3
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH70.4
grep -i "PERFUSIONINDEXFOOT" *.prg |cut -d : -f1 > RH70.5
grep -i "100255534" *.prg |cut -d : -f1 > RH71.1
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH71.2
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH71.3
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH71.4
grep -i "POSTDUCTALO2SATURATION" *.prg |cut -d : -f1 > RH71.5
grep -i "100255533" *.prg |cut -d : -f1 > RH72.1
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH72.2
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH72.3
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH72.4
grep -i "PREDUCTALO2SATURATION" *.prg |cut -d : -f1 > RH72.5
grep -i "100255612" *.prg |cut -d : -f1 > RH73.1
grep -i "Peds Pulse Ox Site" *.prg |cut -d : -f1 > RH73.2
grep -i "Peds Pulse Ox Site" *.prg |cut -d : -f1 > RH73.3
grep -i "Pulse Ox Site" *.prg |cut -d : -f1 > RH73.4
grep -i "PULSEOXSITE" *.prg |cut -d : -f1 > RH73.5
grep -i "17476880" *.prg |cut -d : -f1 > RH74.1
grep -i "PvO2" *.prg |cut -d : -f1 > RH74.2
grep -i "PvO2" *.prg |cut -d : -f1 > RH74.3
grep -i "PvO2" *.prg |cut -d : -f1 > RH74.4
grep -i "PVO2" *.prg |cut -d : -f1 > RH74.5
grep -i "17476887" *.prg |cut -d : -f1 > RH75.1
grep -i "QS/QT" *.prg |cut -d : -f1 > RH75.2
grep -i "QS/QT" *.prg |cut -d : -f1 > RH75.3
grep -i "QS/QT" *.prg |cut -d : -f1 > RH75.4
grep -i "QSQT" *.prg |cut -d : -f1 > RH75.5
grep -i "1961370022" *.prg |cut -d : -f1 > RH76.1
grep -i "Respiratory Rate Anesthesia" *.prg |cut -d : -f1 > RH76.2
grep -i "Respiratory Rate Anesthesia" *.prg |cut -d : -f1 > RH76.3
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH76.4
grep -i "RESPIRATORYRATE" *.prg |cut -d : -f1 > RH76.5
grep -i "17473331" *.prg |cut -d : -f1 > RH77.1
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH77.2
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH77.3
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH77.4
grep -i "RESPIRATORYRATE" *.prg |cut -d : -f1 > RH77.5
grep -i "17476888" *.prg |cut -d : -f1 > RH78.1
grep -i "SVO2" *.prg |cut -d : -f1 > RH78.2
grep -i "SVO2" *.prg |cut -d : -f1 > RH78.3
grep -i "SVO2" *.prg |cut -d : -f1 > RH78.4
grep -i "SVO2" *.prg |cut -d : -f1 > RH78.5
grep -i "17476870" *.prg |cut -d : -f1 > RH79.1
grep -i "SVR" *.prg |cut -d : -f1 > RH79.2
grep -i "SVR" *.prg |cut -d : -f1 > RH79.3
grep -i "SVR" *.prg |cut -d : -f1 > RH79.4
grep -i "SVR" *.prg |cut -d : -f1 > RH79.5
grep -i "17476871" *.prg |cut -d : -f1 > RH80.1
grep -i "SVRI" *.prg |cut -d : -f1 > RH80.2
grep -i "SVRI" *.prg |cut -d : -f1 > RH80.3
grep -i "SVRI" *.prg |cut -d : -f1 > RH80.4
grep -i "SVRI" *.prg |cut -d : -f1 > RH80.5
grep -i "122156673" *.prg |cut -d : -f1 > RH81.1
grep -i "ScvO2" *.prg |cut -d : -f1 > RH81.2
grep -i "ScvO2" *.prg |cut -d : -f1 > RH81.3
grep -i "ScvO2" *.prg |cut -d : -f1 > RH81.4
grep -i "SCVO2" *.prg |cut -d : -f1 > RH81.5
grep -i "1252247753" *.prg |cut -d : -f1 > RH82.1
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH82.2
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH82.3
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH82.4
grep -i "SOMATICOXIMETRY" *.prg |cut -d : -f1 > RH82.5
grep -i "17473336" *.prg |cut -d : -f1 > RH83.1
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH83.2
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH83.3
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH83.4
grep -i "SYSTOLICBLOODPRESSURE" *.prg |cut -d : -f1 > RH83.5
grep -i "17473326" *.prg |cut -d : -f1 > RH84.1
grep -i "Temp C" *.prg |cut -d : -f1 > RH84.2
grep -i "Temp C" *.prg |cut -d : -f1 > RH84.3
grep -i "Temp C" *.prg |cut -d : -f1 > RH84.4
grep -i "TEMPC" *.prg |cut -d : -f1 > RH84.5
grep -i "17476884" *.prg |cut -d : -f1 > RH85.1
grep -i "VO2" *.prg |cut -d : -f1 > RH85.2
grep -i "VO2" *.prg |cut -d : -f1 > RH85.3
grep -i "VO2" *.prg |cut -d : -f1 > RH85.4
grep -i "VO2" *.prg |cut -d : -f1 > RH85.5
grep -i "17473353" *.prg |cut -d : -f1 > RH86.1
grep -i "Vitals/Measurement Additional Comment" *.prg |cut -d : -f1 > RH86.2
grep -i "Vitals/Measurement Additional Comment" *.prg |cut -d : -f1 > RH86.3
grep -i "Vital Signs Comment" *.prg |cut -d : -f1 > RH86.4
grep -i "VITALSIGNSCOMMENT" *.prg |cut -d : -f1 > RH86.5
grep -i "2001568865" *.prg |cut -d : -f1 > RH87.1
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH87.2
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH87.3
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH87.4
grep -i "WHICHTESTISBEINGPERFORMED" *.prg |cut -d : -f1 > RH87.5
grep -i "17476883" *.prg |cut -d : -f1 > RH88.1
grep -i "O2AVI" *.prg |cut -d : -f1 > RH88.2
grep -i "O2AVI" *.prg |cut -d : -f1 > RH88.3
grep -i "avDO2" *.prg |cut -d : -f1 > RH88.4
grep -i "AVDO2" *.prg |cut -d : -f1 > RH88.5
grep -i "3145188" *.prg |cut -d : -f1 > RH89.1
grep -i "CVP" *.prg |cut -d : -f1 > RH89.2
grep -i "CVP" *.prg |cut -d : -f1 > RH89.3
grep -i "CVP" *.prg |cut -d : -f1 > RH89.4
grep -i "CVP" *.prg |cut -d : -f1 > RH89.5
grep -i "3144515" *.prg |cut -d : -f1 > RH90.1
grep -i "CaO2" *.prg |cut -d : -f1 > RH90.2
grep -i "CaO2" *.prg |cut -d : -f1 > RH90.3
grep -i "CaO2" *.prg |cut -d : -f1 > RH90.4
grep -i "CAO2" *.prg |cut -d : -f1 > RH90.5
grep -i "434437405" *.prg |cut -d : -f1 > RH91.1
grep -i "Calibrated" *.prg |cut -d : -f1 > RH91.2
grep -i "Calibrated" *.prg |cut -d : -f1 > RH91.3
grep -i "Calibrated" *.prg |cut -d : -f1 > RH91.4
grep -i "CALIBRATED" *.prg |cut -d : -f1 > RH91.5
grep -i "3144487" *.prg |cut -d : -f1 > RH92.1
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH92.2
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH92.3
grep -i "Cardiac Index" *.prg |cut -d : -f1 > RH92.4
grep -i "CARDIACINDEX" *.prg |cut -d : -f1 > RH92.5
grep -i "3144333" *.prg |cut -d : -f1 > RH93.1
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH93.2
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH93.3
grep -i "Cardiac Output" *.prg |cut -d : -f1 > RH93.4
grep -i "CARDIAC OUTPUT" *.prg |cut -d : -f1 > RH93.5
grep -i "1191411628" *.prg |cut -d : -f1 > RH94.1
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH94.2
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH94.3
grep -i "Cerebral Oximetry" *.prg |cut -d : -f1 > RH94.4
grep -i "CEREBRALOXIMETRY" *.prg |cut -d : -f1 > RH94.5
grep -i "3144521" *.prg |cut -d : -f1 > RH95.1
grep -i "DO2" *.prg |cut -d : -f1 > RH95.2
grep -i "DO2" *.prg |cut -d : -f1 > RH95.3
grep -i "DO2" *.prg |cut -d : -f1 > RH95.4
grep -i "DO2" *.prg |cut -d : -f1 > RH95.5
grep -i "3053551" *.prg |cut -d : -f1 > RH96.1
grep -i "Diastolic BP sitting" *.prg |cut -d : -f1 > RH96.2
grep -i "Diastolic BP sitting" *.prg |cut -d : -f1 > RH96.3
grep -i "Diastolic BP sitting" *.prg |cut -d : -f1 > RH96.4
grep -i "DIASTOLICBPSITTING" *.prg |cut -d : -f1 > RH96.5
grep -i "3053564" *.prg |cut -d : -f1 > RH97.1
grep -i "Diastolic BP standing" *.prg |cut -d : -f1 > RH97.2
grep -i "Diastolic BP standing" *.prg |cut -d : -f1 > RH97.3
grep -i "Diastolic BP standing" *.prg |cut -d : -f1 > RH97.4
grep -i "DIASTOLICBPSTANDING" *.prg |cut -d : -f1 > RH97.5
grep -i "3053541" *.prg |cut -d : -f1 > RH98.1
grep -i "Diastolic BP supine" *.prg |cut -d : -f1 > RH98.2
grep -i "Diastolic BP supine" *.prg |cut -d : -f1 > RH98.3
grep -i "Diastolic BP supine" *.prg |cut -d : -f1 > RH98.4
grep -i "DIASTOLICBPSUPINE" *.prg |cut -d : -f1 > RH98.5
grep -i "3059690" *.prg |cut -d : -f1 > RH99.1
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH99.2
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH99.3
grep -i "Diastolic Blood Pressure" *.prg |cut -d : -f1 > RH99.4
grep -i "DIASTOLICBLOODPRESSURE" *.prg |cut -d : -f1 > RH99.5
grep -i "1486606713" *.prg |cut -d : -f1 > RH100.1
grep -i "EWS CNS Level of Consciousness" *.prg |cut -d : -f1 > RH100.2
grep -i "EWS CNS Level of Consciousness" *.prg |cut -d : -f1 > RH100.3
grep -i "EWS CNS Level of Consciousness" *.prg |cut -d : -f1 > RH100.4
grep -i "EWSCNSLEVELOFCONSCIOUSNESS" *.prg |cut -d : -f1 > RH100.5
grep -i "1527287586" *.prg |cut -d : -f1 > RH101.1
grep -i "EWS Score" *.prg |cut -d : -f1 > RH101.2
grep -i "EWS Score" *.prg |cut -d : -f1 > RH101.3
grep -i "EWS Score" *.prg |cut -d : -f1 > RH101.4
grep -i "EWSSCORE" *.prg |cut -d : -f1 > RH101.5
grep -i "3049511" *.prg |cut -d : -f1 > RH102.1
grep -i "HR Site" *.prg |cut -d : -f1 > RH102.2
grep -i "HR Site" *.prg |cut -d : -f1 > RH102.3
grep -i "HR Site" *.prg |cut -d : -f1 > RH102.4
grep -i "HRSITE" *.prg |cut -d : -f1 > RH102.5
grep -i "3049478" *.prg |cut -d : -f1 > RH103.1
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH103.2
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH103.3
grep -i "Heart Rate" *.prg |cut -d : -f1 > RH103.4
grep -i "HEARTRATE" *.prg |cut -d : -f1 > RH103.5
grep -i "3077827" *.prg |cut -d : -f1 > RH104.1
grep -i "Heart Rate- Sitting" *.prg |cut -d : -f1 > RH104.2
grep -i "Heart Rate- Sitting" *.prg |cut -d : -f1 > RH104.3
grep -i "Heart Rate- Sitting" *.prg |cut -d : -f1 > RH104.4
grep -i "HEARTRATESITTING" *.prg |cut -d : -f1 > RH104.5
grep -i "3077840" *.prg |cut -d : -f1 > RH105.1
grep -i "Heart Rate- Standing" *.prg |cut -d : -f1 > RH105.2
grep -i "Heart Rate- Standing" *.prg |cut -d : -f1 > RH105.3
grep -i "Heart Rate- Standing" *.prg |cut -d : -f1 > RH105.4
grep -i "HEARTRATESTANDING" *.prg |cut -d : -f1 > RH105.5
grep -i "3077838" *.prg |cut -d : -f1 > RH106.1
grep -i "Heart Rate- Supine" *.prg |cut -d : -f1 > RH106.2
grep -i "Heart Rate- Supine" *.prg |cut -d : -f1 > RH106.3
grep -i "Heart Rate- Supine" *.prg |cut -d : -f1 > RH106.4
grep -i "HEARTRATESUPINE" *.prg |cut -d : -f1 > RH106.5
grep -i "3145330" *.prg |cut -d : -f1 > RH107.1
grep -i "MPAP" *.prg |cut -d : -f1 > RH107.2
grep -i "MPAP" *.prg |cut -d : -f1 > RH107.3
grep -i "MPAP" *.prg |cut -d : -f1 > RH107.4
grep -i "MPAP" *.prg |cut -d : -f1 > RH107.5
grep -i "3053469" *.prg |cut -d : -f1 > RH108.1
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH108.2
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH108.3
grep -i "O2 Saturation" *.prg |cut -d : -f1 > RH108.4
grep -i "O2SATURATION" *.prg |cut -d : -f1 > RH108.5
grep -i "3144719" *.prg |cut -d : -f1 > RH109.1
grep -i "O2ER" *.prg |cut -d : -f1 > RH109.2
grep -i "O2ER" *.prg |cut -d : -f1 > RH109.3
grep -i "O2ER" *.prg |cut -d : -f1 > RH109.4
grep -i "O2ER" *.prg |cut -d : -f1 > RH109.5
grep -i "3145327" *.prg |cut -d : -f1 > RH110.1
grep -i "PA DBP" *.prg |cut -d : -f1 > RH110.2
grep -i "PA DBP" *.prg |cut -d : -f1 > RH110.3
grep -i "PA DBP" *.prg |cut -d : -f1 > RH110.4
grep -i "PADBP" *.prg |cut -d : -f1 > RH110.5
grep -i "3145192" *.prg |cut -d : -f1 > RH111.1
grep -i "PA SBP" *.prg |cut -d : -f1 > RH111.2
grep -i "PA SBP" *.prg |cut -d : -f1 > RH111.3
grep -i "PA SBP" *.prg |cut -d : -f1 > RH111.4
grep -i "PASBP" *.prg |cut -d : -f1 > RH111.5
grep -i "3145333" *.prg |cut -d : -f1 > RH112.1
grep -i "PAWP" *.prg |cut -d : -f1 > RH112.2
grep -i "PAWP" *.prg |cut -d : -f1 > RH112.3
grep -i "PAWP" *.prg |cut -d : -f1 > RH112.4
grep -i "PAWP" *.prg |cut -d : -f1 > RH112.5
grep -i "6201159" *.prg |cut -d : -f1 > RH113.1
grep -i "PVRI" *.prg |cut -d : -f1 > RH113.2
grep -i "PVRI" *.prg |cut -d : -f1 > RH113.3
grep -i "PVRI" *.prg |cut -d : -f1 > RH113.4
grep -i "PVRI" *.prg |cut -d : -f1 > RH113.5
grep -i "1993624601" *.prg |cut -d : -f1 > RH114.1
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH114.2
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH114.3
grep -i "Perfusion Index (Foot)" *.prg |cut -d : -f1 > RH114.4
grep -i "PERFUSIONINDEXFOOT" *.prg |cut -d : -f1 > RH114.5
grep -i "100136689" *.prg |cut -d : -f1 > RH115.1
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH115.2
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH115.3
grep -i "Post Ductal O2 Saturation" *.prg |cut -d : -f1 > RH115.4
grep -i "POSTDUCTALO2SATURATION" *.prg |cut -d : -f1 > RH115.5
grep -i "100136686" *.prg |cut -d : -f1 > RH116.1
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH116.2
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH116.3
grep -i "Pre Ductal O2 Saturation" *.prg |cut -d : -f1 > RH116.4
grep -i "PREDUCTALO2SATURATION" *.prg |cut -d : -f1 > RH116.5
grep -i "6201206" *.prg |cut -d : -f1 > RH117.1
grep -i "PvO2" *.prg |cut -d : -f1 > RH117.2
grep -i "PvO2" *.prg |cut -d : -f1 > RH117.3
grep -i "PvO2" *.prg |cut -d : -f1 > RH117.4
grep -i "PVO2" *.prg |cut -d : -f1 > RH117.5
grep -i "6201190" *.prg |cut -d : -f1 > RH118.1
grep -i "RSWI" *.prg |cut -d : -f1 > RH118.2
grep -i "RSWI" *.prg |cut -d : -f1 > RH118.3
grep -i "RSWI" *.prg |cut -d : -f1 > RH118.4
grep -i "RSWI" *.prg |cut -d : -f1 > RH118.5
grep -i "3056786" *.prg |cut -d : -f1 > RH119.1
grep -i "Recovery Heart Rate" *.prg |cut -d : -f1 > RH119.2
grep -i "Recovery Heart Rate" *.prg |cut -d : -f1 > RH119.3
grep -i "Recovery Heart Rate" *.prg |cut -d : -f1 > RH119.4
grep -i "RECOVERY HEART RATE" *.prg |cut -d : -f1 > RH119.5
grep -i "3056776" *.prg |cut -d : -f1 > RH120.1
grep -i "Recovery O2 Saturation" *.prg |cut -d : -f1 > RH120.2
grep -i "Recovery O2 Saturation" *.prg |cut -d : -f1 > RH120.3
grep -i "Recovery O2 Saturation" *.prg |cut -d : -f1 > RH120.4
grep -i "RECOVERYO2SATURATION" *.prg |cut -d : -f1 > RH120.5
grep -i "3049556" *.prg |cut -d : -f1 > RH121.1
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH121.2
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH121.3
grep -i "Respiratory Rate" *.prg |cut -d : -f1 > RH121.4
grep -i "RESPIRATORYRATE" *.prg |cut -d : -f1 > RH121.5
grep -i "3144808" *.prg |cut -d : -f1 > RH122.1
grep -i "SVO2" *.prg |cut -d : -f1 > RH122.2
grep -i "SVO2" *.prg |cut -d : -f1 > RH122.3
grep -i "SVO2" *.prg |cut -d : -f1 > RH122.4
grep -i "SVO2" *.prg |cut -d : -f1 > RH122.5
grep -i "3144499" *.prg |cut -d : -f1 > RH123.1
grep -i "SVR" *.prg |cut -d : -f1 > RH123.2
grep -i "SVR" *.prg |cut -d : -f1 > RH123.3
grep -i "SVR" *.prg |cut -d : -f1 > RH123.4
grep -i "SVR" *.prg |cut -d : -f1 > RH123.5
grep -i "3144503" *.prg |cut -d : -f1 > RH124.1
grep -i "SVRI" *.prg |cut -d : -f1 > RH124.2
grep -i "SVRI" *.prg |cut -d : -f1 > RH124.3
grep -i "SVRI" *.prg |cut -d : -f1 > RH124.4
grep -i "SVRI" *.prg |cut -d : -f1 > RH124.5
grep -i "208178284" *.prg |cut -d : -f1 > RH125.1
grep -i "ScvO2" *.prg |cut -d : -f1 > RH125.2
grep -i "ScvO2" *.prg |cut -d : -f1 > RH125.3
grep -i "ScvO2" *.prg |cut -d : -f1 > RH125.4
grep -i "SCVO2" *.prg |cut -d : -f1 > RH125.5
grep -i "434438036" *.prg |cut -d : -f1 > RH126.1
grep -i "Site Changed" *.prg |cut -d : -f1 > RH126.2
grep -i "Site Changed" *.prg |cut -d : -f1 > RH126.3
grep -i "Site Changed" *.prg |cut -d : -f1 > RH126.4
grep -i "SITECHANGED" *.prg |cut -d : -f1 > RH126.5
grep -i "1191411698" *.prg |cut -d : -f1 > RH127.1
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH127.2
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH127.3
grep -i "Somatic Oximetry" *.prg |cut -d : -f1 > RH127.4
grep -i "SOMATICOXIMETRY" *.prg |cut -d : -f1 > RH127.5
grep -i "3144496" *.prg |cut -d : -f1 > RH128.1
grep -i "Stroke Volume" *.prg |cut -d : -f1 > RH128.2
grep -i "Stroke Volume" *.prg |cut -d : -f1 > RH128.3
grep -i "Stroke Volume" *.prg |cut -d : -f1 > RH128.4
grep -i "STROKEVOLUME" *.prg |cut -d : -f1 > RH128.5
grep -i "236794669" *.prg |cut -d : -f1 > RH129.1
grep -i "Stroke Volume Variance" *.prg |cut -d : -f1 > RH129.2
grep -i "Stroke Volume Variance" *.prg |cut -d : -f1 > RH129.3
grep -i "Stroke Volume Variance" *.prg |cut -d : -f1 > RH129.4
grep -i "STROKEVOLUMEVARIANCE" *.prg |cut -d : -f1 > RH129.5
grep -i "3053545" *.prg |cut -d : -f1 > RH130.1
grep -i "Systolic BP sitting" *.prg |cut -d : -f1 > RH130.2
grep -i "Systolic BP sitting" *.prg |cut -d : -f1 > RH130.3
grep -i "Systolic BP sitting" *.prg |cut -d : -f1 > RH130.4
grep -i "SYSTOLICBPSITTING" *.prg |cut -d : -f1 > RH130.5
grep -i "3053556" *.prg |cut -d : -f1 > RH131.1
grep -i "Systolic BP standing" *.prg |cut -d : -f1 > RH131.2
grep -i "Systolic BP standing" *.prg |cut -d : -f1 > RH131.3
grep -i "Systolic BP standing" *.prg |cut -d : -f1 > RH131.4
grep -i "SYSTOLICBPSTANDING" *.prg |cut -d : -f1 > RH131.5
grep -i "3053533" *.prg |cut -d : -f1 > RH132.1
grep -i "Systolic BP supine" *.prg |cut -d : -f1 > RH132.2
grep -i "Systolic BP supine" *.prg |cut -d : -f1 > RH132.3
grep -i "Systolic BP supine" *.prg |cut -d : -f1 > RH132.4
grep -i "SYSTOLICBPSUPINE" *.prg |cut -d : -f1 > RH132.5
grep -i "3059680" *.prg |cut -d : -f1 > RH133.1
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH133.2
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH133.3
grep -i "Systolic Blood Pressure" *.prg |cut -d : -f1 > RH133.4
grep -i "SYSTOLICBLOODPRESSURE" *.prg |cut -d : -f1 > RH133.5
grep -i "3144902" *.prg |cut -d : -f1 > RH134.1
grep -i "Temp C" *.prg |cut -d : -f1 > RH134.2
grep -i "Temp C" *.prg |cut -d : -f1 > RH134.3
grep -i "Temp C" *.prg |cut -d : -f1 > RH134.4
grep -i "TEMPC" *.prg |cut -d : -f1 > RH134.5
grep -i "434436104" *.prg |cut -d : -f1 > RH135.1
grep -i "Transcutaneous Site Temp" *.prg |cut -d : -f1 > RH135.2
grep -i "Transcutaneous Site Temp" *.prg |cut -d : -f1 > RH135.3
grep -i "Transcutaneous Site Temp" *.prg |cut -d : -f1 > RH135.4
grep -i "TRANSCUTANEOUSSITETEMP" *.prg |cut -d : -f1 > RH135.5
grep -i "3144527" *.prg |cut -d : -f1 > RH136.1
grep -i "VO2" *.prg |cut -d : -f1 > RH136.2
grep -i "VO2" *.prg |cut -d : -f1 > RH136.3
grep -i "VO2" *.prg |cut -d : -f1 > RH136.4
grep -i "VO2" *.prg |cut -d : -f1 > RH136.5
grep -i "1993624405" *.prg |cut -d : -f1 > RH137.1
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH137.2
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH137.3
grep -i "Which Test is Being Performed" *.prg |cut -d : -f1 > RH137.4
grep -i "WHICHTESTISBEINGPERFORMED" *.prg |cut -d : -f1 > RH137.5
grep -i "6201257" *.prg |cut -d : -f1 > RH138.1
grep -i "avDO2" *.prg |cut -d : -f1 > RH138.2
grep -i "avDO2" *.prg |cut -d : -f1 > RH138.3
grep -i "avDO2" *.prg |cut -d : -f1 > RH138.4
grep -i "AVDO2" *.prg |cut -d : -f1 > RH138.5
