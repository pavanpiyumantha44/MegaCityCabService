package com.cab.mega.model;

import com.google.gson.annotations.SerializedName;

public class LoginModel {
    @SerializedName("email")
    String email;
    @SerializedName("password")
    String password;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
