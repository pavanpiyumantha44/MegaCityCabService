<%@include file="/WEB-INF/view/layout/driver/header.jsp" %>
<%@ page import="com.google.gson.Gson" %>
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
<div class="container-fluid">
<div class="row">
    <div class="col-12 col-md-6 d-flex">
         <div class="card flex-fill border-0">
                <div class="card-body py-4">
                      <div class="row">
                          <div class="col-6">
                              <div class="d-flex justify-content-end">
                                   <h4 class="mt-1">
                                        <i class="fa-solid fa-taxi text-primary"></i>
                                   </h4>
                              </div>
                          </div>
                          <div class="col-6">
                              <div>
                                   <h2 id="totalRides">0</h2>
                              </div>
                          </div>
                      </div>
                      <div class="row">
                          <p class="mb-2 text-center">
                              Total Rides
                          </p>
                      </div>
                </div>
         </div>
    </div>
    <div class="col-12 col-md-6 d-flex">
    <div class="card flex-fill border-0">
         <div class="card-body py-4">
               <div class="d-flex align-items-start justify-content-center">
                    <div class="flex-grow-1 text-center">
                          <h4 class="mb-2">
                          <i class="fa-solid fa-money-bill-wave text-success"></i>
                              <span id="earning"><span>
                              <span class="text-success">LKR</span>
                          </h4>
                          <p class="mb-2">
                              Total Earnings
                          </p>
                          <div class="mb-0">
                             <span class="badge text-success me-2">
                                 +9.0%
                             </span>
                             <span class="text-muted">
                                 Since Last Month
                             </span>
                          </div>
                    </div>
               </div>
         </div>
    </div>
    </div>
    </div>
</div>
<div class="container-fluid mt-5">
<p class="text-success">Available Rides</p>
<div class="card border-0 shadow-md ">
    <div class="card-header">
        <div class="row">
            <div class="col-lg-10 col-sm-6">
            </div>
            <div class="col-lg-2 col-sm-6">
                <input type="text" class="form-control" placeholder="Search..." style="outline: none;" onfocus="this.style.outline='none';">
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table id="cusTbl" class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Booking ID</th>
                        <th scope="col">Pickup Location</th>
                        <th scope="col">Destination</th>
                        <th scope="col">Pickup Date Time</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div class="card-footer d-flex justify-content-end">
            <nav aria-label="Page navigation example">
              <ul class="pagination">
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Previous">
                    <span aria-hidden="true">&laquo;</span>
                  </a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <!-- <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>-->
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                  </a>
                </li>
              </ul>
            </nav>
        </div>
    </div>
   </div>
</div>
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
<script type="module">
const bookings = <%= new Gson().toJson(request.getAttribute("rides")) %>;
console.log(bookings);

$(document).ready(function() {
    const rideCount = <%= new Gson().toJson(request.getAttribute("rideCount")) %>;
    const totalEarning = <%= new Gson().toJson(request.getAttribute("totalEarning")) %>;
    $("#totalRides").text(rideCount);
    $("#earning").append(totalEarning);
    const tableBody = $('#cusTbl tbody');

    function renderTable() {
        tableBody.empty();

        bookings.forEach(function(booking) {
            var row = "<tr>" +
                       "<td> <a href='${pageContext.request.contextPath}/booking?action=edit&id=" + booking.bookingId + "'>BK"+booking.bookingId+"</a></td>" +
                       "<td>" + booking.pickupLocation + "</td>" +
                       "<td>" + booking.destination + "</td>" +
                       "<td>" + booking.pickupDateTime + "</td>" +
                       "<td>";
                           if (booking.status === "pending") {
                               row += "<span class='badge text-bg-warning'>" + booking.status + "</span>";
                           } else if (booking.status === "assigned") {
                               row += "<span class='badge text-bg-info'>" + booking.status + "</span>";
                           } else if (booking.status === "ongoing") {
                               row += "<span class='badge text-bg-primary'>" + booking.status + "</span>";
                           } else if (booking.status === "completed") {
                               row += "<span class='badge text-bg-success'>" + booking.status + "</span>";
                           } else if (booking.status === "cancelled" || booking.status === "closed") {
                               row += "<span class='badge text-bg-danger'>" + booking.status + "</span>";
                           }
                           row += "</td>" +
                   "</tr>";
            tableBody.append(row);
        });
    }
    renderTable();

    $('#searchBox').on('keyup', function() {
        const searchTerm = $(this).val().toLowerCase();

        $('#cusTbl tbody tr').each(function() {
            const bookingId = $(this).find('td').eq(0).text().toLowerCase();
            const pickupLocation = $(this).find('td').eq(1).text().toLowerCase();
            const destination = $(this).find('td').eq(2).text().toLowerCase();

            if (bookingId.includes(searchTerm) || pickupLocation.includes(searchTerm) || destination.includes(searchTerm)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
           $(document).on("click", ".delete-btn", function() {
                       const bookingId = $(this).data("id");
                       const row = $(this).closest("tr");
                       console.log(bookingId);

                       Swal.fire({
                           title: "Are you sure?",
                           text: "You won't be able to undo this action!",
                           icon: "warning",
                           showCancelButton: true,
                           confirmButtonColor: "#d33",
                           cancelButtonColor: "#3085d6",
                           confirmButtonText: "Yes, delete it!"
                       }).then((result) => {
                           if (result.isConfirmed) {
                               $.ajax({
                                   url: "${pageContext.request.contextPath}/admin?action=booking/delete",
                                   type: "POST",
                                   data: { id: bookingId },
                                   success: function(response) {
                                       if (response.success) {
                                           row.fadeOut(300, function() {
                                               $(this).remove();
                                           });

                                            Toastify({
                                                text: "Booking Deleted Successfully!.",
                                                duration: 3000,
                                                close: true,
                                                gravity: "top",
                                                position: "center",
                                                backgroundColor: "green",
                                            }).showToast();
                                       } else {
                                            Toastify({
                                                text: "Error deleting Booking.",
                                                duration: 3000,
                                                close: true,
                                                gravity: "top",
                                                position: "center",
                                                backgroundColor: "red",
                                            }).showToast();
                                       }
                                   },
                                   error: function() {
                                        Toastify({
                                           text: "Something went wrong!",
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
               });
    </script>
</body>
</html>
