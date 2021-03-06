<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>과제 목록</title>

<!-- jQuery 스크립트 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		// 폼 유효성 검사
		// code here...
	});
</script>
</head>

<body>
	<!-- 메뉴+CSS 인클루드 -->
	<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
	<!-- 강좌 메뉴 인클루드 -->
	<jsp:include page="/WEB-INF/view/inc/stmgr-menu.jsp"></jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1>과제 목록</h1>
		</div>
	</div>
	<div class="container">
		<table class="table">
			<tr>
				<th>No.</th>
				<th>제목</th>
				<th>시작 기한</th>
				<th>종료 기한</th>
				<th>수정날짜</th>
			</tr>
			<c:forEach var="r" items="${reportList}">
				<tr>
					<td>${r.reportNo}</td>
					<td>
						<a href="${pageContext.request.contextPath}/student/reportSubmitDetail?reportNo=${r.reportNo}&accountId=${accountId}">${r.reportTitle}</a>
					</td>
					<td>${r.reportStartDate}</td>
					<td>${r.reportEndDate}</td>
					<td>${r.reportUpdateDate}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="d-flex justify-content-center">
			<ul class="pagination">
				<!-- 처음으로, &lt; -->
				<c:choose>
					<c:when test="${currentPage > 1}">
						<li class="page-item">
							<a class="page-link"
							href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=1">&lt;&lt;</a></li>
						<li class="page-item">
							<a class="page-link"
							href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=${currentPage-1}">&lt;</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<a class="page-link" href="#">&lt;&lt;</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link" href="#">&lt;</a>
						</li>
					</c:otherwise>
				</c:choose>
				<!-- 현재페이지 네비바 -->
				<c:forEach var="i" begin="${navBeginPage}" end="${navLastPage}">
					<c:if test="${i <= lastPage}">
						<c:choose>
							<c:when test="${i == currentPage}">
								<li class="page-item active">
									<a class="page-link" href="#">${i}</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link"
									href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=${i}">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
				<!-- &gt;, 마지막으로 -->
				<c:choose>
					<c:when test="${currentPage < lastPage}">
						<li class="page-item">
							<a class="page-link"
							href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=${currentPage+1}">&gt;</a>
						</li>
						<li class="page-item">
							<a class="page-link"
							href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=${lastPage}">&gt;&gt;</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item disabled">
							<a class="page-link" href="#">&gt;</a>
						</li>
						<li class="page-item disabled">
							<a class="page-link" href="#">&gt;&gt;</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</body>
</html>