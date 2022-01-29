public without sharing class DoctorAppointmentController {
    public DV_Appointment__c appointment { get; set; }
    public String selectedDoctor { get; set; }
    public String selectedPatient { get; set; }
    public DV_Doctor__c defaultDoctor { get; set; }
    
    public Integer pageSize{get;set;} 
    public Integer resaultSizePage{get; set;} 
    public List<SelectOption> paginationSizeOptions{get;set;}
  
    public DoctorAppointmentController() {
        appointment = new DV_Appointment__c();
        
        pageSize = 10;
        paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('5','5'));
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('15','15'));
        paginationSizeOptions.add(new SelectOption('20','20'));
        
        defaultDoctor = new DV_Doctor__c();
        defaultDoctor.Working_Hours_Start__c = Time.newInstance(0, 0, 0, 0);
        defaultDoctor.Working_Hours_End__c = Time.newInstance(0, 0, 0, 0);
    }
      
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {                
                setCon = new ApexPages.StandardSetController( DoctorAppointmentModel.getSortListOfAppointmentByDoctorName() );
                setCon.setPageSize(pageSize);  
                resaultSizePage = setCon.getResultSize();
            }            
            return setCon;
        }
        set;
    }    
     
    //Changes the size of pagination
    public PageReference refreshPageSize() {
         setCon.setPageSize(pageSize);
         return null;
    }
 
    // Initialize setCon and return a list of record    
     
    public List<DV_Appointment__c> getAppointmentsList() {
         return (List<DV_Appointment__c>) setCon.getRecords();
    }

    public void sortByDoctorName() {
        setCon = new ApexPages.StandardSetController( DoctorAppointmentModel.getSortListOfAppointmentByDoctorName() );
        updateSetController();
    }
    public void sortByPatientName() {
		setCon = new ApexPages.StandardSetController( DoctorAppointmentModel.getSortListOfAppointmentByPatientName() );
        updateSetController();
    }
    public void getSortedListByDoctors() {
        if(selectedDoctor != null) {
            setCon = new ApexPages.StandardSetController( DoctorAppointmentModel.getSortListOfAppointmentBySelectedDoctor(selectedDoctor) );
            appointment.DV_Doctor__c = DoctorAppointmentModel.getDoctorById(selectedDoctor).id;
        } else {
			setCon = new ApexPages.StandardSetController( DoctorAppointmentModel.getAppointmentsInfo() );
        }
        updateSetController();
    }
   
    public DV_Doctor__c getDoctorDetails() {
        Boolean isSelected = !String.isBlank(selectedDoctor);
        return (isSelected) ? DoctorAppointmentModel.getDoctorById(selectedDoctor) : defaultDoctor;
    }
    
    public void setSelectedPatientAppointment() {
        appointment.DV_Patient__c = DoctorAppointmentModel.getPatientById(selectedPatient).id;
    }

    public List<SelectOption> getDoctorItems() {
        List<SelectOption> items = new List<SelectOption>();
        List<DV_Doctor__c> doctors = DoctorAppointmentModel.getDoctors();
        for (DV_Doctor__c doctor : doctors) {
            items.add(new SelectOption(doctor.id, doctor.Name));
        }
        return items;
    }
    public List<SelectOption> getPatientItems() {
        List<SelectOption> items = new List<SelectOption>();
        List<DV_Patient__c> patients = DoctorAppointmentModel.getPatients();
        for (DV_Patient__c patient : patients) {
            items.add(new SelectOption(patient.id, patient.Name));
        }
        return items;
    }
    
    public void createdNewAppointment() {  
        try {
            System.debug(appointment);
            insert appointment;
        	setCon = new ApexPages.StandardSetController( DoctorAppointmentModel.getSortListOfAppointmentByLastModifiedDate() );
        	updateSetController();
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.INFO, 'The Appointment successfully created');
            ApexPages.addMessage(message);
            resetAppointmentData();
        } catch (Exception e) {
            System.debug(appointment);
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, 'ERROR failed to add appointnent');
            ApexPages.addMessage(message);
            resetAppointmentData();
        }
        
    }
    
    public void resetAppointmentData() {
        appointment.DV_Doctor__c = null;
        appointment.DV_Patient__c = null;
        appointment.Appointment_Date__c = null;
        appointment.Duration_in_minutes__c = null;
        appointment.Id = null;
    }
    
    public void updateSetController() {
        setCon.setPageSize(pageSize);
        resaultSizePage = setCon.getResultSize();
        setCon.getRecords();
    }
          
    
}