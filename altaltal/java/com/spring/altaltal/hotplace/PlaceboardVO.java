package com.spring.altaltal.hotplace;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class PlaceboardVO {
	private int pboard_num;
	private int place_num;
	private String member_nickname;
	private String pboard_content;
	private int pboard_taste;
	private int pboard_price;
	private int pboard_service;
	private Date pboard_date;
	
	public int getPboard_num() {
		return pboard_num;
	}
	public void setPboard_num(int pboard_num) {
		this.pboard_num = pboard_num;
	}
	public int getPlace_num() {
		return place_num;
	}
	public void setPlace_num(int place_num) {
		this.place_num = place_num;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getPboard_content() {
		return pboard_content;
	}
	public void setPboard_content(String pboard_content) {
		this.pboard_content = pboard_content;
	}
	public int getPboard_taste() {
		return pboard_taste;
	}
	public void setPboard_taste(int pboard_taste) {
		this.pboard_taste = pboard_taste;
	}
	public int getPboard_price() {
		return pboard_price;
	}
	public void setPboard_price(int pboard_price) {
		this.pboard_price = pboard_price;
	}
	public int getPboard_service() {
		return pboard_service;
	}
	public void setPboard_service(int pboard_service) {
		this.pboard_service = pboard_service;
	}
	public Date getPboard_date() {
		return pboard_date;
	}
	public void setPboard_date(Date pboard_date) {
		this.pboard_date = pboard_date;
	}
}
