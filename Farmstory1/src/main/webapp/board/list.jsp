<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String pg = request.getParameter("pg");
	
	int limitStart = 0;
	int currentPage = 1;
	int total = 0;	
	int lastPageNum = 0;
	int pageGroupCurrent = 1;
	int pageGroupStart = 1;
	int pageGroupEnd = 0;
	int pageStartNum = 0;
	
	total = ArticleDAO.getInstance().selectCountTotal(cate);
	if(total % 10 == 0){
		lastPageNum = total / 10;
	}else{
		lastPageNum = (total / 10) + 1;
	}
	if(pg != null){
		currentPage = Integer.parseInt(pg);	
	}
	limitStart = (currentPage - 1) * 10;
	pageGroupCurrent = (int)Math.ceil(currentPage / 10.0);
	pageGroupStart = (pageGroupCurrent - 1) * 10 + 1;
	pageGroupEnd = pageGroupCurrent * 10;
	
	if(pageGroupEnd > lastPageNum){
		pageGroupEnd = lastPageNum;
	}
	pageStartNum = total - limitStart;
	
	List<ArticleBean> articles =  ArticleDAO.getInstance().selectArticles(cate, limitStart);

	pageContext.include("/board/_"+group+".jsp");
%>
	<main id="board">
	    <section class="list">
	       <caption>글목록</caption>
	        <table border="0">
	            <tr>
	                <th>번호</th>
	                <th>제목</th>
	                <th>글쓴이</th>
	                <th>날짜</th>
	                <th>조회</th>
	            </tr>
	            <% for(ArticleBean article : articles){ %>
	            <tr>
	                <td><%= pageStartNum-- %></td>
	                <td><a href="/Farmstory1/board/view.jsp?group=<%= group %>&cate=<%= cate%>&no=<%=article.getNo()%>&pg=<%= currentPage %>"><%= article.getTitle() %>[<%= article.getComment() %>]</a></td>
	                <td><%= article.getNick() %></td>
	                <td><%= article.getRdate().substring(2, 10) %></td>
	                <td><%= article.getHit() %></td>
	            </tr>
	            <% } %>
	       </table>
	       <div class="page">
	       		<% if(pageGroupStart > 1){ %>
	            <a href="./list.jsp?group=<%=group %>&cate=<%=cate %>&pg=<%= pageGroupStart-1 %>" class="prev">이전</a>
	            <% } %>
	            <% for(int num = pageGroupStart; num<=pageGroupEnd; num++){ %>
	            <a href="./list.jsp?group=<%=group %>&cate=<%=cate %>&pg=<%= num %>" class="num <%=(num==currentPage)? "current":"off"%>"><%= num %></a>
	            <% } %>
	            <% if(pageGroupEnd < lastPageNum){ %>
	            <a href="./list.jsp?group=<%=group %>&cate=<%=cate %>&pg=<%= pageGroupEnd + 1 %>" class="next">다음</a>
	            <% } %>
	       </div>
	       <a href="/Farmstory1/board/write.jsp?group=<%= group %>&cate=<%= cate%>"  class="btn btnWrite">글쓰기</a>
	    </section>
	</main>
	</article>
  </section>
</div>
<%@ include file="/_footer.jsp" %>