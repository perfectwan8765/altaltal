package com.spring.board.domain;

import java.util.Date;

import org.apache.ibatis.type.Alias;

@Alias("board")
public class BoardVO {
	
	private int bno;
	private String uname;
	private String title;
	private String content;
	private int viewcnt;
	private Date regdate;
	private Date updatedate;
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(Date updatedate) {
		this.updatedate = updatedate;
	}
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", uname=" + uname + ", title=" + title + ", content=" + content + ", viewcnt="
				+ viewcnt + ", regdate=" + regdate + ", updatedate=" + updatedate + "]";
	}
	
}
