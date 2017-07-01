package com.neu.abc.db;

public class SQLConstant {
	public static String QUERY_USER_BY_NM = "SELECT U_ID,U_NAME, U_NICK, U_DOB, U_GEN, "
			+ "U_EMAIL, U_PHONE_N, U_PHOTO_ADD, U_CRT_TM, U_ROLE "
			+ "FROM neu_abc_user  WHERE U_NAME = ? ";
	
	public static String CREAT_USER_T = "INSERT INTO neu_abc_user  "
			+ "(U_ID,U_NAME,U_PWD,U_EMAIL,U_PHONE_N,U_CRT_TM,U_ROLE)  "
			+ "VALUES (_nextval('U_ID'),?,?,?,?,sysdate(),'T');";
	
	public static String CREAT_USER_S = "INSERT INTO neu_abc_user  "
			+ "(U_ID,U_NAME,U_PWD,U_PHONE_N,U_EMAIL,U_CRT_TM,U_ROLE)  "
			+ "VALUES (_nextval('U_ID'),?,?,?,?,sysdate(),'S');";
	

	public static String QUERY_LOGIN_USER = "SELECT U_ID,U_NAME, U_NICK, U_DOB, U_GEN, "
			+ "U_EMAIL, U_PHONE_N, U_PHOTO_ADD, U_CRT_TM, U_ROLE "
			+ "FROM neu_abc_user  WHERE U_NAME = ? AND U_PWD = ?";	
	
	
	public static String UPDATE_USER = "UPDATE neu_abc_user "
			+ "SET U_NICK = ?, U_DOB = ?, U_GEN = ?, U_EMAIL = ?, U_PHOTO_ADD = ? "
			+ "WHERE U_ID = ?;";
	public static String DELETE_USER = "";
	public static String QUERY_ALL_USER = "";
	public static String QUERY_USER_BY_ID = "";

	public static String TBD = "";
}
