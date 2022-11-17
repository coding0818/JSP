<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String pg = request.getParameter("pg");
	String no = request.getParameter("no");
	
	ArticleBean article = ArticleDAO.getInstance().selectArticle(no, cate);
	
	pageContext.include("/board/_"+group+".jsp");
%>
<main id="board">
    <section class="view">
        
        <table>
            <caption>글보기</caption>
                <tr>
                    <th>제목</th>
                    <td><input type="text" name="title" readonly value="<%= article.getTitle() %>"></td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td><a href="#"> <%= article.getOriName()%></a>&nbsp<span><%= article.getDownload() %></span>회 다운로드</td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="content" readonly><%= article.getContent() %></textarea></td>
                </tr>
        </table>
        <div>
                <a href="#" class="btn btnview">삭제</a>
                <a href="/Farmstory1/board/modify.jsp?group=<%=group %>&cate=<%=cate %>&no=<%=no %>" class="btn btnview">수정</a>
                <a href="/Farmstory1/board/list.jsp?group=<%=group %>&cate=<%=cate %>&pg=<%= pg %>" class="btn btnview">목록</a>
        </div>
        
        <!--댓글목록-->
        <section class="commentList">
            <h3>댓글목록</h3>
            <article>
                <span class="nick">길동이</span>
                <span class="date">20-05-20</span>
                <p class="content">
                    댓글 샘플입니다.
                </p>
                <div>
                    <a href="#" class="remove">삭제</a>
                    <a href="#" class="moldify">수정</a>
                </div>
            </article>

            <p class="empty">등록된 댓글이 없습니다.</p>
        </section>

        <!--댓글쓰기-->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="#">
                <textarea name="content">댓글내용 입력</textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete">
                </div>
            </form>
        </section>

       
    </section>
</main>
<%@ include file="/_footer.jsp" %>