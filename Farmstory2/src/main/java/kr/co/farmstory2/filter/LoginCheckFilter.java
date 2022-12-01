package kr.co.farmstory2.filter;

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

import kr.co.farmstory2.vo.UserVO;

public class LoginCheckFilter implements Filter{
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private List<String> uriList;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		uriList = new ArrayList<>();
		uriList.add("/Farmstory2/board/list.do");
		uriList.add("/Farmstory2/board/write.do");
		uriList.add("/Farmstory2/board/modify.do");
		uriList.add("/Farmstory2/board/view.do");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		logger.info("LoginCheckFilter...");
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		String uri = req.getRequestURI();
		
		HttpSession sess = req.getSession();
		UserVO sessUser = (UserVO)sess.getAttribute("sessUser");
		
		logger.debug("here1");
		
		if(uriList.contains(uri)) {
			logger.debug("here2");
			
			// 로그인을 하지 않았을 경우
			if(sessUser == null) {
				logger.debug("here3");
				resp.sendRedirect("/Farmstory2/user/login.do");
				return;
			}
		}else if(uri.contains("/user/login.do")) {
			logger.debug("here4");
			// 로그인을 했을 경우
			if(sessUser != null) {
				logger.debug("here5");
				resp.sendRedirect("/Farmstory2/board/list.do");
				return;
			}
		}
		logger.debug("here6");
		chain.doFilter(request, response);
	}

}
