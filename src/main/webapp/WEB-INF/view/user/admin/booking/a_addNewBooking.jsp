<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<style>
#customerLookupTbl tbody tr {
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#customerLookupTbl tbody tr:hover {
    background-color: #f5f5f5;
}
#vehicleLookupTbl tbody tr {
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#vehicleLookupTbl tbody tr:hover {
    background-color: #f5f5f5;
}
</style>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">New Booking</li>
  </ol>
</nav>
<form id="newRideBookingForm">

    <div class="mt-5">
        <div class="border-bottom pb-4">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="label">Customer Id</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="user_id" id="user_id" placeholder="Customer" aria-label="Customer ID" readonly>
                                <button class="btn btn-outline-primary" type="button" id="customerLookup"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="label">Full Name</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="full_name" id="full_name" placeholder="Full Name" aria-label="Full Name" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="label">NIC</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="nic" id="nic" placeholder="NIC" aria-label="NIC" readonly>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="label">Email</label>
                            <div class="input-group">
                                <input type="email" class="form-control" name="email" id="email" placeholder="Email" aria-label="EMAIL" readonly>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <hr/>
            <p>Ride Info</p>
            <div class="container-fluid">
               <div class="row">
                   <div class="col-md-3 col-sm-12 mb-3">
                       <div class="form-group">
                           <label class="form-label">Pickup Location</label>
                           <div class="input-group">
                               <input type="text" class="form-control" name="pickup_location" id="pickup_location" placeholder="pickup location" aria-label="PICKUP LOCATION"value="" required>
                               <span class="input-group-text text-primary"><i class="fa-solid fa-location-dot"></i></i></span>
                               <input type="hidden" id="pickup_lat" name="pickup_lat" value=""/>
                               <input type="hidden" id="pickup_lon" name="pickup_lon" value=""/>
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3 col-sm-12 mb-3">
                       <div class="form-group">
                           <label class="form-label">Destination</label>
                           <div class="input-group">
                               <input type="text" class="form-control" name="destination" id="destination" placeholder="Destination" aria-label="DESTINATION" required>
                               <span class="input-group-text text-danger"><i class="fa-solid fa-location-dot"></i></i></span>
                               <input type="hidden" id="destination_lat" name="destination_lat" value=""/>
                               <input type="hidden" id="destination_lon" name="destination_lon" value=""/>
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3 col-sm-6 mb-3">
                       <div class="form-group">
                           <label class="form-label">Select Pickup Date</label>
                           <div class="input-group date">
                               <input type="date" class="form-control" id="datepicker" placeholder="Select Pickup Date" aria-label="DATETIME" required>
                               <span class="input-group-text text-success"><i class="fa-solid fa-calendar-days"></i></span>
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3 col-sm-6 mb-3">
                       <div class="form-group">
                           <label class="form-label">Select Pickup Time</label>
                           <div class="input-group time">
                               <input type="time" class="form-control" id="timepicker" placeholder="Select Pickup Time" aria-label="DATETIME" required>
                                <span class="input-group-text text-success"><i class="fa-solid fa-clock"></i></span>
                           </div>
                       </div>
                       <input type="hidden" id="pickup_dttm" name="pickup_dttm" value=""/>
                   </div>
                   <div class="col-md-12 col-sm-12 mb-12">
                       <div class="form-group">
                           <label class="form-label">Special Notes</label>
                           <div class="input-group time">
                               <textarea name="special_note" id="special_note" rows="3" class="form-control" placeholder="Enter Special Notes"></textarea>
                           </div>
                       </div>
                       <input type="hidden" id="pickup_dttm" name="pickup_dttm" value=""/>
                   </div>
               </div>
            </div>
            <hr/>
            <p>Vehicle Info</p>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-8 col-sm-12">
                        <div class="row">
                         <div class="col-md-6 col-sm-12 mb-3">
                               <div class="form-group">
                                   <label class="label">VIN</label>
                                   <div class="input-group">
                                       <input type="text" class="form-control" name="vin" id="vin" placeholder="Vehicle" aria-label="VIN" readonly>
                                       <input type="hidden" name="vehicle_id"  id="vehicle_id"/>
                                       <input type="hidden" name="current_meter_reading" id="current_meter_reading"/>
                                       <button class="btn btn-outline-primary" type="button" id="vehicleLookup"><i class="fa-solid fa-magnifying-glass"></i></button>
                                   </div>
                               </div>
                           </div>
                           <div class="col-md-6 col-sm-12 mb-3">
                               <div class="form-group">
                                   <label class="label">Registration Number</label>
                                   <div class="input-group">
                                       <input type="text" class="form-control" name="registration_number" id="registration_number" placeholder="Registration Number" aria-label="Registration Number" readonly>
                                   </div>
                               </div>
                           </div>
                           <div class="col-md-6 col-sm-12 mb-3">
                               <div class="form-group">
                                   <label class="label">Model</label>
                                   <div class="input-group">
                                       <input type="text" class="form-control" name="model" id="model" placeholder="Model" aria-label="MODEL" readonly>
                                   </div>
                               </div>
                           </div>
                           <div class="col-md-6 col-sm-12 mb-3">
                               <div class="form-group">
                                   <label class="label">No of Seats</label>
                                   <div class="input-group">
                                       <input type="email" class="form-control" name="no_of_seats" id="no_of_seats" placeholder="No Of Seats" aria-label="NO OF SEATS" readonly>
                                   </div>
                               </div>
                           </div>
                            <div class="col-md-6 col-sm-12 mb-3">
                                <div class="form-group">
                                    <label class="label">Price Per Day (200KM)</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="price_per_day" id="price_per_day" placeholder="Price Per Day" aria-label="PRICE PER DAY" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-12 mb-3">
                                <div class="form-group">
                                    <label class="label">Vehicle Type</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="vehicle_type" id="vehicle_type" placeholder="Vehicle Type" aria-label="VEHICLE TYPE" readonly>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-12 mb-3">
                        <div class="text-center">
                            <img id="vehicleImage" src='${pageContext.request.contextPath}/assets/images/carPH.jpg' width="80%" alt="Vehicle Image">
                        </div>
                    </div>
                </div>
            </div>
            <hr/>
            <p>Available Driver</p>
             <div class="container-fluid">
                 <div class="row">
                     <div class="col-md-3 col-sm-12 mb-3">
                         <div class="form-group">
                             <label class="label">Customer Id</label>
                             <div class="input-group">
                                 <input type="text" class="form-control" name="user_id" id="user_id" placeholder="Customer" aria-label="Customer ID" readonly>
                                 <button class="btn btn-outline-primary" type="button" id="customerLookup"><i class="fa-solid fa-magnifying-glass"></i></button>
                             </div>
                         </div>
                     </div>
                     <div class="col-md-3 col-sm-12 mb-3">
                         <div class="form-group">
                             <label class="label">Full Name</label>
                             <div class="input-group">
                                 <input type="text" class="form-control" name="full_name" id="full_name" placeholder="Full Name" aria-label="Full Name" readonly>
                             </div>
                         </div>
                     </div>
                     <div class="col-md-3 col-sm-12 mb-3">
                         <div class="form-group">
                             <label class="label">NIC</label>
                             <div class="input-group">
                                 <input type="text" class="form-control" name="nic" id="nic" placeholder="NIC" aria-label="NIC" readonly>
                             </div>
                         </div>
                     </div>
                     <div class="col-md-3 col-sm-12 mb-3">
                         <div class="form-group">
                             <label class="label">Email</label>
                             <div class="input-group">
                                 <input type="email" class="form-control" name="email" id="email" placeholder="Email" aria-label="EMAIL" readonly>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
            <div class="modal fade" id="customerSearchModal" tabindex="-1" aria-labelledby="customerSearchModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="customerSearchModalLabel">Search Customers</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Search input field -->
                            <input type="text" class="form-control" id="searchCustomerInput" placeholder="Enter customer name, NIC, or email">
                            <!-- Table to display customer list -->
                            <table id="customerLookupTbl" class="table mt-3">
                                <thead>
                                    <tr>
                                        <th>Customer ID</th>
                                        <th>First Name</th>
                                        <th>Last Name</th>
                                        <th>NIC</th>
                                        <th>Email</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <!-- Message for no records found -->
                            <div id="noRecordsMessage" class="alert alert-warning mt-3" style="display: none;">Customer not found</div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        <div class="modal fade" id="vehicleSearchModal" tabindex="-1" aria-labelledby="vehicleSearchModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="vehicleSearchModalLabel">Search Vehicles</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Search input field -->
                        <input type="text" class="form-control" id="searchVehicleInput" placeholder="Enter Vehicle Model, Type, or No of Seats">
                        <!-- Table to display vehicle list -->
                        <table id="vehicleLookupTbl" class="table mt-3">
                            <thead>
                                <tr>
                                    <th>Vehicle ID</th>
                                    <th>Model</th>
                                    <th>Type</th>
                                    <th>Registration No</th>
                                    <th>No of Seats</th>
                                    <th>Price per Day</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Rows will be populated here dynamically -->
                            </tbody>
                        </table>
                        <!-- Message for no records found -->
                        <div id="noRecordsMessage2" class="alert alert-warning mt-3" style="display: none;">Vehicle not found</div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>
    <!-- Form Buttons -->
    <div class="mt-5 d-flex justify-content-end gap-3">
        <button type="button" class="btn btn-outline-secondary">Cancel</button>
        <button type="submit" class="btn btn-primary">Create</button>
    </div>
