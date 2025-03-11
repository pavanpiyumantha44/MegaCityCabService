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
}
