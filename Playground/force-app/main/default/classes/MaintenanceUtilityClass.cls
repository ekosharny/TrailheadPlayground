public class MaintenanceUtilityClass {
    public static List<Case> createRequests(String status, String type, String origin, String subject){
        List<Case> testCases = new List<Case>();
        for(Integer i=0; i<150; i++){
            testCases.add(new Case(status=status, type=type, origin = origin,
                                   subject=subject));
        }

        insert testCases;
        
        List<Product2> testEquipment = new List<Product2>();
        for(Integer i=1; i<4; i++){
            testEquipment.add(new Product2(Name='Test Equipment' + i, Maintenance_Cycle__c=50*i,
                                     Replacement_Part__c= true));
        }

        insert testEquipment;
        System.debug(testEquipment);
        
        List<Work_Part__c> parts = new List<Work_Part__c>();
        for(case cs: testCases){
            for(Integer j=0; j<3; j++){
                parts.add(new Work_Part__c(Maintenance_Request__c = cs.id,
                                          Equipment__c = testEquipment[j].id));
            }
        }
        insert parts;
        
        return testCases;
    }
}