package com.dobee.controller;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dobee.dao.UserDao;
import com.dobee.vo.member.User;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@RestController
public class AjaxController_alpaca {
	
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	//회원 목록 가져오기
    @RequestMapping(value="getUserList.do", method=RequestMethod.POST)
    @JsonManagedReference
    public List<User> getUserList() {
    	UserDao userdao = sqlsession.getMapper(UserDao.class);
    	System.out.println("여기도 타??");
    	List<User> result = userdao.getUserList();
    	System.out.println("유저리스트"+result.toString());
    	System.out.println("유저리스트 갯수"+result.size());
    	return result;
    }
    
    //전체 채팅방 가져오기
    
    
}
