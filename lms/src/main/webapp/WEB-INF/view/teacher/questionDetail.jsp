<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>질문게시판 게시글</title>
	</head>
	
	<body>
		<!-- 메뉴+CSS 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		<!-- 강좌 메뉴 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/lectmgr-menu.jsp"></jsp:include>
		
		<div class="jumbotron">
			<div class="container">
				<h1>질문게시판 게시글</h1>
				<h5 class="ml-1">No. ${question.questionNo}</h5>
			</div>
		</div>
		
		<div class="container">
			<table class="table">
				<tr>
					<td>게시글 제목</td>
					<td colspan="3">${question.questionTitle}</td>
				</tr>
				<tr class="small">
					<td style="width: 20%">게시글 작성자</td>
					<td style="width: 30%">${question.questionWriter}</td>
					<td style="width: 20%">게시글 조회수</td>
					<td style="width: 30%">${question.questionCount}</td>
				</tr>
				<tr class="small">
					<td>게시글 생성일</td>
					<td>${question.questionCreateDate}</td>
					<td>게시글 수정일</td>
					<td>${question.questionUpdateDate}</td>
				</tr>
				<tr>
					<td colspan="4">게시글 내용</td>
				</tr>
				<tr>
					<td class="px-4" colspan="4">${question.questionContent}</td>
				</tr>
			</table>
			<table class="table">
				<thead>
					<tr>
						<th colspan="4">
							<span>댓글</span>
							<a class="badge badge-pill badge-primary" href="${pageContext.request.contextPath}/teacher/createQuestionComment?questionNo=${question.questionNo}">작성</a>
						</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="qc" items="${question.questionComment}">
						<%-- 댓글이 없을 때는 표시하지 않음 --%>
						<c:if test="${qc.questionCommentNo != 0}">
							<tr class="small" style="border-top: 2px solid #DEE2E6">
								<td>댓글 고유번호</td>
								<td>
									<span>${qc.questionCommentNo}</span>
									<%-- 세션의 accountId와 댓글 작성자 accountId가 같을때만 수정버튼 표시 --%>
									<c:if test="${accountId == qc.accountId}">
										<a class="badge badge-pill badge-primary" href="${pageContext.request.contextPath}/teacher/modifyQuestionComment?questionCommentNo=${qc.questionCommentNo}">수정</a>
									</c:if>
								</td>
								<td>댓글 작성자</td>
								<td>${qc.questionCommentWriter}</td>
							</tr>
							<tr class="small">
								<td style="width: 20%">댓글 생성일</td>
								<td style="width: 30%">${qc.questionCommentCreateDate}</td>
								<td style="width: 20%">댓글 수정일</td>
								<td style="width: 30%">${qc.questionCommentUpdateDate}</td>
							</tr>
							<tr>
								<td colspan="4">댓글 내용</td>
							</tr>
							<tr>
								<td colspan="4">${qc.questionCommentContent}</td>
							</tr>
							<tr>
								<td>첨부파일</td>
								<td colspan="3">
									<c:forEach var="qcf" items="${qc.questionCommentFileList}">
										<%-- 파일 사이즈가 0 이상일 때만 보여줌 --%>
										<c:if test="${qcf.questionCommentFileSize > 0}">
											<div>
												<a href="${pageContext.request.contextPath}/teacher/downloadQuestionCommentFile?questionCommentFileUUID=${qcf.questionCommentFileUUID}">
													${qcf.questionCommentFileOriginal}
												</a>
												<span class="small">${qcf.questionCommentFileSize} byte / ${qcf.questionCommentFileCount}회 다운로드</span>
											</div>
										</c:if>
									</c:forEach>
								</td>
							</tr>
							<tr>
								<td colspan="4"></td>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</body>
</html>