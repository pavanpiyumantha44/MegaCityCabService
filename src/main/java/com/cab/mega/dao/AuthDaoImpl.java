package com.cab.mega.dao;

import com.cab.mega.model.*;
import com.cab.mega.model.Driver;
import com.cab.mega.utils.database.DBConnectionFactory;
import com.cab.mega.utils.encryption.HashPassword;

import java.security.NoSuchAlgorithmException;
import java.sql.*;

public class AuthDaoImpl implements AuthDao{
    private static HashPassword getEncrypter() {
        return new HashPassword();
    }

    @Override
    public int registerUser(User user) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO user(first_name,last_name,nic,email,password,phone,gender,role_id) VALUES(?,?,?,?,?,?,?,?)";
        try{
            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1,user.getFirstName());
            statement.setString(2,user.getLastName());
            statement.setString(3,user.getNic());
            statement.setString(4,user.getEmail());
            statement.setString(5,user.getPassword());
            statement.setString(6,user.getPhone());
            statement.setString(7,user.getGender());
            statement.setInt(8,user.getRoleId());
            statement.executeUpdate();
            try (ResultSet rs = statement.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    throw new SQLException("User ID generation failed.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public boolean getUserByEmail(String email) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "SELECT email from user where email=?";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1,email);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean registerAdmin(Staff admin) {
        return false;
    }

    @Override
    public boolean registerDriver(Driver driver) {
        return false;
    }

    @Override
    public boolean registerCustomer(Customer customer) {
        return false;
    }

    @Override
    public boolean checkIsUserAvailable(String email, String phone) {
        return false;
    }

    @Override
    public User loginUser(LoginModel loginModel) {
        Connection connection = DBConnectionFactory.getConnection();
        String sql = "SELECT * FROM user WHERE email = ? AND password = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, loginModel.getEmail());
            statement.setString(2,getEncrypter().hashPassword(loginModel.getPassword()));
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    User user = new User(
                            resultSet.getInt("user_id"),
                            resultSet.getString("first_name"),
                            resultSet.getString("email"),
                            resultSet.getString("password"),
                            resultSet.getInt("role_id")
                    );
                    return user;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
