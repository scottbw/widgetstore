// IWC callback functions
// name them exactly as the IWC variables you want to listen to, but with "IWC" in the beginning (e.g. shared data: "keyword" -> "IWCkeyword()")

function IWCkeywords(data) {
	SnaSearch.update(data);
}

function IWCnode_name(data) {
	SnaSearch.update(data);
}
