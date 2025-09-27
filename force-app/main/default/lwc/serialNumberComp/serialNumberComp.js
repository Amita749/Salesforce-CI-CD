import { LightningElement ,api} from 'lwc';
export default class SerialNumberComp extends LightningElement {
    @api index;
    get position() {
        return this.index + 1;
    }

}