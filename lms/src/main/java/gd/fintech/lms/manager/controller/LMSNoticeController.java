package gd.fintech.lms.manager.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gd.fintech.lms.manager.service.LMSNoticeService;
import gd.fintech.lms.manager.vo.LMSNotice;

// lms의 공지사항 관리 컨트롤러

@Controller
public class LMSNoticeController {
	// lms 공지사항 서비스
	@Autowired LMSNoticeService lmsNoticeService;
	
	// lms 공지사항 리스트 출력
	// 매개변수 :
	// Model
	// RequestParam : currentPage(현재 페이지)
	// 리턴값 : 공지사항 리스트
	@GetMapping("/*/lmsNoticeList")
	public String lmsNoticeList(Model model,
			@RequestParam(value="currentPage") int currentPage) {
		Map<String, Object> map = lmsNoticeService.getLMSNoticeListByPage(currentPage);
		
		model.addAttribute("lmsNoticeList", map.get("lmsNoticeList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lastPage", map.get("lastPage"));
		return "lmsNoticeList";
	}
	
	// 공지사항 상세보기 페이지 
	// 매개변수 :
	// Model
	// RequestParam : lmsNoticeNo(공지사항 번호)
	// 리턴값 : 공지사항 번호에 해당되는 공지 상세 정보
	@GetMapping("/*/lmsNoticeDetail")
	public String lmsNoticeDetail (Model model,
			@RequestParam(value="lmsNoticeNo") int lmsNoticeNo) {
		LMSNotice lmsNotice = lmsNoticeService.getLMSNoticeDetail(lmsNoticeNo);
		model.addAttribute("lmsNotice", lmsNotice);
		return "lmsNoticeDetail";
	}
	
	// lms 공지사항 리스트 검색
	// 매개변수 :
	// Model
	// RequestParam : 
	// currentPage(현재 페이지)
	// lmsNoticeSearch(lms공지사항 검색어)
	// 리턴값 : 검색한 공지사항 페이지 출력
	@GetMapping("/*/lmsNoticeList")
	public String lmsNoticeListSearch(Model model,
			@RequestParam(value="currentPage") int currentPage,
			@RequestParam(value="lmsNoticeSearch", required = false) String lmsNoticeSearch) {
		Map<String, Object> map = lmsNoticeService.getLMSNoticeListSearch(currentPage, lmsNoticeSearch);
		
		model.addAttribute("lmsNoticeList", map.get("lmsNoticeList"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("lmsNoticeSearch", lmsNoticeSearch);
		model.addAttribute("lastPage", map.get("lastPage"));
		return "lmsNoticeList";
	}
	
	// lms 공지사항 입력 페이지
	// 리턴값 : 공지사항 입력 액션
	@GetMapping("/manager/createLMSNotice")
	public String createLMSNotice() {
		return "createLMSNotice";
	}
	
	// lms 공지사항 입력 액션
	// 매개변수 : lms 공지사항 정보
	// 리턴값 : 입력한 공지사항 페이지 출력
	@PostMapping("/manager/createLMSNotice")
	public String createLMSNotice(LMSNotice lmsNotice) {
		lmsNoticeService.createLMSNotice(lmsNotice);
		return "redirect:/*/lmsNoticeDetail?lmsNoticeNo="+lmsNotice.getLmsNoticeNo();
	}
	
	// lms 공지사항 수정 페이지
	// 매개변수 : 
	// Model
	// RequestParam : lmsNoticeNo(lms공지사항 번호)
	// 리턴값 : 공지사항 수정 액션
	@GetMapping("/manager/modifyLMSNotice")
	public String modifyLMSNotice(Model model,
			@RequestParam(value="lmsNoticeNo") int lmsNoticeNo) {
		model.addAttribute("lmsNoticeDetail", lmsNoticeService.getLMSNoticeDetail(lmsNoticeNo));
		return "modifyLMSNotice";
	}
	
	// lms 공지사항 수정 액션
	// 매개변수 : lms 공지사항 정보
	// 리턴값 : 수정한 공지사항 페이지 출력
	@PostMapping("/manager/modifyLMSNotice")
	public String modifyLMSNotice(LMSNotice lmsNotice) {
		lmsNoticeService.modifyLMSNotice(lmsNotice);
		return "redirect:/*/lmsNoticeDetail?lmsNoticeNo="+lmsNotice.getLmsNoticeNo();
	}
	
	// lms 공지사항 삭제 
	// 매개변수 : 
	// RequestParam : lmsNoticeNo(lms 공지사항 번호)
	// 리턴값 : 해당 번호의 공지사항 삭제 & 공지사항 리스트 출력  
	@GetMapping("/manager/removeLMSNotice")
	public String removeLMSNotice(@RequestParam(value="lmsNoticeNo") int lmsNoticeNo) {
		lmsNoticeService.removeLMSNotice(lmsNoticeNo);
		return "redirect:/*/lmsNoticeList";
	}
}