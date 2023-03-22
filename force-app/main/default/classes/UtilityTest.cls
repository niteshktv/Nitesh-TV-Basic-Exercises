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
                lead.Phone = '1234567890';
            }else{
                lead.LeadSource = 'Phone Inquiry';
                lead.Phone = '34545';
            }
            leadList.add(lead);
        }
        if(isInsert){
            insert leadList;
        }
        return leadList;
    }

    public static List<Lead> createLeadWithoutLeadSource(String Name, Integer leadCount, boolean isInsert){
        List<Lead> leadList =  new List<Lead>();
        for(Integer i=0; i<leadCount; i++){
            Lead lead = new Lead();
            lead.LastName = Name +i;
            lead.Company = 'Thinkvibes';
            if(math.mod(i, 2) == 0){
                lead.Phone = '1234567';
            }else{
                lead.Email = 'mohit.guestuser@info.tv'+i;
            }
            leadList.add(lead);
        }
        if(isInsert){
            insert leadList;
        }
        return leadList;
    }

    public static List<Campaign> createCampaignForLead(Integer campaginCount, boolean isInsert){
        List<Campaign> campaignList = new List<Campaign>();
        for(Integer i=0; i<campaginCount; i++){
            Campaign campagin = new Campaign();
            if(i<2){
               campagin.Name='Web';
            }else if(i>=2 && i<4){
                campagin.Name='Phone Inquiry';
            }else if(i>=4 && i<6){
                campagin.Name='Partner Referral';
            }else if(i>=6 && i<8){
                campagin.Name='Purchased List';
            }else{
                campagin.Name='Other';
            }
            campaignList.add(campagin);
        }
        if(isInsert){
            insert campaignList;
        }
        return campaignList;
    }
    public static List<Lead> createLeadWithMultipleLeadSource(String Name,Integer leadCount, boolean isInsert){
        List<Lead> leadList =  new List<Lead>();
        for(Integer i=0; i<leadCount; i++){
            Lead lead = new Lead();
            lead.LastName = Name +i;
            lead.Company = 'Thinkvibes';
            lead.Phone = '1234567';
            if(i<2){
                lead.LeadSource='Web';
            }else if(i>=2 && i<4){
                lead.LeadSource='Phone Inquiry';
            }else if(i>=4 && i<6){
                lead.LeadSource='Partner Referral';
            }else if(i>=6 && i<8){
                lead.LeadSource='Purchased List';
            }else{
                lead.LeadSource='xyz';
            }
            leadList.add(lead);
        }
        if(isInsert){
            insert leadList;
        }
        return leadList;
    }

    public static List<Account> createAccount(String Name, Integer accountCount, boolean isInsert){
        List<Account> accountList = new List<Account>();
        for(Integer i=0; i<accountCount; i++){
            Account account = new Account();
            account.Name=Name +i;
            accountList.add(account);
        }
        if(isInsert){
            insert accountList;
        }
        return accountList;
    }
}