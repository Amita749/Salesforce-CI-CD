@IsTest
public class JobDivaWrapperTest {
	
	// This test method should give 100% coverage
	static testMethod void testParse() {
		String json = '{'+
		'    \"message\": \"Query \\\"New/Updated Job Records\\\" completed successfully\",'+
		'    \"data\": ['+
		'        {'+
		'            \"JOBID\": \"18631853\",'+
		'            \"JOBDIVANO\": \"23-00001\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00001\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1424308\",'+
		'            \"PRIMARYSALESID\": \"1424308\",'+
		'            \"COMPANYID\": \"7354762\",'+
		'            \"USERID\": \"1424308\",'+
		'            \"COMPANYNAME\": \"K&B Global Consulting\",'+
		'            \"PRIMARYOWNERID\": \"1504079\",'+
		'            \"CONTACTID\": \"21460747\",'+
		'            \"CONTACTFIRSTNAME\": \"Merrick\",'+
		'            \"CONTACTLASTNAME\": \"Bernstein\",'+
		'            \"ISSUEDATE\": \"2023-01-03T14:05:48\",'+
		'            \"DATEUPDATED\": \"2023-01-03T14:08:18\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-05T00:00:00\",'+
		'            \"ENDDATE\": \"2023-01-19T00:00:00\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"FILLED\",'+
		'            \"TITLE\": \"SAP FI CO Assessment\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"1\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"1020 Homer St\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Durham\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27707\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Normal\",'+
		'            \"BILLRATEMIN\": \"140\",'+
		'            \"BILLRATEMAX\": \"140\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"0\",'+
		'            \"REMOTE_PERCENTAGE\": \"0\",'+
		'            \"DATESTATUSUPDATED\": \"2023-01-03T14:08:18\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18643440\",'+
		'            \"JOBDIVANO\": \"23-00002\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00002\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1460565\",'+
		'            \"PRIMARYSALESID\": \"1524454\",'+
		'            \"COMPANYID\": \"3198005\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"COMPANYNAME\": \"Computer Aid Inc\",'+
		'            \"PRIMARYOWNERID\": \"1178386\",'+
		'            \"CONTACTID\": \"16933794\",'+
		'            \"CONTACTFIRSTNAME\": \"Nicole\",'+
		'            \"CONTACTLASTNAME\": \"Walker\",'+
		'            \"ISSUEDATE\": \"2023-01-05T08:28:44\",'+
		'            \"DATEUPDATED\": \"2023-02-15T20:57:07\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-05T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"CANCELLED\",'+
		'            \"TITLE\": \"IT Manager - Catalyst Data Team\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"Wake Forest Rd\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Raleigh\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27604\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"100\",'+
		'            \"BILLRATEMAX\": \"104\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"0\",'+
		'            \"REMOTE_PERCENTAGE\": \"0\",'+
		'            \"DATESTATUSUPDATED\": \"2023-02-15T20:57:02\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18649995\",'+
		'            \"JOBDIVANO\": \"23-00003\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00003\",'+
		'            \"DIVISIONID\": \"255123\",'+
		'            \"DIVISIONNAME\": \"US Sales\",'+
		'            \"PRIMARYRECRUITERID\": \"1481220\",'+
		'            \"PRIMARYSALESID\": \"1426169\",'+
		'            \"COMPANYID\": \"6916021\",'+
		'            \"USERID\": \"1426169\",'+
		'            \"COMPANYNAME\": \"Palo Alto Networks\",'+
		'            \"PRIMARYOWNERID\": \"1426169\",'+
		'            \"CONTACTID\": \"31143193\",'+
		'            \"CONTACTFIRSTNAME\": \"Yuva\",'+
		'            \"CONTACTLASTNAME\": \"Devarajan\",'+
		'            \"ISSUEDATE\": \"2023-01-05T21:40:13\",'+
		'            \"DATEUPDATED\": \"2023-01-23T17:30:49\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-16T00:00:00\",'+
		'            \"ENDDATE\": \"2023-12-29T00:00:00\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"FILLED\",'+
		'            \"TITLE\": \"SAP SAC Consultant (India) New Role\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"1\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"3000 Tannery Way,\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Santa Clara\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"95054\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"30\",'+
		'            \"BILLRATEMAX\": \"30\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"0\",'+
		'            \"REMOTE_PERCENTAGE\": \"0\",'+
		'            \"DATESTATUSUPDATED\": \"2023-01-23T17:30:49\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18668651\",'+
		'            \"JOBDIVANO\": \"23-00004\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00004\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1460565\",'+
		'            \"PRIMARYSALESID\": \"1524454\",'+
		'            \"COMPANYID\": \"9269606\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"COMPANYNAME\": \"Pager Duty\",'+
		'            \"PRIMARYOWNERID\": \"\",'+
		'            \"CONTACTID\": \"38924468\",'+
		'            \"CONTACTFIRSTNAME\": \"Sunil\",'+
		'            \"CONTACTLASTNAME\": \"Chandra\",'+
		'            \"ISSUEDATE\": \"2023-01-10T12:17:48\",'+
		'            \"DATEUPDATED\": \"2023-04-03T09:37:51\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-10T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"CLOSED\",'+
		'            \"TITLE\": \"Salesforce Administrator\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"100\",'+
		'            \"BILLRATEMAX\": \"100\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"1\",'+
		'            \"REMOTE_PERCENTAGE\": \"100\",'+
		'            \"DATESTATUSUPDATED\": \"2023-04-03T09:37:51\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18675095\",'+
		'            \"JOBDIVANO\": \"23-00005\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00005\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1460565\",'+
		'            \"PRIMARYSALESID\": \"1524454\",'+
		'            \"COMPANYID\": \"9269606\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"COMPANYNAME\": \"Pager Duty\",'+
		'            \"PRIMARYOWNERID\": \"\",'+
		'            \"CONTACTID\": \"38924468\",'+
		'            \"CONTACTFIRSTNAME\": \"Sunil\",'+
		'            \"CONTACTLASTNAME\": \"Chandra\",'+
		'            \"ISSUEDATE\": \"2023-01-11T11:43:02\",'+
		'            \"DATEUPDATED\": \"2023-01-11T12:06:31\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-11T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"CLOSED\",'+
		'            \"TITLE\": \"Salesforce QA Engineer (2)\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"0\",'+
		'            \"BILLRATEMAX\": \"0\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"1\",'+
		'            \"REMOTE_PERCENTAGE\": \"100\",'+
		'            \"DATESTATUSUPDATED\": \"2023-01-11T12:06:31\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18675109\",'+
		'            \"JOBDIVANO\": \"23-00006\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00006\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1460565\",'+
		'            \"PRIMARYSALESID\": \"1524454\",'+
		'            \"COMPANYID\": \"9269606\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"COMPANYNAME\": \"Pager Duty\",'+
		'            \"PRIMARYOWNERID\": \"\",'+
		'            \"CONTACTID\": \"38924468\",'+
		'            \"CONTACTFIRSTNAME\": \"Sunil\",'+
		'            \"CONTACTLASTNAME\": \"Chandra\",'+
		'            \"ISSUEDATE\": \"2023-01-11T11:44:50\",'+
		'            \"DATEUPDATED\": \"2023-01-11T12:06:02\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-11T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"CLOSED\",'+
		'            \"TITLE\": \"Salesforce Developer\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"0\",'+
		'            \"BILLRATEMAX\": \"0\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"1\",'+
		'            \"REMOTE_PERCENTAGE\": \"100\",'+
		'            \"DATESTATUSUPDATED\": \"2023-01-11T12:06:02\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18675344\",'+
		'            \"JOBDIVANO\": \"23-00007\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00007\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1483320\",'+
		'            \"PRIMARYSALESID\": \"1524454\",'+
		'            \"COMPANYID\": \"9269606\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"COMPANYNAME\": \"Pager Duty\",'+
		'            \"PRIMARYOWNERID\": \"\",'+
		'            \"CONTACTID\": \"38924468\",'+
		'            \"CONTACTFIRSTNAME\": \"Sunil\",'+
		'            \"CONTACTLASTNAME\": \"Chandra\",'+
		'            \"ISSUEDATE\": \"2023-01-11T12:08:05\",'+
		'            \"DATEUPDATED\": \"2023-04-06T11:20:09\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-11T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"CANCELLED\",'+
		'            \"TITLE\": \"Salesforce QA Engineer (2)\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"50\",'+
		'            \"BILLRATEMAX\": \"75\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"1\",'+
		'            \"REMOTE_PERCENTAGE\": \"100\",'+
		'            \"DATESTATUSUPDATED\": \"2023-04-06T11:20:09\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18675356\",'+
		'            \"JOBDIVANO\": \"23-00008\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00008\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1483320\",'+
		'            \"PRIMARYSALESID\": \"1421430\",'+
		'            \"COMPANYID\": \"9269606\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"COMPANYNAME\": \"Pager Duty\",'+
		'            \"PRIMARYOWNERID\": \"\",'+
		'            \"CONTACTID\": \"38924468\",'+
		'            \"CONTACTFIRSTNAME\": \"Sunil\",'+
		'            \"CONTACTLASTNAME\": \"Chandra\",'+
		'            \"ISSUEDATE\": \"2023-01-11T12:09:19\",'+
		'            \"DATEUPDATED\": \"2023-03-28T17:03:50\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-11T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"LOST\",'+
		'            \"TITLE\": \"Salesforce Developer\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRY\": \"\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"100\",'+
		'            \"BILLRATEMAX\": \"100\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"1\",'+
		'            \"REMOTE_PERCENTAGE\": \"100\",'+
		'            \"DATESTATUSUPDATED\": \"2023-03-28T17:03:50\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18688652\",'+
		'            \"JOBDIVANO\": \"23-00009\",'+
		'            \"OPTIONALREFERENCENO\": \"23-00009\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1460565\",'+
		'            \"PRIMARYSALESID\": \"1524454\",'+
		'            \"COMPANYID\": \"3198005\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"COMPANYNAME\": \"Computer Aid Inc\",'+
		'            \"PRIMARYOWNERID\": \"1178386\",'+
		'            \"CONTACTID\": \"16933794\",'+
		'            \"CONTACTFIRSTNAME\": \"Nicole\",'+
		'            \"CONTACTLASTNAME\": \"Walker\",'+
		'            \"ISSUEDATE\": \"2023-01-13T10:51:25\",'+
		'            \"DATEUPDATED\": \"2023-01-30T10:44:04\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-13T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"CLOSED\",'+
		'            \"TITLE\": \"Sr. Analytics & Data Visualization Solutions Lead\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"Wake Forest Rd\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Raleigh\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27604\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"95\",'+
		'            \"BILLRATEMAX\": \"98\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"0\",'+
		'            \"REMOTE_PERCENTAGE\": \"0\",'+
		'            \"DATESTATUSUPDATED\": \"2023-01-30T10:44:04\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"14627418\",'+
		'            \"JOBDIVANO\": \"21-00158\",'+
		'            \"OPTIONALREFERENCENO\": \"21-00158\",'+
		'            \"DIVISIONID\": \"253174\",'+
		'            \"DIVISIONNAME\": \"US TA\",'+
		'            \"PRIMARYRECRUITERID\": \"1456737\",'+
		'            \"PRIMARYSALESID\": \"1178386\",'+
		'            \"COMPANYID\": \"7245895\",'+
		'            \"USERID\": \"1178386\",'+
		'            \"COMPANYNAME\": \"Advance Auto Parts\",'+
		'            \"PRIMARYOWNERID\": \"1178386\",'+
		'            \"CONTACTID\": \"7108488\",'+
		'            \"CONTACTFIRSTNAME\": \"Madhup\",'+
		'            \"CONTACTLASTNAME\": \"Agrawal\",'+
		'            \"ISSUEDATE\": \"2021-03-17T17:58:48\",'+
		'            \"DATEUPDATED\": \"2023-01-03T13:53:06\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2021-03-17T00:00:00\",'+
		'            \"ENDDATE\": \"2021-03-27T00:00:00\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"FILLED\",'+
		'            \"TITLE\": \"Supply Chain Project Manager\",'+
		'            \"OPENINGS\": \"2\",'+
		'            \"FILLS\": \"1\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"2635 E milbrook R\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Raleigh\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27614\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"90\",'+
		'            \"BILLRATEMAX\": \"100\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"60\",'+
		'            \"PAYRATEMAX\": \"65\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"0\",'+
		'            \"REMOTE_PERCENTAGE\": \"0\",'+
		'            \"DATESTATUSUPDATED\": \"2021-04-05T15:20:29\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"17438172\",'+
		'            \"JOBDIVANO\": \"22-00298\",'+
		'            \"OPTIONALREFERENCENO\": \"22-00298\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1436738\",'+
		'            \"PRIMARYSALESID\": \"1178386\",'+
		'            \"COMPANYID\": \"3198130\",'+
		'            \"USERID\": \"1497033\",'+
		'            \"COMPANYNAME\": \"Lenovo\",'+
		'            \"PRIMARYOWNERID\": \"1178386\",'+
		'            \"CONTACTID\": \"7108297\",'+
		'            \"CONTACTFIRSTNAME\": \"Sharad\",'+
		'            \"CONTACTLASTNAME\": \"Gupta\",'+
		'            \"ISSUEDATE\": \"2022-08-01T11:16:19\",'+
		'            \"DATEUPDATED\": \"2023-01-04T13:44:13\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2022-08-15T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"CLOSED\",'+
		'            \"TITLE\": \"SAP SD Business Analyst\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"1009 Think Place\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Morrisville\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27560\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"120\",'+
		'            \"BILLRATEMAX\": \"120\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"1\",'+
		'            \"REMOTE_PERCENTAGE\": \"100\",'+
		'            \"DATESTATUSUPDATED\": \"2023-01-04T13:44:13\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18475731\",'+
		'            \"JOBDIVANO\": \"22-00426\",'+
		'            \"OPTIONALREFERENCENO\": \"22-00426\",'+
		'            \"DIVISIONID\": \"255123\",'+
		'            \"DIVISIONNAME\": \"US Sales\",'+
		'            \"PRIMARYRECRUITERID\": \"1481220\",'+
		'            \"PRIMARYSALESID\": \"1426169\",'+
		'            \"COMPANYID\": \"6916021\",'+
		'            \"USERID\": \"1426169\",'+
		'            \"COMPANYNAME\": \"Palo Alto Networks\",'+
		'            \"PRIMARYOWNERID\": \"1426169\",'+
		'            \"CONTACTID\": \"31143193\",'+
		'            \"CONTACTFIRSTNAME\": \"Yuva\",'+
		'            \"CONTACTLASTNAME\": \"Devarajan\",'+
		'            \"ISSUEDATE\": \"2022-12-16T03:45:12\",'+
		'            \"DATEUPDATED\": \"2023-01-05T21:30:05\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2023-01-03T00:00:00\",'+
		'            \"ENDDATE\": \"2023-12-29T00:00:00\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"FILLED\",'+
		'            \"TITLE\": \"SAP SAC Consultant (India)\",'+
		'            \"OPENINGS\": \"2\",'+
		'            \"FILLS\": \"1\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"3000 Tannery Way,\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Santa Clara\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"95054\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"30\",'+
		'            \"BILLRATEMAX\": \"30\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"0\",'+
		'            \"REMOTE_PERCENTAGE\": \"0\",'+
		'            \"DATESTATUSUPDATED\": \"2023-01-05T21:30:05\"'+
		'        },'+
		'        {'+
		'            \"JOBID\": \"18520089\",'+
		'            \"JOBDIVANO\": \"22-00435\",'+
		'            \"OPTIONALREFERENCENO\": \"22-00435\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"DIVISIONNAME\": \"\",'+
		'            \"PRIMARYRECRUITERID\": \"1460565\",'+
		'            \"PRIMARYSALESID\": \"1524454\",'+
		'            \"COMPANYID\": \"3198005\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"COMPANYNAME\": \"Computer Aid Inc\",'+
		'            \"PRIMARYOWNERID\": \"1178386\",'+
		'            \"CONTACTID\": \"14591147\",'+
		'            \"CONTACTFIRSTNAME\": \"Anne\",'+
		'            \"CONTACTLASTNAME\": \"Elliott\",'+
		'            \"ISSUEDATE\": \"2022-12-28T12:28:30\",'+
		'            \"DATEUPDATED\": \"2023-01-12T13:53:55\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"STARTDATE\": \"2022-12-28T00:00:00\",'+
		'            \"ENDDATE\": \"\",'+
		'            \"POSITIONTYPE\": \"Contract\",'+
		'            \"JOBSTATUS\": \"CLOSED\",'+
		'            \"TITLE\": \"Technical Specialist- Expert\",'+
		'            \"OPENINGS\": \"1\",'+
		'            \"FILLS\": \"0\",'+
		'            \"MAXALLOWEDSUBMITTALS\": \"0\",'+
		'            \"ADDRESS1\": \"3900 Wake Forest Rd\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Raleigh\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27609\",'+
		'            \"COUNTRY\": \"US\",'+
		'            \"PRIORITY\": \"Top Priority\",'+
		'            \"BILLRATEMIN\": \"114\",'+
		'            \"BILLRATEMAX\": \"114\",'+
		'            \"BILLFREQUENCY\": \"Hourly\",'+
		'            \"PAYRATEMIN\": \"0\",'+
		'            \"PAYRATEMAX\": \"0\",'+
		'            \"PAYFREQUENCY\": \"Hourly\",'+
		'            \"CURRENCY\": \"USD\",'+
		'            \"ONSITE_FLEXIBILITY\": \"1\",'+
		'            \"REMOTE_PERCENTAGE\": \"100\",'+
		'            \"DATESTATUSUPDATED\": \"2023-01-12T13:53:55\"'+
		'        }'+
		'    ]'+
		'}';
		JobDivaWrapper r = JobDivaWrapper.parse(json);
		System.assert(r != null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JobDivaWrapper objClz_JobDetailsWrapper = new JobDivaWrapper(System.JSON.createParser(json));
		System.assert(objClz_JobDetailsWrapper != null);
		System.assert(objClz_JobDetailsWrapper.message == null);
		System.assert(objClz_JobDetailsWrapper.data == null);

		json = '{\"TestAMissingObject\": { \"TestAMissingArray\": [ { \"TestAMissingProperty\": \"Some Value\" } ] } }';
		JobDivaWrapper.Data objData = new JobDivaWrapper.Data(System.JSON.createParser(json));
		System.assert(objData != null);
		System.assert(objData.JOBID == null);
		System.assert(objData.JOBDIVANO == null);
		System.assert(objData.OPTIONALREFERENCENO == null);
		System.assert(objData.DIVISIONID == null);
		System.assert(objData.DIVISIONNAME == null);
		System.assert(objData.PRIMARYRECRUITERID == null);
		System.assert(objData.PRIMARYSALESID == null);
		System.assert(objData.COMPANYID == null);
		System.assert(objData.USERID == null);
		System.assert(objData.COMPANYNAME == null);
		System.assert(objData.PRIMARYOWNERID == null);
		System.assert(objData.CONTACTID == null);
		System.assert(objData.CONTACTFIRSTNAME == null);
		System.assert(objData.CONTACTLASTNAME == null);
		System.assert(objData.ISSUEDATE == null);
		System.assert(objData.DATEUPDATED == null);
		System.assert(objData.DATEUSERFIELDUPDATED == null);
		System.assert(objData.STARTDATE == null);
		System.assert(objData.ENDDATE == null);
		System.assert(objData.POSITIONTYPE == null);
		System.assert(objData.JOBSTATUS == null);
		System.assert(objData.TITLE == null);
		System.assert(objData.OPENINGS == null);
		System.assert(objData.FILLS == null);
		System.assert(objData.MAXALLOWEDSUBMITTALS == null);
		System.assert(objData.ADDRESS1 == null);
		System.assert(objData.ADDRESS2 == null);
		System.assert(objData.CITY == null);
		System.assert(objData.STATE == null);
		System.assert(objData.ZIPCODE == null);
		System.assert(objData.COUNTRY == null);
		System.assert(objData.PRIORITY == null);
		System.assert(objData.BILLRATEMIN == null);
		System.assert(objData.BILLRATEMAX == null);
		System.assert(objData.BILLFREQUENCY == null);
		System.assert(objData.PAYRATEMIN == null);
		System.assert(objData.PAYRATEMAX == null);
		System.assert(objData.PAYFREQUENCY == null);
		System.assert(objData.CURRENCY_Z == null);
		System.assert(objData.ONSITE_FLEXIBILITY == null);
		System.assert(objData.REMOTE_PERCENTAGE == null);
		System.assert(objData.DATESTATUSUPDATED == null);
	}
}