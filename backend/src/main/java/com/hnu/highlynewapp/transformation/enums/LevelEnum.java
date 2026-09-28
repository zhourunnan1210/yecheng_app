package com.hnu.highlynewapp.transformation.enums;

public enum LevelEnum {
    STATUS_ONE(1, "国际领先"),
    STATUS_TWO(2, "国际先进"),
    STATUS_THREE(3, "国内领先"),
    STATUS_FOUR(4, "国内先进"),
    STATUS_FIVE(5, "国内一般"),
    STATUS_SIX(6, "未评价");
    private int code;
    private String message;

    LevelEnum(int code, String message) {
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
        for (LevelEnum levelEnum : LevelEnum.values()) {
            if (levelEnum.getMessage().equals(message))
                code = levelEnum.getCode();
        }
        return code;
    }
}
