package kr.co.jboard2.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.jboard2.service.user.ArticleService;
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
		
		// 게시판 목록 처리 관련 변수 선언
		int limitStart = 0;
		int currentPage = 1;
		int pageGroupCurrent = 1;
		int pageGroupStart = 1;
		int pageGroupEnd = 0;
		int pageStartNum = 0;
		
		int total = service.selectCountTotal();
		// 페이지 마지막 번호 계산
		int lastPageNum = service.getLastPageNum(total);
		// 현재 페이지 게시물 limitStart 값 계산
		if(pg != null) {
			limitStart = service.getLimitStart(pg);
		}
		
		
		
		
		// 페이지 그룹 계산
		pageGroupCurrent = (int)Math.ceil(currentPage/10.0);
		pageGroupStart = (pageGroupCurrent - 1) * 10 + 1;
		pageGroupEnd = pageGroupCurrent * 10;
		
		if(pageGroupEnd > lastPageNum) {
			pageGroupEnd = lastPageNum;
		}
		
		// 페이지 시작 번호 계산
		pageStartNum = total - limitStart;
		
		/*
		List<Integer> pageNum = new ArrayList<>();
		pageNum.add(limitStart);
		pageNum.add(currentPage);
		pageNum.add(total);
		pageNum.add(lastPageNum);
		pageNum.add(pageGroupCurrent);
		pageNum.add(pageGroupStart);
		pageNum.add(pageGroupEnd);
		pageNum.add(pageStartNum);
		*/
		
		List<ArticleVO> articles = service.selectArticles(limitStart);
		req.setAttribute("articles", articles);
		
		req.setAttribute("limitStart", limitStart);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("total", total);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("pageGroupCurrent", pageGroupCurrent);
		req.setAttribute("pageGroupStart", pageGroupStart);
		req.setAttribute("pageGroupEnd", pageGroupEnd);
		req.setAttribute("pageStartNum", pageStartNum);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/list.jsp");
		dispatcher.forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
