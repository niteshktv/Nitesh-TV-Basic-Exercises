trigger AccountTrigger on Account (Before insert, Before update, After insert, After update) {
    
    if(Trigger.isBefore && (Trigger.isUpdate || Trigger.isInsert)){
        AccountTriggerHandler.zipCodeStartsWith5(Trigger.new);
    }
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)){
        AccountTriggerHandler.zipCodeStartsWith7(Trigger.new);
    }
}