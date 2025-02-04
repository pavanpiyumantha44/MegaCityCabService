package com.cab.mega.Model;

public class Driver extends User{
    private String licenseNumber;
    private int drivingExperience;
    private String availabilityStatus;

    public Driver(){
        super();
    }

    public Driver(int userId, String firstName, String lastName, String email, String phone, String password, int roleId, String licenseNumber, int drivingExperience, String availabilityStatus) {
        super(userId, firstName, lastName, email, phone, password, roleId);
        this.licenseNumber = licenseNumber;
        this.drivingExperience = drivingExperience;
        this.availabilityStatus = availabilityStatus;
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
