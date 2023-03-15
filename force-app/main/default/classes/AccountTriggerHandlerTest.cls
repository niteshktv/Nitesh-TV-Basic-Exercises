@isTest
public class AccountTriggerHandlerTest {
    //exercise 6
    //if no zip code is provided
    @isTest static void noZipCode(){
        Account account = new Account(Name='Mohit');
        insert account;

        System.assertEquals(1, [SELECT Id FROM Account].size());
    }
    // add single account with zip code starts with 5
    @isTest static void startsWith5(){
        Account account = new Account(Name='Mohit', ShippingPostalCode='567');
        insert account;

        System.assertEquals(1, [SELECT Id FROM Account].size());
    }
    // // exercise-6 point-1
    // // Add multiple account with zipCode starts with 5
    @isTest static void addMultipleAccount(){
        Account[] accounts = new Account[]{
            new Account(Name='Mohit', ShippingPostalCode='567'),
            new Account(Name='Mohit'),
            new Account(Name='Mohit', ShippingPostalCode='567', Industry='Shipping'),
            new Account(Name='Mohit', Industry='Technology')
        };
        insert accounts;
        System.assertEquals(2, [SELECT Id, Industry FROM Account where Industry='Biotechnology'].size());
    }

    @isTest static void checkBulkificationOfAccounts(){
        Account[] accounts = new Account[1000];
        for (Integer i=0; i<1000; i++) {
            if(i/2==0){
                accounts[i]=new Account(Name='Mohit', ShippingPostalCode='567'+ i, Industry='Shipping');
            }else{
                accounts[i]=new Account(Name='Mohit', ShippingPostalCode='567' + i, Industry='Technology');
            }
        }
        insert accounts;
    }


    // exercise-6 
    // add single account with zip code starts with 7
    @isTest static void startsWith7(){
        Account account = new Account(Name='Mohit');
        insert account;

        Opportunity opp = new Opportunity( AccountId= account.Id, Name='Demo', Closedate = Date.newInstance(2023,03,14), StageName='Qualification');
        insert opp;

        account.ShippingPostalCode='767';
        update account;

        System.assertEquals(1, [SELECT Id, AccountId, StageName From Opportunity Where AccountId = :account.Id and StageName = 'Closed Won'].size());

    }

    // Add multiple opportunities related to a single account with zipCode starts with 7
    @isTest static void addMultipleOpp(){
        Account account = new Account(Name='Mohit');
        insert account;

        Opportunity[] opportunities = new Opportunity[]{
            new Opportunity( AccountId= account.Id, Name='Demo1', Closedate = Date.newInstance(2023,03,12), StageName='Prospecting'),
            new Opportunity( AccountId= account.Id, Name='Demo2', Closedate = Date.newInstance(2023,03,15), StageName='Needs Analysis'),
            new Opportunity( AccountId= account.Id, Name='Demo3', Closedate = Date.newInstance(2023,03,16), StageName='Qualification'),
            new Opportunity( AccountId= account.Id, Name='Demo4', Closedate = Date.newInstance(2023,03,17), StageName='Value Proposition')
        };
        insert opportunities;

        account.ShippingPostalCode = '7678';
        update account;

        System.assertEquals(4, [SELECT Id, AccountId, StageName From Opportunity Where AccountId = :account.Id and StageName = 'Closed Won'].size());
    }
}