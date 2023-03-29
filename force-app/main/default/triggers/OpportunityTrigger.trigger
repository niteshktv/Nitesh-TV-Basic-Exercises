trigger OpportunityTrigger on Opportunity(After update, After insert){
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHandler.changeOpportunityStageToClosedWon(Trigger.newMap, Trigger.oldMap);
        OpportunityTriggerHandler.createContractForOpportunityAccount(Trigger.new);
    } 
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        OpportunityTriggerHandler.validateOpportunityCloseDate(Trigger.new);
    }
}