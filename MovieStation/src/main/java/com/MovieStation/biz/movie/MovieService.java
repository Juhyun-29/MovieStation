package com.MovieStation.biz.movie;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MovieService implements MovieMapper{

	@Autowired
	MovieDAO movieDAO;
	
	@Override
	public void insertComment(Movie comment) {
		movieDAO.insertComment(comment);
	}

	@Override
	public void updateComment(Movie comment) {
		movieDAO.updateComment(comment);
	}

	@Override
	public void deleteComment(Movie comment) {
		movieDAO.deleteComment(comment);
	}

	@Override
	public List<Movie> getCommentList(Movie comment) {
		return movieDAO.getCommentList(comment);
	}

}
