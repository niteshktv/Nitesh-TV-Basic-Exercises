public class LeadTriggerHandler {
    public static void checkLead(List<Lead> leadList){
        for(Lead lead : leadList){
            if(lead.Country__c == 'United States' && (lead.Phone == null || string.valueOf(lead.Phone).length() < 10)){
                lead.addError('Phone should be of 10 characters');
            }else if(lead.Email == null && lead.Phone == null){
                lead.addError('Either email or phone is required');
            }else if(checkLastDomain(lead)){
                lead.addError('Email Can not ends with .games, .garden, .glass, .free, .talk ');
            }else if(checkStartDomain(lead)){
                lead.addError('Email Can not starts with Career@, contact@, info@');
            }
        }
    }

    public static boolean checkLastDomain(Lead lead){
        String[] domains = new String[]{'.games', '.garden', '.glass', '.free', '.talk'};
        for(String domain  : domains){
            if (lead.Email != null && lead.Email.endsWith(domain)) {
                return true;
            }
        }
        return false;
    }
    public static boolean checkStartDomain(Lead lead){
        String[] domains = new String[]{'info@', 'contact@', 'Career@'};
        for(String domain  : domains){
            if (lead.Email != null && lead.Email.startsWith(domain)) {
                return true;
            }
        }
        return false;
    }
}