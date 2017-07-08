package com.neu.abc.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.neu.abc.db.ClassMgr;
import com.neu.abc.exceptions.DataAccessException;
import com.neu.abc.model.ClassTimeFrame;
import com.neu.abc.model.User;
import com.neu.abc.utils.Constants;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/cls")
public class TrainingClassController {
	private static final Logger logger = LoggerFactory.getLogger(TrainingClassController.class);
	@Inject
	private ClassMgr classmgr;
	
	@RequestMapping(value = "/getTimeFrame", method = RequestMethod.GET)
	public String doStudent(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String uid=user.getId();
		
		List<ClassTimeFrame> list = classmgr.getAvailableTimeFrame(uid);		
		List<ClassTimeFrame> clses = classmgr.getStudentClasses(uid); 
		
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");  
		Date now = new Date();
		Calendar calendar = Calendar.getInstance(); 
		calendar.setTime(now);
		calendar.set(Calendar.MONDAY, calendar.get(Calendar.MONDAY) - 3);  
		String startPoint = formatter.format(calendar.getTime());
		String nowPoint = formatter.format(now );
		Calendar farFuture = Calendar.getInstance(); 
		farFuture.setTime(now);
		farFuture.set(Calendar.DATE, calendar.get(Calendar.DATE) + 15);  
		String endPoint = formatter.format(farFuture.getTime() );
		
		List<Map<String, String>> events = new ArrayList<Map<String, String>>();
		
		
		//先遍历用户已注册的课程，将StartPoint遍历到距离现在最近的一次上课结束时间
		for(int c=0;c<clses.size();c++){
			ClassTimeFrame cls = clses.get(c);
			if(nowPoint.compareTo(cls.getStartTime())<0){ //展现未学习过的课程
				events.add(createTimeEvent("Booked_"+c, cls.getStartTime(), cls.getEndTime(),"#4FF"));
			}else if(nowPoint.compareTo(cls.getEndTime())>0){ //展现已学习的内容
				events.add(createTimeEvent("NA_b"+c, startPoint, cls.getStartTime(),"#ff9f89"));
				startPoint=cls.getEndTime();				
			}else{//正在上课
				events.add(createTimeEvent("NA_b"+c, startPoint, cls.getStartTime(),"#ff9f89"));				
				events.add(createTimeEvent("Now_"+c, cls.getStartTime(), cls.getEndTime(),"#FF4"));
				startPoint=cls.getEndTime();
			}			
		}		
		//绘制不可选区域
		for (int i=0;i<list.size();i++){
			ClassTimeFrame ctf = list.get(i);
			if(startPoint.compareTo(ctf.getStartTime())<0){//发现有空白区域
				events.add(createTimeEvent("NA_a"+i, startPoint, ctf.getStartTime(),"#ff9f89"));	
				startPoint = ctf.getEndTime();
			}else if(endPoint.compareTo(ctf.getStartTime())<=0){	
				startPoint = ctf.getEndTime();
			}
		}
		events.add(createTimeEvent("NA_a", startPoint, endPoint,"#ff9f89"));
		
		JSONObject obj = new JSONObject();
		obj.accumulate("list", events);
		request.setAttribute("msg", obj.toString());
		logger.info(obj.toString());
		return "ajax";
	}
	
	private Map<String, String> createTimeEvent(String id, String start, String end, String color){
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("start", start);
		map.put("end", end);
		map.put("color", color);
		return map;
	}	
	
