package com.spring.altaltal.makguli;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class MakguliboardVO {
	
	private int mboard_num;
	private int makguli_num;
	private String member_nickname;
	private String mboard_content;
	private int mboard_sweat;
	private int mboard_sour;
	private int mboard_body;
	private int mboard_spark;
	private int mboard_popular;
	private Date mboard_date;
	

	public int getMakguli_num() {
		return makguli_num;
	}
	public void setMakguli_num(int makguli_num) {
		this.makguli_num = makguli_num;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getMboard_content() {
		return mboard_content;
	}
	public void setMboard_content(String mboard_content) {
		this.mboard_content = mboard_content;
	}
	public int getMboard_sweat() {
		return mboard_sweat;
	}
	public void setMboard_sweat(int mboard_sweat) {
		this.mboard_sweat = mboard_sweat;
	}
	public int getMboard_sour() {
		return mboard_sour;
	}
	public void setMboard_sour(int mboard_sour) {
		this.mboard_sour = mboard_sour;
	}
	public int getMboard_body() {
		return mboard_body;
	}
	public void setMboard_body(int mboard_body) {
		this.mboard_body = mboard_body;
	}
	public int getMboard_spark() {
		return mboard_spark;
	}
	public void setMboard_spark(int mboard_spark) {
		this.mboard_spark = mboard_spark;
	}
	public int getMboard_popular() {
		return mboard_popular;
	}
	public void setMboard_popular(int mboard_popular) {
		this.mboard_popular = mboard_popular;
	}
	public Date getMboard_date() {
		return mboard_date;
	}
	public void setMboard_date(Date mboard_date) {
		this.mboard_date = mboard_date;
	}
	public int getMboard_num() {
		return mboard_num;
	}
	public void setMboard_num(int mboard_num) {
		this.mboard_num = mboard_num;
	}
}
