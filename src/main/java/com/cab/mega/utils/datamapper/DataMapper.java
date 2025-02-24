package com.cab.mega.utils.datamapper;

import com.google.gson.JsonObject;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class DataMapper {
    private static DataMapper dataMapper;

    private DataMapper() {
        // Private constructor to enforce singleton pattern
    }

    public static synchronized DataMapper getDataMapper() {
        if (dataMapper == null) {
            dataMapper = new DataMapper();
        }
        return dataMapper;
    }

    public String mapData(HttpServletRequest request) {
        JsonObject requestJson = new JsonObject();
        for (Map.Entry<String, String[]> entry : request.getParameterMap().entrySet()) {
            requestJson.addProperty(entry.getKey(), entry.getValue()[0]);
        }
        //System.out.println(requestJson);
        return requestJson.toString();
    }
}