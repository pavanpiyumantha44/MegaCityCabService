<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="./assets/homepage/signup.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>MegaCity Cabs - Sign Up</title>
    <style>
        .hidden{
            display:none;
        }
        .errMessage{
          padding:8px;
          background-color:tomato;
          color:white;
          border-radius:5px;
          margin-bottom:10px;
        }
    </style>
  </head>
  <body>
    <header>
      <nav>
        <div class="nav__header">
          <div class="nav__logo">
            <a href="index.jsp"><span style="color: #c49403;">MegaCity</span> Cabs</a>
          </div>
          <div class="nav__menu__btn" id="menu-btn">
            <i class="ri-menu-line"></i>
          </div>
        </div>
        <ul class="nav__links" id="nav-links">
          <li><a href="#home">Home</a></li>
          <li><a href="#rent">Rent</a></li>
          <li><a href="#service">Services</a></li>
          <li><a href="#ride">Ride</a></li>
          <li><a href="#contact">Contact</a></li>
          <li class="nav__links__btn">
            <button class="btn">Sign Up</button>
          </li>
          <li class="nav__links__btn">
            <button class="btn">Sign In</button>
          </li>
        </ul>
        <div class="nav__btns">
          <button class="btn btn__primary"><a href="signup.jsp" style="text-decoration:none;">Sign Up</a></button>
          <button class="btn btn__secondary"><a href="login.jsp" style="color:white; text-decoration:none;">Sign In</a></button>
        </div>
      </nav>
    </header>
    <section class="login_section_container login_container">
      <div class="login_image">
        <img src="./assets/images/login.png" alt="loginImg"/>
      </div>
      <div class="form">
              <form class="signup-form" id="signupForm">
                <h2>Sign Up</h2>
                <div class="errMessage hidden" id="errorMsg"></div>
                <!-- Grid Layout for Form Fields -->
                <div class="form-grid">
                  <!-- Row 1: First Name and Last Name -->
                  <div class="form-group">
                    <label for="first_name">First Name</label>
                    <input type="text" id="first_name" name="first_name" placeholder="Enter your first name" required>
                  </div>
                  <div class="form-group">
                    <label for="last_name">Last Name</label>
                    <input type="text" id="last_name" name="last_name" placeholder="Enter your last name" required>
                  </div>

                  <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required>
                  </div>
                  <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="Enter your phone number" required>
                  </div>

                  <div class="form-group">
                      <label for="nic">NIC</label>
                      <input type="text" id="nic" name="nic" placeholder="Enter your NIC" required>
                    </div>
                    <div class="form-group">
                      <label for="gender">Gender</label>
                      <select id="gender" name="gender" required>
                        <option value="" disabled selected>Select your gender</option>
                        <option value="M">Male</option>
                        <option value="F">Female</option>
                      </select>
                    </div>
                  <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" minlength="6" required>
                  </div>
                  <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="c_password" name="c_password" placeholder="Confirm your password" minlength="6" required>
                  </div>
                  <div class="form-group full-width">
                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" placeholder="Enter your address" required>
                  </div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="signup-button">Sign Up</button>

                <!-- Login Link -->
                <p class="login-link">Already have an account? <a href="#">Sign In</a></p>
              </form>
            </div>
    </section>
    <footer class="footer">
      <div class="section__container footer__container">
        <div class="footer__col">
          <h4>Our Vehicle Fleet</h4>
          <ul class="footer__links">
            <li><a href="#">Suzuki Alto</a></li>
            <li><a href="#">Suzuki WagonR</a></li>
            <li><a href="#">Toyota Aqua</a></li>
            <li><a href="#">Toyota Vitz</a></li>
            <li><a href="#">Toyota Prius</a></li>
            <li><a href="#">Toyota KDH</a></li>
          </ul>
        </div>
        <div class="footer__col">
          <h4>About MegaCity</h4>
          <ul class="footer__links">
            <li><a href="#">Why MegaCity</a></li>
            <li><a href="#">Our Story</a></li>
            <li><a href="#">Investors</a></li>
            <li><a href="#">Press Centers</a></li>
            <li><a href="#">Advertise</a></li>
          </ul>
        </div>
        <div class="footer__col">
          <h4>Resources</h4>
          <ul class="footer__links">
            <li><a href="#">Download</a></li>
            <li><a href="#">Help Centers</a></li>
            <li><a href="#">Guides</a></li>
            <li><a href="#">Partner Network</a></li>
            <li><a href="#">Mechanics</a></li>
          </ul>
        </div>
        <div class="footer__col">
          <h4>Extras</h4>
          <ul class="footer__links">
            <li><a href="#">Rental Deal</a></li>
            <li><a href="#">Repair Shop</a></li>
            <li><a href="#">View Booking</a></li>
            <li><a href="#">Hire Companies</a></li>
            <li><a href="#">New Offers</a></li>
          </ul>
        </div>
      </div>
      <div class="section__container footer__bar">
        <h4><span style="color: #c49403;">MegaCity</span> Cabs</h4>
        <p>Copyright © 2025 MegaCity Cabs. All rights reserved.</p>
        <ul class="footer__socials">
          <li>
            <a href="#"><i class="ri-facebook-fill"></i></a>
          </li>
          <li>
            <a href="#"><i class="ri-twitter-fill"></i></a>
          </li>
          <li>
            <a href="#"><i class="ri-google-fill"></i></a>
          </li>
        </ul>
      </div>
    </footer>
<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
    <script>
      $(document).ready(function() {
        // Form submission
        $("form").on("submit", function(e) {
          e.preventDefault();

          var isValid = true;
          var errorMessage = "";

          // Validate Email
          var email = $("#email").val();
          var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
          if(email === "") {
            showError("Email is required");
            isValid = false;
          } else if (!emailPattern.test(email)) {
            showError("Please enter a valid email address");
            isValid = false;
          }
        var nic = $("#nic").val();
        var nicPattern = /^([0-9]{9}[xXvV]|[0-9]{12})$/;
        if (nic === "") {
          showError("Enter NIC");
          isValid = false;
        } else if (!nicPattern.test(nic)) {
          showError("Invalid NIC");
          isValid = false;
        }

          var firstName = $("#first_name").val();
          if(firstName === ""){
            showError("Enter First Name");
            isValid = false;
          }
          var lastName = $("#last_name").val();
          if(lastName === ""){
            showError("Enter Last Name");
            isValid = false;
          }
          var address = $("#address").val();
          if(address === ""){
            showError("Enter Address");
            isValid = false;
          }
          // Validate password
          var password = $("#password").val();
          if(password === "") {
            showError("Password is Required!");
            isValid=false;
          }
          var cPassword = $('#c_password').val();
          if(password !== cPassword){
            showError("Password and Confirm Password are not matching");
            isValid=false;
          }

           function showError(message) {
             $('#errorMsg').removeClass('hidden');
             $('#errorMsg').empty();
             $('#errorMsg').append('<p>' + message + '</p>');
           }

          // If all fields are valid, submit form data via AJAX
          if(isValid){
              $.ajax({
                type: "POST",
                url: "auth?action=register",
                data: $(this).serialize(),
                success: function(response) {
                  console.log(response);
                  if(response.isSuccess){

                    setTimeout(() => {
                        window.location = '<%= request.getContextPath() %>/login.jsp';
                    }, 2000);
                  }else{
                     showError(response.message);
                  }
                },
                error: function(xhr, status, error) {
                  showError("Something went wrong");
                }
              });
          }
        });
      });
    </script>
    <script src="https://unpkg.com/scrollreveal"></script>
    <script src="./assets/homepage/main.js"></script>
  </body>
</html>
