package com.spring.board.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.board.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO{
	
	@Inject
	private SqlSession session;
	
	@Override
	public List<ReplyVO> replylist(Map paramMap) throws Exception{
		return session.selectList("ReplyMapper.replylist", paramMap);
	}
	
	@Override
	public int totalReply(int bno) throws Exception{
		return session.selectOne("ReplyMapper.totalreply", bno);
	}
	
	@Override
	public void create(ReplyVO vo) throws Exception{
		session.insert("ReplyMapper.create", vo);
	}
	
	@Override
	public void modify(ReplyVO vo) throws Exception{
		session.update("ReplyMapper.modify", vo);
	}
	
	@Override
	public void delete(int rno) throws Exception{
		session.delete("ReplyMapper.delete", rno);
	}
}
