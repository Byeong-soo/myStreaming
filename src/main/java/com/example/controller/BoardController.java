package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.domain.AttachVO;
import com.example.domain.BoardVO;
import com.example.domain.Criteria;
import com.example.domain.MemberVO;
import com.example.domain.PageDTO;
import com.example.service.AttachService;
import com.example.service.BoardService;

import net.coobird.thumbnailator.Thumbnailator;

//?는 향후 jsp명을 보고 고칠예정입니다!!!
//업로드 파일경로는 어떻게 해야될지...

@Controller // 프론트 컨트롤러 -> 호출할 대상 servlet -context에 있음
@RequestMapping("/board/*") // 공통경로
public class BoardController {

	@Autowired
	private BoardService boardService;

	@Autowired
	private AttachService attachService;

	@GetMapping("/list ?") // 글목록 요청
	public String list(Criteria cri, Model model) {// Model(jsp데이터 전달까지 같이)에 주입한것을 스프링이안전하게 보냄

		System.out.println("list()호출됨");// 향후 게시판에 해당하는 jsp파일이름으로 고쳐야함

		// board테이블에서 (검색어가 있으면)검색,페이징 적용한글 리스트 가져오기
		List<BoardVO> boardList = boardService.getBoards(cri);

		// ================================ 게시글 추가 부분=========================================
		// 게시글 없으면 100개 넣기 (테스트 진행을 위해서 임시로 추가)
		if (boardList.isEmpty()) { // 게시글 하나도 없을 경우
			for (int i = 1; i <= 100; i++) {
				// insert할 새 글번호 가져오기
				int num = boardService.getNextNum();

				BoardVO boardVO = new BoardVO();
				boardVO.setNum(i);
				boardVO.setMid("테스트");
				boardVO.setSubject(i + "번글");
				boardVO.setContent("테스트 내용 " + i);
				boardVO.setRegDate(new Date(System.currentTimeMillis()));
				boardVO.setReRef(num);
				boardVO.setReLev(0);
				boardVO.setReSeq(0);
				boardService.addBoard(boardVO);
			}

		} // if

		boardList = boardService.getBoards(cri); // 게시글 추가될시 새로 불러옴
		// =====================================게시글 추가부분 끝================================================

		// 검색유형, 검색어가 있으면 적용하여 글개수 가져오기
		int totalCount = boardService.getCountBySearch(cri);

		// 페이지 블록 정보 객체 준비, 필요한 정보를 생성자로 전달
		PageDTO pageDTO = new PageDTO(cri, totalCount);

		// 뷰에서 사용할 데이터를 Model객체에 저장 - > 스프링(dispatcher servlet)이 requestScope로 옮겨줌
		model.addAttribute("boardList", boardList);// el언어로 requestScope.boardList로 접근
		model.addAttribute("pageMarker", pageDTO);

		return "board/??";

	}// getBoards

	// 상세보기
	@GetMapping("/content")
	public String content (int num, @ModelAttribute("pageNum") String pageNum, Model model,HttpServletRequest request,BoardVO boardVO,HttpSession session) {
		
		
		
		if(boardVO.isSecret() == true) {//비밀글일
			if(boardVO.getMid() == "admin" || session.getId() == boardVO.getMid()) {
				// 조회수 1 증가시키기
				boardService.updateReadcount(num);

				// join 쿼리문으로 게시판 글과 첨부파일 리스트 정보 가져오기
				boardVO = boardService.getBoard(num);
				System.out.println(boardVO);

				model.addAttribute("board", boardVO);

				model.addAttribute("attachList", boardVO.getAttachList());// 첨부파일 리스트
				model.addAttribute("attachCount", boardVO.getAttachList().size());
				model.addAttribute("pageNum", pageNum); // 컨트롤러에서 쓰이지 않음, 받은 값을 jsp로 전달

				return "board/content";
			}else if(boardVO.getMid() != session.getId() || session.getId() == null) {
				
				return "board/list";
			}
			
		
		}
		
		
		
			// 조회수 1 증가시키기
			boardService.updateReadcount(num);

			// join 쿼리문으로 게시판 글과 첨부파일 리스트 정보 가져오기
			boardVO = boardService.getBoard(num);
			System.out.println(boardVO);

			model.addAttribute("board", boardVO);

			model.addAttribute("attachList", boardVO.getAttachList());// 첨부파일 리스트
			model.addAttribute("attachCount", boardVO.getAttachList().size());
			model.addAttribute("pageNum", pageNum); // 컨트롤러에서 쓰이지 않음, 받은 값을 jsp로 전달

			return "board/content";
		
				
		
		
	} // content

//=======================글쓰기 메소드 관련=================================================	

