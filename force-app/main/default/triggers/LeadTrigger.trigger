trigger LeadTrigger on Lead (before insert, before update) {
	LeadTriggerHandler.checkLead(Trigger.new);
}