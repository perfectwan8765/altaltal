package com.spring.board.service;

import java.util.List;

import com.spring.board.domain.BoardVO;
import com.spring.board.domain.Criteria;

public interface BoardService {
	
	public List<BoardVO> listBoard(Criteria cri) throws Exception;
	public int getTotalBoard(Criteria cri) throws Exception;
	public void createBoard(BoardVO vo) throws Exception;
	public BoardVO viewBoard(int bno, int check) throws Exception;
	public void updateBoard(BoardVO vo) throws Exception;
	public void deleteBoard(int bno) throws Exception;

}
