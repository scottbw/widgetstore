function init() {
	// show logo, help link, and footer (and therefore be able to display status messages)?
	ltfll_design.Init({showLogo:true,showHelp:true,showFooter:true});

	//initialize IWC: [data format:'JSON' or 'non-JSON'], [init shared data]
	IWCinit('JSON', true);
}


function submitForm2(data) {
//alert('data='+data);
//var toSubmit=document.forms['form1'].feedurl.value;
//alert('I am submitting : '+toSubmit);
IWCsetVarJSON(IWCnameSpace, "feedurl", data);
        drop(data);
	document.forms['form1'].feedurl.value = '';
	return false;
}

