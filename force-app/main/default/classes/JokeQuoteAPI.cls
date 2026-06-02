public class JokeQuoteAPI {

    @AuraEnabled(cacheable=false)
    public static Map<String,String> getData() {

        Http h = new Http();
        HttpRequest r = new HttpRequest();

        r.setEndpoint('https://official-joke-api.appspot.com/random_joke');
        r.setMethod('GET');

        HttpResponse res = h.send(r);

        Map<String,Object> data =
        (Map<String,Object>)JSON.deserializeUntyped(res.getBody());

        Map<String,String> result = new Map<String,String>();

        result.put('setup', (String)data.get('setup'));
        result.put('punchline', (String)data.get('punchline'));

        return result;
    }
}