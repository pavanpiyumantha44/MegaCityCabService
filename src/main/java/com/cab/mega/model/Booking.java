package com.cab.mega.model;

import java.util.Date;

public class Booking {
    private int bookingId;
    private int userId;
    private int vehicleId;
    private String startDate;
    private String endDate;
    private int noOfDays;
    private String isLicenseVerified;
    private String isUtilityBillVerified;
    private int startMeterReading;
    private int endMeterReading;
    private double totalPrice;
    private String bookingStatus;


    // Default constructor
    public Booking() {
    }

    public Booking(int bookingId, int userId, int vehicleId, String startDate, String endDate, int noOfDays, String isLicenseVerified, String isUtilityBillVerified, int startMeterReading, int endMeterReading, double totalPrice, String bookingStatus) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.vehicleId = vehicleId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.noOfDays = noOfDays;
        this.isLicenseVerified = isLicenseVerified;
        this.isUtilityBillVerified = isUtilityBillVerified;
        this.startMeterReading = startMeterReading;
        this.endMeterReading = endMeterReading;
        this.totalPrice = totalPrice;
        this.bookingStatus = bookingStatus;
    }

    public Booking(int userId, int vehicleId, String startDate, String endDate, int noOfDays, String isLicenseVerified, String isUtilityBillVerified, int startMeterReading, int endMeterReading, double totalPrice, String bookingStatus) {
        this.userId = userId;
        this.vehicleId = vehicleId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.noOfDays = noOfDays;
        this.isLicenseVerified = isLicenseVerified;
        this.isUtilityBillVerified = isUtilityBillVerified;
        this.startMeterReading = startMeterReading;
        this.endMeterReading = endMeterReading;
        this.totalPrice = totalPrice;
        this.bookingStatus = bookingStatus;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public int getNoOfDays() {
        return noOfDays;
    }

    public void setNoOfDays(int noOfDays) {
        this.noOfDays = noOfDays;
    }

    public String getIsLicenseVerified() {
        return isLicenseVerified;
    }

    public void setIsLicenseVerified(String isLicenseVerified) {
        this.isLicenseVerified = isLicenseVerified;
    }

    public String getIsUtilityBillVerified() {
        return isUtilityBillVerified;
    }

    public void setIsUtilityBillVerified(String isUtilityBillVerified) {
        this.isUtilityBillVerified = isUtilityBillVerified;
    }

    public int getStartMeterReading() {
        return startMeterReading;
    }

    public void setStartMeterReading(int startMeterReading) {
        this.startMeterReading = startMeterReading;
    }

    public int getEndMeterReading() {
        return endMeterReading;
    }

    public void setEndMeterReading(int endMeterReading) {
        this.endMeterReading = endMeterReading;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
}
