<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<body>
		<div id="sideBar">
			<div class="logo">
				<a id="logo" href="index"><img alt="logo" src="img/movieStation.png" width="100%"></a>
			</div>
			<div class="btnImg">
				<a id="searchBtn" class="link1 active" href="search"><img alt="searchImg" src="img/search.png" width="30px"><br>검색</a> 
			</div>
			<div class="btnImg">
				<a id="homeBtn" class="link2" href="index"><img alt="homeImg" src="img/home.png" width="30px"><br>홈</a>
			</div>
			<div class="btnImg">
				<a id="boardBtn" class="link3" href="#"><img alt="boxofficeImg" src="img/boxoffice.png" width="30px"><br>게시판</a>
			</div>
			<div class="btnImg">
				<a id="boxOfficeBtn" class="link4" href="boxOfficeList"><img alt="nowplayingImg" src="img/nowplaying.png" width="30px"><br>박스오피스</a>
			</div>
			<div class="btnImg">
				<a id="myPageBtn" class="link5" href="#"><img alt="upcomingImg" src="img/upcoming.png" width="30px"><br>마이페이지</a>
			</div>
			<div id="loginout">
				<c:choose>
					<c:when test="${empty name}">
						<div id="insertUser">
							<a href="insertUser">회원가입</a>
						</div>
						<div id="login">
							<a href="login">로그인</a>
						</div>
					</c:when>
					<c:otherwise>
						<a id="logout" href="logout">로그아웃</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
</body>

