$(document).ready(function() {
	$("#keywordSearch form").submit(function() {
		IWCsetVarJSON(IWCnameSpace, "keywords", $("#keywords").val());
		return false; //don't submit the form (prevents reloading the page)
	});
});
