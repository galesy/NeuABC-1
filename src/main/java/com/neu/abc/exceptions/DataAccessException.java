package com.neu.abc.exceptions;

public class DataAccessException extends Throwable {
	private static final long serialVersionUID = 3406579414328697032L;

	public DataAccessException(Throwable e){
		super(e);
	}
}
