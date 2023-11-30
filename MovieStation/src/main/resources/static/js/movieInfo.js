$(function () {
	
		var scoreData=$("#scoreData").val();
		var starScore=Math.floor(scoreData*100)/100;
		$("#starScore").attr("value",starScore);
		
        $(".starpoint_box").addClass("checked");
        $(".label_star").each(function (i, o) {
            $(this).on("mouseover", function () {
                if($(".starpoint_box").hasClass("checked")===true){
                    var widthValue = (i + 1) * 10;
                    $(".starpoint_bg").css("width", widthValue + "%");
                }
            })
        
            $(this).on("click", function () {
                    var widthValue = (i + 1) * 10;
                    $(".starpoint_bg").css("width", widthValue + "%");
                    $(".starpoint_box").toggleClass("checked");
            })
        });
        
        $("#stil").mousewheel(function(event, delta) {
			this.scrollLeft -= (delta * 50);
			event.preventDefault();
		})
});

function updateComment(){
	$("#myComment").css("display","none");
	$("#updateComment").css("display","block");
}
