public with sharing class YTController {

    private static final String SEARCH_URL =
        'https://www.googleapis.com/youtube/v3/search';

    private static final String API_KEY =
        'AIzaSyB8qAfXDjDF04fhO5o326TgB-WXzKOi-7k';

    @AuraEnabled(cacheable=true)
    public static List<MyWrapper> getYTVideos(String searchKey) {

        searchKey =
            String.isBlank(searchKey)
            ? 'salesforce'
            : searchKey;

        Http http = new Http();

        HttpRequest req = new HttpRequest();

        String endpoint =
            SEARCH_URL +
            '?part=snippet' +
            '&maxResults=20' +
            '&type=video' +
            '&q=' +
            EncodingUtil.urlEncode(searchKey, 'UTF-8') +
            '&key=' + API_KEY;

        req.setEndpoint(endpoint);

        req.setMethod('GET');

        HttpResponse res = http.send(req);

        if (res.getStatusCode() != 200) {

            throw new AuraHandledException(
                'YouTube API Error: ' +
                res.getStatus()
            );
        }

        YouTubeResult.Response response =
            (YouTubeResult.Response)
            JSON.deserialize(
                res.getBody(),
                YouTubeResult.Response.class
            );

        List<MyWrapper> wrapperList =
            new List<MyWrapper>();

        for (YouTubeResult.Item itemObj :
             response.items) {

            MyWrapper wrap = new MyWrapper();

            wrap.videoId =
                itemObj.id.videoId;

            wrap.title =
                itemObj.snippet.title;

            wrap.description =
                itemObj.snippet.description;

            wrap.channelTitle =
                itemObj.snippet.channelTitle;

            wrap.publishedAt =
                String.valueOf(
                    itemObj.snippet.publishedAt
                );

            // Thumbnail Logic
            if (itemObj.snippet.thumbnails != null) {

                if (itemObj.snippet.thumbnails.medium != null &&
                    itemObj.snippet.thumbnails.medium.url != null) {

                    wrap.thumbnails =
                        itemObj.snippet
                        .thumbnails
                        .medium
                        .url;
                }

                else if (itemObj.snippet.thumbnails.high != null &&
                         itemObj.snippet.thumbnails.high.url != null) {

                    wrap.thumbnails =
                        itemObj.snippet
                        .thumbnails
                        .high
                        .url;
                }

                else {

                    wrap.thumbnails =
                    'https://via.placeholder.com/120x90?text=No+Image';
                }
            }
            else {

                wrap.thumbnails =
                'https://via.placeholder.com/120x90?text=No+Image';
            }

            wrapperList.add(wrap);
        }

        return wrapperList;
    }

    public class MyWrapper {

        @AuraEnabled
        public String videoId;

        @AuraEnabled
        public String title;

        @AuraEnabled
        public String description;

        @AuraEnabled
        public String thumbnails;

        @AuraEnabled
        public String channelTitle;

        @AuraEnabled
        public String publishedAt;
    }
}