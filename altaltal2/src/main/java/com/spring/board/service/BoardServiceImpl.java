package com.spring.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.board.domain.BoardVO;
import com.spring.board.domain.Criteria;
import com.spring.board.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO dao;

	@Override
	public List<BoardVO> listBoard(Criteria cri) throws Exception {
		return dao.list(cri);
	}
	
	@Override
	public int getTotalBoard(Criteria cri) throws Exception{
		return dao.getTotal(cri);
	}

	@Override
	public void createBoard(BoardVO vo) throws Exception {
		dao.create(vo);
	}
	
	@Transactional
	@Override
	public BoardVO viewBoard(int bno, int check) throws Exception {
		if(check == 0) {
			dao.countUp(bno);
		}
		return dao.view(bno);
	}

	@Override
	public void updateBoard(BoardVO vo) throws Exception {
		dao.update(vo);
	}

	@Override
	public void deleteBoard(int bno) throws Exception {
		dao.delete(bno);
	}

}
