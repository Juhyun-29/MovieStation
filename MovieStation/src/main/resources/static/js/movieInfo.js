$(function () {
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
});

function updateComment(){
	$("#myComment").css("display","none");
	$("#updateComment").css("display","block");
}

/*function deleteComment(){
	myComment.method = "post";
	myComment.action = "/deleteComment";
	myComment.submit();
}*/
