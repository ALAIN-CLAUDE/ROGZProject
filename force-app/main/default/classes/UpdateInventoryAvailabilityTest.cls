/**
* @author Emandleni Moyo
* @date 24th March 2022
* @description Test UpdateInventoryAvailability.apxc
**/
@isTest public class UpdateInventoryAvailabilityTest {
    @isTest 
    public static void UpdateProductInventoryTest(){
       
        Pricebook2 PriceBook = new Pricebook2(
            Name = 'Price Book',
            IsActive = true
        );
        
        Product2 product = new Product2();
        product.Name = 'Test Product ';
        product.IsActive = true;
        
        PricebookEntry PriceBookEntry = new PricebookEntry(
            Pricebook2Id = PriceBook.Id,
            Product2Id = product.Id,
            UnitPrice = 100.00,
            UseStandardPrice = true,
            IsActive = true
        );
        
        Account a = new Account(Name='TestAccount');
        insert a;
        
        Order order = new Order();
        order.AccountId = a.Id;
        order.EffectiveDate = System.today();
        order.Status = 'Draft';
        order.ReqShipDate__c = System.today() + 14;
        order.Purchase_Order_Number__c = '123';
        insert order;
        
        Orderitem oitem = new Orderitem();
        oitem.OrderId = order.id;
        oitem.Quantity = 1;
        oitem.UnitPrice = 200;
        oitem.PricebookEntryId = PriceBookEntry.Id;
        
        
        List<OrderItem> orderProductList = new List<OrderItem>();
        orderProductList.add(oitem);
        
        Test.startTest();
        UpdateInventoryAvailability.UpdateProductInventory(orderProductList);
        Test.stopTest();
    }
    
    @isTest(seeAllData=true) 
    public static void doUpdateProductInventoryTest(){
        Pricebook2 PriceBook = new Pricebook2(
            Name = 'Price Book',
            IsActive = true
        );
        
        Product2 product = new Product2();
        product.Name = 'Test Product ';
        product.IsActive = true;
        product.StockKeepingUnit = 'HB13-E';
        
        PricebookEntry PriceBookEntry = new PricebookEntry(
            Pricebook2Id = PriceBook.Id,
            Product2Id = product.Id,
            UnitPrice = 100.00,
            UseStandardPrice = true,
            IsActive = true
        );
        
        Account a = new Account(Name='TestAccount');
        insert a;
        
        Order order = new Order();
        order.AccountId = a.Id;
        order.EffectiveDate = System.today();
        order.Status = 'Draft';
        order.ReqShipDate__c = System.today() + 14;
        order.Purchase_Order_Number__c = '123';
        insert order;
        
        Orderitem oitem = new Orderitem();
        oitem.OrderId = order.id;
        oitem.Quantity = 1;
        oitem.UnitPrice = 200;
        oitem.PricebookEntryId = PriceBookEntry.Id;
        //insert oitem;
        
        Set<Id> orderProductIds = new Set<Id>();
        orderProductIds.add(oitem.Id);
        
        //Test.setMock(WebServiceMock.class, new SYSPROMockGenerator());
        Test.startTest();
        UpdateInventoryAvailability.doUpdateProductInventory(orderProductIds);
        //try{
        //    SYSPROWCFServiceController.makeHttpCallout('https://www.google.com', 'application/xml', 'POST');
        //} catch(Exception e) {}
        Test.stopTest();
    }
    
    @isTest
    public static void getQuantityOnHandTest(){
		String xmlString = '<?xml version="1.0" encoding="Windows-1252"?><InvQuery>	<StockItem>		<StockCode>HB14-E</StockCode>		<Description>NITELIFE SR COLLAR (S) PURPLE</Description>	</StockItem>	<WarehouseItem>		<Warehouse>EU</Warehouse>		<Description>TEST WAREHOUSE</Description>		<QtyOnHand>            0.000000</QtyOnHand>	</WarehouseItem>	<WarehouseItem>		<Warehouse>FG</Warehouse>		<Description>TEST CHINA WAREHOUSE</Description>		<QtyOnHand>            0.000000</QtyOnHand>	</WarehouseItem>	<WarehouseItem>		<Warehouse>FH</Warehouse>		<Description>TEST WAREHOUSE</Description>		<QtyOnHand>            0.000000</QtyOnHand>	</WarehouseItem>	<WarehouseItem>		<Warehouse>FQ</Warehouse>		<Description>FG - DISTRIBUTION CENTRE</Description>		<QtyOnHand>          855.000000</QtyOnHand>	</WarehouseItem>	<WarehouseItem>		<Warehouse>FR</Warehouse>		<Description>TEST WAREHOUSE</Description>		<QtyOnHand>            0.000000</QtyOnHand>	</WarehouseItem>	<WarehouseItem>		<Warehouse>ZE</Warehouse>		<Description>CREDITS - EXPORT</Description>		<QtyOnHand>            0.000000</QtyOnHand>	</WarehouseItem>	<WarehouseItem>		<Warehouse>ZM</Warehouse>		<Description>CREDITS - MISCELLANEOUS</Description>		<QtyOnHand>            0.000000</QtyOnHand>	</WarehouseItem></InvQuery> ';
    	Test.startTest();
        String response = UpdateInventoryAvailability.getQuantityOnHand(xmlString);
        Test.stopTest();
    }
    
