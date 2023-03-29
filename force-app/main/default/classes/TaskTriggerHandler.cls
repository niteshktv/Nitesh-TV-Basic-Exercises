public with sharing class TaskTriggerHandler {
    //Whenever a task (related to an Opportunity) with Subject “1stAppointment” is marked as completed then auto update related opportunity Stage to Negotiation.
    public static void validateTaskRecords(List<Task> taskList){
        List<String> taskWhatId = new List<String>();
        for(Task task : taskList ){
            if(
                task.Subject == '1stAppointment' &&
                task.Status == 'Completed'
            ){
                taskWhatId.add(task.WhatId);
            }
        }

        List<Opportunity> opportunityList = [Select Id, StageName from Opportunity where Id in :taskWhatId and StageName != 'Negotiation/Review'];
        for(Opportunity opportunity : opportunityList){
            opportunity.StageName = 'Negotiation/Review';
        }
        update opportunityList;
    }
}