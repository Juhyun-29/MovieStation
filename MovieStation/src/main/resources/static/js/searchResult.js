$(function(){

	var urlParams=new URL(location.href).searchParams;
	var searchType=urlParams.get('searchType');

	$("#searchType").val(searchType).prop("selected",true);
	
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