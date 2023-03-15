import { LightningElement, wire, api, track } from 'lwc';
import { NavigationMixin, CurrentPageReference } from "lightning/navigation";
import getProductsCount from "@salesforce/apex/AddOrEditOrderProductsController.getProductsCount";
import getAllProducts from "@salesforce/apex/.getAllProducts";
import getOrderProducts from "@salesforce/apex/AddOrEditOrderProductsController.getOrderProducts";
import addProductsToOrder from "@salesforce/apex/AddOrEditOrderProductsController.addProductsToOrder";
import ROGZProductArchitectureSheet from '@salesforce/resourceUrl/ROGZProductArchitectureSheet';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from "@salesforce/apex";

const addcolumns =
    [
        { label: 'Product Image', fieldName: 'productImage', type: 'imageDisplay' },
        { label: 'Quantity', fieldName: 'quantity', type: 'number', editable: 'true' },
        { label: 'Available Quantity', fieldName: 'availableQuantity', type: 'double' },
        { label: 'Product Description', fieldName: 'name', type: 'text', typeAttributes: {} },
        { label: 'Product SKU', fieldName: 'product2StockKeepingUnit', type: 'text' },
        { label: 'List Price', fieldName: 'unitPrice', type: 'currency', typeAttributes: { currencyCode: 'ZAR', currencyDisplayAs: 'code' }, cellAttributes: { alignment: 'left' } },
    ];
const editcolumns =
    [
        { label: 'Product Image', fieldName: 'productImage', type: 'imageDisplay' },
        { label: 'Quantity', fieldName: 'quantity', type: 'numAddOrEditOrderProductsControllerber', editable: 'true' },
        { label: 'Available Quantity', fieldName: 'availableQuantity', type: 'double' },
        { label: 'Product Description', fieldName: 'name', type: 'text', typeAttributes: {} },
        { label: 'Product SKU', fieldName: 'product2StockKeepingUnit', type: 'text' },
        { label: 'Unit Price', fieldName: 'unitPrice', type: 'currency', typeAttributes: { currencyCode: 'ZAR', currencyDisplayAs: 'code' }, cellAttributes: { alignment: 'left' } },
    ];


export default class AddOrEditOrderProducts extends NavigationMixin(LightningElement) {
    @api recordId;
    @api mode;
    allProducts = [];
    filteredProducts = [];
    orderProducts = [];
    columns;
    productData = [];
    disableSave = false;
    disableCancel = false;
    wiredOrderProductsValue;
    wiredAllProductsValue;
    totalNoOfProducts;
    selectedProductIds = [];
    @track preSelectedRows = [];
    @track initialRecords;
    @track arrayOfMappedChoosen = [];
  

    get defaultSelectedRows() {
        return this.preSelectedRows;
    }
    fetchProducts(clearAll, eventTarget) {
        console.log('eventTarget   ', eventTarget);
        const params = {
            orderId: this.recordId,
            brand: this.filters.product2Brand,
            division: this.filters.product2Divison,
            category: this.filters.product2Category,
            range: this.filters.product2Range,
            function: this.filters.product2Function,
            product: this.filters.Name,
            sku: this.filters.product2StockKeepingUnit,
            offsetCount: this.isFiltersChange ? 0 : this.productData.length
        };
        console.log('params   ', params);
        getAllProducts({ search: params })
            .then((data) => {
                console.log('data  ', data);
                this.totalNoOfProducts = data.searchTotalCount;
                if (clearAll) {
                    this.productData = [...data.products];
                    this.initialRecords = [...data.products];
                }
                else {
                    this.productData = this.productData.concat([...data.products]);
                    this.initialRecords = this.productData.concat([...data.products]);
                }

                if (this.productData.length >= this.totalNoOfProducts) {
                    if (eventTarget)
                        eventTarget.enableInfiniteLoading = false;
                    this.loadMoreStatus = 'No more data to load';
                } else {
                    this.loadMoreStatus = '';
                }
                if (eventTarget)
                    eventTarget.isLoading = false;
            })
            .catch(error => {
                console.log('Error  ', error);
            });
    }

