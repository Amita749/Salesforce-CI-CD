import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import checkFolderId from '@salesforce/apex/OneDriveIntegrationCtrl.checkFolderId';
import createFolder from '@salesforce/apex/OneDriveIntegrationCtrl.createFolderAndSubFolder';
import uploadFile from '@salesforce/apex/OneDriveIntegrationCtrl.uploadFile';
import deleteDocument from '@salesforce/apex/OneDriveIntegrationCtrl.deleteDocument';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
const columns = [
                { label: 'Name', fieldName: 'fileName', },
                { label: 'Preview',fieldName: '',cellAttributes: { iconName: 'utility:preview' }},
                { label: 'Download',fieldName: '',cellAttributes: { iconName: 'utility:download' }},
                { label: 'Delete',fieldName: '',cellAttributes: { iconName: 'utility:delete' }}
            ];

export default class OneDriveIntegration extends NavigationMixin(LightningElement) {
    columns = columns;
    showUploadButton;
    showFileDataTable = false;
    disableAttachButton = true;
    showUploadedDocumentTable = false;
    folderId = '';
    subFolderIds = {};
    showSpinner = true;
    @api recordId;
    @api residentialLoanApplicationId;
    @api opportunityId;
    @track filesUploaded = [];
    @track uploadedFiles = [];
    ij = 0;

    get options() {
        return [
            { label: 'Pre-Project', value: 'Pre-Project' },
            { label: 'Project-Initiation-Documents', value: 'Project-Initiation-Documents' },
            { label: 'RFI', value: 'RFI' },
            { label: 'Requirements-Design', value: 'Requirements-Design' },
            { label: 'ITT', value: 'ITT' },
            { label: 'Project-Financial-Accounting', value: 'Project-Financial-Accounting' },
            { label: 'Contracts', value: 'Contracts' },
            { label: 'Project-Plan', value: 'Project-Plan' },
            { label: 'Work-Packages', value: 'Work-Packages' },
            { label: 'QA-Integration-Testing', value: 'QA-Integration-Testing' },
            { label: 'Change-Control-Requests', value: 'Change-Control-Requests' },
            { label: 'Stakeholder-Communications', value: 'Stakeholder-Communications' },
            { label: 'Service-Transition-to-BaU', value: 'Service-Transition-to-BaU' },
            { label: 'Project-Logs', value: 'Project-Logs' },
            { label: 'Project-Closure', value: 'Project-Closure' }
        ];
    }

    invokeEmail() {
        var pageRef = {
            type: "standard__quickAction",
            attributes: {
                apiName:"Global.SendEmail"
            },
            state: {
                recordId: this.recordId,
                defaultFieldValues:
                    encodeDefaultFieldValues({
                        HtmlBody: "Need Addtional Documents",
                        Subject:"Need Addtional Documents"
                    })
            }
        };
        this[NavigationMixin.Navigate](pageRef);
    }

    connectedCallback() {
        var idToPass;
        if(this.recordId){
            idToPass = this.recordId;
        }else if(this.opportunityId){
            idToPass = this.opportunityId;
        }else if(this.residentialLoanApplicationId){
            idToPass = this.residentialLoanApplicationId;
        }
        checkFolderId({recordId : idToPass}).then( result=>{
            this.showSpinner = false;
            console.log('aaya12'+JSON.stringify(result));
            console.log(result);
            if(result == null){
                //throw Error
                this.showUploadButton = true;
            }else{
                if(result.uploadDocuments.length>0){
                    this.uploadedFiles = result.uploadDocuments;
                    this.showFileDataTable = true;
                }
                this.subFolderIds = result.docFolIds;
                console.log('Subfolder: '+JSON.stringify(this.subFolderIds));
                this.showUploadButton = false;
                this.folderId = result.folderId;
                console.log('folderId: '+this.folderId);
            }  
        }).catch(error => {
            console.log(error);
            this.showSpinner = false;
        });
    }

