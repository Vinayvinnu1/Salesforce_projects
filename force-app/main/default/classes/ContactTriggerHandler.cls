public class ContactTriggerHandler {

    public static void sendWelcomeEmail(List<Contact> conList) {

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Contact con : conList) {

            // Check email is not blank
            if(con.Email != null) {

                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

                mail.setToAddresses(new List<String>{con.Email});

                mail.setSubject('Welcome to Our Company');

                mail.setPlainTextBody(
                    'Hello ' + con.FirstName + ',\n\n' +
                    'Your contact record has been created successfully.\n\n' +
                    'Thank You.'
                );

                emails.add(mail);
            }
        }

        // Send all emails at once
        if(!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }
}