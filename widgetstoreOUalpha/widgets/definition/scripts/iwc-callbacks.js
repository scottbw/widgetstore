// IWC callback functions
// name them exactly as the IWC variables you want to listen to, but with "IWC" in the beginning (e.g. shared data: "keyword" -> "IWCkeyword()")

function IWCkeywords(data) {
	if (IWCdata["server"] && IWCdata["context"] && IWCdata["lang"])
		display_definition_keywords(data);
}

function IWCnode_id(data) {
	if (IWCdata["server"] && IWCdata["context"] && IWCdata["lang"] && IWCdata["node_name"] && IWCdata["node_id"])
		display_definition(IWCdata["node_name"], IWCdata["node_id"]);
}

