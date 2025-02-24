<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Route Finder with Current Location</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>
    <style>
        #map {
            height: 500px;
            width: 100%;
        }
        label, input, button {
            margin: 5px;
        }
        #info {
            display: flex;
            justify-content: space-between;
            font-size: 18px;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <label for="start">Start Location (Auto-detected):</label>
    <input type="text" id="start" placeholder="Using your current location" disabled>
    <label for="end">End Location:</label>
    <input type="text" id="end" placeholder="Enter end address">
    <button onclick="showRoute()">Show Route</button>
    <div id="map"></div>
    <div id="info">
        <span id="distance">Distance: - km</span>
        <span id="duration">Duration: -</span>
    </div>

    <script>
        let map = L.map('map').setView([51.505, -0.09], 13); // Default view (London)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        let routingControl;
        let markers = [];
        let currentLocation;

        // Get user's current location
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                currentLocation = [position.coords.latitude, position.coords.longitude];
                map.setView(currentLocation, 13);

                // Place marker at current location
                let startMarker = L.marker(currentLocation).addTo(map)
                    .bindPopup("Your Location").openPopup();
                markers.push(startMarker);
            }, function (error) {
                alert("Unable to get location. Please enable location services.");
            });
        } else {
            alert("Geolocation is not supported by your browser.");
        }

        function showRoute() {
            const endAddress = document.getElementById('end').value;

            if (!endAddress) {
                alert("Please enter the destination address.");
                return;
            }

            // Geocode the end address
            geocodeAddress(endAddress, (endCoords) => {
                if (routingControl) {
                    map.removeControl(routingControl);
                }
                markers.forEach(marker => map.removeLayer(marker));
                markers = [];

                // Define red marker icon for the endpoint
                const redIcon = L.icon({
                    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png',
                    iconSize: [25, 41],
                    iconAnchor: [12, 41],
                    popupAnchor: [1, -34]
                });

                // Add routing control with current location as start
                routingControl = L.Routing.control({
                    waypoints: [
                        L.latLng(currentLocation[0], currentLocation[1]),
                        L.latLng(endCoords[0], endCoords[1])
                    ],
                    routeWhileDragging: true,
                    lineOptions: {
                        styles: [{ color: 'blue', weight: 6, opacity: 0.8 }]
                    }
                }).addTo(map);

                // Add end marker
                let endMarker = L.marker(endCoords, { icon: redIcon }).addTo(map)
                    .bindPopup("End Location").openPopup();
                markers.push(endMarker);

                // Fit map to route
                map.fitBounds(L.latLngBounds([currentLocation, endCoords]));

                // Calculate and display distance & time
                routingControl.on('routesfound', function (e) {
                    let route = e.routes[0];
                    let distanceKm = (route.summary.totalDistance / 1000).toFixed(2); // Convert to km
                    let durationSec = route.summary.totalTime; // In seconds
                    let durationHrs = Math.floor(durationSec / 3600);
                    let durationMin = Math.floor((durationSec % 3600) / 60);

                    document.getElementById('distance').innerText = `Distance: ${distanceKm} km`;
                    document.getElementById('duration').innerText = `Duration: ${durationHrs}h ${durationMin}m`;
                });
            });
        }

        // Function to geocode address using OpenStreetMap's Nominatim API
        function geocodeAddress(address, callback) {
            let url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(address)}`;

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data.length > 0) {
                        let lat = data[0].lat;
                        let lon = data[0].lon;
                        callback([parseFloat(lat), parseFloat(lon)]);
                    } else {
                        alert("Address not found. Please enter a valid location.");
                    }
                })
                .catch(error => {
                    alert("Error fetching location. Please try again.");
                });
        }
    </script>
</body>
</html>
