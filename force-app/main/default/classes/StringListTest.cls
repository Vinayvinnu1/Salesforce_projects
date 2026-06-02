public class StringListTest {

    public static List<String> generateStringList(Integer num) {
        
        List<String> strList = new List<String>();
        
        for(Integer i = 0; i < num; i++){
            strList.add('Test ' + i);
        }
        
        return strList;
    }
}