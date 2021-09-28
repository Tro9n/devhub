public with sharing class EventTriggerHandler {

    public static void triggerHandle(List<Event__c> events) {
        Boolean hasAppointment = false;
        List<Event__c> listToInsert = new List<Event__c>();
        if (Trigger.isInsert && Trigger.isBefore) {
            for (Event__c event : events) {
                List<Event__c> oldEvents = [SELECT Id, Doctor__c, Appointment_Start__c, Appointment_Finish__c FROM Event__c WHERE Doctor__c = :event.Doctor__c];
                for (Event__c doctorAppointment : oldEvents) {
                    System.debug(oldEvents);
                    if (event.Appointment_Start__c != doctorAppointment.Appointment_Start__c
                            && event.Appointment_Finish__c != doctorAppointment.Appointment_Finish__c) {
                        hasAppointment = true;
                    }
                }
                listToInsert.add(event);
            }
        }
        if (!hasAppointment) {
            insert listToInsert;
            sendEmail(listToInsert[0].Doctor__c);
            System.debug('mylist ' +listToInsert);
        }
    }

    public static void sendEmail(String id) {
        Contact contact = [SELECT Id, Email FROM Contact WHERE Id = :id LIMIT 1];
        System.debug('email: ' + contact);
        EmailManager.sendMail(contact.Email, 'Appointment booking',
                'Congratulation, you have successfully registered to the doctor');
    }
}