<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>질문게시판 목록</title>
	</head>
	
	<body>
		<!-- 메뉴+CSS 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		<!-- 강좌 메뉴 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/lectmgr-menu.jsp"></jsp:include>
		
		<div class="jumbotron">
			<div class="container">
				<h1>질문게시판 목록</h1>
			</div>
		</div>
		
		<div class="container">
			<div>
				<table class="table">
					<thead>
						<tr>
							<th>No.</th>
							<th class="w-50">제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${navBeginPage == 0 || navLastPage == 0}">
							<tr>
								<td class="text-center" colspan="5">
									<span>질문게시판에 질문이 없습니다</span>
								</td>
							</tr>
						</c:if>
						<c:forEach var="q" items="${list}">
							<%-- 임시방편, 협업자가 메서드의 기능을 완성하면 제거바람 --%>
							<c:if test="${q.lectureNo == lectureNo}">
								<tr>
									<td>${q.questionNo}</td>
									<td>
										<a href="${pageContext.request.contextPath}/teacher/questionDetail?questionNo=${q.questionNo}">
											${q.questionTitle}
										</a>
									</td>
									<td>${q.questionWriter}</td>
									<td>${q.questionCreateDate}</td>
									<td>${q.questionCount}</td>
								</tr>
							</c:if>
						</c:forEach>
						<tr>
							<td colspan="5"></td>
						</tr>
					</tbody>
				</table>
				
				<c:if test="${navBeginPage > 0 && navLastPage > 0}">
					<div class="d-flex justify-content-center mt-4">
						<ul class="pagination">
							<%-- 이전 버튼 --%>
							<c:if test="${navBeginPage != 1}">
								<li class="page-item">
									<a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}">&lt;&lt;</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=${navBeginPage-1}">&lt;</a>
								</li>
							</c:if>
							<c:if test="${navBeginPage == 1}">
								<li class="page-item disabled">
									<a class="page-link">&lt;&lt;</a>
								</li>
								<li class="page-item disabled">
									<a class="page-link">&lt;</a>
								</li>
							</c:if>
							
							<%-- 각 페이지 이동 버튼 --%>
							<c:forEach var="p" begin="${navBeginPage}" end="${navLastPage}" step="1">
								<c:if test="${(param.currentPage != null && p != param.currentPage) || (param.currentPage == null && p != 1)}">
									<li class="page-item">
										<a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=${p}">${p}</a>
									</li>
								</c:if>
								<c:if test="${(param.currentPage != null && p == param.currentPage) || (param.currentPage == null && p == 1)}">
									<li class="page-item active">
										<a class="page-link">${p}</a>
									</li>
								</c:if>
							</c:forEach>
							
							<%-- 다음 버튼 --%>
							<c:if test="${navLastPage != lastPage}">
								<li class="page-item">
									<a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=${navLastPage+1}">&gt;</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&currentPage=${lastPage}">&gt;&gt;</a>
								</li>
							</c:if>
							<c:if test="${navLastPage == lastPage}">
								<li class="page-item disabled">
									<a class="page-link">&gt;</a>
								</li>
								<li class="page-item disabled">
									<a class="page-link">&gt;&gt;</a>
								</li>
							</c:if>
						</ul>
					</div>
				</c:if>
			</div>
		</div>
	</body>
</html>