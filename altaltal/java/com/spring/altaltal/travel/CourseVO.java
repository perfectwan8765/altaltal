package com.spring.altaltal.travel;

import org.springframework.stereotype.Component;

@Component
public class CourseVO {
	
	private int course_num;
	private String course_area;
	private String course_name;
	private String course_picture;
	private String course_content;
	
	
	public int getCourse_num() {
		return course_num;
	}
	public void setCourse_num(int course_num) {
		this.course_num = course_num;
	}
	public String getCourse_area() {
		return course_area;
	}
	public void setCourse_area(String course_area) {
		this.course_area = course_area;
	}
	public String getCourse_content() {
		return course_content;
	}
	public void setCourse_content(String course_content) {
		this.course_content = course_content;
	}
	public String getCourse_picture() {
		return course_picture;
	}
	public void setCourse_picture(String course_picture) {
		this.course_picture = course_picture;
	}
	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}
}
