package com.cab.mega.dao;

import com.cab.mega.model.Booking;
import com.cab.mega.model.Customer;
import com.cab.mega.model.Driver;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDaoImpl implements CustomerDao{

    @Override
    public void addCustomer(Customer customer) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO customer(user_id, address, membership_status) VALUES(?,?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,customer.getUserId());
            statement.setString(2,customer.getAddress());
            statement.setString(3,customer.getMembershipStatus());
            statement.executeUpdate();
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        Connection connection = DBConnectionFactory.getConnection();
        String query = "SELECT u.user_id,c.customer_id,u.first_name,u.last_name,u.nic,email,u.password,u.phone,gender,u.role_id,c.address,c.membership_status from user as u join customer as c on u.user_id=c.user_id where u.role_id=4";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                customers.add(new Customer(
                        resultSet.getInt("user_id"),
                        resultSet.getString("first_name"),
                        resultSet.getString("last_name"),
                        resultSet.getString("nic"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone"),
                        resultSet.getString("gender"),
                        resultSet.getInt("role_id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getString("address"),
                        resultSet.getString("membership_status")));
            }

        }catch (SQLException e){
            e.printStackTrace();
        }
        return customers;
    }

    @Override
    public Customer getCustomerById(int customerId) {
        Customer customer = null;
        Connection connection = DBConnectionFactory.getConnection();
        String query = "SELECT u.*,c.customer_id,c.address,c.membership_status FROM user as u join customer as c on u.user_id = c.user_id where customer_id=?";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,customerId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                customer = new Customer(
                        resultSet.getInt("user_id"),
                        resultSet.getString("first_name"),
                        resultSet.getString("last_name"),
                        resultSet.getString("nic"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone"),
                        resultSet.getString("gender"),
                        resultSet.getInt("role_id"),
                        resultSet.getInt("customer_id"),
                        resultSet.getString("address"),
                        resultSet.getString("membership_status")
                );
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return customer;
    }

    @Override
    public boolean deleteCustomer(int id) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "DELETE FROM user where user_id=?";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            statement.executeUpdate();
            return true;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
