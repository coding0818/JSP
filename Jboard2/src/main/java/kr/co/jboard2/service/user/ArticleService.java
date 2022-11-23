package kr.co.jboard2.service.user;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.vo.ArticleVO;

public enum ArticleService {

	INSTANCE;
	private ArticleDAO dao;
	private ArticleService() {
		dao = new ArticleDAO();
	}
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public List<ArticleVO> selectArticles(int limitStart) {
		return dao.selectArticles(limitStart);
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
