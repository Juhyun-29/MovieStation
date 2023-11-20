<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport"
   content="width=device-width, initial-scale=1, minimum-scale=1.0">
<title>영화 정보 - ${title}</title>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"
   integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ=="
   crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="js/sideBar.js"></script>
<script src="js/movieInfo.js"></script>
<link rel="stylesheet" href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css">
<link rel="stylesheet" href="css/frame.css" >
<link rel="stylesheet" href="css/movieInfo.css" >

</head>
<body>
 	<div id="container">
		<jsp:include page="frame/sideBarSearch.jsp"/>
		<div id="subContainer1">
			<div id="header">
				<div id="poster">
					<img alt="poster" src="${poster}" onerror="this.onerror=null; this.src='img/nullPoster.png';" style="width: 213px;">
				</div>
				<div id="main">
					<div id="title">
						<h1>
							<a href="movie?movieId=${movieId}&movieSeq=${movieSeq}">${title}</a>
						</h1>
					</div>
					<div id="detail">
						<div id="staffAndStarpoint" class="list">
							<h3 class="detailHeader">제작진</h3>
							<c:forEach items="${staffList}" var="staff">
								<a class="detail"><b>${staff.staffRoleGroup} | </b>${staff.staffNm}</a>
							</c:forEach>
							<br>
							<div id="score">
								<img alt="starpoint" src="img/score.png" width="90px">
								<a></a>
							</div>
						</div>
						<div id="info" class="infoList">
							<h3 class="detailHeader">기본정보</h3>
							<a class="detail"><b>개봉 | </b>${repRlsDate}</a>
							<a class="detail"><b>등급 | </b>${rating}</a>
							<a class="detail"><b>장르 | </b>${genre}</a>
							<a class="detail"><b>국가 | </b>${nation}</a>
							<a class="detail"><b>러닝타임 | </b>${runtime}분</a>
							<c:if test="${not empty productionList}">
								<c:forEach items="${productionList}" var="production">
									<a class="detail"><b>제작사 | </b>${production.staffNm}</a>
								</c:forEach>
							</c:if>
							<c:if test="${not empty distributorList}">
								<c:forEach items="${distributorList}" var="distributor">
									<a class="detail"><b>배급사 | </b>${distributor.staffNm}</a>
								</c:forEach>
							</c:if>
						</div>
						<div id="actorList" class="list">
							<h3 class="detailHeader">주요 출연진</h3>
							<c:forEach items="${actorList}" var="actor">
								<c:choose>
									<c:when test="${not empty actor.staffRole}">
										<a class="detail"><b>${actor.staffRole} | </b>${actor.staffNm}</a>
									</c:when>
									<c:otherwise>
										<a class="detail"><b>출연 | </b>${actor.staffNm}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
					<div id="detailMobile">
						<div id="staffInfo">
							<div id="staffList" class="list">
								<h3 class="detailHeader">제작진</h3>
								<c:forEach items="${staffList}" var="staff">
									<a class="detail"><b>${staff.staffRoleGroup} | </b>${staff.staffNm}</a>
								</c:forEach>
							</div>
							<div id="info" class="list">
								<h3 class="detailHeader">기본정보</h3>
								<a class="detail"><b>개봉 | </b>${repRlsDate}</a>
								<a class="detail"><b>등급 | </b>${rating}</a>
								<a class="detail"><b>장르 | </b>${genre}</a>
								<a class="detail"><b>국가 | </b>${nation}</a>
								<a class="detail"><b>러닝타임 | </b>${runtime}분</a>
								<c:if test="${not empty productionList}">
									<c:forEach items="${productionList}" var="production">
										<a class="detail"><b>제작사 | </b>${production.staffNm}</a>
									</c:forEach>
								</c:if>
								<c:if test="${not empty distributorList}">
									<c:forEach items="${distributorList}" var="distributor">
										<a class="detail"><b>배급사 | </b>${distributor.staffNm}</a>
									</c:forEach>
								</c:if>
							</div>
						</div>
						<div id="actorList" class="list">
							<h3 class="detailHeader">주요 출연진</h3>
							<c:forEach items="${actorList}" var="actor">
								<c:choose>
									<c:when test="${not empty actor.staffRole}">
										<a class="detail"><b>${actor.staffRole} | </b>${actor.staffNm}</a>
									</c:when>
									<c:otherwise>
										<a class="detail"><b>출연 | </b>${actor.staffNm}</a>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</div>
					</div>
				</div>

			</div>
			<div id="plot">
				<h3 class="detailHeader">소개</h3>
				<p id="plotText">${plotText}</p>
			</div>
			<c:choose>
				<c:when test="${fn:length(stilList)>1}">
					<div id="stil">
						<c:forEach items="${stilList}" var="stil">
							<a><img alt="스틸" src="${stil}"></a>
						</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<div id="noResult">
						<b><c:out value="${msg}" /></b>
					</div>
				</c:otherwise>
			</c:choose>
			<c:if test="${not empty sessionScope.id}">
				<c:choose>
					<c:when test="${empty myComment}">
						<form name="insertForm" action="insertComment" method="post">
							<div class="comment commentBox">
								<div class="starpoint_wrap">
									<div class="starpoint_box">
										<label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5개</span></label>
										<label for="starpoint_2" class="label_star" title="1"><span class="blind">1개</span></label>
										<label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5개</span></label>
										<label for="starpoint_4" class="label_star" title="2"><span class="blind">2개</span></label>
										<label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5개</span></label>
										<label for="starpoint_6" class="label_star" title="3"><span class="blind">3개</span></label>
										<label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5개</span></label>
										<label for="starpoint_8" class="label_star" title="4"><span class="blind">4개</span></label>
										<label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5개</span></label>
										<label for="starpoint_10" class="label_star" title="5"><span class="blind">5개</span></label>
										<input type="radio" name="starpoint" id="starpoint_1" class="star_radio" value="1">
										<input type="radio" name="starpoint" id="starpoint_2" class="star_radio" value="2">
										<input type="radio" name="starpoint" id="starpoint_3" class="star_radio" value="3">
										<input type="radio" name="starpoint" id="starpoint_4" class="star_radio" value="4">
										<input type="radio" name="starpoint" id="starpoint_5" class="star_radio" value="5">
										<input type="radio" name="starpoint" id="starpoint_6" class="star_radio" value="6">
										<input type="radio" name="starpoint" id="starpoint_7" class="star_radio" value="7">
										<input type="radio" name="starpoint" id="starpoint_8" class="star_radio" value="8">
										<input type="radio" name="starpoint" id="starpoint_9" class="star_radio" value="9">
										<input type="radio" name="starpoint" id="starpoint_10" class="star_radio" value="10">
										<span class="starpoint_bg"></span>
									</div>
								</div>
								<input type="text" name="content">
								<input type="hidden" name="movieId" value="${movieId}">
								<input type="hidden" name="movieSeq" value="${movieSeq}">
								<input type="hidden" name="nickname" value="${sessionScope.nickname}">
								<input type="hidden" name="id" value="${sessionScope.id}">
								<input class="btn" type="submit" value="등록">
							</div>
						</form>
					</c:when>
					<c:otherwise>
						<h3 class="starTitle">나의 별점 & 한줄평</h3>
						<div id="myComment" class="comment commentBox">
							<form name="deleteForm" action="deleteComment" method="post">
								<div class="cmt_starpoint_wrap">
									<div class="cmt_starpoint_box">
										<label for="starpoint_comment" class="cmt_label_star"></label>
										<span class="cmt_starpoint_bg" style="width: calc(${myComment.starpoint}*10%)"></span>
									</div>
								</div>
								<a class="a_number"><b>${myComment.starpoint}</b></a>
								<br>
								<a class="a_text">${myComment.content}</a>
								<br>
								<a class="a_text"><b>${myComment.nickname } |</b></a>
								<a class="a_number">${myComment.regdate}</a>
								<c:if test="${myComment.regdate!=myComment.updatedate}">
									<a class="a_number updateDate">(${myComment.updatedate}에 수정됨)</a>
								</c:if>
								<c:if test="${id==myComment.id}">
									<input type="hidden" name="movieId" value="${movieId}">
									<input type="hidden" name="movieSeq" value="${movieSeq}">
									<input type="hidden" name="rseq" value="${myComment.rseq}">
									<button class="btn" onclick="updateComment();return false;" style="margin-left: 5px;">수정</button>
									<input class="btn" type="submit" value="삭제">
								</c:if>
								<br>
							</form>
						</div>
						<div id="updateComment" class="comment commentBox" style="display: none;">
							<form name="updateForm" action="updateComment" method="post">
								<div class="starpoint_wrap">
									<div class="starpoint_box">
										<label for="starpoint_1" class="label_star" title="0.5"><span class="blind">0.5개</span></label>
										<label for="starpoint_2" class="label_star" title="1"><span class="blind">1개</span></label>
										<label for="starpoint_3" class="label_star" title="1.5"><span class="blind">1.5개</span></label>
										<label for="starpoint_4" class="label_star" title="2"><span class="blind">2개</span></label>
										<label for="starpoint_5" class="label_star" title="2.5"><span class="blind">2.5개</span></label>
										<label for="starpoint_6" class="label_star" title="3"><span class="blind">3개</span></label>
										<label for="starpoint_7" class="label_star" title="3.5"><span class="blind">3.5개</span></label>
										<label for="starpoint_8" class="label_star" title="4"><span class="blind">4개</span></label>
										<label for="starpoint_9" class="label_star" title="4.5"><span class="blind">4.5개</span></label>
										<label for="starpoint_10" class="label_star" title="5"><span class="blind">5개</span></label>
										<input type="radio" name="starpoint" id="starpoint_1" class="star_radio" value="1">
										<input type="radio" name="starpoint" id="starpoint_2" class="star_radio" value="2">
										<input type="radio" name="starpoint" id="starpoint_3" class="star_radio" value="3">
										<input type="radio" name="starpoint" id="starpoint_4" class="star_radio" value="4">
										<input type="radio" name="starpoint" id="starpoint_5" class="star_radio" value="5">
										<input type="radio" name="starpoint" id="starpoint_6" class="star_radio" value="6">
										<input type="radio" name="starpoint" id="starpoint_7" class="star_radio" value="7">
										<input type="radio" name="starpoint" id="starpoint_8" class="star_radio" value="8">
										<input type="radio" name="starpoint" id="starpoint_9" class="star_radio" value="9">
										<input type="radio" name="starpoint" id="starpoint_10" class="star_radio" value="10">
										<span class="starpoint_bg"></span>
									</div>
								</div>
								<input type="text" name="content" value="${myComment.content}">
								<input type="hidden" name="movieId" value="${movieId}">
								<input type="hidden" name="movieSeq" value="${movieSeq}">
								<input type="hidden" name="rseq" value="${myComment.rseq}">
								<input class="btn" type="submit" value="수정">
							</form>
						</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${fn:length(commentList)>0 }">
				<h3 class="starTitle">별점 & 한줄평</h3>
				<div id="commentList" class="commentBox">
					<c:forEach items="${commentList }" var="comment" varStatus="status">
						<form name="deleteForm" action="deleteComment" method="post">
							<div class="comment">
								<div class="cmt_starpoint_wrap">
									<div class="cmt_starpoint_box">
										<label for="starpoint_comment" class="cmt_label_star"></label>
										<span class="cmt_starpoint_bg" style="width: calc(${comment.starpoint}*10%)"></span>
									</div>
								</div>
								<a class="a_number"><b>${comment.starpoint}</b></a>
								<br>
								<a class="a_text">${comment.content}</a>
								<br>
								<a class="a_text"><b>${comment.nickname} |</b></a>
								<a class="a_number">${comment.regdate}</a>
								<c:if test="${comment.regdate!=comment.updatedate}">
									<a class="a_number updateDate">(${comment.updatedate}에 수정됨)</a>
								</c:if>
								<input type="hidden" name="movieId" value="${movieId}">
								<input type="hidden" name="movieSeq" value="${movieSeq}">
								<input type="hidden" name="rseq" value="${comment.rseq}">
								<c:if test="${role=='Admin'}">
									<input class="btn" type="submit" value="삭제">
								</c:if>
								<br>
							</div>
						</form>
					</c:forEach>
				</div>
			</c:if>
			<hr>
		</div>
 	</div> 
	<div id="footer"></div>
</body>
</html>