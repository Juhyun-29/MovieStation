package com.MovieStation.biz.movie;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface MovieMapper {

	@Insert("INSERT INTO MOVIECOMMENT(RSEQ,MOVIEID,MOVIESEQ,NICKNAME,CONTENT,STARPOINT,ID) VALUES(null,#{movieId},#{movieSeq},#{nickname},#{content},#{starpoint},#{id})")
	void insertComment(Movie comment);

	@Update("UPDATE MOVIECOMMENT SET CONTENT=#{content}, STARPOINT=#{starpoint} WHERE RSEQ=#{rseq}")
	void updateComment(Movie comment);

	@Delete("DELETE FROM MOVIECOMMENT WHERE RSEQ=#{rseq}")
	void deleteComment(Movie comment);
	
	@Select("SELECT AVG(STARPOINT) AS STARSCORE FROM MOVIECOMMENT WHERE MOVIEID=#{movieId} AND MOVIESEQ=#{movieSeq}")
	Movie getStarScore(Movie comment);
	
	@Select("SELECT * FROM MOVIECOMMENT WHERE MOVIEID=#{movieId} AND MOVIESEQ=#{movieSeq} AND ID=#{id}")
	Movie getComment(Movie comment);

	@Select("SELECT * FROM MOVIECOMMENT WHERE MOVIEID=#{movieId} AND MOVIESEQ=#{movieSeq} ORDER BY UPDATEDATE DESC")
	List<Movie> getCommentList(Movie comment);

	
}