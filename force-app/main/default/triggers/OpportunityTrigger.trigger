trigger OpportunityTrigger on Opportunity(After update, After insert){
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHandler.opportunityStageChanged(Trigger.new, Trigger.old);
        OpportunityTriggerHandler.opportunityStageChangedToClosedWon(Trigger.new);
    } 
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        OpportunityTriggerHandler.checkOpportunityClosedDate(Trigger.new);
    }
}