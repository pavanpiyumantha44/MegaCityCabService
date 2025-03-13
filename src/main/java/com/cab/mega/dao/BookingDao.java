package com.cab.mega.dao;

import com.cab.mega.model.Booking;

import java.awt.print.Book;
import java.util.List;

public interface BookingDao {
    public boolean createBooking(Booking booking);
    public Booking getBooking(int id);
    public boolean updateBooking(Booking booking);
    public List<Booking> getAllBookings();
    public List<Booking> getAssignedBookingByDriverId(int driverId);
    public boolean updateRide(Booking booking);
    public boolean updateRideCompleted(Booking booking);
    public boolean updateRideClosed(Booking booking);
}
