package com.cab.mega.dao;

import com.cab.mega.model.Booking;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BookingDaoImpl implements BookingDao{
    @Override
    public boolean addBooking(Booking booking) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO booking (user_id, vehicle_id, start_date, end_date, no_of_days,is_license_verified,is_utility_bill_verified, start_meter_reading, end_meter_reading, total_price, booking_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,booking.getUserId());
            statement.setInt(2,booking.getVehicleId());
            statement.setString(3,booking.getStartDate());
            statement.setString(4,booking.getEndDate());
            statement.setInt(5,booking.getNoOfDays());
            statement.setString(6,booking.getIsLicenseVerified());
            statement.setString(7,booking.getIsUtilityBillVerified());
            statement.setInt(8,booking.getStartMeterReading());
            statement.setInt(9,booking.getEndMeterReading());
            statement.setDouble(10,booking.getTotalPrice());
            statement.setString(11,booking.getBookingStatus());
            statement.executeUpdate();
            return true;
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean updateBooking(Booking booking) {
        return false;
    }

    @Override
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        return bookings;
    }
}
