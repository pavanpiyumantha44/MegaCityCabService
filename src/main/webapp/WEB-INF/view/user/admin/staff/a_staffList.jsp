<%@ page import="com.google.gson.Gson" %>
<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<!-- Content Area -->
<div>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb my-5">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin?action=dashboard"><i class="fa-solid fa-house"></i> Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Staff</li>
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
                        <th scope="col">Gender</th>
                        <th scope="col">Job Title</th>
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
const staff = <%= new Gson().toJson(request.getAttribute("staff")) %>;
    console.log(staff);

    $(document).ready(function() {
        // Reference to the table body
        const tableBody = $('#cusTbl tbody');

        // Iterate over each customer and construct table rows
        staff.forEach((stf, index) => {

          var row = "<tr>" +
              "<td>" + stf.firstName + "</td>" +
              "<td>" + stf.lastName + "</td>" +
              "<td>" + stf.nic + "</td>" +
              "<td>" + stf.email + "</td>" +
              "<td>" + stf.phone + "</td>" +
              "<td>" + stf.gender + "</td>" +
              "<td>" + stf.jobTitle + "</td>" +
              "<td>" + "<button class='btn btn-sm btn-outline-primary me-2 update-btn' data-id='" +stf.userId+ "'>" +
                       "<i class='fa-solid fa-pencil'></i>" +
                       "</button>" +
                       "<button class='btn btn-sm btn-outline-danger delete-btn' data-id='" +stf.userId+ "'>" +
                       "<i class='fa-regular fa-trash-can'></i>" +
                       "</button>" +
              "</td>" +
              "</tr>";
          tableBody.append(row);
        });

        $(document).on("click", ".delete-btn", function() {
            const userId = $(this).data("id");
            const row = $(this).closest("tr");

            // Show the custom modal
            const modal = document.getElementById('delete-modal');
            modal.classList.remove('hidden');

            // Handle the "Delete" button click
            document.getElementById('confirm-delete').onclick = function() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin?action=staff/delete",
                    type: "POST",
                    data: { id: userId },
                    success: function(response) {
                        if (response.success) {
                            row.fadeOut(300, function() {
                                $(this).remove();
                            });

                            // Show success toast notification
                            Toastify({
                                text: "Staff member deleted successfully!",
                                duration: 3000,
                                close: true,
                                gravity: "top",
                                position: "center",
                                backgroundColor: "green",
                            }).showToast();
                        } else {
                            // Show error toast notification
                            Toastify({
                                text: "Failed to delete staff member.",
                                duration: 3000,
                                close: true,
                                gravity: "top",
                                position: "center",
                                backgroundColor: "red",
                            }).showToast();
                        }
                    },
                    error: function() {
                        // Show error toast notification
                        Toastify({
                            text: "Error deleting staff member.",
                            duration: 3000,
                            close: true,
                            gravity: "top",
                            position: "right",
                            backgroundColor: "red",
                        }).showToast();
                    }
                });

                // Hide the modal after deletion
                modal.classList.add('hidden');
            };

            // Handle the "Cancel" button click
            document.getElementById('cancel-delete').onclick = function() {
                modal.classList.add('hidden');
            };
        });
    });
</script>
</body>
</html>