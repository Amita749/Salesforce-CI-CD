/* 
Name: JobDivaWrapper.cls
Description: Wrapper to convert JSON response into Apex. If, else required in this code because of the reserved key word coming from the JobDiva response.
Date: 02 February 2024
Version: 1.0
Author: DynPro                       
*/
global class JobDivaWrapper {

	global String message {get;set;} 
	global List<Data> data {get;set;} 

	public JobDivaWrapper(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'message') {
						message = parser.getText();
					} else if (text == 'data') {
						data = arrayOfData(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'JobDivaWrapper consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	global class Data {
		public String JOBID {get;set;} 
		public String JOBDIVANO {get;set;} 
		public String OPTIONALREFERENCENO {get;set;} 
		public String DIVISIONID {get;set;} 
		public String DIVISIONNAME {get;set;} 
		public String PRIMARYRECRUITERID {get;set;} 
		public String PRIMARYSALESID {get;set;} 
		public String COMPANYID {get;set;} 
		public String USERID {get;set;} 
		public String COMPANYNAME {get;set;} 
		public String PRIMARYOWNERID {get;set;} 
		public String CONTACTID {get;set;} 
		public String CONTACTFIRSTNAME {get;set;} 
		public String CONTACTLASTNAME {get;set;} 
		public String ISSUEDATE {get;set;} 
		public String DATEUPDATED {get;set;} 
		public String DATEUSERFIELDUPDATED {get;set;} 
		public String STARTDATE {get;set;} 
		public String ENDDATE {get;set;} 
		public String POSITIONTYPE {get;set;} 
		public String JOBSTATUS {get;set;} 
		public String TITLE {get;set;} 
		public String OPENINGS {get;set;} 
		public String FILLS {get;set;} 
		public String MAXALLOWEDSUBMITTALS {get;set;} 
		public String ADDRESS1 {get;set;} 
		public String ADDRESS2 {get;set;} 
		public String CITY {get;set;} 
		public String STATE {get;set;} 
		public String ZIPCODE {get;set;} 
		public String COUNTRY {get;set;} 
		public String PRIORITY {get;set;} 
		public String BILLRATEMIN {get;set;} 
		public String BILLRATEMAX {get;set;} 
		public String BILLFREQUENCY {get;set;} 
		public String PAYRATEMIN {get;set;} 
		public String PAYRATEMAX {get;set;} 
		public String PAYFREQUENCY {get;set;} 
		public String CURRENCY_Z {get;set;} // in json: CURRENCY
		public String ONSITE_FLEXIBILITY {get;set;} 
		public String REMOTE_PERCENTAGE {get;set;} 
		public String DATESTATUSUPDATED {get;set;} 

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'JOBID') {
							JOBID = parser.getText();
						} else if (text == 'JOBDIVANO') {
							JOBDIVANO = parser.getText();
						} else if (text == 'OPTIONALREFERENCENO') {
							OPTIONALREFERENCENO = parser.getText();
						} else if (text == 'DIVISIONID') {
							DIVISIONID = parser.getText();
						} else if (text == 'DIVISIONNAME') {
							DIVISIONNAME = parser.getText();
						} else if (text == 'PRIMARYRECRUITERID') {
							PRIMARYRECRUITERID = parser.getText();
						} else if (text == 'PRIMARYSALESID') {
							PRIMARYSALESID = parser.getText();
						} else if (text == 'COMPANYID') {
							COMPANYID = parser.getText();
						} else if (text == 'USERID') {
							USERID = parser.getText();
						} else if (text == 'COMPANYNAME') {
							COMPANYNAME = parser.getText();
						} else if (text == 'PRIMARYOWNERID') {
							PRIMARYOWNERID = parser.getText();
						} else if (text == 'CONTACTID') {
							CONTACTID = parser.getText();
						} else if (text == 'CONTACTFIRSTNAME') {
							CONTACTFIRSTNAME = parser.getText();
						} else if (text == 'CONTACTLASTNAME') {
							CONTACTLASTNAME = parser.getText();
						} else if (text == 'ISSUEDATE') {
							ISSUEDATE = parser.getText();
						} else if (text == 'DATEUPDATED') {
							DATEUPDATED = parser.getText();
						} else if (text == 'DATEUSERFIELDUPDATED') {
							DATEUSERFIELDUPDATED = parser.getText();
						} else if (text == 'STARTDATE') {
							STARTDATE = parser.getText();
						} else if (text == 'ENDDATE') {
							ENDDATE = parser.getText();
						} else if (text == 'POSITIONTYPE') {
							POSITIONTYPE = parser.getText();
						} else if (text == 'JOBSTATUS') {
							JOBSTATUS = parser.getText();
						} else if (text == 'TITLE') {
							TITLE = parser.getText();
						} else if (text == 'OPENINGS') {
							OPENINGS = parser.getText();
						} else if (text == 'FILLS') {
							FILLS = parser.getText();
						} else if (text == 'MAXALLOWEDSUBMITTALS') {
							MAXALLOWEDSUBMITTALS = parser.getText();
						} else if (text == 'ADDRESS1') {
							ADDRESS1 = parser.getText();
						} else if (text == 'ADDRESS2') {
							ADDRESS2 = parser.getText();
						} else if (text == 'CITY') {
							CITY = parser.getText();
						} else if (text == 'STATE') {
							STATE = parser.getText();
						} else if (text == 'ZIPCODE') {
							ZIPCODE = parser.getText();
						} else if (text == 'COUNTRY') {
							COUNTRY = parser.getText();
						} else if (text == 'PRIORITY') {
							PRIORITY = parser.getText();
						} else if (text == 'BILLRATEMIN') {
							BILLRATEMIN = parser.getText();
						} else if (text == 'BILLRATEMAX') {
							BILLRATEMAX = parser.getText();
						} else if (text == 'BILLFREQUENCY') {
							BILLFREQUENCY = parser.getText();
						} else if (text == 'PAYRATEMIN') {
							PAYRATEMIN = parser.getText();
						} else if (text == 'PAYRATEMAX') {
							PAYRATEMAX = parser.getText();
						} else if (text == 'PAYFREQUENCY') {
							PAYFREQUENCY = parser.getText();
						} else if (text == 'CURRENCY') {
							CURRENCY_Z = parser.getText();
						} else if (text == 'ONSITE_FLEXIBILITY') {
							ONSITE_FLEXIBILITY = parser.getText();
						} else if (text == 'REMOTE_PERCENTAGE') {
							REMOTE_PERCENTAGE = parser.getText();
						} else if (text == 'DATESTATUSUPDATED') {
							DATESTATUSUPDATED = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static JobDivaWrapper parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new JobDivaWrapper(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	
    private static List<Data> arrayOfData(System.JSONParser p) {
        List<Data> res = new List<Data>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Data(p));
        }
        return res;
    }
}