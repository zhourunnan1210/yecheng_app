package com.hnu.highlynewapp.enums;

public enum StatusEnum {
    STATUS_ZERO(0, "未审核"),
    STATUS_ONE(1, "正在审核"),
    STATUS_TWO(2, "审核通过"),
    STATUS_THREE(3, "审核失败");
    private int code;
    private String message;

    StatusEnum(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public static Integer findCodeByMsg(String message) {
        Integer code = null;
        for (StatusEnum statusEnum : StatusEnum.values()) {
            if (statusEnum.getMessage().equals(message))
                code = statusEnum.getCode();
        }
        return code;
    }

    public static String findMsgByCode(Integer code) {
        String msg = null;
        for (StatusEnum statusEnum : StatusEnum.values()) {
            if (statusEnum.getCode() == code)
                msg = statusEnum.getMessage();
        }
        return msg;
    }
}
