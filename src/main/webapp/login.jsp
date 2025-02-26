<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="stylesheet" href="./assets/homepage/login.css" />
    <title>MegaCity Cabs</title>
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
          <button class="btn btn__primary">Sign Up</button>
          <button class="btn btn__secondary">Sign In</button>
        </div>
      </nav>
    </header>
    <section class="login_section_container login_container">
      <div class="login_image">
        <img src="./assets/images/login.png" alt="loginImg"/>
      </div>
      <div class="form">
        <form action="auth?action=login" method="post" class="signin-form">
          <h2>Sign In</h2>
          <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>
          </div>
          <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" minlength="6" required>
          </div>
          <button type="submit" class="signin-button">Sign In</button>
          <p class="signup-link">Don't have an account? <a href="#">Sign Up</a></p>
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

    <script src="https://unpkg.com/scrollreveal"></script>
    <script src="./assets/homepage/main.js"></script>
  </body>
</html>
