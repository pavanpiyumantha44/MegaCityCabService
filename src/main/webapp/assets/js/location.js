
const map = L.map('map').setView([6.9388614, 79.8542005], 13); // Default center (London)
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
}).addTo(map);

let routingControl;
let markers = [];

function showRoute() {
    const startAddress = document.getElementById('pickup_location').value;
    const endAddress = document.getElementById('destination').value;

    if (!startAddress || !endAddress) {
        //alert("Please enter both start and end addresses.");
        return;
    }

    geocodeAddress(startAddress, (startCoords) => {
        geocodeAddress(endAddress, (endCoords) => {

            if (routingControl) {
                map.removeControl(routingControl);
            }
            markers.forEach(marker => map.removeLayer(marker));
            markers = [];

            routingControl = L.Routing.control({
                waypoints: [
                    L.latLng(startCoords[0], startCoords[1]),
                    L.latLng(endCoords[0], endCoords[1])
                ],
                routeWhileDragging: true,
                lineOptions: {
                    styles: [{ color: '#007bff', weight: 6, opacity: 0.8 }]
                }
            }).addTo(map);


            routingControl.on('routesfound', function(e) {
                let route = e.routes[0]; // First route
                let distance = (route.summary.totalDistance / 1000).toFixed(2);
                let duration = Math.ceil(route.summary.totalTime / 60);

                document.getElementById("distance_km").value = distance+" Km";
                document.getElementById("duration").value = duration+" Min";
            });

            const redIcon = L.icon({
                iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34]
            });

            let startMarker = L.marker(startCoords).addTo(map).bindPopup("Start Location").openPopup();
            let endMarker = L.marker(endCoords, { icon: redIcon }).addTo(map).bindPopup("End Location").openPopup();

            markers.push(startMarker, endMarker);

            const bounds = L.latLngBounds([startCoords, endCoords]);
            map.fitBounds(bounds);
        });
    });
}

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
                Toastify({
                    text: "Couldn't find the route",
                    duration: 3000,
                    close: true,
                    gravity: "top",
                    position: "center",
                    backgroundColor: "red",
                }).showToast();
            }
        })
        .catch(error => console.error('Geocoding error:', error));
}

showRoute();
