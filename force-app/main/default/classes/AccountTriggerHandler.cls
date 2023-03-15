public class AccountTriggerHandler {
    // Exercise-6 
    // Zip code starts with 5 than change industry to Biotechnology
    public static void zipCodeStartsWith5(List<Account> accountList){
        for(Account account : accountList){
            if(account.ShippingPostalCode != null && account.ShippingPostalCode.startsWith('5')){
                account.Industry = 'Biotechnology';
            }
        }
    }

    // Zip code starts with 7 than change stage of opportunities to closed won related to that account 
    public static void zipCodeStartsWith7(List<Account> accountList){
        List<String> accountIdList = new List<String>();
        for(Account account : accountList){
            if(account.ShippingPostalCode != null && account.ShippingPostalCode.startsWith('7')){
                accountIdList.add(account.Id);
            }
        }
        if(accountIdList.isEmpty()){
            return;
        }
        List<Opportunity> oppList = [SELECT Id,AccountId, StageName  FROM Opportunity Where AccountId IN :accountIdList and (StageName != 'Closed Won' OR StageName != 'Closed Lost') ];
                for(Opportunity opp : oppList){
                    opp.StageName = 'Closed Won';
                }
        update oppList;
    }
}