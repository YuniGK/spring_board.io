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

	/* �Խñ� ��� ---------------------- */
	/*
	board/list.do
	board/list.do?page=1
	
	page �� int page�� �ƴ� Integer page�� �޴´�.
	page���� ���� ��� null�� ������ ������ 
	��ü���� Integer�� �޴´�.
	*/
	@RequestMapping("/board/list.do")
	public String list(Integer page, Model model) {
		
		//���� ������ ������
		int nowPage = 1;
		
		//������ ���� ������ ���
		if (page != null) {
			nowPage = page;
		}
		
		//�������� ���� �Խù� ��ġ
		int start = (nowPage - 1) * MyConstant.Board.BLOCK_LIST + 1;
		int end = start + MyConstant.Board.BLOCK_LIST - 1;
		
		//map�� �����Ѵ�.
		Map map = new HashMap();
		
		map.put("start", start);
		map.put("end", end);

		/*
		List<BoardVo> totalList = board_dao.selectList();
		int total = totalList.size();
		*/
		
		//��ü �Խù� ����
		int rowTotal = board_dao.selectRowTotal();
		
		//����¡ �޴� ����
		String pageMenu = Paging.getPaging("list.do", nowPage, rowTotal, MyConstant.Board.BLOCK_LIST, MyConstant.Board.BLOCK_PAGE);
		
		List<BoardVo> list = board_dao.selectList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		/* �Խñ� �󼼿��� ���� session show�� ������ �����Ѵ�.
		 * 
		 *  �ٽ� �󼼱��� Ŭ������ ��, ��ȸ���� �����ϱ� ���ؼ� �����Ѵ�.*/
		session.removeAttribute("show");
		
		return "/board/board_list";
	}
	
	/* �Խñ� �� ---------------------- */
	@RequestMapping("/board/view.do")
	public String view(int idx, Model model) {
		
		model.addAttribute("vo", board_dao.selectOne(idx));
		
		/* session�� show��� ���°� ���� ��� ��ȸ���� �����Ѵ�. 
		 * 
		 * �̸��� ���� ���ϴ� �ɷ��� �� �� �ִ�.
		 * 
		 * �Ʒ��� ������ �����ϴ� ������ ���ΰ�ħ���� ��� ��ȸ���� �����ϴ� ����
		 * ���� ���ؼ� �̴�.*/
		if (session.getAttribute("show") == null) {
			//��ȸ�� ����
			int res = board_dao.hitUpdate(idx);
			
			//���� session�� �����Ǿ���.
			session.setAttribute("show", true);
		}
		
		return "/board/board_view";
	}
	
	/* �Խñ� ���� ---------------------- */
	@RequestMapping("/board/delete.do")
	public String view(int idx, int page, Model model) {
		
		//������ use_state = 'n'���� �����ϱ�
		int res = board_dao.delete(idx);
		
		model.addAttribute("page", page);
		
		return "redirect:/board/list.do";
	}
	
	/* �۾��� �� �̵� --------------------- */
	@RequestMapping("/board/insert_form.do")
	public String insert_form() {
		return "/board/board_insert_form";
	}
	
	/* �Խñ� ��� ---------------------- */
	@RequestMapping("/board/insert.do")
	public String insert(BoardVo vo) {
		
		String ip = request.getRemoteAddr();
		
		//�α��� ������ m_idx���ϱ�
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		int m_idx = user.getM_idx();

		vo.setIp(ip);
		vo.setM_idx(m_idx);
		
		int res = board_dao.insert(vo);
		
		return "redirect:/board/list.do";
	}
	
	/* �Խñ� ����� �̵� ------------------- */
	@RequestMapping("/board/reply_form.do")
	/* �ش� ���������� /board/reply_form.do?idx=4 
	 * ���������� ��� ������ ���ָ� /board/reply.do ������
	 * ����� �����ϴ�. 
	 * 
	 * �Ķ���� ������ ���޵Ǿ� ��� ������
	 * <input name="idx" value="${param.idx}" type="hidden" > 
	 * �־��ش�. */
	public String reply_form() {
		return "/board/board_reply_form";
	}
	
	/* �Խñ� ��� ---------------------- */
	@RequestMapping("/board/reply.do")
	public String reply(BoardVo vo, int page, Model model) {
		
		String ip = request.getRemoteAddr();
		
		//�α��� ������ m_idx���ϱ�
		MemberVo user = (MemberVo) session.getAttribute("user");
		
		//���ر� ���� ������
		BoardVo board = board_dao.selectOne(vo.getIdx());
		
		//���ر� �Ʒ��� �Խù��� step�� 1�� ����
		int res = board_dao.update_step(board);
		
		int m_idx = user.getM_idx();

		vo.setIp(ip);
		vo.setM_idx(m_idx);
		vo.setRef(board.getRef()); //���ر�
		vo.setStep(board.getStep()+1);
		vo.setDepth(board.getDepth()+1);
		
		res = board_dao.insert_reply(vo);
		
		model.addAttribute("page", page);
		
		return "redirect:/board/list.do";
	}
	
	/* �Խñ� ������ �̵� ------------------- */
	@RequestMapping("/board/modify_form.do")
	public String modify_form(int idx, Model model) {

		BoardVo board = board_dao.selectOne(idx);
		
		model.addAttribute("vo", board);
		
		return "/board/board_modify_form";
	}
	
	/* �Խñ� ���� ------------------------- */
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
