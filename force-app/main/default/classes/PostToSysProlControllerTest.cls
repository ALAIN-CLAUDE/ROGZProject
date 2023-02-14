@isTest
public class PostToSysProlControllerTest {
    @isTest 
    static void test_getConfirmedOrders(){
        Account acc = new Account(Name='Test Account');
        insert acc;
        
        RetailStore  retailStore = new RetailStore (Name='Test Retail Store');
        retailStore.AccountId = acc.Id;
        retailStore.Shipping_Instructions_Code__c = '9';
        Insert retailStore;
        
        List<Id> ids = new List<Id>();
        
        List<Order> orders = new List<Order>();
        for(Integer i = 0; i < 10; i++){
            Order order = new Order();
            order.Retail_Store__c = retailStore.Id;
            ids.add(order.Id);
            order.AccountId = acc.Id;
            order.Purchase_Order_Number__c = 'testClassOrder'+i;
            order.Status = 'Confirmed';
            order.EffectiveDate = System.today();
            order.ReqShipDate__c = System.today() + 7;
            orders.add(order);
        }
        
        Insert orders;
        
        String result;
        Test.startTest();
        try{
            result = PostToSysProlController.getConfirmedOrders(ids);
            result = PostToSysProlController.getConfirmedOrders(new List<Id>());
        }
        catch(Exception e){
        }
        Test.stopTest();
    }
}