<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link
      href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="./assets/homepage/styles.css" />
    <title>MegaCity Cabs</title>
  </head>
  <body>
    <header>
      <nav>
        <div class="nav__header">
          <div class="nav__logo">
            <a href="#"><span style="color: #c49403;">MegaCity</span> Cabs</a>
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
           <button class="btn"><a href="login.jsp">Sign In</a></button>
          </li>
        </ul>
        <div class="nav__btns">
          <button class="btn btn__primary"><a href="signup.jsp" style="text-decoration:none;">Sign Up</a></button>
          <button class="btn btn__secondary"><a href="login.jsp" style="color:white; text-decoration:none;">Sign In</a></button>
        </div>
      </nav>
      <div class="section__container header__container" id="home">
        <div class="header__image">
          <img src="./assets/images/homeBg1.png" alt="header" />
        </div>
        <div class="header__content">
          <h1>Rent Smart, Save Big Find Your Perfect Ride Today!</h1>
          <p>
            The place where concern your safety, comfort, and hassle-free ride provider in Sri Lanka
          </p>
          <div class="header__links">
            <button class="btn btn__primary"><a href="login.jsp" style="color:white; text-decoration:none;">Book Your Vehicle</a></button>
          </div>
        </div>
      </div>
    </header>

    <section class="section__container steps__container" id="rent">
      <p class="section__subheader">NEED AN AFFORDABLE VEHICLE?</p>
      <h2 class="section__header">Just follow these 3 easy steps</h2>
      <div class="steps__grid">
        <div class="steps__card">
          <span><i class="ri-map-pin-fill"></i></span>
          <h4>Choose a location</h4>
          <p>
            Select your desired destination for renting a vehicle
          </p>
        </div>
        <div class="steps__card">
          <span><i class="ri-calendar-check-fill"></i></span>
          <h4>Duration</h4>
          <p>
            Specify the date and time you wish to rent your vehicle with hassle-free
            scheduling options.
          </p>
        </div>
        <div class="steps__card">
          <span><i class="ri-bookmark-3-fill"></i></span>
          <h4>Book your vehicle</h4>
          <p>
            Explore our diverse fleet of vehicles and find the perfect match for your needs.
          </p>
        </div>
      </div>
    </section>

    <section class="section__container service__container" id="service">
      <div class="service__image">
        <img src="./assets/images/homeBg2.png" alt="service" />
      </div>
      <div class="service__content">
        <p class="section__subheader">OUR SERVICES</p>
        <h2 class="section__header">
          Enjoy the Ride with Premium Service and Affordable Rates
        </h2>
        <ul class="service__list">
          <li>
            <span><i class="ri-price-tag-3-fill"></i></span>
            <div>
              <h4>Comfortable Vehicles</h4>
              <p>
                Whether you're after an economy car or a luxury ride, we offer options for every budget, ensuring you get the most value for your money.
              </p>
            </div>
          </li>
          <li>
            <span><i class="ri-wallet-fill"></i></span>
            <div>
              <h4>Attractive Packages</h4>
              <p>
               We guarantee the best rates in the market, so you can book with peace of mind, knowing you're securing the most competitive deal.
              </p>
            </div>
          </li>
          <li>
            <span><i class="ri-customer-service-fill"></i></span>
            <div>
              <h4>Customer support 24x7</h4>
              <p>
                Our friendly team is here around the clock to answer your questions and address any concerns, making sure your rental experience is seamless.
              </p>
            </div>
          </li>
        </ul>
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