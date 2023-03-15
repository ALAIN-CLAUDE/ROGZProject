import { LightningElement ,wire,track,api} from 'lwc';
import getLwcIframeUrl from '@salesforce/apex/roqzLwcIframeAPX.getLwcIframeUrl';

export default class RoqzLwcIframe extends LightningElement {

    @api height ;

    @api width;

  loginUserUrl;
  UserFirstName;

    ///1)create custom metadata or filed to store url values. grab it dynamically and display url field on component based on login user 
    //2) show an input field that user can insert their url and based oin that display the bi dashboard

    @wire(getLwcIframeUrl)
    wiredLinks({error, data }) {
        if (data){
          console.log('the user url=============> '+JSON.stringify(data) );

              this.loginUserUrl = data[0].User_URL__c;
              this.UserFirstName ='Welcome: '+ data[0].User_Name__r.FirstName.toUpperCase();

        } else if (error) {
           this.error = error;
           console.log('the error=============> '+JSON.stringify(error));
        }
    }



}