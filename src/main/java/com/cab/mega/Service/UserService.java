package com.cab.mega.Service;

import com.cab.mega.dao.*;
import com.cab.mega.model.*;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserService {
    private static UserService userService;
    private UserDao userDao;
    private StaffDao staffDao;
    private CustomerDao customerDao;
    private AuthDao authDao;
    private DriverDao driverDao;

    private UserService() {
        this.userDao = new UserDaoImpl();
        this.staffDao = new StaffDaoImpl();
        this.customerDao = new CustomerDaoImpl();
        this.authDao = new AuthDaoImpl();
        this.driverDao = new DriverDaoImpl();
    }

    public static UserService getInstance() {
        if (userService == null) {
            synchronized (LoginService.class) {
                if (userService == null) {
                    userService = new UserService();
                }
            }
        }
        return userService;
    }
    public void addAdmin(User user, Staff staff) throws SQLException {
        Connection connection=null;
        try{
            connection = DBConnectionFactory.getConnection();
            connection.setAutoCommit(false);
            int userId = userDao.addUser(user);
            System.out.println(userId);
            staff.setUserId(userId);
            staffDao.addStaff(staff);
            connection.commit();
        }catch (SQLException e){
            if(connection != null)
            {
                connection.rollback();
            }
        }
    }
    public void getAllUsers(){
        List<User> users = userDao.getAllUsers();
        users.forEach(user->{System.out.println(user.getEmail());});
    }
    public List<Customer> getAllCustomers() throws SQLException{
        return customerDao.getAllCustomers();
    }
    public CommonResponseModel addCustomer(User user, Customer customer) throws SQLException {
        Connection connection = null;
        String regex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern emailPattern = Pattern.compile(regex);
        Matcher emailMatcher = emailPattern.matcher(user.getEmail());

        Pattern phonePattern = Pattern.compile("[^\\d+]");
        Matcher phoneMatcher = phonePattern.matcher(user.getPhone());

        String nicRegex = "^([0-9]{9}[xXvV]|[0-9]{12})$";
        Pattern nicPattern = Pattern.compile(nicRegex);
        Matcher nicMatcher = nicPattern.matcher(user.getNic());

        if (user.getFirstName().length() > 30 || user.getFirstName().isEmpty()) {
            return new CommonResponseModel("Invalid First Name", false, null);
        } else if (user.getLastName().length() > 30 || user.getLastName().isEmpty()) {
            return new CommonResponseModel("Invalid Last Name", false, null);
        } else if (!nicMatcher.matches()) {
            return new CommonResponseModel("Invalid NIC", false, null);
        }else if (!emailMatcher.matches()) {
            return new CommonResponseModel("Invalid Email Address", false, null);
        } else if (user.getPhone().length() > 15 || user.getPhone().length() < 6 || phoneMatcher.find()) {
            return new CommonResponseModel("Invalid Phone Number", false, null);
        } else if (!(user.getPassword().length() >= 6 && user.getPassword().length() <= 32)) {
            return new CommonResponseModel("Password length must be between 6 and 32 characters.", false, null);
        } else if (!user.getPassword().matches(".*[A-Z].*") || !user.getPassword().matches(".*\\d.*")) {
            return new CommonResponseModel("Please use a complex password with mix characters and numbers", false, null);
        } else if (authDao.getUserByEmail(user.getEmail())) {
            return new CommonResponseModel("User already registered with the same Email", false, null);
        } else {
            try {
                connection = DBConnectionFactory.getConnection();
                connection.setAutoCommit(false);
                int userId = userDao.addUser(user);
                System.out.println(userId);
                customer.setUserId(userId);
                customerDao.addCustomer(customer);
                connection.commit();
                return new CommonResponseModel("Customer Created Successfully!", true, null);
            } catch (SQLException e) {
                if (connection != null) {
                    connection.rollback();
                }
            }
            return new CommonResponseModel("Something went wrong!", false, null);
        }
    }

    public List<Driver> getAllDrivers() {
        return driverDao.getAllDrivers();
    }

    public CommonResponseModel addDriver(User user, Driver driver) throws SQLException {
        Connection connection = null;
        String regex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern emailPattern = Pattern.compile(regex);
        Matcher emailMatcher = emailPattern.matcher(user.getEmail());

        Pattern phonePattern = Pattern.compile("[^\\d+]");
        Matcher phoneMatcher = phonePattern.matcher(user.getPhone());

        String nicRegex = "^([0-9]{9}[xXvV]|[0-9]{12})$";
        Pattern nicPattern = Pattern.compile(nicRegex);
        Matcher nicMatcher = nicPattern.matcher(user.getNic());

        if (user.getFirstName().length() > 30 || user.getFirstName().isEmpty()) {
            return new CommonResponseModel("Invalid First Name", false, null);
        } else if (user.getLastName().length() > 30 || user.getLastName().isEmpty()) {
            return new CommonResponseModel("Invalid Last Name", false, null);
        } else if (!nicMatcher.matches()) {
            return new CommonResponseModel("Invalid NIC", false, null);
        }else if (!emailMatcher.matches()) {
            return new CommonResponseModel("Invalid Email Address", false, null);
        } else if (user.getPhone().length() > 15 || user.getPhone().length() < 6 || phoneMatcher.find()) {
            return new CommonResponseModel("Invalid Phone Number", false, null);
        } else if (!(user.getPassword().length() >= 6 && user.getPassword().length() <= 32)) {
            return new CommonResponseModel("Password length must be between 6 and 32 characters.", false, null);
        } else if (!user.getPassword().matches(".*[A-Z].*") || !user.getPassword().matches(".*\\d.*")) {
            return new CommonResponseModel("Please use a complex password with mix characters and numbers", false, null);
        } else if (authDao.getUserByEmail(user.getEmail())) {
            return new CommonResponseModel("Driver already registered with the same Email", false, null);
        } else {
            try {
                connection = DBConnectionFactory.getConnection();
                connection.setAutoCommit(false);
                int userId = userDao.addUser(user);
                System.out.println(userId);
                driver.setUserId(userId);
                driverDao.addDriver(driver);
                connection.commit();
                return new CommonResponseModel("Driver Created Successfully!", true, null);
            } catch (SQLException e) {
                if (connection != null) {
                    connection.rollback();
                }
            }
            return new CommonResponseModel("Something went wrong!", false, null);
        }
    }

    public List<Staff> getAllStaff() {
        return staffDao.getAllStaff();
    }

    public CommonResponseModel addStaff(User user, Staff staff) throws SQLException {
        Connection connection = null;
        String regex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern emailPattern = Pattern.compile(regex);
        Matcher emailMatcher = emailPattern.matcher(user.getEmail());

        Pattern phonePattern = Pattern.compile("[^\\d+]");
        Matcher phoneMatcher = phonePattern.matcher(user.getPhone());

        String nicRegex = "^([0-9]{9}[xXvV]|[0-9]{12})$";
        Pattern nicPattern = Pattern.compile(nicRegex);
        Matcher nicMatcher = nicPattern.matcher(user.getNic());

        if (user.getFirstName().length() > 30 || user.getFirstName().isEmpty()) {
            return new CommonResponseModel("Invalid First Name", false, null);
        } else if (user.getLastName().length() > 30 || user.getLastName().isEmpty()) {
            return new CommonResponseModel("Invalid Last Name", false, null);
        } else if (!nicMatcher.matches()) {
            return new CommonResponseModel("Invalid NIC", false, null);
        }else if (!emailMatcher.matches()) {
            return new CommonResponseModel("Invalid Email Address", false, null);
        } else if (user.getPhone().length() > 15 || user.getPhone().length() < 6 || phoneMatcher.find()) {
            return new CommonResponseModel("Invalid Phone Number", false, null);
        } else if (!(user.getPassword().length() >= 6 && user.getPassword().length() <= 32)) {
            return new CommonResponseModel("Password length must be between 6 and 32 characters.", false, null);
        } else if (!user.getPassword().matches(".*[A-Z].*") || !user.getPassword().matches(".*\\d.*")) {
            return new CommonResponseModel("Please use a complex password with mix characters and numbers", false, null);
        } else if (authDao.getUserByEmail(user.getEmail())) {
            return new CommonResponseModel("User already registered with the same Email", false, null);
        } else {
            try {
                connection = DBConnectionFactory.getConnection();
                connection.setAutoCommit(false);
                int userId = userDao.addUser(user);
                System.out.println(userId);
                staff.setUserId(userId);
                staffDao.addStaff(staff);
                connection.commit();
                return new CommonResponseModel("Staff Member Created Successfully!", true, null);
            } catch (SQLException e) {
                if (connection != null) {
                    connection.rollback();
                }
            }
            return new CommonResponseModel("Something went wrong!", false, null);
        }
    }
}
