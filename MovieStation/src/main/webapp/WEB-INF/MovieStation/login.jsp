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
<link rel="stylesheet" href="css/frame.css" >


</head>
<body>
	<div id="container">
		<jsp:include page="frame/sideBarIndex.jsp"/>
		<div id="subContainer1">
  			<div id="main">
  				<div id="formBox">
  					<form id="form" name="form" action="login" method="post">
  						<ul>
  							<li>
								아이디
							</li>
							<li>
								<input class="input" type="text" name="id">
							</li>
  							<li>
								비밀번호
							</li>
							<li>
								<input class="input" type="password" name="password">
							</li>
  							<li> <input type="submit" value="로그인"></li>
  						</ul>
  						<a href="getUserId">아이디 찾기</a><a href="getUserPw">비밀번호 찾기</a><a href="insertUser">회원가입</a>
  					</form>
  				</div>
  			</div>
  		</div>
	</div>
	<div id="footer"></div>
</body>
</html>