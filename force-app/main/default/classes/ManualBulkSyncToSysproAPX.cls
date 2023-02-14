/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-11-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ManualBulkSyncToSysproAPX {
 
    @AuraEnabled
	public static String getConfirmedOrders(List<Id> ids){


        Last_Job_CompletedDate__mdt JCD = Last_Job_CompletedDate__mdt.getInstance('Job_Completed_Date');
        System.debug('CompletedDate__c Unformatted================> '+JCD.CompletedDate__c);
        
        
        STRING dateStringify = STRING.valueOf(JCD.CompletedDate__c);
        Datetime myStartDate = Datetime.valueOfGMT(dateStringify);
        system.debug('myStartDate================> '+myStartDate);
       // this.startTime = myStartDate;
        
      
        DateTime myEndDate = System.now();
        system.debug('myEndDate================> '+myEndDate);

        //
        
         
        if('Rogz Sales Profile' == [SELECT Name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name)
            throw new AuraHandledException('Your are not authorized to click on this button');

        List<Order> orders = [SELECT Id, Status FROM Order WHERE Status LIKE '%Confirmed%' AND LastModifiedDate >= : myStartDate AND  LastModifiedDate <= : myEndDate ];
        if(orders.isEmpty()){
            throw new AuraHandledException('Please Select only the Confirmed Orders');
        }
        else{
            try{
              //  for(Order o:orders){
              //      o.Status = 'Post to Syspro';
              //  }
              //  update orders;

                ManualBulkSyncToSysproController.getListProcessorPostOrderDetails(orders);
                
                
            }catch(Exception e){
                throw new AuraHandledException(e.getMessage());
            }
        }
        return  orders.size()+ '  Records sent for Processing';
    }


}
