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
<%@page import="org.apache.openjpa.lib.conf.IntValue"%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.apache.wookie.beans.ITagsWidgets"%>
<%@page import="org.apache.wookie.beans.jpa.impl.StoreUserImpl"%>
<%@page import="org.apache.wookie.beans.IRating"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.IComments"%>
<%@page import="org.apache.wookie.util.MD5Util"%>
<%@ page import='org.apache.wookie.Messages'%>
<%@ page import='org.apache.wookie.beans.IWidget'%>
<%@ page import='org.apache.wookie.beans.IWidgetInstance'%>
<%@ page import='org.apache.wookie.beans.IFeature'%>
<%@ page import='org.apache.wookie.beans.IParam'%>
<%@ page import='java.util.List'%>
<%@ page import='java.util.Collection'%>
<%@ page import='java.util.Map'%>
<%@ page import='java.util.HashMap'%>
<%@ page import='java.util.Iterator,java.util.ArrayList'%>
<%@ page import='java.util.HashMap'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%@ page import='org.apache.wookie.helpers.WidgetInstanceFactory'%>
<%@ page import='org.apache.wookie.controller.WidgetInstancesController'%>
<%@ page import='org.apache.wookie.server.LocaleHandler'%>
<%
	String sid = request.getParameter("id");
	int id = Integer.parseInt(sid);
	IPersistenceManager persistenceManager = PersistenceManagerFactory
			.getPersistenceManager();
	IWidget dwidget = persistenceManager.findById(IWidget.class, id);
%>
<html>
<head>
<title>New design for widget store</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link type="text/css" href="../displayWidget.css" rel="stylesheet" />
<script type="text/javascript"
	src="/wookie/shared/js/jquery/jquery-1.5.1.min.js"></script>
<!--
<script type="text/javascript"
	src="/wookie/shared/js/jquery-ui-1.8.10.custom.min.js"></script>
	-->
	<script type="text/javascript"
	src="/wookie/shared/js/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript" src="/wookie/shared/js/tag.js"></script>
<script type="text/javascript"
	src="/wookie/shared/js/jquery.ui.stars.min.js"></script>
<link type="text/css" href="/wookie/shared/css/jquery.ui.stars.css"
	rel="stylesheet" />
<link type="text/css" href="/wookie/shared/js/highslide.css"
	rel="stylesheet" />
<script type="text/javascript" src="/wookie/shared/js/displayWidget.js"></script>
<script type="text/javascript"
	src="/wookie/shared/js/bsn.AutoSuggest.js"></script>
<script type="text/javascript" src="/wookie/shared/js/autosuggest.js"></script>
<script type="text/javascript" src="/wookie/shared/js/jquery.flot.js"></script>
<script type="text/javascript" src="/wookie/shared/js/stats.js"></script>
<link type="text/css"
	href="/wookie/shared/css/autosuggest_inquisitor.css" rel="stylesheet" />
</head>

<body>
<span id="widgetID" style="display: none"> <%
 	out.print(id);
 %> </span>


<%@ include file="static/header.html"%>

<p>
<%
	//out.println("<p>Features enabled</p>");
	//String[] features = persistenceManager.findServerFeatureNames();
	//for (int j = 0; j < features.length; j++) {
	//	out.println("<p>" + features[j] + "</p>");
	//}
