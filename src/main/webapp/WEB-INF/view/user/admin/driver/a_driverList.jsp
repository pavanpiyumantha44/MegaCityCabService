<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Drivers</li>
  </ol>
</nav>

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
                        <th scope="col">License Number</th>
                        <th scope="col">Gender</th>
                        <th scope="col">Driving Experience</th>
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
const drivers = <%= new Gson().toJson(request.getAttribute("drivers")) %>;
    console.log(drivers);

    $(document).ready(function() {
        // Reference to the table body
        const tableBody = $('#cusTbl tbody');

        // Iterate over each customer and construct table rows
         drivers.forEach(function(driver) {
           var row = "<tr>" +
                   "<td>" + driver.firstName + "</td>" +
                   "<td>" + driver.lastName + "</td>" +
                   "<td>" + driver.nic + "</td>" +
                   "<td>" + driver.email + "</td>" +
                   "<td>" + driver.phone + "</td>" +
                   "<td>" + driver.licenseNumber + "</td>" +
                   "<td>" + driver.gender + "</td>" +
                   "<td>" + driver.drivingExperience + " Y</td>" +
                   "<td>" + "<a href='${pageContext.request.contextPath}/admin?action=drivers/update&id=" + driver.userId + "'>" +
                                                                             "<button class='btn btn-sm btn-outline-primary me-2'>" +
                                                                                 "<i class='fa-solid fa-pencil'></i>" +
                                                                             "</button>" +
                                                                         "</a>" +
                            "<button class='btn btn-sm btn-outline-danger delete-btn' data-id='" +driver.userId+ "'>" +
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
                                   url: "${pageContext.request.contextPath}/admin?action=drivers/delete",
                                   type: "POST",
                                   data: { id: userId },
                                   success: function(response) {
                                       if (response.isSuccess) {
                                           row.fadeOut(300, function() {
                                               $(this).remove();
                                           });

                                            Toastify({
                                                text: "Driver Deleted Successfully!.",
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