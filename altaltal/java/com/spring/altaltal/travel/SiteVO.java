package com.spring.altaltal.travel;

import org.springframework.stereotype.Component;

@Component
public class SiteVO {
	
	private int site_num;
	private int course_num;
	private int site_order;
	private String site_name;
	private String site_content;
	private String site_picture;
	private double site_maplat;
	private double site_maplng;
	
	public int getSite_num() {
		return site_num;
	}
	public void setSite_num(int site_num) {
		this.site_num = site_num;
	}
	public int getCourse_num() {
		return course_num;
	}
	public void setCourse_num(int course_num) {
		this.course_num = course_num;
	}
	public String getSite_name() {
		return site_name;
	}
	public void setSite_name(String site_name) {
		this.site_name = site_name;
	}
	public String getSite_content() {
		return site_content;
	}
	public void setSite_content(String site_content) {
		this.site_content = site_content;
	}
	public double getSite_maplat() {
		return site_maplat;
	}
	public void setSite_maplat(double site_maplat) {
		this.site_maplat = site_maplat;
	}
	public double getSite_maplng() {
		return site_maplng;
	}
	public void setSite_maplng(double site_maplng) {
		this.site_maplng = site_maplng;
	}
	public String getSite_picture() {
		return site_picture;
	}
	public void setSite_picture(String site_picture) {
		this.site_picture = site_picture;
	}
	public int getSite_order() {
		return site_order;
	}
	public void setSite_order(int site_order) {
		this.site_order = site_order;
	}
	
}
