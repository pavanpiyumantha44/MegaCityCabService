package com.cab.mega.dao;

import com.cab.mega.model.User;

import java.util.List;

public interface UserDao {
    public int addUser(User user);
    public boolean updateUser(User user, int id);
    public boolean deleteUser(int id);
    public List<User> getAllUsers();
}
