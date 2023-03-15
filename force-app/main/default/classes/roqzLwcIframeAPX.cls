/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-14-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class roqzLwcIframeAPX {
    @AuraEnabled(cacheable=true)
    public static Power_Bi_URL__c [] getLwcIframeUrl(){

        String userId= userinfo.getUserId();

        Power_Bi_URL__c [] urllist = [SELECT Id, User_Name__c, User_Name__r.FirstName, User_URL__c FROM Power_Bi_URL__c where 	User_Name__c =:userId limit 1];
        system.debug(urllist);

        if(!urllist.isEmpty()){
            return urllist;
        }else{
         
             return null;
        }


    }
}