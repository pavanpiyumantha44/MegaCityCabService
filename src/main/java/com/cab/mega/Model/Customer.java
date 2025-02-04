package com.cab.mega.Model;

public class Customer extends User{
    private String nic;
    private String address;
    private String membershipStatus;

    public Customer() {
        super();
    }

    public Customer(int userId, String firstName, String lastName, String email, String phone, String password, int roleId, String nic, String address, String membershipStatus) {
        super(userId, firstName, lastName, email, phone, password, roleId);
        this.nic = nic;
        this.address = address;
        this.membershipStatus = membershipStatus;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
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
