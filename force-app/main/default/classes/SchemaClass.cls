public class SchemaClass {
    public static void method(){
        map<string,Schema.SobjectType> sc = Schema.GetGlobalDescribe();
        system.debug(sc.Keyset());
    }
}