package com.neu.abc.controller;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.neu.abc.db.UserMgr;
import com.neu.abc.exceptions.DataAccessException;
import com.neu.abc.model.User;
import com.neu.abc.utils.Constants;

import net.sf.json.JSONObject;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/user")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	@Inject
	private UserMgr usermgr;
	
	/**
	 * For teacher.
	 */
	@RequestMapping(value = "/doRegist", method = RequestMethod.POST)
	public String doTeacher(HttpServletRequest request, HttpServletResponse response) throws DataAccessException {  
		String uname=request.getParameter("username");
		String pwd = request.getParameter("password");
		String email = request.getParameter("email");
		String agree = request.getParameter("agree");
		String status = "failed";
		String message = "Failed to create user.";
		if("Y".equalsIgnoreCase(agree)){
			boolean crt = usermgr.createTeacher(uname, pwd, email);
			if(crt){
				User user = usermgr.queryUser(uname);
				if(user !=null){
					request.getSession(true).removeAttribute(Constants.SESSION_USER);
					request.getSession().setAttribute(Constants.SESSION_USER, user);
					status ="Success";
					message ="Success";
				}
			}
		}else{						
			message = "You must accept agreement to Sign In.";
		}
		JSONObject obj = new JSONObject();
		obj.accumulate("status",status );
		obj.accumulate("message", message);
		request.setAttribute("msg", obj.toString());
		logger.info(obj.toString());
		return "ajax";
	}
	/**
	 * For Student.
	 */
	@RequestMapping(value = "/doRegists", method = RequestMethod.POST)
	public String doStudent(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		String uname=request.getParameter("phone");
		String pwd = request.getParameter("password");
		String email = request.getParameter("email");
		String agree = request.getParameter("agree");
		String status = "failed";
		String message = "Failed to create user.";
		if("Y".equalsIgnoreCase(agree)){
			boolean crt = usermgr.createStudent(uname, pwd,email);
			if(crt){
				User user = usermgr.queryUser(uname);
				if(user !=null){
					request.getSession(true).removeAttribute(Constants.SESSION_USER);
					request.getSession().setAttribute(Constants.SESSION_USER, user);
					status ="Success";
					message ="Success";
				}
			}
		}else{						
			message = "You must accept agreement to Sign In.";
		}
		JSONObject obj = new JSONObject();
		obj.accumulate("status",status );
		obj.accumulate("message", message);
		request.setAttribute("msg", obj.toString());
		logger.info(obj.toString());
		return "ajax";
	}
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public String checkUniqueName(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
		String uname=request.getParameter("phone");
		String status = "true";
		User user = usermgr.queryUser(uname);
		if(user !=null){
			status="false";
		}
		request.setAttribute("msg", status);
		return "ajax";
	}
	/**
	 * Student Pre login.
	 */
	@RequestMapping(value = "/regists", method = RequestMethod.GET)
	public ModelAndView registerStudents(Locale locale, Model model) throws DataAccessException {
		ModelAndView mav = new ModelAndView();
        mav.setViewName("abc.register_s");
		return mav;
	}
	
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public ModelAndView registerTeacher(Locale locale, Model model) throws DataAccessException {
		ModelAndView mav = new ModelAndView();
        mav.setViewName("abc.register_t");
		return mav;
	}
	

}
