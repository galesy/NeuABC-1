package com.neu.abc.db;

import java.util.ArrayList;
import java.util.List;

import com.neu.abc.exceptions.DataAccessException;
import com.neu.abc.model.ClassTimeFrame;

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
}
