@isTest
public class OpportunityTriggerHandlerTest {
    // If stage is changes from Negotiation/Review to closed won and NextStep field is empty Test
	@isTest static void testOpportunityWithoutNextStep(){
        List<Opportunity> opportunityList = UtilityTest.createOpportunity('Demo', 10, true);
        for(Opportunity opportunity : opportunityList){
            opportunity.StageName = 'Closed Won';
        }
        Test.startTest();
        List<Database.UpsertResult> results = Database.upsert(opportunityList, false);
        Test.stopTest();
        for (Database.UpsertResult sr : results) {
            if (sr.isSuccess()) {
                System.debug('Successfully inserted Opportunity. opp ID: ' + sr.getId());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {                   
                    System.assertEquals('Next Step can not be Empty',err.getMessage());
                }
            }
        }
        System.assertEquals(5, [Select id, StageName from Opportunity where StageName='Closed Won'].size());
    }

    // If stage is chnages from Negotiation/Review to closed won and NextStep field is not empty Test
    @isTest static void testOpportunityWithNextStep(){
        List<Opportunity> opportunityList = UtilityTest.createOpportunity('Demo', 10, false);
        for(Opportunity opportunity : opportunityList){
            if(opportunity.StageName == 'Negotiation/Review'){
                opportunity.NextStep = 'Next Step';
            }
            opportunity.StageName = 'Closed Won';
        }
        Test.startTest();
        List<Database.UpsertResult> results = Database.upsert(opportunityList, false);
        Test.stopTest();
        for (Database.UpsertResult sr : results) {
            if (sr.isSuccess()) {
                System.debug('Successfully inserted Opportunity. opp ID: ' + sr.getId());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {                   
                    System.assertEquals('Next Step can not be Empty',err.getMessage());
                }
            }
        }
        System.assertEquals(10, [Select id, StageName from Opportunity where StageName='Closed Won'].size());
    }


    // Exercise-7 
    //Opportunity Stage
    @isTest static void opportunityStageSetToClosedWon(){
        // List<Account> accountList = UtilityTest.createAccountsForOpportunity('Test', 2, true);
        Account account = new Account(Name='Mohit');
        insert account;
        List<Opportunity> opportunityList = UtilityTest.createOpportunity('Demo', 10, false);
        // for(Integer i=0; i<accountList.size(), i++){
            for(Opportunity opportunity : opportunityList){
                if(opportunity.StageName == 'Negotiation/Review'){
                    opportunity.NextStep = 'Next Step';
                }
                opportunity.AccountId = account.Id;
                opportunity.StageName = 'Closed Won';
            }
            insert opportunityList;
        // }
        List<String> opportunityAccountId = new List<String>();
        for(Opportunity opportunity : opportunityList){
            opportunityAccountId.add(opportunity.AccountId);
        }
        Test.startTest();
        List<Database.UpsertResult> results = Database.upsert(opportunityList, false);
        Test.stopTest();
        for (Database.UpsertResult sr : results) {
            if (sr.isSuccess()) {
                System.debug('Successfully inserted Opportunity. opp ID: ' + sr.getId());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {      
                    System.debug(err.getMessage());             
                    // System.assertEquals('Next Step can not be Empty',err.getMessage());
                }
            }
        }
        
        System.assertEquals(10, [Select Id, AccountId from Contract where AccountId IN :opportunityAccountId].size());
    }

    //Exercise-8 
    //Opportunity Close Date should fall under the current month Test
    @isTest static void checkOpportunityClosedDate(){
        List<Opportunity> opportunityList = UtilityTest.createOpportunity('Demo', 10, false);
        for(Opportunity opportunity : opportunityList){
            if(opportunity.StageName == 'Negotiation/Review'){
                opportunity.CloseDate = Date.newInstance(2023, Date.today().month()+1, 23);
            }
        }
        // insert opportunityList;
        Test.startTest();
        List<Database.UpsertResult> results = Database.upsert(opportunityList, false);
        Test.stopTest();
        for (Database.UpsertResult sr : results) {
            if (sr.isSuccess()) {
                // System.debug('Successfully inserted Opportunity. opp ID: ' + sr.getId());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {                   
                    System.assertEquals('Opportunity Close Date should fall under the current month',err.getMessage());
                }
            }
        }
        System.assertEquals(5, [Select id, StageName from Opportunity].size());
    }
}