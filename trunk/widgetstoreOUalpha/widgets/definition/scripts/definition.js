//create an ajaxmanager for tracking / caching definition requests
var managedAjaxDefinitions = $.manageAjax.create('AjaxDefinition', {
	cacheResponse: true,
	abortOld: true,
	maxRequests: 1,
	preventDoubleRequests: true
});


//Display a definition
function display_definition(term, uri)
{
	//escape the URI
	uri = escapeURI(uri);
	
	//set header for definition
	var html = "<div class=\"definition\"><h4>" + term + "</h4></div>";
	$('#inner-details').html(html);
	setStatus("Retrieving definition(s)...");

	//retrieve query params
	var language = IWCdata["lang"]; //$("#language").val();
	var context = escape(IWCdata["context"]); //escape($.query.get("context"));
	var server = IWCdata["server"];

	var url = server + "Definition/getDefinitionByConcept?response=json&concept=";
	url += escape(unescapeURI(uri)) + "&lang=" + language + "&context="+context;

	$.manageAjax.add('AjaxDefinition', {
	  success: function(data) {
	      display_definition_callback(data, false, true);
	  },
	  url: Widget.proxify(url)
	});
}

// Display definition callback for a concept
function display_definition_callback(data, parsed, single)
{
	if (!parsed)
	{
		var service_response = "ns:getDefinitionByConceptResponse";
	
		data = data[service_response];
		data = data["ns:return"];
	}
	
	if (single) //always remove the header if requesting only a single definition
	{
		$(".definition").remove();	
	}
	
	var term = definition_fix(data[0]["$"]);
	var definition = definition_fix(data[1]["$"]);
	
	//convert brackets
	definition = definition.replace(/ -LRB- /g, " (");
	definition = definition.replace(/ -RRB- /g, ") ");

	//remove extra spaces before punctuation marks
	definition = definition.replace(/ +(\.|,)/, "$1");

	// include the actual definition
	//$('#inner-details i').remove(); //remove status message for retrieving status 
	delStatus();

	var html = "<div class=\"definition\">";

	html += "<h4>";
	if (typeof term != "undefined" && term != "undefined") html += term;
	html += "</h4>";
	
	if (typeof definition != "undefined" && definition != "undefined") {
		html += definition;
		if (typeof data[2]["$"] != "undefined" && data[2]["$"] != "") html += "<div class=\"read-more\"><a target=\"_blank\" href=\"" +  unescape(data[2]["$"]) + "\">Read more...</a></div>";
	} else {
		html += "No definition found.";
	}
	
	html += "</div>";
	$('#inner-details').append(html);
}


//display a definition given a single input term
function display_definition_keywords(term)
{
	var lang = IWCdata["lang"]; //$("#language").val();
	var context = escape(IWCdata["context"]); //escape($.query.get("context"));
	var server = IWCdata["server"];

	//call webservice to resolve term(s) to a list of concepts
	var url = server+"Definition/getDefinition?response=json&term="+term+"&lang="+lang+"&context=" + context;

	var html = "<div class=\"definition\"><h4>" + term + "</h4></div>";
	$('#inner-details').html(html);
	setStatus("Retrieving definition(s)...");
	
	$.manageAjax.add('AjaxDefinition', {
		success: function(data) {
			display_definition_keywords_callback(data);
		},
		url: Widget.proxify(url)
	});
}

//callback for definition display given a term not a concept
function display_definition_keywords_callback(data)
{
	//remove existing definitions on page
	$(".definition").remove();
	
	var data = data["ns:getDefinitionResponse"];

	for(var item in data)
	{
		if (item != "@xmlns")
		{
			var itemData = data[item];

			if (typeof itemData[0] != "undefined")
			{
				display_definition_callback(itemData, true);
			}
		}
	}
}


function definition_fix(text)
{
	text = unescape(text);
	text = text.replace(/_/g," ");
	text = text.replace(/\\\//g, "/");
	return text;
}
