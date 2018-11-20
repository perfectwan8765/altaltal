package com.spring.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.spring.board.domain.Criteria;
import com.spring.board.domain.ReplyVO;
import com.spring.board.persistence.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Inject
	private ReplyDAO dao;

	@Override
	public List<ReplyVO> getReplyList(int bno, Criteria cri) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bno", bno);
		paramMap.put("cri", cri);
		return dao.replylist(paramMap);
	}

	@Override
	public int getTotalReply(int bno) throws Exception {
		return dao.totalReply(bno);
	}

	@Override
	public void insertReply(ReplyVO vo) throws Exception {
		dao.create(vo);
	}
	
	@Override
	public void updateReply(ReplyVO vo) throws Exception{
		dao.modify(vo);
	}
	
	@Override
	public void deleteReply(int rno) throws Exception{
		dao.delete(rno);
	}

}
