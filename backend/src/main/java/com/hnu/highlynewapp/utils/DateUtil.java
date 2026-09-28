package com.hnu.highlynewapp.utils;

import com.google.common.collect.Lists;

import java.util.*;

/**
 * @author zhourunnan
 * @Date 2021/9/22 20:51
 */
public class DateUtil {
    private static Map<String, Date> timeIndexMap = new HashMap<>();

    static {
        timeIndexMap.put("全部", null);
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MONTH, -1);
        timeIndexMap.put("一个月内", c.getTime());
        c = Calendar.getInstance();
        c.add(Calendar.MONTH, -3);
        timeIndexMap.put("三个月内", c.getTime());
        c = Calendar.getInstance();
        c.add(Calendar.MONTH, -6);
        timeIndexMap.put("六个月内", c.getTime());
        c = Calendar.getInstance();
        c.add(Calendar.YEAR, -1);
        timeIndexMap.put("一年内", c.getTime());
    }

    public static List<String> getTimeIndex() {
        return Lists.newArrayList("一个月内", "三个月内", "六个月内", "一年内");
    }

    public static Date getStartDateByTimeIndex(String timeIndex) {
        return timeIndexMap.get(timeIndex);
    }
}
