package com.spring.altaltal;

import java.sql.Date;
import org.springframework.stereotype.Component;

@Component
public class FeedbackVO {
	
	private int feedback_num;
	private String feedback_writer;
	private String feedback_email;
	private String feedback_message;
	private String feedback_status;
	private Date feedback_date;
	
	public String getFeedback_email() {
		return feedback_email;
	}
	public void setFeedback_email(String feedback_email) {
		this.feedback_email = feedback_email;
	}
	public String getFeedback_message() {
		return feedback_message;
	}
	public void setFeedback_message(String feedback_message) {
		this.feedback_message = feedback_message;
	}
	public String getFeedback_status() {
		return feedback_status;
	}
	public void setFeedback_status(String feedback_status) {
		this.feedback_status = feedback_status;
	}
	public Date getFeedback_date() {
		return feedback_date;
	}
	public void setFeedback_date(Date feedback_date) {
		this.feedback_date = feedback_date;
	}
	public int getFeedback_num() {
		return feedback_num;
	}
	public void setFeedback_num(int feedback_num) {
		this.feedback_num = feedback_num;
	}
	public String getFeedback_writer() {
		return feedback_writer;
	}
	public void setFeedback_writer(String feedback_writer) {
		this.feedback_writer = feedback_writer;
	}
}
