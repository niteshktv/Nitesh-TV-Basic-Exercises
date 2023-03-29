@isTest
public with sharing class TaskTriggerHandlerTest {
    //Whenever a task (related to an Opportunity) with Subject “1stAppointment” is marked as completed then auto update related opportunity Stage to Negotiation.
    @isTest static void taskTriggerTest() {
        List<Opportunity> opportunityList = UtilityTest.createOpportunityForTask('Demo', 10, true);
        List<Task> taskList = UtilityTest.createtask('1stAppointment',10, true);
        for (Integer i = 0; i < 10; i++) {
            taskList[i].WhatId = opportunityList[i].Id;
            taskList[i].Status = 'Completed';
        }
        Test.startTest();
        List<Database.SaveResult> results = Database.update(taskList, false);
        Test.stopTest();
        Set<String> taskWhatIdSet = new Set<String>();
        for(Task task:taskList){
            taskWhatIdSet.add(task.WhatId);
        }
        System.assertEquals(10, [Select Id, StageName from Opportunity Where Id In :taskWhatIdSet and StageName='Negotiation/Review'].size());
    }
}