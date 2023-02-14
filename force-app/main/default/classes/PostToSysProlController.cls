/**
 * @description       : This is used to collect selected record ids from flow and pass them in lwc cmp to check if record is in stage confirm  then switch status to post to syspro which is later picked up by process builder and send to invocable method for callout
 * @author            : xx-Unknown
 * @group             : 
 * @last modified on  : 01-08-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class PostToSysProlController {
    @AuraEnabled
	public static String getConfirmedOrders(List<Id> ids){
        if('Rogz Sales Profile' == [SELECT Name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name)
            throw new AuraHandledException('Your are not authorized to click on this button');

        List<Order> orders = [SELECT Id, Status FROM Order WHERE Status LIKE '%Confirmed%'];
        if(orders.isEmpty()){
            throw new AuraHandledException('Please Select only the Confirmed Orders');
        }
        else{
            try{
                for(Order o:orders){
                    o.Status = 'Post to Syspro';
                }
                update orders;
                
                
            }catch(Exception e){
                throw new AuraHandledException(e.getMessage());
            }
        }
        return 'Successfully updated '+ orders.size()+ ' orders';
    }
}