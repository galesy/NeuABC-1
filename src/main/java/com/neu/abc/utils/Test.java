package com.neu.abc.utils;

import org.springframework.util.DigestUtils;

public class Test {

	public static void main(String[] args) {
		System.out.println(DigestUtils.md5DigestAsHex("neusoft".getBytes()));

	}

}
