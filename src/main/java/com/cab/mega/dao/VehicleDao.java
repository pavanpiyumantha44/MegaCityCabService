package com.cab.mega.dao;

import com.cab.mega.model.Vehicle;

import java.util.List;

public interface VehicleDao {
    public int insertVehicle(Vehicle vehicle);
    public void insertVehicleImages(int vehicleId, List<String> imagePaths);
    public List<Vehicle> getVehicles();
    public List<String> getVehicleImages(int vehicleId);
}