    loadMoreData(event) {
        const eventTarget = event.target;
        eventTarget.isLoading = true;
        this.loadMoreStatus = 'Loading';
        console.log('..................');
        this.isFiltersChange = false;
        this.fetchProducts(false, eventTarget);

    }


    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        if (currentPageReference.state.c__recordId) {
            this.recordId = currentPageReference.state.c__recordId;
        }

        if (currentPageReference.state.c__mode) {
            this.mode = currentPageReference.state.c__mode;
        }

        if (this.mode === 'add') {
            this.columns = addcolumns;
            console.log('Current page reference mode ADD fetching products ');
            this.fetchProducts(true);
        }
     
        if (this.mode === 'edit') {
            this.columns = editcolumns;
        }
    }


    escapeRegExp(str) {
        return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
    }

    filterBy(prop, term) {
        const re = new RegExp(this.escapeRegExp(term), 'i')
        return product => {
            if (product.hasOwnProperty(prop) && re.test(product[prop])) {
                return true;
            }
            return false;
        }
    }

    //const found = people.filter(filterBy(searchString))
    filters = {};
    isFiltersChange = false;
    handleChange(event) {

        this.filters[event.target.name] = event.target.value;
        console.log('Filters Changed fetching products ', this.filters);
        this.isFiltersChange = true;
        this.fetchProducts(true);

    }

    renderedCallback() {
        console.log('renderedCallback .... ');
    }

    draftValues = [];

    handleKeyUp(event) {
        console.log('eventeventevent .... ');
        // Write additional code to identify the key pressed from the key code, if required
        const tableEditedEvent = new CustomEvent('tableedit');
        this.dispatchEvent(tableEditedEvent);
    }


    toggleButtons(value) {
        this.disableCancel = value;
        this.disableSave = value;
    }
    handleCellChange(event) {
        console.log('Cell Change ...................');
    }




    /*
    * The event fired when the Save button is clicked
    */
    handleSave() {

        this.toggleButtons(true);


        let saveDraftValues = this.template.querySelector('c-custom-datatable').draftValues;
        console.log('saveDraftValues  : ', JSON.stringify(saveDraftValues));

       // let selectedRecords = this.template.querySelector('c-custom-datatable').getSelectedRows();

        let productWithQuantities = [];
        if (this.mode === 'add') {
            //display error for products without quantities
            console.log('saveDraftValues.length savedraft=============> ' +saveDraftValues.length);
            console.log('t this.selectedRows.length=============> ' +  this.selectedRows.length);
            console.log('this.selectedProductIds =============> ' +  this.selectedProductIds.length );
            if (this.selectedProductIds.length  !== this.selectedRows.length) {
                this.showNotification('', 'Please confirm all products are selected and have quantities ', 'warning');
                productWithQuantities = [];

            } else {
                let draftValueIdLst = [];

                saveDraftValues.forEach(d => {
                    console.log('this is the quantity for savedraft=============> ' + d.quantity);

                    console.log(' this.arrayOfMappedChoosen : ', JSON.stringify(this.arrayOfMappedChoosen));

                    console.log(' this.IS ===========> d : ', JSON.stringify(d));
                    var prod = this.arrayOfMappedChoosen.find(p => p.priceBookEntryId == d.priceBookEntryId);

                    console.log('this.is var prod : ', JSON.stringify(prod));

                    console.log('this.selectedProductIds 22 : ', JSON.stringify(this.selectedProductIds));
                    if (this.selectedProductIds.includes(d.priceBookEntryId))
                        productWithQuantities.push({ Product2Id: d.priceBookEntryId, Quantity: d.quantity, OrderId: this.recordId, UnitPrice: prod.UnitPrice });


                });

                console.log(' result raftValueIdLst CHECK: ', draftValueIdLst);

                console.log(' result FOR QUANTITY CHECK: ', JSON.stringify(draftValueIdLst));
            }
        } else if (this.mode === 'edit') {
            let orderItems = []; 
            //result.length
            console.log(' this.selectedProductIds===========in edit : '+ this.selectedProductIds);
            saveDraftValues.forEach(d => {
                console.log(' d  ===========in edit : ',d);

                console.log(' saveDraftValues ===========in edit : ', saveDraftValues);
                if (this.selectedProductIds.includes(d.priceBookEntryId))
                    orderItems.push({ Quantity: d.quantity, Id: d.orderItemId });
            });
            productWithQuantities = orderItems;
        }
        if (productWithQuantities.length > 0) {
            console.log('productWithQuantities  : ', productWithQuantities);
            addProductsToOrder({ recordId: this.recordId, items: productWithQuantities })
                .then(() => {
                    let successMessage = productWithQuantities.length + ' order products ' + (this.mode === 'add' ? 'added' : 'updated') + ' successfully';
                    this.showNotification('', successMessage, 'success');
                    refreshApex(this.wiredOrderProductsValue);
                    this.isFiltersChange = true;
                    this.fetchProducts(true);
                    //refreshApex(this.wiredAllProductsValue);
                    this.toggleButtons(false);
                    this.navigateToRecordViewPage();
                })
                .catch(error => {
                    this.toggleButtons(false);
                    console.log('Error  ', error);
                    let errorMessage = 'Unknown error';
                    if (Array.isArray(error.body)) {
                        errorMessage = error.body.map(e => e.message).join(', ');
                    } else if (typeof error.body.message === 'string') {
                        errorMessage = error.body.message;
                    }
                    this.showNotification('Error', errorMessage, 'error');
                });
        } else {
            this.toggleButtons(false);
        }
    }

    handleSelection(event) {


        this.selectedProductIds = [];
        let updatedItemsSet = new Set();
        var arr = [];
        // List of selected items we maintain.
        let selectedItemsSet = new Set(this.selectedRows);
        // List of items currently loaded for the current view.
        let loadedItemsSet = new Set();
        this.productData.map((ele) => {

            console.log('==================> element ' + JSON.stringify(ele));
            //loadedItemsSet.add(ele.product2Id);
            console.log('==================> element product2Id ' + JSON.stringify(ele.product2Id));

            loadedItemsSet.add(ele.priceBookEntryId);

            console.log('==================> loadedItemsSet inside ' + loadedItemsSet);
        });

        if (event.detail.selectedRows) {
            event.detail.selectedRows.map((ele) => {
                updatedItemsSet.add(ele.priceBookEntryId);
                this.arrayOfMappedChoosen.push({ priceBookEntryId: ele.priceBookEntryId, Quantity: ele.quantity, UnitPrice: ele.unitPrice });


            });


            // Add any new items to the selectedRows list
            updatedItemsSet.forEach((id) => {
                if (!selectedItemsSet.has(id)) {
                    selectedItemsSet.add(id);
                }
            });
        }

        loadedItemsSet.forEach((id) => {
            if (selectedItemsSet.has(id) && !updatedItemsSet.has(id)) {
                // Remove any items that were unselected.
                selectedItemsSet.delete(id);
            }
        });

        this.selectedRows = [...selectedItemsSet];
        console.log('selectedRows==> ' + JSON.stringify(this.selectedRows));



        this.selectedRows.forEach(p => {
            this.selectedProductIds.push(p);
        })
        console.log('this.selectedProductIds ', this.selectedProductIds);
        console.log('arrayOfMappedChoosen ', JSON.stringify(this.arrayOfMappedChoosen));




    }

    handleClick() {
        const dt = this.template.querySelector('c-custom-datatable');
        dt.openInlineEdit();
    }

    closeProducts() {
        this.navigateToRecordViewPage();
    }

    showNotification(t, m, v) {
        const evt = new ShowToastEvent({
            title: t,
            message: m,
            variant: v,
        });
        this.dispatchEvent(evt);
    }




    navigateToRecordViewPage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                actionName: 'view'
            }
        }, true);
    }

    get isAdd() {
        return this.mode === 'add';
    }
    get isEdit() {
        return this.mode === 'edit';
    }
    openCS() {
        window.open(ROGZProductArchitectureSheet);
    }
}