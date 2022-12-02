package kr.co.farmstory2.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.vo.ArticleVO;
import kr.co.farmstory2.vo.FileVO;

public enum ArticleService {

	INSTANCE;
	private ArticleDAO dao;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	private ArticleService () {
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
	
	public ArticleVO selectArticle(String no, String cate) {
		return dao.selectArticle(no, cate);
	}
	
	public List<ArticleVO> selectArticles(String cate, int start) {
		return dao.selectArticles(cate, start);
	}
	public List<ArticleVO> selectArticlesByKeyword(String keyword, int start) {
		return dao.selectArticlesByKeyword(keyword, start);
	}
	public List<ArticleVO> selectComments(String no) {
		return dao.selectComments(no);
	}
	
	public int selectCountTotal(String search, String cate) {
		return dao.selectCountTotal(search, cate);
	}
	
	public List<ArticleVO> selectLatest(String cate) {
		return dao.selectLatest(cate);
	}
	
	public List<ArticleVO> selectLatests(String cate1, String cate2, String cate3) {
		return dao.selectLatests(cate1, cate2, cate3);
	}
	
	public FileVO selectFile(String parent) {
		return dao.selectFile(parent);
	}
	
	
	public int updateComment(String no, String content) {
		return dao.updateComment(no, content);
	}
	
	public void updateArticle(String title, String content, String no) {
		dao.updateArticle(title, content, no);
	}
	public void updateArticleHit(String no) {
		dao.updateArticleHit(no);
	}
	
	public void updateFileDownload(int fno) {
		dao.updateFileDownload(fno);
	}
	
	public void deleteArticle(String no) {
		dao.deleteArticle(no);
	}
	public int deleteComment(String no, String parent) {
		return dao.deleteComment(no, parent);
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
	
	public int getCurrentPage(String pg) {
		int currentPage = 1;
		
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
		}
		return currentPage;
	}
	
	public int getLimitStart(int currentPage) {
		int limitStart = 0;
		limitStart = (currentPage-1)*10;
		return limitStart;
	}
	
	public int[] getPageGroupNum(int currentPage, int lastPageNum) {
		int pageGroupCurrent = (int)Math.ceil(currentPage/10.0);
		int pageGroupStart = (pageGroupCurrent - 1) * 10 + 1;
		int pageGroupEnd = pageGroupCurrent * 10;
		
		if(pageGroupEnd > lastPageNum) {
			pageGroupEnd = lastPageNum;
		}
		
		int[] result = {pageGroupStart, pageGroupEnd};
		return result;
	}
	
	public int getPageStartNum(int total, int limitStart) {
		logger.debug("getPageStartNum...");
		int pageStartNum = 0;
		
		pageStartNum = total - limitStart;
		
		return pageStartNum;
	}
	
	public int getStartNum(int currentPage) {
		return (currentPage - 1)*10;
	}
	
	public String getSavePath(HttpServletRequest req) {
		ServletContext application = req.getServletContext();
		return application.getRealPath("/file");
	}
	
	public MultipartRequest uploadFile(HttpServletRequest req, String savePath) throws IOException {
		int maxSize = 1024 *1024 * 10;
		return new MultipartRequest(req, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	}
	
	public String renameFile(String fname, String uid, String savePath) {
		
		int i = fname.lastIndexOf(".");
		String ext = fname.substring(i);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss_");
		String now = sdf.format(new Date());
		String newName = now+uid+ext;
		
		File f1 = new File(savePath+"/"+fname);
		File f2 = new File(savePath+"/"+newName);
		
		f1.renameTo(f2);
		
		return newName;
		
	}
}
