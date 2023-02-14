/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-10-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class specificSalesorderSync {
   
    @AuraEnabled
    public static String getSpecificSalesorderSync(List<Id> ids){
        List<Order> ordersUpdateList = new List<Order> ();
            List<Order>  ordIdList = new List<Order> ();
            set<id> ordSet = new set<id>();

        if('Rogz Sales Profile' == [SELECT Name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name)
            throw new AuraHandledException('Your are not authorized to click on this button');

    

          for(id ordId : ids){
            ordSet.add(ordId);
          }

          //  Database.executeBatch(new BulkPostOrderdetailsToSYSPro(query), 200);
      //  List<Order> orders = [SELECT Id, Status FROM Order WHERE Status LIKE '%Confirmed%' and id in : ordSet];

        String query = 'SELECT Id, Status FROM Order WHERE Status LIKE %Confirmed% and id in : ordSet';
        List<Order> orders  = Database.query(query);
        if(orders.isEmpty()){
            throw new AuraHandledException('Batch found no Confirmed Orders Selected');
        }
        else{
            try{
                /*
                for(Order o:orders){
                    o.Status = 'Post to Syspro';
                }
                update orders;
                */
 
                for(Order ord :orders){
                    ord.Status = 'Post to Syspro';
                    //
                    ordersUpdateList.add(ord);
                   // ordIdList.add(ord.id);
                  
                }
               
                if(!ordersUpdateList.isEmpty()){
                    system.debug('size of ordMapUpdate===========> '+ordersUpdateList.size());
                    update ordersUpdateList;

                    Database.executeBatch(new BulkPostOrderdetailsToSYSPro(query), 200);

                }
              




            }catch(Exception e){
                throw new AuraHandledException(e.getMessage());
            }
        }
        return 'Successfully updated '+ orders.size()+ ' orders';
    }

}
