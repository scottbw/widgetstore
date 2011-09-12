<%@page import="org.apache.wookie.beans.ITagsWidgets"%>
<%@page import="org.apache.wookie.beans.ITags"%>
<%@page import="org.eclipse.jdt.core.dom.SwitchStatement"%>
<%@ page import='java.io.*'%>
<%@ page import='java.util.*'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%
	String tagsText = request.getParameter("tagsText").trim();
	String reqUsername = request.getParameter("uname").trim();
	int widid = Integer.parseInt(request.getParameter("widid").trim());
	String sessionUserName = ((String) session.getAttribute("userName"))
			.trim();

	PrintWriter pw = response.getWriter();
	
	IPersistenceManager persistenceManager = PersistenceManagerFactory
	.getPersistenceManager();
	
	ArrayList<String> newlyInsertedTags = new ArrayList<String>();
	if (sessionUserName.equals(reqUsername)) {
		String[] tags=tagsText.split(" ");
		
		for(int j=0;j<tags.length;j++){
			System.out.println("j="+j+"\t"+tags[j]);
		}
		
		
		for(int j=0;j<tags.length;j++){
			ITags[] itag = persistenceManager.findByValue(ITags.class,"tagtext",tags[j]);
			if (itag.length==0){//if tag not already exists
				ITags newITag = persistenceManager.newInstance(ITags.class);
				newITag.setTagText(tags[j]);
				persistenceManager.save(newITag);
			}
			
			System.out.println("Tag ["+tags[j]+"] saved...");
			
			//get th id of either the just inserted tag or the tag already exists in DB 
			ITags[] currItag = persistenceManager.findByValue(ITags.class,"tagtext",tags[j]);
			int tagid = new Integer(currItag[0].getId().toString());
			
			System.out.println("Id of ["+tags[j]+"] is "+tagid);
			
			//Check if widget is already tagged with this tag
			Map<String,Object> itagwidParameters = new HashMap<String,Object>();
			itagwidParameters.put("tagid",tagid);
			itagwidParameters.put("widid",widid);
			
			System.out.println("Checking to see if tag ["+tagid+"] already annotated to widget ["+widid+"]");
			
			ITagsWidgets[] itagwids = persistenceManager.findByValues(ITagsWidgets.class,itagwidParameters);
			if (itagwids.length == 0){
				System.out.println("Not annotated");
				ITagsWidgets newITagWid = persistenceManager.newInstance(ITagsWidgets.class);
				newITagWid.setTagid(tagid);
				newITagWid.setWidid(widid);
				System.out.println("Going to save...");
				persistenceManager.save(newITagWid);
				newlyInsertedTags.add(tags[j]);
			}else {
				//do nothing
				System.out.println("Tag ["+tags[j]+"] already annotated to widget");
			}		
		}
		pw.append("SUCCESS:");
		for (String newTag : newlyInsertedTags){
			pw.append(newTag+":");
		}
			
		


	} else {
		pw.append("Not authenticated");
	}
%>
