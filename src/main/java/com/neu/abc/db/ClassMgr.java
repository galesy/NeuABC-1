package com.neu.abc.db;

import java.util.ArrayList;
import java.util.List;

import com.neu.abc.exceptions.DataAccessException;
import com.neu.abc.model.ClassTimeFrame;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ClassMgr {
	private DBMgr conMgr;

	public void setConMgr(DBMgr conMgr) {
		this.conMgr = conMgr;
	}
	
	public List<ClassTimeFrame> getAvailableTimeFrame(String uid) throws DataAccessException{
		List<String> paramList = new ArrayList<String>();
		paramList.add(uid);
		List<List<String>> result = conMgr.executeQuerySQL(SQLConstant.ALL_TEACHER_AVAILABLE_TM, paramList, 2);
		
		List<ClassTimeFrame> list = new ArrayList<ClassTimeFrame>();
		if(result.size()==0){
			return list;
		}else{
			for(int i=0;i<result.size();i++){
				List<String> temp = result.get(i);
				ClassTimeFrame frame = new ClassTimeFrame();
				frame.setStartTime(temp.get(0));
				frame.setEndTime(temp.get(1));
				list.add(frame);
			}
			return list;
		}		
	}
	//用户已经选择的课程，具体到每节课
	public List<ClassTimeFrame> getStudentClasses (String uid) throws DataAccessException{
		List<String> paramList = new ArrayList<String>();
		paramList.add(uid);
		List<List<String>> result = conMgr.executeQuerySQL(SQLConstant.STUDENT_CLASSES, paramList, 4);
		
		List<ClassTimeFrame> list = new ArrayList<ClassTimeFrame>();
		if(result.size()==0){
			return list;
		}else{
			for(int i=0;i<result.size();i++){
				List<String> temp = result.get(i);
				ClassTimeFrame cls = new ClassTimeFrame();
				cls.setStartTime(temp.get(0));
				cls.setProdName(temp.get(1));
				cls.setProdType(temp.get(2));
				cls.setTeacherNick(temp.get(3));
				list.add(cls);
			}
			return list;
		}		
	}
	//用户购买的课程类别(如果是老师，就是老师可以教的课程类别)
	public List<String> getProductTypeByUser(String uid) throws DataAccessException {
		List<String> paramList = new ArrayList<String>();
		paramList.add(uid);
		return conMgr.queryForOneCol(SQLConstant.GET_USER_PROD_TYPE, paramList);
	}
	//确认老师是否这个时间available
	public boolean confirmTeacherTime(String tuid, String stm) throws DataAccessException {
		List<String> paramList = new ArrayList<String>();
		paramList.add(tuid);
		paramList.add(stm);
		List<String> rst = conMgr.queryForOneRow(SQLConstant.CONFIRM_TEACHER_TIME, paramList, 1);
		if(rst !=null && rst.size() > 0){
			return true;
		}else{
			return false;
		}
	}
	//保存老师available的时间段
	public boolean saveTeacherTime(String tuid, String stm, String etm) throws DataAccessException {
		List<String> paramList = new ArrayList<String>();
		paramList.add(tuid);
		paramList.add(stm);
		paramList.add(etm);
		return conMgr.executeUpdateSQL(SQLConstant.CREATE_TEACHER_TIME, paramList);
	}
	
	//删除老师available的时间段
		public boolean deleteTeacherTime(String tuid, String stm) throws DataAccessException {
			List<String> paramList = new ArrayList<String>();
			paramList.add(tuid);
			paramList.add(stm);
			return conMgr.executeUpdateSQL(SQLConstant.DELETE_TEACHER_TM, paramList);
		}
	
	//老师已安排的时间，具体到每节课
	public List<ClassTimeFrame> getTeacherAvailableTM (String uid, String stt, String ett) throws DataAccessException{
			List<String> paramList = new ArrayList<String>();
			paramList.add(uid);
			paramList.add(stt);
			paramList.add(ett);
			//start， end， number of registered attendees
			List<List<String>> result = conMgr.executeQuerySQL(SQLConstant.GET_TEACHER_AVAILABLE_TM, paramList, 3);
			
			List<ClassTimeFrame> list = new ArrayList<ClassTimeFrame>();
			if(result.size()==0){
				return list;
			}else{
				for(int i=0;i<result.size();i++){
					List<String> temp = result.get(i);
					ClassTimeFrame cls = new ClassTimeFrame();
					cls.setStartTime(temp.get(0));
					cls.setEndTime(temp.get(1));
					cls.setNoOfStu(temp.get(2));
					list.add(cls);
				}
				return list;
			}		
		}
	//确保某一个课程有人注册
	public boolean confirmStudentTime(String tuid, String stm) throws DataAccessException{
		List<String> paramList = new ArrayList<String>();
		paramList.add(tuid);
		paramList.add(stm);
		List<String> rst = conMgr.queryForOneRow(SQLConstant.CONFIRM_STUDENT_TM, paramList, 1);
		if(rst !=null && rst.size() > 0){
			return true;
		}else{
			return false;
		}
	}

	public boolean saveStudentTime(String uid, String stm, String tid, String pid)  throws DataAccessException{
		List<String> params = new ArrayList<String>();

		params.add(tid);
		params.add(uid);
		params.add(stm);
		params.add(pid);
		
		return conMgr.executeUpdateSQL(SQLConstant.SAVE_CLS_FOR_STU, params);
	}

	public JSONArray getTeacherByTime(String uid, String stm) throws DataAccessException {
		JSONArray arr = new JSONArray();
		List<String> params = new ArrayList<String>();
		params.add(uid);
		params.add(stm);
		List<List<String>> result = conMgr.executeQuerySQL(SQLConstant.GET_TEACHER_BY_STARTTM, params, 5);		
		if(result.size()==0){
			return arr;
		}else{			
			for(int i=0;i<result.size();i++){
				JSONObject obj = new JSONObject();
				List<String> temp = result.get(i);
				obj.accumulate("tid", temp.get(0));
				obj.accumulate("tnick", temp.get(1));
				obj.accumulate("ptypeid", temp.get(2));
				obj.accumulate("ptypename", temp.get(3));
				obj.accumulate("count", temp.get(4));
				arr.add(obj);
			}
			return arr;
		}		
		
	}

	public JSONArray getAllProductsOfUser(String uid)  throws DataAccessException{
		List<String> params = new ArrayList<String>();
		params.add(uid);
		List<List<String>> result = conMgr.executeQuerySQL(SQLConstant.GET_ALL_PRODUCT_BY_USER, params, 3);
		
		if(result.size()==0){
			return new JSONArray();
		}else{
			JSONArray arr = new JSONArray();
			for(int i=0;i<result.size();i++){
				JSONObject obj = new JSONObject();
				List<String> temp = result.get(i);
				obj.accumulate("pid", temp.get(0));
				obj.accumulate("pname", temp.get(1));
				obj.accumulate("ptype", temp.get(2));
				arr.add(obj);
			}
			return arr;
		}		
		
	}
	//Cancel Student's class. 
	//TODO notification to teacher?
	public boolean cancelStudentClass(String uid, String stm) throws DataAccessException {
		List<String> params = new ArrayList<String>();
		params.add(uid);
		params.add(stm);
		return conMgr.executeUpdateSQL(SQLConstant.CANCEL_STU_CLASS, params);
		
	}

	public JSONObject getClassDetails(String uid, String stm) throws DataAccessException{
		List<String> params = new ArrayList<String>();
		params.add(uid);
		params.add(stm);
		List<String> result = conMgr.queryForOneRow(SQLConstant.QUERY_CLASS_DETAILS, params, 6);
		if(result.size()==0){
			return new JSONObject();
		}else{
			JSONObject obj = new JSONObject();
			obj.accumulate("tid", result.get(0));
			obj.accumulate("tnick", result.get(1));
			obj.accumulate("pid", result.get(2));
			obj.accumulate("pname", result.get(3));
			obj.accumulate("typeid", result.get(4));
			obj.accumulate("typename", result.get(5));
			return obj;
		}		
		
	}
	
	public JSONObject getClassDetailForTeacher(String tid, String stm) throws DataAccessException{
		List<String> params = new ArrayList<String>();
		params.add(tid);
		params.add(stm);
		List<String> result = conMgr.queryForOneRow(SQLConstant.QUERY_CLASS_DETAILS_TEACHER, params, 7);
		if(result.size()==0){
			return new JSONObject();
		}else{
			JSONObject obj = new JSONObject();
			obj.accumulate("sid", result.get(0));
			obj.accumulate("snick", result.get(1));
			obj.accumulate("pid", result.get(2));
			obj.accumulate("pname", result.get(3));
			obj.accumulate("typeid", result.get(4));
			obj.accumulate("typename", result.get(5));
			obj.accumulate("sphoto", result.get(6));
			return obj;
		}		
		
	}
	//TODO notification to student?
	public boolean cancelTeacherClass(String uid, String stm) throws DataAccessException {
		List<String> params = new ArrayList<String>();
		params.add(uid);
		params.add(stm);
		return conMgr.executeUpdateSQL(SQLConstant.CANCEL_TEACHER_CLASS, params);
		
	}

}
