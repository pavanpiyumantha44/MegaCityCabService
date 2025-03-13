<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/driver/header.jsp" %>
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
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/driver?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">BookingID : #1 <span id="displayBookingId"></span></li>
  </ol>
</nav>
<form id="updateBookingForm">
    <div class="mt-5">
        <div class="border-bottom pb-4">
         <p id="ride_info" class="" style="cursor:pointer;">Ride Info</p>
            <div class="container-fluid" id="info">
                <div class="row">
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="form-group">
                            <label class="label">Full Name</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="full_name" id="full_name" placeholder="Full Name" aria-label="Full Name" readonly>
                                <span class="input-group-text text-info"><i class="fa-regular fa-user"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="form-group">
                            <label class="label">Email</label>
                            <div class="input-group">
                                <input type="email" class="form-control" name="email" id="email" placeholder="Email" aria-label="EMAIL" readonly>
                                <span class="input-group-text text-primary"><i class="fa-solid fa-envelope"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-12 mb-3">
                       <div class="form-group">
                           <label class="label">Phone</label>
                           <div class="input-group">
                               <input type="text" class="form-control" name="customer_phone" id="customer_phone" placeholder="Customer" aria-label="Customer ID" readonly>
                               <span class="input-group-text text-success"><i class="fa-solid fa-phone"></i></span>
                           </div>
                       </div>
                   </div>
                   <div class="col-md-3 col-sm-12 mb-3">
                       <div class="form-group">
                           <label class="label">Special Note</label>
                           <div class="input-group">
                               <input type="text" class="form-control" name="special_note" id="special_note" rows="3" class="form-control" placeholder="Enter Special Notes" readonly>
                               <span class="input-group-text text-warning"><i class="fa-solid fa-note-sticky"></i></span>
                           </div>
                       </div>
                   </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-12 mb-3">
                        <div class="form-group">
                            <label class="form-label">Pickup Location</label>
                            <div class="input-group">
                                <input type="text" class="form-control" name="pickup_location" id="pickup_location" placeholder="pickup location" aria-label="PICKUP LOCATION"value="" readonly>
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
                                <input type="text" class="form-control" name="destination" id="destination" placeholder="Destination" aria-label="DESTINATION" readonly>
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
                                <input type="date" class="form-control" id="pickup_date" name="pickup_date" placeholder="Select Pickup Date" aria-label="DATE" readonly>
                                <span class="input-group-text text-success"><i class="fa-solid fa-calendar-days"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6 mb-3">
                        <div class="form-group">
                            <label class="form-label">Select Pickup Time</label>
                            <div class="input-group time">
                                <input type="time" class="form-control" id="pickup_time" name="pickup_time" placeholder="Select Pickup Time" aria-label="DATETIME" readonly>
                                 <span class="input-group-text text-success"><i class="fa-solid fa-clock"></i></span>
                            </div>
                        </div>
                        <input type="hidden" id="pickup_dttm" name="pickup_dttm" value=""/>
                        <input type="hidden" id="base_fare" name="base_fare" value=""/>
                        <input type="hidden" id="price_per_km" name="price_per_km" value=""/>
                        <input type="hidden" id="total_fare" name="total_fare" value=""/>
                    </div>
                </div>
                </div>
                <div class="container-fluid">
                    <div class="row my-3">
                        <div class="col-lg-12 col-md-12 col-sm-12 mb-3">
                            <div class="form_group">
                               <label for="status" class="form-label fw-medium">Ride Status</label>
                               <div class="d-flex">
                                   <select id="status" name="status" class="form-select w-75 me-3">
                                   </select>
                                   <button type="submit" class="btn btn-primary">Update</button>
                               </div>
                            </div>
                        </div>
                    </div>
                </div>
    </div>
    <div class="container-fluid">
      <div class="row my-3" id="route-section">
         <div class="col-md-3 col-sm-6 mb-3 d-flex justify-content-center align-items-center">
             <div class="form-group pt-3">
               <button type="button" class="btn btn-secondary" onclick="showRoute()">Show Route</button>
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
         <div class="col-12">
            <div id="map"></div>
         </div>
      </div>
      <div class="row my-3 hide" id="distance-section">
         <div class="col-md-3 col-sm-6 mb-3">
             <div class="form-group">
                 <label class="form-label">Start Meter Reading (KM)</label>
                 <div class="input-group">
                     <input type="text" class="form-control" id="start_meter_reading" name="start_meter_reading" placeholder="Start Meter Reading" readonly/>
                      <span class="input-group-text text-secondary"><i class="fa-solid fa-gauge"></i></span>
                 </div>
             </div>
         </div>
         <div class="col-md-3 col-sm-6 mb-3">
             <div class="form-group">
                 <label class="form-label">End Meter Reading (KM)</label>
                 <div class="input-group">
                     <input type="number" class="form-control" id="end_meter_reading" name="end_meter_reading" min="1" placeholder="End Meter Reading"/>
                      <span class="input-group-text text-primary"><i class="fa-solid fa-gauge-high"></i></span>
                 </div>
             </div>
         </div>
      </div>
      <div class="row my-3 hide" id="payment-section">
         <div class="col-md-12 col-sm-6 mb-3">
             <div class="form-group">
                 <label class="form-label">Payment Collected</label>
                 <div class="input-group">
                     <input type="checkbox" class="form-check-input" id="paid" name="paid" />
                     <label for="paid" class="form-check-label ms-2">Paid</label>
                 </div>
             </div>
         </div>
         <div class="col-md-12 col-sm-6 mb-3">
             <div class="bg-success p-5 rounded">
               <div class="row d-flex">
                <div class="col-md-3 col-sm-6 w-50 text-end">
                    <p class="text-white">Distance : </p>
                </div>
                <div class="col-md-3 col-sm-6 w-50 text-start">
                    <p class="text-white" id="distance-km" id="distance-km"></p>
                </div>
                <div class="col-md-3 col-sm-6 w-50 text-end">
                    <p class="text-white">Ride Completed Date Time : </p>
                </div>
                <div class="col-md-3 col-sm-6 w-50 text-start">
                    <p class="text-white" id="completed-dttm"></p>
                </div>
                <hr class="text-white"/>
                <div class="col-md-3 col-sm-6 w-50 text-end">
                    <p class="text-white fs-2">Total Price : </p>
                </div>
                <div class="col-md-3 col-sm-6 w-50 text-start">
                    <p class="text-white fs-2" id="total-price"></p>
                </div>
             </div>
         </div>
      </div>
    </div>
