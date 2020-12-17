package gd.fintech.lms.manager.mapper;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.lms.manager.vo.Syllabus;

// 강의계획서를 작성 및 수정, 강의계획서 승인과 출력을 하는 Mapper

@Mapper
public interface SyllabusMapper {
	// 강의계획서의 정보를 출력
	// 매개변수: 강의계획서 고유번호
	// 리턴값: 강의계획서 고유번호에 해당하는 강의계획서 정보
	Syllabus selectSyllabusDetail(int syllabusNo);
	
	// 강사가 강의계획서를 작성
	// 매개변수: 강의계획서 정보
	// 리턴값: 변경된 행의 갯수
	int insertSyllabus(Syllabus syllabus);
	
	// 강사가 강의계획서 내용을 수정(수정 시 서명을 전부 취소)
	// 매개변수: 강의계획서 정보
	// 리턴값: 변경된 행의 갯수
	int updateSyllabus(Syllabus syllabus);
	
	// 강사가 강의계획서에 서명
	// 매개변수: 서명할 강의계획서 고유번호
	// 리턴값: 변경된 행의 갯수
	int updateSyllabusTeacherSign(int syllabusNo);
	
	// 운영자가 강의계획서에 서명
	// 매개변수: 서명할 강의계획서 고유번호
	// 리턴값: 변경된 행의 갯수
	int updateSyllabusManagerSign(int syllabusNo);
}
