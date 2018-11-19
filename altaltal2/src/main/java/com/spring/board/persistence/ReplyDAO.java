package com.spring.board.persistence;

import java.util.List;
import java.util.Map;

import com.spring.board.domain.Criteria;
import com.spring.board.domain.ReplyVO;

public interface ReplyDAO {
	
	public List<ReplyVO> replylist(Map paramMap) throws Exception;
	public int totalReply(int bno) throws Exception;
	public void create(ReplyVO vo) throws Exception;
}
