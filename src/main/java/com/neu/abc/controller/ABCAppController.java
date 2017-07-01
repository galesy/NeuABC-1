package com.neu.abc.controller;

import java.io.File;
import java.util.Iterator;

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
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import com.neu.abc.exceptions.DataAccessException;
import com.neu.abc.utils.Constants;

/**
 * Handles requests for the application home page.
 */
@Controller
public class ABCAppController {
	@Autowired CookieLocaleResolver resolver;
	private static final Logger logger = LoggerFactory.getLogger(ABCAppController.class);
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String app(HttpServletRequest request, HttpServletResponse response) {
//		if("en".equals(request.getParameter("lan"))){
//			resolver.setLocale(request, response, Locale.ENGLISH );
//		}else{
//			resolver.setLocale(request, response, Locale.CHINA );
//		}
		return "abc.homepage";
	}
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(HttpServletRequest request, HttpServletResponse response) {
		return "abc.homepage";
	}
	
	@RequestMapping(value = "/landing", method = RequestMethod.GET)
	public String displayLandingPage(HttpServletRequest request, HttpServletResponse response) {		
		return "abc.stu.landing";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response)  {  
		request.getSession(true).removeAttribute(Constants.SESSION_USER);
		return "abc.homepage";
	}
	/**
	 * User edit Pre-load.
	 */
	@RequestMapping(value = "/edituser", method = RequestMethod.GET)
	public String preloadUserEdit(HttpServletRequest request, HttpServletResponse response) {  
		return "abc.stu.useredit";
	}
	@RequestMapping(value = "/editableuser", method = RequestMethod.GET)
	public String loadUserEdit(HttpServletRequest request, HttpServletResponse response) {  
		return "abc.stu.editableuser";
	}
	
	@RequestMapping(value = "/profileupload", method = RequestMethod.POST)
    public String  springUpload(HttpServletRequest request) throws DataAccessException
    {		
		try{
		String photoPath=request.getSession().getServletContext().getRealPath("/")+"static\\neu\\images\\photo\\";
        CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
                request.getSession().getServletContext());
        if(multipartResolver.isMultipart(request))
        {
            MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
            Iterator iter=multiRequest.getFileNames();             
            while(iter.hasNext())
            {
                MultipartFile file=multiRequest.getFile(iter.next().toString());
                if(file!=null)
                {
                    String path=photoPath+file.getOriginalFilename();
                    file.transferTo(new File(path));
                }
            }
        }
		}catch(Exception e){
			logger.error("File upload failed", e);
			throw new DataAccessException(e);
		}
        return "abc.stu.useredit";
    }
}
