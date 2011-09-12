<%@page import="org.apache.wookie.beans.ITagsWidgets"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.wookie.beans.util.IPersistenceManager"%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.apache.wookie.beans.jpa.impl.TagsImpl"%>
<%@page import="org.apache.wookie.beans.util.PersistenceManagerFactory"%>
<%
	response.setHeader("Cache-Control", "no-cache");

	String tag = request.getParameter("tag").trim();

	String widgetId = request.getParameter("wid").trim();

	//System.out.println("widg id passed="+widgetId);
	System.out.println("tag="+tag);

	IPersistenceManager persistenceManager = PersistenceManagerFactory
			.getPersistenceManager();

	List<ITags> tags = persistenceManager.findLike(tag);

	PrintWriter pw = response.getWriter();

	if (tags == null)
		pw.append("No tags suggestions");
	else {
		Iterator tagsIterator = tags.iterator();

		//Return in JSON format
		pw.append("[");
		while (tagsIterator.hasNext()) {
			TagsImpl t = (TagsImpl) tagsIterator.next();
			if (!widgetId.equals("")) {
				int widid = Integer.parseInt(widgetId);
				//System.out.println("tag id="+t.getId());
				Map<String, Object> tagWidParameters = new HashMap<String, Object>();
				tagWidParameters.put("tagid", t.getId());
				tagWidParameters.put("widid", widid);
				ITagsWidgets[] itw = persistenceManager.findByValues(
						ITagsWidgets.class, tagWidParameters);
				//System.out.println("itw length="+itw.length);
				if (itw.length == 0) {//if widget not already tagged with this id 
					pw.append("\"" + t.getTagtext() + "\"");
					if (tagsIterator.hasNext()) {//if it is not the last element
						pw.append(",");
					}
				}
			} else {
				pw.append("\"" + t.getTagtext() + "\"");
				if (tagsIterator.hasNext()) {//if it is not the last element
					pw.append(",");
				}
			}
		}
		pw.append("]");
	}
%>

