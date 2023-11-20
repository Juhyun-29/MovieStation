package com.MovieStation.biz.user;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserDAO {

	private final SqlSessionTemplate mybatis;
	
	public String getUserId(String id) {
		return mybatis.selectOne("getUserId", id);
	}
	
	public String getUserNick(String nickname) {
		return mybatis.selectOne("getUserNick", nickname);
	}
	
	public String getUserMail(String mail) {
		return mybatis.selectOne("getUserMail", mail);
	}
	
	public void insertUser(User user) {
		mybatis.insert("insertUser", user);
	}
	
	public void updateUser(User user) {
		mybatis.update("updateUser", user);
	}
	
	public void deleteUser(User user) {
		mybatis.delete("deleteUser", user);
	}
	
	public User getUser(User user){
		return mybatis.selectOne("getUser", user);
	}
}
