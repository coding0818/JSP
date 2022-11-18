<%@page import="java.util.List"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	if(sessUser == null){
		response.sendRedirect("/Farmstory1/user/login.jsp?success=101");
		return;
	}
	String group = request.getParameter("group");
	String cate = request.getParameter("cate");
	String pg = request.getParameter("pg");
	String no = request.getParameter("no");
	
	ArticleDAO dao = ArticleDAO.getInstance();
	
	dao.updateArticleHit(no);
	ArticleBean article = dao.selectArticle(no, cate);
	List<ArticleBean> comments = dao.selectComments(no);
	
	pageContext.include("/board/_"+group+".jsp");
%>
<script>
	$(document).ready(function(){
		
		$('.btnRemove').click(function(){
			
			let isDelete = confirm('정말 삭제 하시겠습니까?');
			
			if(isDelete){
				return true;
			}else{
				return false;
			}
			
		});
		
		// 댓글 삭제
		$(document).on('click', '.remove', function(e){
			e.preventDefault();
			let isDeleteOk = confirm('정말 삭제 하시겠습니까?');
			
			if(isDeleteOk){
				let article = $(this).closest('article');
				let no = $(this).attr(data-no);
				let parent = $(this).attr(data-parent);
				
				
				jsonData = {"no":no, "parent":parent};
				$.ajax({
					url:'/Farmstory1/proc/commentDeleteProc.jsp',
					type:'GET',
					data:jsonData,
					dataType:'json',
					success: function(data){
						
						if(data.result == 1){
							alert('댓글이 삭제되었습니다.');
							article.hide();
						}
					}
				});
			}
			
		});
		
		// 댓글 수정
		$(document).on('click', '.modify', function(e){
			e.preventDefault();
			
			let txt = $(this).text();
			let p_tag = $(this).parent.prev();
			
			if(txt == '수정'){
				$(this).text('수정완료');
				p_tag.attr('contentEditable', true);
				p_tag.focus();
			}else{
				$(this).text('수정');
				
				let no = $(this).attr(data-no);
				let content = p_tag.text();
				
				jsonData = {"no":no, "content":content};
				
				$.ajax({
					url:'/Farmstory1/board/proc/commentModifyProc.jsp',
					type:'POST',
					data:jsonData,
					dataType:'json',
					success: function(data){
						
						if(data.result == 1){
							alert('댓글이 수정되었습니다.');
							p_tag.attr('contentEditable', false);
						}
					}
				});
			}
			
		});
		
		// 댓글 작성
		$('.commentForm > form').submit(function(){
			let no       = $(this).children('input[name=no]').val();
			let uid      = $(this).children('input[name=uid]').val();
			let textarea = $(this).children('textarea[name=content]');
			let content  = textarea.val();
			
			if(content == ''){
				alert('댓글을 작성하세요.');
				return false;
			}
			
			let jsonData = {"uid":uid, "no":no, "content":content};
			
			$.ajax({
				url:'/Farmstory1/board/proc/commentWriteProc.jsp',
				method:'post',
				data: jsonData,
				dataType:'json',
				success: function(data){
					if(data.result > 0){
						
						let article = "<article>";
							article += "<span class='nick'>"+data.nick+"</span>";  
							article += "<span class='date'>"+data.date+"</span>";  
							article += "<p class='content'>"+data.content+"</p>";  
							article += "<div>";  
							article += "<a href='#' class='remove' data-no='"+data.no+" data-parent='"+data.parent+"'>삭제</a>&nbsp";  
							article += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";  
							article += "</div>";
							article += "</article>";
						
						$('.commentList > .empty').hide();
						$('.commentList').append(article);
						textarea.val('');
					}
				}
			});
			return false;
		});
	});
</script>
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
                    <% if(article.getFile() >1){ %>
                    <td><a href="#"> <%= article.getOriName()%></a>&nbsp<span><%= article.getDownload() %></span>회 다운로드</td>
                    <% }else{ %>
                    <td></td>
                    <%} %>
                   
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea name="content" readonly><%= article.getContent() %></textarea></td>
                </tr>
        </table>
        <div>
                <a href="#" class="btn btnview">삭제</a>
                <a href="/Farmstory1/board/modify.jsp?group=<%=group %>&cate=<%=cate %>&no=<%=no %>&pg=<%= pg %>" class="btn btnview">수정</a>
                <a href="/Farmstory1/board/list.jsp?group=<%=group %>&cate=<%=cate %>&pg=<%= pg %>" class="btn btnview">목록</a>
        </div>
        
        <!--댓글목록-->
        <section class="commentList">
            <h3>댓글목록</h3>

			<% for(ArticleBean comment : comments){ %>            
            <article>
                <span class="nick"><%= comment.getNick() %></span>
                <span class="date"><%= comment.getRdate().substring(2, 10) %></span>
                <p class="content">
                    <%= comment.getContent() %>
                </p>
                <% if(sessUser.getUid().equals(comment.getUid())){ %>
                <div>
                    <a href="#" class="remove" data-no="<%= comment.getNo()%>" data-parent="<%= comment.getParent()%>">삭제</a>
                    <a href="#" class="modify" data-no="<%= comment.getNo()%>">수정</a>
                </div>
                <% } %>
            </article>
            <% } %>

            <% if(comments.size() == 0){ %>
            <p class="empty">등록된 댓글이 없습니다.</p>
            <% } %>
        </section>

        <!--댓글쓰기-->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="/Farmstory1/board/proc/commentWriteProc.jsp">
            	<input type="hidden" name="uid" value="<%= sessUser.getUid() %>">
            	<input type="hidden" name="no" value="<%= no %>">
                <textarea name="content">댓글내용 입력</textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete">
                </div>
            </form>
        </section>

       
    </section>
</main>
</article>
  </section>
</div>
<%@ include file="/_footer.jsp" %>