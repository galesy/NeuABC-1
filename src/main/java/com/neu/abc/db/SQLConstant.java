package com.neu.abc.db;

public class SQLConstant {
	public static String QUERY_USER_BY_NM = "SELECT U_ID,U_NAME, U_NICK, U_DOB, U_GEN, "
			+ "U_EMAIL, U_PHONE_N, U_PHOTO_ADD, U_CRT_TM, U_ROLE "
			+ "FROM neu_abc_user  WHERE U_NAME = ? ";
	
	public static String CREAT_USER_T = "INSERT INTO neu_abc_user  "
			+ "(U_ID,U_NAME,U_PWD,U_EMAIL,U_CRT_TM,U_ROLE)  "
			+ "VALUES (_nextval('U_ID'),?,?,?,sysdate(),'T');";
	
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
	
	public static String ALL_TEACHER_AVAILABLE_TM="SELECT CLS_START, CLS_END FROM NEU_ABC_TCH_TM A, NEU_ABC_USER B "
			+ "WHERE A.U_ID = B.U_ID AND B.U_ROLE ='T' AND  A.U_ID IN "
			+" ( SELECT U_ID FROM NEU.NEU_ABC_TCH_PROD_TYPE WHERE P_TYPE IN  "
			+ "  ( SELECT P_TYPE FROM NEU.NEU_ABC_STU_PROD_TYPE "
			+ " WHERE U_ID=?"
			+ " ) ) and  cls_start > DATE_FORMAT(NOW(),'%Y-%m-%d %H:%i:%s') order by CLS_START " ;//大于现在的时间
			
	public static String TEACHER_CLASS_AVAILABLE
			= " SELECT A.U_ID, A.U_NICK, C.P_TYPE_NAME " //返回老师的 ID，名称，以及供选择的课
			+ " FROM NEU_ABC_USER A, NEU_ABC_PROD_TYPE C, "
			+ " ( " //学生可以上的课程，以及可以上这些课程的老师
			+ "  SELECT DISTINCT T2.U_ID, T2.P_TYPE FROM NEU_ABC_TCH_PROD_TYPE T2, NEU_ABC_STU_PROD_TYPE T1 "
			+ " WHERE T1.P_TYPE = T2.P_TYPE AND T1.U_ID = ?	  "
			+ " ) B "
			+ " WHERE A.U_ID = B.U_ID  AND  B.P_TYPE = C.P_TYPE_ID "
			+ " AND A.U_ID IN ( " //有时间的老师
			+ " SELECT DISTINCT U_ID FROM NEU_ABC_TCH_TM "
			+ " WHERE CLS_START <= ? AND CLS_END >= ? "
				//没有被其他同学占用的老师
			+ " AND U_ID NOT IN ( SELECT U_T_ID FROM NEU_ABC_TCH_STU_TM "
			+ " WHERE CLS_START = ? "
			+ " )  "
			+ " ) ;";
	
	public static String STUDENT_CLASSES = "SELECT A.CLS_START ,B.P_NAME, c.P_TYPE_NAME, d.U_NICK "
			+ " FROM neu_abc_tch_stu_tm A, neu_abc_prod B, neu_abc_prod_type c, neu_abc_user d "
			+ " WHERE A.CLS_PROD = B.P_ID and b.p_type_id = c.P_TYPE_ID and a.U_T_ID = d.u_id "
			+ " AND a.U_S_ID = ? order by CLS_START ";
	
	public static String GET_USER_PROD_TYPE = "SELECT P_TYPE FROM NEU_ABC_TCH_PROD_TYPE WHERE U_ID = ? ";
	public static String CONFIRM_TEACHER_TIME = " SELECT U_ID FROM NEU_ABC_TCH_TM "
										+" WHERE U_ID = ? AND CLS_START = ?";
	public static String CREATE_TEACHER_TIME =" INSERT INTO NEU_ABC_TCH_TM  "
			+ " (U_ID,CLS_START,CLS_END) VALUES (?, ? ,?); ";
	public static String GET_TEACHER_AVAILABLE_TM = "	SELECT A.CLS_START, A.CLS_END, COUNT(B.U_S_ID) "
			+ "	FROM NEU_ABC_TCH_TM A LEFT JOIN NEU_ABC_TCH_STU_TM B "
			+ "	ON A.U_ID = B.U_T_ID AND A.CLS_START = B.CLS_START "
			+ "	WHERE U_ID =  ? AND A.CLS_START >= ? AND A.CLS_END <= ? "
			+ " GROUP BY  A.CLS_START, A.CLS_END "
			+ " ORDER BY CLS_START ";
	
	public static String CONFIRM_STUDENT_TM = " SELECT U_S_ID FROM neu_abc_tch_stu_tm "
			+ " WHERE U_T_ID = ? AND CLS_START = ? ";
	
