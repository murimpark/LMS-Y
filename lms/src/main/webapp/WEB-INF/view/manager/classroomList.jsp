<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>ClassroomList</title>
		
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
		<div class="jumbotron">
			<h1>강의실 목록</h1>
			</div>
			<div>
				<a href="${pageContext.request.contextPath}/manager/createClassroom">작성</a>
				<table class=table>
					<tr>
						<th>강의실 고유번호</th>
						<th>강의실 호실</th>
					</tr>
				<c:forEach items="${classroomList}" var="c">
					<tr>
						<td><a href="${pageContext.request.contextPath}/manager/classroomDetail?classroomNo=${c.classroomNo}">${c.classroomNo}</a></td>
						<td>${c.classroomNumber}</td>
					</tr>
					
				
				</c:forEach>	
				
				
				</table>
				
			</div>
		</div>
	</body>
</html>