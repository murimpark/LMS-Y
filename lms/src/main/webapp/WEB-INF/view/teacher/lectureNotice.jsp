<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>강좌 공지사항</title>
	</head>
	<body>
		<!-- 부트스트랩(CSS) 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		
		<!-- 강좌 메뉴 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/lectmgr-menu.jsp"></jsp:include>
		
			
			<div class="jumbotron">
				<div class=container>
					<h1>${lectureNo}강의 공지사항</h1>
				</div>
			</div>
			<!-- 검색 -->
			<div class="container">
				<div style="text-align:left;">
					<a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/teacher/createLectureNotice?lectureNo=${lectureNo}">글쓰기</a>
				</div>
				<form action="${pageContext.request.pathInfo}" method="get">
					<input type="hidden" name="lectureNo" value="${lectureNo}">
					<input type="hidden" name="currentPage" value="1">
					<div class="justify-content-end mb-3 input-group">
							<input class="form-control col-sm-2" type="text" name="lectureNoticeSearch" value="${lectureNoticeSearch}" placeholder="Search">
						<div class="input-group-append">
							<button class="btn btn-success" type="submit">검색</button>
						</div>
					</div>
				</form>
			</div>
			<div class="container">
				
				<table class="table">
					<thead>
						<tr class="text-center">
							<th>No.</th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회 수</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${navBeginPage == 0 || navLastPage == 0}">
							<tr>
								<td class="text-center" colspan="5">
									<span>공지사항에 게시글이 없습니다</span>
								</td>
							</tr>
						</c:if>
						<c:forEach var="ln" items="${lectureNoticeList}">
							<tr class="text-center">
								<td>${ln.lectureNoticeNo}</td>
								<td><a href="${pageContext.request.contextPath}/teacher/lectureNoticeOne?lectureNo=${lectureNo}&&lectureNoticeNo=${ln.lectureNoticeNo}">${ln.lectureNoticeTitle}</a></td>
								<td>${ln.lectureNoticeCreateDate}</td>
								<td colspan="1">${ln.lectureNoticeCount}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			<!-- 강좌 자료실 목록 페이징 -->
			<c:if test="${navBeginPage > 0 && navLastPage > 0}">
				<div style="margin-left:40%">
					<ul class="pagination">
						<c:if test="${null == lectureNoticeSearch}">
							<c:choose>
								<c:when test="${currentPage > '1'}">
									<!-- 현재 페이지가 1보다 클시 -->
									<!-- 현재 페이지가 1일시 -->
									<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/teacher/lectureNotice?lectureNo=${lectureNo}&currentPage=1">&lt;&lt;</a></li>
									<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/teacher/lectureNotice?lectureNo=${lectureNo}&currentPage=${currentPage-1}">&lt;</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item disabled">
										<a class="page-link" href="#"> &lt;&lt; </a>
									</li>
									<li class="page-item disabled">
										<a class="page-link" href="#">&lt;</a>
									</li>
								</c:otherwise>
								</c:choose>
									<!-- 현재 페이지 표시 -->
									<c:forEach var="i" begin="${navBeginPage}" end="${navLastPage}">
										<c:if test="${i <= lastPage}">
											<c:choose>
												<c:when test="${i == currentPage}">
												<li class="page-item active"><a class="page-link" href="#">${i}</a></li>
												</c:when>
												<c:otherwise>
												<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/teacher/lectureNotice?lectureNo=${lectureNo}&currentPage=${i}">${i}</a></li>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
									<!-- 현재 페이지가 마지막 페이지 보다 작을시 -->
									<!-- 현재 페이지가 마지막 페이지 일시 -->
								<c:choose>
								<c:when test="${currentPage < lastPage}">
									<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/teacher/lectureNotice?lectureNo=${lectureNo}&currentPage=${currentPage+1}">&gt;</a></li>
									<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/teacher/lectureNotice?lectureNo=${lectureNo}&currentPage=${lastPage}">&gt;&gt;</a></li>
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
						</c:if>
					</ul>
				</div>
				<!-- 검색 목록 페이징 -->
				<div style="margin-left:40%">
					<ul class="pagination">
						<c:if test="${null != lectureNoticeSearch}">
									<c:choose>
										<c:when test="${currentPage > '1'}">
											<!-- 현재 페이지가 1보다 클시 -->
											<!-- 현재 페이지가 1일시 -->
											<li class="page-item"><a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&&currentPage=1&&lectureNoticeSearch=${lectureNoticeSearch}">&lt;&lt;</a></li>
											<li class="page-item"><a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&&currentPage=${currentPage-1}&&lectureNoticeSearch=${lectureNoticeSearch}">&lt;</a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item disabled">
												<a class="page-link" href="#"> &lt;&lt; </a>
											</li>
											<li class="page-item disabled">
												<a class="page-link" href="#">&lt;</a>
											</li>
										</c:otherwise>
									</c:choose>
									<!-- 현재페이지 네비바 -->
									<!-- 현재 페이지 표시 -->
									<c:forEach var="i" begin="${navBeginPage}" end="${navLastPage}">
										<c:if test="${i <= lastPage}">
											<c:choose>
												<c:when test="${i == currentPage}">
													<li class="page-item active"><a class="page-link" href="#">${i}</a></li>
												</c:when>
												<c:otherwise>
													<li class="page-item"><a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&&currentPage=${i}&&lectureNoticeSearch=${lectureNoticeSearch}">${i}</a></li>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forEach>
									<!-- 다음, 마지막으로 -->
									<!-- 현재 페이지가 마지막 페이지 보다 작을시 -->
									<!-- 현재 페이지가 마지막 페이지 일시 -->
								<c:choose>
										<c:when test="${currentPage < lastPage}">
											<li class="page-item"><a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&&currentPage=${currentPage+1}&&lectureNoticeSearch=${lectureNoticeSearch}">&gt;</a></li>
											<li class="page-item"><a class="page-link" href="${pageContext.request.pathInfo}?lectureNo=${lectureNo}&&currentPage=${lastPage}&&lectureNoticeSearch=${lectureNoticeSearch}">&gt;&gt;</a></li>
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
						</c:if>
					</ul>
				</div>
			</c:if>
		</div>
	</body>
</html>