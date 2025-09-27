public class StudentHandler {
    public static String getStudentInfo() {
        // Create student record
        Student__c s = new Student__c();
        s.Name = 'Test Student';        // Text
        s.Roll_No__c = 1;               // Number (integer)
        s.Student_Marks__c = 85.0;      // Decimal (Number(10,2))


        return 'Name: ' + s.Name + ', Roll No: ' + s.Roll_No__c + ', Marks: ' + s.Student_Marks__c;
    }
}