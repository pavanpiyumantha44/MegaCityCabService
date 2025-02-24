<%@include file="/WEB-INF/view/layout/admin/header.jsp" %>
<!-- Content Area -->
<div class="flex-1 p-10 overflow-y-auto" class="content" id="main-content">
               <div>
                <nav class="flex" aria-label="Breadcrumb">
                  <ol class="inline-flex items-center space-x-1 md:space-x-2 rtl:space-x-reverse">
                    <li class="inline-flex items-center">
                      <a href="${pageContext.request.contextPath}/admin?action=dashboard" class="inline-flex items-center text-sm font-medium text-gray-800 hover:text-blue-600">
                        <svg class="w-3 h-3 me-2.5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                          <path d="m19.707 9.293-2-2-7-7a1 1 0 0 0-1.414 0l-7 7-2 2a1 1 0 0 0 1.414 1.414L2 10.414V18a2 2 0 0 0 2 2h3a1 1 0 0 0 1-1v-4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v4a1 1 0 0 0 1 1h3a2 2 0 0 0 2-2v-7.586l.293.293a1 1 0 0 0 1.414-1.414Z"/>
                        </svg>
                        Home
                      </a>
                    </li>
                    <li aria-current="page">
                      <div class="flex items-center">
                        <svg class="rtl:rotate-180 w-3 h-3 text-gray-400 mx-1" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                          <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4"/>
                        </svg>
                        <span class="ms-1 text-sm font-medium text-gray-500 md:ms-2 dark:text-gray-400">Bookings</span>
                      </div>
                    </li>
                  </ol>
                </nav>
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
</div>
<%@include file="/WEB-INF/view/layout/admin/footer.jsp" %>
</body>
</html>