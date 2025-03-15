package com.cab.mega.dao;

import com.cab.mega.model.Vehicle;

import java.util.List;

public interface VehicleDao {
    public int insertVehicle(Vehicle vehicle);
    public void insertVehicleImages(int vehicleId, List<String> imagePaths);
    public Vehicle getVehicleById(int vehicleId);
    public List<Vehicle> getVehicles();
    public List<Vehicle> getAvailableVehicles();
    public List<String> getVehicleImages(int vehicleId);
}
