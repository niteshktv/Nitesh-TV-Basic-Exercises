public class OpportunityTriggerHandler{
    // If Opportunity stage is chnages from Negotiation/Review to closed Won than next field can be empty
    public static void changeOpportunityStageToClosedWon(Map<Id ,Opportunity> newOpportunityMap, Map<Id, Opportunity> opportunityMap) {
        String currentUserId = UserInfo.getUserId();
        User currentUser = [Select Id, Profile.Name From User where Id =:currentUserId limit 1];

        for (Id newOpportunityId : newOpportunityMap.keySet()) {
            Opportunity newOpportunity = newOpportunityMap.get(newOpportunityId);
            Opportunity oldOpportunity = opportunityMap.get(newOpportunityId);
            if (
                currentUser.Profile.Name != 'System Administrator' &&
                oldOpportunity.StageName == 'Negotiation/Review' &&
                newOpportunity.StageName == 'Closed Won' &&
                newOpportunity.NextStep == null
            ) {
                newOpportunity.NextStep.addError('Next Step can not be Empty');
            }
        }
    }

    //Exercise-7 
    //Whenever an Opportunity is marked ‘Closed-Won’, auto create a Contract and activate it.
    public static void createContractForOpportunityAccount(List<Opportunity> opportunityList){
        List<Contract> contractList = new List<Contract>();
        for(Opportunity opportunity : opportunityList){
            if(opportunity.StageName == 'Closed Won' && opportunity.AccountId != null){
                contractList.add(new Contract(
                    AccountId = opportunity.AccountId,
                    Status = 'Draft',
                    ContractTerm =  12,
                    StartDate = opportunity.CloseDate + 1
                ));
            }
        }
        insert contractList;

        for(Contract contract : contractList){
            contract.Status = 'Activated';
        }
        update contractList;
    }
    

    //Exercise-8
    //Opportunity Close Date should fall under the current month
    public static void validateOpportunityCloseDate(List<Opportunity> opportunityList){
        for(Opportunity opportunity : opportunityList){
            if(opportunity.CloseDate > Date.newInstance(Date.today().month() == 12 ? Date.today().year() + 1 : Date.today().year(), Date.today().month() == 12 ? 12 : Date.today().month() + 1, 1) - 1){
                opportunity.CloseDate.addError('Opportunity Close Date should fall under the current month');
            }
        }
    }
}