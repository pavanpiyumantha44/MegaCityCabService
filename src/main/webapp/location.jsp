<!DOCTYPE html>
<html>
<head>
    <title>Display Directions with Geocoding</title>
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
            font-size: 18px;
            margin-top: 10px;
            font-weight: bold;
        }
        #distance, #duration {
            margin-right: 20px;
        }
    </style>
</head>
<body>
    <label for="start">Start Location (Address):</label>
    <input type="text" id="start" placeholder="Enter start address">
    <label for="end">End Location (Address):</label>
    <input type="text" id="end" placeholder="Enter end address">
    <button onclick="showRoute()">Show Route</button>
    <div id="map"></div>

    <div id="info">
        <div id="distance">Distance: - km</div>
        <div id="duration">Duration: - min</div>
    </div>

    <script>
        // Initialize the map
        const map = L.map('map').setView([51.505, -0.09], 13); // Default center (London)
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        let routingControl;
        let markers = []; // Store markers globally

        function showRoute() {
            const startAddress = document.getElementById('start').value;
            const endAddress = document.getElementById('end').value;

            if (!startAddress || !endAddress) {
                alert("Please enter both start and end addresses.");
                return;
            }

            // Geocode the start and end addresses
            geocodeAddress(startAddress, (startCoords) => {
                geocodeAddress(endAddress, (endCoords) => {
                    // Remove previous route and markers
                    if (routingControl) {
                        map.removeControl(routingControl);
                    }
                    markers.forEach(marker => map.removeLayer(marker)); // Remove previous markers
                    markers = []; // Clear marker array

                    // Add routing control with the geocoded coordinates
                    routingControl = L.Routing.control({
                        waypoints: [
                            L.latLng(startCoords[0], startCoords[1]), // Start point
                            L.latLng(endCoords[0], endCoords[1])     // End point
                        ],
                        routeWhileDragging: true,
                        lineOptions: {
                            styles: [{ color: '#007bff', weight: 6, opacity: 0.8 }] // Custom route style
                        }
                    }).addTo(map);

                    // Listen for route calculation and display distance & duration
                    routingControl.on('routesfound', function(e) {
                        let route = e.routes[0]; // First route
                        let distance = (route.summary.totalDistance / 1000).toFixed(2); // Convert meters to km
                        let duration = Math.ceil(route.summary.totalTime / 60); // Convert seconds to minutes

                        document.getElementById("distance").innerText = `Distance: ${distance} km`;
                        document.getElementById("duration").innerText = `Duration: ${duration} min`;
                    });

                    // Define a red marker icon for the endpoint
                    const redIcon = L.icon({
                        iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34]
                    });

                    // Add new markers
                    let startMarker = L.marker(startCoords).addTo(map).bindPopup("Start Location").openPopup();
                    let endMarker = L.marker(endCoords, { icon: redIcon }).addTo(map).bindPopup("End Location").openPopup();

                    // Store markers so they can be removed next time
                    markers.push(startMarker, endMarker);

                    // Adjust the map view to fit the route
                    const bounds = L.latLngBounds([startCoords, endCoords]);
                    map.fitBounds(bounds);
                });
            });
        }

        // Function to geocode an address using OpenStreetMap's Nominatim API
        function geocodeAddress(address, callback) {
            const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(address)}`;

            fetch(url)
                .then(response => response.json())
                .then(data => {
                    if (data.length > 0) {
                        const lat = parseFloat(data[0].lat);
                        const lon = parseFloat(data[0].lon);
                        callback([lat, lon]);
                    } else {
                        alert("Location not found. Please enter a valid address.");
                    }
                })
                .catch(error => console.error('Geocoding error:', error));
        }
    </script>
</body>
</html>
