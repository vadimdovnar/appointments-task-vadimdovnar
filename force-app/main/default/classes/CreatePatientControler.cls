public class CreatePatientControler {
    
    
    public DV_Patient__c patient { get; set; }
    public List<DV_Patient__c> patientsList { get; set; }
    public Integer pageSize { get; set; } 
    public List<DV_Patient__c> patientsForTable { get; set; }
    
    
    
    public CreatePatientControler() {
        patient = new DV_Patient__c();
        patientsList = DoctorAppointmentModel.getPatients();
        patientsForTable = new List<DV_Patient__c>();
        pageSize = 10;
        setCon.setPageSize(pageSize);
    }
    
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {                
                setCon = new ApexPages.StandardSetController(patientsList);
            }
			setCon.setPageSize(pageSize);            
            patientsForTable = setCon.getRecords();            
            return setCon;
        }
        set;
    }
    
    public PageReference refreshPageSize() {
         setCon.setPageSize(pageSize);
         return null;
    }
    
    public void getFirst() {
        setCon.first();
        setCon.getRecords();
    }
    
    public void getPrevious() {
        setCon.previous();
        setCon.getRecords();
    }
    
    public void getNext() {
        setCon.next();
        setCon.getRecords();
    }
    
    public void getLast() {
        setCon.last();
        setCon.getRecords();
    }
    
    public void createPatient() {
        try {
            insert patient;
            setCon = new ApexPages.StandardSetController( DoctorAppointmentModel.getPatients() );
            setCon.setPageSize(pageSize);
            patientsForTable = setCon.getRecords();
            resetPatientData();
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.INFO, 'The Patient successfully created');
            ApexPages.addMessage(message);
            
        } catch (Exception e) {
            resetPatientData();
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, 'ERROR failed to add patient');
            ApexPages.addMessage(message);
            
        }
    }
    
    public void resetPatientData() {
        patient.Name = null;
        patient.Id = null;
    }
}