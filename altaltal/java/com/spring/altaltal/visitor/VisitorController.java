package com.spring.altaltal.visitor;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class VisitorController {
	
	@Autowired
	private VisitorDAO visitorDAO;
	
	@RequestMapping(value="/visitorCount.vi", method= RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	@ResponseBody
	public String getPeopleJSONGET() {
		HashMap<String, Object> map = visitorDAO.getMainInfo();
		String str = "";
		ObjectMapper mapper = new ObjectMapper(); //JSON형식으로 데이터를 반환하기 위해 사용(pom.xml 편집)
		try {
			str = mapper.writeValueAsString(map);
		} catch (Exception e) {
			System.out.println("first() mapper : " + e.getMessage());
		}
		return str;
	}

}
