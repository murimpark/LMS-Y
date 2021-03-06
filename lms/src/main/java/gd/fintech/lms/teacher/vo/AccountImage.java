package gd.fintech.lms.teacher.vo;

import lombok.Data;

//운영자,강사,학생 이미지파일 VO

@Data
public class AccountImage {	
	//계정 아이디
	private String accountId;
	
	//이미지 파일 UUID
	private String imageFileUUID;
	
	//이미지 원본 이름
	private String imageFileOriginal;
	
	//이미지 파일크기
	private long imageFileSize;
	
	//이미지 타입
	private String imageFileType;
	
	//이미지 생성일시
	private String imageFileCreateDate;
}
