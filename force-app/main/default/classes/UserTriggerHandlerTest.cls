@isTest
public with sharing class UserTriggerHandlerTest {
    @isTest static void userTriggerHandlerTest() {
        // Setup test data
        // Create a unique UserName
        String uniqueUserName = 'insidesales' + DateTime.now().getTime() + '@testorg.com';
        // This code runs as the system user
        Profile p = [SELECT Id,Name FROM Profile WHERE Name='Inside Sales'];
        User u = new User(Alias = 'standt', Email='insidesales@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName=uniqueUserName);
        insert u;
        Id userId = u.id;
        //Get the group you want. Queues are stored as group objects with a type of Queue
        List<Group> g = [select Id from Group where Name='Marketing Hot Leads' AND Type = 'Queue'];
        List<QueueSobject> queueSobject =[Select QueueId from QueueSObject Where SobjectType='Lead' limit 1];
        GroupMember member = new GroupMember();
        member.UserOrGroupId = userId;
        member.GroupId = g[0].Id;

        insert member;
        System.assertEquals(1, [select Id from Group where Name='Marketing Hot Leads' AND Type = 'Queue'].size());
    }
}