package com.cab.mega.controller;

import com.cab.mega.Service.BookingService;
import com.cab.mega.Service.UserService;
import com.cab.mega.Service.VehicleService;
import com.cab.mega.model.*;
import com.cab.mega.utils.mail.SendEmail;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;

import com.itextpdf.layout.property.UnitValue;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import static com.cab.mega.utils.datamapper.DataMapper.getDataMapper;

@WebServlet("/booking/*")
public class BookingDataController extends HttpServlet {

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
        if (action.equals("list")){
            showRides(req,res);
        }else if (action.equals("add")){
            showAddRides(req,res);
        }else if (action.equals("edit")){
            String id = req.getParameter("id");
            showEditBooking(req,res,id);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null){
            res.sendRedirect(req.getContextPath()+"/");
        }
        assert action != null;
        if (action.equals("list")){
            //showRides(req,res);
        }else if (action.equals("add")){
            createBooking(req,res);
        }else if (action.equals("update/driver")){
            String id = req.getParameter("id");
            updateBookingByDriver(req,res,id);
        }
    }
    private void showRides(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId == 1) {
                List<Booking> bookings = bookingService.getBookings();
                req.setAttribute("bookings",bookings);
                req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_availableBookings.jsp").forward(req, res);
            }else if(roleId == 2){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if(roleId == 3){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            }else if(roleId == 4){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else{
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
    private void showAddRides(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId == 1) {
                try{
                    List<Customer> customers = userService.getAllCustomers();
                    List<Vehicle> vehicles = vehicleService.getAllAvailableVehicles();
                    List<Driver> drivers = userService.getAllDrivers();
                    req.setAttribute("customers",customers);
                    req.setAttribute("vehicles",vehicles);
                    req.setAttribute("drivers",drivers);
                    SendEmail email = SendEmail.getEmailSender();
                    email.generateEmail("pavanpiyumantha222@gmail.com","Test Email","Test Message");
                    req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_addNewBooking.jsp").forward(req, res);
                }catch (NullPointerException | SQLException e){
                    res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                }
            }else if(roleId == 2){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if(roleId == 3){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            }else if(roleId == 4){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else{
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
    private void showEditBooking(HttpServletRequest req, HttpServletResponse res,String id) throws ServletException, IOException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId == 1) {
                Booking booking = bookingService.getBooking(Integer.parseInt(id));
                Customer customer = userService.getCustomer(booking.getCustomerId());
                Driver driver = userService.getDriver(booking.getDriverId());
                Vehicle vehicle = vehicleService.getVehicle(booking.getVehicleId());
                req.setAttribute("booking",booking);
                req.setAttribute("customer",customer);
                req.setAttribute("driver",driver);
                req.setAttribute("vehicle",vehicle);

                req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_editBooking.jsp").forward(req, res);
            }else if(roleId == 2){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if(roleId == 3){
                Booking booking = bookingService.getBooking(Integer.parseInt(id));
                Customer customer = userService.getCustomer(booking.getCustomerId());
                req.setAttribute("booking",booking);
                req.setAttribute("customer",customer);
                req.getRequestDispatcher("/WEB-INF/view/user/driver/d_updateRide.jsp").forward(req, res);
            }else if(roleId == 4){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else{
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
    private void createBooking(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");

            if (roleId == 1) {

                double endMeterReading = 0;
                double distanceKm = 0;
                double waitingPrice = 0;
                double totalPrice = 0;
                double discountPrice = 0;
                String customerId = req.getParameter("customer_id");
                String driverId = req.getParameter("driver_id");
                String vehicleId = req.getParameter("vehicle_id");
                String pickupLocation = req.getParameter("pickup_location");
                String destination = req.getParameter("destination");
                String specialNote = req.getParameter("special_note");
                String startMeterReading = req.getParameter("current_meter_reading");
                String baseFare = req.getParameter("base_fare");
                String pricePerKm = req.getParameter("price_per_km");
                String pickupDateTime = req.getParameter("pickup_dttm");
                String status = "assigned";
                String paymentStatus = "pending";

                double [] pickupCoordinates = getCoordinates(pickupLocation);
                double pickupLat = pickupCoordinates[0];
                double pickupLon = pickupCoordinates[1];
                double [] destinationCoordinates = getCoordinates(destination);
                double destinationLat = destinationCoordinates[0];
                double destinationLon = destinationCoordinates[1];
                //System.out.println("CustomerId:"+ customerId + " Driver ID :" + driverId + " Vehicle Id " + vehicleId + " Pickup Location " + pickupLocation + " Destination " + destination + " PickupLat " + pickupLat + " PickupLon " + pickupLon + " Destination lat " + destinationLat + " Destination Lon " + destinationLon + " Special Note " + specialNote + " Start Meter Reading " + startMeterReading +" EndMeterReading "+ endMeterReading +" BaseFare " + baseFare + " Price Per KM " + pricePerKm + " Pickup Date Time " + pickupDateTime + " Status " + status + " Payment Status " + paymentStatus);

                Booking booking = new Booking(Integer.parseInt(customerId), Integer.parseInt(driverId), Integer.parseInt(vehicleId), pickupLocation, destination, String.valueOf(pickupLat),String.valueOf(pickupLon), String.valueOf(destinationLat), String.valueOf(destinationLon), specialNote, Double.parseDouble(startMeterReading), endMeterReading, distanceKm, Double.parseDouble(baseFare), Double.parseDouble(pricePerKm), waitingPrice, totalPrice, discountPrice, pickupDateTime, status, paymentStatus);

                try {
                    CommonResponseModel response = new CommonResponseModel("Something went wrong!", false, null);
                    response = bookingService.addBooking(booking);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                } catch (NullPointerException e) {
                    CommonResponseModel response = new CommonResponseModel("Something went wrong!", false, null);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                }
            } else if (roleId == 2) {
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if (roleId == 3) {
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if (roleId == 4) {
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            }
        } catch (NullPointerException e) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }

    private static double[] getCoordinates(String destinationValue) {
        try {
            String urlString = "https://nominatim.openstreetmap.org/search?q=" + destinationValue + "+Lanka&format=json";
            URL url = new URL(urlString);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("User-Agent", "Mozilla/5.0");

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                System.out.println("Network response was not ok");
                return new double[]{0.0, 0.0}; // Return default values if request fails
            }

            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String inputLine;

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            Gson gson = new Gson();
            JsonObject[] locations = gson.fromJson(response.toString(), JsonObject[].class);

            if (locations.length > 0) {
                JsonObject location = locations[0];
                double lat = location.get("lat").getAsDouble();
                double lon = location.get("lon").getAsDouble();

                //System.out.println("Latitude: " + lat + ", Longitude: " + lon);

                return new double[]{lat, lon};
            } else {
                System.out.println("Location not found.");
                return new double[]{0.0, 0.0};
            }

        } catch (Exception e) {
            System.out.println("There was a problem with the fetch operation: " + e.getMessage());
            return new double[]{0.0, 0.0};
        }
    }

    private void updateBooking(HttpServletRequest req, HttpServletResponse res, String id) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");

            if (roleId == 1) {

                double endMeterReading = 0;
                double distanceKm = 0;
                double waitingPrice = 0;
                double totalPrice = 0;
                double discountPrice = 0;
                String customerId = req.getParameter("customer_id");
                String driverId = req.getParameter("driver_id");
                String vehicleId = req.getParameter("vehicle_id");
                String pickupLocation = req.getParameter("pickup_location");
                String destination = req.getParameter("destination");
                String specialNote = req.getParameter("special_note");
                String startMeterReading = req.getParameter("current_meter_reading");
                String baseFare = req.getParameter("base_fare");
                String pricePerKm = req.getParameter("price_per_km");
                String pickupDateTime = req.getParameter("pickup_dttm");
                String status = "assigned";
                String paymentStatus = "pending";

                double [] pickupCoordinates = getCoordinates(pickupLocation);
                double pickupLat = pickupCoordinates[0];
                double pickupLon = pickupCoordinates[1];
                double [] destinationCoordinates = getCoordinates(destination);
                double destinationLat = destinationCoordinates[0];
                double destinationLon = destinationCoordinates[1];
                //System.out.println("CustomerId:"+ customerId + " Driver ID :" + driverId + " Vehicle Id " + vehicleId + " Pickup Location " + pickupLocation + " Destination " + destination + " PickupLat " + pickupLat + " PickupLon " + pickupLon + " Destination lat " + destinationLat + " Destination Lon " + destinationLon + " Special Note " + specialNote + " Start Meter Reading " + startMeterReading +" EndMeterReading "+ endMeterReading +" BaseFare " + baseFare + " Price Per KM " + pricePerKm + " Pickup Date Time " + pickupDateTime + " Status " + status + " Payment Status " + paymentStatus);

                Booking booking = new Booking(Integer.parseInt(customerId), Integer.parseInt(driverId), Integer.parseInt(vehicleId), pickupLocation, destination, String.valueOf(pickupLat),String.valueOf(pickupLon), String.valueOf(destinationLat), String.valueOf(destinationLon), specialNote, Double.parseDouble(startMeterReading), endMeterReading, distanceKm, Double.parseDouble(baseFare), Double.parseDouble(pricePerKm), waitingPrice, totalPrice, discountPrice, pickupDateTime, status, paymentStatus);
                try {
                    CommonResponseModel response = new CommonResponseModel("Something went wrong!", false, null);
                    Booking bookingData = new Gson().fromJson(getDataMapper().mapData(req), Booking.class);
                    response = bookingService.addBooking(booking);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                } catch (NullPointerException e) {
                    CommonResponseModel response = new CommonResponseModel("Something went wrong!", false, null);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                }
            } else if (roleId == 2) {
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if (roleId == 4) {
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
            }
        } catch (NullPointerException e) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }

    private void updateBookingByDriver(HttpServletRequest req, HttpServletResponse res, String id) throws IOException, ServletException
    {
        HttpSession session = req.getSession();
        int roleId = (int) session.getAttribute("role_id");

        if (roleId != 3) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
        String status = req.getParameter("status");
        if("assigned".equals(status) || "ongoing".equals(status)|| "arrived".equals(status)){

            Booking updatingRideStatus = new Booking(Integer.parseInt(id),status);
            try {
                CommonResponseModel updateResponse = bookingService.updateRideDetails(updatingRideStatus);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(updateResponse));
            } catch (NullPointerException e) {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!", false, null);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }
        }
        if ("completed".equals(status)) {
            String getStartMeterReading = req.getParameter("start_meter_reading");
            String getEndMeterReading = req.getParameter("end_meter_reading");
            String getPricePerKm = req.getParameter("price_per_km");
            String getBaseFare = req.getParameter("base_fare");
            String dropOffDttm = "";

            if (getStartMeterReading == null || getEndMeterReading == null || getStartMeterReading.isEmpty() || getEndMeterReading.isEmpty()) {
                CommonResponseModel response = new CommonResponseModel("Start and End meter readings are required!", false, null);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
                return;
            }

            if (getPricePerKm == null || getBaseFare == null || getPricePerKm.isEmpty() || getBaseFare.isEmpty()) {
                CommonResponseModel response = new CommonResponseModel("Price per km and base fare are required!", false, null);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
                return;
            }

            try {
                double pricePerKm = Double.parseDouble(getPricePerKm);
                double baseFare = Double.parseDouble(getBaseFare);
                double startMeterReading = Double.parseDouble(getStartMeterReading);
                double endMeterReading = Double.parseDouble(getEndMeterReading);

                if (endMeterReading <= startMeterReading) {
                    CommonResponseModel response = new CommonResponseModel("End meter reading cannot be less than or equal start meter reading!", false, null);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                    return;
                }

                double distanceKm = endMeterReading - startMeterReading;
                double rideCost = calculatePayment(pricePerKm, baseFare, distanceKm);
                double discountPrice = (rideCost * 0.05);
                double totalPrice = rideCost-discountPrice;

                Booking updatingCompletedBooking = new Booking(Integer.parseInt(id), distanceKm, endMeterReading, dropOffDttm, discountPrice, totalPrice, status);

                CommonResponseModel completedResponse = bookingService.updateRideCompleted(updatingCompletedBooking);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(completedResponse));
            } catch (NumberFormatException e) {
                // Handle invalid number format for any of the parameters
                CommonResponseModel response = new CommonResponseModel("Invalid input! Please ensure all fields are valid numbers.", false, null);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
                return;
            }
        }
        if("closed".equals(status)){
            String paymentStatus = "pending";
            String paymentMethod = "cash";
            String paid = req.getParameter("paid");
            if (paid == null || paid.isEmpty()) {
                CommonResponseModel response = new CommonResponseModel("Please Verify the collected payment!", false, null);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
                return;
            }
            if ("on".equals(paid)){
                paymentStatus = "paid";
            }
            Booking updatingClosedBooking = new Booking(Integer.parseInt(id),paymentMethod, paymentStatus,status);
            try {
                CommonResponseModel updateResponse = bookingService.updateRideClosed(updatingClosedBooking);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(updateResponse));
            } catch (NullPointerException e) {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!", false, null);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }
        }
    }
    private double calculatePayment(double pricePerKm, double baseFare, double distanceKm){
        double rideCost = baseFare+(pricePerKm*distanceKm);
        return rideCost;
    }
}
