public class AccHandler {
    public static void SetDescription(list<Account>  acclist){
        for(account ac : acclist){
            if(ac.Description == null){
                ac.Description = 'this is a sample description';
            }
        }
    }
    //if an account is being deleted and if it has related contact 
    public static void CheckContact(list<account> acclist){
       set<id> accid = new set<id>();
        for(Account a : acclist){
            accid.add(a.id);
        }
        set<id> accwithCon = new set<id>();
        for(contact con : [select AccountId from contact where AccountId IN : accid]){
            accwithcon.add(con.AccountId);
        }
        for(account ac : acclist){
            if(accwithCon.contains(ac.id)){
                ac.addError('This account has related contacts');
                
            }
        }
    }
  /*  //When an Account is created, automatically create a default Contact for it
    public static void CreateCon(list<account> acclist){
        list<contact> contoInsert = new list<contact>();
        for(account ac :acclist){
            contact a= new contact();
            a.LastName = ac.Name;
            a.Phone = ac.Phone;
            a.AccountId = ac.id;
            contoInsert.add(a);
        }
        if(!contoInsert.isEmpty()){
            insert contoInsert;
        }
    }*/
    // 2. Update contact phone when Account phone changes
    public static void updateContactPhone(List<Account> newList, Map<Id, Account> oldMap){

        Set<Id> accIds = new Set<Id>();

        // Find accounts where phone changed
        for(Account acc : newList){
            account oldac = oldmap.get(acc.id);
            if(acc.Phone != oldac.Phone){
                accIds.add(acc.Id);
            }
        }

        if(accIds.isEmpty()) return;

        // Get related contacts
        List<Contact> conList = [
            SELECT Id, Phone, AccountId
            FROM Contact
            WHERE AccountId IN :accIds
        ];

        // Map accountId -> phone
        Map<Id, String> accPhoneMap = new Map<Id, String>();
        for(Account acc : newList){
            if(accIds.contains(acc.Id)){
                accPhoneMap.put(acc.Id, acc.Phone);
            }
        }

        // Update contacts
        for(Contact con : conList){
            con.Phone = accPhoneMap.get(con.AccountId);
        }

        if(!conList.isEmpty()){
            update conList;
        }
    }
 public static void SetDesc(List<Account> acclist){
        List<Account> accToUpdate = new List<Account>();
        
        for(Account ac : acclist){
            accToUpdate.add(new Account(
                Id = ac.Id,
                Description = 'this is a restored account'
            ));
        }
        
        update accToUpdate;
    }
}