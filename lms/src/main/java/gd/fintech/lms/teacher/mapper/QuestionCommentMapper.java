package gd.fintech.lms.teacher.mapper;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.lms.teacher.vo.QuestionComment;

// 질문게시판 질문글의 댓글들을 관리하는 테이블의 매퍼

@Mapper
public interface QuestionCommentMapper {
	// 단일 댓글에 대한 상세 정보 출력
	// 매개변수: 댓글 고유번호
	// 리턴값: 댓글 첨부파일을 포함한 댓글의 상세정보
	QuestionComment selectQuestionCommentDetail(int questionCommentNo);
	
	// 질문에 대한 댓글 생성
	// 매개변수: 댓글 객체, setter를 사용해 추가할 정보 questionNo, accountId, questionCommentWriter, questionCommentContent를 넣을 것
	// 리턴값: 변경된 행 갯수
	int insertQuestionComment(QuestionComment questionComment);
	
	// 질문에 대한 댓글 수정
	// 매개변수: 댓글 객체, setter를 사용해 변경할 행 고유번호 questionCommentNo, 변경할 정보 questionCommentContent를 넣을 것
	// 리턴값: 변경된 행 갯수
	int updateQuestionComment(QuestionComment questionComment);
	
	// DELETE 매핑은 질문게시판 댓글 삭제(질문의 답변 삭제)가 안되는 것이 맞다고 생각하여 등록하지 않음. 필요시 추가예정
}
