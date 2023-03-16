@isTest
public with sharing class TaskTriggerHandlerTest {
    //Whenever a task (related to an Opportunity) with Subject “1stAppointment” is marked as completed then auto update related opportunity Stage to Negotiation.
    @isTest static void taskTriggerTest() {
        Opportunity opportunity = new Opportunity(Name='Demo', LeadSource='Web', CloseDate= Date.newInstance(2023, 3,16), StageName='Qualification');
        insert opportunity;
        Task task = new Task(Subject='1stAppointment', WhatId=opportunity.Id);
        insert task;

        task.Status = 'Completed';
        update task;

        System.assertEquals(1, [Select Id, StageName from Opportunity Where Id = :task.WhatId and StageName='Negotiation/Review'].size());
    }
}