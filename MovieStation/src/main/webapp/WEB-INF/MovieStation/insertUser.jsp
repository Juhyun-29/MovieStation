<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport"
   content="width=device-width, initial-scale=1, minimum-scale=1.0">
<title>영화 통합검색</title>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
   integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
   crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="js/search.js"></script>
<script src="js/sideBar.js"></script>
<link rel="stylesheet" href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css">
<link rel="stylesheet" href="css/user.css" >

</head>
<body>
	<div id="container">
		<jsp:include page="frame/sideBarIndex.jsp"/>
		<div id="subContainer">
  			<div id="main">
  				<div id="formBox">
  					<form id="form" name="form" action="insertUser" method="post">
  						<ul>
  							<li><label for="id">아이디 : </label><input class="input" type="text" name="id"></li>
  							<li><label for="password">비밀번호 : </label><input class="input" type="password" name="password"></li>
  							<li><label for="name">이름 : </label><input class="input" type="text" name="name"></li>
  							<li><label for="nickname">닉네임 : </label><input class="input" type="text" name="nickname"></li>
  							<li><label for="birthday">생일 : </label><input class="input" type="date" name="birthday"></li>
  							<li><label for="gender">성별 : </label>남성<input type="radio" name="gender" value="남성">여성<input type="radio" name="gender" value="여성"></li>
  							<li><label for="mail">이메일 : </label><input class="input" type="email" name="mail"></li>
  							<li> <input type="submit" value="회원가입"> </li>
  						</ul>
  					</form>
  				</div>
  			</div>
  		</div>
	</div>
	<div id="footer"></div>
</body>
</html>