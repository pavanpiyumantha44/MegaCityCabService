package com.cab.mega.dao;

import com.cab.mega.model.Booking;
import com.cab.mega.model.Customer;
import com.cab.mega.model.Driver;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DriverDaoImpl implements DriverDao{
    @Override
    public void addDriver(Driver driver) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO driver(user_id, license_number, driving_experience,availability_status) VALUES(?,?,?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,driver.getUserId());
            statement.setString(2,driver.getLicenseNumber());
            statement.setInt(3,driver.getDrivingExperience());
            statement.setString(4,driver.getAvailabilityStatus());
            statement.executeUpdate();
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        Connection connection = DBConnectionFactory.getConnection();
        String query = "SELECT u.user_id,d.driver_id,u.first_name,u.last_name,u.nic,email,u.password,u.phone,gender,u.role_id,d.license_number,d.driving_experience,d.availability_status from user as u join driver as d on u.user_id=d.user_id where u.role_id=3";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                drivers.add(new Driver(
                        resultSet.getInt("user_id"),
                        resultSet.getInt("driver_id"),
                        resultSet.getString("first_name"),
                        resultSet.getString("last_name"),
                        resultSet.getString("nic"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone"),
                        resultSet.getString("gender"),
                        resultSet.getInt("role_id"),
                        resultSet.getString("license_number"),
                        resultSet.getInt("driving_experience"),
                        resultSet.getString("availability_status")));
            }

        }catch (SQLException e){
            e.printStackTrace();
        }
        return drivers;
    }

    @Override
    public Driver getDriverById(int driverId) {
        Driver driver = null;
        Connection connection = DBConnectionFactory.getConnection();
        String query = "SELECT u.*,d.driver_id,d.license_number,d.driving_experience,d.availability_status FROM user as u join driver as d on u.user_id = d.user_id where d.driver_id=?";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,driverId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                driver = new Driver(
                        resultSet.getInt("user_id"),
                        resultSet.getInt("driver_id"),
                        resultSet.getString("first_name"),
                        resultSet.getString("last_name"),
                        resultSet.getString("nic"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone"),
                        resultSet.getString("gender"),
                        resultSet.getInt("role_id"),
                        resultSet.getString("license_number"),
                        resultSet.getInt("driving_experience"),
                        resultSet.getString("availability_status")
                );
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return driver;
    }

    @Override
    public boolean updateDriver(Driver driver) {
        return true;
    }

    @Override
    public boolean deleteDriver(int id) {
        return true;
    }
}
