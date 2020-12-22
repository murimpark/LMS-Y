package gd.fintech.lms.teacher.service;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gd.fintech.lms.student.vo.ReportSubmit;
import gd.fintech.lms.teacher.mapper.ReportMapper;
import gd.fintech.lms.teacher.vo.Report;

// 과제 출제 및 과제 평가를 관리하는 서비스

@Service
@Transactional
public class ReportService {
	// 디버깅 메세지 출력을 위한 로거
	Logger logger = LoggerFactory.getLogger(ReportService.class);
	
	// 과제 출제 및 과제 평가 관리를 위한 매퍼
	@Autowired private ReportMapper reportMapper;
	
	// 해당 강좌에 등록된 과제 리스트를 출력 (currentPage 페이지의 내용 10개만 보여줌)
	// 매개변수:
	// #1: 표시할 페이지 번호
	// #2: 현재 로그인한 사용자의 정보가 담긴 세션 객체
	// 리턴값: 등록된 과제 리스트
	public List<Map<String, Object>> getReportList(int currentPage, HttpSession session) {
		// 현재 로그인한 사용자의 정보
		String sessionAccountId = (String)session.getAttribute("accountId");
		
		// 리턴값으로 보낼 리스트 생성
		List<Map<String, Object>> returnList = new ArrayList<>();
		
		// rowPerPage 및 beginRow 설정
		int rowPerPage = 10;
		int beginRow = (currentPage-1)*rowPerPage;

		// 테스트용 코드
		logger.debug("beginRow = "+beginRow);
		logger.debug("rowPerPage = "+rowPerPage);
		
		// ReportList를 가져오기 위한 파라미터 설정
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("accountId", sessionAccountId);
		paramMap.put("beginRow", beginRow);
		paramMap.put("rowPerPage", rowPerPage);
		
		// ReportList를 가져오고, Report별로 ReportSubmit 갯수를 첨부해서 Map의 List를 리턴함
		List<Report> list = reportMapper.selectReportList(paramMap);
		for (Report report : list) {
			Map<String, Object> map = new HashMap<>();
			map.put("report", report);
			map.put("reportSubmitCount", reportMapper.selectReportSubmitCount(report.getReportNo()));
			
			returnList.add(map);
		}
		
		return returnList;
	}
	
	// 해당 과제에 대한 상세 정보 출력 (제출된 과제 포함)
	// 매개변수: 과제 고유번호
	// 리턴값: 제출된 과제를 포함한 과제 상세정보
	public Report getReportDetail(int reportNo) {
		return reportMapper.selectReportDetail(reportNo);
	}
	
	// 과제 생성
	// 매개변수: 과제 객체, setter를 사용해 추가할 정보 lectureNo, reportTitle, reportContent, reportStartDate, reportEndDate를 넣을 것
	public void createReport(Report report) {
		reportMapper.insertReport(report);
	}
	
	// 과제 수정
	// 매개변수: 과제 객체, setter를 사용해 변경할 행 고유번호 reportNo, 변경할 정보 reportTitle, reportContent, reportStartDate, reportEndDate를 넣을 것
	public void modifyReport(Report report) {
		reportMapper.updateReport(report);
	}
	
	// 학생이 제출한 과제 평가
	// 매개변수, 과제제출 객체, setter를 사용해 변경할 행 고유번호 reportSubmitNo, 변경할 정보 reportSubmitScore, reportSubmitFeedback을 넣을 것
	public void evaluateReportSubmit(ReportSubmit reportSubmit) {
		reportMapper.updateReportSubmitEvaluation(reportSubmit);
	}
}
