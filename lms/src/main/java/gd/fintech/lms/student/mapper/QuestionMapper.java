package gd.fintech.lms.student.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.lms.student.vo.Question;
// 질문게시판 Mapper 
@Mapper
public interface QuestionMapper {
		
	//질문 게시판 질문입력
	//매게변수: 질문게시판 정보를 가지고옴
	//리턴값:질문 리스트 행
	int insertQuestion(Question question);
	
	//학생의(자신의) 질문 수정액션
	//매개변수: 질문 게세판 정보를 가지고옴
	//리턴값: 변경한 질문
	int updateQuestion(Question question);
		
	//학생의 질문 삭제
	//매개변수: 질문게시판 질문 번호
	//리턴값: 삭제된 질문
	int deleteQuestion(int questionNo);

	//해당 강좌 질문 리스트 출력(페이징)
	//매개변수:강좌의 번호
	//리턴값: 해당 강좌의 질문 리스트
	List<Question> selectLectureQuestionListByPage(Map<String,Object>map);
	
	//해당 학생의 질문 상세보기(강사의 댓글과 파일보기)
	//매개변수: 질문 번호
	//리턴값: 질문의 모든 정보
	Question selectQuestionOne(int questionNo);
	
	
	//강좌 질문 갯수
	//매개변수:강좌 번호
	//리턴값:강좌에 대한 질문의 갯수
	int lectureQuestionCount(int lectureNo,String studentLectureSearch);
	
	//질문의 조회수 증가
	//매개변수:질문의 번호
	//리턴값:해당 번호의 질문 조회수 1씩증가
	int increaseQuestionCount(int questionNo); 
	
	
}
