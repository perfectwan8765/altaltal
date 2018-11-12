package com.spring.altaltal.member;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class MemberVO {
	
	private String member_email;
	private String member_password;
	private int member_admin;
	private String member_nickname;
	private String member_picture;
	private String member_area;
	private String member_country;
	private String member_makguli;
	private String member_place;
	private Date member_date;
	
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_password() {
		return member_password;
	}
	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}
	public int getMember_admin() {
		return member_admin;
	}
	public void setMember_admin(int member_admin) {
		this.member_admin = member_admin;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getMember_picture() {
		return member_picture;
	}
	public void setMember_picture(String member_picture) {
		this.member_picture = member_picture;
	}
	public String getMember_area() {
		return member_area;
	}
	public void setMember_area(String member_area) {
		this.member_area = member_area;
	}
	public String getMember_country() {
		return member_country;
	}
	public void setMember_country(String member_country) {
		this.member_country = member_country;
	}
	public Date getMember_date() {
		return member_date;
	}
	public void setMember_date(Date member_date) {
		this.member_date = member_date;
	}
	public String getMember_makguli() {
		return member_makguli;
	}
	public void setMember_makguli(String member_makguli) {
		this.member_makguli = member_makguli;
	}
	public String getMember_place() {
		return member_place;
	}
	public void setMember_place(String member_place) {
		this.member_place = member_place;
	};
	

}
