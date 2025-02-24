package com.cab.mega.controller;

import com.cab.mega.Service.AuthService;
import com.cab.mega.Service.LoginService;
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
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, String returnUrl) throws IOException {
//        System.out.println("working");
//        System.out.println(success);
//        System.out.println(message);
//        System.out.println(returnUrl);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print("{\"success\":" + success + ",\"message\":\"" + message + "\" " + (returnUrl != null ? ",\"returnUrl\":\"" + returnUrl + "\"" : "") + "}");
        out.flush();
    }
//private void sendJsonResponse(HttpServletResponse response, boolean success, String message, String returnUrl) throws IOException {
//    System.out.println("working");
//    System.out.println(success);
//    System.out.println(message);
//    System.out.println(returnUrl);
//    response.setContentType("application/json");
//    response.setCharacterEncoding("UTF-8");
//
//    // Use a Java object to represent the response
//    class JsonResponse {
//        boolean success;
//        String message;
//        String returnUrl;
//
//        JsonResponse(boolean success, String message, String returnUrl) {
//            this.success = success;
//            this.message = message;
//            this.returnUrl = returnUrl;
//        }
//    }
//
//    JsonResponse jsonResponse = new JsonResponse(success, message, returnUrl);
//    String json = new Gson().toJson(jsonResponse);
//    System.out.println(json);
//    PrintWriter out = response.getWriter();
//    out.print(json);
//    out.flush();
//}
    public void login(HttpServletRequest req, HttpServletResponse res)throws IOException, ServletException{
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            LoginModel loginModel = new LoginModel();
            loginModel.setEmail(email);
            loginModel.setPassword(password);

            User user = authService.loginUser(loginModel,req);

            if (user != null) {
                //sendJsonResponse(res, true, "Login successful!", returnUrl);
                res.sendRedirect(req.getContextPath()+"/admin?action=dashboard");
            } else {
                //sendJsonResponse(res, false, "Invalid email or password!", null);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void register(HttpServletRequest req, HttpServletResponse res) throws IOException {

    }
    public void logout(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false); // Get session if exists
        if (session != null) {
            session.invalidate(); // Destroy session
        }
        System.out.println(req.getContextPath());
        res.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}
