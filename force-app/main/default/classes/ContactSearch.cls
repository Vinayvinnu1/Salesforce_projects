public class ContactSearch {
    public static list<contact> searchForContacts(String ConLastName, String PostalCode){
List<Contact> conist =[Select Id, FirstName, LastName 
                       from Contact 
                       Where LastName = :ConLastName 
                       AND MailingPostalCode = :PostalCode];        
         if(conist.isEmpty()){
            return Null;
         }
        return conist;
    }
}