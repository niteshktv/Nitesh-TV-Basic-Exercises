@isTest
public class OpportunityTriggerHandlerTest {
    // If stage is chnages from Negotiation/Review to closed won and NextStep field is empty Test
	@isTest static void noNextStep(){
        Opportunity opportunity = new Opportunity(Name='Demo', StageName='Negotiation/Review', CloseDate=Date.newInstance(2023, 3,14));
        insert opportunity;

        opportunity.StageName = 'Closed Won';
        try {
            update opportunity;
            System.assertEquals(true, opportunity.StageName == 'Closed Won');
        } catch (Exception e) {
            System.assertEquals(true, e.getMessage().contains('Next Step can not be Empty'));
        }
        System.assertEquals(1, [Select ID , StageName from Opportunity].size());
    }

    // If stage is chnages from Negotiation/Review to closed won and NextStep field is not empty Test
    @isTest static void NextStep(){
        Opportunity opportunity = new Opportunity(Name='Demo', StageName='Negotiation/Review', CloseDate=Date.newInstance(2023, 3,14), NextStep='This is Next Step');
        insert opportunity;

        opportunity.StageName = 'Closed Won';
        try {
            update opportunity;
            System.assertEquals(true, opportunity.StageName == 'Closed Won');
        } catch (Exception e) {
            System.assertEquals(false, e.getMessage().contains('Next Step can not be Empty'));
        }
        System.assertEquals(1, [Select ID , StageName from Opportunity where StageName='Closed Won'].size());
    }

    // Exercise-7 
    //Opportunity Stage
    @isTest static void opportunityStageSetToClosedWon(){
        Account account = new Account(Name='Mohit');
        insert account;

        Opportunity opportunity = new Opportunity(Name='Demo', CloseDate=Date.newInstance(2023, 3,15), AccountId= account.Id, StageName='Prosepecting');
        insert opportunity;

        opportunity.StageName='Closed Won';
        update opportunity;
        System.assertEquals(1, [Select Id, AccountId from Contract where AccountId = :opportunity.AccountId].size());
    }
    //testing for bulkification
    @isTest static void opportunityStageSetToClosedWonBulkTest(){
        Account account = new Account(Name='Mohit');
        insert account;

        Opportunity[] opportunities = new Opportunity[1000];
        for(Integer i=0; i< 1000; i++){
            if(i/2==0){
                opportunities[i] = new Opportunity(Name='Demo'+i, CloseDate=Date.newInstance(2023, 3,15), AccountId= account.Id, StageName='Prosepecting');
            }else{
                opportunities[i] = new Opportunity(Name='Demo'+i, CloseDate=Date.newInstance(2023, 3,15), AccountId= account.Id, StageName='Qualification');
            }          
        }
        insert opportunities;

        for(Opportunity opp : opportunities){
            opp.StageName='Closed Won';
        }
        update opportunities;
        System.assertEquals(1000, [Select Id, AccountId from Contract where AccountId = :account.Id].size());
    }
    //Exercise-8 
    //Opportunity Close Date should fall under the current month Test
    @isTest static void checkOpportunityClosedDate(){
        Opportunity futureOpportunity = new Opportunity(Name='Demo', CloseDate=Date.newInstance(2023, 4,2), StageName='Prosepecting');
        try{
            insert futureOpportunity;
        }catch(Exception e){
            System.assertEquals(true, e.getMessage().contains('Opportunity Close Date should fall under the current month'));
        }
        System.assertEquals(0, [Select id from Opportunity].size());
    }
    @istest static void checkForBulk(){
        Opportunity[] opportunities = new Opportunity[]{
            new Opportunity(Name='Demo', CloseDate=Date.newInstance(2023, 3,20), StageName='Prosepecting'),
            new Opportunity(Name='Demo', CloseDate=Date.newInstance(2023, 3,2), StageName='Qualification'),
            new Opportunity(Name='Demo', CloseDate=Date.newInstance(2023, 3,15), StageName='Qualification')
        };
        insert opportunities;
        System.assertEquals(3, [Select id from Opportunity].size());
    }
}