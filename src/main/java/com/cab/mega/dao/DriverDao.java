package com.cab.mega.dao;

import com.cab.mega.model.Driver;

import java.util.List;

public interface DriverDao {
    public void addDriver(Driver driver);
    public List<Driver> getAllDrivers();
    public boolean updateDriver(Driver driver);
    public boolean deleteDriver(int id);
}
