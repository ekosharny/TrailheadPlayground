public with sharing class YelpController {
    @AuraEnabled
    public static List<Object> returnBusinesses(String search){
        List<Object> businesses = YelpCallouts.businessSearch(search);
        return businesses;
    }
}