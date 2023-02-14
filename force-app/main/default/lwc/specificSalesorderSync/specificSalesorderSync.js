import { LightningElement, api } from "lwc";
import getSpecificSalesorderSync from "@salesforce/apex/specificSalesorderSync.getSpecificSalesorderSync";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class SpecificSalesorderSync extends LightningElement {
    _listViewIds;
    @api 
      get listViewIds(){

          return this._listViewIds;
      }
     
      set listViewIds(value){
          this._listViewIds = value;
          console.log(JSON.stringify(value));
       
          getSpecificSalesorderSync({ ids: value })
          .then(result => {
              console.log(result);
              this.showNotification("Success", result, "success");
              
          }).catch(error => {
              console.log(error);
              let strError = "Unknown error";
              if (error.body) {
                if (Array.isArray(error.body)) {
                  strError = error.body.map(e => e.message).join(", ");
                } else if (typeof error.body.message === "string") {
                  strError = error.body.message;
                }
              }
            //  console.log(json.stringify(strError));
              this.showNotification("Error", strError, "error");
              
          });
      }
  
    showNotification(title, message, variant) {
      console.log('title   ' , title);
      console.log('message   ' , message);  
      console.log('variant   ' , variant);
      const evt = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant
      });
      this.dispatchEvent(evt);
      alert(message);
      this.close();
    }
  
    close() {
      setTimeout(function() {
        window.history.back();
      }, 1000);
    }
}