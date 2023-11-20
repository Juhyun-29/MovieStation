package com.MovieStation.biz.movie;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MovieService implements MovieMapper{

	private final MovieDAO movieDAO;
	
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
	public Movie getStarPoint(Movie comment) {
		return movieDAO.getStarPoint(comment);
	}
	
	@Override
	public Movie getComment(Movie comment) {
		return movieDAO.getComment(comment);
	}
	
	@Override
	public List<Movie> getCommentList(Movie comment) {
		return movieDAO.getCommentList(comment);
	}

	

	

}
