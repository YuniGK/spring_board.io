package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.MemberVo;

public class MemberDao {
	SqlSession sqlSession;
	
	public MemberDao(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}

	public List<MemberVo> seleList() {

		List<MemberVo> list = sqlSession.selectList("member.member_list");

		return list;
	}
	
	public int insert(MemberVo vo) {
		//실패시 0	
		return sqlSession.insert("member.member_insert", vo);
	}
	
	public int update(MemberVo vo) {
		//실패시 0	
		return sqlSession.update("member.member_update", vo);
	}
	
	public MemberVo selectOne(int m_idx) {

		MemberVo vo = sqlSession.selectOne("member.member_list_one", m_idx);
		
		return vo;
	}
	
	//중복아이디 체크
	public MemberVo selectOne(String m_id) {

		MemberVo vo = sqlSession.selectOne("member.member_id_one", m_id);
		
		return vo;
	}
	
	public int delete(int m_idx) {
		//실패시 0	
		return sqlSession.delete("member.member_delete", m_idx);
	}
	
}
