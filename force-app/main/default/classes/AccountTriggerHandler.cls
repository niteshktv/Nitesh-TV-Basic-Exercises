public class AccountTriggerHandler {
    // Exercise-6 
    // Zip code starts with 5 than change industry to Biotechnology
    public static void updateIndustryToBiotechnology(List<Account> accountList){
        for(Account account : accountList){
            if(account.ShippingPostalCode != null && account.ShippingPostalCode.startsWith('5')){
                account.Industry = 'Biotechnology';
            }
        }
    }

    // Zip code starts with 7 than change stage of opportunities to closed won related to that account 
    public static void updateOpportunityStageBasedOnZipCode(List<Account> accountList){
        Set<String> accountIdSet = new Set<String>();
        for(Account account : accountList){
            if(account.ShippingPostalCode != null && account.ShippingPostalCode.startsWith('7')){
                accountIdSet.add(account.Id);
            }
        }
        if(!accountIdSet.isEmpty()){
            List<Opportunity> opportunityList = [SELECT Id,AccountId, StageName  FROM Opportunity Where AccountId IN :accountIdSet and (StageName != 'Closed Won' OR StageName != 'Closed Lost') ];
            for(Opportunity opp : opportunityList){
                opp.StageName = 'Closed Won';
            } 
            update opportunityList;
        }
    }
}