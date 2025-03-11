<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Available Bookings</li>
  </ol>
</nav>
<div class="card border-0 shadow-md mt-5">
    <div class="card-header">
        <div class="row">
            <div class="col-lg-7 col-sm-6">
            </div>
            <div class="col-lg-3 col-sm-6 d-flex">
                <a href="${pageContext.request.contextPath}/booking?action=download/excel" class="btn btn-success me-2">Download Excel <i class="fa-solid fa-file-excel"></i></a>
                 <a href="${pageContext.request.contextPath}/booking?action=download/pdf" class="btn btn-warning">Download PDF <i class="fa-solid fa-file-pdf"></i></a>
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
                        <th scope="col">Booking Date Time</th>
                        <th scope="col">Status</th>
                        <th scope="col">Actions</th>
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
const bookings = <%= new Gson().toJson(request.getAttribute("bookings")) %>;
console.log(bookings);

$(document).ready(function() {
    const tableBody = $('#cusTbl tbody');

    function renderTable() {
        tableBody.empty();

        bookings.forEach(function(booking) {
            var row = "<tr>" +
                       "<td> <a href='${pageContext.request.contextPath}/booking?action=edit&id=" + booking.bookingId + "'>BK"+booking.bookingId+"</a></td>" +
                       "<td>" + booking.pickupLocation + "</td>" +
                       "<td>" + booking.destination + "</td>" +
                       "<td>" + booking.bookingDateTime + "</td>" +
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
                       "<td>" +
                           "<button class='btn btn-sm btn-outline-primary me-2 update-btn' data-id='" + booking.bookingId + "'>" +
                               "<i class='fa-solid fa-pencil'></i>" +
                           "</button>" +
                           "<button class='btn btn-sm btn-outline-danger delete-btn' data-id='" + booking.bookingId + "'>" +
                               "<i class='fa-regular fa-trash-can'></i>" +
                           "</button>" +
                       "</td>" +
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