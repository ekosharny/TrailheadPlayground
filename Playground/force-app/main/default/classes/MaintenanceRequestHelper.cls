public with sharing class MaintenanceRequestHelper {
    
    public static void updateWorkOrders(List<Case> requests) {
        // TODO: Complete the method to update workorders
        
        List<Case> newRequests = new List<Case>();
        
        Map<Id, List<Work_Part__c>> parts = new Map<Id, List<Work_Part__c>>();
        
        for(Case cs : [Select id, (Select equipment__r.Maintenance_Cycle__c from Work_Parts__r) From Case]){
            parts.put(cs.id, cs.Work_Parts__r);
        }
        
        for(Case c: requests){
            //Integer cycle = (Integer)c.equipment__r.Maintenance_Cycle__c;
            
            List<Work_Part__c> wparts = parts.get(c.id);

            List<Decimal> cycles = new List<Decimal>();
            for(Work_Part__c wp : wparts){
                cycles.add(wp.equipment__r.Maintenance_Cycle__c);
            }
            cycles.sort();
            Decimal shortestCycle = cycles[0];
          
            newRequests.add(new Case(vehicle__c = c.vehicle__c, 
                                    equipment__c = c.Equipment__c,
                                    type = 'Routine Maintenance',
                                    date_reported__c = date.today(),
                                    subject = c.subject,
                                    origin = c.origin,
                                    accountid = c.AccountId,
                                    contactid = c.ContactId,
                                    //date_due__c = date.today().addDays(cycle)
                                    date_due__c = date.today().addDays(Integer.valueOf(shortestCycle))
                                    )); 
        }
        
        if(newRequests.size()>0){
            insert newRequests;
        }        
    }        
   
}