</form>
</div>
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
<script src="${pageContext.request.contextPath}/assets/js/location.js"></script>
<script>
$(document).ready(function() {
      const booking = <%= new Gson().toJson(request.getAttribute("booking")) %>;
      const customer = <%= new Gson().toJson(request.getAttribute("customer")) %>;

      $('#ride_info').click(function() {
          $('#info').toggleClass('hide');
      });
      rideStatusDropdown = $('#status');
      rideStatusDropdown.append('<option value="" disabled selected>Assigned</option>');
      rideStatusDropdown.append('<option value="ongoing">Ongoing</option>');

      function changeRideStatus(status){
         var statusDropdown = $('#status');

         if(status === "assigned"){
            statusDropdown.empty();
            statusDropdown.append('<option value="" selected disabled>Assigned</option>');
            statusDropdown.append('<option value="ongoing">Ongoing</option>');
         }
         if(status === "ongoing"){
            statusDropdown.empty();
            statusDropdown.append('<option value="" selected disabled>Ongoing</option>');
            statusDropdown.append('<option value="arrived">Arrived</option>');
         }
         if(status === "arrived"){
           $("#route-section").addClass("hide");
           $("#distance-section").removeClass("hide");
            statusDropdown.empty();
            statusDropdown.append('<option value="" selected disabled>Arrived</option>');
            statusDropdown.append('<option value="completed">Completed</option>');
         }
         if(status === "completed"){
           $("#route-section").addClass("hide");
           $("#distance-section").addClass("hide");
           $("#payment-section").removeClass("hide");
            statusDropdown.empty();
            statusDropdown.append('<option value="" selected disabled>Completed</option>');
            statusDropdown.append('<option value="closed">Closed</option>');
         }
         if(status === "closed"){
           $("#route-section").addClass("hide");
           $("#distance-section").addClass("hide");
           $("#payment-section").addClass("hide");
            statusDropdown.empty();
            statusDropdown.append('<option value="" selected disabled>Closed</option>');
         }
      }
      function setPaymentDetails(data){
        console.log(data);
        $("#distance-km").text(data.distanceKm+" KM");
        let currentDateTime = new Date().toLocaleString();
        $("#completed-dttm").text(currentDateTime);
        $("#total-price").text(data.totalPrice+" LKR");
      }
    console.log(booking);
    console.log(customer);
    //set customer details
    $("#customer_id").val(customer.customerId);
    $("#full_name").val(customer.firstName+" "+customer.lastName);
    $("#customer_phone").val(customer.phone);
    $("#email").val(customer.email);
    //set ride details
    $("#pickup_location").val(booking.pickupLocation);
    $("#destination").val(booking.destination);
    $("#pickup_lat").val(booking.pickupLat);
    $("#pickup_lon").val(booking.pickupLon);
    $("#destination_lat").val(booking.destinationLat);
    $("#destination_lon").val(booking.destinationLon);
    $("#status").val(booking.status);
    $("#start_meter_reading").val(booking.startMeterReading);
    const dateTimeString = booking.pickupDateTime;
    const [date, time] = dateTimeString.split(" ");
    $("#pickup_date").val(date);
    $("#pickup_time").val(time);
    $("#special_note").val(booking.specialNote);
    $("#price_per_km").val(booking.pricePerKm);
    $("#base_fare").val(booking.baseFare);


    // Form submission
    $("form").on("submit", function(e) {
      e.preventDefault();

      var isValid = true;
      var errorMessage = "";

      var userId = $("#customer_id").val();
      if(userId === ""){
          errorMessage = "Select a customer";
          isValid = false;
      }
      var userId = $("#vehicle_id").val();
      if(userId === ""){
          errorMessage = "Select a Vehicle";
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
      var status = $("#status").val();
      if(status === ""){
          errorMessage = "Invalid Ride Status";
          isValid = false;
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
      function closeRide(){
      $("#payment-section").addClass("hide");
        Toastify({
            text: "Ride has been completed!",
            duration: 3000,
            close: true,
            gravity: "top",
            position: "center",
            backgroundColor: "green",
        }).showToast();
        Toastify({
            text: "Your Payment has been updated!",
            duration: 3000,
            close: true,
            gravity: "top",
            position: "center",
            backgroundColor: "blue",
        }).showToast();
        setTimeout(() => {
            window.location = '<%= request.getContextPath() %>/driver?action=dashboard';
        }, 2000);
        return;
      }
      if(!isValid){
        validationMessage(errorMessage);
      }

      if(isValid){
          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/booking?action=update/driver&id="+booking.bookingId,
            data: $(this).serialize(),
            success: function(response) {
              console.log(response);
              if(response.isSuccess){
                Toastify({
                     text: response.message,
                     duration: 3000,
                     close: true,
                     gravity: "top",
                     position: "center",
                     backgroundColor: "green",
                 }).showToast();
                 if(response.data.status === "closed"){
                    closeRide();
                 }
                 changeRideStatus(response.data.status);
                 setPaymentDetails(response.data);
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