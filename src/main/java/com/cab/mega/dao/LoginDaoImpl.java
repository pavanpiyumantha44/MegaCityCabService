package com.cab.mega.dao;

import com.cab.mega.model.LoginModel;
import com.cab.mega.model.User;
import com.cab.mega.utils.database.DBConnectionFactory;
import com.cab.mega.utils.encryption.HashPassword;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDaoImpl implements LoginDao{

//    public static HashPassword getHashPassword(){
//        return HashPassword.getHashPassword();
//    }

    @Override
    public User getUserByEmail(String email) {
        String query = "SELECT user_id, first_name, email, role_id, password FROM user WHERE email = ? and password = ?";
        try {
            Connection connection = DBConnectionFactory.getConnection();
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();

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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}