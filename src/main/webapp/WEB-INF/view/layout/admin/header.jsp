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
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha2/dist/css/bootstrap.min.css">
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <!-- Include JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/assets/css/style.css">
    <!-- Toastify CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <!-- Sweet Alert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>
</head>

<body>
    <div class="wrapper">
        <aside id="sidebar" class="js-sidebar">
            <!-- Content For Sidebar -->
            <div class="h-100">
                <div class="sidebar-logo">
                    <span style="font-size: 1.5rem; color: #FFC001;">MegaCity</span> <span class="text-white" style="font-size: 1.2rem;">Cabs</span>
                </div>
                <ul class="sidebar-nav">
                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/admin?action=dashboard" class="sidebar-link">
                            <i class="fa-solid fa-list pe-2"></i>
                            Dashboard
                        </a>
                    </li>
                     <li class="sidebar-item">
                        <a href="#" class="sidebar-link collapsed" data-bs-target="#bookings" data-bs-toggle="collapse"
                            aria-expanded="false"><i class="fa-solid fa-file-lines pe-2"></i></i>
                            Rides
                        </a>
                        <ul id="bookings" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/booking?action=list" class="sidebar-link">Available Bookings</a>
                            </li>
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/booking?action=add" class="sidebar-link">Create Booking</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item">
                        <a href="#" class="sidebar-link collapsed" data-bs-target="#customers" data-bs-toggle="collapse"
                            aria-expanded="false">
                            <i class="fas fa-users"></i>
                            Customers
                        </a>
                        <ul id="customers" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/admin?action=customers/list" class="sidebar-link">Available Customers</a>
                            </li>
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/admin?action=customers/add" class="sidebar-link">Add Customers</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item">
                        <a href="#" class="sidebar-link collapsed" data-bs-target="#vehicles" data-bs-toggle="collapse"
                            aria-expanded="false">
                            <i class="fa-solid fa-car-side"></i>
                            Vehicles
                        </a>
                        <ul id="vehicles" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/admin?action=vehicles/list" class="sidebar-link">Available Vehicles</a>
                            </li>
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/admin?action=vehicles/add" class="sidebar-link">Add Vehicle</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item">
                        <a href="#" class="sidebar-link collapsed" data-bs-target="#drivers" data-bs-toggle="collapse"
                            aria-expanded="false">
                            <i class="fa-solid fa-user-tie"></i>
                            Drivers
                        </a>
                        <ul id="drivers" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/admin?action=drivers/list" class="sidebar-link">Available Drivers</a>
                            </li>
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/admin?action=drivers/add" class="sidebar-link">Add Driver</a>
                            </li>
                        </ul>
                    </li>
                    <li class="sidebar-item">
                        <a href="#" class="sidebar-link collapsed" data-bs-target="#staff" data-bs-toggle="collapse"
                            aria-expanded="false">
                            <i class="fa-regular fa-id-badge"></i>
                            Staff
                        </a>
                        <ul id="staff" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/admin?action=staff/list" class="sidebar-link">Available Staff</a>
                            </li>
                            <li class="sidebar-item">
                                <a href="${pageContext.request.contextPath}/admin?action=staff/add" class="sidebar-link">Add Staff Member</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </aside>
        <div class="main">
            <nav class="navbar bg-white navbar-expand px-3 border-bottom">
                <button class="btn" id="sidebar-toggle" type="button">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="navbar-collapse navbar">
                    <ul class="navbar-nav">
                        <li class="nav-item dropdown">
                            <a href="#" data-bs-toggle="dropdown" class="nav-icon pe-md-0">
                                <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2.25&w=256&h=256&q=80" class="avatar img-fluid rounded" alt="">
                                <span class="ms-2"><%= session.getAttribute("first_name") %></span>
                                <i class="fa-solid fa-angle-down"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end">
                                <a href="#" class="dropdown-item">Profile</a>
                                <a href="#" class="dropdown-item">Setting</a>
                                <a href="auth?action=logout" class="dropdown-item">Logout</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
            <!-- Main Content-->
            <main class="content px-3 py-2">
                <div class="container-fluid">