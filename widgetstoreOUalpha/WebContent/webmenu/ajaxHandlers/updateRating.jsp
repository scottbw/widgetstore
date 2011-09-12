<%@page import="org.apache.wookie.beans.IRating"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@ page import='java.io.*'%>
<%@ page import='java.util.*'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%
	String reqUsername = request.getParameter("username");

	String newR = request.getParameter("newRate");
	double newRate = Double.parseDouble(newR);

	String widid = request.getParameter("wid");//widget id
	int wid = Integer.parseInt(widid);

	String sessionUserName = ((String) session.getAttribute("userName"))
			.trim();

	PrintWriter pw = response.getWriter();

	System.out.println("newRate=" + newRate);
	System.out.println("user=" + reqUsername);

	//check if the actual logged in user is  trying to update the rate and not
	//someone else who replicates his credentials
	if (sessionUserName.equals(reqUsername)) {

		IPersistenceManager persistenceManager = PersistenceManagerFactory
				.getPersistenceManager();

		IStoreUser[] u = persistenceManager.findByValue(
				IStoreUser.class, "username", reqUsername);
		if (u.length != 0) {
			int userid = u[0].getId();
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userid", userid);
			params.put("widid", wid);
			IRating[] ir = persistenceManager.findByValues(
					IRating.class, params);
			if (ir.length != 0) {
				ir[0].setRate(newRate);
				persistenceManager.save(ir[0]);
			}
		}

	} else {
		pw.append("Not authenticated");
	}
%>
