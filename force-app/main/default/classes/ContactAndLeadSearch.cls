public class ContactAndLeadSearch {
    public static list<List<sObject>> searchContactsAndLeads(String Name){
        list<list<sObject>> leadConRecords =[Find :Name IN Name Fields Returning
                                      Contact(Id, FirstName, LastName),
                                      Lead(Id, FirstName, LastName)];
        return leadConRecords;
    }

}