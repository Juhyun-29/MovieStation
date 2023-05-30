package com.MovieStation.view.movie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.MovieStation.biz.movie.Movie;
import com.MovieStation.biz.movie.MovieService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@RestController
public class MovieController {

	@Autowired
	private MovieService movieService;
	
	@GetMapping("/search")
	public ModelAndView searchPage(ModelAndView mav) {
		mav.setViewName("search");
		return mav;
	}
	
	@GetMapping("/searching")
	public ModelAndView searchMovie(Movie movie, ModelAndView mav) throws IOException {
		System.out.println("/search 실행");
		System.out.println("영화 검색 처리");
		
		int page;
		if(movie.getPage()==null) {
			page=1;
		}else {
			page=Integer.parseInt(movie.getPage());  
		}
		System.out.println("현재 페이지 : "+page);
		
		String key = "KFI7VEXN1YPWR5EJLOD3";
		String query = URLEncoder.encode(movie.getQuery(),"UTF-8");
		String keyword = movie.getQuery();
		String searchType=movie.getSearchType();
		
		try {
			URL url = new URL("https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey="+key+"&"+searchType+"="+query+"&sort=prodYear,1&listCount=500");
			BufferedReader bfr;
			bfr=new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
			
			JSONParser jsonParser=new JSONParser();
			JSONObject jsonObject=(JSONObject)jsonParser.parse(bfr);
			
			JSONArray data=(JSONArray)jsonObject.get("Data");
			JSONObject result=(JSONObject)data.get(0);
			JSONArray searchResult=(JSONArray)result.get("Result");
			
			// 검색 결과가 없을 때
			if(searchResult==null) {
				int totalCount=0;
				String msg="검색 결과가 없습니다. 검색유형과 검색어를 확인해 보시고 다시 검색해 보세요.";
				
				mav.addObject("page", page);
				mav.addObject("query", query);
				mav.addObject("searchType", searchType);
				mav.addObject("keyword", keyword);			
				mav.addObject("totalCount", totalCount);
				mav.addObject("msg", msg);
				
				mav.setViewName("searchResult");
				return mav;
			
			// 검색 결과가 있을 때
			}else {

				// 성인 영화 필터링 된 검색 결과를 담을 JSONArray 생성
				JSONArray movieList=new JSONArray();
				
				// 최초 검색 결과에서 에로 영화, 장르·런타임·개봉날짜 없는 영화, 극장 상영 안한 영화 필터링
				for (int i = 0; i < searchResult.size(); i++) {
					JSONObject movieResult=(JSONObject)searchResult.get(i);
					if(movieResult.get("genre").equals("에로")||movieResult.get("genre").equals("")||movieResult.get("runtime").equals("")||movieResult.get("repRlsDate").equals("")||!movieResult.get("use").equals("극장용")) {
						continue;
					}else {
						// 필터링 된 검색 결과를 위에서 선언한 movieList에 담음
						movieList.add(movieResult);
					}
				}
				
				if(movieList.toString().equals("[]")) {
					int totalCount=0;
					String msg="검색 결과가 없습니다. 검색유형과 검색어를 확인해 보시고 다시 검색해 보세요.";
					
					mav.addObject("page", page);
					mav.addObject("query", query);
					mav.addObject("searchType", searchType);
					mav.addObject("keyword", keyword);			
					mav.addObject("totalCount", totalCount);
					mav.addObject("msg", msg);
					
					mav.setViewName("searchResult");
					return mav;
				}else {
					// 필터링 된 검색 결과 수
					int totalCount=movieList.size()-1;
					
					// 검색 결과를 10개씩 담아낼 JSONArray 생성(페이징 처리를 위함)
					JSONArray finalMovieList=new JSONArray();
					
					// 검색 결과 페이징 처리를 위한 반복문
					for (int j = page*10-10; j < movieList.size(); j++) {
						if(j<page*10) {
							JSONObject movieInfo=(JSONObject)movieList.get(j);
							
							// KMDB에 설정된 영화 제목 필터링
							String title=(String)movieInfo.get("title");
							title=title.replace("!HS", "");
							title=title.replace("!HE", "");
							title=title.replaceAll("  ", "");
							movieInfo.put("title", title);

							// 영화 포스터 1개만 가져오기
							String posters=(String)movieInfo.get("posters");
							String[] posterList=posters.split("\\|");
							String poster=posterList[0];
							movieInfo.put("posters", poster);
							
							// 개봉 날짜 포맷팅
							String repRlsDate=(String)movieInfo.get("repRlsDate");
							if(repRlsDate.length()>7) {
								SimpleDateFormat dtFormat=new SimpleDateFormat("yyyyMMdd");
								SimpleDateFormat newDtFormat=new SimpleDateFormat("yyyy-MM-dd");
								Date newDt=dtFormat.parse(repRlsDate);
								repRlsDate=newDtFormat.format(newDt);
								movieInfo.put("repRlsDate", repRlsDate);
							}
							
							// 영화 줄거리 가져오기
							JSONObject plots=(JSONObject)movieInfo.get("plots");
							JSONArray plot=(JSONArray)plots.get("plot");
							JSONObject plotData=(JSONObject)plot.get(0);
							String plotText=(String)plotData.get("plotText");
							movieInfo.put("overview", plotText);
							
							finalMovieList.add(movieInfo);
						}else {
							continue;
						}
					}
					
					mav.addObject("page", page);
					mav.addObject("query", query);
					mav.addObject("searchType", searchType);
					mav.addObject("keyword", keyword);			
					mav.addObject("totalCount", totalCount);			
					mav.addObject("finalMovieList", finalMovieList);			
					
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		mav.setViewName("searchResult");
		return mav;
	}
	
	@GetMapping("/movie")
	public ModelAndView getMovieInfo(Movie movie, HttpSession session, ModelAndView mav) {
		System.out.println("/movie 실행");
		System.out.println("영화 상세정보 처리");
		
		String key = "KFI7VEXN1YPWR5EJLOD3";
		String movieId = movie.getMovieId();
		String movieSeq = movie.getMovieSeq();
		movie.setId((String)session.getAttribute("id"));
		
		try {
			URL url = new URL("https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey="+key+"&movieId="+movieId+"&movieSeq="+movieSeq);
			BufferedReader bfr;
			bfr=new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
			
			JSONParser jsonParser=new JSONParser();
			JSONObject jsonObject=(JSONObject)jsonParser.parse(bfr);
			
			JSONArray data=(JSONArray)jsonObject.get("Data");
			JSONObject result=(JSONObject)data.get(0);
			JSONArray searchResult=(JSONArray)result.get("Result");
			
			JSONObject movieInfo=(JSONObject)searchResult.get(0);
			
			String title=(String)movieInfo.get("title");
			title=title.replace("!HS", "");
			title=title.replace("!HE", "");
			title=title.replaceAll("  ", "");
			
			String posters=(String)movieInfo.get("posters");
			String[] posterList=posters.split("\\|");
			String poster=posterList[0];
			
			String rating=(String)movieInfo.get("rating");
			String genre=(String)movieInfo.get("genre");
			String runtime=(String)movieInfo.get("runtime");
			
			String repRlsDate=(String)movieInfo.get("repRlsDate");
			if(repRlsDate.length()>7) {
				SimpleDateFormat dtFormat=new SimpleDateFormat("yyyyMMdd");
				SimpleDateFormat newDtFormat=new SimpleDateFormat("yyyy-MM-dd");
				Date newDt=dtFormat.parse(repRlsDate);
				repRlsDate=newDtFormat.format(newDt);
			}
			
			JSONObject plots=(JSONObject)movieInfo.get("plots");
			JSONArray plot=(JSONArray)plots.get("plot");
			JSONObject plotData=(JSONObject)plot.get(0);
			String plotText=(String)plotData.get("plotText");
			
			String stlls=(String)movieInfo.get("stlls");
			String[] stllList=stlls.split("\\|");
			
			JSONObject staffs=(JSONObject)movieInfo.get("staffs");
			JSONArray staff=(JSONArray)staffs.get("staff");
			
			JSONArray staffList=new JSONArray();
			JSONArray actorList=new JSONArray();
			for (int i = 0; i < staff.size(); i++) {
				if(i<12) {
					JSONObject staffResult=(JSONObject)staff.get(i);
					if(staffResult.get("staffRoleGroup").equals("감독")||staffResult.get("staffRoleGroup").equals("원작")||staffResult.get("staffRoleGroup").equals("각본")){
						staffList.add(staffResult);
					}else if(staffResult.get("staffRoleGroup").equals("출연")) {
						actorList.add(staffResult);
					}else {
						continue;
					}
				}else {
					continue;
				}
			}
			
			JSONArray productionList=new JSONArray();
			JSONArray distributorList=new JSONArray();
			for (int i = 0; i < staff.size(); i++) {
				JSONObject staffResult=(JSONObject)staff.get(i);
				if(staffResult.get("staffRoleGroup").equals("제작사")) {
					productionList.add(staffResult);
				}else if(staffResult.get("staffRoleGroup").equals("배급사")){
					distributorList.add(staffResult);
				}else {
					continue;
				}
			}
			
			String nation=(String)movieInfo.get("nation");
			String msg="스틸컷이 없습니다.";
			
			mav.addObject("movieId", movieId);
			mav.addObject("movieSeq", movieSeq);
			mav.addObject("title", title);
			mav.addObject("poster", poster);
			mav.addObject("rating", rating);
			mav.addObject("genre", genre);
			mav.addObject("runtime", runtime);
			mav.addObject("repRlsDate", repRlsDate);
			mav.addObject("plotText", plotText);
			mav.addObject("stllList", stllList);
			mav.addObject("staffList", staffList);
			mav.addObject("actorList", actorList);
			mav.addObject("productionList", productionList);
			mav.addObject("distributorList", distributorList);
			mav.addObject("nation", nation);
			mav.addObject("msg", msg);

		}catch(Exception e) {
			e.printStackTrace();
		}
		
		System.out.println("getCommentList 실행");
		
		if(movie.getPage()==null) movie.setPage("1");
		
		mav.addObject("pg", movie.getPage());
		if(movie.getId()!=null) {
			mav.addObject("myComment", movieService.getComment(movie));
		}
		mav.addObject("commentList", movieService.getCommentList(movie));
		
		mav.setViewName("movieInfo");
		return mav;
	}
	
	@GetMapping("/boxOfficeList")
	public ModelAndView getBoxOfficeList(Movie movie, ModelAndView mav) {
		mav.setViewName("boxOfficeList");
		return mav;
	}
	
	@PostMapping("/insertComment")
	public ModelAndView insertComment(Movie movie, ModelAndView mav) {
		System.out.println("insertComment 실행");
		movieService.insertComment(movie);
		mav.setViewName("redirect:movie?movieId="+movie.getMovieId()+"&movieSeq="+movie.getMovieSeq());
		return mav;
	}
	
	@PostMapping("/updateComment")
	public ModelAndView updateComment(Movie movie, ModelAndView mav) {
		System.out.println("updateComment 실행");
		movieService.updateComment(movie);
		mav.setViewName("redirect:movie?movieId="+movie.getMovieId()+"&movieSeq="+movie.getMovieSeq());
		return mav;
	}
	
}
