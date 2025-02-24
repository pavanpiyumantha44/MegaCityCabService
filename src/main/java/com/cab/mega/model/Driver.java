package com.cab.mega.model;

public class Driver extends User{
    private int driverId;
    private String licenseNumber;
    private int drivingExperience;
    private String availabilityStatus;


    public Driver(int userId, int driverId, String firstName, String lastName, String nic, String email, String password, String phone, String gender, int roleId, String licenseNumber, int drivingExperience, String availabilityStatus) {
        super(userId, firstName, lastName,nic, email,password, phone, gender, roleId);
        this.driverId = driverId;
        this.licenseNumber = licenseNumber;
        this.drivingExperience = drivingExperience;
        this.availabilityStatus = availabilityStatus;
    }

    public Driver(String licenseNumber, int drivingExperience) {
        this.licenseNumber = licenseNumber;
        this.drivingExperience = drivingExperience;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public int getDrivingExperience() {
        return drivingExperience;
    }

    public void setDrivingExperience(int drivingExperience) {
        this.drivingExperience = drivingExperience;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }
}
