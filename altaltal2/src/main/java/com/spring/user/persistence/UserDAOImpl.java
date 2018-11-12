package com.spring.user.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.user.domain.UserDTO;
import com.spring.user.domain.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;
	
	private static final String NAMESPACE = "UserMapper";
	
	@Override
	public int checkEmail(String email) throws Exception {
		return session.selectOne(NAMESPACE+".checkEmail", email);
	}

	@Override
	public int checkUname(String uname) throws Exception {
		return session.selectOne(NAMESPACE+".checkUname", uname);
	}

	@Override
	public int join(UserVO vo) throws Exception {
		return session.insert(NAMESPACE+".join", vo);
	}

	@Override
	public UserVO login(UserDTO dto) throws Exception {
		return session.selectOne(NAMESPACE+".login", dto);
	}
	
	@Override
	public void changePW(UserVO vo) throws Exception{
		session.update(NAMESPACE+".changePW", vo);
	}
	
	@Override
	public void keepLogin(UserVO vo) throws Exception{
		session.update(NAMESPACE +".keepLogin", vo);
	}
	
	@Override
	public UserVO checkAutoLogin(String sessionkey) throws Exception{
		return session.selectOne(NAMESPACE+".checkAutoLogin", sessionkey);
	}
	
	@Override
	public int checkPass(UserDTO dto) throws Exception{
		return session.selectOne(NAMESPACE+".checkPass", dto);
	}

}
