@isTest
private class LeadTriggerHandlerTest{
    //Exercise-1 Point-1
    //Country is US
    @isTest static void usCountryTest(){
        Lead usLead = new Lead(LastName='Singh', Country__c='United States', LeadSource = 'Web');
        try {
            insert usLead;
        } catch (Exception e) {
            System.assertEquals('System.DmlException', e.getTypeName());
        }
        System.assertEquals(0, [SELECT Id FROM Lead].size());
    }
    
    // Test phone when country is US
    @isTest static void usCountryWithPhoneTest(){
        Lead usLead = new Lead(LastName='Singh',Company='Thinkvibes', Country__c='United States', Phone='1234567890', LeadSource = 'Web');
        insert usLead;
        System.assertEquals(1, [SELECT Id FROM Lead].size());
    }

    // country is other than US
    @isTest static void otherCountry(){
        Lead usLead1 = new Lead(LastName='Singh',Company='Thinkvibes', Country__c='India', Phone='12345', LeadSource = 'Web');
        insert usLead1;
        
        Lead usLead2 = new Lead(LastName='Singh',Company='Thinkvibes', Country__c='India', Email='Mohit.Singh@thinkvibes.com', LeadSource = 'Web');
        insert usLead2;
        System.assertEquals(2, [SELECT Id FROM Lead].size());
    }
    // No Country is selected 
    @isTest static void emailTest(){    
        Lead usLead = new Lead(LastName='Singh',Company='Thinkvibes', Email='Mohit.Singh@thinkvibes.com', LeadSource = 'Web');
        insert usLead;
        System.assertEquals(1, [SELECT Id FROM Lead].size());
    }
    // No Country is selected 
    @isTest static void phoneTest(){    
        Lead usLead = new Lead(LastName='Singh',Company='Thinkvibes', Phone='8432895', LeadSource = 'Web');
        insert usLead;
        System.assertEquals(1, [SELECT Id FROM Lead].size());
    }
    // No email or phone Test
    @isTest static void withoutEmailOrPhoneTest(){    
        Lead usLead = new Lead(LastName='Singh',Company='Thinkvibes', LeadSource = 'Web');
        try{
            insert usLead;
        }catch(Exception e){
            System.assertEquals('System.DmlException', e.getTypeName());
        }
        System.assertEquals(0, [SELECT Id FROM Lead].size());
    }

    // Exercise-2 Point-1
    // Email ends with .games, .garden, .glass, .free, .talk 
    @isTest static void EndDomainTest(){
        Lead lead1 = new Lead(LastName='Singh',Company='Thinkvibes', Email='mohit.singh@thinkvibes.garden', LeadSource = 'Web');
        try{
            insert lead1;
        }catch(Exception e){
            System.assertEquals('System.DmlException', e.getTypeName());
        }
        System.assertEquals(0, [SELECT Id FROM Lead].size());
    }

    // Exercise-2 Point-1
    // Email starts with Career@, contact@, info@ Test
    @isTest static void StartDomainTest(){
        Lead lead1 = new Lead(LastName='Singh',Company='Thinkvibes', Email='Info@thinkvibes.com', LeadSource = 'Web');
        try{
            insert lead1;
        }catch(Exception e){
            System.assertEquals('System.DmlException', e.getTypeName());
        }
        System.assertEquals(0, [SELECT Id FROM Lead].size());
    }
    // Exercise-3 
    // Check email length Test 
    @isTest static void EmailLengthLessThan20(){
        Lead lead = new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Web');
        insert lead;
		System.debug([SELECT ID, Email from Lead Where Id = :lead.Id limit 1].Email);
        System.assertEquals('mohit@tv.comz', [SELECT ID, Email from Lead Where Id = :lead.Id limit 1].Email);
    }

    // Exercise-4 
    //If lead status is not selected
    @isTest static void leadSourceNotSelected(){
        Lead lead = new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com');
        try{
            insert lead;
        }catch(Exception e){
            System.debug(e.getTypeName());
            System.assertEquals('System.DmlException', e.getTypeName());
        }
        System.assertEquals(0, [Select ID from lead].size());
    }
    
    //leadSource is selceted
    @isTest static void leadSourceSelected(){
        Campaign campagin= new Campaign(Name = 'Web');
        insert campagin;
        
        Lead lead = new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Web');
        insert lead;
        
        System.assertEquals(1, [Select ID from CampaignMember].size());
    }
    //Add multiple leads
    @isTest static void addMultipleLeads(){
        Campaign[] campaigns = new Campaign[]{
            new Campaign(Name= 'Web'),
            new Campaign(Name= 'Phone Inquiry'),
            new Campaign(Name= 'Partner Referral'),
            new Campaign(Name= 'Purchased List'),
            new Campaign(Name= 'Other')    
        };
        insert campaigns;
        Lead[] leads = new Lead[]{
             new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Web'),
             new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Phone Inquiry'),
           	 new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Partner Referral'),
             new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Purchased List'),
             new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Web'),
             new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Mohit'),
             new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Other'),
             new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'xyz')
        };
         insert leads;
        System.assertEquals(6, [Select ID from CampaignMember].size());
    }
}