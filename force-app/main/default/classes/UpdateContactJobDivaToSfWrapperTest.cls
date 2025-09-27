@IsTest
public class UpdateContactJobDivaToSfWrapperTest 
{
static testMethod void testParse() {
		String json = '{'+
		'    \"message\": \"Query \\\"New/Updated Contact Records\\\" completed successfully\",'+
		'    \"data\": ['+
		'        {'+
		'            \"CONTACTID\": \"41482010\",'+
		'            \"FIRSTNAME\": \"Romit\",'+
		'            \"LASTNAME\": \"Jadhwani\",'+
		'            \"DATECREATED\": \"2024-03-24T18:52:26\",'+
		'            \"USERID\": \"1441599\",'+
		'            \"DATEUPDATED\": \"2024-03-26T15:47:18\",'+
		'            \"DATEUSERFIELDUPDATED\": \"\",'+
		'            \"COMPANYID\": \"9271835\",'+
		'            \"COMPANYNAME\": \"Databricks\",'+
		'            \"DEPARTMENT\": \"\",'+
		'            \"TITLE\": \"Sr. Director, Data Engineering, Analytics & Integrations\",'+
		'            \"ACTIVE\": \"1\",'+
		'            \"PRIMARY\": \"\",'+
		'            \"EMAIL\": \"romit.jadhwani@databricks.com\",'+
		'            \"ALTERNATE_EMAIL\": \"\",'+
		'            \"WORKPHONE\": \"\",'+
		'            \"WORKPHONEEXT\": \"\",'+
		'            \"HOMEPHONE\": \"\",'+
		'            \"CELLPHONE\": \"\",'+
		'            \"FAX\": \"\",'+
		'            \"ADDRESS1\": \"\",'+
		'            \"ADDRESS2\": \"\",'+
		'            \"CITY\": \"\",'+
		'            \"STATE\": \"\",'+
		'            \"ZIPCODE\": \"\",'+
		'            \"COUNTRYID\": \"US\",'+
		'            \"SALES_PIPELINE\": \"\",'+
		'            \"CONTACT_TYPES\": \"\"'+
		'         }'+
		'    ]'+
		'}';
		UpdateContactFromJobDivaToSFWrapper obj = UpdateContactFromJobDivaToSFWrapper.parse(json);
		System.assert(obj != null);
	}
}