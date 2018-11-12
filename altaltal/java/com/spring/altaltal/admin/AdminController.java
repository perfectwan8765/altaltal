package com.spring.altaltal.admin;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.altaltal.freeboard.PageInfo;
import com.spring.altaltal.hotplace.HotplaceVO;
import com.spring.altaltal.makguli.MakguliVO;
import com.spring.altaltal.member.MemberVO;
import com.spring.altaltal.mypage.MypageDAO;
import com.spring.altaltal.travel.CourseVO;
import com.spring.altaltal.travel.SiteVO;

@Controller
public class AdminController {
	
	@Autowired
	private AdminDAO adminDAO;
	
	@Autowired
	private MypageDAO mypageDAO;
	
	@RequestMapping(value="/AdminMembersList.ad")
	public String MembersList(HttpServletRequest request, Model model) throws Exception {
		String keyword = "";
		String topic = "";
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		if(request.getParameter("topic") != null) {
			topic = request.getParameter("topic");
		}
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		ArrayList<MemberVO> memberslist = adminDAO.membersList(page, limit, topic, keyword);
		int listCount = adminDAO.getCountMember(topic, keyword);
		
		int maxPage = (int)((double)listCount/limit + 0.95);
		int startPage = (((int)((double)page / 10 +0.9)) -1)*10+1;
		int endPage = startPage+10-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		System.out.println("listCount : " + listCount);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("topic", topic);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("memberslist", memberslist);
		
		return "./admin/member/admin_memberlist";
	}
	
	@RequestMapping(value="/AdminMemberInfo.ad")
	public String AdminMemberInfo(HttpSession session, HttpServletRequest request, Model model) throws Exception {
		String email = request.getParameter("member_email");	
		String page = request.getParameter("page");
		System.out.println("adminmemberInfo email : " + email);
		MemberVO vo = mypageDAO.getMember(email);
		model.addAttribute("page", page);
		model.addAttribute("vo", vo);
		
		return "./admin/member/admin_memberupdate";
	}
	
