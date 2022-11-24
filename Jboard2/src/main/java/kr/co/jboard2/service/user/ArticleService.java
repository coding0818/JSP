package kr.co.jboard2.service.user;

import java.util.List;


import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;

public enum ArticleService {

	INSTANCE;
	private ArticleDAO dao;
	private ArticleService() {
		dao = new ArticleDAO();
	}
	
	public int insertArticle(ArticleVO article) {
		return dao.insertArticle(article);
	}
	
	public void insertFile(int parent, String newName, String fname) {
		dao.insertFile(parent, newName, fname);
	}
	
	public ArticleVO insertComment(ArticleVO vo) {
		return dao.insertComment(vo);
	}
	
	public ArticleVO selectArticle(String no) {
		return dao.selectArticle(no);
	}
	
	public List<ArticleVO> selectArticles(int limitStart) {
		return dao.selectArticles(limitStart);
	}
	public List<ArticleVO> selectComments(String no) {
		return dao.selectComments(no);
	}
	
	public int selectCountTotal() {
		return dao.selectCountTotal();
	}
	

	
	public int getLastPageNum(int total) {
		int lastPageNum = 0;
		
		if(total % 10 == 0) {
			lastPageNum = (total/10);
		}else {
			lastPageNum = (total/10)+1;
		}
		
		return lastPageNum;
	}
	
	public int getLimitStart(String pg) {
		
		int currentPage = 1;
		
		
		currentPage = Integer.parseInt(pg);
		
		
		int limitStart = (currentPage-1)*10;
		
		return limitStart;
	}
}
