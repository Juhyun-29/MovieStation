	
$(function(){	
	$(".link1").click(function(){
          $(".link2_content").hide();
          $(".link2").removeClass("active");
          $(".link3_content").hide();
          $(".link3").removeClass("active");
          $(".link4_content").hide();
          $(".link4").removeClass("active");
          $(".link5_content").hide();
          $(".link5").removeClass("active");
          $(".link1_content").show();
          $(".link1").addClass("active");
      });
      $(".link2").click(function(){
    	  $(".link1_content").hide();
          $(".link1").removeClass("active");
          $(".link3_content").hide();
          $(".link3").removeClass("active");
          $(".link4_content").hide();
          $(".link4").removeClass("active");
          $(".link5_content").hide();
          $(".link5").removeClass("active");
          $(".link2_content").show();
          $(".link2").addClass("active");
      });
      $(".link3").click(function(){
          $(".link1_content").hide();
          $(".link1").removeClass("active");
          $(".link2_content").hide();
          $(".link2").removeClass("active");
          $(".link4_content").hide();
          $(".link4").removeClass("active");
          $(".link5_content").hide();
          $(".link5").removeClass("active");
          $(".link3_content").show();
          $(".link3").addClass("active");
      });
      $(".link4").click(function(){
          $(".link1_content").hide();
          $(".link1").removeClass("active");
          $(".link2_content").hide();
          $(".link2").removeClass("active");
          $(".link3_content").hide();
          $(".link3").removeClass("active");
          $(".link5_content").hide();
          $(".link5").removeClass("active");
          $(".link4_content").show();
          $(".link4").addClass("active");
      });
      $(".link5").click(function(){
          $(".link1_content").hide();
          $(".link1").removeClass("active");
          $(".link2_content").hide();
          $(".link2").removeClass("active");
          $(".link3_content").hide();
          $(".link3").removeClass("active");
          $(".link4_content").hide();
          $(".link4").removeClass("active");
          $(".link5_content").show();
          $(".link5").addClass("active");
      });
})