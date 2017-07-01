package com.neu.abc.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.neu.abc.db.UserMgr;
import com.neu.abc.model.User;
import com.neu.abc.utils.Constants;

/**
 * Handles requests for the application home page.
 */
@Controller
public class TilesController {
	
	private static final Logger logger = LoggerFactory.getLogger(TilesController.class);
	@Inject
	private UserMgr usermgr;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/tiles", method = RequestMethod.GET)
    public ModelAndView indexlist(HttpServletRequest request, HttpServletResponse response){
		User user = (User)request.getSession().getAttribute(Constants.SESSION_USER);
        logger.info("Welcome user :"+user.getName());
        ModelAndView mav = new ModelAndView();
        mav.setViewName("abc.calendar");
        return mav;
    }
	
}
