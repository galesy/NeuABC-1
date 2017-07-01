package com.neu.abc.utils;

import org.springframework.util.DigestUtils;

public class PwdUtil {
	public static String encryptPwd(String pwd) {
		if (pwd != null) {
			return DigestUtils.md5DigestAsHex(pwd.getBytes());
		} else {
			return null;
		}
	}
	
}