</form>
</div>
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
<script>

function getPickupCoordinates() {
var pickUpLocation = $("#pickup_location").val();
const url = "https://nominatim.openstreetmap.org/search?q="+pickUpLocation+"+Lanka&format=json";
    fetch(url)
        .then(response => {
            if (!response.ok) {
                console.log("Network response was not ok");
            }
            return response.json();
        })
        .then(data => {
            const location = data[0];
            if (location) {
                const lat = location.lat;
                const lon = location.lon;
                $("#pickup_lat").val(lat);
                $("#pickup_lon").val(lon);
                console.log("Latitude: "+lat+"Longitude: "+lon);
            } else {
                console.log("Location not found.");
            }
        })
        .catch(error => {
            console.error("There was a problem with the fetch operation:", error);
        });
}
function getDestinationCoordinates() {
var destinationValue = $("#destination").val();
const url = "https://nominatim.openstreetmap.org/search?q="+destinationValue+"+Lanka&format=json";
    fetch(url)
        .then(response => {
            if (!response.ok) {
                console.log("Network response was not ok");
            }
            return response.json();
        })
        .then(data => {
            const location = data[0];
            if (location) {
                const lat = location.lat;
                const lon = location.lon;
                $("#destination_lat").val(lat);
                $("#destination_lon").val(lon);
                console.log("Latitude: "+lat+"Longitude: "+lon);
            } else {
                console.log("Location not found.");
            }
        })
        .catch(error => {
            console.error("There was a problem with the fetch operation:", error);
        });
}
  $(document).ready(function() {
      $('#customerLookup').click(function () {
          // Show the Bootstrap modal
          $('#customerSearchModal').modal('show');
      });
      const customers = <%= new Gson().toJson(request.getAttribute("customers")) %>;
          console.log(customers);

          // Show the modal when the lookup button is clicked
          $('#customerLookup').click(function () {
              $('#customerSearchModal').modal('show');
          });

          // Search functionality
          $('#searchCustomerInput').on('keyup', function () {
              const searchTerm = $(this).val().toLowerCase();
              const tableBody = $('#customerLookupTbl tbody');
              const noRecordsMessage = $('#noRecordsMessage');

              // Clear the table and hide the "no records" message
              tableBody.empty();
              noRecordsMessage.hide();

              if (searchTerm) {
                  // Filter customers based on the search term
                  const filteredCustomers = customers.filter(function (customer) {
                      return (
                          customer.firstName.toLowerCase().includes(searchTerm) ||
                          customer.nic.toLowerCase().includes(searchTerm) ||
                          customer.email.toLowerCase().includes(searchTerm)
                      );
                  });

                  // Display filtered customers in the table
                  if (filteredCustomers.length > 0) {
                      filteredCustomers.forEach(function (customer) {
                          const row = "<tr data-customer-id='" + customer.userId + "' data-customer-nic='" + customer.nic + "' data-customer-email='" + customer.email + "' data-customer-last-name='" + customer.lastName + "' data-customer-first-name='" + customer.firstName+ "'>" +
                              "<td>" + customer.userId + "</td>" +
                              "<td>" + customer.firstName + "</td>" +
                              "<td>" + customer.lastName + "</td>" +
                              "<td>" + customer.nic + "</td>" +
                              "<td>" + customer.email + "</td>" +
                              "</tr>";
                          tableBody.append(row);
                      });
                  } else {
                      // Show "Customer not found" message if no records match
                      noRecordsMessage.show();
                  }
              } else {
                  // Clear the table if the search term is empty
                  tableBody.empty();
              }
          });

          // click event to set customer name in the input field
          $('#customerLookupTbl tbody').on('click', 'tr', function () {
              const customerFirstName = $(this).data('customer-first-name');
              const customerLastName = $(this).data('customer-last-name');
              const userId = $(this).data('customer-id');
              const customerNic = $(this).data('customer-nic');
              const customerEmail = $(this).data('customer-email');

              // Set the customer name in the input field
              $('#user_id').val(userId);
              $('#full_name').val(customerFirstName+" "+customerLastName);
              $('#nic').val(customerNic);
              $('#email').val(customerEmail);

              // Close the modal
              $('#customerSearchModal').modal('hide');
          });

     $('#vehicleLookup').click(function () {
         // Show the Bootstrap modal
         $('#vehicleSearchModal').modal('show');
     });
     const vehicles = <%= new Gson().toJson(request.getAttribute("vehicles")) %>;
         console.log(vehicles); // Debug: Log vehicles data

         // Show the modal when the lookup button is clicked
         $('#vehicleLookup').click(function () {
             $('#vehicleSearchModal').modal('show');
         });

         // Search functionality
         $('#searchVehicleInput').on('keyup', function () {
             const searchTerm = $(this).val().toLowerCase();
             const tableBody = $('#vehicleLookupTbl tbody');
             const noRecordsMessage = $('#noRecordsMessage2');

             // Clear the table and hide the "no records" message
             tableBody.empty();
             noRecordsMessage.hide();

             if (searchTerm) {
                 // Filter vehicles based on the search term
                 const filteredVehicles = vehicles.filter(function (vehicle) {
                     return (
                         (vehicle.model && vehicle.model.toLowerCase().includes(searchTerm)) ||
                         (vehicle.type && vehicle.type.toLowerCase().includes(searchTerm)) ||
                         (vehicle.noOfSeats && vehicle.noOfSeats.toString().toLowerCase().includes(searchTerm))
                     );
                 });

                 // Display filtered vehicles in the table
                 if (filteredVehicles.length > 0) {
                     filteredVehicles.forEach(function (vehicle) {
                         const row = "<tr data-vehicle-id='" + vehicle.vehicleId + "' data-vehicle-model='" +vehicle.model+ "' data-vehicle-current-meter-reading='" +vehicle.currentMeterReading+ "' data-vehicle-vin='" + vehicle.vin +"' data-vehicle-image='" + vehicle.imageName + "' data-vehicle-type='" + vehicle.vehicleType + "' data-vehicle-no-of-seats='" + vehicle.noOfSeats + "' data-vehicle-price-per-day='" + vehicle.pricePerDay + "' data-vehicle-registration-number='" + vehicle.registrationNumber + "'>" +
                             "<td>" + vehicle.vehicleId + "</td>" +
                             "<td>" + vehicle.model + "</td>" +
                             "<td>" + vehicle.vehicleType + "</td>" +
                             "<td>" + vehicle.registrationNumber + "</td>" +
                             "<td>" + vehicle.noOfSeats + "</td>" +
                             "<td>" + vehicle.pricePerDay + " LKR</td>" +
                             "</tr>";
                         tableBody.append(row);
                     });
                 } else {
                     // Show "Vehicle not found" message if no records match
                     noRecordsMessage.show();
                 }
             } else {
                 // Clear the table if the search term is empty
                 tableBody.empty();
             }
         });

         // Click event to set vehicle details in the input fields
         $('#vehicleLookupTbl tbody').on('click', 'tr', function () {
             const vehicleId = $(this).data('vehicle-id');
             const model = $(this).data('vehicle-model');
             const type = $(this).data('vehicle-type');
             const vin = $(this).data('vehicle-vin');
             const currentMeterReading = $(this).data('vehicle-current-meter-reading');
             const registrationNumber = $(this).data('vehicle-registration-number');
             const noOfSeats = $(this).data('vehicle-no-of-seats');
             const pricePerDay = $(this).data('vehicle-price-per-day');
             const imageUrl = $(this).data('vehicle-image');

             // Set the vehicle details in the input fields
             $('#vehicle_id').val(vehicleId);
             $('#vin').val(vin);
             $('#model').val(model);
             $('#vehicle_type').val(type);
             $('#registration_number').val(registrationNumber);
             $('#no_of_seats').val(noOfSeats);
             $('#price_per_day').val(pricePerDay);
             $('#current_meter_reading').val(currentMeterReading);
             if (imageUrl) {
                 $('#vehicleImage').attr('src', '${pageContext.request.contextPath}/assets/images/'+imageUrl);
             } else {
                 $('#vehicleImage').attr('src', '${pageContext.request.contextPath}/assets/images/carPH.png');
             }

             // Close the modal
             $('#vehicleSearchModal').modal('hide');
         });

        $('#is_license_verified_value').change(function () {
            const isChecked = $(this).is(':checked');
            $('#is_license_verified').val(isChecked ? 'Y' : 'N');
        });
        $('#is_utility_bill_verified_value').change(function () {
            const isChecked = $(this).is(':checked');
            $('#is_utility_bill_verified').val(isChecked ? 'Y' : 'N');
        });

    // Form submission
    $("form").on("submit", function(e) {
      e.preventDefault();
      getPickupCoordinates();
      getDestinationCoordinates();

      var isValid = true;
      var errorMessage = "";

      var userId = $("#user_id").val();
      if(userId === ""){
          errorMessage += "Select a customer";
          isValid = false;
      }
      var userId = $("#vehicle_id").val();
      if(userId === ""){
          errorMessage += "Select a Vehicle";
          isValid = false;
      }
      const startDate = $('#start_date').val();
      const endDate = $('#end_date').val();

      var date = $('#datePicker').val();
      var time = $('#timePicker').val();
      if(date === ""){
          errorMessage += "Select Pickup Date";
          isValid = false;
      }
      if(date === ""){
          errorMessage += "Select Pickup Time";
          isValid = false;
      }
      if (date && time) {
          var datetime = date + ' ' + time;
          $('#pickup_dttm').val(datetime);
          console.log('Combined DateTime:', datetime);
      }

      function validationMessage(errorMessage)
      {
          Toastify({
                     text: errorMessage,
                     duration: 3000,
                     close: true,
                     gravity: "top",
                     position: "center",
                     backgroundColor: "red",
                 }).showToast();
         return;
      }
      if(!isValid){
        validationMessage(errorMessage);
      }
      // If all fields are valid, submit form data via AJAX
      if(isValid){
          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/admin?action=bookings/add",
            data: $(this).serialize(),
            success: function(response) {
              console.log(response);
              if(response.isSuccess){
                $("#newCustomerForm")[0].reset();
                Toastify({
                     text: response.message,
                     duration: 3000,
                     close: true,
                     gravity: "top",
                     position: "center",
                     backgroundColor: "green",
                 }).showToast();
              }else{
                 Toastify({
                     text: response.message,
                     duration: 3000,
                     close: true,
                     gravity: "top",
                     position: "center",
                     backgroundColor: "red",
                 }).showToast();
              }

              // You can handle a successful response here
            },
            error: function(xhr, status, error) {
              Toastify({
                  text: "There was an error submitting the form!",
                  duration: 3000,
                  close: true,
                  gravity: "top",
                  position: "center",
                  backgroundColor: "green",
              }).showToast();
            }
          });
      }
    });
  });
</script>
</body>
</html>