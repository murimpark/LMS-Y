<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>LMS 공지 수정</title>
		
		<!-- jQuery 스크립트 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 		<!-- NAVER SmartEditor2 스크립트 -->
		<script src="${pageContext.request.contextPath}/se2/js/service/HuskyEZCreator.js"></script>
 		<script>
            $(document).ready(function() {
				// submit시 유효성 검사
				$('#submitBtn').click(function() {
					oEditors.getById["lmsNoticeContentId"].exec("UPDATE_CONTENTS_FIELD", []);

					// 댓글 내용을 입력하지 않았을 경우 입력 요구 및 포커스 이동
					if ($('#lmsNoticeTitleId').val() == '') {
						alert('제목을 입력해주세요.');
						$('#lmsNoticeTitleId').focus();
						return
					}
					if ($('#lmsNoticeContentId').val() == '') {
						alert('내용을 입력해주세요.');
						$('#lmsNoticeContentId').focus();
						return
					}
					// 유효성 검사를 만족했을 경우 submit
					$('#formId').submit();
				});

				// NAVER SmartEditor2 적용 코드
				let oEditors = [];
				nhn.husky.EZCreator.createInIFrame({
					oAppRef: oEditors,
					elPlaceHolder: "lmsNoticeContentId",	// 적용할 textarea 태그의 id 속성
					sSkinURI: "${pageContext.request.contextPath}/se2/SmartEditor2Skin.html",	
					htParams : {
						bUseToolbar : true,			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : true,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true,		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						I18N_LOCALE : "ko_KR"
					},
					fCreator: "createSEditor2"
				});
            });
        </script>
	</head>
	
	<body>
		<!-- 메뉴+CSS 인클루드 -->
		<jsp:include page="/WEB-INF/view/inc/menu.jsp"></jsp:include>
		<div class="jumbotron">
			<div class="container">
				<h1>LMS 공지수정</h1>
			</div>
		</div>
		<div class="container">
			<div>
				<form id="formId" action="${pageContext.request.contextPath}/manager/modifyLMSNotice" method="post">
					<input type="hidden" name="lmsNoticeNo" value="${lmsNotice.lmsNoticeNo}">
					<table class="table">
						<tr>
							<td>제목</td>
							<td>
								<div class="form-group">
									<input class="form-control container-fluid" id="lmsNoticeTitleId" type="text" name="lmsNoticeTitle" value="${lmsNotice.lmsNoticeTitle}">
								</div>		
							</td>
						</tr>
						<tr>
							<td colspan="2">
							<div class="form-group">
								<textarea id="lmsNoticeContentId" name="lmsNoticeContent" style="width: 100%">${lmsNotice.lmsNoticeContent}</textarea>
							</div>
							</td>
						</tr>
					</table>
					<div class="form-group d-flex justify-content-end">
						<button class="btn btn-outline-success" id="submitBtn" type="button">수정</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>