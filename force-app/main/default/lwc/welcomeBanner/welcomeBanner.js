import { LightningElement } from 'lwc';

import Banner from '@salesforce/resourceUrl/Banner';

export default class WelcomeBanner extends LightningElement {

    connectedCallback() {

        const style = document.createElement('style');

        style.innerText = `
            .banner-container{
                background-image:url(${Banner});
                background-size:cover;
                background-position:center;
            }
        `;

        document.head.appendChild(style);
    }

}