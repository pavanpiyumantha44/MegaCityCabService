<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
            <div class="flex-1 p-10 overflow-y-auto" class="content" id="main-content">
            <!-- Main Content -->
                <!-- Content Area -->
                                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                                    <!-- Total Revenue Card -->
                                    <div class="bg-white p-12 rounded-lg shadow-lg">
                                        <h2 class="text-xl font-semibold mb-2">Total Revenue</h2>
                                        <div class="flex items-center justify-between w-full">
                                            <p class="text-black-700 font-bold text-3xl">$12,345</p>
                                            <p class="text-green-500 font-bold text-3xl">$</p>
                                        </div>

                                    </div>

                                    <!-- Total Sales Card -->
                                    <div class="bg-white p-12 rounded-lg shadow-lg">
                                        <h2 class="text-xl font-semibold mb-2">Total Sales</h2>
                                        <div class="flex items-center justify-between w-full">
                                            <p class="text-black-700 font-bold text-3xl">$12,345</p>
                                            <p class="text-green-500 font-bold text-3xl">$</p>
                                        </div>
                                    </div>

                                    <!-- Vision Analytics Card -->
                                    <div class="bg-white p-12 rounded-lg shadow-lg">
                                        <h2 class="text-xl font-semibold mb-2">Vision Analytics</h2>
                                        <div class="flex items-center justify-between w-full">
                                            <p class="text-black-700 font-bold text-3xl">$12,345</p>
                                            <p class="text-green-500 font-bold text-3xl">$</p>
                                        </div>
                                    </div>

                                    <!-- Total Users Card -->
                                    <div class="bg-white p-12 rounded-lg shadow-lg">
                                        <h2 class="text-xl font-semibold mb-2">Total Users</h2>
                                        <div class="flex items-center justify-between w-full">
                                            <p class="text-black-700 font-bold text-3xl">$12,345</p>
                                            <p class="text-green-500 font-bold text-3xl">$</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-1 mt-5 shadow-lg h-1vh">
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full bg-white border border-gray-200">
                                            <thead>
                                                <tr>
                                                    <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Package</th>
                                                    <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Invoice date</th>
                                                    <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                                    <th class="px-6 py-3 border-b border-gray-200 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white">
                                                <tr>
                                                    <td class="px-6 py-4 border-b border-gray-200">Free Package</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">Jan 13, 2023</td>
                                                    <td class="px-6 py-4 border-b border-gray-200 text-green-500">Paid</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">
                                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3" />
                                                        </svg>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="px-6 py-4 border-b border-gray-200">Standard Package</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">Jan 13, 2023</td>
                                                    <td class="px-6 py-4 border-b border-gray-200 text-green-500">Paid</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">
                                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3" />
                                                        </svg>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="px-6 py-4 border-b border-gray-200">Business Package</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">Jan 13, 2023</td>
                                                    <td class="px-6 py-4 border-b border-gray-200 text-red-500">Unpaid</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">
                                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3" />
                                                        </svg>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="px-6 py-4 border-b border-gray-200">Standard Package</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">Jan 13, 2023</td>
                                                    <td class="px-6 py-4 border-b border-gray-200 text-yellow-500">Pending</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">
                                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3" />
                                                        </svg>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="px-6 py-4 border-b border-gray-200">Standard Package</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">Jan 13, 2023</td>
                                                    <td class="px-6 py-4 border-b border-gray-200 text-yellow-500">Pending</td>
                                                    <td class="px-6 py-4 border-b border-gray-200">
                                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3" />
                                                        </svg>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                </div>
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
</body>
</html>