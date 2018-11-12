package com.spring.user.persistence;

import com.spring.user.domain.UserDTO;
import com.spring.user.domain.UserVO;

public interface UserDAO {
	
	public int checkPass(UserDTO dto) throws Exception;
	public int checkEmail(String email) throws Exception;
	public int checkUname(String uname) throws Exception;
	public int join(UserVO vo) throws Exception;
	public UserVO login(UserDTO dto) throws Exception;
	public void changePW(UserVO vo) throws Exception;
	public void keepLogin(UserVO vo) throws Exception;
	public UserVO checkAutoLogin(String sessionkey) throws Exception;
	
}
