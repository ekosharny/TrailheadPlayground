trigger MaintenanceRequest on Case (before update) {
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
    
    List<Case> cases = new List<Case>();
    
    for(Case c : Trigger.new){
        if(c.status == 'Closed' && (c.type == 'Repair' || c.type == 'Routine Maintenance')){
            cases.add(c);
        }
    }    
    if(cases.size()>0){
        MaintenanceRequestHelper.updateWorkOrders(cases);
    }
    
}