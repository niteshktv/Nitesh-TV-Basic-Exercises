@isTest
public class OpportunityTriggerHandlerTest {
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
    }

    @isTest static void NextStep(){
        Opportunity opportunity = new Opportunity(Name='Demo', StageName='Negotiation/Review', CloseDate=Date.newInstance(2023, 3,14), NextStep='This is Next Step');
        insert opportunity;

        opportunity.StageName = 'Closed Won';
        try {
            update opportunity;
            System.assertEquals(true, opportunity.StageName == 'Closed Won');
        } catch (Exception e) {
            System.assertEquals(true, e.getMessage().contains('Next Step can not be Empty'));
        }
    }
}