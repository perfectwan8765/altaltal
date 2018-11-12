package com.spring.altaltal.hotplace;

import org.springframework.stereotype.Component;

@Component
public class HotplaceVO {
	
	private int place_num;
	private String place_name;
	private String place_area;
	private String place_juso;
	private String place_menu;
	private String place_phone;
	private String place_content;
	private double place_maplat;
	private double place_maplng;
	private String place_price;
	private String place_url;
	private String place_picture;
	private int place_likecount;
	private int place_readcount;
	
	public int getPlace_num() {
		return place_num;
	}
	public void setPlace_num(int place_num) {
		this.place_num = place_num;
	}
	public String getPlace_name() {
		return place_name;
	}
	public void setPlace_name(String place_name) {
		this.place_name = place_name;
	}
	public String getPlace_area() {
		return place_area;
	}
	public void setPlace_area(String place_area) {
		this.place_area = place_area;
	}
	public String getPlace_juso() {
		return place_juso;
	}
	public void setPlace_juso(String place_juso) {
		this.place_juso = place_juso;
	}
	public String getPlace_menu() {
		return place_menu;
	}
	public void setPlace_menu(String place_menu) {
		this.place_menu = place_menu;
	}
	public String getPlace_content() {
		return place_content;
	}
	public void setPlace_content(String place_content) {
		this.place_content = place_content;
	}
	public String getPlace_picture() {
		return place_picture;
	}
	public void setPlace_picture(String place_picture) {
		this.place_picture = place_picture;
	}
	public String getPlace_price() {
		return place_price;
	}
	public void setPlace_price(String place_price) {
		this.place_price = place_price;
	}
	public int getPlace_likecount() {
		return place_likecount;
	}
	public void setPlace_likecount(int place_likecount) {
		this.place_likecount = place_likecount;
	}
	public int getPlace_readcount() {
		return place_readcount;
	}
	public void setPlace_readcount(int place_readcount) {
		this.place_readcount = place_readcount;
	}

	public double getPlace_maplat() {
		return place_maplat;
	}
	public void setPlace_maplat(double place_maplat) {
		this.place_maplat = place_maplat;
	}
	public String getPlace_url() {
		return place_url;
	}
	public void setPlace_url(String place_url) {
		this.place_url = place_url;
	}
	public double getPlace_maplng() {
		return place_maplng;
	}
	public void setPlace_maplng(double place_maplng) {
		this.place_maplng = place_maplng;
	}
	public String getPlace_phone() {
		return place_phone;
	}
	public void setPlace_phone(String place_phone) {
		this.place_phone = place_phone;
	}
}
