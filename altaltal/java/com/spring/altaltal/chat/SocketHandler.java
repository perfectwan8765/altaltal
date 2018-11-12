package com.spring.altaltal.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


//websocket에서 서버단의 프로세스를 정의할 수 있다.
public class SocketHandler extends TextWebSocketHandler{
		
	private final Logger logger = LogManager.getLogger(getClass());
	HttpServletRequest request;
	
	//접속하는 사용자에 대한 세션을 보관하기 위해 정의
	private Set<WebSocketSession> sessionSet = new HashSet<WebSocketSession>();
	private Map<WebSocketSession, String> nameMap = new HashMap<WebSocketSession, String>();
	private Map<WebSocketSession, String> regionMap = new HashMap<WebSocketSession, String>();
	private ArrayList<WebSocketSession> keys;
	
	public SocketHandler() {
		super();
		this.logger.info("create SocketHandler instance!");
	}
	
	//클라이언트에서 연결을 종료할 경우 발생하는 이벤트
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		nameMap.remove(session);
		regionMap.remove(session);
		
		Map<String, Object> map = session.getAttributes();
		String region = (String)map.get("region");
		if(regionMap.containsValue(region)) {
			keys = getKey(regionMap, region);
		}
		
		String nameList="";
		for(WebSocketSession client_session : keys) {
			String name = nameMap.get(client_session);
			nameList += name + "/";
		}
		System.out.println(nameList);
		
		for(WebSocketSession client_session : keys) {
			try {
			client_session.sendMessage(new TextMessage("remove/"+ nameList));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
		
		/*Collection<String> values = nameMap.values();
		String nameList ="";
		for (String name : values) {
			nameList += name +  "/";
		}
		
		for(WebSocketSession client_session : this.sessionSet) {
			try {
					client_session.sendMessage(new TextMessage("remove/"+ nameList));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
		this.logger.info("remove session!");*/
		
		super.afterConnectionClosed(session, status);
	}
	
	//클라이언트에서 접속하여 성공할 경우 자동으로 발생하는 이벤트, session에는 연결요청한 client session 정보가 담김.
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		super.afterConnectionEstablished(session);
			
		sessionSet.add(session);
		this.logger.info("add session!");
		
		Map<String, Object> map = session.getAttributes();
		String nickname = (String)map.get("nickname");
		String region = (String)map.get("region");
		System.out.println("afterConnection nickname : " + nickname);
		System.out.println("afterConnection region : " + region);
		nameMap.put(session, nickname);
		regionMap.put(session, region);		
		
		if(regionMap.containsValue(region)) {
			keys = getKey(regionMap, region);
		}
		
		String nameList="";
		for(WebSocketSession client_session : keys) {
			String name = nameMap.get(client_session);
			nameList += name + "/";
		}
		System.out.println(nameList);
		
		for(WebSocketSession client_session : keys) {
			try {
			client_session.sendMessage(new TextMessage("nameList/"+ nameList));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
		
		/*for(WebSocketSession client_session : this.sessionSet) {
				try {						
						client_session.sendMessage(new TextMessage("nameList/"+ nameList));
				}catch(Exception ignored) {
					this.logger.error("fail to send message!", ignored);
				}
		}*/
	}
	
	//클라이언트에서 send를 이용해서 메시지 발송을 한 경우 자동으로 메소드 호출 이벤트 핸들링
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception{
		super.handleMessage(session, message);
		
		//session.getAttributes() : HandshakeInterceptor의 beforeHandshake()메서드에서 저장한 map을 가져온다.
		Map<String, Object> map = session.getAttributes();
		//String userName = (String)map.get("userName");
		String region = (String)map.get("region");
		//System.out.println("전송자 아이디 : " + userName);
		//System.out.println("session.getId" + session.getId());
		
		if(regionMap.containsValue(region)) {
			keys = getKey(regionMap, region);
		}
		
		for(WebSocketSession client_session : keys) {
			try {
			client_session.sendMessage(new TextMessage("message/"+(String)message.getPayload()));
			}catch(Exception ignored) {
				this.logger.error("fail to send message!", ignored);
			}
		}
		
		/*for(WebSocketSession client_session : this.sessionSet) {
			if(client_session.isOpen()) {
				try {
					client_session.sendMessage(new TextMessage("message/"+(String)message.getPayload()));
				}catch(Exception ignored) {
					this.logger.error("fail to send message!", ignored);
				}
			}
		}*/
	}
	
	// 전송 에러 발생할 때 호출
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception{
		this.logger.error("web socket error!", exception);
	}
	
	//메시지가 긴 경우 분할해서 보낼 수 있는지 여부를 결정하는 메소드
	public boolean supportsPartialMessage() {
		this.logger.info("call method!");
		
		return false;
	}
	
	public ArrayList<WebSocketSession> getKey(Map<WebSocketSession, String> m, String value) { 
		ArrayList<WebSocketSession> keys = new ArrayList<WebSocketSession>();
		for(WebSocketSession o: m.keySet()) { 
			if(m.get(o).equals(value)) 
				keys.add(o); 
		} 
		return keys; 
	}

}