public class LeadTriggerHandler {
    public static void beforeInsert(List<Lead> leadList){
        for(Lead lead : leadList){
            if(lead.Country == 'United States' && (lead.Phone == null || string.valueOf(lead.Phone).length() < 10)){
                lead.addError('Phone should be of 10 characters');
            }else if(lead.Email == null && lead.Phone == null){
                lead.addError('Either email or phone is required');
            }
        }
    }
}