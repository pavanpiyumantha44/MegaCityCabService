package com.cab.mega.dao;

import com.cab.mega.model.Staff;
import com.cab.mega.model.Customer;
import com.cab.mega.model.Driver;
import com.cab.mega.model.User;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterDaoImpl implements RegisterDao{
    @Override
    public int registerUser(User user) {
        return 0;
    }

    @Override
    public boolean registerAdmin(Staff admin) {
//        String regex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
//        Pattern emailPattern = Pattern.compile(regex);
//        Matcher emailMatcher =emailPattern.matcher(admin.getEmail());
//        Pattern phonePattern = Pattern.compile("[^\\d+]");
//        Matcher phoneMatcher = phonePattern.matcher(admin.getPhone());
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO admin(user_id,password) VALUES(?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.executeUpdate();
        }catch (SQLException e){
            e.printStackTrace();
        }
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
}
