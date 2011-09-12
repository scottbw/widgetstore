<%@ page import="org.apache.wookie.util.HashGenerator" %>
<%@ page import="org.apache.wookie.w3c.util.RandomGUID" %>
<%@page import="org.apache.wookie.beans.util.IPersistenceManager"%>
<%@page import="org.apache.wookie.beans.util.PersistenceManagerFactory"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%
            String userID = request.getParameter("userID");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String pass = request.getParameter("pass1");
            RandomGUID rg=new RandomGUID();
            String salt = rg.toString();
            String hashedPassword = HashGenerator.getInstance().encrypt(pass+salt);//default hash algorithm is SHA
            String hashedUserNameWS = HashGenerator.getInstance().encrypt(userID+salt);
            
        	IPersistenceManager persistenceManager = PersistenceManagerFactory
			.getPersistenceManager();
            
        	IStoreUser su = persistenceManager.newInstance(IStoreUser.class);
        	
        	su.setEmail(email);
        	su.setFullname(name);
        	su.setSalt(salt);
        	su.setPassword(hashedPassword);
        	su.setHashedUserNameWS(hashedUserNameWS);
        	su.setUsername(userID);
        	
        	persistenceManager.save(su);
        	
        	response.sendRedirect("/wookie/webmenu/WidgetWebMenuServlet?operation=NEW_DESIGN");
%>