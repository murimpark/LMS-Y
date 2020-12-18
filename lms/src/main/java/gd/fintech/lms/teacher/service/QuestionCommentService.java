package gd.fintech.lms.teacher.service;

import java.io.File;
import java.util.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import gd.fintech.lms.FilePath;
import gd.fintech.lms.dto.QuestionCommentForm;
import gd.fintech.lms.teacher.mapper.QuestionCommentFileMapper;
import gd.fintech.lms.teacher.mapper.QuestionCommentMapper;
import gd.fintech.lms.teacher.vo.QuestionComment;
import gd.fintech.lms.teacher.vo.QuestionCommentFile;

// 질문게시판 댓글을 관리하는 서비스

@Service
@Transactional
public class QuestionCommentService {
	// 디버깅 메세지 출력을 위한 로거
	Logger logger = LoggerFactory.getLogger(QuestionCommentService.class);
	
	// 질문게시판 댓글 관리를 위한 매퍼
	@Autowired private QuestionCommentMapper questionCommentMapper;
	
	// 질문게시판 댓글 파일 관리를 위한 매퍼
	@Autowired private QuestionCommentFileMapper questionCommentFileMapper;
	
	// DTO를 받아와 해당 질문게시판 게시글의 댓글을 생성
	// 매개변수: 질문게시판 댓글 커맨드 객체 (MultipartFile 포함 가능)
	public void createQuestionComment(QuestionCommentForm questionCommentForm) {
		// DTO를 VO로 변환 후 댓글 추가
		QuestionComment questionComment = new QuestionComment();
		questionComment.setQuestionNo(questionCommentForm.getQuestionNo());
		questionComment.setAccountId(questionCommentForm.getAccountId());
		questionComment.setQuestionCommentContent(questionCommentForm.getQuestionCommentContent());
		questionCommentMapper.insertQuestionComment(questionComment);
		
		// 파일이 있을 경우 for문을 돌면서 MultipartFile을 VO로 변환 후 댓글 첨부파일 추가
		for (MultipartFile mf : questionCommentForm.getQuestionCommentFileList()) {
			String filenameUUID = UUID.randomUUID().toString().replaceAll("-", "");
			
			try {
				// 물리적 파일을 생성(하드디스크)
				String fileName = FilePath.getFilePath()+filenameUUID;
				mf.transferTo(new File(fileName));
				
				logger.debug("파일 생성됨: "+fileName);
			} catch (Exception e) { // 해당 파일 생성 실패 시
				// 원래 예외 메세지를 출력함
				e.printStackTrace();
				
				// Transactional 기능을 수행하는 Service 컴포넌트에게 예외 발생을 알려 작업 내역을 롤백하도록 유도함
				throw new RuntimeException(e);
			}
			
			QuestionCommentFile questionCommentFile = new QuestionCommentFile();
			questionCommentFile.setQuestionCommentFileUUID(filenameUUID);
			questionCommentFile.setQuestionCommentFileOriginal(mf.getOriginalFilename());
			questionCommentFile.setQuestionCommentNo(questionComment.getQuestionCommentNo()); // selectKey 이용, 위에 추가한 댓글의 고유번호를 가져와서 등록
			questionCommentFile.setQuestionCommentFileSize(mf.getSize());
			questionCommentFile.setQuestionCommentFileType(mf.getContentType());
			questionCommentFileMapper.insertQuestionCommentFile(questionCommentFile);
		}
	}
	
	// DTO를 받아와 해당 질문게시판 게시글의 댓글을 수정
	// 매개변수: 질문게시판 댓글 커맨드 객체 (MultipartFile 포함 가능)
	public void modifyQuestionComment(QuestionCommentForm questionCommentForm) {
		// DTO를 VO로 변환 후 댓글 수정
		QuestionComment questionComment = new QuestionComment();
		questionComment.setQuestionCommentNo(questionCommentForm.getQuestionCommentNo());
		questionComment.setQuestionCommentContent(questionCommentForm.getQuestionCommentContent());
		questionCommentMapper.updateQuestionComment(questionComment);
		
		// 파일이 있을 경우 for문을 돌면서 MultipartFile을 VO로 변환 후 댓글 첨부파일 추가
		for (MultipartFile mf : questionCommentForm.getQuestionCommentFileList()) {
			String filenameUUID = UUID.randomUUID().toString().replaceAll("-", "");
			
			try {
				// 물리적 파일을 생성(하드디스크)
				String fileName = FilePath.getFilePath()+filenameUUID;
				mf.transferTo(new File(fileName));
				
				logger.debug("파일 생성됨: "+fileName);
			} catch (Exception e) { // 해당 파일 생성 실패 시
				// 원래 예외 메세지를 출력함
				e.printStackTrace();
				
				// Transactional 기능을 수행하는 Service 컴포넌트에게 예외 발생을 알려 작업 내역을 롤백하도록 유도함
				throw new RuntimeException(e);
			}
			
			QuestionCommentFile questionCommentFile = new QuestionCommentFile();
			questionCommentFile.setQuestionCommentFileUUID(filenameUUID);
			questionCommentFile.setQuestionCommentFileOriginal(mf.getOriginalFilename());
			questionCommentFile.setQuestionCommentNo(questionComment.getQuestionCommentNo()); // selectKey 이용, 위에 추가한 댓글의 고유번호를 가져와서 등록
			questionCommentFile.setQuestionCommentFileSize(mf.getSize());
			questionCommentFile.setQuestionCommentFileType(mf.getContentType());
			questionCommentFileMapper.insertQuestionCommentFile(questionCommentFile);
		}
	}
	
	// UUID에 해당하는 첨부파일을 삭제
	// 매개변수: 삭제할 첨부파일의 UUID
	public void removeQuestionCommentFile(int questionCommentFileUUID) {
		// 물리적 파일(하드디스크에 존재하는 파일) 제거
		String fileName = FilePath.getFilePath()+questionCommentFileUUID;
		File file = new File(fileName);
		if (file.exists()) {
			file.delete();
			
			logger.debug("파일 제거됨: "+fileName);
		} else {
			logger.debug("파일이 존재하지 않음 (제거 실패): "+fileName);
		}
		
		// DB의 파일 정보 제거
		questionCommentFileMapper.deleteQuestionCommentFile(questionCommentFileUUID);
	}
}
