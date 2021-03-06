function clickSearch(keyword) {
		$('#searchModalInput').val(keyword);

}

$(function() {

timer = setInterval( function () {

    $.ajax({
    	url: '/search/popular',
    	dataType:"JSON",
    	method: 'GET',
    	success: function (data) {
        	console.log("인기 검색어 데이터")
        	console.log(data);
        	$('.search-rank-one').remove();
        	for(let i=0; i<data.length;i++){
				let str = `
					<div class="search-rank-one" >
                		 <span class="search-rank-num">${i+1}</span>
                		 <span class="search-rank-word" id="${i+1}+${data[i].keyword}">${data[i].keyword}</span>
            		</div>
				`
	        if(i<5){
	        	$('.search-rank-left').append(str);
				$('#'+(i+1)+(data[i].keyword)).on("click",function () {
					$('#searchModalInput').val(data[i].keyword);
				})
			}else{
				$('.search-rank-right').append(str);
				$('#'+(i+1)+(data[i].keyword)).on("click",function () {
					$('#searchModalInput').val(data[i].keyword);
				})
			}
		}
    }
});

    }, 600000);

});

$('#search-button').on('click',function(){
	let keyword = $('#searchModalInput').val();
	keyword = keyword.trim();
	let name = keyword;
	console.log(keyword);
	if(keyword == '')
		return;
	$.ajax({
    	url: '/search/'+keyword,
    	dataType:"JSON",
    	method: 'POST',
    	success: function (data) {
       		console.log("키워드 등록")
        	console.log(data);
    	}
	});

	$('#searchModalInput').val("");

	location.href='/search/search?keyword='+keyword;
});

