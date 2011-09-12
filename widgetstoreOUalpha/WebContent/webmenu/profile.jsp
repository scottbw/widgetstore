<%@page import="org.apache.wookie.beans.IAccessLog"%>
<%@page import="org.apache.wookie.beans.IApikeyWidget"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.apache.wookie.beans.IApiKey"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.util.IPersistenceManager"%>
<%@page import="org.apache.wookie.beans.util.PersistenceManagerFactory"%>
<%@page import="org.apache.wookie.util.MD5Util"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
	String username = request.getParameter("u");
	PrintWriter pw = response.getWriter();
	IPersistenceManager persistenceManager = PersistenceManagerFactory
			.getPersistenceManager();
	IStoreUser isu = null;
	if (username != null) {
		isu = persistenceManager.getStoreUser(username);

		if (isu != null) {

			int userId = isu.getId();
			IApiKey[] keysOfUser = persistenceManager.findByValue(
					IApiKey.class, "userID", userId);
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP Page</title>
<link type="text/css" href="../newLayout.css" rel="stylesheet" />
<script type="text/javascript"
	src="/wookie/shared/js/jquery/jquery-1.3.2.min.js"></script>
	<script type="text/javascript"
	src="/wookie/shared/js/profile.js"></script>
</head>
<body>
<%@ include file="static/header.html"%>
<div id="content">


<h2>Profile page</h2>
<p>This would be the profile paghe for <%
	out.println(username);
%>
</p>

<h3>details</h3>
<p>
<%
	String hash = MD5Util.md5Hex(isu.getEmail());
			String imgSrc = "http://www.gravatar.com/avatar/" + hash
					+ "?d=identicon";
%> <img src="<%out.print(imgSrc);%>"></img></p>
<p>Username: <%
	out.print(username);
%>
<% if (username.equals(userName)){%>
<button id="changeUserNameBtn">Change</button>
<%} %>
</p>
<p>Full name: <%
	out.print(isu.getFullname());
%>
<% if (username.equals(userName)){//userName is the session name,username is the request parameter%>
<button id="changeFullNameBtn">Change</button>
<%} %>
</p>
<p>Email: <%
	out.print(isu.getEmail());
%>
<% if (username.equals(userName)){//userName is the session name,username is the request parameter%>
<button id="changeEmailBtn">Change</button>
<%} %>
</p>
<p>
<% if (username.equals(userName)){%>
<button id="changePassBtn">Change password</button>
<%} %>
</p>

<%
	if (keysOfUser != null && keysOfUser.length != 0) {
%>
<h3>Api s assigned to you</h3>
<ul>
	<%
		for (IApiKey key : keysOfUser) {
						out.print("<li><p>" + key.getValue());
						IApikeyWidget[] apiW = persistenceManager
								.findByValue(IApikeyWidget.class, "apiKey",
										key.getId());
						if (apiW != null && apiW.length != 0) {
							if (apiW[0].getWidgetId()==0) {
								out.print("Allowed to access all widgets");
							}else {
								out.print("Allowed to access the following widgets");
								out.print("<ul>");
								for (int j=0;j<apiW.length;j++){
									out.print("<li>"+apiW[j].getWidgetId()+"</li>");
								}
								out.print("</ul>");
							}
							out.print("<div><p>AccessLog</p>");
							IAccessLog[] alogs = persistenceManager.findByValue(IAccessLog.class,"ApiKeyId",key.getId());
							if (alogs!=null && alogs.length!=0){
								out.print("<table>");
								out.print("<tr><th>Widget id</th><th>Container user</th><th>Access time</th></tr>");								
								for (int i=0;i<alogs.length;i++){
									out.print("<tr><td>"+alogs[i].getWidgetId()+"</td><td>"+alogs[i].getContainerUser()+"</td><td>"+alogs[i].getAccessTime().toString()+"</td></tr>");
								}
								out.print("</table>");
							}
							out.print("</p>");
						}
						out.print("</p></li>");
					}
	%>
</ul>
<%
		} else {
%>
No Api keys assigned
<%
	}
%>
<% if (username.equals(userName)){//userName is the session name,username is the request parameter%>
<p>
<button id="requestAPIBtn">Request API key</button>
</p>
<%} %>
<%
		}else {
			out.print("No such user");
		}
	}//username is not null
	else {

		out.print("Some problem popped up");
	}
%>
</div>
<div id="sub-section">
<div>
<h1>sub-section</h1>
</div>
</div>
<%@ include file="static/footer.html"%>
</body>
</html>