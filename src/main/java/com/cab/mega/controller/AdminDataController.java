package com.cab.mega.controller;

import com.cab.mega.Service.BookingService;
import com.cab.mega.Service.UserService;
import com.cab.mega.Service.VehicleService;
import com.cab.mega.model.*;
import com.google.gson.Gson;
import com.google.protobuf.TextFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import static com.cab.mega.utils.datamapper.DataMapper.getDataMapper;

@WebServlet("/admin/*")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminDataController extends HttpServlet {
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
        }else if (action.equals("bookings/addRental")){
            //showAddRentalBooking(req,res);
        }else if(action.equals("customers/list")){
            showCustomers(req,res);
        }else if(action.equals("customers/add")){
            showAddCustomers(req,res);;
        }else if(action.equals("drivers/list")){
            showDrivers(req,res);;
        }else if(action.equals("drivers/add")){
            showAddDrivers(req,res);;
        }else if(action.equals("staff/list")){
            showStaff(req,res);
        }else if(action.equals("staff/add")){
            showAddStaff(req,res);
        }else if(action.equals("vehicles/list")){
            showVehicles(req,res);
        }else if(action.equals("vehicles/add")){
            showAddVehicle(req,res);
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
            addCustomers(req,res);
        }else if(action.equals("customers/delete")){
            deleteUser(req,res);
        }else if(action.equals("bookings/add")){
            addBooking(req,res);
        }else if(action.equals("drivers/add")){
            addDrivers(req,res);
        }else if(action.equals("drivers/delete")){
            deleteUser(req,res);
        }else if(action.equals("staff/add")){
            addStaff(req,res);
        }else if(action.equals("staff/delete")){
            deleteUser(req,res);
        }else if(action.equals("vehicles/add")){
            addVehicle(req,res);
        }else if(action.equals("vehicles/delete")){
            deleteVehicle(req,res);
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
    private void showBookings(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_availableBookings.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }

    }
    private void showCustomers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            List<Customer> customers = userService.getAllCustomers();
            req.setAttribute("customers",customers);
            req.getRequestDispatcher("/WEB-INF/view/user/admin/customer/a_customerList.jsp").forward(req, res);
        }catch (NullPointerException | SQLException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showAddCustomers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/customer/a_addNewCustomer.jsp").forward(req, res);
        }catch (NullPointerException | IOException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void addCustomers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            String firstName = req.getParameter("first_name");
            String lastName = req.getParameter("last_name");
            String nic = req.getParameter("nic");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String address = req.getParameter("address");
            String membershipStatus = req.getParameter("membership");
            User user = new User(firstName,lastName,nic,email,password,phone,gender,4);
            Customer customer = new Customer(address,membershipStatus);
            try {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!",false,null);
                Customer customerData = new Gson().fromJson(getDataMapper().mapData(req), Customer.class);
                response = userService.addCustomer(user,customer);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }catch (Exception e){
                res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                e.printStackTrace();
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showDrivers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            List<Driver> drivers = userService.getAllDrivers();
            req.setAttribute("drivers",drivers);
            req.getRequestDispatcher("/WEB-INF/view/user/admin/driver/a_driverList.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showAddDrivers (HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/driver/a_addNewDriver.jsp").forward(req, res);
        }catch (NullPointerException | IOException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void addDrivers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            String firstName = req.getParameter("first_name");
            String lastName = req.getParameter("last_name");
            String nic = req.getParameter("nic");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String licenseNumber = req.getParameter("license_number");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String drivingExperience = req.getParameter("driving_experience");
            User user = new User(firstName,lastName,nic,email,password,phone,gender,3);
            Driver driver = new Driver(licenseNumber,Integer.parseInt(drivingExperience));
            try {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!",false,null);
                Driver driverData = new Gson().fromJson(getDataMapper().mapData(req), Driver.class);
                response = userService.addDriver(user,driver);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }catch (Exception e){
                res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                e.printStackTrace();
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showStaff(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            List<Staff> staff = userService.getAllStaff();
            req.setAttribute("staff",staff);
            req.getRequestDispatcher("/WEB-INF/view/user/admin/staff/a_staffList.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showAddStaff (HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/staff/a_addNewStaffMember.jsp").forward(req, res);
        }catch (NullPointerException | IOException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void addStaff(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            String firstName = req.getParameter("first_name");
            String lastName = req.getParameter("last_name");
            String nic = req.getParameter("nic");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String jobTitle = req.getParameter("job_title");
            User user = new User(firstName,lastName,nic,email,password,phone,gender,2);
            Staff staff = new Staff(jobTitle);
            try {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!",false,null);
                Staff staffData = new Gson().fromJson(getDataMapper().mapData(req), Staff.class);
                response = userService.addStaff(user,staff);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }catch (Exception e){
                res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                e.printStackTrace();
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showVehicles(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            List<Vehicle> vehicles = vehicleService.getAllVehicles();
            req.setAttribute("vehicles",vehicles);
            req.getRequestDispatcher("/WEB-INF/view/user/admin/vehicle/a_vehicleList.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showAddVehicle (HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/vehicle/a_addNewVehicle.jsp").forward(req, res);
        }catch (NullPointerException | IOException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void addVehicle(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            String vin = req.getParameter("vin");
            String model = req.getParameter("model");
            String make = req.getParameter("make");
            int year = Integer.parseInt(req.getParameter("year"));
            String registrationNumber = req.getParameter("registration_number");
            String vehicleType = req.getParameter("vehicle_type");
            int noOfSeats = Integer.parseInt(req.getParameter("no_of_seats"));
            int meterReading = Integer.parseInt(req.getParameter("current_meter_reading"));
            double baseFare = Double.parseDouble(req.getParameter("base_fare"));
            double pricePerDay = Double.parseDouble(req.getParameter("price_per_day"));
            double pricePerKm = Double.parseDouble(req.getParameter("price_per_km"));
            double pricePerExtraKm = Double.parseDouble(req.getParameter("price_per_extra_km"));
            double pricePerExtraHour = Double.parseDouble(req.getParameter("price_per_extra_hour"));
            String status = req.getParameter("status");
            System.out.println("VIN: " + vin + ", Model: " + model + ", Make: " + make + ", Year: " + year + ", Registration Number: " + registrationNumber + ", Vehicle Type: " + vehicleType + ", No. of Seats: " + noOfSeats + ", Meter Reading: " + meterReading + ", Price Per Day: " + pricePerDay + ", Price Per Km: " + pricePerKm + ", Price Per Extra Km: " + pricePerExtraKm + ", Price Per Extra Hour: " + pricePerExtraHour + ", Status: " + status);
            Vehicle vehicle =new Vehicle(vin,model,make,year,registrationNumber,vehicleType,noOfSeats,meterReading,baseFare,pricePerDay,pricePerKm,pricePerExtraKm,pricePerExtraHour,status);

            try {
                // Handling file upload
                List<Part> fileParts = req.getParts().stream()
                        .filter(part -> "vehicle_images".equals(part.getName()) && part.getSize() > 0)
                        .collect(Collectors.toList());

                List<String> imagePaths = new ArrayList<>();
                for (Part filePart : fileParts) {
                    System.out.println(filePart);
                    String fileName = System.currentTimeMillis() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadPath = getServletContext().getRealPath("") + "uploads" + File.separator + fileName;

                    File uploadDir = new File(getServletContext().getRealPath("") + "uploads");
                    if (!uploadDir.exists()) uploadDir.mkdirs();

                    filePart.write(uploadPath);
                    imagePaths.add("uploads/" + fileName);
                }
                CommonResponseModel response = new CommonResponseModel("Something went wrong!",false,null);
                response = vehicleService.addVehicle(vehicle,imagePaths);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }catch (Exception e){
                res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                e.printStackTrace();
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void addBooking(HttpServletRequest req, HttpServletResponse res) throws IOException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            String userId = req.getParameter("user_id");
            String vehicleId = req.getParameter("vehicle_id");

            String startDate = req.getParameter("start_date");
            String endDate = req.getParameter("end_date");
            int noOfDays = Integer.parseInt(req.getParameter("no_of_days"));
            String pricePerDay = req.getParameter("price_per_day");
            String isLicenseVerified = req.getParameter("is_license_verified");
            String isUtilityBillVerified = req.getParameter("is_utility_bill_verified");
            String startMeterReading = req.getParameter("current_meter_reading");
            int endMeterReading = 0;
            double totalPrice = Double.parseDouble(req.getParameter("total_price"));
            String bookingStatus = "pending";

            //System.out.println(userId+" "+vehicleId+" "+startDate+" "+" "+endDate+" "+noOfDays+" "+pricePerDay+" "+isLicenseVerified+" "+isUtilityBillVerified+" "+startMeterReading+" "+endMeterReading+" "+totalPrice);

            //Booking booking = new Booking(Integer.parseInt(userId),Integer.parseInt(vehicleId),startDate,endDate,noOfDays,isLicenseVerified,isUtilityBillVerified,Integer.parseInt(startMeterReading),endMeterReading,totalPrice,bookingStatus);

            try {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!",false,null);
                Booking bookingData = new Gson().fromJson(getDataMapper().mapData(req), Booking.class);
                //response = bookingService.addBooking(booking);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            } catch (TextFormat.ParseException e){
                e.printStackTrace();
            } catch (Exception e){
                res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                e.printStackTrace();
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void deleteUser(HttpServletRequest req, HttpServletResponse res){
        try{
            int userId = Integer.parseInt(req.getParameter("id"));

            //boolean isDeleted = userService.deleteCustomer(userId); // Implement this in your service

            res.setContentType("application/json");
            res.getWriter().write(new Gson().toJson(Collections.singletonMap("success", true)));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    private void deleteVehicle(HttpServletRequest req, HttpServletResponse res){
        try{
            int vehicleId = Integer.parseInt(req.getParameter("id"));

            //boolean isDeleted = userService.deleteCustomer(userId); // Implement this in your service

            res.setContentType("application/json");
            res.getWriter().write(new Gson().toJson(Collections.singletonMap("success", true)));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
