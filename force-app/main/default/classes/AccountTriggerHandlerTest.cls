@isTest
public class AccountTriggerHandlerTest {
    //exercise 6
    //if no zip code is provided
    @isTest static void noZipCodeTest(){
        List<Account> accountList = UtilityTest.createAccount('Demo Account', 5, true);

        System.assertEquals(5, [SELECT Id FROM Account].size());
    }
    // add single account with zip code starts with 5
    @isTest static void zipCodeStartsWith5(){
        List<Account> accountList = UtilityTest.createAccount('Demo Account', 10, false);
        for(Integer i=0; i<accountList.size(); i++){
            if(i<5){
                accountList[i].ShippingPostalCode='5678';
            }
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(accountList, false);
        Test.stopTest();

        System.assertEquals(5, [SELECT Id FROM Account Where Industry='Biotechnology'].size());
    }


    // exercise-6 
    // add single account with zip code starts with 7
    @isTest static void zipCodeStartsWith7(){
        List<Account> accountList = UtilityTest.createAccount('Demo Account', 2, true);
        List<Opportunity> opportunityList = UtilityTest.createOpportunity('Demo Opportunity', 10, true);
        for(Integer i=0; i<opportunityList.size(); i++){
            if(i<5){
                opportunityList[i].AccountId = accountList[0].Id;
            }else{
                opportunityList[i].AccountId = accountList[1].Id;
            }
        }
        for(Account account: accountList){
            account.ShippingPostalCode='7893';
        }
        Test.startTest();
        List<Database.SaveResult> opportunityResults = Database.update(opportunityList, false);
        List<Database.SaveResult> accountResults = Database.update(accountList, false);
        Test.stopTest();
        Set<String> accountIdList = new Set<String>();
        for(Account account : accountList){
            accountIdList.add(account.Id);
        }
        System.assertEquals(10, [SELECT Id, AccountId, StageName From Opportunity Where AccountId = :accountIdList and StageName = 'Closed Won'].size());
    }
}