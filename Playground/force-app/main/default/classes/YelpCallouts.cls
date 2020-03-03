public with sharing class YelpCallouts {
    //CREATE HTTP RESPONSE
    public static HttpResponse yelpResponse(String urlpath){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.yelp.com/v3/'+urlpath);
        request.setMethod('GET');
        request.setHeader('Authorization', 
                          'bearer SQlb3QZqYXfS3cerCrGu6Ikk6wW4lNN5s9gAXv66lOuHeXprjJsEOuC0s-Y0ClALJBIdQ1mqav9sEoJK6pmbUHEtye7bCB9QyC2_pLp9wenln42FhA4Ab7hmtb41XnYx');
        
        HttpResponse response = http.send(request);
        
        return response;
    }
    
    //BUSINESS SEARCH
    public static List<Object> businessSearch(String location){
        String ep = 'businesses/search?location=' + location;
        HttpResponse response = yelpResponse(ep);

        List<Object> bsns = getBusinesses(response);
        
 		return bsns;
    }
    
    //PHONE SEARCH
    public static List<Object> phoneSearch(String phone){
        String ep = 'businesses/search/phone?phone=' + phone;
        HttpResponse response = yelpResponse(ep);
        
        List<Object> bsns = getBusinesses(response);
        
 		return bsns;
    }
    
    //TRANSACTION SEARCH
    public static List<Object> transactionSearch(String location){
        String ep = 'transactions/delivery/search?location=' + location;
        HttpResponse response = yelpResponse(ep);
        
        List<Object> bsns = getBusinesses(response);
        
 		return bsns;
    }
    
    //GET BUSINESSES FROM SEARCHES
    private static List<Object> getBusinesses(HttpResponse response){
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        
        List<Object> businesses = (List<Object>) results.get('businesses');
        
        for(Integer i=0; i<businesses.size(); i++){
            Map<String, Object> info = (Map<String, Object>) businesses[i];
            
            System.debug(info.get('name'));
        } 
        System.debug(businesses);
        
        return businesses;
    }
    
    //GET BUSINESS DETAIL
    public static String businessDetail(String businessID){
        String ep = 'businesses/'+ businessID;
        HttpResponse response = yelpResponse(ep);
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        
        String name = (String)results.get('name');
        System.debug('Name: ' + name);
        
        System.debug('Phone: ' + results.get('phone'));
        System.debug('Rating: ' + results.get('rating'));
        System.debug('Price: ' + results.get('price'));
        
        return name;
    }
    
    //GET BUSINESS REVIEWS
    public static List<Object> businessReviews(String businessID){
        String ep = 'businesses/'+businessId+ '/reviews';
        HttpResponse response = yelpResponse(ep);
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        
        List<Object> reviews = (List<Object>) results.get('reviews');
        
        for(Integer i=0; i<reviews.size(); i++){
            Map<String, Object> info = (Map<String, Object>) reviews[i];
            Map<String, Object> user = (Map<String, Object>) info.get('user');
            
            System.debug('User: ' + user.get('name') + 
                         ' Rating: ' + info.get('rating'));
            System.debug('Review: ' + info.get('text'));
            System.debug(' ');
        }
        return reviews;
    }
    
    //AUTOCOMPLETE
    public static Map<String, Object> autocomplete(String txt){
        String ep = 'autocomplete?text='+txt;
        HttpResponse response = yelpResponse(ep);
        
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
       
        System.debug('Terms:' + results.get('terms'));
        System.debug('Businesses:' + results.get('businesses'));
        System.debug('Categories:' + results.get('categories'));
        
        return results;
    }   
}