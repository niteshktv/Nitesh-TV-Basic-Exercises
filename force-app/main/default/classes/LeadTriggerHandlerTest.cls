@isTest
private class LeadTriggerHandlerTest{
    //Exercise-1 Point-1
    //Country is US
    @isTest static void usCountryTest(){
        List<Lead> leadList = UtilityTest.createLeadWithCountryUnitedStates('Demo Lead', 10, false);
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(leadList, false);
        Test.stopTest();
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                for(Database.Error err : sr.getErrors()) {                
                    System.assertEquals(true,err.getMessage().contains('Phone should be of 10 characters'));
                }
            }
        }
        // assert records where country is united states and phone number length is 10
        System.assertEquals(5, [Select id, Country__c from Lead where Country__c='United States'].size());
    }

    // country is other than US
    @isTest static void otherCountry(){
        List<Lead> leadList = UtilityTest.createLead('Demo Lead', 10, false);
        for(Lead lead: leadList){
            lead.Country__c = 'India';
            lead.Phone = '47766';
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(leadList, false);
        Test.stopTest();
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {                 
                    System.assertEquals(true,err.getMessage().contains('Phone should be of 10 characters'));
                }
            }
        }
        //assert records where country is other than United States
        System.assertEquals(10, [Select id, Country__c from Lead where Country__c='India'].size());
    }
    // Either phone or email is required to save the record
    @isTest static void emailOrPhoneTest(){
        List<Lead> leadList = UtilityTest.createLead('Demo Lead', 10, false);
        for(Integer i=0; i<leadList.size(); i++){
            if(i<=3){
                leadList[i].Phone = '78357';
            } 
            if(i>3 && i<=7){
                leadList[i].Email = 'Demo.user@gmail.com';
            }
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(leadList, false);
        Test.stopTest();
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                for(Database.Error err : sr.getErrors()) {                 
                    System.assertEquals(true,err.getMessage().contains('Either email or phone is required'));
                }
            }
        }
        // either phone number is provided or not.
        System.assertEquals(8, [Select id from Lead].size());
    }

    // Exercise-2 Point-1
    // Email ends with .games, .garden, .glass, .free, .talk 
    @isTest static void EndDomainTest(){
        List<Lead> leadList = UtilityTest.createLead('Demo Lead', 10, false);
        for(Integer i=0; i<leadList.size(); i++){
            if(i<3){
                leadList[i].Email = 'guestuser@demo.games';
            }else if(i>=3 && i<7){
                leadList[i].Email = 'guestuser@demo.glass';
            }else if(i>=7){
                leadList[i].Email = 'guestusers@demo.free';
            }
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(leadList, false);
        Test.stopTest();
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {                 
                    System.assertEquals(true,err.getMessage().contains('Email Can not ends with .games, .garden, .glass, .free, .talk'));
                }
            }
        }
        System.assertEquals(0, [Select id from Lead].size());
    }

    // Exercise-2 Point-1
    // Email starts with Career@, contact@, info@ Test
    @isTest static void startDomainTest(){
        List<Lead> leadList = UtilityTest.createLead('Demo Lead', 10, false);
        for(Integer i=0; i<leadList.size(); i++){
            if(i<3){
                leadList[i].Email = 'career@demo.com';
             }else{
                leadList[i].Email ='Demo@demo.com';
             }
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(leadList, false);
        Test.stopTest();
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                for(Database.Error err : sr.getErrors()) {                 
                    System.assertEquals(true,err.getMessage().contains('Email Can not starts with Career@, contact@, info@'));
                }
            }
        }
        // assert successful insert records where email not starts with Career@, contact@, info@ Test
        System.assertEquals(7, [Select id from Lead].size());
    }
    // Exercise-3 
    // Check email length Test 
    @isTest static void appendZForEmailLessThen20CharTest(){
        Lead lead = new Lead(LastName='Singh', Company='Thinkvibes', Email='Mohit@tv.com', LeadSource = 'Web');
        insert lead;
        System.assertEquals('mohit@tv.comz', [SELECT ID, Email from Lead Where Id = :lead.Id limit 1].Email);
    }

    // Exercise-4 
    //If lead Source is required
    @isTest static void leadSourceRequiredTest(){
        List<Lead> leadList = UtilityTest.createLeadWithoutLeadSource('Demo Lead', 10, false);
        for(Integer i=0; i<leadList.size(); i++){
            if(i<3){
                leadList[i].LeadSource = 'Web';
            }else if(i>=3 && i<7){
                leadList[i].LeadSource = 'Phone Inquiry';
            }
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(leadList, false);
        Test.stopTest();
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {                 
                    System.assertEquals(true,err.getMessage().contains('Enter a lead source'));
                }
            }
        }
        //assert successful insert records where lead source is given
        System.assertEquals(7, [Select id from Lead].size());
    }
    //Add multiple leads
    @isTest static void addCampaignToLeadTest(){
        List<Campaign> campaignList = UtilityTest.createCampaignForLead(10, true);
        List<Lead> leadList = UtilityTest.createLeadWithMultipleLeadSource('Demo Lead',10, true);
        System.assertEquals(8, [Select ID from CampaignMember].size());
    }

    // Exercise-5 Point-1 Test
    @isTest static void isEmailContainsABetweenTest(){
        List<Lead> leadList = UtilityTest.createLead('Demo Lead', 10, false);
        for(Integer i=0; i<leadList.size(); i++){
            if(i<5){
                leadList[i].Email = 'Nitesh.kumawat@demo.tv';
             }else{
                leadList[i].Email ='guestuser@demo.info';
             }
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(leadList, false);
        Test.stopTest();
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {                
                    System.assertEquals(true,err.getMessage().contains('character "a" in the Lead objects Email field between the 5th character and the 12th character'));
                }
            }
        }
        //assert successful insert records where lead leads email does not contains character a in between
        System.assertEquals(5, [Select id from Lead].size());
    }
    //Exercise-11 
    // whenever lead is marked as Unqualified, the Reason (reason__c) field is required.it shouldn’t trigger for cloned and new records.
    @isTest static void makeReasonRequiredTest(){
        List<Lead> leadList = UtilityTest.createLead('Demo Lead', 10, false);
        for(Integer i=0; i<leadList.size(); i++){
            leadList[i].Phone = '8473209';
            leadList[i].Status='Unqualified';
            if(i<5){
                leadList[i].Reason__c = 'Custom Reason';
            }
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(leadList, false);
        Test.stopTest();
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {                 
                    System.assertEquals(true,err.getMessage().contains('Reason is required to save the record'));
                }
            }
        }
        System.assertEquals(5, [Select id from Lead].size());
    }
}