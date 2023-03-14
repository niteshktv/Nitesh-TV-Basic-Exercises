public class OpportunityTriggerHandler{
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
}