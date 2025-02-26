package com.cab.mega.dao;

import com.cab.mega.model.Vehicle;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehicleDaoImpl implements VehicleDao{
    @Override
    public int insertVehicle(Vehicle vehicle) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO vehicle (vin, model, make, year, registration_number, vehicle_type, no_of_seats, current_meter_reading, price_per_day, price_per_km, price_per_extra_km, price_per_extra_hour, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try{
            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1, vehicle.getVin());
            statement.setString(2, vehicle.getModel());
            statement.setString(3, vehicle.getMake());
            statement.setInt(4, vehicle.getYear());
            statement.setString(5, vehicle.getRegistrationNumber());
            statement.setString(6, vehicle.getVehicleType());
            statement.setInt(7, vehicle.getNoOfSeats());
            statement.setInt(8, vehicle.getCurrentMeterReading());
            statement.setDouble(9, vehicle.getPricePerDay());
            statement.setDouble(10, vehicle.getPricePerKm());
            statement.setDouble(11, vehicle.getPricePerExtraKm());
            statement.setDouble(12, vehicle.getPricePerExtraHour());
            statement.setString(13, vehicle.getStatus());

            statement.executeUpdate();
            try (ResultSet rs = statement.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    throw new SQLException("Vehicle ID generation failed.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public void insertVehicleImages(int vehicleId, List<String> imagePaths) {
        Connection connection = DBConnectionFactory.getConnection();
        String sql = "INSERT INTO vehicle_Image (vehicle_id, image_file_path) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            for (String path : imagePaths) {
                ps.setInt(1, vehicleId);
                ps.setString(2, path);
                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Vehicle> getVehicles() {
        Connection connection = DBConnectionFactory.getConnection();
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT v.vehicle_id,v.vin, v.model, v.make, v.year, v.registration_number, v.vehicle_type, v.no_of_seats, v.current_meter_reading, v.price_per_day, v.price_per_km, v.price_per_extra_km, v.price_per_extra_hour, v.status, vi.image_file_path from vehicle as v join vehicle_image as vi on v.vehicle_id = vi.vehicle_id";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                vehicles.add(new Vehicle(
                        resultSet.getInt("vehicle_id"),
                        resultSet.getString("vin"),
                        resultSet.getString("model"),
                        resultSet.getString("make"),
                        resultSet.getInt("year"),
                        resultSet.getString("registration_number"),
                        resultSet.getString("vehicle_type"),
                        resultSet.getInt("no_of_seats"),
                        resultSet.getInt("current_meter_reading"),
                        resultSet.getDouble("price_per_day"),
                        resultSet.getDouble("price_per_km"),
                        resultSet.getDouble("price_per_extra_km"),
                        resultSet.getDouble("price_per_extra_hour"),
                        resultSet.getString("status"),
                        resultSet.getString("image_file_path")
                ));
            }
            return vehicles;
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<String> getVehicleImages(int vehicleId) {
        Connection connection = DBConnectionFactory.getConnection();
        List<String> imagePaths = new ArrayList<>();
        String sql = "SELECT image_file_path FROM vehicle_Image WHERE vehicle_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, vehicleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                imagePaths.add(rs.getString("image_file_path"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return imagePaths;
    }
}
