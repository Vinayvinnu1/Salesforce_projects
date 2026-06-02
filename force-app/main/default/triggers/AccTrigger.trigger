//When a new Account is created, set default description if it is not provided.
trigger AccTrigger on Account (before insert, before update, before delete, after insert, after update, after undelete) {
  /*  if( trigger.isbefore &&(trigger.isinsert ||trigger.isupdate)){
    AccHandler.SetDescription(Trigger.new);
    }
    if(trigger.isBefore && trigger.isDelete){
        AccHandler.CheckContact(Trigger.old);    
            }
    //if(trigger.isAfter && Trigger.isInsert){
    //    AccHandler.CreateCon(Trigger.new);
   // }
   // if(trigger.isUpdate){
   //     AccHandler.updateContactPhone(Trigger.new, trigger.oldmap);
   // }*/
    if(trigger.isundelete){
        AccHandler.SetDesc(Trigger.new);
    }
}