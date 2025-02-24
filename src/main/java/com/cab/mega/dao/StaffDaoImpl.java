package com.cab.mega.dao;

import com.cab.mega.model.Driver;
import com.cab.mega.model.Staff;
import com.cab.mega.utils.database.DBConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StaffDaoImpl implements StaffDao {
    @Override
    public void addStaff(Staff staff) {
        Connection connection = DBConnectionFactory.getConnection();
        String query = "INSERT INTO staff(user_id,job_title) VALUES(?,?)";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1,staff.getUserId());
            statement.setString(2,staff.getJobTitle());
            statement.executeUpdate();
        }catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Staff> getAllStaff() {
        List<Staff> staff = new ArrayList<>();
        Connection connection = DBConnectionFactory.getConnection();
        String query = "SELECT u.user_id,s.staff_id,u.first_name,u.last_name,u.nic,email,u.password,u.phone,gender,u.role_id,s.job_title from user as u join staff as s on u.user_id=s.user_id";
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()){
                staff.add(new Staff(
                        resultSet.getInt("user_id"),
                        resultSet.getString("first_name"),
                        resultSet.getString("last_name"),
                        resultSet.getString("nic"),
                        resultSet.getString("email"),
                        resultSet.getString("password"),
                        resultSet.getString("phone"),
                        resultSet.getString("gender"),
                        resultSet.getInt("role_id"),
                        resultSet.getInt("staff_id"),
                        resultSet.getString("job_title")));
            }

        }catch (SQLException e){
            e.printStackTrace();
        }
        return staff;
    }
}