    createFolder(){
        this.showSpinner = true;
        var idToPass;
        if(this.recordId){
            idToPass = this.recordId;
        }else if(this.opportunityId){
            idToPass = this.opportunityId;
        }else if(this.residentialLoanApplicationId){
            idToPass = this.residentialLoanApplicationId;
        }
        createFolder({recordId : idToPass}).then( result=>{
            if(result!=null){
                console.log(result);
                this.showUploadButton = false;
                this.showSpinner = false;
                this.folderId = result.folderId;
                this.subFolderIds = result.subFolderIds;
            }else{
                //Throw error;
                this.showSpinner = false;
            }
        }).catch(error => {
            console.log(error);
            this.showSpinner = false;
        });
    }

    handleSelectedFiles(event){
        this.disableAttachButton = false;
        //var ij = 0;
        if(event.target.files.length>0){
            for(var i=0; i< event.target.files.length; i++){
                let file = event.target.files[i];
                let reader = new FileReader();
                reader.onload = e => {
                    // let base64 = 'base64,';
                    // let content = reader.result.indexOf(base64) + base64.length;
                    // let fileContents = reader.result.substring(content);
                    // this.filesUploaded.push({fileIndex: this.ij, title: file.name, fileType:'', fileTypeId:'', versionData: atob(fileContents)});
                    this.filesUploaded.push({fileIndex: this.ij, title: file.name, fileType:'', fileTypeId:'', versionData: reader.result.split(',')[1]});
                    this.ij++;
                };
                
                reader.readAsDataURL(file);
                this.showUploadedDocumentTable = true;
                console.log(this.filesUploaded.length);
                
            }
        }else{
            this.showUploadedDocumentTable = false;
        }
        // if(this.filesUploaded.length > 0){
        //     this.showUploadedDocumentTable = true;
        // }
    }

    handleTypeChange(event){
        var element = this.filesUploaded.find(ele => ele.fileIndex == event.target.dataset.id);
        element.fileType = event.detail.value;
        element.fileTypeId = this.subFolderIds[event.detail.value];
        this.filesUploaded = [...this.filesUploaded];
    }

    attachFiles(){
        var element = this.filesUploaded.filter(ele => ele.fileType == "" );   
        if(element.length == 0){
            this.showSpinner = true;
            uploadFile({files: this.filesUploaded}).then(result =>{
                if(result.length>0){
                    if(this.uploadedFiles.length == 0){
                        this.uploadedFiles = result;
                        const evt = new ShowToastEvent({
                            title: 'Success',
                            message: 'File Uploaded',
                            variant: 'success',
                        });
                        this.dispatchEvent(evt);
                    } else {
                        this.uploadedFiles = this.uploadedFiles.concat(result);
                    }
                    this.disableAttachButton = true;
                }
                this.showFileDataTable = true;
                this.showUploadedDocumentTable = false;
                this.filesUploaded = [];
                this.showSpinner = false;
                
            }).catch(error => {
                console.log(error);
                this.showSpinner = true;
            });
        } else {
            const evt = new ShowToastEvent({
                title: 'Error',
                message: 'Please select Type for all files',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        } 
    }

    removeDocument(event){
        var index = parseInt(event.currentTarget.name,10);
        this.filesUploaded.splice(index, 1);
        if(this.filesUploaded.length == 0){
            this.showUploadedDocumentTable = false;
        }
    }

    previewDocument(event){
        var element = this.uploadedFiles.find(ele =>ele.fileId == event.currentTarget.dataset.id);
        window.open(element.webUrl,'_blank');
    }

    downloadDocument(event){
        var element = this.uploadedFiles.find(ele =>ele.fileId == event.currentTarget.dataset.id);
        window.open(element.downloadUrl,'_blank');
    }

    deleteDocument(event){
        this.showSpinner = true;
        var index = parseInt(event.currentTarget.name,10);
        deleteDocument({documentId : event.currentTarget.dataset.id}).then( result=>{
            if(result=='True'){
                this.showSpinner = false;
                this.uploadedFiles.splice(index, 1);
                const evt = new ShowToastEvent({
                    title: 'Success',
                    message: 'File Deleted',
                    variant: 'success',
                });
                this.dispatchEvent(evt);
                if(this.uploadedFiles.length == 0){
                    this.showFileDataTable = false;
                }
            }else{
              this.showSpinner = false;  
            }
        }).catch(error => {
            console.log(error);
            this.showSpinner = false;
        });
    }
}