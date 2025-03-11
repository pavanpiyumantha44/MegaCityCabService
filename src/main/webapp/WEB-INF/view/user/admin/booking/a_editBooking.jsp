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
#map {
    height: 500px;
    width: 100%;
}
</style>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Edit Booking <span id="displayBookingId"></span></li>
  </ol>
</nav>
<form id="updateBookingForm">

    <div class="mt-5">
        <div class="border-bottom pb-4">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="label">Customer Id</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="customer_id" id="customer_id" placeholder="Customer" aria-label="Customer ID" readonly>
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
                                    <label class="label">Price Per KM</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" name="price_per_km" id="price_per_km" placeholder="Price Per Day" aria-label="PRICE PER KM" readonly>
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
                             <label class="label">Driver Id</label>
                             <div class="input-group">
                                 <input type="text" class="form-control" name="driver_id" id="driver_id" placeholder="Driver" aria-label="Driver ID" readonly>
                                 <button class="btn btn-outline-primary" type="button" id="driverLookup"><i class="fa-solid fa-magnifying-glass"></i></button>
                             </div>
                         </div>
                     </div>
                     <div class="col-md-3 col-sm-12 mb-3">
                         <div class="form-group">
                             <label class="label">Full Name</label>
                             <div class="input-group">
                                 <input type="text" class="form-control" name="driver_full_name" id="driver_full_name" placeholder="Full Name" aria-label="Full Name" readonly>
                             </div>
                         </div>
                     </div>
                     <div class="col-md-3 col-sm-12 mb-3">
                         <div class="form-group">
                             <label class="label">NIC</label>
                             <div class="input-group">
                                 <input type="text" class="form-control" name="driver_nic" id="driver_nic" placeholder="NIC" aria-label="NIC" readonly>
                             </div>
                         </div>
                     </div>
                     <div class="col-md-3 col-sm-12 mb-3">
                         <div class="form-group">
                             <label class="label">Phone</label>
                             <div class="input-group">
                                 <input type="text" class="form-control" name="driver_phone" id="driver_phone" placeholder="Phone" aria-label="PHONE" readonly>
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
                                <input type="date" class="form-control" id="pickup_date" name="pickup_date" placeholder="Select Pickup Date" aria-label="DATE" required>
                                <span class="input-group-text text-success"><i class="fa-solid fa-calendar-days"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="form-group">
                            <label class="form-label">Select Pickup Time</label>
                            <div class="input-group time">
                                <input type="time" class="form-control" id="pickup_time" name="pickup_time" placeholder="Select Pickup Time" aria-label="DATETIME" required>
                                 <span class="input-group-text text-success"><i class="fa-solid fa-clock"></i></span>
                            </div>
                        </div>
                        <input type="hidden" id="pickup_dttm" name="pickup_dttm" value=""/>
                        <input type="hidden" id="base_fare" name="base_fare" value=""/>
                    </div>
                    <div class="col-md-12 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="form-label">Special Notes</label>
                            <div class="input-group time">
                                <textarea name="special_note" id="special_note" rows="3" class="form-control" placeholder="Enter Special Notes"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row my-3">
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class=form_group>
                                <label for="status" class="form-label fw-medium">Booking Status</label>
                                <select id="status" name="status" class="form-select">
                                    <option value="pending">Pending</option>
                                    <option value="assigned">Assigned</option>
                                    <option value="closed">Closed</option>
                                </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="form-group">
                            <label class="form-label">Estimated Distance (KM)</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="distance_km" name="distance_km" placeholder="Distance km" readonly/>
                                 <span class="input-group-text text-warning"><i class="fa-solid fa-map-location-dot"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="form-group">
                            <label class="form-label">Estimate Time Duration (Min)</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="duration" name="duration" placeholder="Estimate Time" readonly/>
                                 <span class="input-group-text text-warning"><i class="fa-solid fa-clock"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3 d-flex justify-content-center align-items-center">
                        <div class="form-group pt-3">
                          <button type="button" class="btn btn-secondary" onclick="showRoute()">Show Route</button>
                        </div>
                    </div>
                    <div class="col-12">
                       <div id="map"></div>
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
    <div class="modal fade" id="driverSearchModal" tabindex="-1" aria-labelledby="customerSearchModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="driverSearchModalLabel">Search Customers</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Search input field -->
                    <input type="text" class="form-control" id="searchDriverInput" placeholder="Enter driver id, name,or NIC">
                    <!-- Table to display customer list -->
                    <table id="driverLookupTbl" class="table mt-3">
                        <thead>
                            <tr>
                                <th>Driver ID</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>NIC</th>
                                <th>Phone</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <!-- Message for no records found -->
                    <div id="noRecordsMessage" class="alert alert-warning mt-3" style="display: none;">Driver not found</div>
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
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
<script src="${pageContext.request.contextPath}/assets/js/location.js"></script>
<script>
$(document).ready(function() {
      const booking = <%= new Gson().toJson(request.getAttribute("booking")) %>;
      const customer = <%= new Gson().toJson(request.getAttribute("customer")) %>;
      const driver = <%= new Gson().toJson(request.getAttribute("driver")) %>;
      const vehicle = <%= new Gson().toJson(request.getAttribute("vehicle")) %>;
          console.log(booking);
          console.log(customer);
          console.log(driver);
          console.log(vehicle);
          //set customer details
          $("#customer_id").val(customer.customerId);
          $("#full_name").val(customer.firstName+" "+customer.lastName);
          $("#nic").val(customer.nic);
          $("#email").val(customer.email);
          //set ride details
          $("#pickup_location").val(booking.pickupLocation);
          $("#destination").val(booking.destination);
          $("#pickup_lat").val(booking.pickupLat);
          $("#pickup_lon").val(booking.pickupLon);
          $("#destination_lat").val(booking.destinationLat);
          $("#destination_lon").val(booking.destinationLon);
          $("#status").val(booking.status);
          const dateTimeString = booking.pickupDateTime;
          const [date, time] = dateTimeString.split(" ");
          $("#pickup_date").val(date);
          $("#pickup_time").val(time);
          $("#special_note").val(booking.specialNote);
          //set vehicle details
          $("#vehicle_id").val(vehicle.vehicle_id);
          $("#vin").val(vehicle.vin);
          $("#registration_number").val(vehicle.registrationNumber);
          $("#model").val(vehicle.model);
          $("#no_of_seats").val(vehicle.noOfSeats);
          $("#price_per_km").val(vehicle.pricePerKm);
          $("#vehicle_type").val(vehicle.vehicleType);
          $('#vehicleImage').attr('src', '${pageContext.request.contextPath}/assets/images/'+vehicle.imageName);
          //set driver details
          $("#driver_id").val(driver.driverId);
          $("#driver_full_name").val(driver.firstName+" "+driver.lastName);
          $("#driver_nic").val(driver.nic);
          $("#driver_phone").val(driver.phone);
          $("displayBookingId").append(booking.bookingId);

          $('#customerLookup').click(function () {
              $('#customerSearchModal').modal('show');
          });

          // Search functionality
          $('#searchCustomerInput').on('keyup', function () {
              const searchTerm = $(this).val().toLowerCase();
              const tableBody = $('#customerLookupTbl tbody');
              const noRecordsMessage = $('#noRecordsMessage');

              tableBody.empty();
              noRecordsMessage.hide();

              if (searchTerm) {
                  const filteredCustomers = customers.filter(function (customer) {
                      return (
                          customer.firstName.toLowerCase().includes(searchTerm) ||
                          customer.nic.toLowerCase().includes(searchTerm) ||
                          customer.email.toLowerCase().includes(searchTerm)
                      );
                  });

                  if (filteredCustomers.length > 0) {
                      filteredCustomers.forEach(function (customer) {
                          const row = "<tr data-customer-id='" + customer.customerId + "' data-customer-nic='" + customer.nic + "' data-customer-email='" + customer.email + "' data-customer-last-name='" + customer.lastName + "' data-customer-first-name='" + customer.firstName+ "'>" +
                              "<td>" + customer.customerId + "</td>" +
                              "<td>" + customer.firstName + "</td>" +
                              "<td>" + customer.lastName + "</td>" +
                              "<td>" + customer.nic + "</td>" +
                              "<td>" + customer.email + "</td>" +
                              "</tr>";
                          tableBody.append(row);
                      });
                  } else {
                      noRecordsMessage.show();
                  }
              } else {
                  tableBody.empty();
              }
          });

          $('#customerLookupTbl tbody').on('click', 'tr', function () {
              const customerFirstName = $(this).data('customer-first-name');
              const customerLastName = $(this).data('customer-last-name');
              const customerId = $(this).data('customer-id');
              const customerNic = $(this).data('customer-nic');
              const customerEmail = $(this).data('customer-email');

              // Set the customer name in the input field
              $('#customer_id').val(customerId);
              $('#full_name').val(customerFirstName+" "+customerLastName);
              $('#nic').val(customerNic);
              $('#email').val(customerEmail);

              // Close the modal
              $('#customerSearchModal').modal('hide');
          });

      const drivers = <%= new Gson().toJson(request.getAttribute("drivers")) %>;
       console.log(drivers);

       $('#driverLookup').click(function () {
           $('#driverSearchModal').modal('show');
       });

       $('#searchDriverInput').on('keyup', function () {
           const searchTerm = $(this).val().toLowerCase();
           const tableBody = $('#driverLookupTbl tbody');
           const noRecordsMessage = $('#noRecordsMessage');

           tableBody.empty();
           noRecordsMessage.hide();

           if (searchTerm) {
               const filteredDrivers = drivers.filter(function (driver) {
                   return (
                       driver.firstName.toLowerCase().includes(searchTerm) ||
                       driver.nic.toLowerCase().includes(searchTerm) ||
                       driver.email.toLowerCase().includes(searchTerm)
                   );
               });

               if (filteredDrivers.length > 0) {
                   filteredDrivers.forEach(function (driver) {
                       const row = "<tr data-driver-id='" + driver.driverId + "' data-driver-nic='" + driver.nic + "' data-driver-phone='" + driver.phone + "' data-driver-last-name='" + driver.lastName + "' data-driver-first-name='" + driver.firstName+ "'>" +
                           "<td>" + driver.driverId + "</td>" +
                           "<td>" + driver.firstName + "</td>" +
                           "<td>" + driver.lastName + "</td>" +
                           "<td>" + driver.nic + "</td>" +
                           "<td>" + driver.phone + "</td>" +
                           "</tr>";
                       tableBody.append(row);
                   });
               } else {
                   noRecordsMessage.show();
               }
           } else {
               tableBody.empty();
           }
       });

       $('#driverLookupTbl tbody').on('click', 'tr', function () {
           const driverFirstName = $(this).data('driver-first-name');
           const driverLastName = $(this).data('driver-last-name');
           const driverId = $(this).data('driver-id');
           const driverNic = $(this).data('driver-nic');
           const driverPhone = $(this).data('driver-phone');

           // Set the customer name in the input field
           $('#driver_id').val(driverId);
           $('#driver_full_name').val(driverFirstName+" "+driverLastName);
           $('#driver_nic').val(driverNic);
           $('#driver_phone').val(driverPhone);

           // Close the modal
           $('#driverSearchModal').modal('hide');
       });

     $('#vehicleLookup').click(function () {
         $('#vehicleSearchModal').modal('show');
     });
     const vehicles = <%= new Gson().toJson(request.getAttribute("vehicles")) %>;
         console.log(vehicles); //

         $('#vehicleLookup').click(function () {
             $('#vehicleSearchModal').modal('show');
         });

         $('#searchVehicleInput').on('keyup', function () {
             const searchTerm = $(this).val().toLowerCase();
             const tableBody = $('#vehicleLookupTbl tbody');
             const noRecordsMessage = $('#noRecordsMessage2');

             tableBody.empty();
             noRecordsMessage.hide();

             if (searchTerm) {
                 const filteredVehicles = vehicles.filter(function (vehicle) {
                     return (
                         (vehicle.model && vehicle.model.toLowerCase().includes(searchTerm)) ||
                         (vehicle.type && vehicle.type.toLowerCase().includes(searchTerm)) ||
                         (vehicle.noOfSeats && vehicle.noOfSeats.toString().toLowerCase().includes(searchTerm))
                     );
                 });

                 if (filteredVehicles.length > 0) {
                     filteredVehicles.forEach(function (vehicle) {
                         const row = "<tr data-vehicle-id='" + vehicle.vehicleId + "' data-vehicle-base-fare='" + vehicle.baseFare + "' data-vehicle-model='" +vehicle.model+ "' data-vehicle-current-meter-reading='" +vehicle.currentMeterReading+ "' data-vehicle-vin='" + vehicle.vin +"' data-vehicle-image='" + vehicle.imageName + "' data-vehicle-type='" + vehicle.vehicleType + "' data-vehicle-no-of-seats='" + vehicle.noOfSeats + "' data-vehicle-price-per-km='" + vehicle.pricePerKm + "' data-vehicle-registration-number='" + vehicle.registrationNumber + "'>" +
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
                     noRecordsMessage.show();
                 }
             } else {
                 tableBody.empty();
             }
         });

         $('#vehicleLookupTbl tbody').on('click', 'tr', function () {
             const vehicleId = $(this).data('vehicle-id');
             const model = $(this).data('vehicle-model');
             const type = $(this).data('vehicle-type');
             const vin = $(this).data('vehicle-vin');
             const currentMeterReading = $(this).data('vehicle-current-meter-reading');
             const registrationNumber = $(this).data('vehicle-registration-number');
             const noOfSeats = $(this).data('vehicle-no-of-seats');
             const pricePerKm = $(this).data('vehicle-price-per-km');
             const baseFare = $(this).data('vehicle-base-fare');
             const imageUrl = $(this).data('vehicle-image');

             $('#vehicle_id').val(vehicleId);
             $('#vin').val(vin);
             $('#model').val(model);
             $('#vehicle_type').val(type);
             $('#registration_number').val(registrationNumber);
             $('#no_of_seats').val(noOfSeats);
             $('#price_per_km').val(pricePerKm);
             $('#base_fare').val(baseFare);
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

      var isValid = true;
      var errorMessage = "";

      var userId = $("#customer_id").val();
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

      var date = $('#pickup_date').val();
      var time = $('#pickup_time').val();
      if(date === ""){
          errorMessage = "Select Pickup Date";
          isValid = false;
      }
      if(date === ""){
          errorMessage = "Select Pickup Time";
          isValid = false;
      }
      if (date !=="" && time !=="") {
          console.log(date+" "+time);
          var datetime = date + " " + time;
          $("#pickup_dttm").val(datetime);
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
            url: "${pageContext.request.contextPath}/booking?action=update",
            data: $(this).serialize(),
            success: function(response) {
              console.log(response);
              if(response.isSuccess){
                $("#updateBookingForm")[0].reset();
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