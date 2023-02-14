/**
* @author Emandleni Moyo
* @date 24 Mar 2022
* @description Handle stock availability updates to Order products when capturing orders
* @note Invoked by Process: Update Order Product Inventory
**/
public class UpdateInventoryAvailability {
    
    @InvocableMethod
    public static void UpdateProductInventory(List <OrderItem> orderProductList){
        Set<Id> orderProductIds = new Set<Id>();
        
        for(OrderItem current : orderProductList){
            orderProductIds.add(current.Id);
        }
        
        doUpdateProductInventory(orderProductIds);
    }
    
    @future(callout=true) 
    public static void doUpdateProductInventory(Set<Id> orderProductIds){        
        List<OrderItem> orderItems = [SELECT Id, Product2.Name, Product2.StockKeepingUnit, Quantity, Quantity_on_Hand__c, Available_Quantity__c, TotalPrice, UnitPrice FROM OrderItem WHERE Id IN: orderProductIds];
        for (OrderItem orderItem : orderItems) {
            System.debug('>> Input SKU: '+orderItem.Product2.StockKeepingUnit);
            String response = SYSPROWCFServiceController.fetchInventory(orderItem.Product2.StockKeepingUnit);
            //orderItem.Quantity_on_Hand__c = Integer.valueOf(getQuantityOnHand(response));
            orderItem.Available_Quantity__c = Integer.valueOf(getAvaliable(response));
        }
        
        UPDATE orderItems;
    }
   
    public static String getQuantityOnHand(String xml){
        XPath xp = new XPath(xml);
        //return xp.getText('/InvQuery/WarehouseItem[4]/QtyOnHand').trim();
        //return xp.getText('/InvQuery/WarehouseItem[Warehouse=\'FQ\']/QtyOnHand'.trim());
        Integer index = 1;
        String result = '';
        do{
            result = xp.getText('/InvQuery/WarehouseItem['+index+']/Warehouse'.trim());
            System.debug(''+result);
            if(result == 'FQ')
                break;
            index++;
        }
        while(result != 'FQ');
        return xp.getText('/InvQuery/WarehouseItem['+index+']/QtyOnHand'.trim());
    }
    
    /**
	* @author Emandleni Moyo (emandleni.moyo@tetrad.co.za)
	* @author Thatho Mmadi
	* @author Anirban Rakshit
	* @date 11 November 2022 (Modification)
	**/
    public static Integer getAvaliable(String xml){
        XPath xp = new XPath(xml);
        //return xp.getText('/InvQuery/WarehouseItem[4]/AvailableQty').trim();
        //return xp.getText('/InvQuery/WarehouseItem[Warehouse=\'FQ\']/AvailableQty'.trim()); 
        
        //Determine the index of warehouse FQ you need it to perform an XPath Query
        Integer index = 1;
        String result = '';
        do{
            result = xp.getText('/InvQuery/WarehouseItem['+index+']/Warehouse'.trim());
            System.debug(''+result);
            if(result == 'FQ')
                break;
            index++;
        }
        while(result != 'FQ');
        
       	Integer QtyOnHand = Integer.valueOf(xp.getText('/InvQuery/WarehouseItem['+index+']/QtyOnHand').trim());
        Integer QtyAllocated = Integer.valueOf(xp.getText('/InvQuery/WarehouseItem['+index+']/QtyAllocated').trim());
        Integer QtyOnBackOrder = Integer.valueOf(xp.getText('/InvQuery/WarehouseItem['+index+']/QtyOnBackOrder').trim());
        
        return QtyOnHand - QtyAllocated + QtyOnBackOrder;
    }
}