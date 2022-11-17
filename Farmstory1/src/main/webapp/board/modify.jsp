<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String no = request.getParameter("no");
	String pg = request.getParameter("pg");
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no, cate);
	
	pageContext.include("/board/_"+group+".jsp");
%>
<main id="board">
    <section class="modify">
        <form action="./proc/modifyProc.jsp">
            <input type="hidden" name="no" value="<%= no%>"/>
            <input type="hidden" name="group" value="<%= group%>"/>
            <input type="hidden" name="cate" value="<%= cate%>"/>
            <input type="hidden" name="pg" value="<%= pg%>"/>
            <table>
                <caption>글수정</caption>
                	
                    <tr>
                        <th>제목</th>
                        <td><input type="text" name="title" value="<%= article.getTitle()%>"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td><textarea name="content"><%= article.getContent() %></textarea></td>
                    </tr>
                    <tr>
                        <th>파일</th>
                        <td>
                            <input type="file" name="file">
                        </td>
                    </tr>
            </table>
            <div>
                    <a href="./view.jsp?group=<%=group %>&cate=<%=cate %>&no=<%=no %>" class="btn btnCancel">취소</a>
                    <input type="submit" value="수정완료" class="btn btnComplete">
            </div>
        </form>
       
    </section>
</main>
</article>
  </section>
</div>
<%@ include file="/_footer.jsp" %>