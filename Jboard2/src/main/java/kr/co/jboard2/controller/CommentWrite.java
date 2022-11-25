package kr.co.jboard2.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.vo.ArticleVO;

@WebServlet("/commentWrite.do")
public class CommentWrite extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService service = ArticleService.INSTANCE;

	@Override
	public void init() throws ServletException {
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.debug("here1");
		String no = req.getParameter("no");
		String uid = req.getParameter("uid");
		String content = req.getParameter("content");
		String regip = req.getRemoteAddr();
		
		logger.debug("here2");
		ArticleVO comment = new ArticleVO();
		comment.setParent(no);
		comment.setUid(uid);
		comment.setContent(content);
		comment.setRegip(regip);
		
		logger.debug("here3");
		ArticleVO vo = service.insertComment(comment);
		
		logger.debug("here4 : " + vo);
		JsonObject json = new JsonObject();
		json.addProperty("result", 1);
		json.addProperty("no", vo.getNo());
		json.addProperty("parent", vo.getParent());
		json.addProperty("nick", vo.getNick());
		json.addProperty("date", vo.getRdate());
		json.addProperty("content", vo.getContent());
		
		
		PrintWriter writer = resp.getWriter();
		String jsonData = json.toString();
		
		logger.debug("here5 : " + jsonData);
		writer.print(jsonData);
	}
}
