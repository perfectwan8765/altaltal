package com.spring.altaltal.visitor;

import java.util.HashMap;

public interface VisitorDAO {
	public void insertVisitor(String agent);
	HashMap<String, Object> getMainInfo();
}
