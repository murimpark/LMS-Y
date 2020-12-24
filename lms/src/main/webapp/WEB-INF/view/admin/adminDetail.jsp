<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>관리자 정보</title>
		
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
			<h1>관리자 정보</h1>
			
			<!-- 관리자 정보 -->
			<div>
				<table border="1">
					<tr>
						<td>아이디</td>
						<td>${admin.accountId}</td>
					</tr>
					<tr>
						<td>Email</td>
						<td>${admin.adminEmail}</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>${admin.adminPhone}</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>${admin.adminName}</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>