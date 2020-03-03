@isTest
private class YelpCalloutTest {
    private static void setup(String txtfile){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource(txtfile);
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        Test.setMock(HttpCalloutMock.class, mock);
    }
	@isTest static void test1(){
        
        setup('MockBusiness');
        
        //TEST BUSINESS SEARCHES
        List<Object> bsn1 = YelpCallouts.businessSearch('San Francisco');
        List<Object> bsn2 = YelpCallouts.phoneSearch('+14152520800');
        List<Object> bsn3 = YelpCallouts.transactionSearch('San Francisco');
        
        System.assertEquals(1, bsn1.size());
        System.assertEquals(1, bsn2.size());
        System.assertEquals(1, bsn3.size());
    }
    
    @isTest static void test2(){
        
        setup('MockBusinessDetails');
        
        //TEST BUSINESS DETAILS
        String name = YelpCallouts.businessDetail('E8RJkjfdcwgtyoPMjQ_Olg');    
        System.assertEquals('Gary Danko', name);
    }
    
    @isTest static void test3(){
        
        setup('MockBusinessReviews');
        
        //TEST BUSINESS REVIEWS
        List<Object> reviews = YelpCallouts.businessReviews('xAG4O7l-t1ubbwVAlPnDKg');
        System.assertEquals(3, reviews.size());
    }
    
    @isTest static void test4(){
        
        setup('MockAutocomplete');
        
        //TEST AUTOCOMPLETE
        Map<String, Object> results = YelpCallouts.autocomplete('del');
        List<Object> businesses = (List<Object>) results.get('businesses');
        List<Object>terms = (List<Object>) results.get('terms');
        List<Object>categories = (List<Object>) results.get('categories');
        
        Integer resultsSize = businesses.size() + terms.size() + categories.size();
        
        System.assertEquals(7, resultsSize);
    }
    
}