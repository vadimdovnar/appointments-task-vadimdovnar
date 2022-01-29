public class CreateDoctorController {
    
    public DV_Doctor__c doctor { get; set; }
    public String selectedDoctor { get; set; }
    public List<DV_Doctor__c> doctorsList { get; set; }
    public Integer pageSize { get; set; } 
    public List<DV_Doctor__c> doctorsForTable { get; set; }
    
    
    
    public CreateDoctorController() {
        doctor = new DV_Doctor__c();
        doctorsList = DoctorAppointmentModel.getDoctors();
        doctorsForTable = new List<DV_Doctor__c>();
        pageSize = 10;
        setCon.setPageSize(pageSize);
    }
    
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {                
                setCon = new ApexPages.StandardSetController(doctorsList);
            }
			setCon.setPageSize(pageSize);            
            doctorsForTable = setCon.getRecords();            
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
    
    public List<SelectOption> getDoctorItems() {
        List<SelectOption> items = new List<SelectOption>();
        List<DV_Doctor__c> doctors = DoctorAppointmentModel.getDoctors();
        for (DV_Doctor__c doctor : doctors) {
            items.add(new SelectOption(doctor.id, doctor.Name));
        }
        return items;
    }
    
    public void createDoctor() {
        try {
            insert doctor;
            setCon = new ApexPages.StandardSetController( DoctorAppointmentModel.getDoctors() );
            setCon.setPageSize(pageSize);
            doctorsForTable = setCon.getRecords();
            resetDoctorData();
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.INFO, 'The Doctor successfully created');
            ApexPages.addMessage(message);
            
            
        } catch (Exception e) {
            resetDoctorData();
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, 'ERROR failed to add doctor');
            ApexPages.addMessage(message);
            
        }
    }
    
    public void resetDoctorData() {
        doctor.Name = null;
        doctor.Working_Hours_Start__c = null;
        doctor.Working_Hours_End__c = null;
        doctor.Id = null;
    }
}