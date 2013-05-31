package com.raysmond.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
public class DateUtil {
	public static Timestamp getSystemTimestamp(){
		java.util.Date date = new java.util.Date();
	    Timestamp timeStamp = new Timestamp(date.getTime());
	    return timeStamp;
	}
	
	public static String getTimestampString(Timestamp time){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		return  sdf.format(time); 
	}
	
	public static void main(String[] args){
		System.out.print(getTimestampString(DateUtil.getSystemTimestamp()));
	}
}
