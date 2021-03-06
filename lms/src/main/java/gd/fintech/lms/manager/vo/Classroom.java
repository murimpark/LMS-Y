package gd.fintech.lms.manager.vo;

import java.util.List;

import lombok.Data;

// 강의실 vo : 운영자가 관리할 강의실  관련 vo

@Data
public class Classroom {
	// 강의실 고유번호 
	private int classroomNo;
	
	// 강의실 번호
	private int classroomNumber;
	
	// 강의실 규격
	private int classroomSize;
	
	// 강의실 수용 인원
	private int classroomTotal;
	
	// 강의실 정보 리스트
	private List<Classroom>classroomInfoList;
}
