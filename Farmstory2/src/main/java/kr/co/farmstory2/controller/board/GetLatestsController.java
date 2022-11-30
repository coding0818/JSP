package kr.co.farmstory2.controller.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.vo.ArticleVO;

@WebServlet("/board/getLatests.do")
public class GetLatestsController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private ArticleService service = ArticleService.INSTANCE;
	
	@Override
	public void init() throws ServletException {
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cate1 = req.getParameter("cate1");
		String cate2 = req.getParameter("cate2");
		String cate3 = req.getParameter("cate3");
		
		List<ArticleVO> latests = service.selectLatests(cate1, cate2, cate3);
	
		if(latests.size() < 15) {
			ArticleVO vo = new ArticleVO();
			vo.setNo(0);
			vo.setTitle("무제");
			vo.setRdate("00-00-00");
			
			for(int i=0; i<15; i++) {
				latests.add(vo);
			}
		}
		
		req.setAttribute("latests", latests);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
