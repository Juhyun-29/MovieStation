package com.MovieStation.biz.movie;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Movie {
	private int rseq;
	private String movieId;
	private	String movieSeq;
	private String nickname;
	private String content;
	private int starpoint;
	private String regdate;
	private String id;
	
	private String page;
	private String query;
	private String searchType;
}
