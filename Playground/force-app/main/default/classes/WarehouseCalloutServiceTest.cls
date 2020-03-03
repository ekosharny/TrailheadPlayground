@IsTest
private class WarehouseCalloutServiceTest {
    // implement your mock callout test here
	public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void test(){
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new WarehouseSyncSchedule());
        
		WarehouseCalloutService.runWarehouseEquipmentSync();
        
        List<Product2> equip = [Select id from Product2];
        
        System.assertEquals(0, equip.size());
        
        Test.stopTest();
        List<Product2> equip2 = [Select id from Product2];
        
        System.assertEquals(1, equip2.size());

        
    }
}