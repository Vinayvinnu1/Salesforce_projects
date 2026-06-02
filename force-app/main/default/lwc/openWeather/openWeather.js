import { LightningElement, track } from 'lwc';

import getWeather from '@salesforce/apex/WeatherAPI.getWeather';

export default class WeatherApp extends LightningElement {

    city = '';

    @track weatherData;

    cityName;
    temperature;
    humidity;
    windSpeed;
    weatherMain;

    handleCityChange(event) {

        this.city = event.target.value;
    }

    getWeatherData() {

        getWeather({ city: this.city })

            .then(result => {

                this.weatherData = JSON.parse(result);

                this.cityName = this.weatherData.name;

                this.temperature =
                    this.weatherData.main.temp;

                this.humidity =
                    this.weatherData.main.humidity;
                this.windSpeed =
                    this.weatherData.wind?.speed;

                this.weatherMain =
                    this.weatherData.weather[0].main;
            })

            .catch(error => {

                console.error(error);

                alert('Error fetching weather data');


                I
            });
    }
}