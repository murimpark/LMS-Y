<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>강좌 수정</title>
		
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
	
		<div class="jumbotron">
 			<div class="container">
    			<h1>강좌 수정</h1>
 			 </div>
			</div>
				<form id="postId" method="post" action="${pageContext.request.contextPath}/manager/modifyLectureManager?lectureNo=${lecture.lectureNo}">
					<div class="container">
				<table class="table"> 
					<tr>
						<td>강사 Id</td>							
						<td><input type="text" name="accountId" id="accountId" value="${accountId}"></td>
						
					</tr>
					<tr>
						<td>과목명</td>
						<td>
							<select name="subjectNo" class="btn btn-default dropdown-toggle">
								<c:forEach items="${subjectList}" var="subject"> 	
									<option value="${subject.subjectNo}">${subject.subjectName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>강사 이름</td>							
						<td><input type="text" name="teacherName" id="teacherNameId" value="${lecture.teacherName}"></td>
					</tr>
					<tr>
						<td>교재명</td>							
						<td>
							<select name="textbookISBN" class="btn btn-default dropdown-toggle">
								<c:forEach items="${textbookList}" var="textbook">	
									<option value="${textbook.textbookISBN}">교재이름:${textbook.textbookTitle}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>강좌명</td>							
						<td><input type="text" name="lectureName" id="lectureNameId" value="${lecture.lectureName}"></td>
					</tr>
					<tr>	
						<td>강좌 시작일</td>							
						<td><input class="form-control" type="date"  name="lectureStartDate" id="lectureStartDateId" value="${lecture.lectureStartDate}"></td>
						
						<td>강좌 종료일</td>							
						<td><input type="date"  name="lectureEndDate" id="lectureEndDateId" value="${lecture.lectureEndDate}"></td>
					</tr>
					<tr>	
						<td>강좌 정원</td>							
						<td><input type="text"  name="lectureTotal" id="lectureTotalId" value="${lecture.lectureTotal}" ></td>
					</tr>
					<tr>
					
						<td>강의실</td>	
					<td>						
						<select name="classroomNo" class="btn btn-default dropdown-toggle">
								<c:forEach items="${classroomList}" var="c">	
									<option value="${c.classroomNo}">${c.classroomNumber}호실</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
						<button class="btn btn-outline-primary" id="submitId" type="button">입력</button>
					</div>		
				</form>
			
	</body>
</html>