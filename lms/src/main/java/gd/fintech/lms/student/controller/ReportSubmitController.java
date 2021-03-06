package gd.fintech.lms.student.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gd.fintech.lms.dto.ReportSubmitForm;
import gd.fintech.lms.student.service.ReportSubmitService;
import gd.fintech.lms.student.vo.ReportSubmit;
import gd.fintech.lms.teacher.service.ReportService;
import gd.fintech.lms.teacher.vo.Report;

@Controller
public class ReportSubmitController {
	// debug를 하기위한 logger 
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	// 한 과제에 관한 과제 제출 서비스
	@Autowired private ReportSubmitService reportSubmitService;
	// 과제 서비스
	@Autowired private ReportService reportService;
	
	// 과제 리스트 출력
	// 매개변수 :
	// Model
	// RequestParam : accountId(계정 ID)
	// 리턴값 : 계정과 연관 있는 과제리스트
	@GetMapping("/student/reportList")
	public String reportList(Model model,
			@RequestParam(value="lectureNo") int lectureNo,
			@RequestParam(value="currentPage", defaultValue = "1") int currentPage,
			HttpSession session) {
		Map<String, Object> map = reportSubmitService.getReportListByPage(lectureNo, currentPage, session);
		logger.debug(map.toString());
		
		model.addAttribute("reportList", map.get("reportList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lectureNo", lectureNo);
		model.addAttribute("lastPage", map.get("lastPage"));
		
		model.addAttribute("navPerPage", map.get("navPerPage"));
		model.addAttribute("navBeginPage", map.get("navBeginPage"));
		model.addAttribute("navLastPage", map.get("navLastPage"));
		return "/student/reportList";
	}
	
	// 과제 제출 정보 출력
	// 매개변수 :
	// Model
	// RequestParam : 
	// reportNo(과제 번호)
	// accountId(계정 ID)
	// 리턴값 : 과제의 제출 상세정보 출력
	@GetMapping("/student/reportSubmitDetail")
	public String reportSubmitDetail(Model model,
			@RequestParam(value="reportNo") int reportNo,
			HttpSession session) {
		Map<String, Object> reportMap = reportSubmitService.getReportDetail(reportNo, session);
		
		model.addAttribute("reportAndReportSubmit", reportMap.get("report"));
		model.addAttribute("isEditable", reportMap.get("isEditable"));
		return "/student/reportSubmitDetail";
	}
	
	// 과제 제출 입력 페이지
	// 매개변수 : 
	// Model
	// RequestParam : reportNo(과제 번호)
	// 리턴값 : 과제 제출 입력페이지
	@GetMapping("/student/createReportSubmit")
	public String createReportSubmit(Model model, 
			@RequestParam(value="reportNo") int reportNo) {
		model.addAttribute("reportNo", reportNo);
		return "/student/createReportSubmit";
	}
	
	// 과제 제출 입력 액션
	// 매개변수 : 과제 제출 폼
	// 리턴값 : 과제 제출 상세보기 페이지 
	@PostMapping("/student/createReportSubmit")
	public String createReportSubmit(ReportSubmitForm reportSubmitForm,
			HttpSession session) {
		logger.debug(reportSubmitForm.toString());
		reportSubmitService.createReportSubmit(reportSubmitForm, session);
		return "redirect:/student/reportSubmitDetail?reportNo="
		+reportSubmitForm.getReportNo()
		+"&accountId="+reportSubmitForm.getAccountId();
	}
	
	// 과제 제출 수정 페이지
	// 매개변수 :
	// Model
	// RequestParam : 
	// reportNo(과제 번호)
	// accountId(계정 ID)
	// 리턴값 : 과제 제출 수정페이지
	@GetMapping("/student/modifyReportSubmit")
	public String modifyReportSubmit(Model model,
			@RequestParam(value="reportSubmitNo") int reportSubmitNo) {
		ReportSubmit reportSubmit = reportSubmitService.getReportSubmitDetail(reportSubmitNo);
		model.addAttribute("reportSubmit", reportSubmit);
		return "/student/modifyReportSubmit";
	}
	
	// 과제 제출 수정 액션
	// 매개변수 : 과제 제출 폼 
	// 리턴값 : 과제 제출 상세보기 페이지 
	@PostMapping("/student/modifyReportSubmit")
	public String modifyReportSubmit(ReportSubmitForm reportSubmitForm) {
		logger.debug(reportSubmitForm.toString());
		reportSubmitService.modifyReportSubmit(reportSubmitForm);
		return "redirect:/student/reportSubmitDetail?reportNo="
		+reportSubmitForm.getReportNo()
		+"&accountId="+reportSubmitForm.getAccountId();
	}
	
	// 과제 제출 첨부파일 다운로드
	// 매개변수 :
	// RequestParam : reportSubmitFileUUID(과제 제출파일 UUID)
	// // HttpServletRequest, HttpServletResponse
	// 리턴값 : 파일 다운로드
	@GetMapping("/student/downloadReportSubmitFile")
	public void downloadReportSubmitFile(@RequestParam(value="reportSubmitFileUUID") String reportSubmitFileUUID,
			HttpServletRequest request, HttpServletResponse response) {
		reportSubmitService.downloadReportSubmitFile(reportSubmitFileUUID, request, response);
	}
}
