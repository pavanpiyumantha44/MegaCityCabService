            </di>
        </div>
    </div>
    <!-- JavaScript for interactivity -->
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
      <script>
            document.addEventListener('DOMContentLoaded', function () {
                const sidebar = document.getElementById('sidebar');
                const sidebarToggle = document.getElementById('sidebarToggle');
                const sidebarClose = document.getElementById('sidebarClose');
                const userMenuButton = document.getElementById('userMenuButton');
                const userMenu = document.getElementById('userMenu');

                // Toggle Sidebar
                sidebarToggle.addEventListener('click', function () {
                    sidebar.classList.toggle('-translate-x-full');
                });

                // Close Sidebar
                sidebarClose.addEventListener('click', function () {
                    sidebar.classList.add('-translate-x-full');
                });

                // Toggle User Menu
                userMenuButton.addEventListener('click', function () {
                    userMenu.classList.toggle('hidden');
                });

                // Close User Menu when clicking outside
                document.addEventListener('click', function (event) {
                    if (!userMenuButton.contains(event.target) && !userMenu.contains(event.target)) {
                        userMenu.classList.add('hidden');
                    }
                });
            });

            // Function to toggle dropdowns
            function toggleDropdown(dropdownId) {
                const dropdown = document.getElementById(dropdownId);
                dropdown.classList.toggle('hidden');
            }
             // Function to handle item selection
            function selectItem(selectedElement) {
                // Remove the 'selected' class from all items
                const allItems = document.querySelectorAll('#sidebar nav a');
                allItems.forEach(item => item.classList.remove('selected'));

                // Add the 'selected' class to the clicked item
                selectedElement.classList.add('selected');
            }
      </script>