IWCsharedKey = null;
IWCdata = new Array();


//#########################################
//IWC init method
//#########################################

function IWCinit(format, initSharedData) {
	Widget.preferenceForKey("sharedDataKey",
		function (key) {
			//setting shared data key
		        IWCsharedKey = key;

		        //initial retrieval of already set variables
			if (initSharedData) {
				if (format == "JSON") {
					IWChandleSharedUpdateJSON(key);
				} else {
					IWChandleSharedUpdate(key);
				}
			}
		}
	);

	//bind corresponding method to shared data updates (dependend of data format used)
	if (format == "JSON") {
		Widget.onSharedUpdate = IWChandleSharedUpdateJSON;
	} else {
		Widget.onSharedUpdate = IWChandleSharedUpdate;
	}

	if (IWCstatusMessages) setStatus('IWC configured ...');
}





//#########################################
//JSON specific methods
//#########################################

function IWCsetVarJSON(ns, name, value) {
	if (IWCstatusMessages) setStatus('sending data ...');
	Widget.sharedDataForKey(
		ns,
		function (data) {
			//if shared data exist for this namespace
			if (data != "No matching key found" && data != "") {
				obj = JSON.parse(data);
				//if the new value is different from the already set one
				if (obj[name] != value) {
					//only store shared data locally if it belongs to the same namespace as this widget
					if (ns == IWCnameSpace) {
						IWCdata[name] = value;
					}
					obj[name] = value;
					data = JSON.stringify(obj);
					Widget.setSharedDataForKey(ns, data);
				}
			} else {
				//only store shared data locally if it belongs to the same namespace as this widget
				if (ns == IWCnameSpace) {
					IWCdata[name] = value;
				}
				//if no shared data exist for this namespace, begin a new entry
				data = '{"' + name + '":"' + value + '"}';
				Widget.setSharedDataForKey(ns, data);
			}
		}
	);
}

function IWCdelVarJSON(name) {
	if (IWCstatusMessages) setStatus('deleting data ...');
        Widget.sharedDataForKey(
                IWCnameSpace,
		function(data) {
			//only delete shared data which is already set
			if (data != "No matching key found" && data != "") {
				delete IWCdata[name];
				obj = JSON.parse(data);
				delete obj[name];
				data = JSON.stringify(obj);
				Widget.setSharedDataForKey(IWCnameSpace, data);
			}
		}
	);
}


function IWCgetVarJSON() {
	Widget.sharedDataForKey(
		IWCnameSpace,
		function(data) {
			//only do something when actual data was received
			if (data != "No matching key found" && data != "") {
				obj = JSON.parse(data);
				//loop over all attributes of retrieved object
				for (var name in obj) {
					//only do something if new retrieved value is different from already set one
					if (IWCdata[name] != obj[name]) {
						if (IWCstatusMessages) setStatus('retrieving data ...');
						//store the newly retrieved value (for next time comparison)
						IWCdata[name] = obj[name];
						//callIWC callback function if existent
						if (eval("typeof " + "IWC" + name) == "function") {
							//call correpsonding IWC function and pass value
							eval("IWC" + name + "('" + obj[name] + "')");
						}
					}
				}
			}
		}
	);
}

function IWChandleSharedUpdateJSON(key) {
	//check if api key of instantiated widget is the same as the api key retrieved on a shared update
	//actually not needed because in Wookie these keys are matched already
	if (key == IWCsharedKey) {
		IWCgetVarJSON();
	}
}




//#########################################
//methods for key:val pairs (non-JSON option)
//#########################################

function IWCsetVar(name, data) {
	if (IWCstatusMessages) setStatus('sending data ...');
	IWCdata[name] = data;
	Widget.setSharedDataForKey(name, escape(data));
}

function IWCdelVar(name) {
	if (IWCstatusMessages) setStatus('deleting data ...');
	delete IWCdata[name];
	//setting a variable null or "null" deletes it
	Widget.setSharedDataForKey(name, null);
}

function IWCgetVar(name) {
	Widget.sharedDataForKey(
		name,
		function(data) {
			data = unescape(data);
			//if retrieved data is different from already set one and
			//actual data was received and
			if (IWCdata[name] != data && data != "No matching key found") {
				if (IWCstatusMessages) setStatus('retrieving data ...');
				//store the data for next time comparison
				IWCdata[name] = data;
				//if corrsponding IWC callback function exists
				if (eval("typeof " + "IWC" + name) == "function") {
					//call IWC callback function and pass data
					eval("IWC" + name + "('" + data + "')");
				}
			}
		}
	);
}

function IWChandleSharedUpdate(key) {
	if (key == IWCsharedKey) {
		//to minimize traffic we define for every widget the shared data updates it should listen to
		//here: loop over the array and call data fetching method
		for (var i = 0; i < IWCsharedData.length; i++) {
			IWCgetVar(IWCsharedData[i]);
		}
	}
}
