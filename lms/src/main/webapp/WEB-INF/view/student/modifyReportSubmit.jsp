<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>과제 제출</title>
		
		<!-- jQuery 스크립트 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <!-- NAVER SmartEditor2 스크립트 -->
		<script src="${pageContext.request.contextPath}/se2/js/service/HuskyEZCreator.js"></script>
        <script>
            $(document).ready(function() {
				// 첨부파일 추가버튼에 대한 이벤트 처리를 등록함
				$('#addFile').click(function() {
					// 첨부파일 프레임의 마지막 부분에 첨부파일 input 태그 및 삭제 버튼을 추가함
					$('#reportSubmitFileFrame').append(`
						<div class="form-group d-flex">
							<div>
								<input class="reportSubmitFile form-control-file" name="reportSubmitFileList" type="file">
							</div>
							<button class="removeFile btn btn-outline-danger" type="button">삭제</button>
						</div>
					`);
					// (바로 위의 코드에서 추가한) 삭제버튼에 대한 이벤트 처리를 등록함
					$('.removeFile').last().click(function(event) {
						// 삭제버튼의 부모(위 코드의 div 태그)를 HTML상에서 완전히 지워버림
						$(event.target).parent().remove();
					});
				});

				// 첨부파일 삭제버튼에 대한 이벤트 처리를 등록함
				$('.removeReportSubmitFile').click(function(event) {
					let filename = $.trim($(event.target).siblings('.reportSubmitFileOriginal').text());
					let remove = confirm('정말 등록한 파일 "'+filename+'" 을(를) 삭제하시겠습니까?\n\n삭제한 파일은 복구할 수 없습니다.');
					if (remove) {
						alert('삭제하였습니다');
					} else {
						return false;
					}
					
					$.ajax({
						url: $(event.target).prop('href'),
						method: 'post',
						success: function(removed) {
							if (removed) {
								$(event.target).parent().remove();
							}
						}
					});
					
					return false;
				});
				// 작성 버튼 클릭 시 유효성 검사 실시
				$('#submitBtn').click(function() {
					// NAVER SmartEditor2에 적은 내용을 실제 form 태그에 적용
					oEditors.getById["reportSubmitContent"].exec("UPDATE_CONTENTS_FIELD", []);
					
					// 댓글 내용을 입력하지 않았을 경우 입력 요구 및 포커스 이동
					let contentText = $('#reportSubmitContent').val().replace(/<.+?>|\s+|&nbsp;/g, '');
					if (contentText == '') {
						alert('내용을 입력해주세요!');
						oEditors.getById["reportSubmitContent"].exec("FOCUS");

						return;
					}

					// 빈 첨부파일 칸이 있을 경우 모두 삭제
					$('.reportSubmitFile').each(function(index, element) {
						if ($(element).val() == '') {
							// 삭제버튼의 부모(위 코드의 div 태그)를 HTML상에서 완전히 지워버림
							$(element).parent().remove();
						}
					});

					$('#reportSubmitForm').submit();
				});

				// NAVER SmartEditor2 적용 코드
				let oEditors = [];
				nhn.husky.EZCreator.createInIFrame({
					oAppRef: oEditors,
					elPlaceHolder: "reportSubmitContent",	// 적용할 textarea 태그의 id 속성
					sSkinURI: "${pageContext.request.contextPath}/se2/SmartEditor2Skin.html",	
					htParams : {
						bUseToolbar : true,						// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : true,				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true,					// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
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
				<h1>과제제출 수정</h1>
			</div>
		</div>
		<div class="container">
			<div>
				<form id="reportSubmitForm" action="${pageContext.request.contextPath}/student/modifyReportSubmit" method="post" enctype="multipart/form-data">
					<input type="hidden" name="reportNo" value="${reportSubmit.reportNo}">
					<input type="hidden" name="reportSubmitNo" value="${reportSubmit.reportSubmitNo}">
					<table class="table">
						<tr>
							<th>제목</th>
							<td>
								<input class="form-control" type="text" name="reportSubmitTitle" value="${reportSubmit.reportSubmitTitle}">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<textarea id="reportSubmitContent" name="reportSubmitContent" style="width: 100%">${reportSubmit.reportSubmitContent}</textarea>
							</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
							<div>
								<c:forEach var="rsf" items="${reportSubmit.reportSubmitFileList}">
									<c:if test="${rsf.reportSubmitFileSize > 0}">
										<div>
											<a class="reportSubmitFileOriginal" href="${pageContext.request.contextPath}/student/downloadReportSubmitFile?reportSubmitFileUUID=${rsf.reportSubmitFileUUID}">
												${rsf.reportSubmitFileOriginal}
											</a>
												${rsf.reportSubmitFileSize},
												${rsf.reportSubmitFileType},
												${rsf.reportSubmitFileCount}회 다운로드,
												${rsf.reportSubmitFileCreateDate}
											<a class="removeReportSubmitFile btn btn-outline-danger" href="${pageContext.request.contextPath}/student/removeReportSubmitFile?reportSubmitFileUUID=${rsf.reportSubmitFileUUID}">삭제</a>
										</div>
									</c:if>
								</c:forEach>
							</div>	
							</td>
						</tr>
					</table>
					<div class="form-group">
						<button class="btn btn-outline-primary" id="addFile" type="button">파일 추가</button>
					</div>
					<div id="reportSubmitFileFrame"></div>
					<div class="form-group d-flex justify-content-end">
						<button class="btn btn-outline-success" id="submitBtn" type="button">수정</button>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>