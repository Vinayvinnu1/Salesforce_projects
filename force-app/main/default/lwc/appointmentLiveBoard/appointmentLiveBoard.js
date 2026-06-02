import { LightningElement, track } from 'lwc';
import { subscribe, onError } from 'lightning/empApi';

const CHANNEL = '/event/Appointment_Alert__e';

export default class AppointmentLiveBoard extends LightningElement {

  @track appointments = [];  // Reactive array of appointments
  @track isLoading = true;
  subscription = {};

  get hasAppointments() {
    return this.appointments.length > 0;
  }

  connectedCallback() {
    // When component loads, start listening for Platform Events
    this.subscribeToEvents();
    this.registerErrorListener();
  }

  subscribeToEvents() {
    // -1 means: give me all new events from now on
    subscribe(CHANNEL, -1, (response) => {
      this.handleEvent(response);
    }).then(response => {
      this.subscription = response;
      this.isLoading = false;
    });
  }

  handleEvent(response) {
    const data = response.data.payload;

    // Add the new appointment to the list (unshift = add to top)
    this.appointments = [{
      id:         data.Appointment_Id__c,
      doctorName: data.Doctor_Name__c,
      status:     data.Status__c,
      priority:   data.Priority__c
    }, ...this.appointments];
  }

  registerErrorListener() {
    onError(error => {
      console.error('Platform Event Error:', JSON.stringify(error));
    });
  }
}
