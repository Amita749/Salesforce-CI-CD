public class TeacherHandler {
  public static String getTeacherInfo() {
        // Create student record
        Teacher__c te= new Teacher__c();
        te.Name = 'Test Teacher';
      te.Email_ID__c= 'test123@gmail.com';
      
        return 'Name: ' + te.Name + ', Email ID :' + te.Email_ID__c ;
    }
}