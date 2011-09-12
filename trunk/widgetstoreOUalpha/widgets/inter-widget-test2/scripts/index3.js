function init() {
	// show logo, help link, and footer (and therefore be able to display status messages)?
	ltfll_design.Init({showLogo:true,showHelp:true,showFooter:true});

	//initialize IWC: [data format:'JSON' or 'non-JSON'], [init shared data]
	IWCinit('JSON', true);
}

function submitForm() {
	IWCsetVarJSON(IWCnameSpace, "feedurl", document.forms['form2'].feedurl.value);
	document.forms['form2'].feedurl.value = '';
	return false;
}

