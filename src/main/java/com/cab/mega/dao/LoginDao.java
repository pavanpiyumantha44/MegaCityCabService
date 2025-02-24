package com.cab.mega.dao;

import com.cab.mega.model.LoginModel;
import com.cab.mega.model.User;

import javax.servlet.http.HttpServletRequest;

public interface LoginDao {
    public User getUserByEmail(String email);
//    public User loginUser(LoginModel loginModel, HttpServletRequest req);
}
