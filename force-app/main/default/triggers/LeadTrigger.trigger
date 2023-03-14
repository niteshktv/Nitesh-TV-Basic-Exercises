trigger LeadTrigger on Lead (before insert, before update, after insert, after update) {
	switch on Trigger.operationType {
		when AFTER_INSERT, AFTER_UPDATE {
			LeadTriggerHandler.checkAfterLead(Trigger.new);
		}
		when BEFORE_INSERT, BEFORE_UPDATE {
			LeadTriggerHandler.checkBeforeLead(Trigger.new);
		}
	}
}