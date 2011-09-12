// IWC callback functions
// name them exactly as the IWC variables you want to listen to, but with "IWC" in the beginning (e.g. shared data: "keyword" -> "IWCkeyword()")

function IWCfeedurl(data) {
	document.forms['form1'].results1.value = 'Widget 2 sent: ' + data;
}
