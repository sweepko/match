package com.sweep.utils;

import javafx.scene.input.DataFormat;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeUtil {
    public static String getCurrentTime(){
        Date date=new Date();
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd-HH:mm:ss");
        return format.format(date);
    }

    public static void main(String[] args) {
        MD5_Encoding m=new MD5_Encoding();
        System.out.println(m.getMD5ofStr("admin"));
    }
}
