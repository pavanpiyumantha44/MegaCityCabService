package com.cab.mega.utils.encryption;
import org.mindrot.jbcrypt.BCrypt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashPassword {
    private static final int SALT_LENGTH = 16;
    private static HashPassword encrypter;

    public static synchronized HashPassword getHash() {
        if (encrypter == null) {
            encrypter = new HashPassword();
        }
        return encrypter;
    }
    public String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }

        return hexString.toString();
    }
}