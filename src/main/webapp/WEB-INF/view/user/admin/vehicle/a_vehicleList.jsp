<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Vehicles</li>
  </ol>
</nav>

<div class="card border-0 shadow-md mt-5">
    <div class="card-header">
        <div class="row">
            <div class="col-lg-10 col-sm-6">
            </div>
            <div class="col-lg-2 col-sm-6">
                <input type="text" id="searchBox" class="form-control" placeholder="Search..." style="outline: none;" onfocus="this.style.outline='none';">
            </div>
        </div>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table id="cusTbl" class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Image</th>
                        <th scope="col">VIN</th>
                        <th scope="col">Model</th>
                        <th scope="col">Make</th>
                        <th scope="col">Registration No</th>
                        <th scope="col">No Of Seats</th>
                        <th scope="col">Price Per Day</th>
                        <th scope="col">Price Per KM</th>
                        <th scope="col">Vehicle Type</th>
                        <th scope="col">Status</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
<script type="module">
const vehicles = <%= new Gson().toJson(request.getAttribute("vehicles")) %>;
console.log(vehicles);

$(document).ready(function() {
    // Reference to the table body
    const tableBody = $('#cusTbl tbody');

    // Function to render the vehicle data in the table
    function renderTable() {
        tableBody.empty(); // Clear the table before rendering new rows

        vehicles.forEach(function(vehicle) {
            var row = "<tr>" +
                       "<td> <img src='${pageContext.request.contextPath}/assets/images/" + vehicle.imageName + "' width='80px'/></td>" +
                       "<td>" + vehicle.vin + "</td>" +
                       "<td>" + vehicle.model + "</td>" +
                       "<td>" + vehicle.make + "</td>" +
                       "<td>" + vehicle.registrationNumber + "</td>" +
                       "<td>" + vehicle.noOfSeats + "</td>" +
                       "<td>" + vehicle.pricePerDay + " LKR</td>" +
                       "<td>" + vehicle.pricePerKm + " LKR</td>" +
                       "<td>" + vehicle.vehicleType + "</td>" +
                       "<td>" + (vehicle.status === "available" ?
                           "<span class='badge text-bg-success'>" + vehicle.status + "</span>" :
                           "<span class='badge text-bg-danger'>" + vehicle.status + "</span>") +
                       "</td>" +
                       "<td>" +
                           "<button class='btn btn-sm btn-outline-primary me-2 update-btn' data-id='" + vehicle.vehicleId + "'>" +
                               "<i class='fa-solid fa-pencil'></i>" +
                           "</button>" +
                           "<button class='btn btn-sm btn-outline-danger delete-btn' data-id='" + vehicle.vehicleId + "'>" +
                               "<i class='fa-regular fa-trash-can'></i>" +
                           "</button>" +
                       "</td>" +
                   "</tr>";
            tableBody.append(row);
        });
    }

    // Render table initially
    renderTable();

    // Search functionality
    $('#searchBox').on('keyup', function() {
        const searchTerm = $(this).val().toLowerCase();

        // Filter rows based on VIN or model
        $('#cusTbl tbody tr').each(function() {
            const vin = $(this).find('td').eq(1).text().toLowerCase();  // VIN is in the second column
            const model = $(this).find('td').eq(2).text().toLowerCase();  // Model is in the third column
            const registrationNumber = $(this).find('td').eq(4).text().toLowerCase();

            // Check if VIN or model matches the search term
            if (vin.includes(searchTerm) || model.includes(searchTerm) || registrationNumber.includes(searchTerm)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
           $(document).on("click", ".delete-btn", function() {
                       const vehicleId = $(this).data("id");
                       const row = $(this).closest("tr");
                       console.log(vehicleId);

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
                                   url: "${pageContext.request.contextPath}/admin?action=vehicles/delete",
                                   type: "POST",
                                   data: { id: vehicleId },
                                   success: function(response) {
                                       if (response.success) {
                                           row.fadeOut(300, function() {
                                               $(this).remove();
                                           });

                                            Toastify({
                                                text: "Vehicle Deleted Successfully!.",
                                                duration: 3000,
                                                close: true,
                                                gravity: "top",
                                                position: "center",
                                                backgroundColor: "green",
                                            }).showToast();
                                       } else {
                                            Toastify({
                                                text: "Error deleting vehicle.",
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