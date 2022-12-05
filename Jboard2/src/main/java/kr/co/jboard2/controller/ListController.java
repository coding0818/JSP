package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/list.do")
public class ListController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;

	@Override
	public void init() throws ServletException {
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String pg = req.getParameter("pg");
		String search = req.getParameter("search");
		
		
		// 게시판 목록 처리 관련 변수 선언
		int limitStart = 0;
		int currentPage = 1;
		int pageStartNum = 0;
		
		int total = service.selectCountTotal(search);
		// 페이지 마지막 번호 계산
		int lastPageNum = service.getLastPageNum(total);
		// 현재 페이지 게시물 limitStart 값 계산
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
			limitStart = service.getLimitStart(pg);
		}
		
		
		// 페이지 그룹 계산
		int[] result = service.getPageGroupNum(currentPage, lastPageNum);
		
		// 페이지 시작 번호 계산
		pageStartNum = total - limitStart;
		int start = service.getStartNum(currentPage);
		
		List<ArticleVO> articles = null;
		if(search == null) {
			articles = service.selectArticles(limitStart);	
		}else {
			articles = service.selectArticlesByKeyword(search, start);	
		}
		
		req.setAttribute("articles", articles);
		req.setAttribute("limitStart", limitStart);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("total", total);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("pageGroupStart", result[0]);
		req.setAttribute("pageGroupEnd", result[1]);
		req.setAttribute("pageStartNum", pageStartNum+1);
		req.setAttribute("search", search);
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/list.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