	public static String DELETE_TEACHER_TM = "DELETE FROM neu_abc_tch_tm "
			+ "WHERE U_ID = ? AND CLS_START = ? ";
	
	public static String GET_TEACHER_BY_STARTTM = " SELECT A.U_ID, A.U_NICK, P_TYPE, P_TYPE_NAME, COUNT(B.U_S_ID)  FROM "
			+ " (SELECT A.U_ID, C.U_NICK, CLS_START, P_TYPE, P_TYPE_NAME FROM NEU_ABC_TCH_TM A  , NEU_ABC_TCH_PROD_TYPE B, NEU_ABC_USER C, "
			+ " (SELECT DISTINCT B.P_TYPE_ID, B.P_TYPE_NAME FROM NEU_ABC_STU_PROD_TYPE A, NEU_ABC_PROD_TYPE B "
			+ "  WHERE A.U_ID= ? AND A.P_TYPE = B.P_TYPE_ID ) T "
			+ " WHERE A.CLS_START = ?  AND T.P_TYPE_ID = B.P_TYPE "
			+ " AND A.U_ID = C.U_ID AND A.U_ID = B.U_ID) A  LEFT JOIN NEU_ABC_TCH_STU_TM B "
			+ " ON A.U_ID = B.U_T_ID AND A.CLS_START = B.CLS_START "
			+ " GROUP BY A.U_ID, A.U_NICK,P_TYPE, P_TYPE_NAME order by a.u_id ";
	
	public static String GET_ALL_PRODUCT_BY_USER = " SELECT A.p_id, a.p_name, a.p_type_id  FROM NEU_ABC_PROD A, "
			+ " NEU_ABC_PROD_TYPE B, NEU_ABC_STU_PROD_TYPE C "
			+ " WHERE A.P_TYPE_ID = B.P_TYPE_ID AND B.P_TYPE_ID = C.P_TYPE"
			+ " AND C.U_ID = ? order by a.p_type_id ";
	
	public static String SAVE_CLS_FOR_STU = " INSERT INTO NEU_ABC_TCH_STU_TM "
			+ " (U_T_ID, U_S_ID,CLS_START,CLS_STATUS,CLS_PROD) "
			+ " VALUES(?,?,?, 'R',?); ";//Reserved
	
	public static String CANCEL_STU_CLASS = " DELETE from neu_abc_tch_stu_tm "
			+" WHERE U_S_ID=? AND CLS_START= ? ";
	
	public static String CANCEL_TEACHER_CLASS = " DELETE from neu_abc_tch_stu_tm "
			+" WHERE U_T_ID=? AND CLS_START= ? ";
	
	public static String QUERY_CLASS_DETAILS =" SELECT B.U_ID, B.U_NICK, C.P_ID, C.P_NAME, D.P_TYPE_ID, D.P_TYPE_NAME "
			+ " FROM NEU_ABC_TCH_STU_TM A, NEU_ABC_USER B, NEU_ABC_PROD C, NEU_ABC_PROD_TYPE D "
			+ " WHERE A.U_T_ID = B.U_ID AND A.CLS_PROD = C.P_ID AND C.P_TYPE_ID = D.P_TYPE_ID "
			+ " AND A.U_S_ID = ? AND A.CLS_START = ?";
	public static String QUERY_CLASS_DETAILS_TEACHER = " SELECT B.U_ID, B.U_NICK, C.P_ID, C.P_NAME, D.P_TYPE_ID, D.P_TYPE_NAME, B.U_PHOTO_ADD "
			+ " FROM NEU_ABC_TCH_STU_TM A, NEU_ABC_USER B, NEU_ABC_PROD C, NEU_ABC_PROD_TYPE D "
			+ " WHERE A.U_S_ID = B.U_ID AND A.CLS_PROD = C.P_ID AND C.P_TYPE_ID = D.P_TYPE_ID "
			+ " AND A.U_T_ID = ? AND A.CLS_START = ?";
	public static String UPDATE_USER_ENG_LEV = " UPDATE NEU_ABC_USER SET U_EXT = ? WHERE U_ID = ? ";
	
	public static String ADD_DEFAULT_PRODUCT_S = "INSERT INTO neu_abc_stu_prod_type  (U_ID,P_TYPE) VALUES (?,11);" ;
	
	public static String ADD_DEFAULT_PRODUCT_T = "INSERT INTO neu_abc_tch_prod_type  (U_ID,P_TYPE) VALUES (?,11);" ;
	
	public static String QUERY_CLASS_ROOM = "select room_id, room_name from neu_abc_cls_room where t_id = ? and  cls_start = ? "; 
	
	public static String CREATE_CLASS_ROOM = "INSERT INTO neu_abc_cls_room (t_id,  room_id, room_name,cls_start)VALUES(?,?,?,?) " ;
}
