function setEmpty(input)
{
	input.value=""
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
 if(url.substr(7,10).indexOf("youtube")==0)
	return type=="name"?"youtube":"video";
if(url.substr(11,10).indexOf("slideshare")==0)
	return type=="name"?"slideshare":"presentation";	
if(url.substr(11,10).indexOf("flickr")==0)
	return type=="name"?"flickr":"image";	
return type=="name"?"delicious":"bookmark"; //if this receives urls of bookmarks then they won't start with delicious	
}

var username=""
var client_ip=""
function setUsername(obj)
{
	if (obj && obj != "null")
		SnaRecommendation.username=obj;	
	SnaRecommendation.getRecommendations();
}

function setClientIp(obj)
{
	if (obj && obj != "null")
		client_ip=obj;
}

var SnaRecommendation = {
	file : null, // APML file from SNA APMLGen API
    settings : {
        api_call: null, // API URL (will get APML from here)
        filename: null,
        update_interval: null,
        max_summary: null
    },
	url: null,
	delicious:null,
	slideshare:null,
	flickr:null,
	youtube:null,
	username:null,
   //we'll have an array for videos, images, presentations and bookmarks
	videos:null,
	images:null,
	presentations:null,
	bookmarks:null,

	init : function()
	{
		//the recommendations will be performed at init
		//TODO - replace the user and pass with ones taken from settings
		
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
		SnaRecommendation.defaultUsername=defaultUser_item[1];

	if(param_item.length > 1) {
		SnaRecommendation.username = param_item[1]; 
		SnaRecommendation.getRecommendations();
	} else {
		Widget.preferenceForKey('username',setUsername);
	}
		},

    update_info : {
        // just some information about updates
        last_update : null,
        next_update : null,
        is_error: null
    },

	getRecommendations: function()
	{
	setStatus("Searching...");
	url="http://ec2-79-125-30-242.eu-west-1.compute.amazonaws.com:8090/recomm/?usr="+SnaRecommendation.username+"&type=unknown&pw=&defaultUsername="+SnaRecommendation.defaultUsername;
		purl=Widget.proxify(url);
		
		 $.ajax({
        type: "GET",
        url: purl,
        dataType: "xml",
        success: function(data) {
		delStatus();
		SnaRecommendation.links={};
			
		SnaRecommendation.videos=Array();
		SnaRecommendation.images=Array();
		SnaRecommendation.presentations=Array();
		SnaRecommendation.bookmarks=Array();
		
        $(data).find("resource").each(
		function(){
		escapedURI=$(this).attr("uri");
		resourceURI=unescape(escapedURI);
		currentRank=$(this).attr("rank");
		resourceType=identifySNResource(resourceURI, "name");
		var resource=new Object()
		resource.uri=resourceURI;
		resource.rank=currentRank;
		
		//depending on the resourceType i add the resource to the right array
		//this should have been moved to a function 
		if (resourceType=="delicious")
		{	
			SnaRecommendation.bookmarks.push(resource);
		}
		
		if (resourceType=="slideshare")
		{	
			SnaRecommendation.presentations.push(resource);
		}
		
		if (resourceType=="flickr")
		{	
			SnaRecommendation.images.push(resource);
		}
		
		if (resourceType=="youtube")
		{	
			SnaRecommendation.videos.push(resource);
		}
		}
		);
		
		SnaRecommendation.videos.sort(compareResources);
		SnaRecommendation.images.sort(compareResources);
		SnaRecommendation.presentations.sort(compareResources);
		SnaRecommendation.bookmarks.sort(compareResources);
		
		// now we have to choose some resources to display
		chooseAndDisplay(SnaRecommendation.videos, "#videos");
		chooseAndDisplay(SnaRecommendation.images, "#images");
		chooseAndDisplay(SnaRecommendation.bookmarks, "#bookmarks");
		chooseAndDisplay(SnaRecommendation.presentations, "#presentations");
		
		$("#recommendations").append("<p><script type='text/javascript' src='http://shots.snap.com/ss/c86a0d3ab55ad3cc6a087d4e014b8536/snap_shots.js'></script></p>");
				
                },
                error: function(request, status, error) {
                    this.update_info.is_error = true;
		    $("#debug").append("<br>"+request+"<br>"+error);
                }
            });
	
	},
	saveAction : function(url, action) {
		url = "http://ec2-79-125-30-242.eu-west-1.compute.amazonaws.com:8090/statistic/?usr="+username+"&pw=&url="+url+"&action="+action+"&ip=";
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
		url = "http://ec2-79-125-30-242.eu-west-1.compute.amazonaws.com:8090/path/?usr="+username+"&pw=&type=" + type + "&uri=" + uri;
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
	
	addLink: function(key, value) {
        this.links[key] = value;
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

//function that will be used by the sort function of the arrays with resources
function compareResources (resObj1, resObj2)
{
	//resObj1 and resObj2 are resource objects holding rank and uri properties. the objects will be sorted by rank descending
	return resObj2.rank-resObj1.rank;
}

//chooses randomly max 3 resources of each type and displays them 
function chooseAndDisplay(resourceArray, locationId)
{
	len=resourceArray.length;
	if (len==0)
		return;
	results=Array();
	if(len<3)
	{
		display(resourceArray,locationId);
		return;
	}
	else
	{
	for (i=0;i<3;i++)
	{
	//choose an index between min (5, length-i)
		randResIndex=Math.floor(Math.random()*(5<(len-i)?5:len-i));
		results.push(resourceArray[randResIndex]);
		//eliminate the resource from the array
		resourceArray.splice(randResIndex,1);
	
	}
	display(results, locationId);
		}

}

function display(resultList, locationId)
{
	$(locationId).append("<p>Recommended "+identifySNResource(resultList[0].uri,"type")+"s</p>");
	for (i=0; i<resultList.length;i++)
	{//TODO: add the uri title
		$(locationId).append("<p><a target='_blank' href='"+resultList[i].uri+"' onMouseover=\"SnaRecommendation.getPath('"+resultList[i].uri+"', 'resource')\" onMouseout='hideddrivetip()' onClick=\"SnaRecommendation.saveAction('"+resultList[i].uri+"', 'recommClick')\">"+resultList[i].uri+"</a></p>");
		}
}
