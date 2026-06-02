//When a new Account is created, set Industry = 'Technology' if it is not provided.
public class AccountHandler {
/*    public static void SetIndustry(list<account> acclist){
        for(account ac: acclist){
            if(ac.Industry == null){
            ac.Description= ac.Industry;
            }}
    }
    //Do not allow deletion of an Account if it has related Contacts.
    public static void conCheckBeforeDelete(List<Account> accList){
    
    Set<Id> accIds = new Set<Id>();
    for(Account acc : accList){
        accIds.add(acc.Id);
    }

    // Get Accounts that have Contacts
    Set<Id> accWithContacts = new Set<Id>();
    for(Contact con : [SELECT AccountId FROM Contact WHERE AccountId IN :accIds]){
        accWithContacts.add(con.AccountId);
    }

    // Prevent deletion
    for(Account acc : accList){
        if(accWithContacts.contains(acc.Id)){
            acc.addError('Cannot delete Account because it has related Contacts.');
        }
    }
}
    //When an Account is created, automatically create a default Contact for it.
    public static void CreateCon(list<Account> acclist){
        list<contact> contoInsert = new list<contact>();
        for(account ac :acclist){
            contact con = new contact
                (LastName = ac.Name,
                phone = ac.Phone,
                AccountId = ac.Id);
                contoInsert.add(con);
        }
        if(!contoInsert.isEmpty()){
            insert contoInsert;
        }
    }*/
}