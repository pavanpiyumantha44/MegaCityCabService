package com.cab.mega.dao;

import com.cab.mega.model.Booking;

import java.util.List;

public interface BookingDao {
    public boolean addBooking(Booking booking);
    public boolean updateBooking(Booking booking);
    public List<Booking> getAllBookings();
}
