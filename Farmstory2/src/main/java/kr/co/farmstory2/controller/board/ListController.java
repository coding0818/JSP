package kr.co.farmstory2.controller.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/list.do")
public class ListController extends HttpServlet{

	
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cate = req.getParameter("cate");
		String group = req.getParameter("group");
		String pg = req.getParameter("pg");
		String search = req.getParameter("search");
		
		int total = service.selectCountTotal(search, cate);
		
		int lastPageNum = service.getLastPageNum(total);
		
		int currentPage = service.getCurrentPage(pg);
		
		int limitStart = service.getLimitStart(currentPage);
		
		int[] result = service.getPageGroupNum(currentPage, lastPageNum);
		
		int pageStartNum = service.getPageStartNum(total, limitStart);
		
		int start = service.getStartNum(currentPage);
		
		List<ArticleVO> articles = null;
		
		if(search == null) {
			articles = service.selectArticles(cate, start);
		}else {
			articles = service.selectArticlesByKeyword(search, start);
		}
		
		req.setAttribute("cate", cate);
		req.setAttribute("group", group);
		req.setAttribute("articles", articles);
		req.setAttribute("limitStart", limitStart);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("total", total);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("pageGroupStart", result[0]);
		req.setAttribute("pageGroupEnd", result[1]);
		req.setAttribute("pageStartNum", pageStartNum+1);
		req.setAttribute("search", search);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/list.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
