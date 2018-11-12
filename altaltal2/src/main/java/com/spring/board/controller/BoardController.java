package com.spring.board.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.board.domain.BoardVO;
import com.spring.board.domain.Criteria;
import com.spring.board.domain.PageMaker;
import com.spring.board.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Inject
	private BoardService service;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void list(@ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		
		logger.info(cri.toString());
		
		model.addAttribute("list", service.listBoard(cri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCnt(service.getTotalBoard(cri));
		model.addAttribute("pageMaker", pageMaker);
		
		logger.info(pageMaker.toString());
		
	}
	
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public void write(@ModelAttribute("cri") Criteria cri) {
	}
	
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String write(BoardVO vo, RedirectAttributes rttr) throws Exception{
		service.createBoard(vo);
		logger.info(vo.toString());
		
		rttr.addFlashAttribute("msg", "Register success!");
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public void view(@ModelAttribute("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		model.addAttribute("board", service.viewBoard(bno, 0));
	}
	
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public void update(int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		model.addAttribute("board", service.viewBoard(bno, 1));
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(BoardVO vo, Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info(vo.toString());
		service.updateBoard(vo);
		
		rttr.addAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "Update success!");
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(int bno, Criteria cri, RedirectAttributes rttr) throws Exception{
		service.deleteBoard(bno);
		
		rttr.addAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "Delete success!");
		
		return "redirect:/board/list";
	}
}
