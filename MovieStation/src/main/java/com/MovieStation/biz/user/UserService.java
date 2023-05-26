package com.MovieStation.biz.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService implements UserMapper{

	@Autowired
	UserDAO userDAO;
	
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
