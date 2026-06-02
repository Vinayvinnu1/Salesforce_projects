import { LightningElement, track } from 'lwc';

import getYTVideos
from '@salesforce/apex/YTController.getYTVideos';


export default class YTSearchPlayer
extends LightningElement {


    @track searchInput = '';

    @track videoResults = [];

    @track finalError = '';

    @track viewUrl = '';

    @track isLoading = false;

    connectedCallback() {

        this.handleSubmit();
    }

    handleSearch(event) {

        this.searchInput =
        event.target.value;
    }

    handleKeyPress(event) {

        if (event.keyCode === 13) {

            this.handleSubmit();
        }
    }

    handleSubmit() {

        this.isLoading = true;

        getYTVideos({
            searchKey: this.searchInput
        })

        .then((results) => {

            this.videoResults = results;

            if (this.videoResults.length > 0) {

                this.showVideoInIframe(
                    this.videoResults[0].videoId
                );
            }
            this.finalError = '';
        })

        .catch((error) => {

            this.finalError =
                error?.body?.message
                || 'Unknown Error';
        })

        .finally(() => {

            this.isLoading = false;
        });
       
    }
    

    showVideoInIframe(videoId) {

        this.viewUrl =
        'https://www.youtube.com/embed/'
        + videoId;
    }

    watchVideo(event) {

        let selectedVideoId =
        event.currentTarget.dataset.id;

        this.showVideoInIframe(
            selectedVideoId
        );
    }

    handleImageError(event) {

        event.target.src =
        'https://via.placeholder.com/120x90?text=No+Image';
    }
}