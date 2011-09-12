// IWC callback functions
// name them exactly as the IWC variables you want to listen to, but with "IWC" in the beginning (e.g. shared data: "keyword" -> "IWCkeyword()")

function IWCfeedurl(data) {
	document.forms['form2'].results2.value = 'Widget 1 sent: ' + data;
}



