@isTest
global class SYSPROMockGenerator implements WebServiceMock {
    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
            // start - specify the response you want to send
            if(request instanceof wwwSysproComNsUtilities.Logon_element){
                wwwSysproComNsUtilities.LogonResponse_element response_x = 
                    new wwwSysproComNsUtilities.LogonResponse_element();
                response_x.LogonResult = '123';
                // end
                response.put('response_x', (object)response_x); 
            }else if(request instanceof wwwSysproComNsQuery.Query_element){
                wwwSysproComNsQuery.QueryResponse_element response_x =
                    new wwwSysproComNsQuery.QueryResponse_element();
                response_x.QueryResult = '<Key>   <SalesOrder>H000055421</SalesOrder>   <Invoice></Invoice></Key>';
                response.put('response_x', (object)response_x);
            }else if(request instanceof wwwSysproComNsTransaction1.Post_element){
                wwwSysproComNsTransaction1.PostResponse_element response_x =
                    new wwwSysproComNsTransaction1.PostResponse_element ();
                response_x.PostResult ='<?xml version="1.0" encoding="Windows-1252"?><SalesOrders xmlns:xsd="http://www.w3.org/2001/XMLSchema-instance" xsd:noNamespaceSchemaLocation="SORTOI.XSD"><Parameters><InBoxMsgReqd>N</InBoxMsgReqd><Process>IMPORT</Process><CustomerToUse /><WarehouseListToUse>FQ</WarehouseListToUse><UseCustomerSalesWarehouse/><TypeOfOrder>ORD</TypeOfOrder><OrderStatus>1</OrderStatus><MinimumDaysToShip>0</MinimumDaysToShip><AllowNonStockItems>Y</AllowNonStockItems><AcceptOrdersIfNoCredit>Y</AcceptOrdersIfNoCredit><AcceptEarlierShipDate>Y</AcceptEarlierShipDate><OperatorToInform>SFORCE</OperatorToInform><CreditFailMessage>No credit available</CreditFailMessage><ValidProductClassList /><ShipFromDefaultBin>N</ShipFromDefaultBin><AllowDuplicateOrderNumbers>Y</AllowDuplicateOrderNumbers><CheckForCustomerPoNumbers>N</CheckForCustomerPoNumbers><AllowInvoiceInformationEntry /><AlwaysUsePriceEntered /><AllowZeroPrice /><AllowChangeToZeroPrice/><AddStockSalesOrderText>N</AddStockSalesOrderText><AddDangerousGoodsText>N</AddDangerousGoodsText><UseStockDescSupplied /><ValidateShippingInstrs /><AllocationAction>A</AllocationAction><IgnoreWarnings>Y</IgnoreWarnings><AddAttachedServiceCharges/><StatusInProcess>N</StatusInProcess><StatusInProcessResponse/><WarnIfCustomerOnHold>N</WarnIfCustomerOnHold><AcceptKitOptional>Y</AcceptKitOptional><AllowBackOrderForPartialHold>Y</AllowBackOrderForPartialHold><AllowBackOrderForSuperseded>Y</AllowBackOrderForSuperseded><OverrideCustomerBackOrder>Y</OverrideCustomerBackOrder><UseMasterAccountForCustomerPartNo/><ApplyLeadTimeCalculation>N</ApplyLeadTimeCalculation><ApplyParentDiscountToComponents>N</ApplyParentDiscountToComponents><AllowManualOrderNumberToBeUsed>N</AllowManualOrderNumberToBeUsed><ReserveStock>N</ReserveStock><ReserveStockRequestAllocs>N</ReserveStockRequestAllocs><AllowBackOrderForNegativeMerchLine>Y</AllowBackOrderForNegativeMerchLine><PutEntireQuantityOnNewLoadWhenChanged>N</PutEntireQuantityOnNewLoadWhenChanged><MinimumChargeLineZero>N</MinimumChargeLineZero><UpdateWhLast>N</UpdateWhLast></Parameters></SalesOrders>';
                response.put('response_x', (object)response_x);
            }
        }
}