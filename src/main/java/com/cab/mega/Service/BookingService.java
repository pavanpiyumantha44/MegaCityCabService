package com.cab.mega.Service;

import com.cab.mega.dao.BookingDao;
import com.cab.mega.dao.BookingDaoImpl;
import com.cab.mega.model.Booking;
import com.cab.mega.model.CommonResponseModel;
import com.cab.mega.model.Vehicle;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;


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
        if (booking.getCustomerId()<=0) {
            return new CommonResponseModel("Invalid User Id", false, null);
        } else if (booking.getVehicleId()<=0) {
            return new CommonResponseModel("Invalid Vehicle Id", false, null);
        } else if (booking.getDriverId()<=0) {
            return new CommonResponseModel("Invalid Driver Id", false, null);
        }else if (booking.getPickupLocation() == null) {
            return new CommonResponseModel("Invalid Pickup Location", false, null);
        }else if (booking.getDestination() == null) {
            return new CommonResponseModel("Invalid Destination", false, null);
        } else if (booking.getPickupDateTime() == null) {
            return new CommonResponseModel("Invalid Pickup Date Time", false, null);
        } else if (booking.getStartMeterReading()<0) {
            return new CommonResponseModel("Invalid Start Meter Reading", false, null);
        } else {
            try {
                connection = DBConnectionFactory.getConnection();
                boolean isBookingCreated = bookingDao.createBooking(booking);
                if(isBookingCreated){
                    return new CommonResponseModel("Booking Created Successfully!", true, null);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return new CommonResponseModel("Something went wrong!", false, null);
        }
    }
    public List<Booking> getBookings() {
        return bookingDao.getAllBookings();
    }
    public Booking getBooking(int id){
        return bookingDao.getBooking(id);
    }
    public List<Booking> getAssignedBookingByDriverId(int id){return bookingDao.getAssignedBookingByDriverId(id);}

    public CommonResponseModel updateRideDetails(Booking booking){
        Map<String, Object> responseData = new HashMap<>();
        if(booking.getStatus().equals("assigned")){
            responseData.put("assigned",booking.getStatus());
        }
        if(booking.getStatus().equals("ongoing")){
            responseData.put("status",booking.getStatus());
        }
        if(booking.getStatus().equals("arrived")){
            responseData.put("status",booking.getStatus());
        }
        try{
            boolean isRideUpdated = bookingDao.updateRide(booking);
            if(isRideUpdated){
                return new CommonResponseModel("Status Updated Successfully!", true,responseData);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return new CommonResponseModel("Something went wrong!", false, null);
    }
    public CommonResponseModel updateRideCompleted(Booking booking){
        Map<String, Object> responseData = new HashMap<>();
        if(booking.getStatus().equals("completed")){
            responseData.put("status",booking.getStatus());
            responseData.put("distanceKm",booking.getDistanceKm());
            responseData.put("discountPrice",booking.getDiscountPrice());
            responseData.put("totalPrice",booking.getTotalPrice());
        }
        try{
            boolean isRideUpdated = bookingDao.updateRideCompleted(booking);
            if(isRideUpdated){
                return new CommonResponseModel("Status Updated Successfully!", true,responseData);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return new CommonResponseModel("Something went wrong!", false, null);
    }
    public CommonResponseModel updateRideClosed(Booking booking){
        Map<String, Object> responseData = new HashMap<>();
        if(booking.getStatus().equals("closed")){
            responseData.put("status",booking.getStatus());
            responseData.put("paymentStatus",booking.getPaymentStatus());
        }
        try{
            boolean isRideUpdated = bookingDao.updateRideClosed(booking);
            if(isRideUpdated){
                return new CommonResponseModel("Status Updated Successfully!", true,responseData);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return new CommonResponseModel("Something went wrong!", false, null);
    }
}
