/**
 * Created by andriilahun on 27.09.2021.
 */

public with sharing class ContactController {
    @AuraEnabled
    public static List<Contact> getAllDoctors() {
        List<Contact> cnctList = [SELECT Id, FirstName, LastName FROM Contact WHERE RecordType.DeveloperName = 'Doctor'];
        return cnctList;
    }

    @AuraEnabled
    public static List<Event__c> getAllEvents(String data) {
        Datetime dateStart = Datetime.valueOf(data);
        List<Event__c> events = [SELECT Id, Appointment_Start__c, Appointment_Finish__c, Doctor__c FROM Event__c WHERE Appointment_Start__c != :dateStart];
        System.debug(events);
        return events;
    }
}