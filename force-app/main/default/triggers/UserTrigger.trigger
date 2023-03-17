trigger UserTrigger on User (before insert, before update, after insert, after update) {
    UserTriggerHandler.addProfileToQueue(Trigger.new);
}