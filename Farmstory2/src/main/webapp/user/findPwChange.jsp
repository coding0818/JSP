<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../_header.jsp"/>
<script src="/Farmstory2/js/validation.js"></script>
<script>
	$(function(){
		$('.btnNext').click(function(e){
			e.preventDefault();
			
			let pass1 = $('input[name=pass1]').val();
			let pass2 = $('input[name=pass2]').val();
			let uid = $('#uid').text();
			
			if(pass2.match(rePass)){
				if(pass1 == pass2){
					
					$('.passResult').css('color', 'green').text('사용하실 수 있는 비밀번호입니다.');
					
					let jsonData = {"uid":uid, "pass":pass2};
					
					$.ajax({
						url:'/Farmstory2/user/findPwChange.do',
						method:'post',
						data:jsonData,
						dataType:'json',
						success:function(data){
							if(data.result > 0){
								alert('비밀번호가 변경되었습니다.\n로그인을 하시기 바랍니다.');
								location.href = "/Farmstory2/user/login.do";
							}
						}
					});
				}else{
					$('.passResult').css('color', 'red').text('비밀번호가 일치하지 않습니다.');
				}
			}else{
				$('.passResult').css('color', 'red').text('숫자,영문,특수문자 포함 5자리 이상이어야 합니다.');
			}
		});
	});
</script>
        <main id="user">
            <section class="find findPwChange">
                <form action="#">
                    <table border="0">
                        <caption>비밀번호 변경</caption>                        
                        <tr>
                            <td>아이디</td>
                            <td id="uid">${sessUserForPw.uid}</td>
                        </tr>
                        <tr>
                            <td>새 비밀번호</td>
                            <td>
                                <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
                            	<span class="passResult"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>새 비밀번호 확인</td>
                            <td>
                                <input type="password" name="pass1" placeholder="새 비밀번호 입력"/>
                            </td>
                        </tr>
                    </table>                                        
                </form>
                
                <p>
                    비밀번호를 변경해 주세요.<br>
                    영문, 숫자, 특수문자를 사용하여 8자 이상 입력해 주세요.                    
                </p>

                <div>
                    <a href="/Farmstory2/user/login.do" class="btn btnCancel">취소</a>
                    <a href="./login.html" class="btn btnNext">다음</a>
                </div>
            </section>
        </main>
        <jsp:include page="../_footer.jsp"/>