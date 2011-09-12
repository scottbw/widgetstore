function setEmpty(input)
{
	input.value=""
}

function searchIfEnter(e)
{
	if (window.event) 
	{ e = window.event; }
/*
     if (e.keyCode == 13)
               {
                        SnaSearch.update();
                }
*/
}

//identifies the social networking application name according to the url given
//it returns the resource type or the name of the social networking application
//if the type is "name" returns the name; if the type is resource it returns the resource type
//youtube - "video"
//delicious - "bookmark"
//slideshare - "presentation"
//flickr - image
function identifySNResource(url, type)
{
//substr(7,x) to strip http:// and the rest is to see if the url starts with delicious or youtube or slideshare or flickr
 if(url.substr(7,10).indexOf("delicious")==0)
	return type=="name"?"delicious":"bookmark";
 if(url.substr(13,10).indexOf("youtube")==0)
	return type=="name"?"youtube":"video";
if(url.substr(11,10).indexOf("slideshare")==0)
	return type=="name"?"slideshare":"presentation";	
if(url.substr(11,10).indexOf("flickr")==0)
	return type=="name"?"flickr":"image";	
return "unidentified";	
}

function setDelicious(obj)
{
	if (obj && obj != "null")
		SnaSearch.delicious=obj;
}

function setSlideshare(obj)
{
	if (obj && obj != "null")
		SnaSearch.slideshare=obj;
}

function setFlickr(obj)
{
	if (obj && obj != "null")
		SnaSearch.flickr=obj;
}

function setYoutube(obj)
{
	if (obj && obj != "null")
		SnaSearch.youtube=obj;
}

function setUsername(obj)
{
	if (obj && obj != "null")
		SnaSearch.username=obj;
}

var client_ip=""
function setClientIp(obj)
{
	if (obj && obj != "null")
		client_ip=obj;
}

