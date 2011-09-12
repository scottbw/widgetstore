//should IWC related status messages be displayed (works only if showFooter is set true in /scripts/index.js)?
var IWCstatusMessages = false;

//JSON only: bind the widget to a namespace
//var IWCnameSpace = "WP6";
var IWCnameSpace = "ltfll";

var IWCinitialSharedData = '{ \
	"server": "http://augur.wu.ac.at/wp6/ltfll/tomcat/testingproxy/user/UNSPECIFIED/", \
	"context": "http://www.ltfll.eu/ontologies/context/1288193760479", \
	"concept": "http://www.lt4el.eu/CSnCS%23HTML", \
	"depth": 0, \
	"lang": "en", \
	"filterWeakPredicates": false \
}';

//non-JSON only: to which IWC variable updates should the widget listen to
//var IWCsharedData = Array("IWC_VARIABLE_1", "IWC_VARIABLE_2");
