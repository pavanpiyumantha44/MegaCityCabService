package com.cab.mega.model;

public class Customer extends User{
    private int customerId;
    private String address;
    private String membershipStatus;

    public Customer() {
        super();
    }

    public Customer(int userId, String firstName, String lastName, String nic, String email, String password, String phone, String gender, int roleId, int customerId, String address, String membershipStatus) {
        super(userId, firstName, lastName, nic, email, password, phone, gender, roleId);
        this.customerId = customerId;
        this.address = address;
        this.membershipStatus = membershipStatus;
    }

    public Customer(String address, String membershipStatus) {
        this.address = address;
        this.membershipStatus = membershipStatus;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMembershipStatus() {
        return membershipStatus;
    }

    public void setMembershipStatus(String membershipStatus) {
        this.membershipStatus = membershipStatus;
    }
}
