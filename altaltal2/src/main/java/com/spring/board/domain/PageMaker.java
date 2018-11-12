package com.spring.board.domain;

public class PageMaker {

	private int totalCnt;
	private int startPage;
	private int endPage;
	private int startNum;
	private boolean prev;
	private boolean next;
	private Criteria cri;
	
	private int displayPageNum = 10;
	
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
		
		calData();
	}
	
	private void calData() {
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		startPage = (endPage-displayPageNum)+1;
		
		int temEndPage = (int)(Math.ceil(totalCnt /(double)cri.getPageNum()));
		
		if(endPage > temEndPage) {
			endPage = temEndPage;
		}
		
		startNum = totalCnt - (cri.getPage()-1)*cri.getPageNum();
		
		prev = startPage == 1 ? false : true;
		next = (endPage * cri.getPageNum()) >= totalCnt ? false : true;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public int getTotalCnt() {
		return totalCnt;
	}

	public Criteria getCri() {
		return cri;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	@Override
	public String toString() {
		return "PageMaker [totalCnt=" + totalCnt + ", startPage=" + startPage + ", endPage=" + endPage + ", startNum="
				+ startNum + ", prev=" + prev + ", next=" + next + ", cri=" + cri + ", displayPageNum=" + displayPageNum
				+ "]";
	}

}
