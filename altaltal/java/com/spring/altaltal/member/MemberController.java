package com.spring.altaltal.member;

import java.io.File;
import java.io.PrintWriter;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class MemberController {
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value="/memberLogout.me")
	public String memberLogout(HttpSession session, SessionStatus status) {
		session.invalidate();
		status.isComplete();
		
		return "main";
	}
	
	@RequestMapping(value="/MemberEMAILCheckAction.me")
	public String MemberEMAILCheckAction(HttpServletRequest request, Model model) {
		String email = request.getParameter("member_email");
		int check = memberDAO.confirmEmail(email);	
		model.addAttribute("email", email);
		model.addAttribute("check", check);
		
		return "./member/member_emailchk";
	}
	
	@RequestMapping(value="/MemberNICKNAMECheckAction.me")
	public String MemberNICKNAMECheckAction(HttpServletRequest request, Model model) {
		String nickname=request.getParameter("member_nickname");
		int check=memberDAO.confirmNickname(nickname);	
		request.setAttribute("nickname", nickname);
		request.setAttribute("check", check);
		
		return "./member/member_nicknamechk";
	}

	@RequestMapping(value="/MemberJoinAction.me")
	public String MemberJoinAction(MemberVO vo, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {		
		MultipartFile mf = multiRequest.getFile("profile_img");
		String uploadPath = "C:\\BigDeep\\altaltal\\profile\\";
		String storedFileName ="";
		if(mf.getSize() != 0) {
		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
		String serial = getRamdomPassword();
		storedFileName = serial + originalFileExtension;
			//mf.transferTo(new File(uploadPath+ "/" + mf.getOriginalFilename()));
			mf.transferTo(new File(uploadPath + storedFileName));
		}
		
		vo.setMember_picture(storedFileName);
		
		int check = memberDAO.insertMember(vo);		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('회원가입이 완료되었습니다.');");
			out.println("location.href='./main.me';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('회원가입이 실패되었습니다.');");
			out.println("location.href='./main.me';");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/MemberLoginAction.me")
	public String MemberLoginAction(MemberVO vo, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		int check = memberDAO.userCheck(vo);
		if(check == 1){
			MemberVO vo2 = memberDAO.getUserInfo(vo);
			session.setAttribute("email", vo.getMember_email());
			session.setAttribute("nickname", vo2.getMember_nickname());
			session.setAttribute("profile", vo2.getMember_picture());
  			if(memberDAO.isAdmin(vo)){
  				session.setAttribute("admin", "admin");
  				out.println("<script>");
  				out.println("location.href='./AdminMembersList.ad'");
  				out.println("</script>"); 
			}else{
				out.println("<script>");
  				out.println("location.href='./main.me'");
  				out.println("</script>"); 
			}
		}else if(check == 0){
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지 않습니다. 다시 로그인해주세요.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		}else{
			out.println("<script>");
			out.println("alert('아이디가 존재하지 않습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		}
		return null;
	}	
	
	@RequestMapping(value="/MemberFind.me")
	public String MemberFind(){
		return "./member/member_find";
	}	
	
	@RequestMapping(value="/MemberFindAction.me")
	public String MemberFindAction(MemberVO vo, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		int check = memberDAO.confirmEmail(vo.getMember_email());
		if(check == 1) {
			String newPassword = getRamdomPassword(); 
			vo.setMember_password(newPassword);
			memberDAO.updatePassword(vo);
		
			String setfrom = "altaltal337@gmail.com";         
		    String tomail  = vo.getMember_email();     // 받는 사람 이메일
		    String title   = "[Project Altaltal] Altaltal 홈페이지의 새로운 비밀번호를 보냅니다";     // 제목
		    String content= "[Project Altaltal]입니다. 새로운 비밀번호를 보냅니다. 확인하시고 이 비밀번호로 로그인 해주세요. \n "
		    						+ "귀하의 새로운 비밀번호는 : [ " + newPassword + " ] 입니다. \n"
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
		      System.out.println("error메시지 : " + e.getMessage());
		    }
		    
			model.addAttribute("email", vo.getMember_email());			
			return "./member/member_find_ok"; 			
		}else{
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록되지 않은 이메일입니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
		}		 
		return null;
	}	
	
	public String getRamdomPassword() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' }; 
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
