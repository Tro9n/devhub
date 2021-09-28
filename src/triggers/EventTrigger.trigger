trigger EventTrigger on Event__c (before insert, before update) {
    EventTriggerHandler.triggerHandle(Trigger.new);
}