package com.neu.abc.controller;

import java.io.File;
import java.util.Iterator;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.util.WebUtils;

import com.neu.abc.db.UserMgr;
import com.neu.abc.exceptions.DataAccessException;
import com.neu.abc.model.User;
import com.neu.abc.utils.Constants;

import net.sf.json.JSONObject;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ABCAppController {
	@Autowired
	CookieLocaleResolver resolver;
	private static final Logger logger = LoggerFactory.getLogger(ABCAppController.class);

	@Inject
	private UserMgr usermgr;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView app(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
        mav.setViewName("abc.homepage");
		return mav;
	}
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView appHomepage(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
        mav.setViewName("abc.homepage");
		return mav;
	}
	
	@RequestMapping(value = "/stu", method = RequestMethod.GET)
	public String studentHomepage(HttpServletRequest request, HttpServletResponse response) {
		return "abc.stu.homepage";
	}
	@RequestMapping(value = "/tch", method = RequestMethod.GET)
	public String teacherHomepage(HttpServletRequest request, HttpServletResponse response) {
		return "abc.tch.homepage";
	}


	@RequestMapping(value = "/landing", method = RequestMethod.GET)
	public String displayLandingPage(HttpServletRequest request, HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		if("T".equalsIgnoreCase(user.getRole())){
			if(user.getProdTypes().size()>-1){//不做判断
				return "abc.tch.landing";
			}else{
				
				return "abc.tch.calendar1";
			}
			
		}else{
			return "abc.stu.landing";
		}
	}

	@RequestMapping(value = "/prodintro", method = RequestMethod.GET)
	public String prodintro(HttpServletRequest request, HttpServletResponse response) {
		User user = (User)WebUtils.getSessionAttribute(request, Constants.SESSION_USER);
		//User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		if("T".equalsIgnoreCase(user.getRole())){
			return "abc.tch.calendar1";			
		}else{
			return "abc.stu.prodintro";
		}
	}
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		request.getSession(true).removeAttribute(Constants.SESSION_USER);
		return "abc.homepage";
	}

	/**
	 * User edit Pre-load.
	 */
	@RequestMapping(value = "/edituser", method = RequestMethod.GET)
	public String preloadUserEdit(HttpServletRequest request, HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		if("T".equalsIgnoreCase(user.getRole())){
			return "abc.tch.useredit";
		}else{
			return "abc.stu.useredit";
		}
	}

	@RequestMapping(value = "/editableuser", method = RequestMethod.GET)
	public String loadUserEdit(HttpServletRequest request, HttpServletResponse response) {
		User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
		if("T".equalsIgnoreCase(user.getRole())){
			return "abc.tch.editableuser";
		}else{
			return "abc.stu.editableuser";
		}
	}

	@RequestMapping(value = "/profileupload", method = RequestMethod.POST)
	public String springUpload(HttpServletRequest request) throws DataAccessException {
		try {
			User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
			String nick=request.getParameter("nick");
			String dob=request.getParameter("dob");
			String email = request.getParameter("email");
			String photo = user.getPhoto();
			String gen = request.getParameter("gen");
			logger.info(request.getCharacterEncoding());
			String photoPath = request.getSession().getServletContext().getRealPath("/")
					+ "static"+File.separator+"neu"+File.separator+"images"+File.separator+"photo"+File.separator+"";
			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
					request.getSession().getServletContext());
			if (multipartResolver.isMultipart(request)) {
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				Iterator iter = multiRequest.getFileNames();
				while (iter.hasNext()) {
					MultipartFile file = multiRequest.getFile(iter.next().toString());
					if (file != null && !"".equals(file.getOriginalFilename())) {
						photo = user.getId()+file.getOriginalFilename();
						String path = photoPath + photo;
						logger.info("upload photo to:" + path);
						file.transferTo(new File(path));
					}
				}
			}
			user.setNick(nick);
			user.setEmailAddr(email);
			user.setGen(gen);
			user.setPhoto(photo);
			user.setDob(dob);
			usermgr.updateUser(user);
			request.getSession().setAttribute(Constants.SESSION_USER,user);
			
		} catch (Exception e) {
			logger.error("File upload failed", e);
			throw new DataAccessException(e);
		}
		request.setAttribute("redirect", "edituser");
		return "abc.stu.redirect";
	}

	@RequestMapping(value = "/bookclass", method = RequestMethod.GET)
	public String bookClass(HttpServletRequest request, HttpServletResponse response) {
		return "abc.stu.landing";
	}
	
	
	//学生的英语水平
		@RequestMapping(value = "/updateEnglishLev", method = RequestMethod.POST)
		public String updateEnglishLev(HttpServletRequest request, HttpServletResponse response) { 
			User user = (User) request.getSession().getAttribute(Constants.SESSION_USER);
			String uid=user.getId();
			String grade = request.getParameter("grade");
			String eng_lev = request.getParameter("engLev");
			JSONObject obj = new JSONObject();
			try{
				usermgr.getClassDetails(uid,grade, eng_lev);
			}catch (DataAccessException e){
				logger.error("Error while upgrade English level:" ,e);
				obj.accumulate("status", "false");
				return "ajax";
			} 
			obj.accumulate("status", "true");
			request.setAttribute("msg", obj.toString());
			return "ajax";
		}
		//老师的课程详细信息
		@RequestMapping(value = "/getClassDetailt", method = RequestMethod.POST)
		public String getClassDetailt(HttpServletRequest request, HttpServletResponse response) throws DataAccessException { 
			
			return "ajax";
		}
}
