trigger TaskTrigger on Task (after insert, after update) {
    TaskTriggerHandler.validateTaskRecords(Trigger.new);
}