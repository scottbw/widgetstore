//create an ajaxmanager for tracking / caching definition requests
var managedSlideShareDocuments = $.manageAjax.create('SlideshareDocuments', {
	cacheResponse: true,
	abortOld: true,
	maxRequests: 1,
	preventDoubleRequests: true
});

function keywords_find_slideshare_documents(query)
{
	var server = IWCdata["server"];
	var url = server + "SlideshareSearch/search?response=json&query="+escape(query)+"&resultCount="+"20";

	$.manageAjax.add('SlideshareDocuments', {
	  success: function(data) {
		keywords_find_slideshare_documents_callback(data); 
	  },
	  url: Widget.proxify(url)
	});

	$("#slideshare").empty(); //empty current document list
	//$("#slideshare").html("searching... (find documents)");
	setStatus("searching... (find slides)");
}

function keywords_find_slideshare_documents_callback(realData)
{
	//$("#slideshare").empty();
	delStatus();

	var data = realData["ns:searchResponse"];

	var count = 0;
	$("#slideshare").html("<ul style='padding-left:10px; margin-left:5px;'></ul>");

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
				$("#slideshare ul").append(li);
			}
		}
	}
	
	if (count == 0)
	{
		$("#slideshare").append("No SlideShare resources found.");	
	}	

	//open each link in a new window / tab
    $('#slideshare a[rel="external"]').click( function() {
        window.open( $(this).attr('href') );
        return false;
    });
}
