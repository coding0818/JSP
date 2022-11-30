package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/modify.do")
public class ModifyController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	@Override
	public void init() throws ServletException {
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cate = req.getParameter("cate");
		String group = req.getParameter("group");
		String no = req.getParameter("no");
		String pg = req.getParameter("pg");
		
		ArticleVO vo = service.selectArticle(no, cate);
		
		req.setAttribute("cate", cate);
		req.setAttribute("group", group);
		req.setAttribute("no", no);
		req.setAttribute("pg", pg);
		req.setAttribute("vo", vo);
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/modify.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String cate = req.getParameter("cate");
		String group = req.getParameter("group");
		String pg = req.getParameter("pg");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		
		service.updateArticle(title, content, no);
		
		resp.sendRedirect("/Farmstory2/board/view.do?group="+group+"&cate="+cate+"&no="+no+"&pg="+pg);
	}
}
