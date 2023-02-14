@isTest
public class SYSPROWCFTestClass {
    @isTest(seeAllData=true) public static void testAllMethods(){
        SYSPROWCFServiceController controller = new SYSPROWCFServiceController();
        Test.startTest();
        try{
            Order ord = [SELECT Id FROM Order LIMIT 1];
            Test.setMock(WebServiceMock.class, new SYSPROMockGenerator());
            SYSPROWCFServiceController.doPostOrder(new Set<Id>{ord.Id});
            SYSPROWCFServiceController.PostOrderdetailsToSYSPro(new List<Order>{ord});
            SYSPROWCFServiceController.fetchInventory('HARD123');
            controller.processQResponse();
        } catch(Exception e) {}
        Test.stopTest();
    }
}