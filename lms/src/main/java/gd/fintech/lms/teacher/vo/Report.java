package gd.fintech.lms.teacher.vo;

import lombok.Data;

// 과제 정보 관련 vo
@Data
public class Report {
	private int reportNo;				// 과제 고유번호 (AUTO_INCREMENT)
	private int lectureNo;				// 과제를 등록한 강사가 속한 강좌의 고유번호
	private String reportTitle;			// 과제 제목
	private String reportContent;		// 과제의 설명 및 내용
	private String reportCreateDate;	// 이 행을 생성한 날짜
	private String reportUpdateDate;	// 이 행을 수정한 날짜
	private String reportStartDate;		// 과제 시작(예정)일
	private String reportEndDate;		// 과제 마감일
}
