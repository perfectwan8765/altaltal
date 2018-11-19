package com.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.board.domain.Criteria;
import com.spring.board.domain.PageMaker;
import com.spring.board.domain.ReplyVO;
import com.spring.board.service.ReplyService;

@RestController
@RequestMapping("/replies")
public class ReplyController {
	
	@Inject
	private ReplyService service;
	
	private static final Logger log = LoggerFactory.getLogger(ReplyController.class);
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO vo){
		
		ResponseEntity<String> entity = null;
		
		try {
			service.insertReply(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	@RequestMapping(value="/{bno}/{page}", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listPage(@PathVariable("bno") int bno, @PathVariable("page") int page){
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		try {
			Criteria cri = new Criteria();
			cri.setPageNum(5);
			cri.setPage(page);
			log.info(cri.toString());
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			int replyCount = service.getTotalReply(bno);
			pageMaker.setTotalCnt(replyCount);
			
			Map<String, Object> map = new HashMap<String, Object>();
			List<ReplyVO> list = service.getReplyList(bno, cri);
			
			map.put("list", list);
			map.put("pageMaker", pageMaker);
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
		}
	
		return entity;
	}
	
}
