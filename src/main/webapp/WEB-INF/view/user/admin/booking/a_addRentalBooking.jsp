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
    <li class="breadcrumb-item active" aria-current="page">New Rental Booking</li>
  </ol>
</nav>
<form id="newRentalBookingForm">

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
             <p>Booking Info</p>
             <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="form-label">Start Date</label>
                            <div class="input-group">
                                <input type="date" class="form-control" name="start_date" id="start_date" aria-label="START DATE"value="<%= java.time.LocalDate.now() %>" min="<%= java.time.LocalDate.now() %>" required>
                                <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="form-label">End Date</label>
                            <div class="input-group">
                                <input type="date" class="form-control" name="end_date" id="end_date" aria-label="END DATE" value="<%= java.time.LocalDate.now() %>" min="<%= java.time.LocalDate.now() %>" required>
                                <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                            </div>
                        </div>
                    </div>
                     <div class="col-md-3 col-sm-6 mb-3">
                         <div class="form-group">
                             <label class="form-label">Verify License</label>
                             <div class="form-check">
                                 <input type="checkbox" class="form-check-input" name="is_license_verified_value" id="is_license_verified_value" aria-label="License Verified">
                                 <input type="hidden" name="is_license_verified" id="is_license_verified" value="N">
                                 <label class="form-check-label" for="is_license_verified">License Verified</label>
                             </div>
                         </div>
                     </div>
                     <div class="col-md-3 col-sm-6 mb-3">
                         <div class="form-group">
                             <label class="form-label">Utility Bill</label>
                             <div class="form-check">
                                 <input type="checkbox" class="form-check-input" name="is_utility_bill_verified_value" id="is_utility_bill_verified_value" aria-label="Utility Bill Verified">
                                 <input type="hidden" name="is_utility_bill_verified" id="is_utility_bill_verified" value="N">
                                 <input type="hidden" name="no_of_days" id="no_of_days" value="1">
                                 <input type="hidden" name="total_price" id="total_price">
                                 <label class="form-check-label" for="is_utility_bill_verified">Utility Bill Verified</label>
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
      e.preventDefault(); // Prevent form submission to handle via AJAX

      // Initialize a flag for validation success
      var isValid = true;
      var errorMessage = "";  // Initialize a variable to accumulate error messages

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

      if (startDate && endDate) {
          const start = new Date(startDate);
          const end = new Date(endDate);

            if (end < start) {
                errorMessage = "Invalid End Date"; // Show error message
                isValid = false; // Validation failed
            }else {
                const timeDifference = end - start; // Difference in milliseconds
                const dayDifference = Math.ceil(timeDifference / (1000 * 60 * 60 * 24)); // Convert to days
                dayDifference === 0 ? $('#no_of_days').val(1) : $('#no_of_days').val(dayDifference);
            }
      }
      var noOfDays = $("#no_of_days").val();
      var DayPrice = $("#price_per_day").val();
      var total = (noOfDays*DayPrice);
      $("#total_price").val(total);

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