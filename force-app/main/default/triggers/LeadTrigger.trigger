trigger LeadTrigger on Lead (after insert, after update) {
	LeadTriggerHandler.beforeInsert(Trigger.new);
}