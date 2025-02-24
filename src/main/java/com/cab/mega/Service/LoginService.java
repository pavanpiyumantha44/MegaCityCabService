package com.cab.mega.Service;

import com.cab.mega.dao.LoginDao;
import com.cab.mega.dao.LoginDaoImpl;
import com.cab.mega.model.LoginModel;
import com.cab.mega.model.User;
import com.cab.mega.utils.encryption.HashPassword;

import javax.servlet.http.HttpServletRequest;

public class LoginService {
    private static LoginService instance;
    private LoginDao loginDao;

    private LoginService() {
        this.loginDao = new LoginDaoImpl();
    }

    public static LoginService getInstance() {
        if (instance == null) {
            synchronized (LoginService.class) {
                if (instance == null) {
                    instance = new LoginService();
                }
            }
        }
        return instance;
    }
    public User loginUser(LoginModel loginModel, HttpServletRequest req){
        User user = loginDao.getUserByEmail(loginModel.getEmail());
        if(user!=null){
            return user;
        } else {
           return null;
        }
    }
}
