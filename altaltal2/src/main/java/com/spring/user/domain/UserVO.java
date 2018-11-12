package com.spring.user.domain;

import java.util.Date;


public class UserVO {

	private String email;
	private String upw;
	private int adminck;
	private String uname;
	private String profile;
	private String area;
	private String country;
	private String umakgeoli;
	private String uplace;
	private String sessionkey;
	private Date sessiondate;
	private Date regdate;
	
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
	public int getAdminck() {
		return adminck;
	}
	public void setAdminck(int adminck) {
		this.adminck = adminck;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getUmakgeoli() {
		return umakgeoli;
	}
	public void setUmakgeoli(String umakgeoli) {
		this.umakgeoli = umakgeoli;
	}
	public String getUplace() {
		return uplace;
	}
	public void setUplace(String uplace) {
		this.uplace = uplace;
	}
	public String getSessionkey() {
		return sessionkey;
	}
	public void setSessionkey(String sessionkey) {
		this.sessionkey = sessionkey;
	}
	public Date getSessiondate() {
		return sessiondate;
	}
	public void setSessiondate(Date sessiondate) {
		this.sessiondate = sessiondate;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "UserVO [email=" + email + ", upw=" + upw + ", adminck=" + adminck + ", uname=" + uname + ", profile="
				+ profile + ", area=" + area + ", country=" + country + ", umakgeoli=" + umakgeoli + ", uplace="
				+ uplace + ", sessionkey=" + sessionkey + ", sessiondate=" + sessiondate + ", regdate=" + regdate + "]";
	}
	
}
