package com.neu.abc.utils;

import java.util.Date;

import com.duobeiyun.DuobeiYunClient;
import com.duobeiyun.DuobeiYunConfig;

public class DuoBeiUtil {
	public static void main(String args[]) {
	}

	public static String createRoom(String title, Date StartTime, int duration) {
		DuobeiYunClient client = new DuobeiYunClient();
		String result = client.createRoom(title, // title
				StartTime, // startTime
				duration, // duration
				true, // video
				DuobeiYunClient.COURSE_TYPE_1v1 // roomType
		);
		System.out.println(DuobeiYunConfig.getInstance().getAppKey());
		return result;
	}
	
	public static String getRoomLink(String uid, String unick, String roomId, String role){
		DuobeiYunClient client = new DuobeiYunClient();
		return client.generateRoomEnterUrl(
				uid ,// uid
			      unick,                          // nickname
			      roomId, // roomId
			      role,         // userRole
			      DuobeiYunClient.DEVICE_TYPE_PC        //deviceType
			  );
	}
}
