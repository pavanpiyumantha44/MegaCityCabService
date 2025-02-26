package com.cab.mega.model;

import java.util.List;

public class Vehicle {

    private int vehicleId;
    private String vin;
    private String model;
    private String make;
    private int year;
    private String registrationNumber;
    private String vehicleType;
    private int noOfSeats;
    private int currentMeterReading;
    private double pricePerDay;
    private double pricePerKm;
    private double pricePerExtraKm;
    private double pricePerExtraHour;
    private String status;
    private String imageName;
    private List<VehicleImage> images;

    public Vehicle(int vehicleId, String vin, String model, String make, int year, String registrationNumber, String vehicleType, int noOfSeats, int currentMeterReading, double pricePerDay, double pricePerKm, double pricePerExtraKm, double pricePerExtraHour, String status, List<VehicleImage> images) {
        this.vehicleId = vehicleId;
        this.vin = vin;
        this.model = model;
        this.make = make;
        this.year = year;
        this.registrationNumber = registrationNumber;
        this.vehicleType = vehicleType;
        this.noOfSeats = noOfSeats;
        this.currentMeterReading = currentMeterReading;
        this.pricePerDay = pricePerDay;
        this.pricePerKm = pricePerKm;
        this.pricePerExtraKm = pricePerExtraKm;
        this.pricePerExtraHour = pricePerExtraHour;
        this.status = status;
        this.images = images;
    }
    public Vehicle(int vehicleId, String vin, String model, String make, int year, String registrationNumber, String vehicleType, int noOfSeats, int currentMeterReading, double pricePerDay, double pricePerKm, double pricePerExtraKm, double pricePerExtraHour, String status, String imageName) {
        this.vehicleId = vehicleId;
        this.vin = vin;
        this.model = model;
        this.make = make;
        this.year = year;
        this.registrationNumber = registrationNumber;
        this.vehicleType = vehicleType;
        this.noOfSeats = noOfSeats;
        this.currentMeterReading = currentMeterReading;
        this.pricePerDay = pricePerDay;
        this.pricePerKm = pricePerKm;
        this.pricePerExtraKm = pricePerExtraKm;
        this.pricePerExtraHour = pricePerExtraHour;
        this.status = status;
        this.imageName = imageName;
    }

    public Vehicle(String vin, String model, String make, int year, String registrationNumber, String vehicleType, int noOfSeats, int currentMeterReading, double pricePerDay, double pricePerKm, double pricePerExtraKm, double pricePerExtraHour, String status) {
        this.vin = vin;
        this.model = model;
        this.make = make;
        this.year = year;
        this.registrationNumber = registrationNumber;
        this.vehicleType = vehicleType;
        this.noOfSeats = noOfSeats;
        this.currentMeterReading = currentMeterReading;
        this.pricePerDay = pricePerDay;
        this.pricePerKm = pricePerKm;
        this.pricePerExtraKm = pricePerExtraKm;
        this.pricePerExtraHour = pricePerExtraHour;
        this.status = status;
    }

    // Getters and Setters
    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int id) {
        this.vehicleId = id;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public String getVehicleType() {
        return vehicleType;
    }

    public void setVehicleType(String vehicleType) {
        this.vehicleType = vehicleType;
    }

    public int getNoOfSeats() {
        return noOfSeats;
    }

    public void setNoOfSeats(int noOfSeats) {
        this.noOfSeats = noOfSeats;
    }

    public int getCurrentMeterReading() {
        return currentMeterReading;
    }

    public void setCurrentMeterReading(int currentMeterReading) {
        this.currentMeterReading = currentMeterReading;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public double getPricePerKm() {
        return pricePerKm;
    }

    public void setPricePerKm(double pricePerKm) {
        this.pricePerKm = pricePerKm;
    }

    public double getPricePerExtraKm() {
        return pricePerExtraKm;
    }

    public void setPricePerExtraKm(double pricePerExtraKm) {
        this.pricePerExtraKm = pricePerExtraKm;
    }

    public double getPricePerExtraHour() {
        return pricePerExtraHour;
    }

    public void setPricePerExtraHour(double pricePerExtraHour) {
        this.pricePerExtraHour = pricePerExtraHour;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<VehicleImage> getImages() {
        return images;
    }

    public void setImages(List<VehicleImage> images) {
        this.images = images;
    }
}