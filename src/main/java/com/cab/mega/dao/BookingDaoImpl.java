package com.cab.mega.dao;

import com.cab.mega.model.Booking;
import com.cab.mega.model.Driver;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDaoImpl implements BookingDao{
    @Override
    public boolean createBooking(Booking booking) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO booking (customer_id,driver_id, vehicle_id, pickup_location,destination, pickup_lat, pickup_lon,destination_lat,destination_lon, special_note, start_meter_reading, end_meter_reading, distance_km, base_fare, price_per_km, waiting_price, total_fare,discount_price,pickup_dttm, status, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
    public Booking getBooking(int id) {
        Booking booking = null;
        Connection connection = DBConnectionFactory.getConnection();
        String query = "SELECT * FROM booking where booking_id=?";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                booking = new Booking(
                        resultSet.getInt("booking_id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getInt("driver_id"),
                        resultSet.getInt("vehicle_id"),
                        resultSet.getString("pickup_location"),
                        resultSet.getString("destination"),
                        resultSet.getString("pickup_lat"),
                        resultSet.getString("pickup_lon"),
                        resultSet.getString("destination_lat"),
                        resultSet.getString("destination_lon"),
                        resultSet.getString("special_note"),
                        resultSet.getDouble("start_meter_reading"),
                        resultSet.getDouble("end_meter_reading"),
                        resultSet.getDouble("distance_km"),
                        resultSet.getDouble("base_fare"),
                        resultSet.getDouble("price_per_km"),
                        resultSet.getDouble("waiting_price"),
                        resultSet.getDouble("total_fare"),
                        resultSet.getDouble("discount_price"),
                        resultSet.getDouble("cancellation_price"),
                        resultSet.getString("booking_time"),
                        resultSet.getString("pickup_dttm"),
                        resultSet.getString("dropoff_dttm"),
                        resultSet.getString("status"),
                        resultSet.getString("payment_status"),
                        resultSet.getString("payment_method"),
                        resultSet.getString("cancelled_by")
                );
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return booking;
    }

    @Override
    public boolean updateBooking(Booking booking) {
        return false;
    }

    @Override
    public List<Booking> getAllBookings() {
        Connection connection = DBConnectionFactory.getConnection();
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM booking";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                bookings.add(new Booking(
                        resultSet.getInt("booking_id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getInt("driver_id"),
                        resultSet.getInt("vehicle_id"),
                        resultSet.getString("pickup_location"),
                        resultSet.getString("destination"),
                        resultSet.getString("pickup_lat"),
                        resultSet.getString("pickup_lon"),
                        resultSet.getString("destination_lat"),
                        resultSet.getString("destination_lon"),
                        resultSet.getString("special_note"),
                        resultSet.getDouble("start_meter_reading"),
                        resultSet.getDouble("end_meter_reading"),
                        resultSet.getDouble("distance_km"),
                        resultSet.getDouble("base_fare"),
                        resultSet.getDouble("price_per_km"),
                        resultSet.getDouble("waiting_price"),
                        resultSet.getDouble("total_fare"),
                        resultSet.getDouble("discount_price"),
                        resultSet.getDouble("cancellation_price"),
                        resultSet.getString("booking_time"),
                        resultSet.getString("pickup_dttm"),
                        resultSet.getString("dropoff_dttm"),
                        resultSet.getString("status"),
                        resultSet.getString("payment_status"),
                        resultSet.getString("payment_method"),
                        resultSet.getString("cancelled_by")
                ));
            }
            System.out.println(bookings);
        }catch (SQLException e){
            e.printStackTrace();
        }
        return bookings;
    }

    @Override
    public List<Booking> getAssignedBookingByDriverId(int driverId) {
        Connection connection = DBConnectionFactory.getConnection();
        List<Booking> rides = new ArrayList<>();
        String query = "SELECT * FROM booking WHERE driver_id=? and status!='closed'";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,driverId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                rides.add(new Booking(
                        resultSet.getInt("booking_id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getInt("driver_id"),
                        resultSet.getInt("vehicle_id"),
                        resultSet.getString("pickup_location"),
                        resultSet.getString("destination"),
                        resultSet.getString("pickup_lat"),
                        resultSet.getString("pickup_lon"),
                        resultSet.getString("destination_lat"),
                        resultSet.getString("destination_lon"),
                        resultSet.getString("special_note"),
                        resultSet.getDouble("start_meter_reading"),
                        resultSet.getDouble("end_meter_reading"),
                        resultSet.getDouble("distance_km"),
                        resultSet.getDouble("base_fare"),
                        resultSet.getDouble("price_per_km"),
                        resultSet.getDouble("waiting_price"),
                        resultSet.getDouble("total_fare"),
                        resultSet.getDouble("discount_price"),
                        resultSet.getDouble("cancellation_price"),
                        resultSet.getString("booking_time"),
                        resultSet.getString("pickup_dttm"),
                        resultSet.getString("dropoff_dttm"),
                        resultSet.getString("status"),
                        resultSet.getString("payment_status"),
                        resultSet.getString("payment_method"),
                        resultSet.getString("cancelled_by")
                ));
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return rides;
    }

    @Override
    public boolean updateRide(Booking booking) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "UPDATE booking SET status=? WHERE booking_id=?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,booking.getStatus());
            statement.setInt(2,booking.getBookingId());
            statement.executeUpdate();
            return true;
        }catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateRideCompleted(Booking booking) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "UPDATE booking SET distance_km=?,end_meter_reading=?, dropoff_dttm=NOW(), discount_price=?, total_fare=?,status=? WHERE booking_id=?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setDouble(1,booking.getDistanceKm());
            statement.setDouble(2,booking.getEndMeterReading());
            statement.setDouble(3,booking.getDiscountPrice());
            statement.setDouble(4,booking.getTotalPrice());
            statement.setString(5,booking.getStatus());
            statement.setInt(6,booking.getBookingId());
            statement.executeUpdate();
            return true;
        }catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateRideClosed(Booking booking) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "UPDATE booking SET payment_method=?,payment_status=?,status=? WHERE booking_id=?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,booking.getPaymentMethod());
            statement.setString(2,booking.getPaymentStatus());
            statement.setString(3,booking.getStatus());
            statement.setInt(4,booking.getBookingId());
            statement.executeUpdate();
            return true;
        }catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
