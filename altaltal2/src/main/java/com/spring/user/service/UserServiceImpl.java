package com.spring.user.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.user.domain.UserDTO;
import com.spring.user.domain.UserVO;
import com.spring.user.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDAO dao;
	
	@Autowired
	private JavaMailSender mailSender;	
	
	
	@Transactional
	@Override
	public int findPass(String email) throws Exception {
		if(dao.checkEmail(email) == 1) {
			UserVO vo = new UserVO();
			vo.setEmail(email);
			vo.setUpw(getRamdomPassword());
			dao.changePW(vo);
		
			String setfrom = "altaltal337@gmail.com";         
		    String tomail  = email;     // 받는 사람 이메일
		    String title   =  "[Project Altaltal] Altaltal 홈페이지의 새로운 비밀번호를 보냅니다";     // 제목
		    String content=  "[Project Altaltal]입니다. 새로운 비밀번호를 보냅니다. 확인하시고 이 비밀번호로 로그인 해주세요. \n "
		    						+ "귀하의 새로운 비밀번호는 : [ " + vo.getUpw() + " ] 입니다. \n"
		    						+ "로그인 후 바로 비밀번호를 바꿔주세요.\n "
		    						+ "저희 사이트를 이용해 주셔서 감사합니다. 앞으로도 많은 이용 부탁드립니다. \n"; // 내용
		   try {
		      MimeMessage msg = mailSender.createMimeMessage();
		      MimeMessageHelper messageHelper = new MimeMessageHelper(msg, true, "UTF-8");
		 
		      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
		      messageHelper.setTo(tomail);     // 받는사람 이메일
		      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
		      messageHelper.setText(content);  // 메일 내용

		      mailSender.send(msg);
		    } catch(Exception e){
		    	e.printStackTrace();
		    	return -1;
		    }		
			return 1;
		}
		return 0;
	}
	
	@Override
	public int checkEmail(String email) throws Exception{
		return dao.checkEmail(email);
	}
 
	@Override
	public int checkUname(String uname) throws Exception {
		return dao.checkUname(uname);
	}

	@Override
	public int join(UserVO vo) throws Exception {
		return dao.join(vo);
	}

	@Override
	public UserVO login(UserDTO dto) throws Exception {
		return dao.login(dto);
	}
	
	@Override
	public void keepLogin(UserVO vo) throws Exception{
		dao.keepLogin(vo);
	}
	
	@Override
	public UserVO checkAutoLogin(String sessionkey) throws Exception{
		return dao.checkAutoLogin(sessionkey);
	}
 	
	private String getRamdomPassword() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }; 
	    
		int idx = 0; 
	    StringBuffer sb = new StringBuffer();  
	    
	    for (int i = 0; i < 10; i++){ 
	    	idx = (int) (charSet.length * Math.random());
	    	sb.append(charSet[idx]); 
	    } 
	    System.out.println("난수 만들기 : " + sb);
	    
	    return sb.toString();
	}

}
