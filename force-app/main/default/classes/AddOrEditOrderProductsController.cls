/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-14-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AddOrEditOrderProductsController {
	@AuraEnabled ( cacheable = true )
	public static Integer getProductsCount(Id recordId){
        return [SELECT COUNT() FROM PricebookEntry WHERE Pricebook2.Name = 'Standard Price Book' AND Product2Id NOT IN (Select Product2Id FROM OrderItem WHERE OrderId =: recordId)];
	}
    public class ProductDTO {
        @AuraEnabled
        public Id priceBookEntryId;
        @AuraEnabled
        public Id orderItemId;
        @AuraEnabled
        public String name;
        //@AuraEnabled
        //public String product2ThumbProductImages;
        @AuraEnabled
        public String pricebook2Id;
        @AuraEnabled
        public String product2Id;
        @AuraEnabled
        public String product2ProductCode;
        @AuraEnabled
        public String product2StockKeepingUnit;
        @AuraEnabled
        public String product2Description;
        @AuraEnabled
        public String product2Family;
        @AuraEnabled
        public Decimal unitPrice;
        @AuraEnabled
        public Decimal listPrice;
        @AuraEnabled
        public Boolean isActive;
        @AuraEnabled
        public String product2Divison;
        @AuraEnabled
        public String product2Category;
        @AuraEnabled
        public String product2Range;
        @AuraEnabled
        public String product2Function;
        @AuraEnabled
        public String product2Brand;
        @AuraEnabled
        public String productImage;
        @AuraEnabled
        public Decimal quantity;
        @AuraEnabled
        public Double availableQuantity;
        @AuraEnabled
        public string contentVersioId;
        @AuraEnabled
        public string imageUrlss;




        public ProductDTO(PricebookEntry pbe){
            this.priceBookEntryId = pbe.Id;
            this.name = pbe.Name;
            this.pricebook2Id = pbe.Pricebook2Id;
            this.product2Id = pbe.Product2Id;
            this.product2ProductCode = pbe.Product2.ProductCode;
            this.product2StockKeepingUnit = pbe.Product2.StockKeepingUnit;
            this.product2Description = pbe.Product2.Description;
            this.product2Family = pbe.Product2.Family;
            this.unitPrice = pbe.UnitPrice;
            this.isActive = pbe.IsActive;
            this.product2Divison = pbe.Product2.Divison__c;
            this.product2Category = pbe.Product2.Category__c;
            this.product2Range = pbe.Product2.Range__c;
            this.product2Function = pbe.Product2.Function__c;
            this.product2Brand = pbe.Product2.Brand__c;
            this.productImage = pbe.Product2.image_Url__c;
            this.availableQuantity = pbe.Product2.Available_Quantity__c;
            this.contentVersioId = pbe.Product2.Content_Version_ID__c;
        }
        public ProductDTO(OrderItem oi){
            this.orderItemId = oi.Id;
            this.name = oi.Product2.Name;
      
            this.product2Id = oi.Product2Id;
            this.product2StockKeepingUnit = oi.Product2.StockKeepingUnit;
            this.productImage = oi.Product2.image_Url__c;
            this.availableQuantity = oi.Product2.ManualQuantityOnHand__c;
            this.unitPrice = oi.UnitPrice;
            this.quantity = oi.Quantity;
        }
    }
    public class SearchResponseDTO {
        @AuraEnabled
        public Integer searchTotalCount {get; set;}
        @AuraEnabled
        public List<ProductDTO> products {get; set;}
    }
    public class SearchDTO {
        @AuraEnabled
        public Id orderId {get; set;}
        @AuraEnabled
        public String brand {get; set;}
        @AuraEnabled 
        public String division {get; set;}
        @AuraEnabled
        public String category {get; set;}
        @AuraEnabled
        public String range {get; set;}
        @AuraEnabled
        public String function {get; set;}
        @AuraEnabled
        public String product {get; set;}
        @AuraEnabled
        public String sku {get; set;}
        @AuraEnabled
        public Integer offsetCount {get; set;}
    }
    @AuraEnabled //( cacheable = true )
	public static SearchResponseDTO getAllProducts(SearchDTO search){
        System.debug('search   ' + search);
        SearchResponseDTO resp = new SearchResponseDTO();
        resp.products = new List<ProductDTO>();
        String queryFields = 'Id, Name, Pricebook2Id,Product2.image_Url__c, Product2Id,Product2.Product_Image_Test__c,Product2.Content_Version_ID__c, Product2.ProductCode,Product2.Available_Quantity__c, Product2.StockKeepingUnit, Product2.Description, Product2.Family, UnitPrice, IsActive, Product2.Divison__c, Product2.Category__c, Product2.Range__c, Product2.Function__c, Product2.Brand__c, Product2.Product_Image_URL__c,Product2.ManualQuantityOnHand__c';
        String query = 'SELECT FIELDS FROM PricebookEntry WHERE Pricebook2.Name = \'Standard Price Book\' AND Product2Id NOT IN (Select Product2Id FROM OrderItem WHERE OrderId = \''+search.orderId+'\')';
        String brand = '%'+search.brand+'%';
        if(String.isNotBlank(search.brand)){
            query += ' AND Product2.Brand__c LIKE :brand';
        }
        String division = '%'+search.division+'%';
        if(String.isNotBlank(search.division)){
            query += ' AND Product2.Divison__c LIKE :division';
        }
        String category = '%'+search.category+'%';
        if(String.isNotBlank(search.category)){
            query += ' AND Product2.Category__c LIKE :category';
        }
        String range = '%'+search.range+'%';
        if(String.isNotBlank(search.range)){
            query += ' AND Product2.Range__c LIKE :range';
        }
        String function = '%'+search.function+'%';
        if(String.isNotBlank(search.function)){
            query += ' AND Product2.Function__c LIKE :function';
        }
        String product = '%'+search.product+'%';
        if(String.isNotBlank(search.product)){
            query += ' AND Name LIKE :product';
        }
        String sku = '%'+search.sku+'%';
        if(String.isNotBlank(search.sku)){
            query += ' AND Product2.StockKeepingUnit LIKE :sku';
        }
        System.debug('query   ' + query);
        resp.searchTotalCount = Database.countQuery(query.replace('FIELDS', 'Count()'));
        query += ' ORDER BY Product2.StockKeepingUnit LIMIT 100 OFFSET ' + search.offsetCount;
        System.debug('query   ' + query);
        for(PricebookEntry pbe : Database.query(query.replace('FIELDS', queryFields))){
            resp.products.add(new ProductDTO(pbe));
        }
        return resp;
	}
    @AuraEnabled ( cacheable = true )
	public static List<ProductDTO> getOrderProducts(Id recordId){
        List<ProductDTO> products = new List<ProductDTO>();
        for(OrderItem oi:[SELECT Id,Product2.Product_Image_Test__c, Product2.Product_Image_URL__c, Product2.ManualQuantityOnHand__c,Product2Id, Product2.Name, Product2.StockKeepingUnit, UnitPrice, ListPrice, Quantity FROM OrderItem WHERE OrderId = :recordId ORDER BY CreatedDate]){

            System.debug('oi   ' + oi);
            products.add(new ProductDTO(oi));
        }
        return products;
	}

    @AuraEnabled
	public static void addProductsToOrder(Id recordId, List<OrderItem> items){
        System.debug('items   ' + items);
        try{
            if((items[0].Id == null) || (Test.isRunningTest()) ){
                Order o = [Select Id, Pricebook2Id FROM Order WHERE Id =:recordId];
                if(o.Pricebook2Id == null){
                    Pricebook2 pb = [SELECT Id, Name FROM Pricebook2 WHERE IsStandard = TRUE LIMIT 1];
                    o.Pricebook2Id = pb.Id;
                    update o;
                }
            }
            upsert items;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
	}

}