$(function(){
      var kobisKey="31ef183abb64add094f000aefb37f2dd";
      var tmdbKey="c3ecba5b01a149b9314ef1c7e5b23bb8";
      var kmdbKey="KFI7VEXN1YPWR5EJLOD3";
      var today=new Date();
      var yesterday=new Date(today.setDate(today.getDate()-1));
      var date=yesterday.toISOString().substring(0,10).replace(/-/g,'');
      
      $.ajax({
         type: "GET",
         url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="+kobisKey+"&targetDt="+date,

         success: function(response){
            var dailyBoxOffice=response["boxOfficeResult"]["dailyBoxOfficeList"];
            var firstMovieNm=dailyBoxOffice[0].movieNm;
            boxOfficeFirst(firstMovieNm);
            for(var i=0;i<dailyBoxOffice.length;i++){
               var movieNm=dailyBoxOffice[i].movieNm;
               var openDt=dailyBoxOffice[i].openDt;
               var releaseDts=openDt.replace(/-/g,"");
                    
               boxOfficeInfo(movieNm,releaseDts);
            }
            upcomingList();
         }
      })
      
      function boxOfficeFirst(firstMovieNm){          
          $.ajax({
                  type: "GET",
                  url: "https://api.themoviedb.org/3/search/movie?api_key="+tmdbKey+"&language=ko-KR&query="+firstMovieNm,
                  success: function(response){
                  var results=response["results"];
                  var movieId=results[0].id;
                  var movieNm=results[0].title;
                  var overviewData=results[0].overview;
                  
                  firstVideo(movieId);
                  
                  var title="<h1>"+movieNm+"</h1>";
                  $("#title").append(title);
                  
                  firstInfo(movieNm);
                  
                  var overview=overviewData
                  $("#overview").append(overview);
                  
                  }
               })    
   	 }
      
      function firstVideo(movieId){          
          $.ajax({
                  type: "GET",
                  url: "https://api.themoviedb.org/3/movie/"+movieId+"/videos?api_key="+tmdbKey+"&language=ko-KR",
                  success: function(response){
                  var results=response["results"];
                  
                  for(var i=0;i<results.length;i++){
                	  if(results[i].type=="Trailer"){
                		  var videoId=results[i].key;
                		  
                		  var video='<iframe class="video"'
                           	  +'src="https://www.youtube-nocookie.com/embed/'+videoId+'?autoplay=1'
                              +'&mute=1&loop=1&modestbranding=1&playlist='+videoId+'&controls=0&cc_load_policy=0"'
                              +'frameBorder="0" allow="accelerometer; autoPlay; clipboard-write;'
                              +'encrypted-media; gyroscope; picture-in-picture" allowFullScreen/>'

                          $(".video-box").append(video);
                          break;
                	  	}
                  	 }
                  }
               })    
   	 }
      
      function firstInfo(movieNm){        
          $.ajax({
                  type: "GET",
                  url: "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey="+kmdbKey+"&title="+movieNm+"&sort=prodYear,1",
                  success: function(response){
                  var kmdb=JSON.parse(response);
                  var results=kmdb.Data[0].Result;
                  
                  var movieList=[];
                  
                  for(var i=0; i<results.length;i++){
                  	if(results[i].genre=="에로"||results[i].genre==""||results[i].use!="극장용"){
                  		continue;
                  	}else{
                  		movieList.push(results[i]);
                  	}
                  }
                  
                  var ratingData=movieList[0].rating;
                  var releaseData=movieList[0].repRlsDate;
                  var repRlsDate=releaseData.substr(0,4)+"-"+releaseData.substr(4,2)+"-"+releaseData.substr(6);
                  var genreData=movieList[0].genre;
                  var runtimeData=movieList[0].runtime;
                  var movieId=movieList[0].movieId;
                  var movieSeq=movieList[0].movieSeq;
                  
                  var rating="<a>"+ratingData+"</a>";
                  $("#rating").append(rating);
                  
                  var release="<a>"+repRlsDate+"</a>"
                  $("#release").append(release);
                  
                  var genre="<a>"+genreData+"</a>";
                  $("#genres").append(genre);
                  
                  var runtime="<a>"+runtimeData+"분</a>";
                  $("#runtime").append(runtime);
                  
                  var firstInfo="<a href=movie?movieId="+movieId+"&movieSeq="+movieSeq+"><b>상세정보</b></a>"
                  $("#firstInfo").append(firstInfo);
                  
                  }
               })    
   	 }
      
      function boxOfficeInfo(movieNm,releaseDts){        
          $.ajax({
                  type: "GET",
                  url: "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey="+kmdbKey+"&title="+movieNm+"&releaseDts="+releaseDts+"&sort=prodYear,1",
                  async: false, // ajax로 먼저 가져온 박스오피스 데이터를 기반으로 success를 처리해야 하므로 동기식으로 처리
                  success: function(response){
                  var kmdb=JSON.parse(response);
                  var results=kmdb.Data[0].Result;
                  
                  for(var i=0; i<results.length;i++){
                  	if(results[i].genre=="에로"||results[i].genre==""||results[i].use!="극장용"||results[i].repRlsDate!=releaseDts){
                  		continue;
                  	}else{
                  		var movieId=results[i].movieId;
                  		var movieSeq=results[i].movieSeq;
                  		var posterList=results[i].posters;
                  		break;
                  	}
                  }
                  
                  if(posterList==null){
					  console.log(movieNm+"의 포스터가 KMDB에 없습니다.");
				  }else{
					 	if(posterList.includes("|")){
                  			var posterArr=posterList.split("|");
                 			var firstPoster=posterArr[0];
                  			var poster="<div class='movieImg'><a href=movie?movieId="+movieId+"&movieSeq="+movieSeq+"><img alt='포스터' src="+firstPoster+"></a></div>";
                  			var boxOffice10=poster;
                  			$("#boxOffice10").append(boxOffice10);
                  		}else if(!posterList.includes("|")){
                  			var firstPoster=posterList;
                  			var poster="<div class='movieImg'><a href=movie?movieId="+movieId+"&movieSeq="+movieSeq+"><img alt='포스터' src="+firstPoster+"></a></div>";
                  			var boxOffice10=poster;
                  			$("#boxOffice10").append(boxOffice10);
                  		}
				  }
                  
                  
                  }
               })    
   	 }
      
   	 
     function upcomingList(){
    	 $.ajax({
             type: "GET",
             url: "https://api.themoviedb.org/3/movie/upcoming?api_key="+tmdbKey+"&language=ko-KR&region=KR",
             success: function(response){
                var results=response["results"];
                for(var i=0;i<results.length;i++){
                	   var movieNm=results[i].title;
                	   var releaseDate=results[i].release_date;
               		   var releaseDts=releaseDate.replace(/-/g,"");
               		   
                	   upcomingInfo(movieNm,releaseDts);
                }
             }
          })  
     }
     
   	 function upcomingInfo(movieNm,releaseDts){        
          $.ajax({
                  type: "GET",
                  url: "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey="+kmdbKey+"&title="+movieNm+"&releaseDts="+releaseDts+"&sort=prodYear,1",
                  async: false, // ajax로 먼저 가져온 박스오피스 데이터를 기반으로 success를 처리해야 하므로 동기식으로 처리
                  success: function(response){
                  var kmdb=JSON.parse(response);
                  var results=kmdb.Data[0].Result;
                  
                  	if(results==null){
                  		console.log(movieNm+"은 KMDB에 없는 영화입니다.");
                  	}else{
                  		for(var i=0; i<results.length;i++){
                  			if(results[i].genre=="에로"||results[i].genre==""||results[i].use!="극장용"||results[i].repRlsDate!=releaseDts){
                  				continue;
                  			}else{
                  				var movieId=results[i].movieId;
                  				var movieSeq=results[i].movieSeq;
                  				var posterList=results[i].posters;
                  		
                  				break;
                  			}
                  		}
                  		if(posterList==null){
							  console.log(movieNm+"의 포스터가 KMDB에 없습니다.");
						}else{
							if(posterList.includes("|")){
                  				var posterArr=posterList.split("|");
                  				var firstPoster=posterArr[0];
                  				var poster="<div class='movieImg'><a href=movie?movieId="+movieId+"&movieSeq="+movieSeq+"><img onerror=this.style.display='none' alt='포스터' src="+firstPoster+"></a></div>";
                  				var upcoming=poster;
                  				$("#upcoming").append(upcoming);
                  			}else if(!posterList.includes("|")){
                  				var firstPoster=posterList;
                  				var poster="<div class='movieImg'><a href=movie?movieId="+movieId+"&movieSeq="+movieSeq+"><img onerror=this.style.display='none' alt='포스터' src="+firstPoster+"></a></div>";
                  				var upcoming=poster;
                  				$("#upcoming").append(upcoming);
                  			}
						}
                  		
                  	}
                  }
               })    
   	 }
     
     document.cookie = "safeCookie1=foo; SameSite=Lax"; 
	 document.cookie = "safeCookie2=foo"; 
	 document.cookie = "crossCookie=bar; SameSite=None; Secure";
})     