// detects if the widget runs outside wookie (i.e. in a non-wookie widget server or as stand-alone widget)
// if widget is outside wookie, create wookie and overload IWC specific functions

//IMPORTANT: /index.html must load /lib/non-wookie.js *after* /lib/iwc.js

if (typeof Widget == "undefined") {
	// create widget object
	var Widget = new function() {
		// Widget.proxify(url) workaround (do not proxify but give back the URL as it is)
		this.proxify = function(url) { return url; }
		// when functions are called do nothing
		this.onSharedUpdate = function(key) { }
		this.preferenceForKey = function(key, callback) { }
		this.sharedDataForKey = function(key, callback) { }
		this.setsharedDataForKey = function(key, value) { }
	}

	// replace IWC specific functions
	var IWCinit = function(format, initSharedData) { if (IWCstatusMessages) setStatus("IWC disabled ... "); }
	// when functions are called do nothing
	var IWCsetVarJSON = function(ns, name, value) { }
	var IWCdelVarJSON = function(name) { }
	var IWCgetVarJSON = function() { }
	var IWChandleSharedUpdateJSON = function(key) { }
	var IWCsetVar = function(name, data) { }
	var IWCdelVar = function(name) { }
	var IWCgetVar = function(name) { }
	var IWChandleSharedUpdate = function(key) { }
}
