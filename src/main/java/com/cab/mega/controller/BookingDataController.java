package com.cab.mega.controller;

import com.cab.mega.Service.UserService;
import com.cab.mega.Service.VehicleService;
import com.cab.mega.model.Customer;
import com.cab.mega.model.Vehicle;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/booking/*")
public class BookingDataController extends HttpServlet {

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
        if (action.equals("list")){
            showRides(req,res);
        }else if (action.equals("add")){
            showAddRides(req,res);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    }
    private void showRides(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId == 1) {
                req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_addNewBooking.jsp").forward(req, res);
            }else if(roleId == 2){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if(roleId == 3){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            }else if(roleId == 4){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else{
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
    private void showAddRides(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        try{
            HttpSession session = req.getSession();
            int roleId = (int) session.getAttribute("role_id");
            if (roleId == 1) {
                try{
                    List<Customer> customers = userService.getAllCustomers();
                    List<Vehicle> vehicles = vehicleService.getAllAvailableVehicles();
                    req.setAttribute("customers",customers);
                    req.setAttribute("vehicles",vehicles);
                    req.getRequestDispatcher("/WEB-INF/view/user/admin/booking/a_addNewBooking.jsp").forward(req, res);
                }catch (NullPointerException | SQLException e){
                    res.sendRedirect(req.getContextPath()+"/login.jsp?error=unauthorized");
                }
            }else if(roleId == 2){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else if(roleId == 3){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            }else if(roleId == 4){
                req.getRequestDispatcher("/WEB-INF/view/user/admin/dashboard.jsp").forward(req, res);
            } else{
                res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                return;
            }
        }catch (NullPointerException e){
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
        }
    }
}
