package com.spring.altaltal.member;

public interface MemberDAO {
	int confirmEmail(String email);
	int confirmNickname(String nickname);
	int insertMember(MemberVO vo);
	int userCheck(MemberVO vo);
	boolean isAdmin(MemberVO vo);
	String findEMAIL(MemberVO vo);
	MemberVO getUserInfo(MemberVO vo);
	int updatePassword(MemberVO vo);
}
