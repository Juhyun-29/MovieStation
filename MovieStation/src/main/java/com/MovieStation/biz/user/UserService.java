package com.MovieStation.biz.user;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService implements UserMapper{

	private final UserDAO userDAO;
	
	@Override
	public String getUserId(String id) {
		return userDAO.getUserId(id);
	}

	@Override
	public String getUserNick(String nickname) {
		return userDAO.getUserNick(nickname);
	}
	@Override
	public String getUserMail(String mail) {
		return userDAO.getUserMail(mail);
	}
	
	@Override
	public void insertUser(User user) {
		userDAO.insertUser(user);
	}

	@Override
	public void updateUser(User user) {
		userDAO.updateUser(user);
	}

	@Override
	public void deleteUser(User user) {
		userDAO.deleteUser(user);
	}

	@Override
	public User getUser(User user) {
		return userDAO.getUser(user);
	}

}
