package com.ic.total;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MemberDao;
import vo.MemberVo;

@Controller
public class MemberController {

	MemberDao member_dao;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;

	public MemberController(MemberDao member_dao) {
		super();
		this.member_dao = member_dao;
	}
	
	@RequestMapping(value = "/member/check_id.do", produces = "text/json;charet=utf-8")
	@ResponseBody
	public String check_id(String m_id) {
		//DB조회
		MemberVo vo = member_dao.selectOne(m_id);
		
		//null DB에 등록된 정보가 없을 경우
		boolean result = (vo == null);
		
		//결과값
		String json = String.format("{\"result\": %b}", result);
		
		return json;
	}
	
	@RequestMapping("/member/delete.do")
	public String delete(int m_idx) {
		
		//DAO 전송
		int res = member_dao.delete(m_idx);
		
		return "redirect:/member/list.do";
	}
	
	@RequestMapping("/member/insert.do")
	public String insert(MemberVo vo) {
		String m_ip = request.getRemoteAddr();
		
		vo.setM_ip(m_ip);
		
		//DB전송
		int res = member_dao.insert(vo);
		
		return "redirect:/member/list.do";
	}
	
	@RequestMapping("/member/insert_form.do")
	public String insert_form() {
		return "member/member_insert_form";
	}
	
	@RequestMapping("/member/list.do")
	public String list(Model model) {
		
		List<MemberVo> list = member_dao.seleList();
		
		model.addAttribute("list", list);
		
		return "member/member_list";
	}
	
	@RequestMapping("/member/login_form.do")
	public String login_form() {
		return "member/member_login_form";
	}
	
	@RequestMapping("/member/logout.do")
	public String logout() {
		
		//세션 삭제
		session.removeAttribute("user");
		
		return "redirect:../board/list.do";
	}
	
	@RequestMapping("/member/modify.do")
	public String modify(MemberVo vo) {
		String m_ip = request.getRemoteAddr();
		
		vo.setM_ip(m_ip);
		
		//DB전송
		int res = member_dao.update(vo);
		
		return "redirect:/member/list.do";
	}
	
	@RequestMapping("/member/modify_form.do")
	public String modify_form(int m_idx, Model model) {
		
		//Dao 전송
		MemberVo vo = member_dao.selectOne(m_idx);
		
		model.addAttribute("vo", vo);
		
		return "member/member_modify_form";
	}
	
	@RequestMapping(value = "/member/login.do", produces = "text/json;charet=utf-8")
	@ResponseBody
	public String modify_form(String m_id, String m_pwd) {
		
		MemberVo user = member_dao.selectOne(m_id);
		
		String result = "";
		
		if (user == null) {
			result = "fail_id";
		}else {
			//비밀번호 체크
			if (user.getM_pwd().equals(m_pwd) == false) {
				
				result = "fail_pwd";
			}else {
				result = "success";
				
				session.setAttribute("user", user);
			}
			
		}//if ~ else 
		
		String json = String.format("{\"result\": \"%s\"}", result);
		
		return json;
	}
	
}
