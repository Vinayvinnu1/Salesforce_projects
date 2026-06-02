public class CaseHandler {
    public static void PriorityOnOrigin(list<case> clist){
        for(case c : clist){
            if(c.origin == 'Email'){
                c.priority = 'medium';
            }
            if(c.origin == 'Phone'){
                c.priority ='High';
            }
            else{
                c.priority ='Low';
            }
        }
    }
}