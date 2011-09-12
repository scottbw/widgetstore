Tools = 
{
	IncludeScript: function(name)
	{
		document.write("<scr"+"ipt src=\""+name+"\"></scri"+"pt>");
	}
	,IsOffline: function()
	{
		return true;
	}
	
	,GetString: function(string, params) 
	{
		var retval = string;
		if (arguments.length == 1)
			return retval;

		for (var key in params) {
			retval = retval.replace('${' + key + '}', params[key]);
		}
		return retval;
	}

	,GetJSON: function(url, methodName, arguments, asyncCallback)
	{
		$.getJSON(Widget.proxify(url), {"method":methodName, "arguments": JSON.stringify(arguments)},  asyncCallback);
	}	
};

Tools.IncludeScript("lib/json2-min.js");