	@RequestMapping(value="/AdminMemberUpdate.ad")
	public String AdminMemberUpdate(MemberVO vo, MultipartHttpServletRequest multiRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String page = request.getParameter("page");
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
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int res = mypageDAO.updateMember(vo);
		if(res == 1) {
			out.println("<script>");
			out.println("alert('회원수정 완료')");
			out.println("location.href='./AdminMembersList.ad?member_email=" + vo.getMember_email() + "&page=" + page + "'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('회원수정 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}
	
	@RequestMapping(value="/AdminNICKNAMECheck.ad")
	public String AdminNICKNAMECheck(HttpServletRequest request, Model model) {
		String nickname=request.getParameter("member_nickname");
		int check=mypageDAO.confirmNickname(nickname);	
		model.addAttribute("nickname", nickname);
		model.addAttribute("check", check);
		
		return "./admin/member/admin_nicknamechk";
	}
	
	@RequestMapping(value="/AdminMeberdelete.ad")
	public String AdminMeberdelete(HttpServletRequest request, Model model, HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String email = request.getParameter("member_email");
		String page = request.getParameter("page");
		int check = mypageDAO.deleteMember(email);
		if(check == 1) {
			out.println("<script>");
			out.println("alert('회원삭제 완료')");
			out.println("location.href='./AdminMemberInfo.ad?page=" + page + "'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('회원삭제 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return null;
	}
	
	@RequestMapping(value="/adminMakguliList.ad")
	public String adminMakguliList(HttpServletRequest request, Model model) throws Exception {
		String topic ="";
		String keyword = "";
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("topic") != null) {
			topic = request.getParameter("topic");
		}
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		ArrayList<MakguliVO> makguliList = adminDAO.adminMakguliList(page, limit, topic, keyword);
		int listCount = adminDAO.getCountMakguli(topic, keyword);
		
		int maxPage = (int)((double)listCount/limit + 0.95);
		int startPage = (((int)((double)page / 10 +0.9)) -1)*10+1;
		int endPage = startPage+10-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		System.out.println("listCount : " + listCount);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		model.addAttribute("topic", topic);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("makguliList", makguliList);
		
		return "./admin/makguli/admin_maklist";
	}
	
	@RequestMapping(value="/adminMakguliInsertForm.ad")
	public String adminMakguliInsertForm() {
		return "./admin/makguli/admin_makinsert";
	}
	
	@RequestMapping(value="/adminMakguli.ad")
	public String adminMakguli(MakguliVO vo, Model model) {
		MakguliVO vo2 = adminDAO.getMakguli(vo.getMakguli_num());
		model.addAttribute("makguli", vo2);
	
		return "./admin/makguli/admin_makdetail";
	}
	
	@RequestMapping(value="/makguliupdateForm.ad")
	public String makguliupdateForm(MakguliVO vo, Model model) {
		MakguliVO vo2 = adminDAO.getMakguli(vo.getMakguli_num());
		model.addAttribute("makguli", vo2);
	
		return "./admin/makguli/admin_makupdateForm";
	}

	@RequestMapping(value="/makguliDelete.ad")
	public String makguliDelete(MakguliVO vo, HttpServletResponse response) throws Exception {		
		int check = adminDAO.makguliDelete(vo.getMakguli_num());		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('막걸리 정보가 삭제되었습니다.');");
			out.println("location.href='./adminMakguliList.ad';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('막걸리 정보 삭제 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/adminMakguliInsert.ad")
	public String adminMakguliInsert(MakguliVO vo, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {		
		MultipartFile mf = multiRequest.getFile("makguli_img");
		String uploadPath = "C:\\BigDeep\\altaltal\\makguli\\";
		String storedFileName ="";
		if(mf.getSize() != 0) {
		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
		String serial = getRamdomPassword();
		storedFileName = serial + originalFileExtension;
			//mf.transferTo(new File(uploadPath+ "/" + mf.getOriginalFilename()));
			mf.transferTo(new File(uploadPath + storedFileName));
		}
		
		vo.setMakguli_picture(storedFileName);
		
		int check = adminDAO.insertMakguli(vo);		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('막걸리 정보 추가되었습니다.');");
			out.println("location.href='./adminMakguliList.ad';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('막걸리 정보 추가 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/adminMakguliUpdate.ad")
	public String adminMakguliUpdate(MakguliVO vo, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {		
		MultipartFile mf = multiRequest.getFile("makguli_img");
		String uploadPath = "C:\\BigDeep\\altaltal\\makguli\\";
		String storedFileName ="";
		if(mf.getSize() != 0) {
		String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
		String serial = getRamdomPassword();
		storedFileName = serial + originalFileExtension;
			//mf.transferTo(new File(uploadPath+ "/" + mf.getOriginalFilename()));
			mf.transferTo(new File(uploadPath + storedFileName));
			vo.setMakguli_picture(storedFileName);
		}
		
		int check = adminDAO.updateMakguli(vo);		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('막걸리 정보가 수정되었습니다.');");
			out.println("location.href='./adminMakguliList.ad';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('막걸리 정보 수정 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/adminPlaceList.ad")
	public String adminPlaceList(HttpServletRequest request, Model model) throws Exception {
		String topic = "";
		String keyword = "";
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("topic") != null) {
			topic = request.getParameter("topic");
		}
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		ArrayList<HotplaceVO> placeList = adminDAO.adminPlaceList(page, limit, topic, keyword);
		int listCount = adminDAO.getCountPlace(topic, keyword);
		
		int maxPage = (int)((double)listCount/limit + 0.95);
		int startPage = (((int)((double)page / 10 +0.9)) -1)*10+1;
		int endPage = startPage+10-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		System.out.println("listCount : " + listCount);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		model.addAttribute("topic", topic);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("placeList", placeList);
		
		return "./admin/place/admin_placelist";
	}
	
	@RequestMapping(value="/adminPlace.ad")
	public String adminPlace(HotplaceVO vo, Model model) {
		HotplaceVO vo2 = adminDAO.getPlace(vo.getPlace_num());
		model.addAttribute("hotplace", vo2);
	
		return "./admin/place/admin_placedetail";
	}
	
	@RequestMapping(value="/adminPlaceInsertForm.ad")
	public String adminPlaceInsertForm() {
		return "./admin/place/admin_placeinsert";
	}
	
	@RequestMapping(value="/placeUpdateForm.ad")
	public String placeUpdateForm(HotplaceVO vo, Model model) {
		HotplaceVO vo2 = adminDAO.getPlace(vo.getPlace_num());
		model.addAttribute("hotplace", vo2);
	
		return "./admin/place/admin_placeupdateForm";
	}
	
	@RequestMapping(value="/adminPlaceInsert.ad")
	public String adminPlaceInsert(HotplaceVO vo, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {		
		MultipartFile mainMf = multiRequest.getFile("place_mainimg");
		MultipartFile sub1Mf = multiRequest.getFile("place_subimg1");
		MultipartFile sub2Mf = multiRequest.getFile("place_subimg2");
		MultipartFile sub3Mf = multiRequest.getFile("place_subimg3");
		MultipartFile sub4Mf = multiRequest.getFile("place_subimg4");
		MultipartFile sub5Mf = multiRequest.getFile("place_subimg5");
		String uploadPath = "C:\\BigDeep\\altaltal\\place\\";
		String mianFileName ="";
		String sub1FileName ="";
		String sub2FileName ="";
		String sub3FileName ="";
		String sub4FileName ="";
		String sub5FileName ="";
		if(mainMf.getSize() != 0) {
			String originalFileExtension = mainMf.getOriginalFilename().substring(mainMf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			mianFileName = serial + originalFileExtension;
			mainMf.transferTo(new File(uploadPath + mianFileName));
		}
		
		if(sub1Mf.getSize() != 0) {
			String originalFileExtension = sub1Mf.getOriginalFilename().substring(sub1Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub1FileName = serial + originalFileExtension;
			sub1Mf.transferTo(new File(uploadPath + sub1FileName));
		}
		
		if(sub2Mf.getSize() != 0) {
			String originalFileExtension = sub2Mf.getOriginalFilename().substring(sub2Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub2FileName = serial + originalFileExtension;
			sub2Mf.transferTo(new File(uploadPath + sub2FileName));
		}
		
		if(sub3Mf.getSize() != 0) {
			String originalFileExtension = sub3Mf.getOriginalFilename().substring(sub3Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub3FileName = serial + originalFileExtension;
			sub3Mf.transferTo(new File(uploadPath + sub3FileName));
		}
		
		if(sub4Mf.getSize() != 0) {
			String originalFileExtension = sub4Mf.getOriginalFilename().substring(sub4Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub4FileName = serial + originalFileExtension;
			sub4Mf.transferTo(new File(uploadPath + sub4FileName));
		}
		
		if(sub5Mf.getSize() != 0) {
			String originalFileExtension = sub5Mf.getOriginalFilename().substring(sub5Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub5FileName = serial + originalFileExtension;
			sub5Mf.transferTo(new File(uploadPath + sub5FileName));
		}
		
		String storedName = mianFileName + "/" + sub1FileName +"/" +sub2FileName + "/" +sub3FileName + "/" +sub4FileName + "/" +sub5FileName;
		
		vo.setPlace_picture(storedName);
		
		int check = adminDAO.insertPlace(vo);		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('맛집 정보 추가되었습니다.');");
			out.println("location.href='./adminPlaceList.ad';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('맛집 정보 추가 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/adminPlaceUpdate.ad")
	public String adminPlaceUpdate(HotplaceVO vo, HttpServletRequest request, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {		
		MultipartFile mainMf = multiRequest.getFile("place_mainimg");
		MultipartFile sub1Mf = multiRequest.getFile("place_subimg1");
		MultipartFile sub2Mf = multiRequest.getFile("place_subimg2");
		MultipartFile sub3Mf = multiRequest.getFile("place_subimg3");
		MultipartFile sub4Mf = multiRequest.getFile("place_subimg4");
		MultipartFile sub5Mf = multiRequest.getFile("place_subimg5");
		String uploadPath = "C:\\BigDeep\\altaltal\\place\\";
		String mainFileName ="";
		String sub1FileName ="";
		String sub2FileName ="";
		String sub3FileName ="";
		String sub4FileName ="";
		String sub5FileName ="";
		String main_picture = request.getParameter("main_picture");
		String sub1_picture = request.getParameter("sub1_picture");
		String sub2_picture = request.getParameter("sub2_picture");
		String sub3_picture = request.getParameter("sub3_picture");
		String sub4_picture = request.getParameter("sub4_picture");
		String sub5_picture = request.getParameter("sub4_picture");
		
		String storedName = "";		
		if(mainMf.getSize() != 0) {
			String originalFileExtension = mainMf.getOriginalFilename().substring(mainMf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			mainFileName = serial + originalFileExtension;
			mainMf.transferTo(new File(uploadPath + mainFileName));
			storedName = mainFileName +"/";
		}else {
			storedName = main_picture +"/";
		}
		
		if(sub1Mf.getSize() != 0) {
			String originalFileExtension = sub1Mf.getOriginalFilename().substring(sub1Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub1FileName = serial + originalFileExtension;
			sub1Mf.transferTo(new File(uploadPath + sub1FileName));
			storedName += sub1FileName +"/";
		}else {
			storedName += sub1_picture +"/";
		}
		
		if(sub2Mf.getSize() != 0) {
			String originalFileExtension = sub2Mf.getOriginalFilename().substring(sub2Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub2FileName = serial + originalFileExtension;
			sub2Mf.transferTo(new File(uploadPath + sub2FileName));
			storedName += sub2FileName+"/";
		}else {
			storedName += sub2_picture+"/";
		}
		
		if(sub3Mf.getSize() != 0) {
			String originalFileExtension = sub3Mf.getOriginalFilename().substring(sub3Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub3FileName = serial + originalFileExtension;
			sub3Mf.transferTo(new File(uploadPath + sub3FileName));
			storedName += sub3FileName+"/";
		}else {
			storedName += sub3_picture+"/";
		}
		
		if(sub4Mf.getSize() != 0) {
			String originalFileExtension = sub4Mf.getOriginalFilename().substring(sub4Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub4FileName = serial + originalFileExtension;
			sub4Mf.transferTo(new File(uploadPath + sub4FileName));
			storedName += sub4FileName+"/";
		}else {
			storedName += sub4_picture+"/";
		}
		
		if(sub5Mf.getSize() != 0) {
			String originalFileExtension = sub5Mf.getOriginalFilename().substring(sub5Mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			sub5FileName = serial + originalFileExtension;
			sub5Mf.transferTo(new File(uploadPath + sub5FileName));
			storedName += sub5FileName;
		}else {
			storedName += sub5_picture;
		}
		
		vo.setPlace_picture(storedName);
		
		int check = adminDAO.updatePlace(vo);		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('맛집 정보가 수정되었습니다.');");
			out.println("location.href='./adminPlaceList.ad';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('맛집 정보 수정 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/deletePlace.ad")
	public String deletePlace(HotplaceVO vo, HttpServletResponse response) throws Exception {		
		int check = adminDAO.deletePlace(vo.getPlace_num());		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('맛집 정보가 삭제되었습니다.');");
			out.println("location.href='./adminPlaceList.ad';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('맛집 정보 삭제 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/adminCourseList.ad")
	public String adminCourseList(HttpServletRequest request, Model model) throws Exception {
		String topic = "";
		String keyword = "";
		int page = 1;
		int limit = 10;
		
		if(request.getParameter("topic") != null) {
			topic = request.getParameter("topic");
		}
		if(request.getParameter("keyword") != null) {
			keyword = request.getParameter("keyword");
		}
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		ArrayList<CourseVO> courseList = adminDAO.adminCourseList(page, limit, topic, keyword);
		int listCount = adminDAO.getCountCourse(topic, keyword);
		
		int maxPage = (int)((double)listCount/limit + 0.95);
		int startPage = (((int)((double)page / 10 +0.9)) -1)*10+1;
		int endPage = startPage+10-1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		System.out.println("listCount : " + listCount);
		
		PageInfo pageInfo = new PageInfo();
		pageInfo.setEndPage(endPage);
		pageInfo.setListCount(listCount);
		pageInfo.setMaxPage(maxPage);
		pageInfo.setPage(page);
		pageInfo.setStartPage(startPage);
		
		model.addAttribute("topic", topic);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("courseList", courseList);
		
		return "./admin/travel/admin_courselist";
	}
	
	@RequestMapping(value="/adminCourseInsertForm.ad")
	public String adminCourseInsertForm() {
		return "./admin/travel/admin_courseinsert";
	}
	
	@RequestMapping(value="/adminCourseInsert.ad")
	public String adminCourseInsert(CourseVO vo, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {		
		MultipartFile mf = multiRequest.getFile("course_img");
		String uploadPath = "C:\\BigDeep\\altaltal\\course\\";
		String storedFileName ="";
		if(mf.getSize() != 0) {
			String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			storedFileName = serial + originalFileExtension;
			mf.transferTo(new File(uploadPath + storedFileName));
		}
		
		vo.setCourse_picture(storedFileName);
		
		int check = adminDAO.insertCourse(vo);		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('여행코스가 추가되었습니다.');");
			out.println("location.href='./adminCourseList.ad';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('여행코스 추가 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/adminCourse.ad")
	public String adminCourse(CourseVO vo, Model model) {
		CourseVO vo2 = adminDAO.getCourse(vo.getCourse_num());
		ArrayList<SiteVO> siteList = adminDAO.getSiteList(vo.getCourse_num());
		
		model.addAttribute("vo2", vo2);
		model.addAttribute("siteList", siteList);
		
		return "./admin/travel/admin_coursedetail";
	}
	
	@RequestMapping(value="/adminCourseDelete.ad")
	public String adminCourseDelete(CourseVO vo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		int page = Integer.parseInt(request.getParameter("page"));
		
		int check = adminDAO.deleteCourse(vo.getCourse_num());		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('해당 여행코스가 삭제되었습니다.');");
			out.println("location.href='./adminCourseList.ad?page="+ page +"';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('여행코스 삭제 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/insertSiteForm.ad")
	public String insertSiteForm(CourseVO vo, Model model) {
		model.addAttribute("vo", vo);
		
		return "./admin/travel/admin_siteinsert";
	}
	
	@RequestMapping(value="/siteInsert.ad")
	public String siteInsert(SiteVO vo, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {		
		MultipartFile mf = multiRequest.getFile("site_img");
		String uploadPath = "C:\\BigDeep\\altaltal\\site\\";
		String storedFileName ="";
		if(mf.getSize() != 0) {
			String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			storedFileName = serial + originalFileExtension;
			mf.transferTo(new File(uploadPath + storedFileName));
		}
		
		vo.setSite_picture(storedFileName);
		
		int check = adminDAO.insertSite(vo);		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('여행장소가 추가되었습니다.');");
			out.println("location.href='./adminCourse.ad?course_num="+ vo.getCourse_num() +"';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('여행장소 추가 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/siteDetail.ad")
	public String siteDetail(CourseVO vo1, SiteVO vo2, Model model) {
		model.addAttribute("CourseVO", vo1);
		SiteVO vo3 = adminDAO.getSite(vo2.getSite_num());
		model.addAttribute("SiteVO", vo3);
		
		return "./admin/travel/admin_sitedetail";
	}
	
	@RequestMapping(value="/siteUpdateForm.ad")
	public String siteUpdateForm(CourseVO vo1, SiteVO vo2, Model model) {
		model.addAttribute("CourseVO", vo1);
		SiteVO vo3 = adminDAO.getSite(vo2.getSite_num());
		model.addAttribute("SiteVO", vo3);
		
		return "./admin/travel/admin_siteupdateForm";
	}
	
	@RequestMapping(value="/siteUpdate.ad")
	public String siteUpdate(SiteVO vo, MultipartHttpServletRequest multiRequest, HttpServletResponse response) throws Exception {		
		MultipartFile mf = multiRequest.getFile("site_img");
		String uploadPath = "C:\\BigDeep\\altaltal\\site\\";
		String storedFileName ="";
		if(mf.getSize() != 0) {
			String originalFileExtension = mf.getOriginalFilename().substring(mf.getOriginalFilename().lastIndexOf("."));
			String serial = getRamdomPassword();
			storedFileName = serial + originalFileExtension;
			mf.transferTo(new File(uploadPath + storedFileName));
			vo.setSite_picture(storedFileName);
		}
		
		int check = adminDAO.updateSite(vo);		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('여행장소가 수정되었습니다.');");
			out.println("location.href='./adminCourse.ad?course_num="+ vo.getCourse_num() +"';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('여행장소 수정 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");			
			out.close();
		}
		return null;
	}
	
	@RequestMapping(value="/siteDelete.ad")
	public String siteDelete(SiteVO vo, HttpServletResponse response) throws Exception {
		int check = adminDAO.siteDelete(vo.getSite_num());		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(check == 1) {
			out.println("<script>");
			out.println("alert('해당 여행장소 정보가 삭제되었습니다.');");
			out.println("location.href='./adminCourse.ad?course_num="+ vo.getCourse_num() +"';");
			out.println("</script>");			
			out.close();
			
		}else {
			out.println("<script>");
			out.println("alert('해당 여행장소 정보 삭제 실패하였습니다.');");
			out.println("history.back();");
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
