package com.spring.admin;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.board.domain.BoardVO;
import com.spring.board.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class BoardDAOTest {
	
	@Inject
	private BoardDAO dao;
	
	private static Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);
	
	@Test
	public void testCreate() throws Exception{
		BoardVO vo = new BoardVO();
		vo.setTitle("새로운 글");
		vo.setUname("user00");
		vo.setContent("새로운 글 content");
		dao.create(vo);
		logger.info("insert success");
	}
	
	@Test
	public void testRead() throws Exception{
		logger.info(dao.view(1).toString());
	}
	
	@Test
	public void testUpdate() throws Exception{
		BoardVO vo = new BoardVO();
		vo.setTitle("수정된 글");
		vo.setBno(1);
		vo.setContent("수정된 글 content");
		dao.update(vo);
	}

}
