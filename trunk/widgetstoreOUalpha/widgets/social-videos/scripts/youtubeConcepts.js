//create an ajaxmanager for tracking / caching definition requests
var managedYoutubeConceptsDocuments = $.manageAjax.create('YoutubeConceptsDocuments', {
	cacheResponse: true,
	abortOld: true,
	maxRequests: 1,
	preventDoubleRequests: true
});

function keywords_find_youtubeConcepts_documents(query, context, lang)
{
	var server = IWCdata["server"];
	var url = server + "YoutubeSearch/smartSearch?response=json&query="+escape(query)+"&context="+context+"&lang="+escape(lang)+"&resultCount="+"20";

	$.manageAjax.add('YoutubeConceptsDocuments', {
	  success: function(data) {
		keywords_find_youtubeConcepts_documents_callback(data); 
	  },
	  url: Widget.proxify(url)
	});

	//$("#youtube").append("<div class=\"filterstatus\">Trying to filter...</div>");
	setStatus("Trying to filter...");

}

function keywords_find_youtubeConcepts_documents_callback(realData)
{
	var data = realData["ns:smartSearchResponse"];
	var count = 0;

	//iterate over all the original youtube concepts
	$("#youtube li").each(function() {
		var original_url = $(this).find("a").attr("href");	
	
		var found = false;
	
		for(var item in data)
		{
			if (item != "@xmlns")
			{
				count++;
				var itemData = data[item];
				
				//add tags as a title element to each document
				var li = "<li> <a rel=\"external\" title=\"" + itemData[2]["$"] + ", ";
	
				var url = itemData[1]["$"];

				if (url == original_url) found = true;

				/*
				if (itemData[1]["$"] != undefined)
				{
					li += "\" href=\"" + itemData[1]["$"] + "\">" + itemData[0]["$"].replace(/"/g,'') + "</li>";	
					$("#youtubeConcepts ul").append(li);
				}
				*/
			}
		}
	
		if (!found)
		{
			$(this).find("a").css("color","gray")
		}
	});
	
	
	//iterate over all the original youtube concepts
	for(var item in data)
	{
		if (item != "@xmlns")
		{
			var found = false;

			count++;
			var itemData = data[item];
			
			//add tags as a title element to each document
			var li = "<li> <a rel=\"external\" title=\"" + itemData[2]["$"] + ", ";
			var url = itemData[1]["$"];

			$("#youtube li").each(function() {
				var original_url = $(this).find("a").attr("href");	
				if (url == original_url) found = true;
			});

			if (itemData[1]["$"] != undefined && !found)
			{
				li += "\" href=\"" + itemData[1]["$"] + "\">" + itemData[0]["$"].replace(/"/g,'') + "</li>";	
				$("#youtube ul").append(li);
			}
		}
	}

	//$("#youtube .filterStatus").remove();
	delStatus();

	//open each link in a new window / tab
    $('#youtube a[rel="external"]').unbind("click");
    $('#youtube a[rel="external"]').click( function() {
        window.open( $(this).attr('href') );
        return false;
    });



}
