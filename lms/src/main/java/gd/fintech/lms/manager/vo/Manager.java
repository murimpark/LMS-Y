package gd.fintech.lms.manager.vo;

import java.util.List;

import gd.fintech.lms.account.vo.Career;
import gd.fintech.lms.account.vo.Education;
import gd.fintech.lms.account.vo.License;
import lombok.Data;

// 운영자 vo : 운영자 정보 관련 vo

@Data
public class Manager {
	// 계정 id
	private String accountId;
	
	// 운영자 E-mail
	private String managerEmail;
	
	// 운영자 이름
	private String managerName;
	
	// 운영자 전화번호
	private String managerPhone;
	
	// 운영자 성별 
	private String managerGender;
	
	// 운영자 생일
	private String managerBirth;
	
	// 운영자 직책
	private String managerPosition;
	
	// 운영자 주소
	private String managerAddressMain;
	
	// 운영자 상세 주소
	private String managerAddressSub;
	
	// 운영자 프로필 이미지
	private String managerImage;
	
	// 운영자 승인 날짜
	private String managerAccessDate;
	
	// 운영자 개인정보 수정 날짜
	private String managerUpdateDate;
	
	//Multipart를 위한 프로퍼티 추가
	private List<AccountImage> imageFileList;
	
	// 경력vo
	private List<Career> careerList;
	
	// 학력vo
	private List<Education> educationList;
	
	// 자격증vo
	private List<License> licenseList;
	
	
}
