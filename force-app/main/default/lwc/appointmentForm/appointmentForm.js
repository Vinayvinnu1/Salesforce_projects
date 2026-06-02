import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AppointmentForm extends LightningElement {

  handleSubmit(event) {
    event.preventDefault();  // Stop default form submit

    // Get the form and submit it
    const fields = event.detail.fields;
    this.template
      .querySelector('lightning-record-edit-form')
      .submit(fields);
  }

  handleSuccess(event) {
    // Show success notification
    const toastEvent = new ShowToastEvent({
      title: 'Appointment Booked!',
      message: 'Appointment has been created successfully.',
      variant: 'success'
    });
    this.dispatchEvent(toastEvent);
  }
}
