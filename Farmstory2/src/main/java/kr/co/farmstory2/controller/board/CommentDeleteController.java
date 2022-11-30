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

@WebServlet("/board/commentDelete.do")
public class CommentDeleteController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		logger.debug("here1");
		String no = req.getParameter("no");
		String parent = req.getParameter("parent");
		
		logger.debug("here2");
		int result = service.deleteComment(no, parent);
		
		logger.debug("here3");
		JsonObject json = new JsonObject();
		json.addProperty("result", result);

		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
