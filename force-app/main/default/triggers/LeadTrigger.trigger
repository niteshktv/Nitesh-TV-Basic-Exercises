trigger LeadTrigger on Lead (before insert, before update) {
	LeadTriggerHandler.beforeInsert(Trigger.new);
}