public class LeadTriggerHandler {
    //After Insert or  Update
    public static void checkAfterLead(List<Lead> leadList){
        for(Lead lead : leadList){
            // If Country Belongs to United States than must have 10 digits phone number
            if(lead.Country__c == 'United States' && (lead.Phone == null || string.ValueOf(lead.Phone).length() < 10)){
                lead.addError('Phone should be of 10 characters');
            }
            // Either phone or email is required to save record
            if(lead.Email == null && lead.Phone == null){
                lead.addError('Either email or phone is required');
            }
            //Exercise-2
            // Lead email should not end with the following domains: .games .garden .glass .free .talk
            if(checkLastDomain(lead)){
                lead.addError('Email Can not ends with .games, .garden, .glass, .free, .talk ');
            }
            // lead should not email starts with info@, contact@, Career@.
            if(checkStartDomain(lead)){
                lead.addError('Email Can not starts with Career@, contact@, info@');
            }
            //Exercise-4
            // lead source is required to save record
            if(Lead.LeadSource == null){
                lead.addError('Enter a lead source');
            }
            //Exercise-5
            // Email does not contains 'a' between the 5th character and the 12th character
            if(aBeetween5To12(lead)){
                lead.addError('character "a" in the Lead objects Email field between the 5th character and the 12th character');
            }
        }
    }

    // Exercise-2 
    // Lead email should not end with the following domains: .games .garden .glass .free .talk
    public static boolean checkLastDomain(Lead lead){
        String[] domains = new String[]{'.games', '.garden', '.glass', '.free', '.talk'};
        for(String domain  : domains){
            if (lead.Email != null && lead.Email.endsWith(domain)) {
                return true;
            }
        }
        return false;
    }
    // Exercise-2 
    // lead should not email starts with info@, contact@, Career@.
    public static boolean checkStartDomain(Lead lead){
        String[] domains = new String[]{'info@', 'contact@', 'Career@'};
        for(String domain  : domains){
            if (lead.Email != null && lead.Email.startsWith(domain)) {
                return true;
            }
        }
        return false;
    }

    // Exercise-3
    // Is email length less than 20  than append with 'z'
    public static void checkBeforeLead(List<Lead> leadList){
        for(Lead lead :  leadList){
            checkLeadEmail(lead);
        }
    }

    private static void checkLeadEmail(Lead lead){
        if(lead.Email != null && lead.Email.length() < 20){
            lead.Email = lead.Email + 'z';
        }
    }

    //Exercise-4 
    //auto add related campagin to a lead based on lead source
    public static void addCampaginToLead(List<Lead> leadList){
        Set<String> leadSource = new Set<String>();

        for(Lead lead : leadList){
            if(lead.LeadSource != null){
                leadSource.add(lead.LeadSource);
            }
        }

        List<Campaign> campaignList = [SELECT ID, Name FROM Campaign WHERE Name IN :leadSource ];

        Map<String, Campaign> campaignMap = new Map<String, Campaign>();
        for(Campaign campaign : campaignList){
            campaignMap.put(campaign .Name, campaign);
        }

        List<CampaignMember> campaignMemberList = new List<CampaignMember>();
        for(Lead lead : leadList){
            if(lead.LeadSource != null && campaignMap.containsKey(lead.LeadSource)){
                campaignMemberList.add(new CampaignMember(CampaignId = campaignMap.get(lead.LeadSource).Id, LeadId = lead.Id, Status = 'sent'));
            }
        }
        insert campaignMemberList;

    }
    
    //Exercise-5 
    // Email does not contains 'a' between the 5th character and the 12th character
    private static boolean aBeetween5To12(Lead lead){
            if(lead.Email != null && lead.Email.length() > 12 && lead.Email.substring(4, 12).contains('a')){
                return true;
            }
        return false;
    }
    
    
}