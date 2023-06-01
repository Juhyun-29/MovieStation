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
<link rel="stylesheet" href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css">
<link rel="stylesheet" href="css/movie.css" >

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
							<h3 class="detailHeader">출연</h3>
							<c:forEach items="${actorList}" var="actor">
								<a class="detail"><b>${actor.staffRole} 역 | </b>${actor.staffNm}</a>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div id="plot" class="header">
				<h3 class="detailHeader">소개</h3>
				<p>${plotText}</p>
			</div>
			<c:choose>
				<c:when test="${fn:length(stllList)>1}">
					<div id="stll">
						<c:forEach items="${stllList}" var="stll">
							<a><img alt="스틸" src="${stll}"></a>
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
						<form name="commentForm" action="insertComment" method="post">
						<div class="commentList">
							<h3>나의 별점 & 한줄평 등록하기</h3>
							<div class="comment">
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
								<a class="a_number">최대 별 5개(10점)</a>
								<br><input id="commentInput" type="text" name="content">
								<input type="hidden" name="movieId" value="${movieId}">
								<input type="hidden" name="movieSeq" value="${movieSeq}">
								<input type="hidden" name="nickname" value="${sessionScope.nickname}">
								<input type="hidden" name="id" value="${sessionScope.id}">
								<input id="commentSubmit" type="submit" value="등록">
							</div>
						</div>
						</form>
					</c:when>
					<c:otherwise>
						<div class="commentList">
						<h3>나의 별점 & 한줄평</h3>
						<div class="comment">
							<div class="cmt_starpoint_wrap">
								<div class="cmt_starpoint_box">
									<label for="starpoint_comment" class="cmt_label_star"></label>
									<span class="cmt_starpoint_bg" style="width: calc(${myComment.starpoint}*10%)"></span>
								</div>
							</div>
							<a class="a_number"><b>${myComment.starpoint}</b></a><br>
							<a class="a_text">${myComment.content}</a><br>
							<a class="a_text"><b>${myComment.nickname } |</b></a> <a class="a_number">${myComment.regdate}</a>
							<c:if test="${sessionScope.id==myComment.id || role=='Admin'}">
								<a class="a_text" href="javascript:void(0)" onclick="javascript:updateComment()">수정</a>
								<a class="a_text" href="javascript:void(0)" onclick="javascript:deleteComment()">삭제</a>
								<form name="commentForm" method="post">
									<input type="hidden" name="movieId" value="${movieId}">
									<input type="hidden" name="movieSeq" value="${movieSeq}">
									<input type="hidden" name="rseq" value="${myComment.rseq}">
									<input type="hidden" name="starpoint" value="${myComment.starpoint}">
									<input type="hidden" name="content" value="${myComment.content}">
								</form>
							</c:if>
						</div>
						</div>
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${fn:length(commentList)>0 }">
				<div class="commentList">
					<h3>별점 & 한줄평</h3>
					<div id="js-load" class="main">
					<ul class="lists">
						<c:forEach items="${commentList }" var="comment" varStatus="status">
							<li class="lists_item js-load">
								<div class="comment">
									<div class="cmt_starpoint_wrap">
										<div class="cmt_starpoint_box">
											<label for="starpoint_comment" class="cmt_label_star"></label>
											<span class="cmt_starpoint_bg" style="width: calc(${comment.starpoint}*10%)"></span>
										</div>
									</div>
									<a class="a_number"><b>${comment.starpoint}</b></a><br>
									<a class="a_text">${comment.content}</a><br>
									<a class="a_text"><b>${comment.nickname} |</b></a> <a class="a_number">${comment.regdate}</a>
									<input type="hidden" id="rseq${status.current}" value="${comment.rseq}">
									<input type="hidden" id="starpoint${status.current}" value="${comment.starpoint}">
									<input type="hidden" id="content${status.current}" value="${comment.content}">
									<c:if test="${id==comment.id || role=='Admin'}">
										<a class="a_text" onclick="updateComment()" style="margin-left: 10px;">수정</a>
										<a class="a_text" href="deleteComment?rseq=${comment.rseq}">삭제</a>
									</c:if>
									<br>
								</div>
							</li>
						</c:forEach>
					</ul>
					 <div id="js-btn-wrap" class="btn-wrap"> <a href="javascript:;" class="button">더보기</a> </div>
					</div>
				</div>
			</c:if>
			<hr>
		</div>
 	</div> 
	<div id="footer"></div>
    <script>
    $(function () {
        $(".starpoint_box").addClass("checked");
        $(".label_star").each(function (i, o) {
            $(this).on("mouseover", function () {
                if($(".starpoint_box").hasClass("checked")===true){
                    var widthValue = (i + 1) * 10;
                    $(".starpoint_bg").css("width", widthValue + "%");
                }
            })
        
            $(this).on("click", function () {
                    var widthValue = (i + 1) * 10;
                    $(".starpoint_bg").css("width", widthValue + "%");
                    $(".starpoint_box").toggleClass("checked");
            })
        });
    });

    $(window).on('load', function () {
        load('#js-load', '5');
        $("#js-btn-wrap .button").on("click", function () {
            load('#js-load', '5', '#js-btn-wrap');
        })
    });
     
    function load(id, cnt, btn) {
        var commentList = id + " .js-load:not(.active)";
        var commentLength = $(girls_list).length;
        var commentTotalCnt;
        if (cnt < commentLength) {
        	commentTotalCnt = cnt;
        } else {
        	commentTotalCnt = commentLength;
            $('.button').hide()
        }
        $(commentList + ":lt(" + commentTotalCnt + ")").addClass("active");
    }
    
    
	function deleteComment(){
		document.commentForm.action="deleteComment";
		document.commentForm.submit();
	}
    </script>

</body>
</html>