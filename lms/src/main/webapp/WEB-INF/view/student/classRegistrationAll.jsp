<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>수강신청</title>
		
		<!-- jQuery 스크립트 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
		 
		<div class="container">
			<h1>수강 목록</h1>
			<table class="table">
					<tr>
						<th>강좌 번호</th>
						<th>강사 이름</th>
						<th>과목 이름</th>
						<th>수강신청일</th>
						<th>강좌 점수</th>
						<th>강좌 리뷰</th>
						<th>강좌 상세보기</th>
					</tr>
				<tbody>
					<c:forEach var="r" items="${classRegistrationAllList}">
					<tr>
						<td>${r.lectureInfo.lectureNo}</td>
						<td>${r.lectureInfo.teacherName}</td>
						<td>${r.lectureInfo.lectureName}</td>
						<td>${r.classRegistrationCreateDate}</td>
						<td>${r.classRegistrationPoint}</td>
						<td>${r.classRegistrationReview}</td>
						<td><a href="${pageContext.request.contextPath}/student/classRegistrationDetail?lectureNo=${r.lectureNo}">과목 상세보기</a></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		
		
		<c:if test="${null eq classregistrationAllList}">
				<div>
					<!-- 처음으로, 이전 -->
					<c:choose>
						<c:when test="${currentPage > 1}">
							<a href="${pageContext.request.pathInfo}?currentPage=1">[처음으로]</a>
							<a href="${pageContext.request.pathInfo}?currentPage=${currentPage-1}"><</a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
					<!-- 현재페이지 네비바 -->
					<c:forEach var="i" begin="${navBeginPage}" end="${navLastPage}">
						<c:if test="${i <= lastPage}">
							<c:choose>
								<c:when test="${i == currentPage}">
									<a href="#">[${i}]</a>
								</c:when>
								<c:otherwise>
									<a href="${pageContext.request.pathInfo}?currentPage=${i}">[${i}]</a>
								</c:otherwise>
							</c:choose>
						</c:if>
					</c:forEach>
					<!-- 다음, 마지막으로 -->
					<c:choose>
						<c:when test="${currentPage < lastPage}">
							<a href="${pageContext.request.pathInfo}?currentPage=${currentPage+1}">></a>
							<a href="${pageContext.request.pathInfo}?currentPage=${lastPage}">[마지막으로]</a>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
		</div>
	</body>
</html>