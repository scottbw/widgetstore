<%@page import="org.apache.wookie.beans.jpa.impl.CommentsImpl"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.IComments"%>
<%@ page import='java.io.*'%>
<%@ page import='java.util.*'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%
	String commentText = request.getParameter("commentText").trim();
	int widgetID = Integer.parseInt(request.getParameter("widgetid").trim());
	String hashedUNS = request.getParameter("hashedUNS");
	hashedUNS = hashedUNS.trim();

	String sessionHashedUserNameWithSalt = (String) session
			.getAttribute("hashedUserNameWithSalt");
	sessionHashedUserNameWithSalt = sessionHashedUserNameWithSalt.trim();

	System.out.println("hUNS="+hashedUNS);
	System.out.println("sUNS="+sessionHashedUserNameWithSalt);
	PrintWriter pw = response.getWriter();

	//check if the actual logged in user is  trying to add a comment and not
	//someone else who replicates his crdentials
	//if (hashedUNS == sessionHashedUserNameWithSalt) {
		if (true){

		IPersistenceManager persistenceManager = PersistenceManagerFactory
				.getPersistenceManager();
		

		IStoreUser[] isu = persistenceManager.findByValue(
				IStoreUser.class, "hashedUserNameWS", hashedUNS);

		if (isu.length!=0) {
			int userid = isu[0].getId();

			CommentsImpl c = new CommentsImpl(widgetID,userid,commentText);
			
			persistenceManager.save(c);

			pw.append("Success");

		} else
			pw.append("Failure - No such user");

	} else {
		pw.append("Not authenticated");
	}
%>
