package com.cab.mega.controller;

import com.cab.mega.Service.BookingService;
import com.cab.mega.Service.UserService;
import com.cab.mega.Service.VehicleService;
import com.cab.mega.model.*;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import static com.cab.mega.utils.datamapper.DataMapper.getDataMapper;

@WebServlet("/driver/*")
public class DriverDataController extends HttpServlet {

    UserService userService;
    VehicleService vehicleService;
    BookingService bookingService;

    public void init() throws ServletException {
        userService = UserService.getInstance();
        vehicleService = VehicleService.getInstance();
        bookingService = BookingService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null){
            res.sendRedirect(req.getContextPath()+"/");
        }
        assert action != null;
        if (action.equals("dashboard")){
            showDashboard(req,res);
        }else if (action.equals("bookings")){
            showBookings(req,res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null){
            res.sendRedirect(req.getContextPath()+"/");
        }
        assert action != null;
        if (action.equals("customers/add")){
            //addCustomers(req,res);
        }else if(action.equals("customers/delete")){
            //deleteUser(req,res);
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            int userId = (int) session.getAttribute("user_id");
            if (roleId!= 3) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            int driverId = userService.getDriverId(userId);
            int rideCount = userService.getDriverRideCount(driverId);
            double totalEarning = userService.getDriverEarning(driverId);
            List<Booking> rides = bookingService.getAssignedBookingByDriverId(driverId);
            req.setAttribute("rides",rides);
            req.setAttribute("rideCount",rideCount);
            req.setAttribute("totalEarning",totalEarning);
            req.getRequestDispatcher("/WEB-INF/view/user/driver/driverDashboard.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
    private void showBookings(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 3) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            int userId = (int) session.getAttribute("user_id");
            int driverId = userService.getDriverId(userId);
            List<Booking> rides = bookingService.getAssignedBookingByDriverId(driverId);
            req.setAttribute("rides",rides);
            req.getRequestDispatcher("/WEB-INF/view/user/driver/d_availableRides.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
}
