trigger OppTrigger on Opportunity (before insert) {
    OppHandler.CloseDateCheck(Trigger.new);
}