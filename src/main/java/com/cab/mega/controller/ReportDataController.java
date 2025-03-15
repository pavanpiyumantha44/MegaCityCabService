package com.cab.mega.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cab.mega.Service.BookingService;
import com.cab.mega.Service.UserService;
import com.cab.mega.Service.VehicleService;
import com.cab.mega.model.Booking;
import com.cab.mega.model.Customer;
import com.cab.mega.model.Vehicle;
import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.pdf.*;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.*;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;

import com.itextpdf.layout.property.UnitValue;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/report/*")
public class ReportDataController extends HttpServlet {
    UserService userService;
    VehicleService vehicleService;
    BookingService bookingService;

    public void init() throws ServletException {
        userService = UserService.getInstance();
        vehicleService = VehicleService.getInstance();
        bookingService = BookingService.getInstance();
    }
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null){
            res.sendRedirect(req.getContextPath()+"/");
        }
        assert action != null;
        if (action.equals("pdf/bookings")){
            downloadPDF(req,res);
        }else if (action.equals("excel/bookings")){
            //downloadExcel(req,res);
        }else if(action.equals("pdf/booking")){
            String id =  req.getParameter("id");
            downloadBookingInvoicePDF(req,res,Integer.parseInt(id));
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {

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

            table.addCell(new Cell().add(new Paragraph(String.valueOf(booking.getBookingId()))));
            table.addCell(new Cell().add(new Paragraph(String.valueOf(booking.getPickupLocation()))));
            table.addCell(new Cell().add(new Paragraph(String.valueOf(booking.getDestination()))));

            document.add(table);
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
            res.reset();
            res.setContentType("text/plain");
            res.getWriter().write("Error generating PDF: " + e.getMessage());
        }
    }
    private void downloadBookingInvoicePDF(HttpServletRequest req, HttpServletResponse res, int id) throws IOException {
        Booking booking = bookingService.getBooking(id);
        Customer customer = userService.getCustomer(booking.getCustomerId());
        res.setContentType("application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=booking_invoice_BK"+booking.getBookingId()+""+booking.getDropOffDateTime()+".pdf");


        try (OutputStream out = res.getOutputStream()) {
            PdfWriter writer = new PdfWriter(out);
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            // Add Header
            Paragraph header = new Paragraph("MegaCity Cabs Service")
                    .setBold()
                    .setFontSize(24)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontColor(ColorConstants.BLUE);
            document.add(header);

            Paragraph subHeader = new Paragraph("Invoice/Bill")
                    .setFontSize(16)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontColor(ColorConstants.WHITE);
            document.add(subHeader);

            // Add Invoice Details Section
            Paragraph invoiceDetailsHeader = new Paragraph("Booking Details")
                    .setBold()
                    .setFontSize(20)
                    .setTextAlignment(TextAlignment.LEFT)
                    .setFontColor(ColorConstants.BLACK);
            document.add(invoiceDetailsHeader);

            Table invoiceDetailsTable = new Table(new float[]{2, 4});
            invoiceDetailsTable.setWidth(UnitValue.createPercentValue(100));

            // Add Invoice Details Rows
            addRowToTable(invoiceDetailsTable, "Invoice Number:", "BK-0000"+booking.getBookingId());
            addRowToTable(invoiceDetailsTable, "Date:", booking.getDropOffDateTime());
            addRowToTable(invoiceDetailsTable, "Distance:", String.format("%.2f", booking.getDistanceKm())+" KM");
            addRowToTable(invoiceDetailsTable, "Base Fare:", String.format("%.2f", booking.getBaseFare())+" LKR");
            addRowToTable(invoiceDetailsTable, "Price Per Km:", String.format("%.2f", booking.getPricePerKm())+" LKR");
            addRowToTable(invoiceDetailsTable, "Ride Cost:", String.format("%.2f", (booking.getTotalPrice()+booking.getDiscountPrice()))+" LKR");
            addRowToTable(invoiceDetailsTable, "Discount(5%):", String.format("%.2f", booking.getDiscountPrice())+" LKR");
            addRowToTable(invoiceDetailsTable, "Total Amount:", String.format("%.2f", booking.getTotalPrice())+" LKR");

            document.add(invoiceDetailsTable);

            // Add Billing Information Section
            Paragraph billingInfoHeader = new Paragraph("Payment Information")
                    .setBold()
                    .setFontSize(20)
                    .setTextAlignment(TextAlignment.LEFT)
                    .setFontColor(ColorConstants.BLACK);
            document.add(billingInfoHeader);

            Table billingInfoTable = new Table(new float[]{2, 4});
            billingInfoTable.setWidth(UnitValue.createPercentValue(100));

            // Add Billing Information Rows
            addRowToTable(billingInfoTable, "Name:", customer.getFirstName());
            addRowToTable(billingInfoTable, "Email:", customer.getEmail());
            addRowToTable(billingInfoTable, "Address:", customer.getAddress());
            addRowToTable(billingInfoTable, "Paid Amount:", String.format("%.2f", booking.getTotalPrice())+" LKR");
            addRowToTable(billingInfoTable, "Payment Method:", booking.getPaymentMethod().toUpperCase());
            addRowToTable(billingInfoTable, "Payment Status:", booking.getPaymentStatus().toUpperCase());

            document.add(billingInfoTable);

            // Add Footer
            Paragraph footer = new Paragraph("Thank you for choosing our services. If you have any questions, please contact us at megacity.cabs.sys@gmail.com")
                    .setFontSize(14)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontColor(ColorConstants.DARK_GRAY);
            document.add(footer);

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
            res.reset();
            res.setContentType("text/plain");
            res.getWriter().write("Error generating PDF: " + e.getMessage());
        }
    }

    // Helper method to add rows to a table
    private void addRowToTable(Table table, String label, String value) {
        table.addCell(new Cell().add(new Paragraph(label).setBold()));
        table.addCell(new Cell().add(new Paragraph(value)));
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
