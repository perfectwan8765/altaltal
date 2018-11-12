package com.spring.board.domain;

public class Criteria {
	
	private int page;
	private int pageNum;
	private String topic;
	private String keyword;
	
	public Criteria() {
		this.page = 1;
		this.pageNum = 10;
	}

	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPageNum(int pageNum) {
		if(pageNum <= 0 || pageNum >= 100) {
			this.pageNum = 10;
			return;
		}
	}
	
	public int getPage() {
		return this.page;
	}
	
	public int getPageStart() {
		return (this.page-1) * pageNum;
	}

	public int getPageNum() {
		return pageNum;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", pageNum=" + pageNum + ", topic=" + topic + ", keyword=" + keyword + "]";
	}

}
