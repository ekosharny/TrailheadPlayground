public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    @future(callout=true)
    public static void runWarehouseEquipmentSync() {
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200){
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
            Map<String,Object> info = new Map<String,Object>();
            List<Product2> equipment = new List<Product2>();
            for(Integer i=0; i<results.size(); i++){
                info = (Map<String, Object>) results[i];
                equipment.add(new Product2(name=(String)info.get('name'),
                                          Replacement_Part__c=(Boolean)info.get('replacement'),
                                          Cost__c=(Decimal)info.get('cost'),
                                          Current_Inventory__c=(Integer)info.get('quantity'),
                                          Lifespan_Months__c=(Integer)info.get('lifespan'),
                                          Maintenance_Cycle__c=(Integer)info.get('maintenanceperiod'),
                                          Warehouse_SKU__c=(String)info.get('sku')));
            }

            upsert equipment Warehouse_SKU__c;
        }
    }
}