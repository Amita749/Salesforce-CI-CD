@IsTest
public class UpdateCompnayFromJobDivaToSFWrapperTest {

    static testMethod void testParse() {
		String json = '{'+
		'    \"message\": \"Query \\\"New/Updated Company Records\\\" completed successfully\",'+
		'    \"data\": ['+
		'        {'+
		'            \"COMPANYID\": \"5371937\",'+
		'            \"COMPANYNAME\": \"Loparex\",'+
		'            \"DATECREATED\": \"2015-04-14T16:41:08\",'+
		'            \"USERID\": \"1188488\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:40:26\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Bagyalakshmi Guptha\",'+
		'            \"COMPANYTYPE\": \"Other\",'+
		'            \"ADDRESS1\": \"1255 Cresent Green Suite 400\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Cary\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27518\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"9196787700\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"www.loparex.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Job Order\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"5738889\",'+
		'            \"COMPANYNAME\": \"FHI360\",'+
		'            \"DATECREATED\": \"2015-09-23T10:22:20\",'+
		'            \"USERID\": \"1371968\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:24:41\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Vikas Kumar\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"359 Blackwell Street, Suite 200\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Durham\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27701\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"919.544.7040\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"bkinyon@fhi360.org \",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"6597722\",'+
		'            \"COMPANYNAME\": \"DynPro India\",'+
		'            \"DATECREATED\": \"2017-01-05T10:17:09\",'+
		'            \"USERID\": \"1396770\",'+
		'            \"DATEUPDATED\": \"2024-02-22T21:30:04\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2024-02-22T21:30:04\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Job Order\",'+
		'            \"INDUSTRY\": \"Computer Software\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"6816787\",'+
		'            \"COMPANYNAME\": \"Lord Corporation\",'+
		'            \"DATECREATED\": \"2017-08-17T10:47:55\",'+
		'            \"USERID\": \"1403781\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:24:17\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Sanjay Kumar\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"111 Lord Drive\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Cary\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27511\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"9193423380\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"https://www.lord.com/\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"6913065\",'+
		'            \"COMPANYNAME\": \"TiVo\",'+
		'            \"DATECREATED\": \"2018-03-23T11:14:40\",'+
		'            \"USERID\": \"1404205\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:18:09\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2023-06-13T15:00:00\",'+
		'            \"PRIMARYOWNER\": \"Sanjay Jain\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"2160 Gold St\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"San Jose\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"95002\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"4085199100\",'+
		'            \"FAX\": \"4085199100\",'+
		'            \"URL\": \"www.tivo.com\",'+
		'            \"EMAIL\": \"Info@Tivo.com\",'+
		'            \"DIVISIONID\": \"701\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"Information Technology and Services\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"6916021\",'+
		'            \"COMPANYNAME\": \"Palo Alto Networks\",'+
		'            \"DATECREATED\": \"2018-04-04T15:36:55\",'+
		'            \"USERID\": \"1421960\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:14:48\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shri Rajan\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"9253992758\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"https://www.paloaltonetworks.com/\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"Information Technology and Services\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"6925650\",'+
		'            \"COMPANYNAME\": \"SAP\",'+
		'            \"DATECREATED\": \"2018-04-25T15:02:33\",'+
		'            \"USERID\": \"1363942\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:23:38\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shiv Thiagarajan\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"6970172\",'+
		'            \"COMPANYNAME\": \"Maxim Integrated\",'+
		'            \"DATECREATED\": \"2018-06-11T11:51:01\",'+
		'            \"USERID\": \"1421960\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:41:45\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shri Rajan\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"San Jose\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"www.maximintegrated.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"Electrical/Electronic Manufacturing\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"6998157\",'+
		'            \"COMPANYNAME\": \"eBay\",'+
		'            \"DATECREATED\": \"2018-07-02T16:45:03\",'+
		'            \"USERID\": \"1421960\",'+
		'            \"DATEUPDATED\": \"2024-02-14T20:32:44\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shri Rajan\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Santa Clara\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"www.ebayinc.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7176644\",'+
		'            \"COMPANYNAME\": \"Magna International\",'+
		'            \"DATECREATED\": \"2018-10-17T18:04:18\",'+
		'            \"USERID\": \"1421960\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:41:09\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Aishwarya Ramani\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Aurora\",'+
		'            \"STATE\": \"ON\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"CA\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7219532\",'+
		'            \"COMPANYNAME\": \"DXC Technology\",'+
		'            \"DATECREATED\": \"2019-01-09T14:09:53\",'+
		'            \"USERID\": \"1421960\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:25:17\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Tysons\",'+
		'            \"STATE\": \"VA\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7230227\",'+
		'            \"COMPANYNAME\": \"Booz Allen Hamilton - HQ\",'+
		'            \"DATECREATED\": \"2019-02-05T14:33:28\",'+
		'            \"USERID\": \"1403781\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:15:33\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Vikas Kumar\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"8283 Greensboro Drive\",'+
		'            \"ADDRESS2\": \"Hamilton Building\",'+
		'            \"CITY\": \"McLean\",'+
		'            \"STATE\": \"VA\",'+
		'            \"ZIPCODE\": \"22102\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"7039025000\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"http://www.boozallen.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7231329\",'+
		'            \"COMPANYNAME\": \"Net App\",'+
		'            \"DATECREATED\": \"2019-02-08T11:19:25\",'+
		'            \"USERID\": \"1443332\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:42:54\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Sanjay Jain\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"San Francisco\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Job Order\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7290336\",'+
		'            \"COMPANYNAME\": \"Blue Cross Blue Shield\",'+
		'            \"DATECREATED\": \"2019-07-15T13:36:13\",'+
		'            \"USERID\": \"1443332\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:34:12\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shiv Thiagarajan\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"4615 University Dr\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Durham\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27707\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Job Order\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7291251\",'+
		'            \"COMPANYNAME\": \"HPE\",'+
		'            \"DATECREATED\": \"2019-07-17T23:00:00\",'+
		'            \"USERID\": \"1421960\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:38:34\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shiv Thiagarajan\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"TX\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7294378\",'+
		'            \"COMPANYNAME\": \"Tecan\",'+
		'            \"DATECREATED\": \"2019-07-22T08:03:24\",'+
		'            \"USERID\": \"1403781\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:22:38\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"9401 Globe Center Dr\",'+
		'            \"ADDRESS2\": \"Suite 140\",'+
		'            \"CITY\": \"Morrisville\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27560\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"9193615200\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"https://www.tecan.com/\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7354762\",'+
		'            \"COMPANYNAME\": \"K&B Global Consulting\",'+
		'            \"DATECREATED\": \"2019-09-26T13:35:00\",'+
		'            \"USERID\": \"1403781\",'+
		'            \"DATEUPDATED\": \"2024-02-14T22:53:52\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2023-04-20T17:58:56\",'+
		'            \"PRIMARYOWNER\": \"Sharad Varshney\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"1020 Homer St\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Durham\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"27701\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"www.kandbgc.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"Entertainment\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7409081\",'+
		'            \"COMPANYNAME\": \"Square Inc.\",'+
		'            \"DATECREATED\": \"2019-11-07T12:45:52\",'+
		'            \"USERID\": \"1445608\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:17:51\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7747743\",'+
		'            \"COMPANYNAME\": \"Google\",'+
		'            \"DATECREATED\": \"2020-01-09T10:12:08\",'+
		'            \"USERID\": \"1445608\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:31:10\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Supplier,Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Mt. View\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"7849438\",'+
		'            \"COMPANYNAME\": \"3S Business Corporation Inc\",'+
		'            \"DATECREATED\": \"2020-04-08T17:32:43\",'+
		'            \"USERID\": \"1443967\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:41:05\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2024-02-14T14:41:05\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"16700 House and Hahl Rd\",'+
		'            \"ADDRESS2\": \"Bldg 6B\",'+
		'            \"CITY\": \"Cypress\",'+
		'            \"STATE\": \"TX\",'+
		'            \"ZIPCODE\": \"77433\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"2818239222\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"geetha.neelam@3sbc.com \",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"\",'+
		'            \"INDUSTRY\": \"Staffing and Recruiting\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8055946\",'+
		'            \"COMPANYNAME\": \"VendorPass\",'+
		'            \"DATECREATED\": \"2021-04-02T16:45:28\",'+
		'            \"USERID\": \"1178386\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:18:23\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2023-06-13T15:03:24\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"10151 Deerwood Park Blvd Building 200,\",'+
		'            \"ADDRESS2\": \"Suite 400\",'+
		'            \"CITY\": \"Jacksonville\",'+
		'            \"STATE\": \"FL\",'+
		'            \"ZIPCODE\": \"32256\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"8776992297\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"Information Technology and Services\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8073504\",'+
		'            \"COMPANYNAME\": \"The Clorox Company\",'+
		'            \"DATECREATED\": \"2021-05-09T00:49:25\",'+
		'            \"USERID\": \"1445608\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:21:57\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Sanjay Kumar\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"5102717000\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"Consumer Goods\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8074366\",'+
		'            \"COMPANYNAME\": \"SAP India Pvt Ltd\",'+
		'            \"DATECREATED\": \"2021-05-12T08:23:47\",'+
		'            \"USERID\": \"1477697\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:46:41\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shiv Thiagarajan\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"#138, EPIP Zone  Whitefield\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Bangalore\",'+
		'            \"STATE\": \"KA\",'+
		'            \"ZIPCODE\": \"560066\",'+
		'            \"COUNTRYID\": \"IN\",'+
		'            \"PHONE\": \"91-8066655991 \",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"r.rehman@sap.com\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Job Order\",'+
		'            \"INDUSTRY\": \"Information Technology and Services\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8121842\",'+
		'            \"COMPANYNAME\": \"Beam Suntory\",'+
		'            \"DATECREATED\": \"2021-08-23T15:50:59\",'+
		'            \"USERID\": \"1443967\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:34:28\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Aishwarya Ramani\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"Merchandise Mart, 222 W. Merchandise Mart Plaza, Suite 1600,\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Chicago\",'+
		'            \"STATE\": \"IL\",'+
		'            \"ZIPCODE\": \"60654\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"3129646999\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"https://www.beamsuntory.com/en\",'+
		'            \"EMAIL\": \"Emily.York@BeamSuntory.com\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"Wine and Spirits\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8125824\",'+
		'            \"COMPANYNAME\": \"Element Solutions Inc\",'+
		'            \"DATECREATED\": \"2021-09-01T03:31:57\",'+
		'            \"USERID\": \"1445608\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:36:53\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Bagyalakshmi Guptha\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"1525 Apex Peakway, Suite 101 Apex, NC, USA 27502\",'+
		'            \"CITY\": \"Cary\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"www.elementsolutionsinc.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"Chemicals\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8838061\",'+
		'            \"COMPANYNAME\": \"Analog Devices\",'+
		'            \"DATECREATED\": \"2022-03-16T12:12:03\",'+
		'            \"USERID\": \"1426169\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:30:25\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"One Analog Way\",'+
		'            \"ADDRESS2\": \"Massachusetts 01887, United States\",'+
		'            \"CITY\": \"Wilmington\",'+
		'            \"STATE\": \"MA\",'+
		'            \"ZIPCODE\": \"01887\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"7813294700\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"www.analog.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"Information Technology and Services\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8855236\",'+
		'            \"COMPANYNAME\": \"FUJIFILM\",'+
		'            \"DATECREATED\": \"2022-04-26T11:45:19\",'+
		'            \"USERID\": \"1178386\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:16:39\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2023-06-12T16:15:41\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"101 J. Morris Commons Lane,\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Morrisville\",'+
		'            \"STATE\": \"NC\",'+
		'            \"ZIPCODE\": \"27560\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"Biotechnology\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8869652\",'+
		'            \"COMPANYNAME\": \"Sony\",'+
		'            \"DATECREATED\": \"2022-05-03T10:29:51\",'+
		'            \"USERID\": \"1447326\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:48:12\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shiv Thiagarajan\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"www.playstation.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Job Order\",'+
		'            \"INDUSTRY\": \"Consumer Electronics\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"8965847\",'+
		'            \"COMPANYNAME\": \"Applied Industrial Technologies\",'+
		'            \"DATECREATED\": \"2022-11-01T09:44:50\",'+
		'            \"USERID\": \"1524454\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:32:03\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Bagyalakshmi Guptha\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9271835\",'+
		'            \"COMPANYNAME\": \"Databricks\",'+
		'            \"DATECREATED\": \"2023-01-18T15:36:48\",'+
		'            \"USERID\": \"1426169\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:24:58\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2023-05-09T10:28:33\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"160 Spear St 15th floor,\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"San Francisco,\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"94105\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"sean.doyle@databricks.com\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Not Billing\",'+
		'            \"INDUSTRY\": \"Computer Software\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9345994\",'+
		'            \"COMPANYNAME\": \"Sagent Lending\",'+
		'            \"DATECREATED\": \"2023-02-22T21:50:23\",'+
		'            \"USERID\": \"1426169\",'+
		'            \"DATEUPDATED\": \"2024-02-14T15:23:13\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Dallas\",'+
		'            \"STATE\": \"TX\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"9729294622\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9398276\",'+
		'            \"COMPANYNAME\": \"Service Titan\",'+
		'            \"DATECREATED\": \"2023-04-26T10:23:38\",'+
		'            \"USERID\": \"1525312\",'+
		'            \"DATEUPDATED\": \"2024-02-14T14:47:30\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2023-06-26T12:47:44\",'+
		'            \"PRIMARYOWNER\": \"Vaibhav Mankame\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"Computer Software\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9571883\",'+
		'            \"COMPANYNAME\": \"Ridge Lending Inc.\",'+
		'            \"DATECREATED\": \"2023-10-05T02:51:20\",'+
		'            \"USERID\": \"1527066\",'+
		'            \"DATEUPDATED\": \"2024-02-18T20:34:54\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"10220 SW Greenburg Road,Suite 140, Portland,0R 97223\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"18557474343\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"Financial Services\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9611476\",'+
		'            \"COMPANYNAME\": \"Govividly\",'+
		'            \"DATECREATED\": \"2023-11-06T13:45:53\",'+
		'            \"USERID\": \"1550142\",'+
		'            \"DATEUPDATED\": \"2024-02-20T19:08:33\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"Shiril Nikhar\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9660550\",'+
		'            \"COMPANYNAME\": \"Elite Medical Experts\",'+
		'            \"DATECREATED\": \"2024-01-16T18:13:09\",'+
		'            \"USERID\": \"1278636\",'+
		'            \"DATEUPDATED\": \"2024-02-18T20:38:41\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"6440 N Swan Rd STE 100,\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Tucson,\",'+
		'            \"STATE\": \"AZ\",'+
		'            \"ZIPCODE\": \"85718\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Billing\",'+
		'            \"INDUSTRY\": \"Medical Devices\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9682469\",'+
		'            \"COMPANYNAME\": \"Test account -9th Feb\",'+
		'            \"DATECREATED\": \"2024-02-09T09:41:36\",'+
		'            \"USERID\": \"1441599\",'+
		'            \"DATEUPDATED\": \"2024-02-14T07:14:18\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"\",'+
		'            \"ADDRESS1\": \"Mill Valley,123\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Mill Valley\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"94941\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"1234567\",'+
		'            \"FAX\": \"12345\",'+
		'            \"URL\": \"www.companymu.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"Job Order\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9686694\",'+
		'            \"COMPANYNAME\": \"SF to JobDiva create Company-Test\",'+
		'            \"DATECREATED\": \"2024-02-16T06:36:31\",'+
		'            \"USERID\": \"1441599\",'+
		'            \"DATEUPDATED\": \"2024-02-16T06:36:31\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Supplier\",'+
		'            \"ADDRESS1\": \"San Jose, suit 789\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"San Jose\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"23456\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"9023456178\",'+
		'            \"FAX\": \"65389\",'+
		'            \"URL\": \"www.createcompanytest.com\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9686726\",'+
		'            \"COMPANYNAME\": \"Test Sf-Company-16th Feb\",'+
		'            \"DATECREATED\": \"2024-02-16T06:57:18\",'+
		'            \"USERID\": \"1441599\",'+
		'            \"DATEUPDATED\": \"2024-02-19T04:32:28\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Customer\",'+
		'            \"ADDRESS1\": \"SanJose,301-D\",'+
		'            \"ADDRESS2\": \"string\",'+
		'            \"CITY\": \"SanJose\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"90860\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"987654321\",'+
		'            \"FAX\": \"009988\",'+
		'            \"URL\": \"www.DybnProtestcloudalyze.com\",'+
		'            \"EMAIL\": \"sangeetaclz@gmail.com\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9688477\",'+
		'            \"COMPANYNAME\": \"test company-20th feb\",'+
		'            \"DATECREATED\": \"2024-02-20T07:24:35\",'+
		'            \"USERID\": \"1441599\",'+
		'            \"DATEUPDATED\": \"2024-02-20T07:30:01\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Supplier\",'+
		'            \"ADDRESS1\": \"Los Angeles,suit,200\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Los Angeles\",'+
		'            \"STATE\": \"MI\",'+
		'            \"ZIPCODE\": \"221133\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"123456\",'+
		'            \"FAX\": \"2233446\",'+
		'            \"URL\": \"www.parentcompanytest.com\",'+
		'            \"EMAIL\": \"parent@gmail.com\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9690971\",'+
		'            \"COMPANYNAME\": \"testing-22feb\",'+
		'            \"DATECREATED\": \"2024-02-22T05:20:00\",'+
		'            \"USERID\": \"1441599\",'+
		'            \"DATEUPDATED\": \"2024-02-22T06:14:59\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Supplier\",'+
		'            \"ADDRESS1\": \"Ann Arbor Avenue,899\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"Cupertino\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"95014\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"123456799\",'+
		'            \"FAX\": \"77665588\",'+
		'            \"URL\": \"www.testingfebsecond.com\",'+
		'            \"EMAIL\": \"testing@gmail.com\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9691495\",'+
		'            \"COMPANYNAME\": \"Test Prod-22 Feb\",'+
		'            \"DATECREATED\": \"2024-02-22T12:55:45\",'+
		'            \"USERID\": \"1441599\",'+
		'            \"DATEUPDATED\": \"2024-02-22T12:56:39\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Supplier\",'+
		'            \"ADDRESS1\": \"San Francisco,suit 600\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"San Francisco\",'+
		'            \"STATE\": \"CA\",'+
		'            \"ZIPCODE\": \"3224\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"43352525\",'+
		'            \"FAX\": \"213456\",'+
		'            \"URL\": \"www.testinghr.com\",'+
		'            \"EMAIL\": \"testinghr@gmail.com\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"\",'+
		'            \"INDUSTRY\": \"\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        },'+
		'        {'+
		'            \"COMPANYID\": \"9691774\",'+
		'            \"COMPANYNAME\": \"CoolSnail Technologies LLC\",'+
		'            \"DATECREATED\": \"2024-02-22T21:38:29\",'+
		'            \"USERID\": \"1556659\",'+
		'            \"DATEUPDATED\": \"2024-02-23T09:44:25\",'+
		'            \"DATEUSERFIELDUPDATED\": \"2024-02-23T09:44:25\",'+
		'            \"PRIMARYOWNER\": \"\",'+
		'            \"COMPANYTYPE\": \"Supplier\",'+
		'            \"ADDRESS1\": \"1765 Greensboro Station Place\",'+
		'            \"ADDRESS2\": \"Suite 900\",'+
		'            \"CITY\": \"McLean\",'+
		'            \"STATE\": \"VA\",'+
		'            \"ZIPCODE\": \"22102\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"PHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"URL\": \"\",'+
		'            \"EMAIL\": \"\",'+
		'            \"DIVISIONID\": \"0\",'+
		'            \"SALES_PIPELINE\": \"\",'+
		'            \"INDUSTRY\": \"Information Technology and Services\",'+
		'            \"VMS_WEBSITE\": \"\"'+
		'        }'+
		'    ]'+
		'}';
		UpdateCompanyFromJobDivaToSFWrapper obj = UpdateCompanyFromJobDivaToSFWrapper.parse(json);
		System.assert(obj != null);
	}
}