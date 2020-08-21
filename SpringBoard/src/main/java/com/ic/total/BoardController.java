package com.ic.total;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.MyConstant;
import dao.BoardDao;
import util.Paging;
import vo.BoardVo;
import vo.MemberVo;

@Controller
public class BoardController {

	BoardDao board_dao;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	public BoardController(BoardDao board_dao) {
		super();
		this.board_dao = board_dao;
	}

	/* 게시글 목록 ---------------------- */
	/*
	board/list.do
	board/list.do?page=1
	
	page → int page가 아닌 Integer page로 받는다.
	page값이 없을 경우 null로 나오기 때문에 
	객체형인 Integer로 받는다.
	*/
	@RequestMapping("/board/list.do")
	public String list(Integer page, Model model) {
		
		//현재 보여질 페이지
		int nowPage = 1;
		
		//페이지 값이 들어왔을 경우
		if (page != null) {
			nowPage = page;
		}
		
		//페이지에 따른 게시물 위치
		int start = (nowPage - 1) * MyConstant.Board.BLOCK_LIST + 1;
		int end = start + MyConstant.Board.BLOCK_LIST - 1;
		
		//map로 포장한다.
		Map map = new HashMap();
		
		map.put("start", start);
		map.put("end", end);

		/*
		List<BoardVo> totalList = board_dao.selectList();
		int total = totalList.size();
		*/
		
		//전체 게시물 갯수
		int rowTotal = board_dao.selectRowTotal();
		
		//페이징 메뉴 생성
		String pageMenu = Paging.getPaging("list.do", nowPage, rowTotal, MyConstant.Board.BLOCK_LIST, MyConstant.Board.BLOCK_PAGE);
		
		List<BoardVo> list = board_dao.selectList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		/* 게시글 상세에서 만든 session show의 내용을 삭제한다.
		 * 
		 *  다시 상세글을 클릭했을 때, 조회수를 증가하기 위해서 삭제한다.*/
		session.removeAttribute("show");
		
		return "/board/board_list";
	}
	
	/* 게시글 상세 ---------------------- */
	@RequestMapping("/board/view.do")
	public String view(int idx, Model model) {
		
		model.addAttribute("vo", board_dao.selectOne(idx));
		
		/* session에 show라는 상태가 없을 경우 조회수가 증가한다. 
		 * 
		 * 이름은 내가 원하는 걸로정 할 수 있다.
		 * 
		 * 아래의 내용을 정의하는 이유는 새로고침했을 경우 조회수가 증가하는 것을
		 * 막기 위해서 이다.*/
		if (session.getAttribute("show") == null) {
			//조회수 증가
			int res = board_dao.hitUpdate(idx);
			
			//현재 session이 생성되었다.
			session.setAttribute("show", true);
		}
		
		return "/board/board_view";
	}
	
	/* 게시글 삭제 ---------------------- */
	@RequestMapping("/board/delete.do")
	public String view(int idx, int page, Model model) {
		
		//삭제는 use_state = 'n'으로 수정하기
		int res = board_dao.delete(idx);
		
		model.addAttribute("page", page);
		
		return "redirect:/board/list.do";
	}
	
	/* 글쓰기 폼 이동 --------------------- */
	@RequestMapping("/board/insert_form.do")
	public String insert_form() {
		return "/board/board_insert_form";
	}
	
	/* 게시글 등록 ---------------------- */
	@RequestMapping("/board/insert.do")
	public String insert(BoardVo vo) {
		
		String ip = request.getRemoteAddr();
		
		//로그인 유저의 m_idx구하기
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		int m_idx = user.getM_idx();

		vo.setIp(ip);
		vo.setM_idx(m_idx);
		
		int res = board_dao.insert(vo);
		
		return "redirect:/board/list.do";
	}
	
	/* 게시글 댓글폼 이동 ------------------- */
	@RequestMapping("/board/reply_form.do")
	/* 해당 페이지에서 /board/reply_form.do?idx=4 
	 * 전달해줬을 경우 포워딩 해주면 /board/reply.do 에서도
	 * 사용이 가능하다. 
	 * 
	 * 파라미터 값으로 전달되어 댓글 폼에서
	 * <input name="idx" value="${param.idx}" type="hidden" > 
	 * 넣어준다. */
	public String reply_form() {
		return "/board/board_reply_form";
	}
	
	/* 게시글 댓글 ---------------------- */
	@RequestMapping("/board/reply.do")
	public String reply(BoardVo vo, int page, Model model) {
		
		String ip = request.getRemoteAddr();
		
		//로그인 유저의 m_idx구하기
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		//기준글 정보 얻어오기
		BoardVo board = board_dao.selectOne(vo.getIdx());
		
		//기준글 아래의 게시물의 step을 1씩 증가
		int res = board_dao.update_step(board);
		
		int m_idx = user.getM_idx();

		vo.setIp(ip);
		vo.setM_idx(m_idx);
		vo.setRef(board.getRef()); //기준글
		vo.setStep(board.getStep()+1);
		vo.setDepth(board.getDepth()+1);
		
		res = board_dao.insert_reply(vo);
		
		model.addAttribute("page", page);
		
		return "redirect:/board/list.do";
	}
	
	/* 게시글 수정폼 이동 ------------------- */
	@RequestMapping("/board/modify_form.do")
	public String modify_form(int idx, Model model) {

		BoardVo board = board_dao.selectOne(idx);
		
		model.addAttribute("vo", board);
		
		return "/board/board_modify_form";
	}
	
	/* 게시글 수정 ------------------------- */
	@RequestMapping("/board/modify.do")
	public String modify_form(BoardVo vo, int page, Model model) {

		vo.setIp(request.getRemoteAddr());
		
		//System.out.printf("idx %d name %s content %s", vo.getIdx(), vo.getName(), vo.getContent());
		
		int res = board_dao.update(vo);
		
		model.addAttribute("page", page);
		
		//System.out.println(res);
		
		return "redirect:/board/list.do";
	}
	
}
