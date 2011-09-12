function init() {
	// show logo, help link, and footer (and therefore be able to display status messages)?
	ltfll_design.Init({showLogo:false,showHelp:false,showFooter:false});

	//initialize IWC: [data format:'JSON' or 'non-JSON'], [init shared data]
	IWCinit('JSON', true);
}