	// 새로운 주글(qna)쓰기 폼 화면 요청
	@GetMapping("/write?")
	public String write(@ModelAttribute("pageNum") String pageNum) {

		System.out.println("write()form호출");

		return "board/?";
	} // write

	// "년/월/일" 형식의 폴더명을 리턴하는 메소드
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String str = sdf.format(new Date());
		return str;
	}

	// 이미지 파일여부 리턴하는 메소드
	private boolean checkImageType(File file) throws IOException {
		boolean isImage = false;

		// contentType 증명
		String contentType = Files.probeContentType(file.toPath()); // 이미지일 경우, "image/jpg" "image/gif" "image/png"
		System.out.println("contentType : " + contentType);

		isImage = contentType.startsWith("image");// 특정 문자열로 시작할경우
		return isImage;
	} // checkImageType

	// 첨부파일 업로드(썸네일 이미지 생성함) -> attachList리턴
	private List<AttachVO> uploadFilesAndGetAttachList(List<MultipartFile> files, int bno)
			throws IllegalStateException, IOException {

		List<AttachVO> attachList = new ArrayList<AttachVO>();// 첨부파일을 attachLsit에 담음

		// 업로드 처리로 생성 해야할 정보가 없을 경우 메소드 종료
		if (files == null || files.size() == 0) {
			System.out.println("첨부파일 없음!");
			return attachList;
		}

		System.out.println("첨부파일 갯수 :" + files.size());

		String uploadFolder = "C:/myStream/upload";// 업로드 기준경로

		// 파일업로드 생성경로
		File uploadPath = new File(uploadFolder, getFolder());// C://(폴더명)/upload/2021/10/29
		System.out.println("uploadPath : " + uploadPath.getPath());

		// 업로드 파일 존재 확인(파일 시스템상에 존재 해야 파일을 확인 할수 있음)
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();// 복수형으로 할시 하위폴더까지 생성

		}

		// 첨부파일 확인
		for (MultipartFile multipartFile : files) {

			if (multipartFile.isEmpty() == true) {
				continue;
			}

			// 원본 파일 이름
			String originalFilename = multipartFile.getOriginalFilename();
			System.out.println("originalFilename : " + originalFilename);

			// 파일중복 피하기(실제 파일명)
			UUID uuid = UUID.randomUUID();// 정보식별을 위해 쓰임
			String uploadFileName = uuid.toString() + "_" + originalFilename;

			File file = new File(uploadPath, uploadFileName);// 생성할 파일경로 파일명 정보

			// 파일1개 업로드(파일 생성)완료
			multipartFile.transferTo(file);

			// 현재 업로드한 파일이 이미지 파일이면 썸네일 이미지를 추가로 생성하기
			boolean isImage = checkImageType(file);// 이미지 파일 여부 true/false로 리턴

			if (isImage == true) {
				// 생성할 파일
				File outFile = new File(uploadPath, "th_" + uploadFileName);// th_가 붙을경우 썸네일 이미지
				Thumbnailator.createThumbnail(file, outFile, 100, 100);// 썸네일 이미지파일 생성하기

			} // if

			// insert할 주글 AttachVO 객체 준비 및 데이터 저장
			AttachVO attachVO = new AttachVO();
			attachVO.setUuid(uuid.toString());
			attachVO.setUploadpath(getFolder());
			attachVO.setFilename(originalFilename);// 원본파일명
			attachVO.setFiletype((isImage == true) ? "I" : "O");
			attachVO.setBno(bno);// 글번호

			attachList.add(attachVO);// 리스트에 추가

		} // for

		return attachList;

	}// uploadFilesAndGetAttachList

	// 첨부파일 업로드와 함께 주글쓰기 처리
	@PostMapping("/write")
	public String write(List<MultipartFile> files, BoardVO boardVO, HttpServletRequest request, RedirectAttributes rttr)
			throws IllegalStateException, IOException { // 배열로 받아도 된다.(MultipartFile[] multipartFile)

		// 스프링(mvc 모듈) 웹에서는 클라이언트(사용자)로부터 넘어오는 file 타입 input 요소의 갯수만큼
		// MultipartFile 타입의 객체로 전달받게 됨.

 // insert할 새 글번호 가져오기
		int num = boardService.getNextNum();

		// 첨부파일 업로드(썸네일 이미지 생성) 후 attachList 리턴하는 메소드
		List<AttachVO> attachList = uploadFilesAndGetAttachList(files, num);

		// insert 할 BoardVO 객체의 데이터 설정 -- 스프링은 vo의 setter이름과 name 속성의
		// 이름이 같으면 자동으로 준비되므로 그 외에 준비되지 않은 것들만 적어주기 --> write에 아이디, 비밀번호, content는 있기
		// 때문에 제외!
		boardVO.setNum(num); // 글 번호, 위에 int num으로 설정해놨기 때문에 그냥 그거 받으면 된다!
		boardVO.setReadcount(0);// 새글은 0
		boardVO.setSecret(boardVO.isSecret());//booelan은 get이 아니라 is로 받을
		boardVO.setRegDate(new Date());
		boardVO.setReRef(num); // 주글일 경우 글그룹 번호는 글번호와 동일함
		boardVO.setReLev(0); // 주글일 경우 들여쓰기 레벨은 0
		boardVO.setReSeq(0); // 주글일 경우 글그룹 안에서의 순번은 0

		boardVO.setAttachList(attachList);// attachList 세팅

		// 주글 한개(boardVO)와 첨부파일 여러개(attachList)를 한개의 트랜잭션으로 insert 처리함
		boardService.addBoardAndAttaches(boardVO);

		// 리다이렉트 시 쿼리스트링으로 서버에 전달할 데이터를
		// RedirectAttributes 타입의 객체에 저장하면,
		// 스프링이 자동으로 쿼리스트링으로 변환해서 처리해줌 -> return "redirect:/board/content?num=" +
		// boardVO.getNum() + "&pageNum=1"; 이렇게 적을 거를 return "redirect:/board/content";
		// 이렇게만 적으면 된다.
		rttr.addAttribute("num", boardVO.getNum());// key = num, value= baordVO.getNum()
		rttr.addAttribute("pageNum", 1);// 새글 쓰는것이기 때문에 1

		return "redirect:/board/content";
	} // write

