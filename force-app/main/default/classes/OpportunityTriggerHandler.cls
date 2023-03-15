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
    

    //Exercise-8
    //Opportunity Close Date should fall under the current month
    public static void checkOpportunityClosedDate(List<Opportunity> opportunityList){
        for(Opportunity opportunity : opportunityList){
            if(opportunity.CloseDate > Date.newInstance(Date.today().month() == 12 ? Date.today().year() + 1 : Date.today().year(), Date.today().month() == 12 ? 12 : Date.today().month() + 1, 1) - 1){
                opportunity.CloseDate.addError('Opportunity Close Date should fall under the current month');
            }
        }
    }
}