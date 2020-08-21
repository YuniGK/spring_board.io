package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.BoardVo;

public class BoardDao {

	SqlSession sqlSession;

	public BoardDao(SqlSession sqlSession) {
		super();
		this.sqlSession = sqlSession;
	}
	
	public List<BoardVo> selectList() {
		return sqlSession.selectList("board.board_list");
	}
	
	public List<BoardVo> selectList(Map map) {
		return sqlSession.selectList("board.board_condition_list",map);
	}
	
	public BoardVo selectOne(int idx) {
		return sqlSession.selectOne("board.board_one", idx);
	}
	
	public int delete(int idx) {
		return sqlSession.update("board.board_delete", idx);
	}
	
	public int insert(BoardVo vo) {
		return sqlSession.insert("board.board_insert", vo);
	}
	
	public int hitUpdate(int idx) {
		return sqlSession.update("board.board_update_readhit", idx);
	}
	
	public int insert_reply(BoardVo vo) {
		return sqlSession.insert("board.board_reply_insert", vo);
	}

	public int update_step(BoardVo vo) {
		return sqlSession.update("board.board_update_step", vo);
	}

	public int update(BoardVo vo) {
		return sqlSession.update("board.board_update", vo);
	}

	public int selectRowTotal() {
		return sqlSession.selectOne("board.board_row_total");
	}
	
}
