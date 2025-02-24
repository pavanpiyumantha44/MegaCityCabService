package com.cab.mega.model;

public class User {
    protected int userId;
    protected String firstName;
    protected String lastName;
    protected String nic;
    protected String email;
    protected String password;
    protected String phone;
    protected String gender;
    protected int roleId;

    public User(){}

    public User(int userId, String firstName, String lastName, String nic, String email, String password, String phone, String gender, int roleId) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.nic = nic;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.roleId = roleId;
    }
    public User(String firstName, String lastName, String nic, String email, String password, String phone, String gender, int roleId) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.nic = nic;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.roleId = roleId;
    }

    public User(int userId, String firstName, String email, String password, int roleId) {
        this.userId = userId;
        this.firstName = firstName;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}