var SnaSearch = {
	file : null, // APML file from SNA APMLGen API
    settings : {
        api_call: null, // API URL (will get APML from here)
        filename: null,
        update_interval: null,
        max_summary: null
    },
	urlprefix: null,
	
	delicious:null,
	slideshare:null,
	flickr:null,
	youtube:null,
	username:null,
	
    update_info : {
        // just some information about updates
        last_update : null,
        next_update : null,
        is_error: null
    },

	resourceLinks: {},
	userLinks:{},

	init : function()
	{
	Widget.preferenceForKey('snaDelicious',setDelicious);
	Widget.preferenceForKey('snaFlickr',setFlickr);
	Widget.preferenceForKey('snaSlideshare',setSlideshare);
	Widget.preferenceForKey('snaYoutube',setYoutube);
	
	
	var url = document.URL;
	var query_st = url.split("?");
	var param_item = new Array();
	var defaultUser_item=new Array();
	if(query_st.length > 1){
		var params = query_st[1].split("&");
		if(params.length > 4)
			param_item = params[4].split("=");
		//to fetch the defaultUsername parameter
		if(params.length>3)
			defaultUser_item=params[3].split("=");
	}
	
	if(defaultUser_item.length>1)
		SnaSearch.defaultUsername=defaultUser_item[1];
	
	if(param_item.length > 1)
		SnaSearch.username = param_item[1];
	else
		Widget.preferenceForKey('username',setUsername);
	urlprefix="http://ec2-79-125-30-242.eu-west-1.compute.amazonaws.com:8090/";
	Widget.preferenceForKey('client_ip', setClientIp);
	},
	saveAction : function(url, action) {
		url = "http://ec2-79-125-30-242.eu-west-1.compute.amazonaws.com:8090/statistic/?usr="+SnaSearch.username+"&pw=&url="+url+"&action="+action+"&ip=";
		purl = Widget.proxify(url);
		$.ajax({
			type: "GET",
			url: purl,
			dataType: "text",
			success: function(data){
				}
			});
			
	},
    getPath : function(uri, type) {
		url = "http://ec2-79-125-30-242.eu-west-1.compute.amazonaws.com:8090/path/?usr="+SnaSearch.username+"&pw=&type=" + type + "&uri=" + uri;
		purl = Widget.proxify(url);
		$.ajax({
			type: "GET",
			url: purl,
			dataType: "xml",
			success: function(data) {
				len = $(data).find("path").attr("len");
				if(len == 0){
					return;
				}
				str = "";
				$(data).find("node").each(
					function()
					{
						userURL = $(this).attr("uri");
						lastIndexofSlash = userURL.lastIndexOf("/");
						user = userURL.substr(lastIndexofSlash+1);
						if( $(this).attr("type") != "final" && len > 1 )
							str += user + " -> ";
						else
							if( ($(this).attr("type") == "start" && len == 1) || $(this).attr("type") == "final" )
								str += user;
					}
				);
				ddrivetip(str);
			}
		});
	},

    update : function(searchterm) {
	//update will be called when pressing the search button
	//get the values in the form
	//TODO: the username needs to be extracted from preferences
	
	//$("#status").append("searching...");
	$("#debug").empty();
	setStatus("Searching...");
	
	//this.settings.api_call=urlprefix+"resources"+"/XMLlist?usr="+this.username+"&n=20&tags="+$("#search_query").val()+"&pw=&defaultUsername="+SnaSearch.defaultUsername;
	this.settings.api_call=urlprefix+"resources"+"/XMLlist?usr="+this.username+"&n=20&tags="+searchterm.toLowerCase()+"&pw=&defaultUsername="+SnaSearch.defaultUsername;
	purl = Widget.proxify(this.settings.api_call);
	//$("#debug").append("<br>"+purl);
	
	//changing this to search for users and resources in the same query
	//search for resources
    $.ajax({
        type: "GET",
        url: purl,
        dataType: "xml",
        success: function(data) {
		delStatus();
		SnaSearch.resourceLinks={};
		$("#debug").find("p").remove();
		if($(data).find("xmllist").attr("results")==0)
		{
			//no results were found
			$("#debug").append("<p style='font-weight:bold;'>You have no resources and users relevant for this query in your social network.</p>");
			//$("#status").empty();	
			return;
		}
		SnaSearch.saveAction($("#search_query").val(), "resourceSearch");
      
			//manage resources (extract them from xml, create a readable form and add them to a dictionary)
		$(data).find("resource").each(manageResource);
		$("#debug").append("<p style='font-weight:bold;'>The results below come from persons in your social network:</p>");
		 for (var url in SnaSearch.resourceLinks)
				$("#debug").append("<p>"+SnaSearch.resourceLinks[url]+"</p>");
			//$("#status").empty();	
                
				
				
				},
                error: function(request, status, error) {
                    this.update_info.is_error = true;
					$("#debug").append("<br>"+request+"<br>"+error);
                }		
			
			});
	
	
		
		//$("#debug").append("<p><script type='text/javascript' src='http://shots.snap.com/ss/c86a0d3ab55ad3cc6a087d4e014b8536/snap_shots.js'></script></p>");
		
    },

    

	addLink: function(key, value, where) {
        if (where=="user")
			this.userLinks[key]=value;
		if(where=="resource")
			this.resourceLinks[key] = value;
    },

   hasSettings : function() {
        if (this.settings.api_call == null) {
            return null;
        }

        if (this.settings.filename == null) {
            return null;
        }

        if (this.settings.update_interval == null) {
            return null;
        }
        if (this.settings.max_summary == null) {
            return null;
        }

        return true;
    }

}


function manageResource()
{
	//for each resource returned i want to save the user that recommended it, the url and the list of tags
				
				//the URI
				uri=$(this).attr("uri");
				
				userURL=$(this).find("user").attr("uri");
				//extract the user from the userURL
				lastIndexofSlash=userURL.lastIndexOf("/");
				user=userURL.substr(lastIndexofSlash+1);
				tagList={};
				//now extract the damned tags
				$(this).find("tag").each(
					function()
					{
						tagList[$(this).attr("name")]=$(this).attr("uri");
					}
				);
				//create a string with the names of the tags
				string=""
				for(var key in tagList)
				{
					string+=key+",&nbsp; ";
				}
				//take out the last comma. i was a bit tired when writing this. not proud of the solution:(
				string=string.substr(0,string.lastIndexOf(","));
				//format the result and add it to the url list
				// the result should be smth like "resource type recommended by user x from platform y on tag1, tag2, tag3
					newUserURL=userURL;
					if (identifySNResource(uri,"resource")=="video")
					{	uri="http://youtube.com/?v="+uri.substr(42);
					newUserURL="http://youtube.com/"+userURL.substr(41);}
				result="<img src='./images/"+identifySNResource(userURL, "name")+".jpg' width='15px' height='15px'/><a target='_blank' href='"+uri+"' onClick=\"SnaSearch.saveAction('"+uri+"', 'resourceClick')\">"+ identifySNResource(userURL, "resource")+"</a> from <a target='_blank' href='"+newUserURL+"' onMouseover=\"SnaSearch.getPath('"+userURL+"', 'user')\" onMouseout='hideddrivetip()' onClick=\"SnaSearch.saveAction('"+userURL+"', 'userClick')\">"+user+"</a> on "+string;
				SnaSearch.addLink(uri,result,"resource");
}
