package com.cab.mega.model;
import java.util.Collection;
import java.util.Map;

public class CommonResponseModel {
    final String message;
    final boolean isSuccess;
    private final Map<String, Object> data;

    public String getMessage() {
        return message;
    }

    public boolean isSuccess() {
        return isSuccess;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public CommonResponseModel(String message, boolean isSuccess, Map<String, Object> data) {
        this.message = message;
        this.isSuccess = isSuccess;
        this.data = data;
    }
}
