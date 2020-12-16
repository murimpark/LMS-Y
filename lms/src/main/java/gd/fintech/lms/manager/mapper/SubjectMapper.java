package gd.fintech.lms.manager.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.lms.manager.vo.Subject;

// 과목 정보를 입력, 수정하는 Mapper

@Mapper
public interface SubjectMapper {
	// 과목 정보를 입력
	// 매개변수: 과목 정보
	// 리턴값: 변경된 행의 갯수
	int insertSubject(Subject subject);
	
	// 과목 정보를 수정
	// 매개변수: 과목 정보
	// 리턴값: 변경된 행의 갯수
	int updateSubject(Subject subject);
	
	// 과목 정보를 페이징하여 리스트로 출력
	// 매개변수:
	// 리턴값: 
	List<Subject> selectSubjectList(Map<String, Integer> map);
	
	// 과목 정보 상세보기
	// 매개변수: 과목 고유번호
	// 리턴값: 과목 고유번호에 해당하는 과목의 상세정보
	Subject selectSubjectDetail(int SubjectNo);
}