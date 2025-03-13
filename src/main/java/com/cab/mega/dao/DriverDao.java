package com.cab.mega.dao;

import com.cab.mega.model.Driver;

import java.util.List;

public interface DriverDao {
    public void addDriver(Driver driver);
    public List<Driver> getAllDrivers();
    public Driver getDriverById(int driverId);
    public int getDriverId(int userId);
    public boolean updateDriver(Driver driver);
    public boolean deleteDriver(int id);
    public int getRideCount(int id);
    public double driversEarning(int id);
}
