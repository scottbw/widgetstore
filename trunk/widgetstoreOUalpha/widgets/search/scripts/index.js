function init() {
	// show logo, help link, and footer (and therefore be able to display status messages)?
	ltfll_design.Init({showLogo:true,showHelp:true,showFooter:true});

	//initialize IWC: [data format:'JSON' or 'non-JSON'], [init shared data]
	IWCinit('JSON', false);

	//Widget.setSharedDataForKey(IWCnameSpace, IWCinitialSharedData);

	//either set initial shared data as set in scripts/config.js or
	//retrieve already set shared data and override some variables with default values as defined in scripts/config.js
	Widget.sharedDataForKey(
		IWCnameSpace,
		function (data) {
			if (data != "No matching key found" && data != "") {
				obj = JSON.parse(data);
				initObj = JSON.parse(IWCinitialSharedData);
				for (var name in initObj) {
					obj[name] = initObj[name];
				}
				data = JSON.stringify(obj);
				Widget.setSharedDataForKey(IWCnameSpace, data);
			} else {
				Widget.setSharedDataForKey(IWCnameSpace, IWCinitialSharedData);
			}
		}
	);
}
