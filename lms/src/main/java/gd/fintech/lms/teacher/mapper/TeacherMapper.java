package gd.fintech.lms.teacher.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import gd.fintech.lms.teacher.vo.Teacher;

//강사 Mapper

@Mapper
public interface TeacherMapper {
	
	//강사 상세보기
	//매개변수:회원가입 당시 입력한 데이터
	//리턴값:강사ID 여부를 조회하여 반환
	Teacher selectTeacherOne(String accountId);
	
	//강사 정보 수정
	//매개변수:강사의 자신의 전체 정보를 가져옴
	//리턴값:변경된 행 갯수
	int updateTeacherInfo(Teacher teacher);
	
}
