<%@ page import='org.apache.wookie.Messages'%>
<%@ page import='org.apache.wookie.beans.IWidget'%>
<%@ page import='org.apache.wookie.beans.IWidgetInstance'%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.apache.wookie.beans.ITagsWidgets"%>
<%@ page import='java.util.ArrayList'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%

IPersistenceManager persistenceManager = PersistenceManagerFactory
.getPersistenceManager();

String requestTag = request.getParameter("tag");

ITags[] itag = persistenceManager.findByValue(ITags.class,"tagtext",requestTag);
int tagidFromTagBean = new Integer(itag[0].getId().toString());

ITagsWidgets[] itagwids = persistenceManager.findByValue(ITagsWidgets.class,"tagid",tagidFromTagBean);

%>
<html>
<head>
<title>New design for widget store</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link type="text/css" href="../newLayout.css" rel="stylesheet" />
<script type="text/javascript"
	src="/wookie/shared/js/jquery/jquery-1.3.2.min.js"></script>
<script type="text/javascript"
	src="/wookie/shared/js/jquery.raty.min.js"></script>
<script type="text/javascript"
	src="/wookie/shared/js/jquery.MetaData.js"></script>
<script type="text/javascript"
	src="/wookie/shared/js/highlight-with-html.js"></script>
<script type="text/javascript"
	src="/wookie/shared/js/bsn.AutoSuggest.js"></script>
<link type="text/css" href="/wookie/shared/js/highslide.css"
	rel="stylesheet" />
<link type="text/css"
	href="/wookie/shared/css/autosuggest_inquisitor.css" rel="stylesheet" />
<script type="text/javascript">
	jQuery.noConflict();
	console.log('1');
	jQuery(document).ready(function($) {
		//$('input.star').rating();
		var options = {
			script : "ajaxHandlers/autosuggestions.jsp?",
			delay : 0,
			varname : "q",
			maxentries : 10,
			noresults : "No matching widgets"
		};
		var as1 = new bsn.AutoSuggest('widgetSearchInput', options);
		console.log('2');
	});
</script>
</head>

<body>
<%@ include file="static/header.html"%>

<div id="content">
<div id="widget-wrapper">
<h2>Widgets tagged with <em><%out.print(""+requestTag); %></em></h2>
<%
for (ITagsWidgets itagwid : itagwids){

	int tagIdFromTagsWidgetsBean = itagwid.getWidid();

    IWidget[] allWidgets = persistenceManager.findAll(IWidget.class);
    ArrayList<String> guids = new ArrayList<String>();
    int count = -1;

    IWidget widget = persistenceManager.findById(IWidget.class,tagIdFromTagsWidgetsBean);
    String id = ""+widget.getId();
    
    if (!widget
    		.getGuid()
    		.equalsIgnoreCase(
    				"http://www.tencompetence.org/widgets/default/notsupported")) {
    	String guid = widget.getGuid();
    	if (!guids.contains(guid)) {
    		guids.add(guid);
    		++count;
%>
<div class="widgetContainer">
<p><a href="displayWidget.jsp?id=<% out.print(widget.getId()); %>">
<%
out.print(widget.getWidgetTitle());
%> 
</a></p>
<div class="widgetIcon"><img align="center" class="wookie-icon"
	src="<%out.print(widget.getWidgetIconLocation());%>" width="75"
	height="75"></div>
<p>descritpion:
<%
out.println(widget.getWidgetDescription());
%>
</p>
<p><a
	href="../WidgetServiceServlet?api_key=TEST&userid=testuser&shareddatakey=mysharedkey&widgetid=<%out.print(widget.getGuid());%>&requestid=getwidget">Intantiate
this!</a></p>
<p><a href="http://www.google.com"
	onclick="return hs.htmlExpand( this, {     	objectType: 'iframe', outlineType: 'rounded-white', wrapperClassName: 'highslide-wrapper drag-header',         outlineWhileAnimating: true, preserveContent: false, width: 250 } )">Test</a>
</p>
<div id="tags-wrapper">
<%
	ITagsWidgets[] itws = persistenceManager.findByValue(
			ITagsWidgets.class, "widid", widget.getId());
if (itws != null && itws.length != 0) {
	
			for (int i = 0; i < itws.length; i++) {
				Integer tagid = (Integer)itws[i].getTagid();
				ITags tag = persistenceManager.findById(ITags.class,tagid);
				
				if (tag.getTagtext().equals(requestTag)){
					out.print("<span class='tagSpan'>"+ tag.getTagtext() + "</span>");					
				}else {					
				out.print("<span class='tagSpan'><a title='See all widgets tagged with "+tag.getTagtext()+"' href='exploreTags.jsp?tag="+tag.getTagtext()+"'>" + tag.getTagtext() + "</a></span>");
				}				
			}
		}else {
			out.print("no tags yet");
		}
%>
</div>
<div class="rating"></div>
</div>

<%
		}
	}//if widget not Notsupported
}//ITagsWidgets loop
%>
</div>
</div>

<div id="sub-section">
<div>
<h1>sub-section</h1>
</div>
</div>

<%@ include file="static/footer.html"%>
<script>
	
</script>
</body>
</html>
