//When an Opportunity is created: If CloseDate is blank, set it to Today + 7 days
public class OppHandler {
    public static void CloseDateCheck(List<Opportunity> oppList){
        for(Opportunity opp : oppList){
            if(opp.CloseDate == null){
                opp.CloseDate = System.today().addDays(7);
            }
        }
    }
}