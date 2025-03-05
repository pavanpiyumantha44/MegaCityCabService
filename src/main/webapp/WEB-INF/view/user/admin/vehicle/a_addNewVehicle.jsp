<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">New Vehicle</li>
  </ol>
</nav>
<form id="newVehicleForm" enctype="multipart/form-data">
    <input type="hidden" name="action" value="add" />

    <div class="mt-5">
        <div class="border-bottom pb-4">
            <h2 class="h5 fw-semibold text-dark">Vehicle Information</h2>
            <p class="mt-1 text-muted small">Add a new vehicle to the system. Make sure to enter all the necessary details!</p>

            <div id="validation" class="mt-3"></div>

            <div class="mt-4 row g-3">
                <!-- VIN Number -->
                <div class="col-md-6">
                    <label for="vin" class="form-label fw-medium">VIN Number</label>
                    <input type="text" name="vin" id="vin" autocomplete="given-name" class="form-control" placeholder="Enter VIN Number" required>
                </div>

                <!-- Model -->
                <div class="col-md-6">
                    <label for="model" class="form-label fw-medium">Model</label>
                    <input type="text" name="model" id="model" autocomplete="family-name"
                        class="form-control" placeholder="Enter Model" required>
                </div>

                <!-- Make -->
                <div class="col-md-6">
                    <label for="make" class="form-label fw-medium">Make</label>
                    <input type="text" name="make" id="make" class="form-control" placeholder="Enter Make" required>
                </div>

                <!-- Year -->
                <div class="col-md-6">
                    <label for="year" class="form-label fw-medium">Year</label>
                    <input type="number" name="year" id="year" class="form-control" placeholder="Enter Year" required>
                </div>

                <!-- Registration Number -->
                <div class="col-md-6">
                    <label for="registration_number" class="form-label fw-medium">Registration Number</label>
                    <input type="text" name="registration_number" id="registration_number" autocomplete="registration_number"
                        class="form-control" placeholder="Enter Registration Number" required>
                </div>
                <!-- Vehicle Type -->
                <div class="col-md-6">
                    <label for="vehicle_type" class="form-label fw-medium">Vehicle Type</label>
                    <select id="vehicle_type" name="vehicle_type" class="form-select">
                        <option value="Car">Car</option>
                        <option value="Mini-Van">Mini-Van</option>
                        <option value="Van">Van</option>
                    </select>
                </div>
                <!-- No Of Seats -->
                <div class="col-md-6">
                    <label for="no_of_seats" class="form-label fw-medium">No Of Seats</label>
                    <input type="number" name="no_of_seats" id="no_of_seats" autocomplete="no_of_seats" min="4"
                        class="form-control" placeholder="Enter No Of Seats" required>
                </div>

                <!-- Current Meter Reading -->
               <div class="col-md-6">
                   <label for="current_meter_reading" class="form-label fw-medium">Current Meter Reading</label>
                   <input type="number" name="current_meter_reading" id="current_meter_reading" autocomplete="current_meter_reading" min="0"
                   class="form-control" placeholder="Enter Current Meter Reading" required>
               </div>
                <!-- Price Per Day -->
                <div class="col-md-6">
                    <label for="price_per_day" class="form-label fw-medium">Price Per Day</label>
                    <input type="number" name="price_per_day" id="price_per_day" autocomplete="price_per_day" min="0"
                    class="form-control" placeholder="Price Per Day" required>
                </div>
                 <!-- Price Per Km -->
                 <div class="col-md-6">
                     <label for="price_per_km" class="form-label fw-medium">Price Per ( KM )</label>
                     <input type="number" name="price_per_km" id="price_per_km" autocomplete="price_per_km" min="0"
                     class="form-control" placeholder="Price Per KM" required>
                 </div>
                  <!-- Price Per Extra Km -->
                  <div class="col-md-6">
                      <label for="price_per_extra_km" class="form-label fw-medium">Price Per Extra ( KM )</label>
                      <input type="number" name="price_per_extra_km" id="price_per_extra_km" autocomplete="price_per_extra_km" min="0"
                      class="form-control" placeholder="Price Per Extra KM" required>
                  </div>
                  <!-- Price Per Extra Km -->
                  <div class="col-md-6">
                      <label for="price_per_extra_hour" class="form-label fw-medium">Price Per Extra Hour</label>
                      <input type="number" name="price_per_extra_hour" id="price_per_extra_hour" autocomplete="price_per_extra_hour" min="0"
                      class="form-control" placeholder="Price Per Extra Hour" required>
                  </div>
                  <!-- Photo1 -->
                  <div class="col-md-6">
                      <label for="" class="form-label fw-medium">Photo I</label>
                      <input type="file" name="vehicle_images" id="vehicle_images" class="form-control" required multiple>
                  </div>
                <!-- Status -->
                <div class="col-md-6">
                    <label for="status" class="form-label fw-medium">Status</label>
                    <select id="status" name="status" class="form-select">
                        <option value="available">Available</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <!-- Form Buttons -->
    <div class="mt-5 d-flex justify-content-end gap-3">
        <button type="button" class="btn btn-outline-secondary">Cancel</button>
        <button type="submit" class="btn btn-primary">Save</button>
    </div>
</form>
</div>
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
<script>
  $(document).ready(function() {
    // Form submission
    $("form").on("submit", function(e) {
      e.preventDefault(); // Prevent form submission to handle via AJAX

      // Initialize a flag for validation success
      var isValid = true;

      // If all fields are valid, submit form data via AJAX
      if(isValid){
      var formData = new FormData(this);
      console.log(formData);
          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/admin?action=vehicles/add",
            data: "",
            success: function(response) {
              console.log(response);
              if(response.isSuccess){
                $("#newVehicleForm")[0].reset();
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
                  backgroundColor: "red",
              }).showToast();
            }
          });
      }
    });
  });
</script>
</body>
</html>