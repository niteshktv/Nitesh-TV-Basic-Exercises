trigger UserTrigger on User (after insert) {
    UserTriggerHandler.addProfileToQueue(Trigger.new);
}