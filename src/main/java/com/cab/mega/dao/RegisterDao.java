package com.cab.mega.dao;

import com.cab.mega.model.Staff;
import com.cab.mega.model.Customer;
import com.cab.mega.model.Driver;
import com.cab.mega.model.User;

public interface RegisterDao {
    public int registerUser(User user);
    public boolean registerAdmin(Staff admin);
    public boolean registerDriver(Driver driver);
    public boolean registerCustomer(Customer customer);
    public boolean checkIsUserAvailable(String email,String phone);
}
