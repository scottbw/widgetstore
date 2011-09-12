// IWC callback functions
// name them exactly as the IWC variables you want to listen to, but with "IWC" in the beginning (e.g. shared data: "keyword" -> "IWCkeyword()")

function IWCkeywords(data) {
	if (IWCdata["server"] && IWCdata["context"] && IWCdata["lang"]) {
		keywords_find_youtube_documents(data);
		keywords_find_youtubeConcepts_documents(data, escape(IWCdata["context"]), IWCdata["lang"]);
	}
}

function IWCnode_name(data) {
	if (IWCdata["server"] && IWCdata["context"] && IWCdata["lang"]) {
		keywords_find_youtube_documents(data);
		keywords_find_youtubeConcepts_documents(data, escape(IWCdata["context"]), IWCdata["lang"]);
	}
}
