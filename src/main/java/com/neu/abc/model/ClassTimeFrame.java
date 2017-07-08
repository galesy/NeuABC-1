package com.neu.abc.model;

public class ClassTimeFrame {
	private String className;

	private String startTime;
	private String endTime;	

	private String teacherNick;
	private String prodName;
	private String prodType;
	
	private String noOfStu;

	public String getNoOfStu() {
		return noOfStu;
	}

	public void setNoOfStu(String noOfStu) {
		this.noOfStu = noOfStu;
	}

	public String getTeacherNick() {
		return teacherNick;
	}

	public void setTeacherNick(String teacherNick) {
		this.teacherNick = teacherNick;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public String getProdType() {
		return prodType;
	}

	public void setProdType(String prodType) {
		this.prodType = prodType;
	}


	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
}
