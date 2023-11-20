function idCheck(){
	if(newMember.id.value==0||newMember.id.value.length==0){
		/*alert("아이디를 입력해주세요.");*/
		$("#idMsg0").css("display","none");
		$("#idMsg1").css("display","none");
		$("#idMsg").css("display","block");
		newMember.id.focus();
	}else{
		$.ajax({
		url:"/idCheck",
        type:"post",
        dataType:"json",
        data:{"id" : $("#id").val()},
        success: function(data){
			if(data=="1"){
				/*alert("이미 사용 중인 아이디입니다. 다른 아이디를 사용해주세요.");*/
				$("#confirmId").attr("value",data);
				$("#idMsg").css("display","none");
				$("#idMsg0").css("display","none");
				$("#idMsg1").css("display","block");
				
			}else if(data=="0"){
				/*alert("사용 가능한 아이디입니다.");*/
				$("#confirmId").attr("value",data);
				$("#idMsg").css("display","none");
				$("#idMsg1").css("display","none");
				$("#idMsg0").css("display","block");
			}
        }
    });
	}
}

function pwCheck(){
	if(newMember.password.value==0||newMember.password.value.length==0){
		/*alert("비밀번호를 입력해주세요.");*/
		$("#pwMsg0").css("display","none");
		$("#pwMsg1").css("display","none");
		$("#pwMsg").css("display","block");
		newMember.password.focus();
	}else{
		if(newMember.password.value==newMember.pwConfirm.value){
			/*alert("비밀번호가 확인되었습니다.");*/
			$("#pwMsg").css("display","none");
			$("#pwMsg1").css("display","none");
			$("#pwMsg0").css("display","block");
		}else if(newMember.password.value!=newMember.pwConfirm.value){
			/*alert("입력한 비밀번호가 서로 다릅니다.");*/
			$("#pwMsg").css("display","none");
			$("#pwMsg0").css("display","none");
			$("#pwMsg1").css("display","block");
		}
	}
}

function nickCheck(){
	if(newMember.nickname.value==0||newMember.nickname.value.length==0){
		/*alert("닉네임을 입력해주세요.");*/
		$("#nickMsg").css("display","block");
		$("#nickMsg0").css("display","none");
		$("#nickMsg1").css("display","none");
		newMember.nickname.focus();
	}else{
		$.ajax({
		url:"/nickCheck",
        type:"post",
        dataType:"json",
        data:{"nickname" : $("#nickname").val()},
        success: function(data){
			if(data=="1"){
				/*alert("이미 사용 중인 닉네임입니다. 다른 닉네임을 사용해주세요.");*/
				$("#confirmNick").attr("value",data);
				$("#nickMsg").css("display","none");
				$("#nickMsg0").css("display","none");
				$("#nickMsg1").css("display","block");
			}else if(data=="0"){
				/*alert("사용 가능한 닉네임입니다.");*/
				$("#confirmNick").attr("value",data);
				$("#nickMsg").css("display","none");
				$("#nickMsg1").css("display","none");
				$("#nickMsg0").css("display","block");
			}
        }
    });
	}
}

function mailCheck(){
	if(newMember.mail.value==0||newMember.mail.value.length==0){
		alert("메일주소를 입력해주세요.");
		newMember.mail.focus();
	}else{
		$.ajax({
		url:"/mailCheck",
        type:"post",
        dataType:"json",
        data:{"mail" : $("#mail").val()},
        success: function(data){
			if(data=="1"){
				alert("이미 사용 중인 메일주소입니다. 다른 메일주소를 사용해주세요.");
				$("#confirmMail").attr("value",data);
			}else if(data=="0"){
				alert("사용 가능한 메일주소입니다. '인증번호'버튼을 눌러 인증번호를 발송해주세요.");
				$("#confirmMail").attr("value",data);
				$("#mailCheckBtn").css("display","none");
				$("#sendBtn").css("display","inline-block");
			}
        }
    });
	}
}

function sendNumber(){
	$("#mail_number").css("display","block");
	$.ajax({
		url:"/mail",
        type:"post",
        dataType:"json",
        data:{"mail" : $("#mail").val()},
        success: function(data){
			alert("인증번호가 발송되었습니다. 수신한 인증번호를 입력창에 입력해주세요.");
            $("#confirm").attr("value",data);
        }
    });
}

function confirmNumber(){
	var number1 = $("#number").val();
    var number2 = $("#confirm").val();

    if(number1 == number2){
		alert("인증되었습니다.");
	}else{
		alert("인증번호가 정확하지 않습니다.");
    }
}

function newMemberReg(){
	   if(newMember.id.value==0||newMember.id.value.length==0){
		   alert("아이디를 입력해주세요.");
		   newMember.id.focus();
	   }else if(newMember.confirmId.value=="1"){
		   alert("이미 사용 중인 아이디입니다. 다른 아이디를 사용해주세요.");
		   newMember.id.focus();
	   }else if(newMember.password.value==0||newMember.password.value.length==0){
		   alert("비밀번호를 입력해주세요.");
		   newMember.password.focus();
	   }else if(newMember.pwConfirm.value==0||newMember.pwConfirm.value.length==0){
		   alert("비밀번호 확인을 진행해주세요.");
		   newMember.pwConfirm.focus();
	   }else if(newMember.password.value!=newMember.pwConfirm.value){
		   alert("입력한 비밀번호가 서로 다릅니다. 비밀번호를 확인해주세요.");
		   newMember.pwConfirm.focus();
	   }else if(newMember.name.value==0||newMember.name.value.length==0){
		   alert("이름을 입력해주세요.");
		   newMember.name.focus();
	   }else if(newMember.birthday.value==0||newMember.birthday.value.length==0){
		   alert("생일을 입력해주세요.");
		   newMember.birthday.focus();
	   }else if(newMember.nickname.value==0||newMember.nickname.value.length==0){
		   alert("닉네임을 입력해주세요.");
		   newMember.nickname.focus();
	   }else if(newMember.confirmNick.value=="1"){
		   alert("이미 사용 중인 닉네임입니다. 다른 닉네임을 사용해주세요.");
		   newMember.nickname.focus();
	   }else if(newMember.gender.value==0||newMember.gender.value.length==0){
		   alert("성별을 입력해주세요.");
	   }else if(newMember.mail.value==0||newMember.mail.value.length==0){
		   alert("이메일을 입력해주세요.");
		   newMember.mail.focus();
	   }else if(newMember.confirmMail.value=="1"){
		   alert("이미 사용 중인 메일주소입니다. 다른 메일주소를 사용해 인증 절차를 진행해주세요.");
		   newMember.mail.focus();
	   }else if(newMember.number.value==0||newMember.number.value.length==0||newMember.number.value!=newMember.confirm.value){
		   alert("인증번호를 입력하지 않았거나 인증번호가 정확하지 않습니다. 인증번호를 확인해주세요.");
	   }else{
		   newMember.method = "post";
		   newMember.action = "/insertUser";
		   newMember.submit();
	   }
   }