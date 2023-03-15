public class AccountTriggerHandler {
    public static void zipCodeStartsWith5(List<Account> accountList){
        for(Account account : accountList){
            if(account.ShippingPostalCode != null && account.ShippingPostalCode.startsWith('5')){
                account.Industry = 'Biotechnology';
            }
        }
    }

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