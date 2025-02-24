package com.cab.mega.model;

public class Staff extends User{
    private int staffId;
    private String jobTitle;

    public Staff(int staffId,String jobTitle) {
        this.staffId = staffId;
        this.jobTitle = jobTitle;
    }

    public Staff(int userId, String firstName, String lastName, String nic, String email, String password, String phone, String gender, int roleId,int staffId, String jobTitle) {
        super(userId, firstName, lastName, nic, email, password, phone, gender, roleId);
        this.staffId = staffId;
        this.jobTitle = jobTitle;
    }
    public Staff(String jobTitle){
        this.jobTitle = jobTitle;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }
}
