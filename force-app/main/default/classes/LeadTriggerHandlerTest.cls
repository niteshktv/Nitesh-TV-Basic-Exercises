@isTest
private class LeadTriggerHandlerTest{
    @isTest static void usCountryTest(){
        Lead usLead = new Lead(LastName='Singh', Country__c='United States');
        try {
            insert usLead;
        } catch (Exception e) {
            System.assertEquals('System.DmlException', e.getTypeName());
        }
        System.assertEquals(0, [SELECT Id FROM Lead].size());
    }
    
    @isTest static void usCountryWithPhoneTest(){
        Lead usLead = new Lead(LastName='Singh',Company='Thinkvibes', Country__c='United States', Phone='1234567890');
        insert usLead;
        System.assertEquals(1, [SELECT Id FROM Lead].size());
    }
    @isTest static void otherCountry(){
        Lead usLead1 = new Lead(LastName='Singh',Company='Thinkvibes', Country__c='India', Phone='12345');
        insert usLead1;
        
        Lead usLead2 = new Lead(LastName='Singh',Company='Thinkvibes', Country__c='India', Email='Mohit.Singh@thinkvibes.com');
        insert usLead2;
        System.assertEquals(2, [SELECT Id FROM Lead].size());
    }
    @isTest static void emailTest(){    
        Lead usLead = new Lead(LastName='Singh',Company='Thinkvibes', Email='Mohit.Singh@thinkvibes.com');
        insert usLead;
        System.assertEquals(1, [SELECT Id FROM Lead].size());
    }
    @isTest static void phoneTest(){    
        Lead usLead = new Lead(LastName='Singh',Company='Thinkvibes', Phone='8432895');
        insert usLead;
        System.assertEquals(1, [SELECT Id FROM Lead].size());
    }
    @isTest static void withoutEmailOrPhoneTest(){    
        Lead usLead = new Lead(LastName='Singh',Company='Thinkvibes');
        try{
            insert usLead;
        }catch(Exception e){
            System.assertEquals('System.DmlException', e.getTypeName());
        }
        System.assertEquals(0, [SELECT Id FROM Lead].size());
    }
    
}