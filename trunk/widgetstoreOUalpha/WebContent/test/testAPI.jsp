<%@page import="org.apache.wookie.beans.jpa.impl.CommentsImpl"%>
<%@page import="org.apache.wookie.beans.IComments"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.ITagsWidgets"%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.apache.wookie.beans.jpa.impl.ApikeyWidgetImpl"%>
<%@page import="org.apache.wookie.beans.IApikeyWidget"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.wookie.beans.util.IPersistenceManager"%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.apache.wookie.beans.IStoreUser"%>
<%@page import="org.apache.wookie.beans.jpa.impl.TagsImpl"%>
<%@page import="org.apache.wookie.beans.jpa.impl.TagsFreqImpl"%>
<%@page import="org.apache.wookie.beans.util.PersistenceManagerFactory"%>
<%


	response.setHeader("Cache-Control", "no-cache");

	//String tag = request.getParameter("tag");

	PrintWriter pw = response.getWriter();

	IPersistenceManager persistenceManager = PersistenceManagerFactory
			.getPersistenceManager();
	
	String query0 = 	"SELECT NEW org.apache.wookie.beans.jpa.impl.TagsFreqImpl(t.id, '', count(t.tagid)) "+
					"FROM TagsWidgetsImpl t "+
					//"WHERE t.id=t2.id "+
					"GROUP BY t.id"+
					"";
	String query = 	"SELECT tw.tagid, count(tw.tagid) "+
	"FROM TagsWidgetsImpl tw "+
	//"WHERE tw.tagid=t2.id "+
	"GROUP BY tw.tagid "+
	"ORDER BY count(tw.tagid) DESC";
	
	String query1 =	"SELECT tw.tagid, count(tw.tagid), max(count(tw.tagid)) "+
	"FROM TagsWidgetsImpl tw "+
	"GROUP BY tw.tagid "+
	"";
	
	List<Object> freqs = persistenceManager.JPQLQuery(Object.class,query);
	
	for (Object o : freqs){
		//out.print("<p>"+tf.getTagText()+" "+tf.getFreq()+"</p>");
		//out.print("<p>"+o+"</p>");
		if (o instanceof Object[]) {
			Object[] oo = (Object[])o;
			out.println("id="+oo[0]+" freq="+oo[1]);
                //for (Object o2 : (Object[])o) {
                //    out.println(o2 + " : ");
                //}
                out.println("<br/>");
            } else {
                out.println(o + "<br/>");
            }
	}
	
	
	
	/*
	ApikeyWidgetImpl apiW = new ApikeyWidgetImpl();
	apiW.setAPIkeyID(1111);
	apiW.setWidgetId(0);//set 0 as default to allow access to all widgets
	
	persistenceManager.save(apiW);
	
	/*IPersistenceManager persistenceManager2 = PersistenceManagerFactory
	.getPersistenceManager();
	ITagsWidgets[] itws = persistenceManager.findByValue(
			ITagsWidgets.class, "widid", 1);
//out.print("itws l = "+itws.length);
	if (itws != null && itws.length != 0) {
		
		for (int i = 0; i < itws.length; i++) {
			Integer tagid = (Integer)itws[i].getTagid();
			out.print(" "+tagid);
			ITags tag = persistenceManager2.findById(ITags.class,1);				
			out.print("<span class='tagSpan'>" + tag.getTagtext() + "</span>");
		}
	}else {
		out.print("no tags yet");
	}*/
%>

