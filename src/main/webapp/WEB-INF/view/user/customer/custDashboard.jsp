<%@include file="/WEB-INF/view/layout/customer/header.jsp" %>
<style>
    .card {
      border: 1px solid #ddd;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .card-body {
      padding: 20px;
    }
    .form-label {
      font-weight: bold;
    }
    .btn-primary {
      background-color: #474fa0;
      border: none;
    }
    .btn-primary:hover {
      background-color: #0056b3;
    }
  </style>
                    <div class="my-3">
                        <h4>Welcome <%= session.getAttribute("first_name") %></h4>
                    </div>
                    <div class="row text-center my-2">
                    <div class="col-12">
                    <button class="btn btn-outline-secondary me-1 w-25">Ride</button><button class="btn btn-outline-secondary w-25">Rental</button>
                    </div>
                    </div>
                    <div class="container mt-5">
                        <div class="row">
                          <div class="col-12">
                            <div class="card">
                              <div class="card-body">

                               <div class="row">
                                <h2 class="text-center mb-4">Select a Vehicle</h2>
                                  <!-- Left Column: Vehicle Options -->
                                  <div class="col-md-6 col-sm-12">
                                    <div>

                                    </div>
                                    <div class="mb-3">
                                      <label class="form-label">Vehicle Type</label>
                                      <div class="d-flex flex-wrap gap-2">
                                        <button class="btn btn-outline-primary">Semi</button>
                                        <button class="btn btn-outline-primary">Car</button>
                                        <button class="btn btn-outline-primary">9 Seater</button>
                                        <button class="btn btn-outline-primary">14 Seater</button>
                                      </div>
                                    </div>
                                    <div class="mb-3">
                                      <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="flexiblePayment">
                                        <label class="form-check-label" for="flexiblePayment">Flexible Payment</label>
                                      </div>
                                      <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="airConditioned">
                                        <label class="form-check-label" for="airConditioned">Air Conditioned</label>
                                      </div>
                                    </div>
                                  </div>

                                  <!-- Right Column: Booking Details -->
                                  <div class="col-md-6 col-sm-12">
                                    <div class="mb-3">
                                      <label for="pickLocation" class="form-label">Pick Location</label>
                                      <input type="text" class="form-control" id="pickLocation" placeholder="Enter pick-up location">
                                    </div>
                                    <div class="mb-3">
                                      <label for="dropLocation" class="form-label">Drop Location</label>
                                      <input type="text" class="form-control" id="dropLocation" placeholder="Enter drop-off location">
                                    </div>
                                    <div class="mb-3">
                                      <label for="dateTime" class="form-label">Date & Time</label>
                                      <input type="datetime-local" class="form-control" id="dateTime">
                                    </div>
                                    <div class="mb-3">
                                      <p><strong>Est. LKR 0.00</strong></p>
                                      <p>4 passengers</p>
                                      <p>Limited baggage</p>
                                    </div>
                                    <button class="btn btn-primary w-100">Book Now</button>
                                  </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3 col-sm-12">
                                        <div class="mb-3">
                                          <label for="budget" class="form-label">Budget</label>
                                          <input type="text" class="form-control" id="budget" placeholder="Enter your budget">
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-12">
                                        <div class="mb-3">
                                          <label for="budget" class="form-label">Budget</label>
                                          <input type="text" class="form-control" id="budget" placeholder="Enter your budget">
                                        </div>
                                    </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
   <%@include file="/WEB-INF/view/layout/customer/footer.jsp" %>
</body>

</html>
