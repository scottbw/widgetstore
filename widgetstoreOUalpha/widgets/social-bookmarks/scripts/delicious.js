//create an ajaxmanager for tracking / caching definition requests
var managedDeliciousDocuments = $.manageAjax.create('DeliciousDocuments', {
	cacheResponse: true,
	abortOld: true,
	maxRequests: 1,
	preventDoubleRequests: true
});

function find_delicious_documents(concept_uri)
{
	var concept = IWCdata["concept"]; //escape(unescapeURI(concept_uri));
	var context = IWCdata["context"]; //escape($.query.get("context"));
	var language = IWCdata["lang"]; //$("#language").val();
	var server = IWCdata["server"];

	var url = server + "DeliciousSearch/searchConcept?response=json&concept="+concept+"&context=" + context + "&lang="+language + "&resultCount="+"20";

	$.manageAjax.add('DeliciousDocuments', {
	  success: function(data) {
		find_delicious_documents_callback(data); 
	  },
	  url: Widget.proxify(url)
	});

	$("#delicious").empty(); //empty current document list
	//$("#delicious").html("searching... (find documents)");
	setStatus("searching... (find bookmarks)");
}

function keywords_find_delicious_documents(query)
{
	var server = IWCdata["server"];
	var url = server + "DeliciousSearch/search?response=json&tag="+escape(query)+"&resultCount="+"20";

	$.manageAjax.add('DeliciousDocuments', {
	  success: function(data) {
		keywords_find_delicious_documents_callback(data); 
	  },
	  url: Widget.proxify(url)
	});

	$("#delicious").empty(); //empty current document list
	//$("#delicious").html("searching... (find documents)");
	setStatus("searching... (find bookmarks)");
}

function keywords_find_delicious_documents_callback(realData)
{
	//$("#documents").empty();
	delStatus();

	var data = realData["ns:searchResponse"];

	var count = 0;
	$("#delicious").html("<ul style='padding-left:10px; margin-left:5px;'></ul>");

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
				li += "\" href=\"" + itemData[0]["$"] + "\">" + itemData[1]["$"].replace(/"/g,"") + "</li>";	
				$("#delicious ul").append(li);
			}
		}
	}

	if (count == 0)
	{
		$("#delicious").append("No Delicious resources found.");	
	}	

	//open each link in a new window / tab
    $('a[rel="external"]').click( function() {
        window.open( $(this).attr('href') );
        return false;
    });
}


function find_delicious_documents_callback(realData)
{
	//$("#documents").empty();
	delStatus();

	var data = realData["ns:searchConceptResponse"];

	var count = 0;
	$("#delicious").html("<ul style='padding-left:10px; margin-left:5px;'></ul>");

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
				li += "\" href=\"" + itemData[0]["$"] + "\">" + itemData[1]["$"].replace(/"/g,"") + "</li>";	
				$("#delicious ul").append(li);
			}
		}
	}
	
	if (count == 0)
	{
		$("#delicious").append("No Delicious resources found.");	
	}	

	//open each link in a new window / tab
    $('#delicious a[rel="external"]').click( function() {
        window.open( $(this).attr('href') );
        return false;
    });
}
