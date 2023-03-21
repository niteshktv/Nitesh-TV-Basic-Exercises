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

    public static List<Lead> createLead(String Name, Integer leadCount, boolean isInsert){
        List<Lead> leadList =  new List<Lead>();
        for(Integer i=0; i<leadCount; i++){
            Lead lead = new Lead();
            lead.LastName = Name +i;
            lead.Company = 'Thinkvibes';
            if(math.mod(i, 2) == 0){
                lead.LeadSource = 'Web';
            }else{
                lead.LeadSource = 'Phone Inquiry';
            }
            leadList.add(lead);
        }
        if(isInsert){
            insert leadList;
        }
        return leadList;
    }
    public static List<Lead> createLeadWithCountryUnitedStates(String Name, Integer leadCount, boolean isInsert){
        List<Lead> leadList =  new List<Lead>();
        for(Integer i=0; i<leadCount; i++){
            Lead lead = new Lead();
            lead.LastName = Name +i;
            lead.Country__c = 'United States';
            lead.Company = 'Thinkvibes';
            if(math.mod(i, 2) == 0){
                lead.LeadSource = 'Web';
            }else{
                lead.LeadSource = 'Phone Inquiry';
            }
            leadList.add(lead);
        }
        if(isInsert){
            insert leadList;
        }
        return leadList;
    }
}