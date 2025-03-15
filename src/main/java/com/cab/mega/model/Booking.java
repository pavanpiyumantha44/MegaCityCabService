package com.cab.mega.model;

import java.util.Date;

public class Booking {
    private int bookingId;
    private int customerId;
    private int driverId;
    private int vehicleId;
    private String pickupLocation;
    private String destination;
    private String pickupLat;
    private String pickupLon;
    private String destinationLat;
    private String destinationLon;
    private String specialNote;
    private double startMeterReading;
    private double endMeterReading;
    private double distanceKm;
    private double baseFare;
    private double pricePerKm;
    private double waitingPrice;
    private double totalPrice;
    private double discountPrice;
    private double cancellationPrice;
    private String bookingDateTime;
    private String pickupDateTime;
    private String dropOffDateTime;
    private String status;
    private String paymentStatus;
    private String paymentMethod;
    private String cancelledBy;

    public Booking(int bookingId, int customerId, int driverId, int vehicleId, String pickupLocation, String destination, String pickupLat, String pickupLon, String destinationLat, String destinationLon, String specialNote, double startMeterReading, double endMeterReading, double distanceKm, double baseFare, double pricePerKm, double waitingPrice, double totalPrice, double discountPrice, double cancellationPrice, String bookingDateTime, String pickupDateTime, String dropOffDateTime, String status, String paymentStatus, String paymentMethod, String cancelledBy) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.driverId = driverId;
        this.vehicleId = vehicleId;
        this.pickupLocation = pickupLocation;
        this.destination = destination;
        this.pickupLat = pickupLat;
        this.pickupLon = pickupLon;
        this.destinationLat = destinationLat;
        this.destinationLon = destinationLon;
        this.specialNote = specialNote;
        this.startMeterReading = startMeterReading;
        this.endMeterReading = endMeterReading;
        this.distanceKm = distanceKm;
        this.baseFare = baseFare;
        this.pricePerKm = pricePerKm;
        this.waitingPrice = waitingPrice;
        this.totalPrice = totalPrice;
        this.discountPrice = discountPrice;
        this.cancellationPrice = cancellationPrice;
        this.bookingDateTime = bookingDateTime;
        this.pickupDateTime = pickupDateTime;
        this.dropOffDateTime = dropOffDateTime;
        this.status = status;
        this.paymentStatus = paymentStatus;
        this.paymentMethod = paymentMethod;
        this.cancelledBy = cancelledBy;
    }

    public Booking(int customerId, int driverId, int vehicleId, String pickupLocation, String destination, String pickupLat, String pickupLon, String destinationLat, String destinationLon, String specialNote, double startMeterReading, double endMeterReading, double distanceKm, double baseFare, double pricePerKm, double waitingPrice, double totalPrice, double discountPrice, String pickupDateTime, String status, String paymentStatus) {
        this.customerId = customerId;
        this.driverId = driverId;
        this.vehicleId = vehicleId;
        this.pickupLocation = pickupLocation;
        this.destination = destination;
        this.pickupLat = pickupLat;
        this.pickupLon = pickupLon;
        this.destinationLat = destinationLat;
        this.destinationLon = destinationLon;
        this.specialNote = specialNote;
        this.startMeterReading = startMeterReading;
        this.endMeterReading = endMeterReading;
        this.distanceKm = distanceKm;
        this.baseFare = baseFare;
        this.pricePerKm = pricePerKm;
        this.waitingPrice = waitingPrice;
        this.totalPrice = totalPrice;
        this.discountPrice = discountPrice;
        this.pickupDateTime = pickupDateTime;
        this.status = status;
        this.paymentStatus = paymentStatus;
    }

    public Booking(int bookingId,String status) {
        this.bookingId = bookingId;
        this.status = status;
    }
    public Booking(int bookingId,double distanceKm, double endMeterReading, String dropOffDttm, double discountPrice, double totalPrice, String status) {
        this.bookingId = bookingId;
        this.distanceKm = distanceKm;
        this.endMeterReading = endMeterReading;
        this.dropOffDateTime = dropOffDttm;
        this.discountPrice = discountPrice;
        this.totalPrice = totalPrice;
        this.status = status;
    }
    public Booking(int bookingId,String paymentMethod, String paymentStatus, String status) {
        this.bookingId = bookingId;
        this.paymentMethod=paymentMethod;
        this.paymentStatus = paymentStatus;
        this.status = status;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getPickupLocation() {
        return pickupLocation;
    }

    public void setPickupLocation(String pickupLocation) {
        this.pickupLocation = pickupLocation;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getPickupLat() {
        return pickupLat;
    }

    public void setPickupLat(String pickupLat) {
        this.pickupLat = pickupLat;
    }

    public String getPickupLon() {
        return pickupLon;
    }

    public void setPickupLon(String pickupLon) {
        this.pickupLon = pickupLon;
    }

    public String getDestinationLat() {
        return destinationLat;
    }

    public void setDestinationLat(String destinationLat) {
        this.destinationLat = destinationLat;
    }

    public String getDestinationLon() {
        return destinationLon;
    }

    public void setDestinationLon(String destinationLon) {
        this.destinationLon = destinationLon;
    }

    public String getSpecialNote() {
        return specialNote;
    }

    public void setSpecialNote(String specialNote) {
        this.specialNote = specialNote;
    }

    public double getStartMeterReading() {
        return startMeterReading;
    }

    public void setStartMeterReading(double startMeterReading) {
        this.startMeterReading = startMeterReading;
    }

    public double getEndMeterReading() {
        return endMeterReading;
    }

    public void setEndMeterReading(double endMeterReading) {
        this.endMeterReading = endMeterReading;
    }

    public double getDistanceKm() {
        return distanceKm;
    }

    public void setDistanceKm(double distanceKm) {
        this.distanceKm = distanceKm;
    }

    public double getBaseFare() {
        return baseFare;
    }

    public void setBaseFare(double baseFare) {
        this.baseFare = baseFare;
    }

    public double getPricePerKm() {
        return pricePerKm;
    }

    public void setPricePerKm(double pricePerKm) {
        this.pricePerKm = pricePerKm;
    }

    public double getWaitingPrice() {
        return waitingPrice;
    }

    public void setWaitingPrice(double waitingPrice) {
        this.waitingPrice = waitingPrice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    public double getCancellationPrice() {
        return cancellationPrice;
    }

    public void setCancellationPrice(double cancellationPrice) {
        this.cancellationPrice = cancellationPrice;
    }

    public String getBookingDateTime() {
        return bookingDateTime;
    }

    public void setBookingDateTime(String bookingDateTime) {
        this.bookingDateTime = bookingDateTime;
    }

    public String getPickupDateTime() {
        return pickupDateTime;
    }

    public void setPickupDateTime(String pickupDateTime) {
        this.pickupDateTime = pickupDateTime;
    }

    public String getDropOffDateTime() {
        return dropOffDateTime;
    }

    public void setDropOffDateTime(String dropOffDateTime) {
        this.dropOffDateTime = dropOffDateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getCancelledBy() {
        return cancelledBy;
    }

    public void setCancelledBy(String cancelledBy) {
        this.cancelledBy = cancelledBy;
    }
}