	@RequestMapping(value = "/tchConfirmDate", method = RequestMethod.POST)
	public String tchConfirmDate(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String tuid=user.getId();
		String stm = request.getParameter("startTime");
		String etm = request.getParameter("endTime");
		JSONObject obj = new JSONObject();
		//没有传时间过来
		if(stm==null||"".equals(stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "Sorry, please try again later");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		
		if(classmgr.confirmTeacherTime(tuid, stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "You have already active this period");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		
		classmgr.saveTeacherTime(tuid, stm, etm);
		obj.accumulate("status", "true");
		request.setAttribute("msg", obj.toString());
		return "ajax";
	}
	
	@RequestMapping(value = "/getTCalendar", method = RequestMethod.GET)
	public String getTeacherCalendar(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String uid=user.getId();
		
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");  
		Date now = new Date();
		Calendar stt = Calendar.getInstance(); 
		stt.setTime(now);
		stt.set(Calendar.MONDAY, stt.get(Calendar.MONDAY) - 3);  
		String startPoint = formatter.format(stt.getTime());
	
		Calendar farFuture = Calendar.getInstance(); 
		farFuture.setTime(now);
		farFuture.set(Calendar.DATE, farFuture.get(Calendar.DATE) + 30);  
		String endPoint = formatter.format(farFuture.getTime() );		
		
		String nowPoint = formatter.format(now );
		//获取距离now最近的下一个整半点
		
		Calendar nextNow = Calendar.getInstance(); 
		nextNow.setTime(now);
		nextNow.set(Calendar.SECOND, 00);
		if(nextNow.get(Calendar.MINUTE)<30){
			nextNow.set(Calendar.MINUTE, 30);
		}else{
			nextNow.set(Calendar.MINUTE, 0);
			nextNow.set(Calendar.HOUR, nextNow.get(Calendar.HOUR)+1);
		}		
		
		List<ClassTimeFrame> list = classmgr.getTeacherAvailableTM(uid, startPoint,endPoint);		
		JSONArray arr = new JSONArray();
		for(int i=0;i<list.size();i++){
			JSONObject obj = new JSONObject();
			
			//已经结束
			if(nowPoint.compareTo(list.get(i).getEndTime())>=0){
				if("0".equals(list.get(i).getNoOfStu())){//不展示已经过去的时间，并没人注册
					continue;
				}
				obj.accumulate("id", "Fin_"+i);
				obj.accumulate("txt", "Finished");
				arr.add(createNAFrame("NA_"+i,startPoint,list.get(i).getStartTime(),"")  );
				startPoint = list.get(i).getEndTime();
			}else if(nowPoint.compareTo(list.get(i).getStartTime())<0){//还未开始
				if(!"0".equals(list.get(i).getNoOfStu())){//不展示已经过去的时间，但没人注册
					obj.accumulate("id", "Rsv_"+i);
					obj.accumulate("txt", "Reserved");
				}else{
					obj.accumulate("id", "Ava_"+i);
					obj.accumulate("txt", "Available");
				}				
			}else{//正在上课
				if("0".equals(list.get(i).getNoOfStu())){//不展示当前没注册人数的时间
					continue;
				}
				obj.accumulate("id", "Run_"+i);
				obj.accumulate("txt", "Running Now");
				arr.add(createNAFrame("NA_"+i,startPoint,list.get(i).getStartTime(),"")  );
				startPoint = list.get(i).getEndTime();
			}
			obj.accumulate("start", list.get(i).getStartTime());
			obj.accumulate("end", list.get(i).getEndTime());
			arr.add(obj);
		}		
		
		String lastNA = formatter.format(nextNow.getTime());
		if(startPoint.compareTo(lastNA)<0){
			arr.add(createNAFrame("NA_N",startPoint,lastNA,"")  );
		}		
		
		request.setAttribute("msg", arr.toString());
		return "ajax";
	}
	
	private JSONObject createNAFrame(String id, String stt, String ett, String txt){
		JSONObject obj = new JSONObject();
		obj.accumulate("id", id);
		if(txt!=null && !"".equals(txt)){
			obj.accumulate("txt", "Running Now");			
		}
		obj.accumulate("start", stt);
		obj.accumulate("end", ett);
		return obj;
		
	}
	
	@RequestMapping(value = "/tchDeleteTime", method = RequestMethod.POST)
	public String tchDeleteTime(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String tuid=user.getId();
		String stm = request.getParameter("startTime");
		String etm = request.getParameter("endTime");
		JSONObject obj = new JSONObject();
		//没有传时间过来
		if(stm==null||"".equals(stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "Sorry, please try again later");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		
		if(classmgr.confirmStudentTime(tuid, stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "Some student already reserved this time");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		
		classmgr.deleteTeacherTime(tuid, stm);
		obj.accumulate("status", "true");
		request.setAttribute("msg", obj.toString());
		return "ajax";
	}
	
	@RequestMapping(value = "/preSelectEvent", method = RequestMethod.GET)
	public String preSelectEvent(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String uid=user.getId();
		String stm = request.getParameter("startTime");
		JSONObject obj = new JSONObject();
		if(stm==null||"".equals(stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "请选择一个时间");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		
		
		return "ajax";
	}
	
	
}
