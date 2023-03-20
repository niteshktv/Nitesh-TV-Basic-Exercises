public with sharing class UtilityTest {
    public static List<Opportunity> createOpportunity(String Name, Integer opportunityCount, boolean isInsert) {
        List<Opportunity> opportunityList = new List<Opportunity>();
        for(Integer i=0; i<opportunityCount; i++){
            Opportunity opportunity = new Opportunity();
            opportunity.Name= Name + i;
            if(math.mod(i, 2) == 0){
                opportunity.StageName='Negotiation/Review';
            }else{
                opportunity.StageName='Prospecting';
            }
            opportunity.CloseDate = Date.today()+1;
            opportunityList.add(opportunity);
        }
        if(isInsert){
            insert opportunityList;
        }
        return opportunityList;
    }
}