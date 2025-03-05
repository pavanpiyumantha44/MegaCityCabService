package com.cab.mega.dao;

import com.cab.mega.model.Booking;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDaoImpl implements BookingDao{
    @Override
    public boolean createBooking(Booking booking) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO booking (customer_id,driver_id, vehicle_id, pickup_location,destination, pickup_lat, pickup_lon,destination_lat,destination_lon, special_note, start_meter_reading, end_meter_reading, distance_km, base_fare, price_per_km, waiting_price, total_fare,discount_price,pickup_dttm,dropoff_dttm, status, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,booking.getCustomerId());
            statement.setInt(2,booking.getDriverId());
            statement.setInt(3,booking.getVehicleId());
            statement.setString(4,booking.getPickupLocation());
            statement.setString(5,booking.getDestination());
            statement.setString(6,booking.getPickupLat());
            statement.setString(7,booking.getPickupLon());
            statement.setString(8,booking.getDestinationLat());
            statement.setString(9,booking.getDestinationLon());
            statement.setString(10,booking.getSpecialNote());
            statement.setDouble(11,booking.getStartMeterReading());
            statement.setDouble(12,booking.getEndMeterReading());
            statement.setDouble(13,booking.getDistanceKm());
            statement.setDouble(14,booking.getBaseFare());
            statement.setDouble(15,booking.getPricePerKm());
            statement.setDouble(16,booking.getWaitingPrice());
            statement.setDouble(17,booking.getTotalPrice());
            statement.setDouble(18,booking.getDiscountPrice());
            statement.setString(19,booking.getPickupDateTime());
            statement.setString(20,booking.getStatus());
            statement.setString(21,booking.getPaymentStatus());
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
