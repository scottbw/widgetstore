$(document).ready(function($) {
	
	function itemSelected(obj){
		console.log(obj['id']);
		window.location.href="displayWidget.jsp?id="+obj['id'];
	}
	
	var options = {
		script : "ajaxHandlers/autosuggestions.jsp?",
		delay : 0,
		varname : "q",
		maxentries : 10,
		noresults : "No matching widgets",
		callback : itemSelected
	};
	var as1 = new bsn.AutoSuggest('widgetSearchInput', options);
	console.log('2');
});