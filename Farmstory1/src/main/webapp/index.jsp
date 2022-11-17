<%@page import="kr.co.farmstory1.bean.ArticleBean"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/_header.jsp" %>
<%
	List<ArticleBean> latests = ArticleDAO.getInstance().selectLatests("grow", "school", "story");

	if(latests.size() < 15){
		ArticleBean ab = new ArticleBean();
		ab.setNo(0);
		ab.setTitle("무제");
		ab.setRdate("00-00-00");
		
		for(int i=0; i<15; i++){
			latests.add(ab);
		}
	}
%>
<script>
	$(function(){
		
			// 공지사항 최신글 가져오기
			$.get('/Farmstory1/board/proc/getLatests.jsp?cate=notice', function(data){
				for(let latest of data){
					let url = "./board/view/jsp?group=community&cate=notice&no="+latest.no+"&pg=1";
					$('#tabs-1 .txt').append("<li><a href='"+url+"'>"+latest.title+"</a></li>");
				}
			});
			$.get('/Farmstory1/board/proc/getLatests.jsp?cate=qna', function(data){
				for(let latest of data){
					let url = "./board/view/jsp?group=community&cate=qna&no="+latest.no+"&pg=1";
					$('#tabs-2 .txt').append("<li><a href='"+url+"'>"+latest.title+"</a></li>");
				}
			});
			$.get('/Farmstory1/board/proc/getLatests.jsp?cate=fna', function(data){
				for(let latest of data){
					let url = "./board/view/jsp?group=community&cate=fna&no="+latest.no+"&pg=1";
					$('#tabs-3 .txt').append("<li><a href='"+url+"'>"+latest.title+"</a></li>");
				}
			});
	})
	
</script>
<main>
    <div class="slider">
      <img src="/Farmstory1/img/main_slide_img_tit.png" alt>
      <div></div>
    </div>
    <div class="quick">
        <a href="/Farmstory1/board/list.jsp?group=community&cate=today&pg=1"><img src="./img/main_banner_sub1_tit.png" alt="오늘의식단"></a>
        <a href="/Farmstory1/board/list.jsp?group=community&cate=chef&pg=1"><img src="./img/main_banner_sub2_tit.png" alt="나도요리사"></a>
    </div>
    <div class="latest">
        <div>
          <a href="">
            <img src="/Farmstory1/img/main_latest1_tit.png" alt="">
          </a>
          <img src="/Farmstory1/img/main_latest1_img.jpg" alt="">
          <table>
          	<% 
          		for(int i=0; i<5; i++){ 
          			ArticleBean ab = latests.get(i);
          	%>
            <tr>
              <td></td>
              <td>
                <a href="./board/view.jsp?group=story&cate=grow&no=<%=ab.getNo()%>&pg=1"><%= ab.getTitle() %></a>
              </td>
              <td><%= ab.getRdate() %></td>
            </tr>
            <% } %>
            
          </table>
        </div>
        <div>
          <a href="">
            <img src="./img/main_latest2_tit.png" alt="">
          </a>
          <img src="./img/main_latest2_img.jpg" alt="">
          <table>
            <% 
          		for(int i=5; i<10; i++){ 
          			ArticleBean ab = latests.get(i);
          	%>
            <tr>
              <td></td>
              <td>
                <a href="./board/view.jsp?group=story&cate=school&no=<%=ab.getNo()%>&pg=1"><%= ab.getTitle() %></a>
              </td>
              <td><%= ab.getRdate() %></td>
            </tr>
            <% } %>
          </table>
        </div>
        <div>
          <a href="">
            <img src="./img/main_latest3_tit.png" alt="">
          </a>
          <img src="./img/main_latest3_img.jpg" alt="">
          <table>
            <% 
          		for(int i=10; i<15; i++){ 
          			ArticleBean ab = latests.get(i);
          	%>
            <tr>
              <td></td>
              <td>
                <a href="./board/view.jsp?group=story&cate=story&no=<%=ab.getNo()%>&pg=1"><%= ab.getTitle() %></a>
              </td>
              <td><%= ab.getRdate() %></td>
            </tr>
            <% } %>
          </table>
        </div>
    </div>
    <div class="info">
        <div>
          <img src="./img/main_sub2_cs_tit.png" class="tit" alt="고객센터 안내">
          <div class="tel">
            <img src="./img/main_sub2_cs_img.png" alt>
            <img src="./img/main_sub2_cs_txt.png" alt>
            <p class="time">
              평일: AM 09:00 ~ PM 06:00<br/>
              점심: PM 12:00 ~ PM 01:00<br/>
              토, 일요일, 공휴일 휴무
            </p>
          </div>
          <div class="btns">
            <a href="">
              <img src="./img/main_sub2_cs_bt1.png" alt>
            </a>
            <a href="">
              <img src="./img/main_sub2_cs_bt2.png" alt>
            </a>
            <a href="">
              <img src="./img/main_sub2_cs_bt3.png" alt>
            </a>
          </div>
        </div>
        <div>
          <img src="./img/main_sub2_account_tit.png" class="tit" alt>
          <p class="account">
            기업은행 123-456789-01-01-012<br/>
            국민은행 01-1234-56789<br/>
            우리은행 123-456789-01-01-012<br/>
            하나은행 123-456789-01-01<br/>
            예 금 주 (주)팜스토리
          </p>
        </div>
        <div>
        	<div>
                 <div id="tabs">
                     <ul>
                         <li><a href="#tabs-1">공지사항</a></li>
                         <li><a href="#tabs-2">1:1 고객문의</a></li>
                         <li><a href="#tabs-3">자주묻는 질문</a></li>
                     </ul>
                     <div id="tabs-1">
                         <ul class="txt txt-notice"></ul>
                     </div>
                     <div id="tabs-2">
                         <ul class="txt txt-qna"></ul>
                     </div> 
                     <div id="tabs-3">
                         <ul class="txt txt-fnq"></ul>
                     </div>
                 </div>
             </div>
        </div>
    </div>
</main>
<%@ include file="/_footer.jsp" %>    