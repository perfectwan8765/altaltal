package com.spring.altaltal.member;

public interface MemberMapper {
	
	int confirmEmail(String email);
	int confirmNickname(String nickname);
	int insertMember(MemberVO vo);
	String userCheck(MemberVO vo);
	int isAdmin(MemberVO vo);
	MemberVO getUserInfo(MemberVO vo);
	int updatePassword(MemberVO vo);
}
