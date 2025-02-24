package com.cab.mega.Service;

import com.cab.mega.dao.AuthDao;
import com.cab.mega.dao.AuthDaoImpl;
import com.cab.mega.dao.LoginDao;
import com.cab.mega.dao.LoginDaoImpl;
import com.cab.mega.model.LoginModel;
import com.cab.mega.model.User;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class AuthService {
    private static AuthService authService;
    private AuthDao authDao;

    public AuthService(){
        authDao = new AuthDaoImpl();
    }

    public static synchronized AuthService getAuthService() {
        if (authService == null) {
            synchronized (AuthService.class) {
                if (authService == null) {
                    authService = new AuthService();
                }
            }
        }
        return authService;
    }

    private String createUrl(int user_id, String contextPath) {
        return switch (user_id) {
            case 1, 2 -> contextPath + "/admin/dashboard";
            default -> contextPath + "/";
        };
    }

    private void setUserSession(HttpServletRequest req, User user) {
        HttpSession session = req.getSession();
        session.setMaxInactiveInterval(45 * 60);
        session.setAttribute("user_id", user.getUserId());
        session.setAttribute("first_name", user.getFirstName());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("role_id", user.getRoleId());
        System.out.println(session.getAttribute("first_name"));
    }

    public User loginUser(LoginModel loginModel, HttpServletRequest req){
        User user = authDao.loginUser(loginModel);
        if(user!=null){
            setUserSession(req,user);
            return user;
        } else {
            return null;
        }
    }
}
