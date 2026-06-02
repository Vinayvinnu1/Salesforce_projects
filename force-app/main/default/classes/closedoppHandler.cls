public class closedoppHandler {
    Public static void CreateTask(List<opportunity> oplist){
        list<Task> NewTask = new List<Task>();
        for(opportunity opp : oplist){
            if(opp.stageName == 'closed won'){
                task t = new task(subject = 'Follow Up Test Task',
                                WhatId = opp.Id);
                NewTask.add(t);
            }
        }
        if(!NewTask.isEmpty()){
            insert NewTask;
        }
    }

}