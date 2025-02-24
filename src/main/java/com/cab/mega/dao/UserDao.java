package com.cab.mega.dao;

import com.cab.mega.model.User;

import java.util.List;

public interface UserDao {
    public int addUser(User user);
    public List<User> getAllUsers();
}
