package com.cab.mega.controller;

import com.cab.mega.Service.UserService;
import com.cab.mega.model.Customer;
import com.cab.mega.model.Staff;
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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.cab.mega.utils.datamapper.DataMapper.getDataMapper;

@WebServlet("/user/*")
public class UserController extends HttpServlet {
    UserService userService;

    public void init() throws ServletException {
        userService = UserService.getInstance();
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String path = req.getPathInfo();
        System.out.println(path);
        if(path == null){
            res.sendRedirect(req.getContextPath()+"/");
        }
        switch (path){
            case "/dashboard":
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard2.jsp").forward(req,res);
                break;
            case "/bookings":
//                req.setAttribute("pageTitle","Available Bookings");
//                handleGetAvailableBookings(req,res);
                req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_availableBookings.jsp").forward(req, res);
                break;
            case "/customers":
                req.setAttribute("pageTitle","Customer List");
                handleGetCustomers(req,res);
                break;
            case "/drivers":
                req.setAttribute("pageTitle","Driver List");
                handleGetDrivers(req,res);
                break;
        }
        String action = req.getParameter("action");
        String userType = req.getParameter("user-type");
        if(action==null || action.equals("User")) {
            getAllUsers(req, res);
        }else if(action==null || action.equals("customers")){
            listCustomers(req,res);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String action = req.getParameter("action");
        String userType = req.getParameter("user-type");
        if(action==null||userType==null){
            res.sendRedirect("error.jsp");
        }
        System.out.println(userType);
        switch (userType){
            case "admin":
                addStaff(userType,req,res);
                break;
            case "customer":
                addCustomer(userType,req,res);
        }
    }
    protected void handleGetAvailableBookings(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession();
        Integer roleId = (Integer) session.getAttribute("rol_id");
        if(roleId == null){
            res.sendRedirect("/login.jsp");
        }

//        List<ReservationModel> reservations = reservationService.getPendingReservations(branchId);
//        System.out.println(reservations);
        req.setAttribute("reservations", "hello");
        req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_availableBookings.jsp").forward(req, res);
    }
    protected void handleGetCustomers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession();
        Integer roleId = (Integer) session.getAttribute("role_id");
        if(roleId == null && roleId!=1){
            res.sendRedirect("/login.jsp");
        }
        req.getRequestDispatcher("/WEB-INF/view/user/admin/customer/a_customerList.jsp").forward(req, res);
    }
    protected void handleGetDrivers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession();
        Integer roleId = (Integer) session.getAttribute("role_id");
        if(roleId == null && roleId!=1){
            res.sendRedirect("/login.jsp");
        }
        req.getRequestDispatcher("/WEB-INF/view/user/admin/customer/a_customerList.jsp").forward(req, res);
    }
    public void addStaff(String userType, HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");
        String nic = req.getParameter("nic");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");
        String roleId = req.getParameter("role_id");
        String jobTitle = "System Administrator";


        User user = new User(firstName,lastName,nic,email,password,phone,gender,1);
        Staff customer = new Staff(jobTitle);
        try {
            Staff adminData = new Gson().fromJson(getDataMapper().mapData(req), Staff.class);
            userService.addAdmin(user,customer);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/register.jsp");
            requestDispatcher.forward(req,res);
        }
    }
    public void getAllUsers(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }
    public void addCustomer(String userType,HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String firstName = req.getParameter("first_name");
        String lastName = req.getParameter("last_name");
        String nic = req.getParameter("nic");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");
        String roleId = req.getParameter("role_id");
        String address = req.getParameter("address");
        String membershipStatus = req.getParameter("membership");

        User user = new User(firstName,lastName,nic,email,password,phone,gender,Integer.parseInt(roleId));
        Customer customer = new Customer(address,membershipStatus);

        try {
            Customer customerData = new Gson().fromJson(getDataMapper().mapData(req), Customer.class);
            userService.addCustomer(user,customer);
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/dashboard2.jsp?page=customers");
            requestDispatcher.forward(req,res);
        }
    }

    public void listCustomers(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        List<Customer> customerList = new ArrayList<>();
        try {
            customerList = userService.getAllCustomers();
            req.setAttribute("customers", customerList);
        } catch ( SQLException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("WEB-INF/view/error.jsp").forward(req, res);
            return;
        }

        req.getRequestDispatcher("dashboard2.jsp?page=customers").forward(req, res);
    }
}
