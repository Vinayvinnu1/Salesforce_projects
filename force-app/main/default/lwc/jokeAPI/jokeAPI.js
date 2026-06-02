import { LightningElement } from 'lwc';
import getData from '@salesforce/apex/JokeQuoteAPI.getData';

export default class JokeAPI extends LightningElement {

    setup = '';
    punchline = '';


    async getJokeData() {

        try {

            const result = await getData();

            this.setup = result.setup;
            this.punchline = result.punchline;

        } catch (error) {

            console.error('Error fetching joke:', error);

        }
    }
}