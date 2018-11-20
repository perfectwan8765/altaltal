package com.spring.board.service;

import java.util.List;

import com.spring.board.domain.Criteria;
import com.spring.board.domain.ReplyVO;

public interface ReplyService {
	
	public List<ReplyVO> getReplyList(int bno, Criteria cri) throws Exception;
	public int getTotalReply(int bno) throws Exception;
	public void insertReply(ReplyVO vo) throws Exception;
	public void updateReply(ReplyVO vo) throws Exception;
	public void deleteReply(int rno) throws Exception;
}
