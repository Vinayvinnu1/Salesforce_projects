@isTest
public class TestRestrictContactByName {

    // ✅ Test valid Contact insert (should pass)
    @isTest
    static void testValidContactInsert() {
        Contact c = new Contact(
            FirstName = 'Vinay',
            LastName = 'Kumar'
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        System.assertNotEquals(null, c.Id, 'Contact should be inserted successfully');
    }

    // ❌ Test invalid Contact insert (should fail)
    @isTest
    static void testInvalidContactInsert() {
        Contact c = new Contact(
            FirstName = 'Test',
            LastName = 'INVALIDNAME'
        );

        Test.startTest();
        try {
            insert c;
            System.assert(false, 'Exception should have been thrown');
        } catch (DmlException e) {
            System.assert(
                e.getMessage().contains('not allowed'),
                'Error message should contain validation message'
            );
        }
        Test.stopTest();
    }

    // ❌ Test invalid update (should fail)
    @isTest
    static void testInvalidContactUpdate() {
        Contact c = new Contact(
            FirstName = 'Update',
            LastName = 'ValidName'
        );
        insert c;

        // Update to invalid name
        c.LastName = 'INVALIDNAME';

        Test.startTest();
        try {
            update c;
            System.assert(false, 'Exception should have been thrown on update');
        } catch (DmlException e) {
            System.assert(
                e.getMessage().contains('not allowed'),
                'Error message should contain validation message'
            );
        }
        Test.stopTest();
    }

    // ✅ Test valid update (should pass)
    @isTest
    static void testValidContactUpdate() {
        Contact c = new Contact(
            FirstName = 'Good',
            LastName = 'Name'
        );
        insert c;

        c.LastName = 'BetterName';

        Test.startTest();
        update c;
        Test.stopTest();

        System.assertEquals('BetterName', c.LastName, 'Update should be successful');
    }
}