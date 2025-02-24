<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user_id") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int roleId = (int) userSession.getAttribute("role_id");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Include FontAwesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <!-- Include Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Include JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Toastify -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">

     <!-- Style for selected item -->
     <style>
         #sidebar nav a.selected {
             background-color: #4a5568; /* A darker shade for selected item */
         }
         #sidebar nav a:hover {
             background-color: #2d3748; /* A darker shade for hover */
         }
     </style>
</head>
<body class="bg-gray-100">
    <div class="flex h-screen">

<!-- Sidebar -->
       <div id="sidebar" class="bg-[#233143] text-white w-64 space-y-6 py-4 px-2 transform -translate-x-full md:translate-x-0 transition-transform duration-200 ease-in-out fixed md:relative h-full">
                   <!-- Close Button for Small Screens -->
                   <button id="sidebarClose" class="md:hidden absolute top-3 right-5 text-white focus:outline-none">
                       <i class="fas fa-times text-xl"></i>
                   </button>
                   <div class="text-2xl font-semibold text-center">
                       <span class="text-yellow-500">MegaCity</span> <span>Cabs</span>
                   </div>
                   <nav>
                       <!-- Dashboard -->
                       <a href="${pageContext.request.contextPath}/admin?action=dashboard" class="flex items-center py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">
                           <i class="fas fa-home text-xl"></i>
                           <span class="ml-3">Dashboard</span>
                       </a>
                       <!-- Bookings -->
                       <div class="relative">
                           <a href="#" class="flex items-center justify-between py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="toggleDropdown('bookingsDropdown'); selectItem(this)">
                               <div class="flex items-center">
                                   <i class="fa-solid fa-clipboard-list text-xl"></i>
                                   <span class="ml-3">Bookings</span>
                               </div>
                               <i class="fas fa-chevron-down text-sm"></i>
                           </a>
                           <!-- Bookings Dropdown -->
                           <div id="bookingsDropdown" class="hidden ml-8 mt-2 space-y-2">
                               <a href="${pageContext.request.contextPath}/admin?action=bookings" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Available Bookings</a>
                               <a href="#" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Add Booking</a>
                           </div>
                       </div>
                       <!-- Customers -->
                       <div class="relative">
                           <a href="#" class="flex items-center justify-between py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="toggleDropdown('customersDropdown'); selectItem(this)">
                               <div class="flex items-center">
                                   <i class="fas fa-users text-xl"></i>
                                   <span class="ml-3">Customers</span>
                               </div>
                               <i class="fas fa-chevron-down text-sm"></i>
                           </a>
                           <!-- Customers Dropdown -->
                           <div id="customersDropdown" class="hidden ml-8 mt-2 space-y-2">
                               <a href="${pageContext.request.contextPath}/admin?action=customers/list" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Available Customer</a>
                               <a href="${pageContext.request.contextPath}/admin?action=customers/add" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Add Customer</a>
                           </div>
                       </div>
                       <!-- Drivers -->
                       <div class="relative">
                           <a href="#" class="flex items-center justify-between py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="toggleDropdown('driversDropdown'); selectItem(this)">
                               <div class="flex items-center">
                                   <i class="fa-solid fa-user-tie text-xl"></i>
                                   <span class="ml-3">Drivers</span>
                               </div>
                               <i class="fas fa-chevron-down text-sm"></i>
                           </a>
                           <!-- Drivers Dropdown -->
                           <div id="driversDropdown" class="hidden ml-8 mt-2 space-y-2">
                               <a href="${pageContext.request.contextPath}/admin?action=drivers/list" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Available Drivers</a>
                               <a href="${pageContext.request.contextPath}/admin?action=drivers/add" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Add Drivers</a>
                           </div>
                       </div>
                        <!-- Staff -->
                       <div class="relative">
                           <a href="#" class="flex items-center justify-between py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="toggleDropdown('staffDropdown'); selectItem(this)">
                               <div class="flex items-center">
                                   <i class="fa-regular fa-id-badge text-xl"></i>
                                   <span class="ml-3">Staff</span>
                               </div>
                               <i class="fas fa-chevron-down text-sm"></i>
                           </a>
                           <!-- Drivers Dropdown -->
                           <div id="staffDropdown" class="hidden ml-8 mt-2 space-y-2">
                               <a href="${pageContext.request.contextPath}/admin?action=staff/list" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Available Staff</a>
                               <a href="${pageContext.request.contextPath}/admin?action=staff/add" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Add New Member</a>
                           </div>
                       </div>
                       <!-- Settings -->
                       <div class="relative">
                           <a href="#" class="flex items-center justify-between py-2.5 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="toggleDropdown('settingsDropdown'); selectItem(this)">
                               <div class="flex items-center">
                                   <i class="fas fa-cog text-xl"></i>
                                   <span class="ml-3">Settings</span>
                               </div>
                               <i class="fas fa-chevron-down text-sm"></i>
                           </a>
                           <!-- Settings Dropdown -->
                           <div id="settingsDropdown" class="hidden ml-8 mt-2 space-y-2">
                               <a href="#" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Profile Settings</a>
                               <a href="#" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">System Settings</a>
                               <a href="#" class="block py-2 px-4 rounded transition duration-200 hover:bg-gray-700" onclick="selectItem(this)">Security</a>
                           </div>
                       </div>
                   </nav>
               </div>
        <div class="flex-1 flex flex-col overflow-hidden">
            <!--NavBar-->
             <!-- Top Navbar -->
                        <div class="bg-white shadow-md p-4 flex justify-between items-center">
                            <button id="sidebarToggle" class="md:hidden focus:outline-none">
                                <i class="fas fa-bars text-xl"></i>
                            </button>
                            <!-- <h1 class="text-2xl font-bold">Dashboard</h1> -->
                             <input type="search" class="w-1/3 h-10 px-4 rounded-lg outline-none" placeholder="Search...">
                            <div class="relative">
                                <button id="userMenuButton" class="flex items-center focus:outline-none">
                                    <img class="inline-block size-10 rounded-full ring-2 ring-white" src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2.25&w=256&h=256&q=80" alt="">
                                    <span class="ml-2"><%= session.getAttribute("first_name") %></span>
                                    <i class="fas fa-chevron-down ml-2"></i>
                                </button>
                                <!-- Dropdown Menu -->
                                <div id="userMenu" class="hidden absolute right-0 mt-2 w-48 bg-white border border-gray-200 rounded-lg shadow-lg">
                                    <a href="#" class="block px-4 py-2 text-gray-700 hover:bg-gray-100">Profile</a>
                                    <a href="#" class="block px-4 py-2 text-gray-700 hover:bg-gray-100">Settings</a>
                                    <hr class="my-2 h-0.5 border-t-1 bg-gray" />
                                    <a href="auth?action=logout" class="block px-4 py-2 text-gray-700 hover:bg-gray-100">Logout</a>
                                </div>
                            </div>
                        </div>