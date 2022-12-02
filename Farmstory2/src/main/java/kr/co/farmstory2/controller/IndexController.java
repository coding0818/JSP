package kr.co.farmstory2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;


@WebServlet("/index.do")
public class IndexController extends HttpServlet{

	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public void init() throws ServletException {
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		logger.info("IndexController...");
		
		String grow = "grow";
		String school = "school";
		String story = "story";
		
		logger.info("here1");
		
		List<ArticleVO> latests = service.selectLatests(grow, school, story);
		
		if(latests.size() < 15) {
			logger.info("here2");
			ArticleVO vo = new ArticleVO();
			vo.setNo(0);
			vo.setTitle("무제");
			vo.setRdate("00-00-00");
			
			for(int i=0; i<15; i++) {
				latests.add(vo);
			}
		}
		
		logger.info("here3");
		req.setAttribute("latests", latests);
		
		logger.info("here4");
		RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
		dispatcher.forward(req, resp);
	}
}
