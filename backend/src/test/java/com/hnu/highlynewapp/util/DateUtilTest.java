package com.hnu.highlynewapp.util;

import com.hnu.highlynewapp.utils.DateUtil;
import org.junit.Test;

import java.util.Calendar;
import java.util.List;

/**
 * @author zhourunnan
 * @Date 2021/9/22 21:00
 */
public class DateUtilTest {

    @Test
    public void testTimeIndex() {
        System.out.println(Calendar.getInstance().getTime());
    }

    @Test
    public void testGetTimeIndex() {
        List<String> timeIndex = DateUtil.getTimeIndex();
        System.out.println(timeIndex);
    }
}
