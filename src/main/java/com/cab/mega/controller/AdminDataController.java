package com.cab.mega.controller;

import com.cab.mega.Service.UserService;
import com.cab.mega.model.*;
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
import java.util.Collections;
import java.util.List;

import static com.cab.mega.utils.datamapper.DataMapper.getDataMapper;

@WebServlet("/admin/*")
public class AdminDataController extends HttpServlet {
    UserService userService;

    public void init() throws ServletException {
        userService = UserService.getInstance();
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
        }else if(action.equals("customers/list")){
            showCustomers(req,res);
        }else if(action.equals("customers/add")){
            showAddCustomers(req,res);;
        }else if(action.equals("drivers/list")){
            showDrivers(req,res);;
        }else if(action.equals("drivers/add")){
            showAddDrivers(req,res);;
        }else if(action.equals("staff/list")){
            showStaff(req,res);
        }else if(action.equals("staff/add")){
            showAddStaff(req,res);
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null){
            res.sendRedirect(req.getContextPath()+"/");
        }
        assert action != null;
        if (action.equals("customers/add")){
            addCustomers(req,res);
        }else if(action.equals("customers/delete")){
            deleteUser(req,res);
        }else if(action.equals("drivers/add")){
            addDrivers(req,res);
        }else if(action.equals("drivers/delete")){
            deleteUser(req,res);
        }else if(action.equals("staff/add")){
            addStaff(req,res);
        }else if(action.equals("staff/delete")){
            deleteUser(req,res);
        }
    }

    private void showDashboard(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
    private void showBookings(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_availableBookings.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }

    }
    private void showCustomers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            List<Customer> customers = userService.getAllCustomers();
            req.setAttribute("customers",customers);
            req.getRequestDispatcher("/WEB-INF/view/user/admin/customer/a_customerList.jsp").forward(req, res);
        }catch (NullPointerException | SQLException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showAddCustomers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/customer/a_addNewCustomer.jsp").forward(req, res);
        }catch (NullPointerException | IOException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void addCustomers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            String firstName = req.getParameter("first_name");
            String lastName = req.getParameter("last_name");
            String nic = req.getParameter("nic");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String address = req.getParameter("address");
            String membershipStatus = req.getParameter("membership");
            User user = new User(firstName,lastName,nic,email,password,phone,gender,4);
            Customer customer = new Customer(address,membershipStatus);
            try {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!",false,null);
                Customer customerData = new Gson().fromJson(getDataMapper().mapData(req), Customer.class);
                response = userService.addCustomer(user,customer);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }catch (Exception e){
                res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                e.printStackTrace();
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showDrivers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            List<Driver> drivers = userService.getAllDrivers();
            req.setAttribute("drivers",drivers);
            req.getRequestDispatcher("/WEB-INF/view/user/admin/driver/a_driverList.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showAddDrivers (HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/driver/a_addNewDriver.jsp").forward(req, res);
        }catch (NullPointerException | IOException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void addDrivers(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            String firstName = req.getParameter("first_name");
            String lastName = req.getParameter("last_name");
            String nic = req.getParameter("nic");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String licenseNumber = req.getParameter("license_number");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String drivingExperience = req.getParameter("driving_experience");
            User user = new User(firstName,lastName,nic,email,password,phone,gender,3);
            Driver driver = new Driver(licenseNumber,Integer.parseInt(drivingExperience));
            try {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!",false,null);
                Driver driverData = new Gson().fromJson(getDataMapper().mapData(req), Driver.class);
                response = userService.addDriver(user,driver);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }catch (Exception e){
                res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                e.printStackTrace();
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showStaff(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            List<Staff> staff = userService.getAllStaff();
            req.setAttribute("staff",staff);
            req.getRequestDispatcher("/WEB-INF/view/user/admin/staff/a_staffList.jsp").forward(req, res);
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void showAddStaff (HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            req.getRequestDispatcher("/WEB-INF/view/user/admin/staff/a_addNewStaffMember.jsp").forward(req, res);
        }catch (NullPointerException | IOException e){
            res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
        }
    }
    private void addStaff(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
        try {
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId!= 1) {
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
            String firstName = req.getParameter("first_name");
            String lastName = req.getParameter("last_name");
            String nic = req.getParameter("nic");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String jobTitle = req.getParameter("job_title");
            User user = new User(firstName,lastName,nic,email,password,phone,gender,2);
            Staff staff = new Staff(jobTitle);
            try {
                CommonResponseModel response = new CommonResponseModel("Something went wrong!",false,null);
                Staff staffData = new Gson().fromJson(getDataMapper().mapData(req), Staff.class);
                response = userService.addStaff(user,staff);
                res.setContentType("application/json");
                res.getWriter().write(new Gson().toJson(response));
            }catch (Exception e){
                res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                e.printStackTrace();
            }
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
