package com.neu.abc.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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
import net.sf.json.JSONNull;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/cls")
public class TrainingClassController {
	private static final Logger logger = LoggerFactory.getLogger(TrainingClassController.class);
	@Inject
	private ClassMgr classmgr;
	
	private String RESERVED = "#4B824B";
	private String RUNING_NOW = "#BF3EFF";
	private String FINISHED = "#6495ED";
	private String AVAILABLE = "#00C5CD" ;
	
	//获取学生可以选的时段
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
		
		JSONArray arr = new JSONArray();
		List<ClassTimeFrame> futureClasses = new ArrayList<ClassTimeFrame>();
		
		//先遍历用户已注册的课程，将StartPoint遍历到距离现在最近的一次上课结束时间
		for(int c=0;c<clses.size();c++){
			ClassTimeFrame cls = clses.get(c);
			if(nowPoint.compareTo(cls.getStartTime())<0){ //展现未学习过的课程
				arr.add(createNAFrame("Rsv_"+c, cls.getStartTime(), cls.getEndTime(),"已预约",RESERVED));
				futureClasses.add(cls);
			}else if(nowPoint.compareTo(cls.getEndTime())>0){ //展现已学习的内容
				arr.add(createNAFrame("NA_"+c,startPoint,cls.getStartTime(),"")  );
				arr.add(createNAFrame("Fin_"+c, cls.getStartTime(), cls.getEndTime(),"已结束",FINISHED));				
				startPoint=cls.getEndTime();				
			}else{//正在上课
				arr.add(createNAFrame("NA_"+c, startPoint, cls.getStartTime(),""));				
				arr.add(createNAFrame("Run_"+c, cls.getStartTime(), cls.getEndTime(),"正在上课",RUNING_NOW));
				startPoint=cls.getEndTime();
			}			
		}		
		//绘制不可选区域，大于现在时间
		int f = 0;
		for (int i=0;i<list.size();){
			ClassTimeFrame ctf = list.get(i);
			if(startPoint.compareTo(ctf.getStartTime())<0){//发现有空白区域(无法注册的区域)
				//空白区有已经注册的课				
				if(f< futureClasses.size() && futureClasses.get(f).getStartTime().compareTo(ctf.getStartTime())<=0){
					ClassTimeFrame fcls = futureClasses.get(f);
					arr.add(createNAFrame("NA_f"+i, startPoint, fcls.getStartTime(),""));
					startPoint = fcls.getEndTime();
					f++;
					continue;
				}
				arr.add(createNAFrame("NA_f"+i, startPoint, ctf.getStartTime(),""));	
				startPoint = ctf.getEndTime();
			}else if(startPoint.compareTo(ctf.getStartTime())>=0){	
				if(f< futureClasses.size() && futureClasses.get(f).getEndTime().compareTo(ctf.getEndTime())<=0){
					f++;
					continue;
				}
				startPoint = ctf.getEndTime();
			}
			i++;
		}
		
