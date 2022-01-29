public with sharing class DoctorAppointmentModel {
    public static List<DV_Appointment__c> getAppointmentsInfo() {
        List<DV_Appointment__c> appointmentsInfo = new List<DV_Appointment__c>([SELECT DV_Doctor__c, Id, DV_Doctor__r.Id, DV_Doctor__r.Name, DV_Patient__r.Id, DV_Patient__r.Name, Appointment_Date__c, Duration_in_minutes__c FROM DV_Appointment__c]);
        return appointmentsInfo;
    }
    
    public static List<DV_Appointment__c> getSortListOfAppointmentByDoctorName() {
        List<DV_Appointment__c> appointmentsInfo = new List<DV_Appointment__c>([SELECT Id, DV_Doctor__r.Id, DV_Doctor__r.Name, DV_Patient__r.Id, DV_Patient__r.Name, Appointment_Date__c, Duration_in_minutes__c FROM DV_Appointment__c ORDER BY DV_Doctor__r.Name]);
        return appointmentsInfo;
    }
    public static List<DV_Appointment__c> getSortListOfAppointmentByLastModifiedDate() {
        List<DV_Appointment__c> appointmentsInfo = new List<DV_Appointment__c>([SELECT DV_Doctor__c, Id, LastModifiedDate, DV_Doctor__r.Id, DV_Doctor__r.Name, DV_Patient__r.Id, DV_Patient__r.Name, Appointment_Date__c, Duration_in_minutes__c FROM DV_Appointment__c ORDER BY LastModifiedDate DESC ]);
        return appointmentsInfo;
    }
    public static List<DV_Appointment__c> getSortListOfAppointmentByPatientName() {
        List<DV_Appointment__c> appointmentsInfo = new List<DV_Appointment__c>([SELECT Id, DV_Doctor__r.Id, DV_Doctor__r.Name, DV_Patient__r.Id, DV_Patient__r.Name, Appointment_Date__c, Duration_in_minutes__c FROM DV_Appointment__c ORDER BY DV_Patient__r.Name]);
        return appointmentsInfo;
    }
    public static List<DV_Appointment__c> getSortListOfAppointmentBySelectedDoctor (String selectedDoctor) {
        List<DV_Appointment__c> appointmentsInfo = new List<DV_Appointment__c>([SELECT DV_Doctor__c, Id, DV_Doctor__r.Id, DV_Doctor__r.Name, DV_Patient__r.Id, DV_Patient__r.Name, Appointment_Date__c, Duration_in_minutes__c FROM DV_Appointment__c WHERE DV_Doctor__c = :selectedDoctor]);
        return appointmentsInfo;
    }
    
    public static List<SObject> getDoctors() {
        List<SObject> doctors = new List<DV_Doctor__c>([SELECT Id, Name, CreatedDate, Working_Hours_End__c, Working_Hours_Start__c FROM DV_Doctor__c ORDER BY CreatedDate DESC]);
        return doctors;
    }
    
    public static List<SObject> getPatients() {
        List<SObject> patients = new List<DV_Patient__c>([SELECT Id, Name, CreatedDate FROM DV_Patient__c ORDER BY CreatedDate DESC]);
        return patients;
    }
    
    public static List<SObject> getDoctorsForDelete(Id selectedDoctor) {
        List<SObject> doctors = new List<DV_Doctor__c>([SELECT Id, Name, CreatedDate, Working_Hours_End__c, Working_Hours_Start__c FROM DV_Doctor__c WHERE Id=:selectedDoctor]);
        return doctors;
    }
    
    public static DV_Doctor__c getDoctorById(Id doctorsId) {
        List<DV_Doctor__c> doctors = new List<DV_Doctor__c>([SELECT Id, Name, Working_Hours_End__c, Working_Hours_Start__c FROM DV_Doctor__c WHERE Id = :doctorsId]);
        return doctors.isEmpty() ? null : doctors[0];
    }
    
    public static DV_Patient__c getPatientById(Id patientId) {
        List<DV_Patient__c> patients = new List<DV_Patient__c>([SELECT Id, Name FROM DV_Patient__c WHERE Id = :patientId]);
        return patients.isEmpty() ? null : patients[0];
    }
}