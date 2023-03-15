trigger TaskTrigger on Task (after insert, after update) {
    TaskTriggerHandler.checkTask(Trigger.new);
}