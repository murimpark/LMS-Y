<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>studentLectureQuestionList</title>

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
				<h1>${lectureNo}강좌질문 게시판</h1>
			</div>
		</div>
		<!-- studentlectureSearch-->
		<div class="container">
			<div style="text-align: left">
				<a class="btn btn-outline-primary"
					href="${pageContext.request.contextPath}/student/createStudentQuestion?lectureNo=${lectureNo}">질문추가</a>
			</div>
			<form action="${pageContext.request.pathInfo}" method="get">
				<input type="hidden" name="lectureNo" value="${lectureNo}"> <input type="hidden" name="currentPage" value="1">
				<div class="justify-content-end mb-3 input-group">
					<input class="form-control col-sm-2" type="text" name="studentLectureSearch" value="${studentlectureSearch}" placeholder="Search">
					<div class="input-group-append">
						<button class="btn btn-success" type="submit">Search</button>
					</div>
				</div>
			</form>
		</div>
		<div class="container">
			<table class="table ">
				<thead>
					<tr class="text-center">
						<th>No.</th>
						<th>작성자 이름</th>
						<th>제목</th>
						<th>생성 날짜</th>
						<th>조회수</th>
				<tbody>
					<c:forEach var="q" items="${questionList}">
						<tr class="text-center">
							<td>${q.questionNo}</td>
							<td>${q.questionWriter}</td>
							<td><a
								href="${pageContext.request.contextPath}/student/studentQuestionDetail?questionNo=${q.questionNo}">${q.questionTitle}</a></td>
							<td>${q.questionCreateDate}</td>
							<td>${q.questionCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<c:if test="${null eq studentlectureSearch}">
			<div style="margin-left: 40%">
				<ul class="pagination">
					<c:if test="${null == studentlectureSearch}">
						<c:choose>
							<c:when test="${currentPage > '1'}">
								<!-- 현재 페이지가 1보다 클시 -->
								<!-- 현재 페이지가 1일시 -->
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=1">
										&lt;&lt;</a></li>
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=${currentPage-1}">
										&lt;</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link"
									href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=1">
										&lt;&lt;</a></li>
								<li class="page-item disabled"><a class="page-link"
									href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=${currentPage-1}">&lt;</a>
								</li>
							</c:otherwise>
						</c:choose>
						<!-- 현재 페이지 표시 -->
						<!-- 현재 페이지 표시 -->
						<c:forEach var="i" begin="${navBeginPage}" end="${navLastPage}">
							<c:if test="${i <= lastPage}">
								<c:choose>
									<c:when test="${i == currentPage}">
										<li class="page-item active"><a class="page-link" href="#">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li class="page-item"><a class="page-link"
											href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=${i}">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:if>
						</c:forEach>
						<!-- 현재 페이지가 마지막 페이지 보다 작을시 -->
						<!-- 현재 페이지가 마지막 페이지 일시 -->
						<c:choose>
							<c:when test="${currentPage < lastPage}">
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=${currentPage+1}">&gt;</a></li>
								<li class="page-item"><a class="page-link"
									href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=${lastPage}">&gt;&gt;</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="page-link"
									href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=${currentPage+1}">&gt;</a>
								</li>
								<li class="page-item disabled"><a class="page-link"
									href="${pageContext.request.contextPath}/student/studentLectureQuestionList?lectureNo=${lectureNo}&currentPage=${lastPage}">&gt;&gt;</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:if>
				</ul>
			</div>
		</c:if>
	</body>
</html>