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
	
	/*@Test
	public void testCreate() throws Exception{
		BoardVO vo = new BoardVO();
		vo.setTitle("�깉濡쒖슫 湲�");
		vo.setUname("user00");
		vo.setContent("�깉濡쒖슫 湲� content");
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
		vo.setTitle("�닔�젙�맂 湲�");
		vo.setBno(1);
		vo.setContent("�닔�젙�맂 湲� content");
		dao.update(vo);
	}*/

}
