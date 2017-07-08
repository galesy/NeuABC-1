package com.neu.abc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.neu.abc.db.ClassMgr;
import com.neu.abc.db.UserMgr;
import com.neu.abc.exceptions.DataAccessException;
import com.neu.abc.model.User;
import com.neu.abc.utils.Constants;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@Inject
	private UserMgr usermgr;
	@Inject
	private ClassMgr classmgr;
	
	@RequestMapping(value = "/doLogin", method = RequestMethod.POST)
	public String doLogin(HttpServletRequest request, HttpServletResponse response) throws DataAccessException {  
		Map<String, String> result = new HashMap<String, String>();
		request.getSession(true).removeAttribute(Constants.SESSION_USER);
		logger.info("User try to login: +"+request.getParameter("username"));
		User user = usermgr.login(request.getParameter("username"), request.getParameter("password"));
		if(user !=null){
			List<String> pType = classmgr.getProductTypeByUser(user.getId());
			if(pType!=null && pType.size()>0){
				user.getProdTypes().addAll(pType);
			}
				//request.getSession(true).removeAttribute(Constants.SESSION_USER);
			WebUtils.setSessionAttribute(request, Constants.SESSION_USER, user);
			//request.getSession(true).setAttribute(Constants.SESSION_USER, user);
			request.setAttribute("msg", "{\"status\":\"success\"}");
		}else{
			request.setAttribute("msg", "{\"status\":\"fail\"}");
		}		
		return "ajax";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {		
		request.getSession(true).removeAttribute(Constants.SESSION_USER);
		ModelAndView mav = new ModelAndView();
        mav.setViewName("abc.login");
		return mav;
	}
	
	@RequestMapping(value = "/signin", method = RequestMethod.GET)
	public ModelAndView signin(HttpServletRequest request, HttpServletResponse response) {	
		request.getSession(true).removeAttribute(Constants.SESSION_USER);
		ModelAndView mav = new ModelAndView();
        mav.setViewName("abc.tch.signin");
		return mav;
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signup(Locale locale, Model model) throws DataAccessException {		
		ModelAndView mav = new ModelAndView();
        mav.setViewName("abc.tch.signup");
		return mav;
	}
	
	
}
