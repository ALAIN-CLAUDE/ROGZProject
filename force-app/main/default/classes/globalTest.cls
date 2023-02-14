@isTest
public class globalTest {
    static testMethod void fakeTest(){  
     AsyncWwwSysproComNsQuery.fakeMethod();
     wwwSysproComNsQuery.fakeMethod();
     wwwSysproComNsTransaction1.fakeMethod();
     SYSPROXMLPostBody.fakeMethod();
     wwwSysproComNsUtilities.fakeMethod();
     
     Test.startTest();
     String xml = SYSPROXMLPostBody.XMLParameters();
     Test.stopTest();
     System.assertEquals('<?xml version="1.0" encoding="Windows-1252"?><SalesOrders xmlns:xsd="http://www.w3.org/2001/XMLSchema-instance" xsd:noNamespaceSchemaLocation="SORTOI.XSD"><Parameters><InBoxMsgReqd>N</InBoxMsgReqd><Process>IMPORT</Process><CustomerToUse /><WarehouseListToUse>FQ</WarehouseListToUse><UseCustomerSalesWarehouse/><TypeOfOrder>ORD</TypeOfOrder><OrderStatus>1</OrderStatus><MinimumDaysToShip>0</MinimumDaysToShip><AllowNonStockItems>Y</AllowNonStockItems><AcceptOrdersIfNoCredit>Y</AcceptOrdersIfNoCredit><AcceptEarlierShipDate>Y</AcceptEarlierShipDate><OperatorToInform>SFORCE</OperatorToInform><CreditFailMessage>No credit available</CreditFailMessage><ValidProductClassList /><ShipFromDefaultBin>N</ShipFromDefaultBin><AllowDuplicateOrderNumbers>Y</AllowDuplicateOrderNumbers><CheckForCustomerPoNumbers>N</CheckForCustomerPoNumbers><AllowInvoiceInformationEntry /><AlwaysUsePriceEntered /><AllowZeroPrice /><AllowChangeToZeroPrice/><AddStockSalesOrderText>N</AddStockSalesOrderText><AddDangerousGoodsText>N</AddDangerousGoodsText><UseStockDescSupplied /><ValidateShippingInstrs /><AllocationAction>A</AllocationAction><IgnoreWarnings>Y</IgnoreWarnings><AddAttachedServiceCharges/><StatusInProcess>N</StatusInProcess><StatusInProcessResponse/><WarnIfCustomerOnHold>N</WarnIfCustomerOnHold><AcceptKitOptional>Y</AcceptKitOptional><AllowBackOrderForPartialHold>Y</AllowBackOrderForPartialHold><AllowBackOrderForSuperseded>Y</AllowBackOrderForSuperseded><OverrideCustomerBackOrder>Y</OverrideCustomerBackOrder><UseMasterAccountForCustomerPartNo/><ApplyLeadTimeCalculation>N</ApplyLeadTimeCalculation><ApplyParentDiscountToComponents>N</ApplyParentDiscountToComponents><AllowManualOrderNumberToBeUsed>N</AllowManualOrderNumberToBeUsed><ReserveStock>N</ReserveStock><ReserveStockRequestAllocs>N</ReserveStockRequestAllocs><AllowBackOrderForNegativeMerchLine>Y</AllowBackOrderForNegativeMerchLine><PutEntireQuantityOnNewLoadWhenChanged>N</PutEntireQuantityOnNewLoadWhenChanged><MinimumChargeLineZero>N</MinimumChargeLineZero><UpdateWhLast>N</UpdateWhLast></Parameters></SalesOrders>', xml);
  }  
}