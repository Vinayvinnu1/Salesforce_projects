trigger casetrigger on Case (before insert) {
    CaseHandler.PriorityOnOrigin(trigger.new);
}