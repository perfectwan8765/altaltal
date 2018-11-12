package com.spring.altaltal.makguli;

import org.springframework.stereotype.Component;

@Component
public class MakguliVO {
	private int makguli_num;
	private String makguli_name;
	private String makguli_area;
	private String makguli_make;
	private String makguli_make_url;
	private String makguli_content;
	private String makguli_ingre;
	private int makguli_degree;
	private int makguli_likecount;
	private int makguli_readcount;
	private String makguli_picture;
	
	public int getMakguli_num() {
		return makguli_num;
	}
	public void setMakguli_num(int makguli_num) {
		this.makguli_num = makguli_num;
	}
	public String getMakguli_name() {
		return makguli_name;
	}
	public void setMakguli_name(String makguli_name) {
		this.makguli_name = makguli_name;
	}
	public String getMakguli_area() {
		return makguli_area;
	}
	public void setMakguli_area(String makguli_area) {
		this.makguli_area = makguli_area;
	}
	public String getMakguli_make() {
		return makguli_make;
	}
	public void setMakguli_make(String makguli_make) {
		this.makguli_make = makguli_make;
	}
	public String getMakguli_ingre() {
		return makguli_ingre;
	}
	public void setMakguli_ingre(String makguli_ingre) {
		this.makguli_ingre = makguli_ingre;
	}
	public int getMakguli_degree() {
		return makguli_degree;
	}
	public void setMakguli_degree(int makguli_degree) {
		this.makguli_degree = makguli_degree;
	}
	public int getMakguli_likecount() {
		return makguli_likecount;
	}
	public void setMakguli_likecount(int makguli_likecount) {
		this.makguli_likecount = makguli_likecount;
	}
	public int getMakguli_readcount() {
		return makguli_readcount;
	}
	public void setMakguli_readcount(int makguli_readcount) {
		this.makguli_readcount = makguli_readcount;
	}
	public String getMakguli_picture() {
		return makguli_picture;
	}
	public void setMakguli_picture(String makguli_picture) {
		this.makguli_picture = makguli_picture;
	}
	public String getMakguli_content() {
		return makguli_content;
	}
	public void setMakguli_content(String makguli_content) {
		this.makguli_content = makguli_content;
	}
	public String getMakguli_make_url() {
		return makguli_make_url;
	}
	public void setMakguli_make_url(String makguli_make_url) {
		this.makguli_make_url = makguli_make_url;
	}
}
