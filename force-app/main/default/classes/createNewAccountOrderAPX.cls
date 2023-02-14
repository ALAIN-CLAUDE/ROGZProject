/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 01-19-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class createNewAccountOrderAPX {
    public static void getcountOrderAPX(string recordId){


        String queryString = 'SELECT Id,name from Account where = :recordId';


        List<Account> lstAccount = Database.query(queryString);

        return lstAccount;
    }
}