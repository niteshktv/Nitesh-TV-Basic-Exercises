public class OpportunityTriggerHandler{
    // If Opportunity stage is chnages from Negotiation/Review to closed Won than next field can be empty
    public static void changeOpportunityStageToClosedWon(Map<Id ,Opportunity> opportunityMap, Map<Id, Opportunity> oldOpportunityMap) {
        String currentUserId = UserInfo.getUserId();
        User currentUser = [Select Id, Profile.Name From User where Id =:currentUserId limit 1];

        for (Id currentId : opportunityMap.keySet()) {
            Opportunity currentOpp = opportunityMap.get(currentId);
            Opportunity oldOpp = oldOpportunityMap.get(currentId);
            if (
                currentUser.Profile.Name != 'System Administrator' &&
                oldOpp.StageName == 'Negotiation/Review' &&
                currentOpp.StageName == 'Closed Won' &&
                currentOpp.NextStep == null
            ) {
                currentOpp.NextStep.addError('Next Step can not be Empty');
            }
        }
    }

    //Exercise-7 
    //Whenever an Opportunity is marked ‘Closed-Won’, auto create a Contract and activate it.
    public static void createContractStageChangesToClosedWon(List<Opportunity> opportunityList){
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
    public static void checkOpportunityClosedDate(List<Opportunity> opportunityMap){
        for(Opportunity opportunity : opportunityMap){
            if(opportunity.CloseDate > Date.newInstance(Date.today().month() == 12 ? Date.today().year() + 1 : Date.today().year(), Date.today().month() == 12 ? 12 : Date.today().month() + 1, 1) - 1){
                opportunity.CloseDate.addError('Opportunity Close Date should fall under the current month');
            }
        }
    }
}