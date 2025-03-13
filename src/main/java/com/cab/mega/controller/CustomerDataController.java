package com.cab.mega.controller;

import com.cab.mega.Service.UserService;
import com.cab.mega.Service.VehicleService;
import com.cab.mega.model.*;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import static com.cab.mega.utils.datamapper.DataMapper.getDataMapper;

@WebServlet("/customer/*")

public class CustomerDataController extends HttpServlet {
    UserService userService;
    VehicleService vehicleService;

    public void init() throws ServletException {
        userService = UserService.getInstance();
        vehicleService = VehicleService.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null){
            res.sendRedirect(req.getContextPath()+"/");
        }
        assert action != null;
        if (action.equals("dashboard")){
            showDashboard(req,res);
        }else if (action.equals("bookings")){
            showBookings(req,res);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null){
            res.sendRedirect(req.getContextPath()+"/");
        }
        assert action != null;
        if (action.equals("customers/delete")){
            deleteUser(req,res);
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 4) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/customer/custDashboard.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
    private void showBookings(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 4) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/customer/booking/a_availableBookings.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }

    }
    private void deleteUser(HttpServletRequest req, HttpServletResponse res){
        try{
            int userId = Integer.parseInt(req.getParameter("id"));

            //boolean isDeleted = userService.deleteCustomer(userId); // Implement this in your service

            res.setContentType("application/json");
            res.getWriter().write(new Gson().toJson(Collections.singletonMap("success", true)));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
