trigger AccountTrigger on Account (Before insert, Before update, After insert, After update) {
    switch on Trigger.operationType {
        when BEFORE_INSERT, BEFORE_UPDATE {
            AccountTriggerHandler.zipCodeStartsWith5(Trigger.new);
        }
        when AFTER_INSERT, AFTER_UPDATE {
            AccountTriggerHandler.zipCodeStartsWith7(Trigger.new);
        }
    }
}