    @isTest
    public static void getAvailableQuantityTest(){
        String xmlString = '<?xml version="1.0" encoding="Windows-1252"?><InvQuery>	<WarehouseItem>		<Warehouse>FQ</Warehouse>		<Description>FG - DISTRIBUTION CENTRE</Description>		<QtyOnHand>         2177.000000</QtyOnHand>		<Edited_QtyOnHand>2,177</Edited_QtyOnHand>		<AvailableQty>         2167.000000</AvailableQty>		<Edited_AvailableQty>2,167</Edited_AvailableQty>		<QtyOnOrder>            0.000000</QtyOnOrder>		<Edited_QtyOnOrder>0</Edited_QtyOnOrder>		<QtyInInspection>            0.000000</QtyInInspection>		<Edited_QtyInInspection>0</Edited_QtyInInspection>		<MinimumQty>            0.000000</MinimumQty>		<Edited_MinimumQty>0</Edited_MinimumQty>		<MaximumQty>            0.000000</MaximumQty>		<Edited_MaximumQty>0</Edited_MaximumQty>		<QtyOnBackOrder>            0.000000</QtyOnBackOrder>		<Edited_QtyOnBackOrder>0</Edited_QtyOnBackOrder>		<QtyAllocated>           10.000000</QtyAllocated>		<Edited_QtyAllocated>10</Edited_QtyAllocated>		<MtdQtyReceived>            0.000000</MtdQtyReceived>		<Edited_MtdQtyReceived>0</Edited_MtdQtyReceived>		<MtdQtyAdjusted>            0.000000</MtdQtyAdjusted>		<Edited_MtdQtyAdjusted>0</Edited_MtdQtyAdjusted>		<MtdQtyIssued>            0.000000</MtdQtyIssued>		<Edited_MtdQtyIssued>0</Edited_MtdQtyIssued>		<YtdQtySold>         1643.000000</YtdQtySold>		<Edited_YtdQtySold>1,643</Edited_YtdQtySold>		<PrevYearQtySold>         2841.000000</PrevYearQtySold>		<Edited_PrevYearQtySold>2,841</Edited_PrevYearQtySold>		<QtyInTransit>            0.000000</QtyInTransit>		<Edited_QtyInTransit>0</Edited_QtyInTransit>		<QtyAllocatedWip>            0.000000</QtyAllocatedWip>		<Edited_QtyAllocatedWip>0</Edited_QtyAllocatedWip>		<Edited_WipQtyReserved>0</Edited_WipQtyReserved>		<MtdQtySold>           38.000000</MtdQtySold>		<Edited_MtdQtySold>38</Edited_MtdQtySold>		<MtdQtyTrf>           -1.000000</MtdQtyTrf>		<Edited_MtdQtyTrf>-1</Edited_MtdQtyTrf>		<DateLastSale>2022/11/10</DateLastSale>		<DateLastCostChange>2022/08/25</DateLastCostChange>		<DateLastCostEntered>0000/00/43</DateLastCostEntered>		<UserField1/>		<UserField2/>		<UserField3/>		<DefaultBin>FQ</DefaultBin>		<UnitCost>         44.73018</UnitCost>		<FutureFree>         2167.000000</FutureFree>		<Edited_FutureFree>2,167</Edited_FutureFree>		<QuantityDispatchNotInvoiced>            0.000000</QuantityDispatchNotInvoiced>		<Edited_QuantityDispatchNotInvoiced>0</Edited_QuantityDispatchNotInvoiced>	</WarehouseItem></InvQuery>';
        Test.startTest();
        Integer response = UpdateInventoryAvailability.getAvaliable(xmlString);
        Test.stopTest();
    }
}