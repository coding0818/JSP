package kr.co.farmstory2.dao;

import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.db.DBHelper;
import kr.co.farmstory2.db.Sql;
import kr.co.farmstory2.vo.ArticleVO;

public class ArticleDAO extends DBHelper{

	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public int insertArticle(ArticleVO article) {
		int result = 0;
		try {
			logger.info("insertArticle...");
			conn = getConnection();
			
			conn.setAutoCommit(false);
			
			psmt = conn.prepareStatement(Sql.INSERT_ARTICLE);
			stmt = conn.createStatement();
			
			psmt.setString(1, article.getTitle());
			psmt.setString(2, article.getContent());
			psmt.setInt(3, article.getFname() == null ? 0:1);
			psmt.setString(4, article.getUid());
			psmt.setString(5, article.getRegip());
			
			psmt.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_MAX_NO);
			
			conn.commit();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	public void insertFile(int parent, String newName, String fname) {
		try {
			logger.info("insertFile...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.INSERT_FILE);
			psmt.setInt(1, parent);
			psmt.setString(2, newName);
			psmt.setString(3, fname);
			
			psmt.executeUpdate();
			
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public ArticleVO insertComment(ArticleVO vo) {
		ArticleVO comment = null;
		
		try {
			logger.info("insertComment...");
			
			conn = getConnection();
			
			conn.setAutoCommit(false);
			PreparedStatement psmt1 = conn.prepareStatement(Sql.INSERT_COMMENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_ARTICLE_COMMENT_PLUS);
			stmt = conn.createStatement();
			
			psmt1.setInt(1, vo.getParent());
			psmt1.setString(2, vo.getContent());
			psmt1.setString(3, vo.getUid());
			psmt1.setString(4, vo.getRegip());
			
			psmt2.setInt(1, vo.getParent());
			
			psmt1.executeUpdate();
			psmt2.executeUpdate();
			rs = stmt.executeQuery(Sql.SELECT_COMMENT_LATEST);
			
			conn.commit();
			
			if(rs.next()) {
				comment = new ArticleVO();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setContent(rs.getString(6));
				comment.setRdate(rs.getString(11).substring(2, 10));
				comment.setNick(rs.getString(12));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		
		return comment;		
	}
	
	public ArticleVO selectArticle(String no, String cate) {
		ArticleVO vo = null;
		try {
			logger.info("selectArticle...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, cate);
			rs = psmt.executeQuery();
			if(rs.next()) {
				vo = new ArticleVO();
				vo.setNo(rs.getInt(1));
				vo.setParent(rs.getInt(2));
				vo.setComment(rs.getInt(3));
				vo.setCate(rs.getString(4));
				vo.setTitle(rs.getString(5));
				vo.setContent(rs.getString(6));
				vo.setFile(rs.getInt(7));
				vo.setHit(rs.getInt(8));
				vo.setUid(rs.getString(9));
				vo.setRegip(rs.getString(10));
				vo.setRdate(rs.getString(11));
				vo.setNick(rs.getString(12));
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return vo;
	}
	
	public List<ArticleVO> selectArticles(String cate, int start) {
		List<ArticleVO> articles = new ArrayList<>();
		try {
			logger.info("selectArticles...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLES);
			psmt.setString(1, cate);
			psmt.setInt(2, start);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO article = new ArticleVO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setUid(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11));
				article.setNick(rs.getString(12));
				
				articles.add(article);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return articles;
	}
	
	public List<ArticleVO> selectArticlesByKeyword(String keyword, int start) {
		
		List<ArticleVO> articles = new ArrayList<>();
		try {
			logger.info("selectArticlesByKeyword...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_ARTICLES_BY_KEYWORD);
			psmt.setString(1, "%"+keyword+"%");
			psmt.setString(2, "%"+keyword+"%");
			psmt.setInt(3, start);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO article = new ArticleVO();
				article.setNo(rs.getInt(1));
				article.setParent(rs.getInt(2));
				article.setComment(rs.getInt(3));
				article.setCate(rs.getString(4));
				article.setTitle(rs.getString(5));
				article.setContent(rs.getString(6));
				article.setFile(rs.getInt(7));
				article.setHit(rs.getInt(8));
				article.setUid(rs.getString(9));
				article.setRegip(rs.getString(10));
				article.setRdate(rs.getString(11));
				article.setNick(rs.getString(12));
				
				articles.add(article);
			}
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return articles;
	}
	
	public List<ArticleVO> selectComments(String no) {
		List<ArticleVO> comments = new ArrayList<>();
		try {
			logger.info("selectComments...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_COMMENTS);
			psmt.setString(1, no);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO comment = new ArticleVO();
				comment.setNo(rs.getInt(1));
				comment.setParent(rs.getInt(2));
				comment.setComment(rs.getInt(3));
				comment.setCate(rs.getString(4));
				comment.setTitle(rs.getString(5));
				comment.setContent(rs.getString(6));
				comment.setFile(rs.getInt(7));
				comment.setHit(rs.getInt(8));
				comment.setUid(rs.getString(9));
				comment.setRegip(rs.getString(10));
				comment.setRdate(rs.getString(11));
				comment.setNick(rs.getString(12));
				
				comments.add(comment);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return comments;
	}
	
	public int selectCountTotal(String search, String cate) {
		int total = 0;
		try {
			logger.info("selectCountTotal...");
			
			conn = getConnection();
			
			if(search == null) {
				psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL);
				psmt.setString(1, cate);
				rs = psmt.executeQuery();	
			}else {
				psmt = conn.prepareStatement(Sql.SELECT_COUNT_TOTAL_FOR_SEARCH);
				psmt.setString(1, cate);
				psmt.setString(2, "%"+search+"%");
				psmt.setString(3, "%"+search+"%");
				rs = psmt.executeQuery();
			}
			
			while(rs.next()) {
				total = rs.getInt(1);
			}
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return total;
	}
	
	public List<ArticleVO> selectLatests(String cate1, String cate2, String cate3) {
		List<ArticleVO> latests = new ArrayList<>();
		try {
			logger.info("selectLatests...");
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.SELECT_LATESTS);
			psmt.setString(1, cate1);
			psmt.setString(2, cate2);
			psmt.setString(3, cate3);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ArticleVO ab = new ArticleVO();
				ab.setNo(rs.getInt(1));
				ab.setTitle(rs.getString(2));
				ab.setRdate(rs.getString(3).substring(2,10));
				
				latests.add(ab);
			}
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return latests;
	}
	
	public void updateArticle(String title, String content, String no) {
		
		try {
			logger.info("updateArticle...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE);
			psmt.setString(1, title);
			psmt.setString(2, content);
			psmt.setString(3, no);
			psmt.executeUpdate();
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	public void updateArticleHit(String no) {
		
		try {
			logger.info("updateArticleHit...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_ARTICLE_HIT);
			psmt.setString(1, no);
			psmt.executeUpdate();
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		
	}
	
	public int updateComment(String no, String content) {
		int result = 0;
		try {
			logger.info("updateComment...");
			
			conn = getConnection();
			psmt = conn.prepareStatement(Sql.UPDATE_COMMENT);
			psmt.setString(1, content);
			psmt.setString(2, no);
			result = psmt.executeUpdate();
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
	
	public void deleteArticle(String no) {
		try {
			logger.info("deleteArticle...");
			
			conn = getConnection();
			
			psmt = conn.prepareStatement(Sql.DELETE_ARTICLE);
			psmt.setString(1, no);
			psmt.setString(2, no);
			
			psmt.executeUpdate();
			close();
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
	}
	public int deleteComment(String no, String parent) {
		int result = 0;
		try {
			logger.info("deleteComment...");
			
			conn = getConnection();
			
			conn.setAutoCommit(false);
			psmt = conn.prepareStatement(Sql.DELETE_COMMENT);
			PreparedStatement psmt2 = conn.prepareStatement(Sql.UPDATE_ARTICLE_COMMENT_MINUS);
			psmt.setString(1, no);
			psmt.setString(2, parent);
			
			result = psmt.executeUpdate();
			psmt2.executeUpdate();
			conn.commit();
			
			close();
			
		}catch(Exception e) {
			logger.error(e.getMessage());
		}
		return result;
	}
}