//=====================================글쓰기 관련 메소드 끝======================================	

//  첨부파일 삭제 하는 메소드
	private void deleteAttachFiles(List<AttachVO> attachList) {

		// 삭제할 파일이 없을 경우 종료
		if (attachList == null || attachList.size() == 0) {
			System.out.println("삭제할 첨부파일 정보 없음");
			return;
		}

		String basePath = "C:/";// ?? 업로드 경로 정해질 경우 수정 사항!

		for (AttachVO attachVO : attachList) {

			String uploadpath = basePath + "/" + attachVO.getUploadpath();// ex C:/??/upload/2021/10/29
			String filename = attachVO.getUuid() + "_" + attachVO.getFilename();// ex) 파일명.jpg(etc..)

			File file = new File(uploadpath, filename);// ex) C:/??/upload/2021/10/29/uuid_파일명(etc..)

			// 첨부파일이 이미지일 경우 썸네일 이미지 파일도 삭제
			if (attachVO.getFiletype().equals("I")) {
				// 썸네일 이미지 파일 여부 확인후 삭제
				File thumbnailFile = new File(uploadpath, "th_" + filename);
				if (thumbnailFile.exists() == true) {
					thumbnailFile.delete();
				} // if
			} // if
		} // for
	}// deleteAttachFiles

	@GetMapping("/remove") // 글삭제
	public String remove(int num, @ModelAttribute("pageNum") String pageNum) {// requestParameter 시도

		// 첨부파일 삭제
		List<AttachVO> attachList = attachService.getAttachesByBno(num);
		deleteAttachFiles(attachList);// 집에 가서 살펴보기

		System.out.println("첨부파일 삭제 완료");

		// attach와 board테이블 내용 삭제 - 한개의 트랜잭션 단위로 처리
		boardService.deleteBoardAndAttaches(num);

		// 글목록으로 이동
		return "redirect:/board/list?pageNum =" + pageNum;

	}// remove

	@GetMapping("/modify ?")
	public String modifyFrom(int num, String pageNum, Model model) {

		// 글과 첨부파일 가져오기
		BoardVO boardVO = boardService.getBoardAndAttaches(num);// JOIN으로 모두 가져옴

		// view에 보내지는것
		model.addAttribute("board", boardVO);// 게시글
		model.addAttribute("attachList", boardVO.getAttachList());// 첨부파일

		return "board/modify?";

	}// modifyForm()

	@PostMapping("/modify") // files name 속성보고 고치기!(input type name?)
	// String delfile은 modify.jsp보고 고치기
	public void modify(List<MultipartFile> files, BoardVO boardVO,
			@RequestParam(required = false, defaultValue = "1") String pageNum,
			@RequestParam(name = "delfile", required = false) List<String> deletUuidList,
			HttpServletRequest request)throws IllegalStateException, IOException {// 파일 각각이 MultipartFile로 들어옴

		// 1.신규 첨부파일 업로드하기. 신규파일 정보 리스트 가져오기.
		List<AttachVO> newAttachList = uploadFilesAndGetAttachList(files, boardVO.getNum());// 내부적으로 파일 업로드 할때 예외발생 ->
																							// 프론트컨트롤러로 넘기기
		System.out.println("POST modify - 신규 첨부파일 업로드 완료~");

		// 2.삭제 할 첨부파일 삭제하기(썸네일 이미지도 삭제)
		List<AttachVO>deleteAttachList = null;
		
		if(deletUuidList != null && deletUuidList.size() > 0) {
			deleteAttachList = attachService.getAttachesByUuids(deletUuidList);
			
			deleteAttachFiles(deleteAttachList);//첨부파일(썸네일도 삭제 )삭제하기
		}//if
		
		System.out.println("POST modify  기존 첨부 파일 삭제");
		
		//3.테이블 작업
		//boardVO 게시글 수정
		//attach 테이블에 신규 파일 정보(newAttachList)를 insert, 삭제할 정보 delete
		
		
		//글번호에 해당하는 게시글 수정, 첨부파일 정보 수정(insert,delete ) - 트랜잭션처리
		boardService.updateBoardAndInsertAttachesAndDeleteAttaches(boardVO, newAttachList, deletUuidList);
		
		System.out.println("post modify -테이블 수정 완료");
		//update

	}// modify
	
	
	
	@GetMapping("/reply")
	public String replyForm(@ModelAttribute("reRef") String reRef, 
			@ModelAttribute("reLev") String reLev, 
			@ModelAttribute("reSeq") String reSeq, 
			@ModelAttribute("pageNum") String pageNum, 
			Model model) {
		
		System.out.println("replayForm()호출!");
	
//		model.addAttribute("reRef", reRef);
//		model.addAttribute("reLev", reLev);
//		model.addAttribute("reSeq", reSeq);
//		model.addAttribute("pageNum", pageNum);
		
		return "board/replyWrite??";
	} // replyForm
	
	
	// 답글쓰기
	@PostMapping("/reply")
	public String reply(List<MultipartFile> files, BoardVO boardVO, String pageNum,
			HttpServletRequest request, RedirectAttributes rttr) 
			throws IllegalStateException, IOException {
		
		// insert할 새 글번호 가져오기
		int num = boardService.getNextNum();
		
		// 첨부파일 업로드(썸네일 생성) 후 attachList 리턴
		List<AttachVO> attachList = uploadFilesAndGetAttachList(files, num);
		
		// ========= insert 할 답글 BoardVO 객체 데이터 설정 =========
		
		boardVO.setNum(num);
		boardVO.setReadcount(0);
		boardVO.isSecret();
		boardVO.setRegDate(new Date());
		boardVO.setAttachList(attachList); // 첨부파일 정보 리스트 저장
		
		// ※ 현재 boardVO에 들어있는 reRef, reLev, reSeq는 바로 insert될 답글 정보가 아님에 주의!
		//   답글을 남길 대상글에 대한 reRef, reLev, reSeq 정보임에 주의!
		
		
		//boardService.addReplyAndAttaches(boardVO, attachList);
		boardService.addReplyAndAttaches(boardVO);
		//=========================================================
		
		// 리다이렉트 시 서버에 전달할 데이터를 rttr에 저장하면 스프링이 자동으로 쿼리스트링으로 변환하여 처리해준다.
		rttr.addAttribute("num", boardVO.getNum());
		rttr.addAttribute("pageNum", pageNum);
		
		return "redirect:/board/content";
	} // reply
	
	
	
	

}