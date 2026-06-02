/*trigger ConTrigger on Contact ( After delete) {
    ConHandle.notifyAccountOwner(Trigger.old);
}*/
trigger ContactTrigger on Contact (after insert) {

    ContactTriggerHandler.sendWelcomeEmail(Trigger.new);

}