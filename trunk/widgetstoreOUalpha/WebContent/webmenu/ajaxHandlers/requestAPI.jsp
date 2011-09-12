<%@page import="org.apache.wookie.beans.util.IPersistenceManager"%>
<%@page import="org.apache.wookie.beans.util.PersistenceManagerFactory"%>
<%@page import="org.apache.wookie.helpers.WidgetKeyManager"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.IApiKey"%>
<%@page import="org.apache.wookie.beans.jpa.impl.ApikeyWidgetImpl"%>
<%@page import="org.apache.wookie.util.HashGenerator"%>
<%@page import="org.apache.wookie.w3c.util.RandomGUID"%>
<%@ page import='java.io.PrintWriter'%>
<% 

String reqUsername = request.getParameter("username");
String sessionUserName = ((String) session.getAttribute("userName"))
		.trim();

PrintWriter pw = response.getWriter();

//check if the actual logged in user is  trying to add a comment and not
//someone else who replicates his crdentials
if (sessionUserName.equals(reqUsername)) {
	
	IPersistenceManager persistenceManager = PersistenceManagerFactory
	.getPersistenceManager();
IStoreUser isu = persistenceManager.getStoreUser(sessionUserName);
String userEmail = isu.getEmail();


int userid = (isu != null) ?  isu.getId() : 0;
String email = (isu!=null) ? isu.getEmail() : "noEmail";
IApiKey key = persistenceManager.newInstance(IApiKey.class);
key.setEmail(email);
key.setUserId(userid);

// generate a nonce
RandomGUID r = new RandomGUID();
String nonce = "nonce-" + r.toString();

// now use SHA hash on the nonce				
String hashKey = HashGenerator.getInstance().encrypt(nonce+email);	

// get rid of any chars that might upset a url...
hashKey = hashKey.replaceAll("=", ".eq."); 
hashKey = hashKey.replaceAll("\\?", ".qu."); 
hashKey = hashKey.replaceAll("&", ".am."); 
hashKey = hashKey.replaceAll("\\+", ".pl."); 

key.setValue(hashKey);
persistenceManager.save(key);

IApiKey[] keyJustEntered = persistenceManager.findByValue(IApiKey.class, "value", hashKey);

Integer apiKeyId = new Integer(keyJustEntered[0].getId().toString());

ApikeyWidgetImpl apiW = new ApikeyWidgetImpl();
apiW.setAPIkeyID(apiKeyId.intValue());
apiW.setWidgetId(0);//set 0 as default to allow access to all widgets

persistenceManager.save(apiW);

pw.append("SUCCESS:"+hashKey);

}else {
	pw.append("NOT AUTHENTICATED");
}

%>