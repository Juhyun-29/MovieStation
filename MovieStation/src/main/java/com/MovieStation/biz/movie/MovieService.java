package com.MovieStation.biz.movie;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MovieService implements MovieMapper{

	@Autowired
	MovieDAO commentDAO;
	
	@Override
	public void insertComment(Movie comment) {
		commentDAO.insertComment(comment);
	}

	@Override
	public void updateComment(Movie comment) {
		commentDAO.updateComment(comment);
	}

	@Override
	public void deleteComment(Movie comment) {
		commentDAO.deleteComment(comment);
	}

	@Override
	public List<Movie> getCommentList(Movie comment) {
		return commentDAO.getCommentList(comment);
	}

}
