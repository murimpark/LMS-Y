<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입 승인대기 중인 운영자 상세정보</title>
		
		<!-- jQuery 스크립트 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
			$(document).ready(function() {
				$('#approveBtn').click(function() {
					let approve = confirm('정말 회원가입을 승인하시겠습니까?');
					
					if(approve) {
						location.replace('${pageContext.request.contextPath}/admin/approveManagerMembership?accountId=${managerQueueDetail.accountId}');
						alert('회원가입이 승인되었습니다.');
					} else {
						alert('취소하였습니다.');
						return;
					}
        		});
        		
        		$('#disapproveBtn').click(function() {
					let disapprove = confirm('정말 회원가입을 거부하시겠습니까?');
					
					if(disapprove) {
						location.replace('${pageContext.request.contextPath}/admin/disapproveManagerMembership?accountId=${managerQueueDetail.accountId}');
						alert('회원가입이 거부되었습니다.');
					} else {
						alert('취소하였습니다.');
						return;
					}
        		});
        	});
        </script>
	</head>
	
	<body>
		<!-- 메뉴+CSS 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		
		<div class="container">
			<h1>회원가입 승인대기 중인 운영자 상세정보</h1>
			
			<div>
				<table class="table">
					<tr>
						<td>아이디</td>						
						<td>${managerQueueDetail.accountId}</td>
					</tr>
					<tr>
						<td>Email</td>
						<td>${managerQueueDetail.managerEmail}</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>${managerQueueDetail.managerName}</td>
					</tr>
					<tr>
						<td>핸드폰 번호</td>
						<td>${managerQueueDetail.managerPhone}</td>
					</tr>
					<tr>
						<td>성별</td>
						<td>${managerQueueDetail.managerGender}</td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td>${managerQueueDetail.managerBirth}</td>
					</tr>
					<tr>
						<td>주소</td>
						<td>${managerQueueDetail.managerAddressMain}</td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td>${managerQueueDetail.managerAddressSub}</td>
					</tr>
				</table>
			</div>
			
			<div>
				<button type="button" id="approveBtn">
					승인
				</button>
				<button type="button" id="disapproveBtn">
					거부
				</button>
			</div>
		</div>
	</body>
</html>