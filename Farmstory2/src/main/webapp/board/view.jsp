<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../_header.jsp"></jsp:include>
<jsp:include page="./_${group}.jsp"/>
<script>
	$(function(){
		
		// 글 삭제 확인
		$('.btnRemove').click(function(){
			
			let isDelete = confirm('정말 삭제하시겠습니까?');
			
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
			
			console.log('here1');
			
			if(isDeleteOk){
				
				console.log('here2');
				
				let article = $(this).closest('article');
				let no = $(this).attr('data-no');
				let parent = $(this).attr('data-parent');
				
				console.log('here3');
				
				let jsonData = {"no":no, "parent":parent};
				
				console.log('here4'+jsonData);
				
				$.ajax({
					url:'/Farmstory2/board/commentDelete.do',
					type:'GET',
					data:jsonData,
					dataType:'json',
					success:function(data){
						
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
			let p_tag = $(this).parent().prev();
			
			if(txt == '수정'){
				$(this).text('수정완료');
				p_tag.attr('contentEditable', true);
				p_tag.focus();
			}else{
				$(this).text('수정');
				
				let no = $(this).attr('data-no');
				let content = p_tag.text();
				
				let jsonData = {"no":no, "content":content};
				
				$.ajax({
					url:'/Farmstory2/board/commentModify.do',
					type:'POST',
					data:jsonData,
					dataType:'json',
					success:function(data){
						
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
			
			console.log('here1');
			
			let no = $(this).children('input[name=no]').val();
			let uid = $(this).children('input[name=uid]').val();
			let textarea = $(this).children('textarea[name=content]');
			let content = textarea.val();
			
			console.log('here2');
			
			jsonData = {
					"no":no,
					"uid":uid,
					"content":content,
			};
			
			console.log('here3 : ' + jsonData);
			
			$.ajax({
				url:'/Farmstory2/board/commentWrite.do',
				method:'post',
				data:jsonData,
				dataType:'json',
				success:function(data){
					console.log('here4 : ' + data);
					
					if(data.result > 0){
						let comment = "<article>";
							comment += "<span class='nick'>"+data.nick+"</span>";
							comment += "<span class='date'>"+data.date+"</span>";
							comment += "<p class='content'>"+data.content+"</p>";
							comment += "<div>";
							comment += "<a href='#' class='remove' data-no='"+data.no+"' data-parent='"+data.parent+"'>삭제</a>&nbsp";
							comment += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
							comment += "</div>";
							comment += "</article>";
							
						$('.commentList > .empty').hide();
						$('.commentList').append(comment);
						textarea.val('');
					}
				}
			});
			console.log('here5');
			return false;
		});
		
	});
</script>
<main id="board">
    <section class="view">
        
        <table border="0">
            <caption>글보기</caption>
            <tr>
                <th>제목</th>
                <td><input type="text" name="title" value="${vo.title}" readonly/></td>
            </tr>
            <tr>
                <th>파일</th>
                <td><a href="/Farmstory2/board/download.do?parent=${vo.no}">${vo.oriName}</a>&nbsp;<span>${vo.download}</span>회 다운로드</td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea name="content" readonly>${vo.content}</textarea>
                </td>
            </tr>                    
        </table>
        
        <div>
        	<c:if test="${sessUser.uid eq vo.uid}">
        		<a href="/Farmstory2/board/delete.do?no=${vo.no}&pg=${pg}&group=${group}&cate=${cate}" class="btn btnRemove">삭제</a>
           	    <a href="/Farmstory2/board/modify.do?no=${vo.no}&pg=${pg}&group=${group}&cate=${cate}" class="btn btnModify">수정</a>
        	</c:if>
            
            <a href="/Farmstory2/board/list.do?pg=${pg}&group=${group}&cate=${cate}" class="btn btnList">목록</a>
        </div>

        <!-- 댓글목록 -->
        <section class="commentList">
            <h3>댓글목록</h3>                   
			<c:forEach var="comment" items="${comments}">
				<article>
	                <span class="nick">${comment.nick}</span>
	                <span class="date">${comment.rdate.substring(2, 10)}</span>
	                <p class="content">${comment.content}</p>
                <c:if test="${sessUser.uid eq comment.uid}">
                	<div>
	                    <a href="#" class="remove" data-no="${comment.no}" data-parent="${comment.parent}">삭제</a>
	                    <a href="#" class="modify" data-no="${comment.no}" data-pg="${pg}">수정</a>
	                </div>
                </c:if>                        
	                
	            </article>
			</c:forEach>
			<c:if test="${empty comments}">
				<p class="empty">등록된 댓글이 없습니다.</p>
			</c:if>

        </section>

        <!-- 댓글쓰기 -->
        <section class="commentForm">
            <h3>댓글쓰기</h3>
            <form action="#" method="post">
            	<input type="hidden" name="uid" value="${sessUser.uid}"/>
            	<input type="hidden" name="no" value="${vo.no}"/>
            	<input type="hidden" name="pg" value="${pg}"/>
                <textarea name="content" placeholder="댓글을 입력하세요."></textarea>
                <div>
                    <a href="#" class="btn btnCancel">취소</a>
                    <input type="submit" value="작성완료" class="btn btnComplete"/>
                </div>
            </form>
        </section>

    </section>
</main>
</article>
  </section>
</div>
<jsp:include page="../_footer.jsp"/>