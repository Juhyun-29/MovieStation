package com.MovieStation.biz.movie;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MovieDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	public void insertComment(Movie comment) {
		mybatis.insert("insertComment", comment);
	}
	
	public void updateComment(Movie comment) {
		mybatis.update("updateComment", comment);
	}
	
	public void deleteComment(Movie comment) {
		mybatis.delete("deleteComment", comment);
	}
	
	public Movie getComment(Movie comment) {
		return mybatis.selectOne("getComment", comment);
	}
	
	public Movie getStarPoint(Movie comment) {
		return mybatis.selectOne("getStarPoint", comment);
	}
	
	public List<Movie> getCommentList(Movie comment){
		return mybatis.selectList("getCommentList", comment);
	}
}
