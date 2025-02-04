package com.cab.mega.Utils.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static String DB_URL;
    private static String DB_USER;
    private static String DB_PASSWORD;
    private static DBConnection instance;
    private Connection connection;

    private DBConnection() {
        try {
            Properties properties = PropertyLoader.getPropertyData();

            DB_URL = properties.getProperty("mysql.url");
            DB_USER = properties.getProperty("mysql.username");
            DB_PASSWORD = properties.getProperty("mysql.password");
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        }catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
    public static DBConnection getInstance() {
        if(instance == null) {
            synchronized (DBConnection.class) {
                if(instance == null){
                    instance = new DBConnection();
                }
            }
        }
        return instance;
    }

    public Connection getConnection() {
        return connection;
    }
}
