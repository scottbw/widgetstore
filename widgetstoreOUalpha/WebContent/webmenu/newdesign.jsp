<%--
/*
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 * limitations under the License.
 */
--%>
<%@ page import='org.apache.wookie.Messages'%>
<%@ page import='org.apache.wookie.beans.IWidget'%>
<%@ page import='org.apache.wookie.beans.IWidgetInstance'%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.apache.wookie.beans.ITagsWidgets"%>
<%@ page import='java.util.List'%>
<%@ page import='java.util.ArrayList'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%@ page import='org.apache.wookie.helpers.WidgetInstanceFactory'%>
<%@ page import='org.apache.wookie.controller.WidgetInstancesController'%>
<%@ page import='org.apache.wookie.server.LocaleHandler'%>

<%	IPersistenceManager persistenceManager = PersistenceManagerFactory
	.getPersistenceManager(); %>

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
<script type="text/javascript" src="/wookie/shared/js/highslide.js"></script>
<script type="text/javascript"
	src="/wookie/shared/js/bsn.AutoSuggest.js"></script>
<script type="text/javascript" src="/wookie/shared/js/autosuggest.js"></script>
<script type="text/javascript" src="/wookie/shared/js/home.js"></script>
<link type="text/css" href="/wookie/shared/js/highslide.css"
	rel="stylesheet" />
<link type="text/css"
	href="/wookie/shared/css/autosuggest_inquisitor.css" rel="stylesheet" />
</head>

<body>
	<%@ include file="static/header.html"%>

	<div id="content">
		<div id="tag-cloud-wrapper">
			<%

double maxFontSize = 3;
double minFontSize = 0.8;
String colors[] = {"#333", "#159", "#468175", "#951"};


String query =	"SELECT tw.tagid, count(tw.tagid) "+
					"FROM TagsWidgetsImpl tw "+
					"GROUP BY tw.tagid "+
					"";
					//"ORDER BY count(tw.tagid) DESC";

	List<Object> freqs = persistenceManager.JPQLQuery(Object.class,query);
	
	
	//Integer maxFreq = new Integer(((Object[])freqs.get(0))[0].toString());
	int maxFreq  = 5;
	int counter = 0;
	for (Object o : freqs){
		counter++;
		if (o instanceof Object[]) {
			Object[] oo = (Object[])o;
			Integer tagid = new Integer(oo[0].toString());
			ITags[] tagsWithThisId=persistenceManager.findByValue(ITags.class,"id",tagid);
			String tagText = tagsWithThisId[0].getTagtext();
			int tagFreq = new Integer(oo[1].toString());
			
			double fontSize = maxFontSize * ((double) tagFreq / maxFreq);
            if (fontSize < minFontSize) {
                fontSize = minFontSize;
            }
			
			out.print("<span><a href='exploreTags.jsp?tag="+tagText+"' "+
					"style=\"font-size:" + fontSize + "em;" + "color:" + colors[counter % colors.length] + ";\">" + 
					tagText + "</a></span>");
			
            
            } else {
            	//
            }
	}
	
	%>
		</div>
		<br clear="both" />
		<div id="widget-wrapper">
			<%
                            IWidget[] allWidgets = persistenceManager.findAll(IWidget.class);
                            ArrayList<String> guids = new ArrayList<String>();
                            int count = -1;

                            for (IWidget widget : allWidgets) {
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
				<p>
					<a href="displayWidget.jsp?id=<% out.print(widget.getId()); %>">
						<%
                                out.print(widget.getWidgetTitle());
                            %> </a>
				</p>
				<div class="widgetIcon">
					<img align="center" class="wookie-icon"
						src="<%out.print(widget.getWidgetIconLocation());%>" width="75"
						height="75">
				</div>
				<p>
					descritpion:<%
                                out.println(widget.getWidgetDescription());
                            %>
				</p>

				<%
//Create a widget instance so you can get the preview url = widgeturl with instance id+proxy parameters
IWidgetInstance instance = null;
String apiKey = "TEST";
String userId = "demostrationUser";
String sharedDataKey = "myshareddata";
String widgetId = widget.getGuid();
instance = WidgetInstanceFactory.getWidgetFactory(session,
				LocaleHandler.localizeMessages(request)).newInstance(
				apiKey, userId, sharedDataKey, null, widgetId, null);


%>
				<p>
					<a
						href="../WidgetServiceServlet?api_key=TEST&userid=testuser&shareddatakey=mysharedkey&widgetid=<%out.print(widget.getGuid());%>&requestid=getwidget">Intantiate
						this!</a>
				</p>
				<p class="testWidgetAnchor">
					<a href="<%=widget.getUrl()%>?idkey=<%=instance.getIdKey()%>&proxy=<%=WidgetInstancesController.checkProxy(request)%>"
						onclick="return hs.htmlExpand(this,{outlineType:'rounded-white',wrapperClassName:'draggable-header',objectType:'iframe'})">Test</a>
				</p>

				<!-- 
<p>
<a href="http://www.google.com" 
onclick="return hs.htmlExpand(this, { outlineType: 'rounded-white',wrapperClassName: 'draggable-header', objectType: 'iframe' } )">
Test
</a>
</p>
-->




				<p>
					<a
						href="../admin/WidgetAdminServlet?operation=DOWNLOADWIDGET&wid=<% out.print(widget.getId());%>">Download</a>
				</p>


				<div id="tags-wrapper">
					<%
	ITagsWidgets[] itws = persistenceManager.findByValue(
				ITagsWidgets.class, "widid", widget.getId());
		if (itws != null && itws.length != 0) {
			
			for (int i = 0; i < itws.length; i++) {
				Integer tagid = (Integer)itws[i].getTagid();
				ITags tag = persistenceManager.findById(ITags.class,tagid);				
				out.print("<span class='tagSpan'><a title='See all widgets tagged with "+tag.getTagtext()+"' href='exploreTags.jsp?tag="+tag.getTagtext()+"'>" + tag.getTagtext() + "</a></span>");
				
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
                                    }
                            }
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
