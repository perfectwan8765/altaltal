package com.spring.board.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.board.domain.BoardVO;
import com.spring.board.domain.Criteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession session;
	
	private static final String NAMESPACE = "BoardMapper";
	
	@Override
	public List<BoardVO> list(Criteria cri) throws Exception {
		return session.selectList(NAMESPACE+".list", cri);
	}
	
	@Override
	public int getTotal(Criteria cri) throws Exception{
		return session.selectOne(NAMESPACE+".getTotal", cri);
	}
	
	@Override
	public void create(BoardVO vo) throws Exception{
		session.insert(NAMESPACE + ".create", vo);
	}

	@Override
	public BoardVO view(int bno) throws Exception {
		return session.selectOne(NAMESPACE+".view", bno);
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		session.update(NAMESPACE+".update", vo);
	}

	@Override
	public void delete(int bno) throws Exception {
		session.delete(NAMESPACE+".delete", bno);
	}
	
	@Override
	public void countUp(int bno) throws Exception{
		session.update(NAMESPACE+".countUp", bno);
	}

}
