// IWC callback functions
// name them exactly as the IWC variables you want to listen to, but with "IWC" in the beginning (e.g. shared data: "keyword" -> "IWCkeyword()")

function IWCkeywords(data) {
	if (IWCdata["server"]) keywords_find_delicious_documents(data);
}

function IWCnode_name(data) {
	if (IWCdata["server"] && IWCdata["concept"] && IWCdata["context"] && IWCdata["lang"])
		find_delicious_documents(data);
}
