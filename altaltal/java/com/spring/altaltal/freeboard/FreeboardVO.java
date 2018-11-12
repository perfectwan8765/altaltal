package com.spring.altaltal.freeboard;

import java.sql.Date;
import org.springframework.stereotype.Component;

@Component
public class FreeboardVO {
	
	private int free_num;
	private String member_nickname;
	private String free_subject;
	private String free_content;
	private int free_readcount;
	private int free_ref;
	private int free_ref_seq;
	private int free_ref_level;
	private Date free_date;
	
	public int getFree_num() {
		return free_num;
	}
	public void setFree_num(int free_num) {
		this.free_num = free_num;
	}
	public String getMember_nickname() {
		return member_nickname;
	}
	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}
	public String getFree_subject() {
		return free_subject;
	}
	public void setFree_subject(String free_subject) {
		this.free_subject = free_subject;
	}
	public String getFree_content() {
		return free_content;
	}
	public void setFree_content(String free_content) {
		this.free_content = free_content;
	}
	public int getFree_readcount() {
		return free_readcount;
	}
	public void setFree_readcount(int free_readcount) {
		this.free_readcount = free_readcount;
	}
	public int getFree_ref() {
		return free_ref;
	}
	public void setFree_ref(int free_ref) {
		this.free_ref = free_ref;
	}
	public int getFree_ref_seq() {
		return free_ref_seq;
	}
	public void setFree_ref_seq(int free_ref_seq) {
		this.free_ref_seq = free_ref_seq;
	}
	public int getFree_ref_level() {
		return free_ref_level;
	}
	public void setFree_ref_level(int free_ref_level) {
		this.free_ref_level = free_ref_level;
	}
	public Date getFree_date() {
		return free_date;
	}
	public void setFree_date(Date free_date) {
		this.free_date = free_date;
	}

}
