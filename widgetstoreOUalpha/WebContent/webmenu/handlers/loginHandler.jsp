<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.jpa.impl.StoreUserImpl"%>
<%@ page import="org.apache.wookie.util.HashGenerator"%>
<%@page import="org.apache.wookie.beans.util.IPersistenceManager"%>
<%@page import="org.apache.wookie.beans.util.PersistenceManagerFactory"%>
<%
	Boolean authenticated = false;
	String name = request.getParameter("name");
	String pass = request.getParameter("pass");
	String prev = request.getParameter("prevPage");

	IPersistenceManager persistenceManager = PersistenceManagerFactory
			.getPersistenceManager();
	IStoreUser su = persistenceManager.getStoreUser(name);

	String hashedUserNameWithSalt = null;
	String hashedPassFromDB = null;
	String salt = null;

	System.out.println("prev page=" + prev);

	if (su == null) {
		//no user with such a username

	} else {
		salt = su.getSalt();
		hashedPassFromDB = su.getPassword();
		hashedUserNameWithSalt = su.getHashedUserNameWS();

		if (salt != null && hashedPassFromDB != null) {
			String hashedPassFromUser = HashGenerator.getInstance()
					.encrypt(pass + salt);
			if (hashedPassFromDB.equals(hashedPassFromUser)) {
				authenticated = true;
				//System.out.println(name+" authenticated");
			}
		}

		if (authenticated) {
			//if present remove other attributes 
			session.removeAttribute("failed");
			session.removeAttribute("noSuchUser");
			session.setAttribute("userName", name);
			session.setAttribute("hashedUserNameWithSalt",
					hashedUserNameWithSalt);
			if (prev == null) {
				response.sendRedirect("/wookie/webmenu/WidgetWebMenuServlet?operation=NEW_DESIGN");
			} else {
				response.sendRedirect(prev);
			}
		} else if (salt == null && hashedPassFromDB == null) {//no such user
			session.removeAttribute("failed");
			session.setAttribute("noSuchUser", true);
			response.sendRedirect("/wookie/webmenu/login.jsp");
		}
	}

	if (!authenticated) {
		session.removeAttribute("noSuchUser");
		session.setAttribute("failed", true);
		response.sendRedirect("/wookie/webmenu/login.jsp");
	}
%>