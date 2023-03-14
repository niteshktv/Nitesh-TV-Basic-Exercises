trigger OpportunityTrigger on Opportunity(After update){
    OpportunityTriggerHandler.opportunityStageChanged(Trigger.new, Trigger.old);
}