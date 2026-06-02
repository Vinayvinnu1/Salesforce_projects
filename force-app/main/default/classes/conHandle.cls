public class conHandle {
    //When a Contact is deleted → send an email to the Account Owner
    public static void notifyAccountOwner(List<Contact> oldContacts){

        Set<Id> accountIds = new Set<Id>();

        // Collect Account Ids
        for(Contact con : oldContacts){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }

        if(accountIds.isEmpty()) return;

        // Query Accounts with Owner details
        Map<Id, Account> accMap = new Map<Id, Account>(
            [SELECT Id, Name, Owner.Email, Owner.Name 
             FROM Account 
             WHERE Id IN :accountIds]
        );

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        // Prepare Emails
        for(Contact con : oldContacts){
            if(con.AccountId != null && accMap.containsKey(con.AccountId)){

                Account acc = accMap.get(con.AccountId);

                if(acc.Owner.Email != null){
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                    mail.setToAddresses(new List<String>{acc.Owner.Email});
                    mail.setSubject('Contact Deleted Notification');
                    mail.setPlainTextBody(
                        'Hello ' + acc.Owner.Name + ',\n\n' +
                        'The contact "' + con.LastName + '" has been deleted from your account "' + acc.Name + '".'
                    );

                    emails.add(mail);
                }
            }
        }

        // Send Emails
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }
}