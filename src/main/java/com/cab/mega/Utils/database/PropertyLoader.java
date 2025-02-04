package com.cab.mega.Utils.database;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class PropertyLoader {
    public static Properties getPropertyData(){
        try {
            Properties properties = new Properties();
            InputStream inputStream = PropertyLoader.class.getClassLoader().getResourceAsStream("database.properties");
            properties.load(inputStream);
            inputStream.close();
            return properties;
        }catch (IOException e){
            System.err.println(e.getMessage());
            return null;
        }
    }
}
