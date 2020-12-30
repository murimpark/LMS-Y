package gd.fintech.lms.student.controller;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gd.fintech.lms.student.service.StudentService;
import gd.fintech.lms.student.vo.Student;

@Controller
public class StudentController {
	Logger logger = LoggerFactory.getLogger(StudentController.class);
	@Autowired StudentService studentService;
	
	//학생 자신의 정보 상세보기
	@GetMapping("/student/studentDetail")
	public String getStudentDetail(Model model,HttpServletRequest request) {
		//세션 가져오기
		HttpSession session =((HttpServletRequest)request).getSession();
		//Id를 가져오기
		String accountId =(String)session.getAttribute("accountId");
		Student student= studentService.getStudentDetail(accountId);
		model.addAttribute("accountId", accountId);
		model.addAttribute("student",student);
		return "/student/studentDetail";
	}	
	
	//학생정보 수정 폼
	@GetMapping("student/studentModify")
	public String getStudentModify(Model model,
			@RequestParam(value="accountId")String accountId) {
		Student student = studentService.getStudentDetail(accountId); 
		model.addAttribute("student",student);
		return "/student/studentModify";
	}
	
	//학생정보 수정 액션
	@PostMapping("student/studentModify")
	public String getStudentModify(Student student) {
		studentService.modifyStudent(student);
		return "/student/studentDetail";
	}
}
