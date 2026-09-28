package com.hnu.highlynewapp.exception;

public class RegisterFailException extends Exception {
    private int code = 721;
    private String message;

    public RegisterFailException(String message) {
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
