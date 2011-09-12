//create an ajaxmanager for tracking / caching definition requests
var managedYoutubeDocuments = $.manageAjax.create('YoutubeDocuments', {
	cacheResponse: true,
	abortOld: true,
	maxRequests: 1,
	preventDoubleRequests: true
});

function keywords_find_youtube_documents(query)
{
	var server = IWCdata["server"];
	var url = server + "YoutubeSearch/search?response=json&query="+escape(query)+"&resultCount="+"20";

	$.manageAjax.add('YoutubeDocuments', {
	  success: function(data) {
		keywords_find_youtube_documents_callback(data); 
	  },
	  url: Widget.proxify(url)
	});

	$("#youtube").empty(); //empty current document list
	//$("#youtube").html("searching... (find documents)");
	setStatus("Searching... (find videos)");
}

function keywords_find_youtube_documents_callback(realData)
{
	//$("#documents").empty();
	delStatus();

	var data = realData["ns:searchResponse"];

	var count = 0;
	$("#youtube").html("<ul style='padding-left:10px; margin-left:5px;'></ul>");

	for(var item in data)
	{
		if (item != "@xmlns")
		{
			var itemData = data[item];
			
			//add tags as a title element to each document
			var li = "<li> <a rel=\"external\" title=\""; 
			li += itemData[2]["$"];
			
			if (itemData[1]["$"] != undefined)
			{
				count++;
				li += "\" href=\"" + itemData[1]["$"] + "\">" + itemData[0]["$"].replace(/"/g,'') + "</li>";	
				$("#youtube ul").append(li);
			}
		}
	}
	
	if (count == 0)
	{
		$("#youtube").append("No YouTube resources found.");	
	}	

	//open each link in a new window / tab
    $('#youtube a[rel="external"]').click( function() {
        window.open( $(this).attr('href') );
        return false;
    });
}
