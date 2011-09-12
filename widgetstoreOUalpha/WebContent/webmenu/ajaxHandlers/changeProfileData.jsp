<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@ page import="org.apache.wookie.util.HashGenerator"%>
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
		IStoreUser isu = persistenceManager
				.getStoreUser(sessionUserName);

		if (what.equals("fname")) {//change full name
			String newFName = request.getParameter("fname");
			isu.setFullname(newFName);
			persistenceManager.save(isu);
			pw.append("SUCCESS:" + newFName);
		} else if (what.equals("uname")) {//change user name
			String newUName = request.getParameter("uname");
			isu.setUsername(newUName);
			String salt = isu.getSalt();
			String hashedUserNameWS = HashGenerator.getInstance().encrypt(newUName + salt);
			isu.setHashedUserNameWS(hashedUserNameWS);
			persistenceManager.save(isu);
			session.setAttribute("userName", newUName);//also change the user name attribute in session
			pw.append("SUCCESS:" + newUName);
		} else if (what.equals("pass")) {//change password
			String oldPass = request.getParameter("oldPass").trim();
			String newPass = request.getParameter("newPass").trim();
			String salt = isu.getSalt();
			String oldHashedPassword = HashGenerator.getInstance().encrypt(oldPass + salt);
			String currentHashedPassInDB = isu.getPassword();
			
			
			System.out.println("old hashed="+oldHashedPassword);
			System.out.println("pass from DB = "+currentHashedPassInDB);
			
			
			if (oldHashedPassword.equals(currentHashedPassInDB)) {
				String hashedPassword = HashGenerator.getInstance()
						.encrypt(newPass + salt);//default hash algorithm is SHA				
				isu.setPassword(hashedPassword);				
				persistenceManager.save(isu);
				pw.append("SUCCESS:");
			}else {
				pw.append("WRONG_PASS");
			}
		} else if (what.equals("email")) {//change user name
			String newEmail = request.getParameter("email");
			isu.setEmail(newEmail);
			persistenceManager.save(isu);
			pw.append("SUCCESS:" + newEmail);
		}

	} else {
		pw.append("Not authenticated");
	}
%>
