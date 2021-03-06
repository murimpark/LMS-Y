package gd.fintech.lms.account.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gd.fintech.lms.account.mapper.AddressMapper;
import gd.fintech.lms.account.mapper.SignUpMapper;
import gd.fintech.lms.account.vo.Account;
import gd.fintech.lms.admin.mapper.ManagerQueueMapper;
import gd.fintech.lms.admin.vo.ManagerQueue;
import gd.fintech.lms.dto.SignUpForm;
import gd.fintech.lms.manager.mapper.StudentQueueMapper;
import gd.fintech.lms.manager.mapper.TeacherQueueMapper;
import gd.fintech.lms.manager.vo.StudentQueue;
import gd.fintech.lms.manager.vo.TeacherQueue;

// 회원가입 기능을 위한 서비스 클래스

@Service
@Transactional
public class SignUpService {
	// SignUpMapper 객체 주입
	@Autowired private SignUpMapper signUpMapper;
	// AddressMapper 객체 주입
	@Autowired private AddressMapper addressMapper;
	// StudentQueueMapper 객체 주입
	@Autowired private StudentQueueMapper studentQueueMapper;
	// TeacherQueueMapper 객체 주입
	@Autowired private TeacherQueueMapper teacherQueueMapper;
	// ManagerQueueMapper 객체 주입
	@Autowired private ManagerQueueMapper managerQueueMapper;
	
	// 회원가입시 Account 테이블에 회원 정보를 입력하는 메소드(vo로 전환)
	// 매걔변수: 회원가입폼에서 입력된 회원정보(id,pw,level)
	// 리턴값: 회원정보 입력
	public int createSignUpAccount(SignUpForm signUpForm) {
		Account account = new Account();
		account.setAccountId(signUpForm.getAccountId());
		account.setAccountPw(signUpForm.getAccountPw());
		account.setAccountEmail(signUpForm.getAccountEmail());
		account.setAccountLevel(signUpForm.getAccountLevel());
		return signUpMapper.insertAccount(account);
	}
	
	// 회원가입시 Student_Queue 테이블에 회원 정보를 입력하는 메소드(vo로 전환)
	// 매개변수: 회원가입폼에서 입력된 회원정보(id,email,name,phone,gender,birth,mainAddress,sub)
	// 리턴값: 학생 승인대기에 입력하는 매퍼
	public int createSignUpStudentQueue(SignUpForm signUpForm) {
		StudentQueue studentQueue = new StudentQueue();
		studentQueue.setAccountId(signUpForm.getAccountId());
		studentQueue.setStudentEmail(signUpForm.getAccountEmail());
		studentQueue.setStudentName(signUpForm.getAccountName());
		studentQueue.setStudentPhone(signUpForm.getAccountPhone());
		studentQueue.setStudentGender(signUpForm.getAccountGender());
		studentQueue.setStudentBirth(signUpForm.getAccountBirth());
		studentQueue.setStudentAddressMain(signUpForm.getAccountAddressMain());
		studentQueue.setStudentAddressSub(signUpForm.getAccountAddressSub());
		return studentQueueMapper.insertStudentQueue(studentQueue);
	}
	
	// 회원가입시 Teacher_Queue 테이블에 회원 정보를 입력하는 메소드(vo로 전환)
	// 매개변수: 회원가입폼에서 입력된 회원정보(id,email,name,phone,gender,birth,mainAddress,sub)
	// 리턴값: 강사 승인대기에 입력하는 매퍼
	public int createSignUpTeacherQueue(SignUpForm signUpForm) {
		TeacherQueue teacherQueue = new TeacherQueue();
		teacherQueue.setAccountId(signUpForm.getAccountId());
		teacherQueue.setTeacherEmail(signUpForm.getAccountEmail());
		teacherQueue.setTeacherName(signUpForm.getAccountName());
		teacherQueue.setTeacherPhone(signUpForm.getAccountPhone());
		teacherQueue.setTeacherGender(signUpForm.getAccountGender());
		teacherQueue.setTeacherBirth(signUpForm.getAccountBirth());
		teacherQueue.setTeacherAddressMain(signUpForm.getAccountAddressMain());
		teacherQueue.setTeacherAddressSub(signUpForm.getAccountAddressSub());
		return teacherQueueMapper.insertTeacherQueue(teacherQueue);
	}
	
	// 회원가입시 manager_Queue 테이블에 회원 정보를 입력하는 메소드(vo로 전환)
	// 매개변수: 회원가입폼에서 입력된 회원정보(id,email,name,phone,gender,birth,mainAddress,sub)
	// 리턴값: 운영자 승인대기에 입력하는 매퍼
	public int createSignUpManagerQueue(SignUpForm signUpForm) {
		ManagerQueue managerQueue = new ManagerQueue();
		managerQueue.setAccountId(signUpForm.getAccountId());
		managerQueue.setManagerEmail(signUpForm.getAccountEmail());
		managerQueue.setManagerName(signUpForm.getAccountName());
		managerQueue.setManagerPhone(signUpForm.getAccountPhone());
		managerQueue.setManagerGender(signUpForm.getAccountGender());
		managerQueue.setManagerBirth(signUpForm.getAccountBirth());
		managerQueue.setManagerAddressMain(signUpForm.getAccountAddressMain());
		managerQueue.setManagerAddressSub(signUpForm.getAccountAddressSub());
		return managerQueueMapper.insertManagerQueue(managerQueue);
	}
	
	// 계정ID로 중복 체크를 위한 메소드
	// 매개변수: 계정ID
	// 리턴값: 조회되는 계정 ID
	public String getAccountId(String accountId) {
		return signUpMapper.selectAccountId(accountId);
	}
	
	// 계정 이메일로 중복 체크를 위한 메소드
	// 매개변수: 계정 이메일
	// 리턴값: 조회되는 계정 이메일
	public String getAccountEmail(String accountEmail) {
		return signUpMapper.selectAccountEmail(accountEmail);
	}
	
	// 우편주소로 주소 리스트를 조회 메소드
	// 매개변수: 우편주소
	// 리턴값: 우편주소에 따른 주소 목록
	public List<String> getAddressListByZipCode(String zipCode) {
		List<String> list = addressMapper.selectAddressByZipCode(zipCode);
		return list;
	}
}
