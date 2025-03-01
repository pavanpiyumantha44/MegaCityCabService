package com.cab.mega.Service;

import com.cab.mega.dao.BookingDao;
import com.cab.mega.dao.BookingDaoImpl;
import com.cab.mega.model.Booking;
import com.cab.mega.model.CommonResponseModel;
import com.cab.mega.model.Vehicle;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;


public class BookingService {
    private static BookingService bookingService;
    BookingDao bookingDao;
    private BookingService(){
        this.bookingDao = new BookingDaoImpl();
    }
    public static BookingService getInstance() {
        if (bookingService == null) {
            synchronized (BookingService.class) {
                if (bookingService == null) {
                    bookingService = new BookingService();
                }
            }
        }
        return bookingService;
    }
    public CommonResponseModel addBooking(Booking booking){
        Connection connection = null;
        if (booking.getUserId()<=0) {
            return new CommonResponseModel("Invalid User Id", false, null);
        } else if (booking.getVehicleId()<=0) {
            return new CommonResponseModel("Invalid Vehicle Id", false, null);
        } else if (booking.getStartDate() == null) {
            return new CommonResponseModel("Invalid Start Date", false, null);
        } else if (booking.getEndDate() == null) {
            return new CommonResponseModel("Invalid End Date", false, null);
        } else if (booking.getStartMeterReading()<0) {
            return new CommonResponseModel("Invalid Start Meter Reading", false, null);
        } else if (booking.getTotalPrice()<0) {
            return new CommonResponseModel("Invalid Total Price", false, null);
        } else {
            try {
                connection = DBConnectionFactory.getConnection();
                boolean isBookingCreated = bookingDao.addBooking(booking);
                return new CommonResponseModel("Booking Created Successfully!", true, null);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return new CommonResponseModel("Something went wrong!", false, null);
        }
    }
    public List<Booking> getBookings() {
        return bookingDao.getAllBookings();
    }
}
