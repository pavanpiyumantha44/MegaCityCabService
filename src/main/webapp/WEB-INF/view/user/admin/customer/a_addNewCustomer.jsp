<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">New Customer</li>
  </ol>
</nav>
<form id="newCustomerForm">
    <input type="hidden" name="action" value="add" />
    <input type="hidden" name="user-type" value="customer" />
    <input type="hidden" name="role_id" value="4" />

    <div class="mt-5">
        <div class="border-bottom pb-4">
            <h2 class="h5 fw-semibold text-dark">Customer Information</h2>
            <p class="mt-1 text-muted small">Add a new user to the system. Make sure to enter all the necessary details!</p>

            <div id="validation" class="mt-3"></div>

            <div class="mt-4 row g-3">
                <!-- First Name -->
                <div class="col-md-6">
                    <label for="first_name" class="form-label fw-medium">First name</label>
                    <input type="text" name="first_name" id="first_name" autocomplete="given-name"
                        class="form-control" placeholder="Enter first name" required>
                </div>

                <!-- Last Name -->
                <div class="col-md-6">
                    <label for="last_name" class="form-label fw-medium">Last name</label>
                    <input type="text" name="last_name" id="last_name" autocomplete="family-name"
                        class="form-control" placeholder="Enter last name" required>
                </div>

                <!-- NIC -->
                <div class="col-md-6">
                    <label for="nic" class="form-label fw-medium">NIC</label>
                    <input type="text" name="nic" id="nic" class="form-control" placeholder="Enter NIC" required>
                </div>

                <!-- Phone -->
                <div class="col-md-6">
                    <label for="phone" class="form-label fw-medium">Phone</label>
                    <input type="text" name="phone" id="phone" class="form-control" placeholder="Enter phone number" required>
                </div>

                <!-- Email -->
                <div class="col-md-6">
                    <label for="email" class="form-label fw-medium">Email address</label>
                    <input type="email" name="email" id="email" autocomplete="email"
                        class="form-control" placeholder="Enter email address" required>
                </div>

                <!-- Password -->
                <div class="col-md-6">
                    <label for="password" class="form-label fw-medium">Password</label>
                    <input type="password" name="password" id="password" autocomplete="new-password"
                        class="form-control" placeholder="Enter password" required>
                </div>

                <!-- Gender -->
                <div class="col-md-6">
                    <label for="gender" class="form-label fw-medium">Gender</label>
                    <select id="gender" name="gender" class="form-select">
                        <option value="M">Male</option>
                        <option value="F">Female</option>
                    </select>
                </div>

                <!-- Membership Status -->
                <div class="col-md-6">
                    <label for="membership" class="form-label fw-medium">Membership Status</label>
                    <select id="membership" name="membership" class="form-select">
                        <option value="regular" selected>Regular</option>
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
      var errorMessage = "";  // Initialize a variable to accumulate error messages

      // Validate First Name
      var firstName = $("#first_name").val();
      if(firstName === "") {
         errorMessage += "First name is required.<br>";
        isValid=false;
      }

      // Validate Last Name
      var lastName = $("#last_name").val();
      if(lastName === "") {
        errorMessage += "Last name is required.";
        isValid=false;
      }

      // Validate NIC
      var nic = $("#nic").val();
      if(nic === "") {
        errorMessage += "NIC is required.<br>";

        isValid=false;
      }

      // Validate Phone
      var phone = $("#phone").val();
      if(phone === "") {
        errorMessage += "Phone number is required.<br>";

        isValid = false;
      }

      // Validate Email
      var email = $("#email").val();
      var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
      if(email === "") {
        errorMessage += "Email is required.<br>";

        isValid = false;
      } else if (!emailPattern.test(email)) {
        errorMessage += "Please enter a valid email address.<br>";

        isValid = false;
      }

      // Validate Password
      var password = $("#password").val();
      if(password === "") {
        errorMessage += "Password is required.<br>";
        isValid = false;
      }

      // If validation fails, display errors in the custom alert box
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
      validationMessage("Enter all the fields");
      }

      // If all fields are valid, submit form data via AJAX
      if(isValid){
          $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/admin?action=customers/add",
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