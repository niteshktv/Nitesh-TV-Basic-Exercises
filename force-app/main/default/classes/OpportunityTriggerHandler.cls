public class OpportunityTriggerHandler{
    // If Opportunity stage is chnages from Negotiation/Review to closed Won than next field can be empty
    public static void opportunityStageChanged(List<Opportunity> opportunityList, List<Opportunity> oldOpportunityList) {
        Map<String, Opportunity> oldOpportunityMap = new Map<String, Opportunity>();
        for(Opportunity opportunity : oldOpportunityList){
            oldOpportunityMap.put(opportunity.Id, opportunity);
        }

        for(Opportunity opportunity : opportunityList){
            if (oldOpportunityMap.get(opportunity.Id).StageName != null &&
                oldOpportunityMap.get(opportunity.Id).StageName == 'Negotiation/Review' &&
                opportunity.StageName != null &&
                opportunity.StageName == 'Closed Won' &&
                opportunity.NextStep == null
            ) {
                opportunity.NextStep.addError('Next Step can not be Empty');
            }
        }
    }

    //Exercise-7 
    //Whenever an Opportunity is marked ‘Closed-Won’, auto create a Contract and activate it.
    public static void opportunityStageChangedToClosedWon(List<Opportunity> opportunityList){
        List<Contract> contractList = new List<Contract>();
        for(Opportunity opportunity : opportunityList){
            if(opportunity.StageName != null && opportunity.StageName == 'Closed Won' && opportunity.AccountId != null){
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
}