		for(;f<futureClasses.size();f++){
			arr.add(createNAFrame("NA_a", startPoint, futureClasses.get(f).getStartTime(),""));
			startPoint = futureClasses.get(f).getEndTime();
		}
		arr.add(createNAFrame("NA_a", startPoint, endPoint,""));
		cleanNullItemInJSONArray(arr);
		request.setAttribute("msg", arr.toString());
		logger.info(arr.toString());
		return "ajax";
	}
	
	private void cleanNullItemInJSONArray(JSONArray arr){
		for(Object obj:arr){
			if(obj instanceof JSONNull){
				arr.remove(obj);
			}
		}
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
				obj.accumulate("color", FINISHED);
				arr.add(createNAFrame("NA_"+i,startPoint,list.get(i).getStartTime(),"")  );
				startPoint = list.get(i).getEndTime();
			}else if(nowPoint.compareTo(list.get(i).getStartTime())<0){//还未开始
				if(!"0".equals(list.get(i).getNoOfStu())){//不展示已经过去的时间，但没人注册
					obj.accumulate("id", "Rsv_"+i);
					obj.accumulate("txt", "Reserved");
					obj.accumulate("color", RESERVED);
				}else{
					obj.accumulate("id", "Ava_"+i);
					obj.accumulate("txt", "Available");
					obj.accumulate("color", AVAILABLE);
				}				
			}else{//正在上课
				if("0".equals(list.get(i).getNoOfStu())){//不展示当前没注册人数的时间
					continue;
				}
				obj.accumulate("id", "Run_"+i);
				obj.accumulate("txt", "Running Now");
				obj.accumulate("color", RUNING_NOW);
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
		cleanNullItemInJSONArray(arr);
		request.setAttribute("msg", arr.toString());
		return "ajax";
	}
	
	private JSONObject createNAFrame(String id, String stt, String ett, String txt){
		return createNAFrame(id, stt,ett, txt, null);
	}
	
	private JSONObject createNAFrame(String id, String stt, String ett, String txt, String color){
		if(stt.equals(ett)){
			return null;
		}
		JSONObject obj = new JSONObject();
		obj.accumulate("id", id);
		if(txt!=null ){
			obj.accumulate("txt", txt);			
		}
		obj.accumulate("start", stt);
		obj.accumulate("end", ett);
		if(color !=null){
			obj.accumulate("color", color);
		}
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
	
	@RequestMapping(value = "/preSelectEvent", method = RequestMethod.POST)
	public String preSelectEvent(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		JSONObject obj = new JSONObject();
		String uid=user.getId();
		
		String stm = request.getParameter("startTime");
		
		JSONArray tchers = classmgr.getTeacherByTime(uid, stm);
		if(tchers.size()==0){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "当前老师已经排满课程,请选择其他老师");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		obj.accumulate("status", "true");
		obj.accumulate("teachers", tchers.toString());	
		
		String getP = request.getParameter("getProd");
		if("Y".equalsIgnoreCase(getP)){
			JSONArray prods = classmgr.getAllProductsOfUser(uid);
			obj.accumulate("products", prods.toString());
		}
		
		request.setAttribute("msg", obj.toString());
				
		return "ajax";
	}
	
	@RequestMapping(value = "/reserveStudentClass", method = RequestMethod.POST)
	public String reserveStudentClass(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		JSONObject obj = new JSONObject();
		
		String uid=user.getId();
		String stm = request.getParameter("startTime");
		String tid=  request.getParameter("tid");
		String pid = request.getParameter("pid");
		if(stm==null||"".equals(stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "请选择一个时间");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}	
		//ToDo:校验是否该时段该老师是否可以预订,因为可能在同一时间其他人也订了该老师.
		
		boolean results = classmgr.saveStudentTime(uid, stm, tid, pid);
					
		if(!results){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "系统忙，请稍候再试！");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}		
		obj.accumulate("status", "true");
		request.setAttribute("msg", obj.toString());
		return "ajax";
	}
	
	@RequestMapping(value = "/cancelStudentClass", method = RequestMethod.POST)
	public String cancelStudentClass(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String uid=user.getId();
		String stm = request.getParameter("startTime");
		String etm = request.getParameter("endTime");
		JSONObject obj = new JSONObject();
		//没有传时间过来
		if(stm==null||"".equals(stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "系统繁忙,请稍候再试.");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");  
		Date now = new Date();
		Calendar curr = Calendar.getInstance(); 
		curr.setTime(now);
		
		if(formatter.format(curr.getTime()).compareTo(stm)>=0){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "课程已经开始,无法取消");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		
		classmgr.cancelStudentClass(uid, stm);
		obj.accumulate("status", "true");
		request.setAttribute("msg", obj.toString());
		return "ajax";
	}
	
	//学生的课程详细信息
	@RequestMapping(value = "/getClassDetails", method = RequestMethod.POST)
	public String getClassDetails(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String uid=user.getId();
		String stm = request.getParameter("startTime");
		JSONObject obj = new JSONObject();
		//没有传时间过来
		if(stm==null||"".equals(stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "系统繁忙,请刷新页面后再次尝试.");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		obj = classmgr.getClassDetails(uid,stm);
		obj.accumulate("status", "true");
		request.setAttribute("msg", obj.toString());
		return "ajax";
	}
	//老师的课程详细信息
	@RequestMapping(value = "/getClassDetailt", method = RequestMethod.POST)
	public String getClassDetailt(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String uid=user.getId();
		String stm = request.getParameter("startTime");
		JSONObject obj = new JSONObject();
		//没有传时间过来
		if(stm==null||"".equals(stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "系统繁忙,请刷新页面后再次尝试.");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		obj = classmgr.getClassDetailForTeacher(uid,stm);
		obj.accumulate("status", "true");
		request.setAttribute("msg", obj.toString());
		return "ajax";
	}
	
	@RequestMapping(value = "/cancelTeacherClass", method = RequestMethod.POST)
	public String cancelTeacherClass(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		String uid=user.getId();
		String stm = request.getParameter("startTime");
		String etm = request.getParameter("endTime");
		JSONObject obj = new JSONObject();
		//没有传时间过来
		if(stm==null||"".equals(stm)){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "System Unavailable.");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");  
		Date now = new Date();
		Calendar curr = Calendar.getInstance(); 
		curr.setTime(now);
		
		if(formatter.format(curr.getTime()).compareTo(stm)>=0){
			obj.accumulate("status", "false");
			obj.accumulate("msg", "You cannot cancel a class which had already started");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		
		classmgr.cancelTeacherClass(uid, stm);
		obj.accumulate("status", "true");
		request.setAttribute("msg", obj.toString());
		return "ajax";
	}
}
