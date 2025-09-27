/* 
Name: UpdateContactFromJobDivaToSFWrapper.cls
Description: This class is wrapper class which convert Jobdiva JSON response into apex wrapper class.
Date: 22 February 2024
Version: 1.0
Author: DynPro                      
*/
global class UpdateContactFromJobDivaToSFWrapper {
    global String message;	
	global List<Data> data;

	global class Data {
		public String CONTACTID;
		public String FIRSTNAME;
		public String LASTNAME;
		public String DATECREATED;
		public String USERID;
		public String DATEUPDATED;
		public String DATEUSERFIELDUPDATED;
		public String COMPANYID;
		public String COMPANYNAME;
		public String DEPARTMENT;
		public String TITLE;
		public String ACTIVE;
		public String PRIMARY;
		public String EMAIL;
		public String ALTERNATE_EMAIL;
		public String WORKPHONE;
		public String WORKPHONEEXT;
		public String HOMEPHONE;
		public String CELLPHONE;
		public String FAX;
		public String ADDRESS1;
		public String ADDRESS2;
		public String CITY;
		public String STATE;
		public String ZIPCODE;
		public String COUNTRYID;
		public String SALES_PIPELINE;
		public String CONTACT_TYPES;
	}

	
	public static UpdateContactFromJobDivaToSFWrapper parse(String json) {
		return (UpdateContactFromJobDivaToSFWrapper) System.JSON.deserialize(json, UpdateContactFromJobDivaToSFWrapper.class);
	}
}