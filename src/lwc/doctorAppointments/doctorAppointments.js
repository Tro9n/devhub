import {LightningElement, wire} from 'lwc';
import getAllEvents from '@salesforce/apex/ContactController.getAllEvents'

export default class DoctorAppointments extends LightningElement {
    doctors;
    error;
    date;
    events = {};


    handleAppointmentDate(event) {
        this.date = event.target.value.toString()
            .replace('T', ' ');
        this.date = this.date.substring(0, event.target.value.length - 5);
        getAllEvents({data: this.date}).then(result => {
            this.events = result;
            console.log('result ', result);
        }).catch(e => {
            console.log(e);
        });
        console.log(this.events);
    }



}