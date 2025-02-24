package com.cab.mega.dao;

import com.cab.mega.model.Staff;

import java.util.List;

public interface StaffDao {
    public void addStaff(Staff staff);
    public List<Staff> getAllStaff();
}
