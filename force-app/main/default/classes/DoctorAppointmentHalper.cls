public with sharing class DoctorAppointmentHalper {
    public static Boolean hasDoctorsAppointments(DV_Appointment__c inputAppointment, Integer startTime, Integer endTime) {
        List<DV_Appointment__c> appointments = DoctorAppointmentModel.getAppointmentsInfo();
        
        for (DV_Appointment__c record : appointments) {
            Integer appointmentDate = record.Appointment_Date__c.hour() * 60 + record.Appointment_Date__c.minute();
            Integer durationInMins = record.Duration_in_minutes__c.intValue();
            Boolean doctorAvailable = true;

            if ((inputAppointment.DV_Doctor__c == record.DV_Doctor__c) && (inputAppointment.Appointment_Date__c == record.Appointment_Date__c)) {
                return doctorAvailable;
            } else if ((inputAppointment.Appointment_Date__c.date() == record.Appointment_Date__c.date()) && (inputAppointment.DV_Doctor__c == record.DV_Doctor__c)) {
                if ((startTime > appointmentDate) && startTime < (appointmentDate + durationInMins) || ((startTime < appointmentDate) && ((endTime) > appointmentDate))) {
                    return doctorAvailable;
                }
            }
        }
        return false;
    }
	
    public static Boolean hasDoctorAvailable(DV_Appointment__c inputAppointment, Integer startTime, Integer endTime) {
        List<DV_Doctor__c> doctors = DoctorAppointmentModel.getDoctors();
        
        for (DV_Doctor__c doctor : doctors) {
            Integer hoursStart = doctor.Working_Hours_Start__c.hour() * 60 + doctor.Working_Hours_Start__c.minute();
            Integer hoursEnd = doctor.Working_Hours_End__c.hour() * 60 + doctor.Working_Hours_End__c.minute();

            if (inputAppointment.DV_Doctor__c == doctor.ID) {
                Boolean cond4 = ((startTime < hoursStart) || (startTime > hoursEnd));
                Boolean cond5 = (endTime > hoursEnd);

                return cond4 || cond5;
            }
        }
        return false;
    }

    
}