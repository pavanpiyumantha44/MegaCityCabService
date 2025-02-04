package com.cab.mega.Utils.database;

import java.sql.Connection;

public class DBConnectionFactory {
    public static Connection getConnection() {
        return DBConnection.getInstance().getConnection();
    }
}
