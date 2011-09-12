<%@ page import='java.io.*'%>
<%@ page import='java.util.*'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%
	String what = request.getParameter("what");
	String reqUsername = request.getParameter("username");
	String sessionUserName = ((String) session.getAttribute("userName"))
			.trim();

	PrintWriter pw = response.getWriter();
	

	//check if the actual logged in user is  trying to add a comment and not
	//someone else who replicates his crdentials
	if (sessionUserName.equals(reqUsername)) {

		IPersistenceManager persistenceManager = PersistenceManagerFactory
		.getPersistenceManager();
		

	} else {
		pw.append("Not authenticated");
	}
%>
