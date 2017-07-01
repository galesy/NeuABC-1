package com.neu.abc.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;

import com.neu.abc.utils.Constants;

public class LoginFilter implements Filter {
	private static final Logger logger = LoggerFactory.getLogger(LoginFilter.class);
	public FilterConfig config;

	public void destroy() {
		this.config = null;
		logger.info("end login filter!");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
			throws IOException, ServletException {
		if (!(request instanceof HttpServletRequest) || !(response instanceof HttpServletResponse)) {
			throw new ServletException("OncePerRequestFilter just supports HTTP requests");
		}
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		String[] notFilter = new String[] { "/images", "/js", "/css","/fonts",
				"/home", "/sso", "/user","/login","/doLogin" };

		String uri = httpRequest.getRequestURI();
		boolean doFilter = true;
		for (String s : notFilter) {
			if (uri.indexOf(s) != -1) {
				doFilter = false;
				break;
			}
		}
		if((httpRequest.getContextPath()+"/").equals(uri)){
			doFilter=false;
		}
		if (doFilter) {
			logger.info("Filter URL:" + httpRequest.getRequestURI());
			HttpSession session = httpRequest.getSession(false);
			if (session == null){
				session = httpRequest.getSession(true);
			}
			Object obj = session.getAttribute(Constants.SESSION_USER);
			if (null == obj) {
				boolean isAjaxRequest = isAjaxRequest(httpRequest);
				if (isAjaxRequest) {
					response.setCharacterEncoding("UTF-8");
					httpResponse.sendError(HttpStatus.UNAUTHORIZED.value(), "Please login again.");
					return;
				}
				httpResponse.sendRedirect("home");
				return;
			} else {
				filterChain.doFilter(request, response);
			}
		} else {
			filterChain.doFilter(request, response);
		}
	}

	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

	public static boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("X-Requested-With");
		if (header != null && "XMLHttpRequest".equals(header))
			return true;
		else
			return false;
	}

}
