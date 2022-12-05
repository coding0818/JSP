package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.jboard2.service.UserService;
import kr.co.jboard2.vo.UserVO;

@WebServlet("/user/myInfo.do")
public class MyInfoController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private UserService service = UserService.INSTANCE;

	@Override
	public void init() throws ServletException {
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/myInfo.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession sess = req.getSession();
		UserVO sessUser = (UserVO)sess.getAttribute("sessUser");
		
		String uid = sessUser.getUid();
		String pass1 = req.getParameter("pass1");
		String pass2 = req.getParameter("pass2");
		String rdate = sessUser.getRdate();
		String name = req.getParameter("name");
		String nick = req.getParameter("nick");
		String email = req.getParameter("email");
		String hp = req.getParameter("hp");
		String zip = req.getParameter("zip");
		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		String regip = req.getRemoteAddr();
		
		UserVO vo = new UserVO();
		vo.setUid(uid);
		vo.setPass(pass2);
		vo.setEmail(email);
		vo.setHp(hp);
		vo.setAddr1(addr1);
		vo.setAddr2(addr2);
		vo.setName(name);
		vo.setNick(nick);
		vo.setRdate(rdate);
		vo.setRegip(regip);
		vo.setZip(zip);
		
		service.updateUser(vo);
		UserVO user = service.selectUser(uid, pass2);
		
		HttpSession sessUser2 = req.getSession();
		sessUser2.setAttribute("sessUser", user);
		
		resp.sendRedirect("/Jboard2/list.do");
	}
}
