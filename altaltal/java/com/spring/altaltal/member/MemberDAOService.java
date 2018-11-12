package com.spring.altaltal.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberDAOService implements MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int confirmEmail(String email) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int check = memberMapper.confirmEmail(email);
		return check;
	}
	
	@Override
	public int confirmNickname(String nickname) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int check = memberMapper.confirmNickname(nickname);
		return check;
	}
	
	@Override
	public int insertMember(MemberVO vo) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int check = memberMapper.insertMember(vo);
		return check;
	}
	
	@Override
	public int userCheck(MemberVO vo) {
		int check = -1;
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		String password = memberMapper.userCheck(vo);
		if(password == null) {
			check = -1;
		}else if(password.equals(vo.getMember_password())) {
			check = 1;
		}else {
			check = 0;
		}
		return check;
	}
	
	@Override
	public boolean isAdmin(MemberVO vo) {
		boolean result = false;
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int check = memberMapper.isAdmin(vo);
		System.out.println("isAdmin check : " + check);
		if(check == 1) {
			result = true;
		}
		
		System.out.println("isAdmin : " + result);
		return result;
	}
	
	@Override
	public String findEMAIL(MemberVO vo) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		String password = memberMapper.userCheck(vo);
		
		return password;
	}
	
	@Override
	public MemberVO getUserInfo(MemberVO vo) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		MemberVO vo2 = memberMapper.getUserInfo(vo);
		
		return vo2;
	}
	
	@Override
	public int updatePassword(MemberVO vo) {
		MemberMapper memberMapper = sqlSession.getMapper(MemberMapper.class);
		int check = memberMapper.updatePassword(vo);
		
		return check;
	}
	
}
