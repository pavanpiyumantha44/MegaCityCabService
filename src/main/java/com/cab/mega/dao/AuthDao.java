package com.cab.mega.dao;

import com.cab.mega.model.*;

public interface AuthDao {
    public int registerUser(User user);
    public boolean getUserByEmail(String email);
    public boolean registerAdmin(Staff admin);
    public boolean registerDriver(Driver driver);
    public boolean registerCustomer(Customer customer);
    public boolean checkIsUserAvailable(String email,String phone);
    public User loginUser(LoginModel loginModel);
}
