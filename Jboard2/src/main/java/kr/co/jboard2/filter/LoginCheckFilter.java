package kr.co.jboard2.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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

import kr.co.jboard2.vo.UserVO;


public class LoginCheckFilter implements Filter{
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private List<String> uriList;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
		uriList = new ArrayList<>();
		uriList.add("/Jboard2/list.do");
		uriList.add("/Jboard2/write.do");
		uriList.add("/Jboard2/modify.do");
		uriList.add("/Jboard2/view.do");
		
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		logger.info("LoginCheckFilter doFilter...0");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		String uri = req.getRequestURI();
		
		HttpSession sess = req.getSession();
		UserVO sessUser = (UserVO)sess.getAttribute("sessUser");
		
		logger.info("LoginCheckFilter doFilter...1");
		
		if(uriList.contains(uri)) {
			
			logger.info("LoginCheckFilter doFilter...2");
			// 로그인을 하지 않았을 경우
			if(sessUser == null) {
				logger.info("LoginCheckFilter doFilter...3");
				resp.sendRedirect("/Jboard2/user/login.do");
				return;
			}
		}else if(uri.contains("/user/login.do")) {
			logger.info("LoginChechFilter doFilter...4");
			// 로그인을 했을 경우
			if(sessUser != null) {
				logger.info("LoginChechFilter doFilter...5");
				resp.sendRedirect("/Jboard2/list.do");
				return;
			}
			
		}
		
		logger.info("LoginChechFilter doFilter...6");
		chain.doFilter(request, response);
	}

}
