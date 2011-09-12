$(document).ready(function() {

	var hashedUNS = $('#hashedUNS').text();
	hashedUNS = encodeURIComponent(hashedUNS);
	var uname = $('#userName').text();
	var widid = $('#widgetID').text();
	
	
	console.log('ur declared');
	function updateRating(username,newValue){
		console.log('Got in updateRating');
		console.log('uname='+username);
		console.log('val='+newValue);
	}
	console.log('ur declared end');
	
	
	
	// handler when new comment is entered
	$('#newCommentSubmit').click(function() {
		var commentText = $('#newCommentText').val();
		
		dataString="commentText="+commentText+"&hashedUNS="+hashedUNS+"&widgetid="+widid;
		$.ajax({
			type: 'POST',
			url : '/wookie/webmenu/ajaxHandlers/addComment.jsp?',
			data : dataString,
			success : function(m) {
				console.log('Done. Got back:' + m);
				if (m=="Success") {
					
				}
			},
			error : function(m, n) {
				console.log('error' + m + n);
			},
			complete : function(m) {
				console.log('complete'+m);
			}
		});
	});
	
	$('#addTagsBtn').click(function(){
		
		$(this).hide();		
		$('#tagSuggestInput').show();//css("display","block");
		$('#addTagsSubmitBtn').show();
		$('#tagSuggestInput').focus();
		$('#tagSuggestInput').tagSuggest({url:"../webmenu/ajaxHandlers/tagSuggestions.jsp","widgetid":widid});
		
		$('#addTagsSubmitBtn').click(function(){
			var tagSuggestInput = $('#tagSuggestInput').val();
			var dataString="uname="+uname+"&tagsText="+tagSuggestInput+"&widid="+widid;
			$.ajax({
				type: 'POST',
				url : '/wookie/webmenu/ajaxHandlers/addTags.jsp?',
				data : dataString,
				success : function(m) {
					console.log('Done. Got back:' + m);
					if (m.substring(0,6)=="SUCCESS") {
						newTags = m.split(":");
						for (i=1 ; i<newTags.length ; i++) {
							//start from the 2nd - first is SUCCESS
							console.log(newTags[i]);
						}
					}
				},
				error : function(m, n) {
					console.log('error' + m + n);
				},
				complete : function(m) {
					console.log('complete'+m);
				}
			});
		});		
	});
});