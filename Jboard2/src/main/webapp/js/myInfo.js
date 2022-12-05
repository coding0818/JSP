/**
 * 날짜 : 2022/10/21
 * 이름 : 박가영
 * 내용 : register 자바스크립트
 */
 // 데이터 검증에 사용하는 정규표현식
let reUid   = /^[a-z]+[a-z0-9]{5,19}$/g;
let rePass  = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,16}$/;
let reName  = /^[ㄱ-힣]+$/;
let reNick  = /^[a-zA-Zㄱ-힣0-9][a-zA-Zㄱ-힣0-9]*$/;
let reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
let reHp    = /^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/;

// 폼 데이터 검증 결과 상태변수
let isNameOk  = false;
let isNickOk  = false;
let isEmailOk = false;
let isEmailAuthOk = false;
let isHpOk    = false;

$(function(){
	
	
	// 이름 검사하기
	$('input[name=name]').focusout(function(){
		
		let name = $(this).val();
		
		if(name.match(reName)){
			isNameOk = true;
			$('.nameResult').text('');
		}else{
			isNameOk = false;
			$('.nameResult').css('color', 'red').text('유효한 이름이 아닙니다.');
		}
	});
	
	// 별명 검사하기
	$('input[name=nick]').keydown(function(){
		isNickOk = false;
	});
	
	$('#btnNickCheck').click(function(){
		
		let nick = $('input[name=nick]').val();
		
		if(isNickOk){
			return;
		}
		
		if(!nick.match(reNick)){
			$('.nickResult').css('color', 'red').text('유효한 닉네임이 아닙니다.');
			isNickOk = false;
			return;
		}
		
		let jsonData = {"nick":nick};
		
		$('.nickResult').css('color', 'black').text('...');	
		setTimeout(function(){
			$.ajax({
				url: '/Jboard2/user/checkNick.do',
				method : 'get',
				data: jsonData,
				dataType : 'json',
				success: function(data){
					if(data.result == 0){
						$('.nickResult').css('color', 'green').text('사용 가능한 닉네임 입니다.');		
						isNickOk = true;
					}else{
						$('.nickResult').css('color', 'red').text('이미 사용중인 닉네임 입니다.');
						isNickOk = false;
					}	
				}
			});
		},500);
	});
	
	// 이메일 검사하기
	$('input[name=email]').focusout(function(){
		
		let email = $(this).val();
		
		if(email.match(reEmail)){
			isEmailOk = true;
			$('.emailResult').text('');
		}else{
			isEmailOk = false;
			$('.emailResult').css('color', 'red').text('유효하지 않은 이메일 입니다.');
		}
		
	});
	
	
	
	// 휴대폰 검사하기		
	$('input[name=hp]').focusout(function(){
		
		let hp = $(this).val();
		
		if(hp.match(reHp)){
			isHpOk = true;
			$('.hpResult').text('');
		}else{
			isHpOk = false;
			$('.hpResult').css('color', 'red').text('유효하지 않은 번호 입니다.');
		}
		
	});
	
	// 최종 폼 전송할 때
	$('.register > form').submit(function(){
		
		
		// 이름 검증
		if(!isNameOk){
			alert('이름이 유효하지 않습니다.');
			return false;
		}
		
		// 별명 검증
		if(!isNickOk){
			alert('별명이 유효하지 않습니다.');
			return false;
		}
		
		
		
		// 휴대폰 검증
		if(!isHpOk){
			alert('휴대폰이 유효하지 않습니다.');
			return false;
		}
		
		return true;
		
	});
	
});


