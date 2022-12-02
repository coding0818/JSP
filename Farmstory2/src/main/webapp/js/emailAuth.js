
let preventDoubleClick = false;
let isEmailAuthOk = false;

$(function(){
	let emailcode = 0;
		
	$('#btnEmailAuth').click(function(){
		
		let email = $('input[name=email]').val();
		
		console.log('here1 : ' + email);
		
		if(email == ''){
			alert('이메일을 입력하세요.');
			return;
		}
		
		if(preventDoubleClick){			
			return;
		}
		
		preventDoubleClick = true;
		
		console.log('here2');
		
		$('.resultEmail').text('인증코드 전송 중 입니다. 잠시만 기다리세요...');
		
		$.ajax({
			url:'/Farmstory2/user/emailAuth.do',
			method:'get',
			data:{"email":email},
			dataType:'json',
			success: function(data){
				// console.log(data);
				if(data.status == 1){
					// 메일발송 성공
					emailcode = data.code;
					$('.emailResult').text('인증코드를 전송했습니다. 이메일을 확인하세요.');
					$('.auth').show();
					
				}else{
					// 메일발송 실패
					$('.emailResult').text('인증코드 전송이 실패했습니다. 이메일을 확인 후 다시 시도하세요.');
				}
			}
		});
			
		
	});
	
	// 이메일 인증코드 확인
	$('#btnEmailConfirm').click(function(){
		let code = $('input[name=auth]').val();
		
		if(code == emailcode){
			isEmailAuthOk = true;
			$('.emailResult').text('이메일이 인증되었습니다.');
		}
	});
})

