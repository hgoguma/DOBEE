package com.dobee.services;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dobee.dao.ChatDao;
import com.dobee.dao.UserDao;
import com.dobee.vo.chat.ChatRoom;
import com.dobee.vo.chat.ChatUsers;
import com.dobee.vo.member.User;

@Service
public class ChatService {
	
    SqlSession sqlSession;
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//DM 채팅 목록 가져오기
	public List<User> getDmUserList(String mail) {
		List<User> dmUserList = null;
		ChatDao chatdao = sqlSession.getMapper(ChatDao.class);
		dmUserList = chatdao.getDmUserList(mail);
		return dmUserList;
	}

	//그룹 채팅방 만들기
	public int makeGroupChatRoom(String newChatRoomName){
		ChatDao chatdao = sqlSession.getMapper(ChatDao.class);
		int result = chatdao.makeGroupChatRoom(newChatRoomName);
		
		return result;
	}
	
	//채팅방 참여자 리스트 만들기
	public int makeGroupChatUsers(String newChatRoomName, List<String> chatUsers) {
		ChatDao chatdao = sqlSession.getMapper(ChatDao.class);
		int result = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("newChatRoomName", newChatRoomName);
		for(int i = 0; i<chatUsers.size(); i++) {
			String chatUserMail = chatUsers.get(i).toString();
			map.put("mail", chatUserMail);
			result = chatdao.makeGroupChatUsers(map);
		}
		return result;
		
	}
	
	//채팅방 seq 가져오기
	public int getChatSeq(String chatRoomName) {
		ChatDao chatdao = sqlSession.getMapper(ChatDao.class);
		int chatSeq = chatdao.getChatSeq(chatRoomName);			
		return chatSeq;
			
	}
	
	//회원이 속한 그룹 채팅방 리스트 가져오기
	public List<ChatRoom> getGroupChatRoomList(String mail) {
		ChatDao chatdao = sqlSession.getMapper(ChatDao.class);
		List<ChatRoom> groupChatRoomList = chatdao.getGroupChatRoomList(mail);
		return groupChatRoomList;
	}
	
}
