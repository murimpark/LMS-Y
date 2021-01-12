<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>강사강좌조회상세보기</title>
	</head>
	<body>
		<!-- 부트스트랩(CSS) 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		
		<!-- 강좌 메뉴 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/stmgr-menu.jsp"></jsp:include>
	
		<div class=container>
			<div class="jumbotron">
				<h1>강좌조회 상세보기</h1>
			</div>
		</div>
		
		<div class=container>
			<table class="table">
				<thead>
					<tr>
						<td>강좌 번호</td>
						<td>강사 이름</td>
						<td>강좌 이름</td>
						<td>과목 이름</td>
						<td>강좌 개강일</td>
						<td>강좌 종강일</td>
						<td>출석확인</td>
						<td>자료실</td>
						<td>공지사항</td>
						<td>강의계획서</td>
					</tr>
				</thead>
				<tbody>
						<tr>
							<td>${classRegistration.lectureInfo.lectureNo}</td>
							<td>${classRegistration.lectureInfo.teacherName}</td>
							<td>${classRegistration.lectureInfo.lectureName}</td>
							<td>${classRegistration.subject.subjectName}</td>
							<td>${classRegistration.lectureInfo.lectureStartDate}</td>
							<td>${classRegistration.lectureInfo.lectureEndDate}</td>
							<td><a href="${pageContext.request.contextPath}/student/attendanceList?lectureNo=${param.lectureNo}&&target=weekDay&&currentYear=${currentYear}&&currentMonth=${currentMonth}&&currentDay=${currentDay}">출석확인</a></td>
							<td><a href="${pageContext.request.contextPath}/student/lectureArchive?lectureNo=${lecture.lectureNo}&&currentPage=1">자료실</a></td>
							<td><a href="${pageContext.request.contextPath}/student/lectureNotice?lectureNo=${lecture.lectureNo}&&currentPage=1">공지사항</a></td>
							<td><a href="${pageContext.request.contextPath}/student/syllabusDetail">강의계획서</a></td>
						</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>