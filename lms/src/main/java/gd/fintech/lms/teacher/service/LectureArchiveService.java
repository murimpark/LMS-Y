package gd.fintech.lms.teacher.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gd.fintech.lms.dto.LectureArchiveForm;
import gd.fintech.lms.manager.mapper.LectureManagerMapper;
import gd.fintech.lms.manager.vo.Lecture;
import gd.fintech.lms.teacher.mapper.LectureArchiveFileMapper;
import gd.fintech.lms.teacher.mapper.LectureArchiveMapper;
import gd.fintech.lms.teacher.mapper.TeacherMapper;
import gd.fintech.lms.teacher.vo.LectureArchive;
import gd.fintech.lms.teacher.vo.LectureArchiveFile;

//강좌별 자료실 서비스

@Service
@Transactional
public class LectureArchiveService {
	// Looger
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	// LectureArchiveMapper, FileMapper 객체 주입
	@Autowired private LectureArchiveMapper lectureArchiveMapper;
	@Autowired private LectureArchiveFileMapper lectureArchiveFileMapper;
	
	//검증 및 변수를 가져오는데 사용하는 메퍼 객제 주입
	@Autowired private TeacherMapper teacherMapper;
	@Autowired private LectureManagerMapper lectureManagerMapper;

	// 강좌 자료실 목록 및 페이징 메서드
	// 매개변수:강좌 고유번호
	// 리턴값:강좌 고유번호를 조회하여 자료실 목록을 반환
	public Map<String,Object> getLectureArchiveListByPage(int lectureNo, int currentPage) {
		// 현재 페이지 표시할 데이터 수
		int rowPerPage = 10;
		// 시작 페이지
		int beginRow = (currentPage - 1) * rowPerPage;
		// 전체 페이지 개수
		int lectureAchiveCount = lectureArchiveMapper.selectLectureArchiveCount(lectureNo);
		// 마지막 페이지
		int lastPage = lectureAchiveCount / rowPerPage;
		// 10 미만의 개수의 데이터가 있는 페이지 표시
		if (lectureAchiveCount % rowPerPage != 0) {
			lastPage += 1;
		}
		// 전체 페이지가 0개이면 현재 페이지도 0으로 표시
		if (lastPage == 0) {
			currentPage = 0;
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", beginRow);
		paramMap.put("lectureNo", lectureNo);
		
		List<LectureArchive> lectureArchiveList = lectureArchiveMapper.selectLectureArchiveListByPage(paramMap);
		logger.trace(lectureArchiveList+"<---- lectureArchiveList");
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("lastPage", lastPage);
		map.put("lectureArchiveList", lectureArchiveList);
		
		return map;
	}
	
	//강좌별 자료실 상세보기 메서드
	//매개변수:강좌 자료실 고유번호
	//리턴값:목록출력
	public LectureArchive getLectureArchiveOne(int lectureArchiveNo) {
		LectureArchive lectureArchive = lectureArchiveMapper.selectLectureArchiveOne(lectureArchiveNo);
		return lectureArchive;
	}
	
	//DTO를 받아와 해당 강좌별 자료실의 입력
	/*public boolean createLectureArchive(LectureArchiveForm lectureArchiveForm,HttpSession session) {
		//현재 로그인한 사용자의 정보
		String sessionAccountId = (String)session.getAttribute("accountId");
		
		logger.debug("로그인 사용자 ID:"+sessionAccountId);
		
		//검증 및 검사를 위한 객체
		List<Lecture> lectureList = lectureManagerMapper.selectTeacherLectureDetail(sessionAccountId);
		LectureArchive lectureArchive = lectureArchiveMapper.selectLectureArchiveOne(lectureArchiveForm.getLectureArchiveNo());
		
		logger.debug("강사가 관리하는 강좌: "+lectureList);
		logger.debug("강사가 작성한 자료실: "+lectureArchive);
		
		//해당 강사가 관리하는 강좌가 아닐 경우 실행 중단후 false 반환
		boolean isCorrectTeacher = false;
		for(Lecture l : lectureList) {
			if(l.getLectureNo() == lectureArchive.getLectureNo()) {
				isCorrectTeacher = true;
			}
		}
		
		logger.debug("강사의 해당 강좌 관리 가능 여부 : "+isCorrectTeacher);
		if(!isCorrectTeacher) {
			return false;
		}
		
		//accountId를 이용해 sessionTeacherName을 가져옴
		String sessionTeacherName = teacherMapper.selectTeacherOne(sessionAccountId).getTeacherName();
		
		logger.debug("강사의 이름:"+sessionTeacherName);
		
		//DTO를 VO로 변환 후 댓글 추가
		//<script> 방지코드 추가
		lectureArchive.setLectureNo(lectureArchiveForm.getLectureNo());
		lectureArchive.setAccountId(lectureArchiveForm.getAccountId());
		lectureArchive.setLectureArchiveWriter(sessionTeacherName);
		lectureArchive.setLectureArchiveContent(lectureArchiveForm.getLectureArchiveContent());
		lectureArchive.setLectureArchiveTitle(lectureArchiveForm.getLectureArchiveTitle().replaceAll("(?i)<script", "&lt;script"));
		lectureArchive.setLectureArchiveContent(lectureArchiveForm.getLectureArchiveContent().replaceAll("(?i)<script", "&lt;script"));
		
		//Logger 디버깅
		logger.trace(lectureArchive+"<--- lectureArchive");
		
		lectureArchiveMapper.insertLectureArchive(lectureArchive);
		
		List<LectureArchiveFile> lectureArchvieFileList = null;
		
		//첨부파일이 존재하는 경우
		if(lectureArchiveForm.getLectureArchiveFileList() !=null) {
			lectureArchvieFileList = new ArrayList<LectureArchiveFile>();
			
		}
	}*/
}
