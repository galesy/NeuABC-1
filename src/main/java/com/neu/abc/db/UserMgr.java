package com.neu.abc.db;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import com.neu.abc.exceptions.DataAccessException;
import com.neu.abc.model.User;
import com.neu.abc.utils.PwdUtil;

public class UserMgr {
	private DBMgr conMgr;

	public void setConMgr(DBMgr conMgr) {
		this.conMgr = conMgr;
	}

	public User login(String username, String password) throws DataAccessException {
		if (username == null || password == null) {
			return null;
		}
		String pwd = PwdUtil.encryptPwd(password);
		List<String> paramList = new ArrayList<String>();
		paramList.add(username);
		paramList.add(pwd);
		int col = 10;
		List<String> list = conMgr.queryForOneRow(SQLConstant.QUERY_LOGIN_USER, paramList, col);
		if (list != null && list.size() == col) {
			User user = new User();
			user.setId(list.get(0));
			user.setName(list.get(1));
			user.setNick(list.get(2));
			user.setDob(list.get(3));
			user.setGen(list.get(4));
			user.setEmailAddr(list.get(5));
			user.setPhoneNumber(list.get(6));
			user.setPhoto(list.get(7));
			user.setCreateTime(list.get(8));
			user.setRole(list.get(9));
			return user;
		} else {
			return null;
		}
	}

	public User queryUser(String username) throws DataAccessException {
		if (username == null) {
			return null;
		}
		List<String> paramList = new ArrayList<String>();
		paramList.add(username);
		int col = 10;
		List<String> list = conMgr.queryForOneRow(SQLConstant.QUERY_USER_BY_NM, paramList, col);
		if (list != null && list.size() == col) {
			User user = new User();
			user.setId(list.get(0));
			user.setName(list.get(1));
			user.setNick(list.get(2));
			user.setDob(list.get(3));
			user.setGen(list.get(4));
			user.setEmailAddr(list.get(5));
			user.setPhoneNumber(list.get(6));
			user.setPhoto(list.get(7));
			user.setCreateTime(list.get(8));
			user.setRole(list.get(9));
			return user;
		} else {
			return null;
		}
	}
		
	public boolean createTeacher(String uname, String pwd, String email) throws DataAccessException {
		List<String> paramList = new ArrayList<String>();
		paramList.add(uname);
		paramList.add(PwdUtil.encryptPwd(pwd));
		paramList.add(email);
		return conMgr.executeUpdateSQL(SQLConstant.CREAT_USER_T, paramList);
	}
	public boolean createStudent(String phone, String pwd, String email) throws DataAccessException {
		List<String> paramList = new ArrayList<String>();
		paramList.add(phone);//username is phone number
		paramList.add(PwdUtil.encryptPwd(pwd));
		paramList.add(phone);
		paramList.add(email);
		return conMgr.executeUpdateSQL(SQLConstant.CREAT_USER_S, paramList);
	}
	
	public boolean updateUser(User user) throws DataAccessException{
		List<String> paramList = new ArrayList<String>();
		paramList.add( user.getNick() );
		paramList.add( user.getDob() );
		paramList.add( user.getGen() );
		paramList.add( user.getEmailAddr() );
		paramList.add( user.getPhoto() );
		paramList.add( user.getId() );		
		return conMgr.executeUpdateSQL(SQLConstant.UPDATE_USER, paramList);
	}
}
