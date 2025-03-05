<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Rental Bookings</li>
  </ol>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-3 col-md-3 col-sm-4">
            <div class="form-group">
                <label class="label">Booking Id</label>
                <input type="text" class="form-control" placeholder="Booking Id" id="booking_id"/>
            </div>
        </div>
        <div class="col-3 col-md-3 col-sm-4">
            <div class="form-group">
                <label class="label">Booking Id</label>
                <input type="text" class="form-control" placeholder="NIC" id="nic"/>
            </div>
        </div>
        <div class="col-3 col-md-3 col-sm-4">
            <div class="form-group">
                <label class="label">Booking Id</label>
                <input type="email" class="form-control" placeholder="Email" id="email"/>
            </div>
        </div>
        <div class="col-3 col-md-3 col-sm-12 text-center">
            <button class="btn btn-outline-primary my-3 w-50" id="searchBtn">Search</button>
        </div>
    </div>
</div>
<div class="card border-0 shadow-md mt-5">
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
                        <th scope="col">First Name</th>
                        <th scope="col">Last Name</th>
                        <th scope="col">NIC</th>
                        <th scope="col">Email</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Address</th>
                        <th scope="col">Gender</th>
                        <th scope="col">Membership Status</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
<script type="module">
const customers = <%= new Gson().toJson(request.getAttribute("customers")) %>;
    console.log(customers);

    $(document).ready(function() {
        // Reference to the table body
        const tableBody = $('#cusTbl tbody');

        // Iterate over each customer and construct table rows
         customers.forEach(function(customer) {
           var row = "<tr>" +
                   "<td>" + customer.firstName + "</td>" +
                   "<td>" + customer.lastName + "</td>" +
                   "<td>" + customer.nic + "</td>" +
                   "<td>" + customer.email + "</td>" +
                   "<td>" + customer.phone + "</td>" +
                   "<td>" + customer.address + "</td>" +
                   "<td>" + customer.gender + "</td>" +
                   "<td><span class='badge text-bg-success'>" + customer.membershipStatus + "</span></td>" +
                   "<td>" + "<button class='btn btn-sm btn-outline-primary me-2 update-btn' data-id='" +customer.userId+ "'>" +
                            "<i class='fa-solid fa-pencil'></i>" +
                            "</button>" +
                            "<button class='btn btn-sm btn-outline-danger delete-btn' data-id='" +customer.userId+ "'>" +
                            "<i class='fa-regular fa-trash-can'></i>" +
                            "</button>" +
                   "</td>" +
                   "</tr>";
               tableBody.append(row);
           });
           $(document).on("click", ".delete-btn", function() {
                       const userId = $(this).data("id");
                       const row = $(this).closest("tr");
                       console.log(userId);

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
                                   url: "${pageContext.request.contextPath}/admin?action=customers/delete",
                                   type: "POST",
                                   data: { id: userId },
                                   success: function(response) {
                                       if (response.success) {
                                           row.fadeOut(300, function() {
                                               $(this).remove();
                                           });

                                            Toastify({
                                                text: "Customer Deleted Successfully!.",
                                                duration: 3000,
                                                close: true,
                                                gravity: "top",
                                                position: "center",
                                                backgroundColor: "green",
                                            }).showToast();
                                       } else {
                                            Toastify({
                                                text: "Error deleting customer.",
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