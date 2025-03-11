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
        }else if(action.equals("download/pdf")){
            downloadPDF(req,res);
        }else if(action.equals("download/excel")){
            downloadExcel(req,res);
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
            } else if (roleId == 3) {
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if (roleId == 4) {
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
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
    private void downloadPDF(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.setContentType("application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=report.pdf");

        try (OutputStream out = res.getOutputStream()) {

            PdfWriter writer = new PdfWriter(out);
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            document.add(new Paragraph("Report Dataset")
                    .setBold()
                    .setFontSize(16)
                    .setTextAlignment(TextAlignment.CENTER)
            );

            Table table = new Table(new float[]{1, 3, 3});
            table.setWidth(UnitValue.createPercentValue(100));

            // Add Table Headers
            table.addCell(new Cell().add(new Paragraph("ID").setBold()));
            table.addCell(new Cell().add(new Paragraph("Name").setBold()));
            table.addCell(new Cell().add(new Paragraph("Email").setBold()));

            Booking booking = bookingService.getBooking(1);
            // Add Sample Data
            table.addCell(new Cell().add(new Paragraph(String.valueOf(booking.getBookingId()))));
            table.addCell(new Cell().add(new Paragraph(String.valueOf(booking.getPickupLocation()))));
            table.addCell(new Cell().add(new Paragraph(String.valueOf(booking.getDestination()))));

            document.add(table);
            document.close();  // Ensure document is properly closed
        } catch (Exception e) {
            e.printStackTrace();
            res.reset();  // Reset response to prevent partial output
            res.setContentType("text/plain");
            res.getWriter().write("Error generating PDF: " + e.getMessage());
        }
    }
    private void downloadExcel(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        res.setHeader("Content-Disposition", "attachment; filename=report.xlsx");

        try (Workbook workbook = new XSSFWorkbook(); OutputStream out = res.getOutputStream()) {
            Sheet sheet = workbook.createSheet("Report");


            List<Vehicle> vehicles = vehicleService.getAllVehicles();
            Row headerRow = sheet.createRow(0);
            String[] headers = {"ID", "Name", "Email"};
            for (int i = 0; i < headers.length; i++) {
                org.apache.poi.ss.usermodel.Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                CellStyle headerStyle = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBold(true);
                headerStyle.setFont(font);
                cell.setCellStyle(headerStyle);
            }
            int rowNum = 1;

            for (Vehicle vehicle : vehicles) { // Corrected loop
                Row row = sheet.createRow(rowNum++);

                // Assuming Vehicle has methods like getId(), getModel(), getYear(), getPrice()
                row.createCell(0).setCellValue(vehicle.getVehicleId());
                row.createCell(1).setCellValue(vehicle.getModel());
                row.createCell(2).setCellValue(vehicle.getYear());
                row.createCell(3).setCellValue(vehicle.getNoOfSeats());
            }

            // Auto-size columns
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Write Excel file to response
            workbook.write(out);
        } catch (Exception e) {
            e.printStackTrace();
            res.reset();
            res.setContentType("text/plain");
            res.getWriter().write("Error generating Excel: " + e.getMessage());
        }
    }
}
