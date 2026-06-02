@isTest
public class TestVerifyDate {
    @isTest
    static void testDateWithin30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(10); // within 30 days

        Date result = VerifyDate.CheckDates(date1, date2);

        System.assertEquals(date2, result, 'Should return date2 when within 30 days');
    }

    @isTest
    static void testDateOutside30Days() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(40); // outside 30 days

        Date result = VerifyDate.CheckDates(date1, date2);

        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
        Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), totalDays);

        System.assertEquals(expectedEndOfMonth, result, 'Should return end of month date');
    }

    @isTest
    static void testDateInPast() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(-5); // past date

        Date result = VerifyDate.CheckDates(date1, date2);

        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
        Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), totalDays);

        System.assertEquals(expectedEndOfMonth, result, 'Should return end of month when date2 is in past');
    }

    @isTest
    static void testExact30DaysBoundary() {
        Date date1 = Date.today();
        Date date2 = date1.addDays(30); // exactly 30 days

        Date result = VerifyDate.CheckDates(date1, date2);

        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
        Date expectedEndOfMonth = Date.newInstance(date1.year(), date1.month(), totalDays);

        System.assertEquals(expectedEndOfMonth, result, 'Should return end of month when exactly 30 days');
    }
}