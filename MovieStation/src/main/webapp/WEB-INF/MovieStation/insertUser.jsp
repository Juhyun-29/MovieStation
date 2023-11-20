<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport"
   content="width=device-width, initial-scale=1, minimum-scale=1.0">
<title>무비스테이션 - 회원가입</title>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
   integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
   crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="js/insertUser.js"></script>
<script src="js/sideBar.js"></script>
<link rel="stylesheet" href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css">
<link rel="stylesheet" href="css/frame.css" >
<link rel="stylesheet" href="css/insertUser.css" >

</head>
<body>
	<div id="container">
		<jsp:include page="frame/sideBarIndex.jsp"/>
		<div id="subContainer1">
  			<div id="main">
  				<div id="formBox">
  					<form id="form" name="newMember">
						<img alt="logo" src="img/movieStation.png">
  						<ul>
  							<li>
								아이디
							</li>
							<li>
								<input class="input" type="text" id="id" name="id" oninput="idCheck()" placeholder="아이디 입력">
								<input type="text" id="confirmId" name="confirmId" style="display: none" value="">
							</li>
							<li>
								<a id="idMsg" class="msg" style="display: none">아이디를 입력해주세요.</a>
								<a id="idMsg0" class="msg" style="display: none">사용 가능한 아이디입니다.</a>
								<a id="idMsg1" class="msg" style="display: none">이미 사용 중인 아이디입니다. 다른 아이디를 사용해주세요.</a>
							</li>
							<li>
								비밀번호
							</li>
							<li>
								<input class="input" type="password" name="password" placeholder="비밀번호 입력">
							</li>
							<li>
								<input class="input" type="password" name="pwConfirm" oninput="pwCheck()" placeholder="비밀번호 확인">
							</li>
							<li>
								<a id="pwMsg" class="msg" style="display: none">위에서부터 차례로 비밀번호를 입력해주세요.</a>
								<a id="pwMsg0" class="msg" style="display: none">비밀번호가 확인되었습니다.</a>
								<a id="pwMsg1" class="msg" style="display: none">입력한 비밀번호가 서로 다릅니다.</a>
							</li>
  							<li>
								이름
							</li>
							<li>
								<input class="input" type="text" name="name" placeholder="이름 입력" autocomplete="on">
							</li>
  							<li>
								생일
							</li>
							<li>
								<input class="input" type="date" name="birthday">
							</li>
							<li>
								닉네임
							</li>
							<li>
								<input class="input" type="text" id="nickname" name="nickname" oninput="nickCheck()" placeholder="닉네임 입력">
								<input type="text" id="confirmNick" name="confirmNick" style="display: none" value="">
							</li>
							<li>
								<a id="nickMsg" class="msg" style="display: none">닉네임을 입력해주세요.</a>
								<a id="nickMsg0" class="msg" style="display: none">사용 가능한 닉네임입니다.</a>
								<a id="nickMsg1" class="msg" style="display: none">이미 사용 중인 닉네임입니다. 다른 닉네임을 사용해주세요.</a>
							</li>
  							<li>
								성별
							</li>
							<li>
								<div id="gender_input">
									남성<input class="select" type="radio" name="gender" value="남성">
									여성<input class="select" type="radio" name="gender" value="여성">
									그외<input class="select" type="radio" name="gender" value="그외">
								</div>
							</li>
  							<li>
								이메일
							</li>
							<li>
								<div id="mail_input" name="mail_input">
									<input class="checkInput" type="email" id="mail" name="mail" placeholder="이메일 입력">
									<input type="text" id="confirmMail" name="confirmMail" style="display: none" value="">
									<button type="button" class="checkBtn" id="mailCheckBtn" name="mailCheckBtn" onclick="mailCheck()">중복확인</button>
									<button type="button" class="checkBtn" id="sendBtn" name="sendBtn" style="display: none" onclick="sendNumber()">인증번호</button>
								</div>
							</li>
							<li id="mail_number" style="display: none">
								<div name="mail_number">
									<input class="checkInput" type="text" id="number" name="number" placeholder="인증번호 입력">
									<input type="text" id="confirm" name="confirm" style="display: none" value="">
									<button type="button" class="checkBtn" id="confirmBtn" name="confirmBtn" onclick="confirmNumber()">이메일 인증</button>
								</div>
							</li>
  							<li>
								<button class="lastBtn" onclick="newMemberReg();return false;">회원가입</button>
								<button class="lastBtn" type="reset" onclick="resetAlert();">다시쓰기</button>
							</li>
  						</ul>
  					</form>
  				</div>
  			</div>
  		</div>
	</div>
	<div id="footer"></div>
</body>
</html>