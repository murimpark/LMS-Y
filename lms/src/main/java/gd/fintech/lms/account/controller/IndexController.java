package gd.fintech.lms.account.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// 계층별 권한에 따른 index 페이지로 이동하는 컨트롤러 클래스

@Controller
public class IndexController {
	// 학생 페이지로 이동하는 메소드
	// 리턴값: studentIndex(뷰이름)
	@GetMapping("/student/index")
	public String studentIndex() {
		return "student/studentIndex";
	}
	// 강사 페이지로 이동하는 메소드
	// 리턴값: teacherIndex(뷰이름)
	@GetMapping("/teacher/index")
	public String teacherIndex() {
		return "teacher/teacherIndex";
	}
	// 운영자 페이지로 이동하는 메소드
	// 리턴값: managerIndex(뷰이름)
	@GetMapping("/manager/index")
	public String managerIndex() {
		return "manager/managerIndex";
	}
	// 관리자 페이지로 이동하는 메소드
	// 리턴값: adminIndex(뷰이름)
	@GetMapping("/admin/index")
	public String adminIndex() {
		return "admin/adminIndex";
	}
}
