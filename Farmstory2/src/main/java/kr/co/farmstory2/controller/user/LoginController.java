package kr.co.farmstory2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.service.UserService;
import kr.co.farmstory2.vo.UserVO;

@WebServlet("/user/login.do")
public class LoginController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	
	@Override
	public void init() throws ServletException {
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.info("LoginController...");
		
		String success = req.getParameter("success");
		req.setAttribute("success", success);
		
		logger.debug("here1");
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/login.jsp");
		dispatcher.forward(req, resp);
		logger.debug("here2");
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uid = req.getParameter("uid");
		String pass = req.getParameter("pass");
		String auto = req.getParameter("auto");
		
		UserVO user = service.selectUser(uid, pass);
		if(user != null) {
			// 회원이 맞을 경우
			
			HttpSession sess = req.getSession();
			sess.setAttribute("sessUser", user);
			
			if(auto != null) {
				
				String sessId = sess.getId();
				
				// 쿠키 생성
				Cookie cookie = new Cookie("SESSID", sessId);
				cookie.setPath("/");
				cookie.setMaxAge(60*60*24*3);
				resp.addCookie(cookie);
				
				// 세션아이디 데이터베이스 저장
				service.updateUserForSession(uid, sessId);
				
			}
			
			resp.sendRedirect("/Farmstory2/index.do");
			
		}else {
			// 회원이 아닌 경우
			resp.sendRedirect("/Farmstory2/user/login.do?success=100");
		}
	}
}