%>
</p>
<%
	if (dwidget != null) {
		//create an instance to use on the preview box
		IWidgetInstance instance = null;
		String apiKey = "TEST";
		String userId = "demostrationUser";
		String sharedDataKey = "myshareddata";
		String widgetId = dwidget.getGuid();
		//session = request.getSession(true);
		instance = WidgetInstanceFactory.getWidgetFactory(session,
				LocaleHandler.localizeMessages(request)).newInstance(
				apiKey, userId, sharedDataKey, null, widgetId, null);
%>
<div id="content">
<div id="widget-wrapper">
<div id="previewWrapper">
<div>
<h2>Preview:</h2>

<iframe id="previewIFrame" width="<%=dwidget.getWidth()%>"
	height="<%=dwidget.getHeight()%>"
	src="<%=dwidget.getUrl()%>?idkey=<%=instance.getIdKey()%>&proxy=<%=WidgetInstancesController.checkProxy(request)%>"></iframe>



</div>
</div>
<div id="widgetMetadata"><img align="center" class="wookie-icon"
	src="<%out.print(dwidget.getWidgetIconLocation());%>" width="40px"
	height="40px">
<p>Title:<%
	out.print(dwidget.getWidgetTitle());
%>
</p>
<p>Author:<%
	out.print(dwidget.getWidgetAuthor());
%>
</p>
<p>Description:<%
	out.println(dwidget.getWidgetDescription());
%>
</p>



<div id="tags-wrapper">
<%
	ITagsWidgets[] itws = persistenceManager.findByValue(
				ITagsWidgets.class, "widid", id);
		if (itws != null && itws.length != 0) {

			for (int i = 0; i < itws.length; i++) {
				Integer tagid = (Integer) itws[i].getTagid();
				ITags tag = persistenceManager.findById(ITags.class,
						tagid);
				out.print("<span class='tagSpan'><a title='See all widgets tagged with "
						+ tag.getTagtext()
						+ "' href='exploreTags.jsp?tag="
						+ tag.getTagtext()
						+ "'>"
						+ tag.getTagtext()
						+ "</a></span>");
			}
		} else {
			out.print("no tags yet");
		}
%>
<div id="addTagsDiv">
<button id="addTagsBtn">Add tags</button>
<input autocomplete="off" style="display: none" id="tagSuggestInput"
	type="text" size="50" name="tags"></input> <input style="display: none"
	id="addTagsSubmitBtn" type="submit" value="Add tags"></input></div>
</div>


</div>
<div class="clear"></div>
<div id="reviews">

<!-- here will go the MEAN rating by all users -->
<div class="rating">
<%
	//Get the mean rating of this widget
		String meanRatingQuery = "SELECT r.widid,AVG(r.rate) "
				+ "FROM RatingImpl r " + "GROUP BY r.widid "
				+ "HAVING r.widid=" + id;

		List<Object> meanRatings = persistenceManager.JPQLQuery(
				Object.class, meanRatingQuery);

		if (meanRatings.size() == 0) {
			out.print("No ratings yet for this widget");
		} else {
			int meanRating = 1;
			for (Object meanR : meanRatings) {
				if (meanR instanceof Object[]) {
					Object[] mR = (Object[]) meanR;
					if (mR[0] instanceof Integer) {
						//out.print("<p>" + mR[0] + "\t");
					}
					if (mR[1] instanceof Double) {
						//out.print("" + mR[1] + "</p>");
						meanRating = ((Double)mR[1]).intValue();
					}
				}
			}

			out.print("<p>Mean rating:</p><span id=\"mean-rating-wrapper\" class=\"rating\">");
			for (int j = 0; j < 10; j++) {
				if (j == meanRating - 1)
					out.print("<input type=\"radio\" name=\""
							+"mean-rating\" value=\""
							+ j + "\" checked=\"checked\"></input>");
				else
					out.print("<input type=\"radio\" name=\""
							+"mean-rating\" value=\""
							+ j + "\"></input>");
			}
			out.print("</span>");	
			
			out.print("<script>$(\"#mean-rating-wrapper\").stars({disabled: true});</script>");
			
		}//end of mean rating size !=0
%>
</div>
<div class="clear"></div>


<div id="usage-wrapper">
<h3>Usage statistics</h3>
<div id="usage-tabs">
	<ul>
		<li id="week-link">Week</li>
		<li id="month-link">Month</li>
		<li id="year-link">Year</li>
	</ul>
	<div id="placeholder" style="width:600px;height:100px"></div>
</div>
</div>


<h2>Reviews:</h2>
<ul>
	<%
		IComments[] comments = persistenceManager.findByValue(
					IComments.class, "widid", id, "creationDate", true);
			//ArrayList comments = dbConU.getWidgetComments(id);
			//		Iterator commentsIterator = comments.iterator();

			if (comments != null && comments.length != 0) {

				for (int w = 0; w < comments.length; w++) {

					IStoreUser isu = persistenceManager.findById(
							IStoreUser.class, comments[w].getUserid());
					out.print("<li class=\"reviewer\">");
					String hash = MD5Util.md5Hex(isu.getEmail());
					String imgSrc = "http://www.gravatar.com/avatar/"
							+ hash + "?d=identicon&s=50";
					out.print("<p><img src='" + imgSrc + "'></img></p>");
					out.print("<p><a href=\"profile.jsp?u="
							+ isu.getUsername() + "\">" + isu.getFullname()
							+ "</a></p>");
					out.print("<p><span id=\"" + w
							+ "-rating-wrapper\" class=\"rating\">");

					Map<String, Object> rateParameters = new HashMap<String, Object>();
					rateParameters.put("widid", id);
					rateParameters.put("userid", isu.getId());
					IRating[] ir = persistenceManager.findByValues(
							IRating.class, rateParameters);

					int rating = 1;
					if (ir != null && ir.length != 0) {
						rating = (int) ir[0].getRate();
					}
					for (int j = 0; j < 10; j++) {
						if (j == rating - 1)
							out.print("<input type=\"radio\" name=\""
									+ isu.getUsername()
									+ "-rating\" value=\"" + j
									+ "\" checked=\"checked\"></input>");
						else
							out.print("<input type=\"radio\" name=\""
									+ isu.getUsername()
									+ "-rating\" value=\"" + j
									+ "\"></input>");
					}

					//out.print(com.get("userName"));
					out.print("<script>$(\"#");
					out.print(w);
					out.print("-rating-wrapper\").stars({");
					if (isu.getUsername().equals(userName)) {
						out.print("disabled: false,");
						out.print("callback: function(ui, type, value){");
						out.print("console.log('ui='+ui);");
						out.print("console.log(ui);");
						out.print("console.log('type='+type);");
						out.print("console.log('value'+value);");
						out.print("dataString='username="+userName+"&wid="+id+"&newRate='+value;");
						out.print("$.ajax({");
						out.print("		type: 'POST',");
						out.print("		url : '/wookie/webmenu/ajaxHandlers/updateRating.jsp?',");
						out.print("		data : dataString,");
						out.print("		success : function(m) {");
						out.print("			console.log('Done. Got back:' + m);");
						out.print("		}");						
						out.print("});");
						out.print("}");
						out.print("");						
					} else {
						out.print("disabled: true");
					}
					out.print("});</script>");
					out.print("</span></p>");
					out.print("<p>" + comments[w].getCommentext() + "</p>");
					out.print("<p>"
							+ comments[w].getCreationDate().toString()
							+ "</p>");
					out.print("</li>");

				}
			} else {
				out.print("No comments yet");
			}
	%>
</ul>
<%
	if (userName != null) {
%>
<div id="addNewCommnet"><textarea rows="5" cols="30"
	id="newCommentText"></textarea> <input id="newCommentSubmit"
	type="submit" value="Add comment"></input></div>
</div>
<%
	} else {
%> <a href="login.jsp">Login</a> to comment <%
 	}
 %>

<div id="requires">
<div>
<h2>Dependencies:</h2>
<h3></h3>
<%
	//Get the feature list of this widget
		Collection<IFeature> featuresList = dwidget.getFeatures();
		//find the dependecy feature (if any)
		IFeature dependencyFeature = null;
		Iterator it = featuresList.iterator();
		while (it.hasNext()) {
			IFeature currF = (IFeature) it.next();
			if (currF.getFeatureName().equals(
					"http://widgets.kmi.open.ac.uk/wookie/dependency")) {
				dependencyFeature = currF;
				break;
			}
		}
		if (dependencyFeature != null) {
			out.print("This widget supports interwidget communication. In order to operate as expected the following widgets need to be loaded at the same page.");
			Collection<IParam> paramsList = dependencyFeature
					.getParameters();
			Iterator it2 = paramsList.iterator();
			while (it2.hasNext()) {
				IParam param = (IParam) it2.next();
				String val = param.getParameterValue();
				if (val.equals("isRequired")) {
					out.println("<p>Is required by:"
							+ param.getParameterName() + "</p>");
				}
				if (val.equals("requires")) {
					out.println("<p>Requires:"
							+ param.getParameterName() + "</p>");
				}
			}
		} else {
			out.print("This widget does not support interwidget communication");
		}
		//out.print("<p>"+currF.getFeatureName()+"</p>");
%>
<p></p>

<h3></h3>
</div>
</div>
<div class="clear"></div>
</div>
</div>
<%
	} else {
%>
Sorry no such widget. Something went wrong.
<%
	}
%>
<div id="sub-section">
<div>
<h1>sub-section</h1>
</div>
</div>

<%@ include file="static/footer.html"%>
</body>
</html>