package com.hnu.highlynewapp.transformation.enums;

public enum MaturityEnum {
    STATUS_ONE(1, "正在研发"),
    STATUS_TWO(2, "已有样品"),
    STATUS_THREE(3, "通过小试"),
    STATUS_FOUR(4, "通过中试"),
    STATUS_FIVE(5, "可以量产");
    private int code;
    private String message;

    MaturityEnum(int code, String message) {
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
        for (MaturityEnum maturityEnum : MaturityEnum.values()) {
            if (maturityEnum.getMessage().equals(message))
                code = maturityEnum.getCode();
        }
        return code;
    }
}
