package com.cab.mega.controller;

import com.cab.mega.Service.AuthService;
import com.cab.mega.Service.LoginService;
import com.cab.mega.model.CommonResponseModel;
import com.cab.mega.model.LoginModel;
import com.cab.mega.model.User;
import com.google.gson.Gson;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

import static com.cab.mega.utils.datamapper.DataMapper.getDataMapper;

@WebServlet("/auth")
public class AuthController extends HttpServlet {
    AuthService authService;

    public void init() throws ServletException {
        authService = AuthService.getAuthService();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
        String actionType = req.getParameter("action");

        if (actionType == null) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action type.");
            return;
        }
        switch (actionType) {
            case "login":
                login(req, res);
                break;
            case "logout":
                logout(req, res);
                break;
            default:
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action type.");
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String actionType = req.getParameter("action");

        if (actionType == null) {
            res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action type.");
            return;
        }

        switch (actionType) {
            case "login":
                login(req, res);
                break;
            case "register":
                register(req, res);
                break;
            case "logout":
                logout(req, res);
                break;
            default:
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action type.");
        }
    }
    public void login(HttpServletRequest req, HttpServletResponse res)throws IOException, ServletException{
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            LoginModel loginModel = new LoginModel();
            loginModel.setEmail(email);
            loginModel.setPassword(password);
            User user = authService.loginUser(loginModel,req);

            if (user != null) {
                System.out.println(user.getRoleId());
                if(user.getRoleId()==1){
                    //res.sendRedirect(req.getContextPath()+"/admin?action=dashboard");
                    CommonResponseModel response = new CommonResponseModel("/admin?action=dashboard",true,null);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                }else if(user.getRoleId()==2){
                    //res.sendRedirect(req.getContextPath()+"/admin?action=dashboard");
                    CommonResponseModel response = new CommonResponseModel("/admin?action=dashboard",true,null);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                }else if(user.getRoleId()==3){
                    //res.sendRedirect(req.getContextPath()+"/");
                    CommonResponseModel response = new CommonResponseModel("/driver?action=dashboard",true,null);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                } else if(user.getRoleId()==4){
                    //res.sendRedirect(req.getContextPath()+"/");
                    CommonResponseModel response = new CommonResponseModel("/customer?action=dashboard",true,null);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                }else{
                    CommonResponseModel response = new CommonResponseModel("Unauthorized",false,null);
                    res.setContentType("application/json");
                    res.getWriter().write(new Gson().toJson(response));
                    //res.sendRedirect(req.getContextPath()+"/login.jsp=unauthorized");
                }
            } else {
                CommonResponseModel response = new CommonResponseModel("Invalid Username or Password",false,null);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
                //res.sendRedirect(req.getContextPath()+"/login.jsp=unauthorized");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void register(HttpServletRequest req, HttpServletResponse res) throws IOException {

    }
    public void logout(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        res.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}
