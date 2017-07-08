package com.neu.abc.model;

import java.util.ArrayList;
import java.util.List;

public class User {
	private String id;
	private String name;
	private String pwd;
	private String encryptPwd;
	private int age;
	private String dob;
	private String role;
	private String nick;
	private String gen;
	private String emailAddr;
	private String phoneNumber;
	private String photo;
	private String createTime;
	private List<String> prodTypes;
	
	public User(){
		this.prodTypes = new ArrayList<String>();
	}

	public List<String> getProdTypes() {
		return prodTypes;
	}
	public void setProdTypes(List<String> prodTypes) {
		this.prodTypes = prodTypes;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEncryptPwd() {
		return encryptPwd;
	}
	public void setEncryptPwd(String encryptPwd) {
		this.encryptPwd = encryptPwd;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getGen() {
		return gen;
	}
	public void setGen(String gen) {
		this.gen = gen;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
