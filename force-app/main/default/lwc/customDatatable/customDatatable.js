import LightningDatatable from 'lightning/datatable';
import imageDisplay from './imageDisplay.html';

export default class CustomDatatable extends LightningDatatable  {
    static customTypes = {
        imageDisplay: {
            template: imageDisplay,
            standardCellLayout: false,
        }
    }
}