package com.spring.user.domain;

public class UserDTO {
	
	private String email;
	private String upw;
	private boolean useCookie;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUpw() {
		return upw;
	}
	public void setUpw(String upw) {
		this.upw = upw;
	}
	public boolean isUseCookie() {
		return useCookie;
	}
	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	
	@Override
	public String toString() {
		return "UserDTO [email=" + email + ", upw=" + upw + ", useCookie=" + useCookie + "]";
	}
	

}
