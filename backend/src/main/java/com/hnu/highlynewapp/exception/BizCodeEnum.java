package com.hnu.highlynewapp.exception;

/**
 * 系统错误枚举
 */
public enum BizCodeEnum {
    INPUT_INVALID(9999, "数据不合法"),
    SERVER_EXCEPTION(10000, "服务器异常，请联系管理员"),
    USERNAME_PASSWORD_INVALID_EXCEPTION(10001, "用户名密码错误"),
    UPLOAD_FAIL_EXCEPTION(10002, "文件上传失败"),
    INFO_NOT_FOUND_EXCEPTION(10003, "查询的信息不存在");

    private int code;
    private String message;

    BizCodeEnum(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
