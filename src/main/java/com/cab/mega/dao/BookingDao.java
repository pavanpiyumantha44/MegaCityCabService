package com.cab.mega.dao;

import com.cab.mega.model.Booking;

import java.util.List;

public interface BookingDao {
    public boolean createBooking(Booking booking);
    public Booking getBooking(int id);
    public boolean updateBooking(Booking booking);
    public List<Booking> getAllBookings();
}
