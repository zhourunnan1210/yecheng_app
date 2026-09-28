package com.hnu.highlynewapp.transformation.enums;

public enum EvaluationStatusEnum {
    STATUS_ZERO(0, "未评估"),
    STATUS_ONE(1, "正在评估"),
    STATUS_TWO(2, "评估完成");
    private int code;
    private String message;

    EvaluationStatusEnum(int code, String message) {
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
        for (EvaluationStatusEnum statusEnum : EvaluationStatusEnum.values()) {
            if (statusEnum.getMessage().equals(message))
                code = statusEnum.getCode();
        }
        return code;
    }

    public static String findMessageByCode(Integer code) {
        String message = "";
        for (EvaluationStatusEnum value : EvaluationStatusEnum.values()) {
            if (value.code == code) {
                message = value.getMessage();
            }
        }
        return message;
    }
}
