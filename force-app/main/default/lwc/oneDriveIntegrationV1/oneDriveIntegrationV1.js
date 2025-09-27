import { LightningElement,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import checkFolderId from '@salesforce/apex/OneDriveIntegrationCtrlV1.checkFolderId';
import createFolder from '@salesforce/apex/OneDriveIntegrationCtrlV1.createFolderAndStructure';
import uploadFile from '@salesforce/apex/OneDriveIntegrationCtrlV1.uploadFile';
import deleteDocument from '@salesforce/apex/OneDriveIntegrationCtrlV1.deleteDocument';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
const columns = [
                { label: 'Name', fieldName: 'fileName', },
                { label: 'Preview',fieldName: '',cellAttributes: { iconName: 'utility:preview' }},
                { label: 'Download',fieldName: '',cellAttributes: { iconName: 'utility:download' }},
                { label: 'Delete',fieldName: '',cellAttributes: { iconName: 'utility:delete' }}
            ];

export default class OneDriveIntegrationV1 extends NavigationMixin(LightningElement) {
    columns = columns;
    showUploadButton;
    showFileDataTable = false;
    disableAttachButton = true;
    showUploadedDocumentTable = false;
    folderId = '';
    showSpinner = true;
    @api recordId;
    @track filesUploaded = [];
    @track uploadedFiles = [];
    ij = 0;

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
        checkFolderId({recordId : this.recordId}).then( result=>{
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
        createFolder({recordId : this.recordId}).then( result=>{
            console.log('create folder result',result);
            if(result!=null){
                console.log(result);
                this.showUploadButton = false;
                this.showSpinner = false;
                this.folderId = result;
                console.log('create folderId: '+this.folderId);
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
                    this.filesUploaded.push({fileIndex: this.ij, title: file.name, fileTypeId: this.folderId, versionData: reader.result.split(',')[1]});
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

    attachFiles(){
        this.showSpinner = true;
        console.log('aaya',this.filesUploaded.length);
        uploadFile({files: this.filesUploaded}).then(result =>{
            console.log('upload folder result',result);
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