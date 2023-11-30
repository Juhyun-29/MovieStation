$(function(){
      var kobisKey="31ef183abb64add094f000aefb37f2dd";
      var kmdbKey="KFI7VEXN1YPWR5EJLOD3";
      
      var today=new Date();
      var yesterday=new Date(today.setDate(today.getDate()-1));
      var date=yesterday.toISOString().substring(0,10).replace(/-/g,'');
      
      var dailyHeader="<a><b>일일 박스오피스</b></a>&nbsp;&nbsp;<span>"+date.substr(0,4)+"년 "+(date.substr(4,2)).replace(/(^0+)/,'')+"월 "+(date.substr(6)).replace(/(^0+)/,'')+"일</span>"
      $("#dailyHeader").append(dailyHeader);
      
      $.ajax({
         type: "GET",
         url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="+kobisKey+"&targetDt="+date,
         success: function(response){
            var dailyBoxOffice=response["boxOfficeResult"]["dailyBoxOfficeList"];
            for(var i=0;i<dailyBoxOffice.length;i++){
               var rank=dailyBoxOffice[i].rank;
               var movieNm=dailyBoxOffice[i].movieNm;
               var openDt=dailyBoxOffice[i].openDt;
               
               var releaseDts=openDt.replace(/-/g,"");
               
               var audiCntData=parseInt(dailyBoxOffice[i].audiCnt);
               var audiIntenData=parseInt(dailyBoxOffice[i].audiInten);
               var audiAccData=parseInt(dailyBoxOffice[i].audiAcc);
               var scrnCntData=parseInt(dailyBoxOffice[i].scrnCnt);
               var showCntData=parseInt(dailyBoxOffice[i].showCnt);
               
               var audiCnt=audiCntData.toLocaleString();
               var audiInten=audiIntenData.toLocaleString();
               var audiAcc=audiAccData.toLocaleString();
               var scrnCnt=scrnCntData.toLocaleString();
               var showCnt=showCntData.toLocaleString();
               
               dailyInfo(rank,movieNm,openDt,releaseDts,audiCnt,audiInten,audiAcc,scrnCnt,showCnt);  
				
            }
         }
      })
      
      function dailyInfo(rank,movieNm,openDt,releaseDts,audiCnt,audiInten,audiAcc,scrnCnt,showCnt){        
          $.ajax({
                  type: "GET",
                  url: "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey="+kmdbKey+"&title="+movieNm+"&releaseDts="+releaseDts+"&sort=prodYear,1",
                  async: false, // ajax로 먼저 가져온 박스오피스 데이터를 기반으로 success를 처리해야 하므로 동기식으로 처리
                  success: function(response){
                  var kmdb=JSON.parse(response);
                  var results=kmdb.Data[0].Result;
                  
                  	if(results==null){
                  		console.log(movieNm+"의 검색 결과가 없습니다. JSON 데이터를 확인해보세요.");
                  	}else{
                  		for(var i=0; i<results.length;i++){
                  			if(results[i].genre=="에로"||results[i].genre==""||results[i].use!="극장용"||results[i].repRlsDate!=releaseDts){
                  				continue;
                  			}else{
                  				var movieId=results[i].movieId;
                  				var movieSeq=results[i].movieSeq;
                  		
                  				break;
                  			}
                  		}
                  		
                  		var dailyBoxOfficeRank="<tr>"
               			+"<td>"+rank+"위</td>"
						+"<td><a href=javascript:movieInfo('"+movieId+"','"+movieSeq+"')>"+movieNm+"</a></td>"
						+"<td>"+openDt+"</td>"
						+"<td>"+audiCnt+"명</td>"
						+"<td class='desktopOnly'>"+audiInten+"명</td>"
						+"<td>"+audiAcc+"명</td>"
						+"<td class='desktopOnly'>"+scrnCnt+"개</td>"
						+"<td class='desktopOnly'>"+showCnt+"회</td>"
						+"</tr>";
						
						$("#dailyBoxOfficeList").append(dailyBoxOfficeRank);   
                  	}
                  }
               })    
   	 }
      
      var weekday=new Date(today.setDate(today.getDate()-5));
      var weekdate=weekday.toISOString().substring(0,10).replace(/-/g,'');
      
      $.ajax({
         type: "GET",
         url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key="+kobisKey+"&targetDt="+weekdate,
         success: function(response){
            var weekendBoxOffice=response["boxOfficeResult"]["weeklyBoxOfficeList"];
            
            var weekendRange=response["boxOfficeResult"].showRange;
            var weekend=weekendRange.substr(0,4)+"-"+weekendRange.substr(4,2)+"-"+weekendRange.substr(6,2)+"~"+weekendRange.substr(9,4)+"-"+weekendRange.substr(13,2)+"-"+weekendRange.substr(15,2);
            var yearWeekTime=response["boxOfficeResult"].yearWeekTime;
            var yearWeek=yearWeekTime.substr(0,4)+"년&nbsp;"+(yearWeekTime.substr(4,2)).replace(/(^0+)/,'')+"주차"
            
            var weekendHeader="<a><b>주말 박스오피스</b></a>&nbsp;&nbsp;<span>"+yearWeek+"("+weekend+")</span>"
      		$("#weekendHeader").append(weekendHeader);
            
            for(var i=0;i<weekendBoxOffice.length;i++){
               var rank=weekendBoxOffice[i].rank;
               var movieNm=weekendBoxOffice[i].movieNm;
               var openDt=weekendBoxOffice[i].openDt;
               
               var releaseDts=openDt.replace(/-/g,"");
               
               var audiCntData=parseInt(weekendBoxOffice[i].audiCnt);
               var audiIntenData=parseInt(weekendBoxOffice[i].audiInten);
               var audiAccData=parseInt(weekendBoxOffice[i].audiAcc);
               var scrnCntData=parseInt(weekendBoxOffice[i].scrnCnt);
               var showCntData=parseInt(weekendBoxOffice[i].showCnt);
               
               var audiCnt=audiCntData.toLocaleString();
               var audiInten=audiIntenData.toLocaleString();
               var audiAcc=audiAccData.toLocaleString();
               var scrnCnt=scrnCntData.toLocaleString();
               var showCnt=showCntData.toLocaleString();
               
               weekendInfo(rank,movieNm,openDt,releaseDts,audiCnt,audiInten,audiAcc,scrnCnt,showCnt);  
               
            }
         }
      })
      
      function weekendInfo(rank,movieNm,openDt,releaseDts,audiCnt,audiInten,audiAcc,scrnCnt,showCnt){        
          $.ajax({
                  type: "GET",
                  url: "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey="+kmdbKey+"&title="+movieNm+"&releaseDts="+releaseDts+"&sort=prodYear,1",
                  async: false, // ajax로 먼저 가져온 박스오피스 데이터를 기반으로 success를 처리해야 하므로 동기식으로 처리
                  success: function(response){
                  var kmdb=JSON.parse(response);
                  var results=kmdb.Data[0].Result;
                  
                  	if(results==null){
                  		console.log(movieNm+"의 검색 결과가 없습니다. JSON 데이터를 확인해보세요.");
                  	}else{
                  		for(var i=0; i<results.length;i++){
                  			if(results[i].genre=="에로"||results[i].genre==""||results[i].use!="극장용"||results[i].repRlsDate!=releaseDts){
                  				continue;
                  			}else{
                  				var movieId=results[i].movieId;
                  				var movieSeq=results[i].movieSeq;
                  		
                  				break;
                  			}
                  		}
						
						var weekendBoxOfficeRank="<tr>"
               			+"<td>"+rank+"위</td>"
						+"<td><a href=javascript:movieInfo('"+movieId+"','"+movieSeq+"')>"+movieNm+"</a></td>"
						+"<td>"+openDt+"</td>"
						+"<td>"+audiCnt+"명</td>"
						+"<td class='desktopOnly'>"+audiInten+"명</td>"
						+"<td>"+audiAcc+"명</td>"
						+"<td class='desktopOnly'>"+scrnCnt+"개</td>"
						+"<td class='desktopOnly'>"+showCnt+"회</td>"
						+"</tr>";
						
						$("#weekendBoxOfficeList").append(weekendBoxOfficeRank);
                  	}
                  }
               })    
   	 }
      
      $.ajax({
         type: "GET",
         url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key="+kobisKey+"&targetDt="+weekdate+"&weekGb=0",
         success: function(response){
            var weeklyBoxOffice=response["boxOfficeResult"]["weeklyBoxOfficeList"];
            
            var weeklyRange=response["boxOfficeResult"].showRange;
            var weekly=weeklyRange.substr(0,4)+"-"+weeklyRange.substr(4,2)+"-"+weeklyRange.substr(6,2)+"~"+weeklyRange.substr(9,4)+"-"+weeklyRange.substr(13,2)+"-"+weeklyRange.substr(15,2);
            var yearWeekTime=response["boxOfficeResult"].yearWeekTime;
            var yearWeek=yearWeekTime.substr(0,4)+"년&nbsp;"+(yearWeekTime.substr(4,2)).replace(/(^0+)/,'')+"주차"
            
            var weeklyHeader="<a><b>주간 박스오피스</b></a>&nbsp;&nbsp;<span>"+yearWeek+"("+weekly+")</span>"
      		$("#weeklyHeader").append(weeklyHeader);
            
            for(var i=0;i<weeklyBoxOffice.length;i++){
               var rank=weeklyBoxOffice[i].rank;
               var movieNm=weeklyBoxOffice[i].movieNm;
               var openDt=weeklyBoxOffice[i].openDt;
               
               var releaseDts=openDt.replace(/-/g,"");
               
               var audiCntData=parseInt(weeklyBoxOffice[i].audiCnt);
               var audiIntenData=parseInt(weeklyBoxOffice[i].audiInten);
               var audiAccData=parseInt(weeklyBoxOffice[i].audiAcc);
               var scrnCntData=parseInt(weeklyBoxOffice[i].scrnCnt);
               var showCntData=parseInt(weeklyBoxOffice[i].showCnt);
               
               var audiCnt=audiCntData.toLocaleString();
               var audiInten=audiIntenData.toLocaleString();
               var audiAcc=audiAccData.toLocaleString();
               var scrnCnt=scrnCntData.toLocaleString();
               var showCnt=showCntData.toLocaleString();
               
               weeklyInfo(rank,movieNm,openDt,releaseDts,audiCnt,audiInten,audiAcc,scrnCnt,showCnt);
               
            }
         }
      })
     
     function weeklyInfo(rank,movieNm,openDt,releaseDts,audiCnt,audiInten,audiAcc,scrnCnt,showCnt){        
          $.ajax({
                  type: "GET",
                  url: "https://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey="+kmdbKey+"&title="+movieNm+"&releaseDts="+releaseDts+"&sort=prodYear,1",
                  async: false, // ajax로 먼저 가져온 박스오피스 데이터를 기반으로 success를 처리해야 하므로 동기식으로 처리
                  success: function(response){
                  var kmdb=JSON.parse(response);
                  var results=kmdb.Data[0].Result;
                  
                  	if(results==null){
                  		console.log(movieNm+"의 검색 결과가 없습니다. JSON 데이터를 확인해보세요.");
                  	}else{
                  		for(var i=0; i<results.length;i++){
                  			if(results[i].genre=="에로"||results[i].genre==""||results[i].use!="극장용"||results[i].repRlsDate!=releaseDts){
                  				continue;
                  			}else{
                  				var movieId=results[i].movieId;
                  				var movieSeq=results[i].movieSeq;
                  		
                  				break;
                  			}
                  		}
						
						var weeklyBoxOfficeRank="<tr>"
               			+"<td>"+rank+"위</td>"
						+"<td><a href=javascript:movieInfo('"+movieId+"','"+movieSeq+"')>"+movieNm+"</a></td>"
						+"<td>"+openDt+"</td>"
						+"<td>"+audiCnt+"명</td>"
						+"<td class='desktopOnly'>"+audiInten+"명</td>"
						+"<td>"+audiAcc+"명</td>"
						+"<td class='desktopOnly'>"+scrnCnt+"개</td>"
						+"<td class='desktopOnly'>"+showCnt+"회</td>"
						+"</tr>";
						
						$("#weeklyBoxOfficeList").append(weeklyBoxOfficeRank); 
                  	}
                  }
               })    
   	 }
     
     
     document.cookie = "safeCookie1=foo; SameSite=Lax"; 
	 document.cookie = "safeCookie2=foo"; 
	 document.cookie = "crossCookie=bar; SameSite=None; Secure";
})

function movieInfo(movieId,movieSeq){
		var form=document.createElement('form');
		
		var id;
		id=document.createElement('input');
		id.setAttribute('type','hidden');
		id.setAttribute('name','movieId');
		id.setAttribute('value',movieId);
		
		var seq;
		seq=document.createElement('input');
		seq.setAttribute('type','hidden');
		seq.setAttribute('name','movieSeq');
		seq.setAttribute('value',movieSeq);
		
		form.appendChild(id);
		form.appendChild(seq);
		form.setAttribute('method','post');
		form.setAttribute('action','movie');
		document.body.appendChild(form);
		form.submit();
} 