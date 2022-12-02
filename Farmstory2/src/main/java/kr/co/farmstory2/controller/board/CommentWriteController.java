package kr.co.farmstory2.controller.board;

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

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/commentWrite.do")
public class CommentWriteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
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
		ArticleVO vo = new ArticleVO();
		vo.setParent(no);
		vo.setUid(uid);
		vo.setContent(content);
		vo.setRegip(regip);
		
		logger.debug("here3");
		ArticleVO comment = service.insertComment(vo);
		
		logger.debug("here4"+vo);
		JsonObject json = new JsonObject();
		json.addProperty("result", 1);
		json.addProperty("no", comment.getNo());
		json.addProperty("parent", comment.getParent());
		json.addProperty("nick", comment.getNick());
		json.addProperty("date", comment.getRdate());
		json.addProperty("content", comment.getContent());
		
		resp.setContentType("application/json;charset=UTF-8");
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
