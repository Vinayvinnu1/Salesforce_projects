public with sharing class WeatherAPI {

    @AuraEnabled(cacheable=false)
    public static String getWeather(String city) {

        Http h = new Http();

        HttpRequest req = new HttpRequest();

        String encodedCity = EncodingUtil.urlEncode(city, 'UTF-8');

        String endpoint =
            'https://api.openweathermap.org/data/2.5/weather?q='
            + encodedCity +
            '&units=metric'
            + '&appid=faf1af4cf05920d3508051d14ec31ce7';

        req.setEndpoint(endpoint);

        req.setMethod('GET');

        HttpResponse rep = h.send(req);

        if(rep.getStatusCode() == 200) {

            return rep.getBody();
            

        } else {

            throw new AuraHandledException(
                'Weather data not found'
            );
        }
    }
}