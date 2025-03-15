package com.cab.mega.dao;

import com.cab.mega.model.Driver;
import com.cab.mega.model.User;
import com.cab.mega.utils.database.DBConnectionFactory;
import com.cab.mega.utils.encryption.HashPassword;

import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {
    private static HashPassword getEncrypter() {
        return HashPassword.getHash();
    }
    @Override
    public int addUser(User user) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO user(first_name,last_name,nic,email,password,phone,gender,role_id) VALUES(?,?,?,?,?,?,?,?)";
        try{
            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1,user.getFirstName());
            statement.setString(2,user.getLastName());
            statement.setString(3,user.getNic());
            statement.setString(4,user.getEmail());
            statement.setString(5,getEncrypter().hashPassword(user.getPassword()));
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
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        return -1;
    }

    @Override
    public boolean updateUser(User user, int id) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "UPDATE user set first_name=?,last_name=?,nic=?,phone=?,gender=?,role_id=? where user_id=?";
        try{
            PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            statement.setString(1,user.getFirstName());
            statement.setString(2,user.getLastName());
            statement.setString(3,user.getNic());
            statement.setString(4,user.getPhone());
            statement.setString(5,user.getGender());
            statement.setInt(6,user.getRoleId());
            statement.setInt(7,id);
            statement.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteUser(int id) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "DELETE FROM user where user_id=?";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            statement.executeUpdate();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<User> getAllUsers() {
        Connection connection = DBConnectionFactory.getConnection();
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM user";
        try{
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                users.add(new Driver(
                        resultSet.getInt("user_id"),
                        resultSet.getInt("driverId"),
                        resultSet.getString("first_name"),
                        resultSet.getString("last_name"),
                        resultSet.getString("nic"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone"),
                        resultSet.getString("gender"),
                        resultSet.getInt("role_id"),
                        "",1,""));
            }
            System.out.println(users);
        }catch (SQLException e){
            e.printStackTrace();
        }
        return users;
    }
}
