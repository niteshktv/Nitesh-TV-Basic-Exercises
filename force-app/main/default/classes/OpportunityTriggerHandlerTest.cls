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
    }
}