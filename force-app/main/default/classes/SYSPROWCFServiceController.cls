public class SYSPROWCFServiceController{
    public static Boolean isAlreadyCalled=false;
    
    //LOGIN SERVICE
    public static String loginService(){
        wwwSysproComNsUtilities.utilitiesclassSoap utils = new wwwSysproComNsUtilities.utilitiesclassSoap();
        return utils.Logon('SFORCE','SFORCE','R','','AUTO','ldNoDebug','EncoreInstance_0','');
        //public String Logon(String Operator,String OperatorPassword,String CompanyId,String CompanyPassword,String LanguageCode,String LogLevel,String EncoreInstance,String XmlIn)
        //return utils.Logon('SFORCE','SFORCE','T','','AUTO','ldNoDebug','EncoreInstance_0','');
    }
    
    public static AsyncWwwSysproComNsQuery.QueryResponse_elementFuture asyncQueryRes;
    
    // Callback method
    public Object processQResponse() {  
        // Get the response by using the unique label
        System.debug(asyncQueryRes.getValue());
        return null;
    }
    
    
    
    //FETCH CUSTOMER RECORD ARSQRY
    /*public static void fetchCustomer(){
        String loginToken = SYSPROWCFServiceController.loginService();
        wwwSysproComNsQuery.queryclassSoap q = new wwwSysproComNsQuery.queryclassSoap();
        System.debug('*** '+loginToken.trim());
        
        String XMLIn = '<?xml version="1.0" encoding="Windows-1252"?><!-- Copyright 1994-2014 SYSPRO Ltd.--><!--      Sample XML for the Customer Query Business Object--><Query xmlns:xsd="http://www.w3.org/2001/XMLSchema-instance" xsd:noNamespaceSchemaLocation="ARSQRY.XSD">	<Key>		<Customer><![CDATA[000019]]></Customer>	</Key>	<Option>		<MultiMediaImageType>GIF</MultiMediaImageType>		<IncludeFutures>N</IncludeFutures>		<IncludeTransactions>Y</IncludeTransactions>		<IncludeInvoices>Y</IncludeInvoices>		<IncludeCheckPayments>Y</IncludeCheckPayments>		<IncludePostDated>Y</IncludePostDated>		<IncludeZeroBalances>N</IncludeZeroBalances>		<IncludeCustomForms>N</IncludeCustomForms>		<AsOfPeriod>C</AsOfPeriod>		<AgeingOption>S</AgeingOption>		<AgeColumn1>30</AgeColumn1>		<AgeColumn2>60</AgeColumn2>		<AgeColumn3>90</AgeColumn3>		<AgeColumn4>120</AgeColumn4>		<AgeColumn5>150</AgeColumn5>		<AgeColumn6>180</AgeColumn6>		<AgeColumn7>210</AgeColumn7>		<XslStylesheet/>	</Option></Query>';
        String s = q.Query(loginToken.trim(), 'ARSQRY', XMLIn);
        System.debug('***'+s);
    }*/
    
    //FETCH INVENTORY RECORD USING STOCKCODE AS KEY: INVQRY
    //String str is STOCKKEEPINGUNIT column in excel spreadsheet
    public static String fetchInventory(String SKU){
        String loginToken = SYSPROWCFServiceController.loginService();
        wwwSysproComNsQuery.queryclassSoap q = new wwwSysproComNsQuery.queryclassSoap();
        System.debug('*** '+loginToken.trim());
        
        String XMLIn = '<?xml version="1.0" encoding="Windows-1252"?><!-- Copyright 1994-2014 SYSPRO Ltd.--><!--      Sample XML for the Inventory Query Business Object--><Query xmlns:xsd="http://www.w3.org/2000/10/XMLSchema-instance" xsd:noNamespaceSchemaLocation="INVQRY.XSD">  <Key>    <StockCode><![CDATA['+SKU+']]></StockCode>  </Key>  <Option>    <MultiMediaImageType>GIF</MultiMediaImageType>    <IncludeHistory>Y</IncludeHistory>    <IncludeBins>Y</IncludeBins>    <IncludeLots>Y</IncludeLots>    <IncludeSerials>Y</IncludeSerials>    <IncludeMovements>Y</IncludeMovements>    <MovementDateSequence>A</MovementDateSequence>    <MovementStartDate>2001-01-12</MovementStartDate>    <MaxNumberMovements>100</MaxNumberMovements>    <IncludeCustomForms>N</IncludeCustomForms>    <IncludeMovementIssues>Y</IncludeMovementIssues>    <IncludeMovementTransfers>Y</IncludeMovementTransfers>    <IncludeMovementReceipts>Y</IncludeMovementReceipts>    <IncludeMovementPhysical>Y</IncludeMovementPhysical>    <IncludeMovementAdjustments>Y</IncludeMovementAdjustments>    <IncludeMovementCostChanges>Y</IncludeMovementCostChanges>    <IncludeMovementCostMods>Y</IncludeMovementCostMods>    <IncludeMovementBinTransfers>Y</IncludeMovementBinTransfers>    <IncludeMovementInvoices>Y</IncludeMovementInvoices>    <IncludeMovementCreditNotes>Y</IncludeMovementCreditNotes>    <IncludeMovementDebitNotes>Y</IncludeMovementDebitNotes>    <IncludeMovementDispatchNotes>Y</IncludeMovementDispatchNotes>    <IncludeEcc>Y</IncludeEcc>    <IncludeApprovedManuf>Y</IncludeApprovedManuf>    <IncludeNarrations>Y</IncludeNarrations>    <ReturnNarrationsinBlock>N</ReturnNarrationsinBlock>    <XslStylesheet/>  </Option>  <Filter>    <Warehouse FilterType="S" FilterValue="FQ"/>  </Filter></Query>';
        String s = q.Query(loginToken.trim(), 'INVQRY', XMLIn);
        //System.debug('***'+s);
        return s;
        //Dom.Document xml = new Dom.Document();
        //xml.load(s);
        //return xml.getRootElement(); //type DOM.XmlNode
    }
    
    //FETCH INVENTORY PRICE LIST INVQPL
    /*public static void fetchInventoryPriceList(){
        String loginToken = SYSPROWCFServiceController.loginService();
        wwwSysproComNsQuery.queryclassSoap q = new wwwSysproComNsQuery.queryclassSoap();
        System.debug('*** '+loginToken.trim());
        
        //String XMLIn = '<?xml version="1.0" encoding="Windows-1252"?><!-- Copyright 1994-2014 SYSPRO Ltd.--><!--      Sample XML for the Inventory Price List Query Business Object--><Query xmlns:xsd="http://www.w3.org/2001/XMLSchema-instance" xsd:noNamespaceSchemaLocation="INVQPL.XSD">  <Option>    <Sequence>S</Sequence>    <PriceMethod>Q</PriceMethod>    <XslStylesheet/>  </Option>  <Filter>    <ProductClass FilterType="A" FilterValue=""/>    <Supplier FilterType="A" FilterValue=""/>    <StockCode FilterType="A" FilterValue=""/>    <Currency FilterType="A" FilterValue=""/>    <PriceCode FilterType="A" FilterValue="AA,AS"/>    <PriceCategory FilterType="A" FilterValue=""/>  </Filter></Query>';        
        String XMLIn = '<?xml version="1.0" encoding="Windows-1252"?><!-- Copyright 1994-2014 SYSPRO Ltd.--><!--      Sample XML for the Inventory Price List Query Business Object--><Query xmlns:xsd="http://www.w3.org/2001/XMLSchema-instance" xsd:noNamespaceSchemaLocation="INVQPL.XSD">  <Option>    <Sequence>S</Sequence>    <PriceMethod>C</PriceMethod>    <XslStylesheet/>  </Option>  <Filter>    <ProductClass FilterType="A" FilterValue=""/>    <Supplier FilterType="A" FilterValue=""/>    <StockCode FilterType="R" FilterValue="A100,A110"/>    <Currency FilterType="A" FilterValue=""/>    <PriceCode FilterType="L" FilterValue="AA,AS"/>    <PriceCategory FilterType="A" FilterValue=""/>  </Filter></Query>';		
        
        String s = q.Query(loginToken.trim(), 'INVQPL', XMLIn);
        System.debug('***');
        
        System.debug('response = !!! '+s);
    }*/
    
    //FETECH SALES ORDER SORQRY
    /*
    public static void fetchSalesOrder(String sysproSOnumber){
        String loginToken = SYSPROWCFServiceController.loginService();
        wwwSysproComNsQuery.queryclassSoap q = new wwwSysproComNsQuery.queryclassSoap();
        System.debug('*** '+loginToken.trim());
        
        String XMLIn = '<?xml version="1.0" encoding="Windows-1252"?><Query xmlns:xsd="http://www.w3.org/2001/XMLSchema-instance" xsd:noNamespaceSchemaLocation="SORQRY.XSD"><Key>   <SalesOrder>'+sysproSOnumber+'</SalesOrder>   <Invoice></Invoice></Key><Option>    <IncludeStockedLines>Y</IncludeStockedLines>    <IncludeNonStockedLines>Y</IncludeNonStockedLines>    <IncludeFreightLines>Y</IncludeFreightLines>    <IncludeMiscLines>Y</IncludeMiscLines>    <IncludeCommentLines>Y</IncludeCommentLines>    <IncludeCompletedLines>Y</IncludeCompletedLines>    <IncludeSerials>N</IncludeSerials>    <IncludeLots>Y</IncludeLots>    <IncludeBins>Y</IncludeBins>    <IncludeAttachedItems>N</IncludeAttachedItems>    <IncludeCustomForms>Y</IncludeCustomForms>    <IncludeDetailLineCustomForms>Y</IncludeDetailLineCustomForms>    <IncludeValues>N</IncludeValues>    <ReturnLineShipDate>N</ReturnLineShipDate>    <XslStylesheet/></Option></Query>';
        String s = q.Query(loginToken.trim(), 'SORQRY', XMLIn);
        System.debug('***');
        
        Dom.Document xml = new Dom.Document();
        xml.load(s);
        
        for (Dom.XmlNode node : xml.getRootElement().getChildElements()) {
            System.debug(''+node);
        }
    }
	*/
    
    //SALES ORDER POST
    @InvocableMethod
    public static void PostOrderdetailsToSYSPro(List <Order> ordersList){
        System.debug('ordersList   ' + ordersList);
        /*Account acc=[select Id,testOrder__c from Account where id='0018E00001cb2OF' limit 1];
		String str=acc.testOrder__c+' || ';
		for(Order o:ordersList){
				str=str+','+o.OrderNumber;
		}
		acc.testOrder__c=str;
		update acc;*/
        /* if(!isAlreadyCalled){
		Account acc=[select Id,testOrder__c from Account where id='0018E00001cb2OF' limit 1];
		String str=acc.testOrder__c+' || ';
		for(Order o:ordersList){
			str=str+','+o.OrderNumber;
		}
		acc.testOrder__c=str;
		update acc;*/
        
        Set<Id> orderIds = new Set<Id>();
        
        for(Order current : ordersList){
            orderIds.add(current.Id);
        }
        
        doPostOrder(orderIds);
        System.debug('orderIds'+orderIds);
        isAlreadyCalled=true;
    }      
    
    @future(callout=true) 
    public static void doPostOrder(Set<Id> orderIds){
        /*String orderId = '';
		for (string setElement : orderIds) {
		orderId = setElement;
		break;
		}*/
        
        //extract an order list from the incoming order, this means get the list of OrderItem objects related to Order
        // List<OrderItem> orderList = [SELECT Id, Product2.Name, Product2.StockKeepingUnit, Quantity, TotalPrice, UnitPrice, OrderId FROM OrderItem WHERE OrderId =: orderId];
        List<OrderItem> orderList = [SELECT Id, Product2.Name, Product2.StockKeepingUnit, Quantity, TotalPrice, UnitPrice, OrderId FROM OrderItem WHERE OrderId in :orderIds];
        
        //Order order = [SELECT Id, Status, SYSPRO_Sales_Order_NUmber__c FROM Order WHERE Id =: orderId];
        List<Order> orders = [SELECT Id, Status, SYSPRO_Sales_Order_NUmber__c, Purchase_Order_Number__c FROM Order WHERE Id in: orderIds];
        for(Order order:orders){
            String orderId = order.Id;
            Dom.Document xml = new Dom.Document();
            String pOn = order.Purchase_Order_Number__c;
            
            try{
                String XMLIn = SYSPROXMLPostBody.populateDynamicXMLIn(orderList, orderId);
                String loginToken = SYSPROWCFServiceController.loginService();
                system.debug('***login token***:'+loginToken);
                wwwSysproComNsTransaction1.transactionclassSoap q = new wwwSysproComNsTransaction1.transactionclassSoap();
                String s = q.Post(loginToken.trim(), 'SORTOI', SYSPROXMLPostBody.XMLParameters(), XMLIn);
                System.debug('**** '+s); 
                xml.load(s);
                
                XPath xp = new XPath(xml);
				String salesOrderNumber = xp.getText('/SalesOrders/Order/SalesOrder');
                
                if(salesOrderNumber != null){
                    //set syspro order number
                    //put order in activated mode 
                    order.SYSPRO_Sales_Order_NUmber__c = salesOrderNumber;
                    order.Status = 'Activated';
                    UPDATE order;
                }
                else{
                    //put order in retry mode
                    order.Status = 'Retry Post';
                    order.Purchase_Order_Number__c = pOn; 
                    UPDATE order;
                    
                    //state that posting failed
                    Task t = new Task();
                    t.Type = 'Call';
                    t.Subject = System.now().format('yyyy_MM_dd_hh_mm_ss') +' Failed to Post';
                    t.Status = 'Open';
                    t.Priority = 'Normal';
                    t.WhatId = order.Id;
                    insert t;
                    Attachment att=new Attachment();
                    att.Body=Blob.valueOf(s);
                    att.Name='Note_' + System.now().format('yyyy_MM_dd_hh_mm_ss') + '.txt';
                    att.parentId=t.Id;
                    insert att;
                }
                if(Test.isRunningTest()){
                    throw new System.CalloutException();
                }
                
                System.debug('****** Pretty Print Start ******');
                System.debug(xml.toXmlString());
                System.debug('****** Pretty Print End ******');
            }catch(System.CalloutException e)
            {
                System.debug('>>'+e);
                order.Status = 'Retry Post';
                Task t = new Task();
                t.Type = 'Call';
                t.Subject = System.now().format('yyyy_MM_dd_hh_mm_ss') +' Failed to Post';
                t.Status = 'Open';
                t.Priority = 'Normal';
                t.WhatId = order.Id;
                insert t;
                Attachment att=new Attachment();
                att.Body=Blob.valueOf(e.getMessage());
                att.Name='Note_' + System.now().format('yyyy_MM_dd_hh_mm_ss') + '.txt';
                att.parentId=t.Id;
                insert att;
                UPDATE order; 
            }
        }
    }
    
    /* THIS LOGIC WAS NOT EFFICIENT AND WAS REPLACED BY XPATH CLASS
    private static String getSysproSalesOrderNumber(Dom.XmlNode rootNode){
        System.debug('root: '+ rootNode.getName());
        if(rootNode.getChildElements()!=null){
            for(Dom.XMLNode child: rootNode.getChildElements()) {
                System.debug('current: '+child.getName());
                if(child.getName() == 'Orders'){
                    System.debug('>>> '+child.getText().trim());
                    return child.getText().trim();
                }
            }
        }
        return null;
    }*/
    
}