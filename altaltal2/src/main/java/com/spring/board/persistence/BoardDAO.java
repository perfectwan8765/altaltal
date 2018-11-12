package com.spring.board.persistence;

import java.util.List;

import com.spring.board.domain.BoardVO;
import com.spring.board.domain.Criteria;

public interface BoardDAO {
	
	public List<BoardVO> list(Criteria cri) throws Exception;
	public void create(BoardVO vo) throws Exception;
	public BoardVO view(int bno) throws Exception;
	public void countUp(int bno) throws Exception;
	public void update(BoardVO vo) throws Exception;
	public void delete(int bno) throws Exception;
	public int getTotal(Criteria cri) throws Exception;
	
}
