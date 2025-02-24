package com.cab.mega.model;
import java.util.Collection;

public class CommonResponseModel {
    final String message;
    final boolean isSuccess;
    final Collection data;

    public String getMessage() {
        return message;
    }

    public boolean isSuccess() {
        return isSuccess;
    }

    public Collection getData() {
        return data;
    }

    public CommonResponseModel(String message, boolean isSuccess, Collection data) {
        this.message = message;
        this.isSuccess = isSuccess;
        this.data = data;
    }
}
