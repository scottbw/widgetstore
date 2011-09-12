//create an ajaxmanager for tracking / caching definition requests
var managedBibsonomyDocuments = $.manageAjax.create('BibsonomyDocuments', {
	cacheResponse: true,
	abortOld: true,
	maxRequests: 1,
	preventDoubleRequests: true
});

function keywords_find_bibsonomy_documents(query)
{
	var server = IWCdata["server"];
	var url = server + "BibsonomySearch/search?response=json&query="+escape(query)+"&resultCount="+"20";

	$.manageAjax.add('BibsonomyDocuments', {
	  success: function(data) {
		keywords_find_bibsonomy_documents_callback(data); 
	  },
	  url: Widget.proxify(url)
	});

	$("#bibsonomy").empty(); //empty current document list
	//$("#bibsonomy").html("searching... (find documents)");
	setStatus("searching... (find scientific papers)");
}

function keywords_find_bibsonomy_documents_callback(realData)
{
	//$("#bibsonomy").empty();
	delStatus();

	var data = realData["ns:searchResponse"];

	var count = 0;
	$("#bibsonomy").html("<ul style='padding-left:10px; margin-left:5px;'></ul>");

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
				$("#bibsonomy ul").append(li);
			}
		}
	}
	
	if (count == 0)
	{
		$("#bibsonomy").append("No BibSonomy resources found.");	
	}	

	//open each link in a new window / tab
    $('#bibsonomy a[rel="external"]').click( function() {
        window.open( $(this).attr('href') );
        return false;
    });
}
