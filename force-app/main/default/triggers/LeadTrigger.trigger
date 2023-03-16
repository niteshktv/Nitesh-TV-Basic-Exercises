trigger LeadTrigger on Lead (before insert, before update, after insert, after update) {
	if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
		LeadTriggerHandler.checkLeadBeforeUpdate(Trigger.new);
	}
	if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
		LeadTriggerHandler.checkLeadAfterUpdate(Trigger.new);
        LeadTriggerHandler.addCampaginToLead(Trigger.new);
	}
}