import { LightningElement, track } from 'lwc';

const WEATHER_CONDITIONS = {
    0: 'Clear sky',
    1: 'Mainly clear',
    2: 'Partly cloudy',
    3: 'Overcast',
    45: 'Foggy',
    48: 'Depositing rime fog',
    51: 'Light drizzle',
    53: 'Moderate drizzle',
    55: 'Dense drizzle',
    61: 'Slight rain',
    63: 'Moderate rain',
    65: 'Heavy rain',
    71: 'Slight snow',
    73: 'Moderate snow',
    75: 'Heavy snow',
    80: 'Rain showers',
    95: 'Thunderstorm'
};

export default class Weather extends LightningElement {

    @track searchQuery = '';
    @track isDataLoaded = false;
    @track isLoading = false;

    @track location = '';
    @track temperature = '';
    @track condition = '';
    @track humidity = '';
    @track windSpeed = '';
    @track errorMessage = '';

    handleSearchInput(event) {
        this.searchQuery = event.target.value;
    }

    handleKeyPress(event) {
        if (event.keyCode === 13) {
            this.handleSearch();
        }
    }

    handleSearch() {

        if (!this.searchQuery.trim()) {
            this.errorMessage = 'Please enter a city name';
            this.isDataLoaded = false;
            return;
        }

        this.fetchWeatherData(this.searchQuery);
    }

    async fetchWeatherData(location) {

        this.isLoading = true;
        this.errorMessage = '';

        try {

            // Step 1: Geocoding API
            const geocodingUrl =
                `https://geocoding-api.open-meteo.com/v1/search?name=${encodeURIComponent(location)}&count=1&language=en&format=json`;

            const geoResponse = await fetch(geocodingUrl);
            const geoData = await geoResponse.json();

            if (!geoData.results || geoData.results.length === 0) {

                this.errorMessage =
                    'Location not found. Please try another city.';

                this.isDataLoaded = false;
                this.isLoading = false;

                return;
            }

            const result = geoData.results[0];

            const latitude = result.latitude;
            const longitude = result.longitude;

            const locationName =
                `${result.name},
                ${result.admin1 ? result.admin1 + ',' : ''}
                ${result.country}`;

            // Step 2: Weather API
            const weatherUrl =
                `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true&hourly=relativehumidity_2m&timezone=auto`;

            const weatherResponse = await fetch(weatherUrl);
            const weatherData = await weatherResponse.json();

            const current = weatherData.current_weather;

            if (!current) {
                throw new Error('Weather data unavailable');
            }

            //humidity
            let humidity = 'N/A';

if (
    weatherData.hourly &&
    weatherData.hourly.relativehumidity_2m &&
    weatherData.hourly.relativehumidity_2m.length > 0
) {

    humidity =
        Math.round(
            weatherData.hourly.relativehumidity_2m[0]
        );
}



            // Assign values
            this.location = locationName;
            this.temperature = Math.round(current.temperature);
            this.condition =
                WEATHER_CONDITIONS[current.weathercode] || 'Unknown';

            this.humidity = humidity;
            this.windSpeed = Math.round(current.windspeed);

            this.isDataLoaded = true;

        }
        catch (error) {

            console.error('Weather Error:', error);

            this.errorMessage =
                'Failed to fetch weather data';

            this.isDataLoaded = false;
        }
        finally {

            this.isLoading = false;
        }
    }

    get weatherIcon() {

        if (this.condition.includes('Clear')) {
            return '☀️';
        }

        if (
            this.condition.includes('Rain') ||
            this.condition.includes('Drizzle')
        ) {
            return '🌧️';
        }

        if (this.condition.includes('Thunder')) {
            return '⛈️';
        }

        if (this.condition.includes('Snow')) {
            return '❄️';
        }

        if (
            this.condition.includes('Cloud') ||
            this.condition.includes('Overcast')
        ) {
            return '☁️';
        }

        return '🌤️';
    }
}