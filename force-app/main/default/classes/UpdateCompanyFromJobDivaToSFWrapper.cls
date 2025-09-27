/* 
Name: UpdateCompanyFromJobDivaToSFWrapper.cls
Description: This class is wrapper class which convert Jobdiva JSON response into apex wrapper class.
Date: 22 February 2024
Version: 1.0
Author: DynPro                      
*/
global class UpdateCompanyFromJobDivaToSFWrapper {
    global String message;
	global List<Data> data;

	global class Data {
		public String COMPANYID;
		public String COMPANYNAME;
		public String DATECREATED;
		public String USERID;
		public String DATEUPDATED;
		public String DATEUSERFIELDUPDATED;
		public String PRIMARYOWNER;
		public String COMPANYTYPE;
		public String ADDRESS1;
		public String ADDRESS2;
		public String CITY;
		public String STATE;
		public String ZIPCODE;
		public String COUNTRYID;
		public String PHONE;
		public String FAX;
		public String URL;
		public String EMAIL;
		public String DIVISIONID;
		public String SALES_PIPELINE;
		public String INDUSTRY;
		public String VMS_WEBSITE;
	}

	
	public static UpdateCompanyFromJobDivaToSFWrapper parse(String json) {
		return (UpdateCompanyFromJobDivaToSFWrapper) System.JSON.deserialize(json, UpdateCompanyFromJobDivaToSFWrapper.class);
	}
}