<%@page import="org.apache.wookie.beans.IWidget"%>
<%@page import="org.apache.wookie.beans.jpa.impl.DescriptionImpl"%>
<%@page import="org.apache.wookie.beans.IDescription"%>
<%@ page import='java.io.*'%>
<%@ page import='java.util.*'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%
            response.setHeader("Content-Type", "text/xml");
            response.setHeader("Cache-Control", "no-cache");

            String q = request.getParameter("q").trim();

            IPersistenceManager persistenceManager = PersistenceManagerFactory.getPersistenceManager();
        	
        	String query = 	"SELECT w "+ 
        					"FROM Widget w,DescriptionImpl d,Name n "+
        					"WHERE w = d.widget AND w = n.widget AND "+
        					"(d.content LIKE '%"+ q + "%' OR n.name LIKE '%"+ q +"%')";
            
            List<IWidget> matchesList = persistenceManager.JPQLQuery(IWidget.class,query);
            
            

            Iterator<IWidget> matchesIterator = matchesList.iterator();
               PrintWriter pw = response.getWriter();
               pw.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n");
                pw.append("<results>\n");
               while (matchesIterator.hasNext ())
               {
            	   IWidget iw = matchesIterator.next();
                   Integer widget_id = new Integer(iw.getId().toString());
                   System.out.println("widget_id="+widget_id);
                   String content = iw.getWidgetDescription();
                   System.out.println("content="+content);
                   String info = iw.getWidgetTitle();
                   System.out.println("info="+info);
                   pw.append("<rs id=\""+widget_id+"\" info=\""+info+"\">\n");
                   pw.append("   "+content+"\n");
                   pw.append("</rs>\n");
               }
                pw.append("</results>");
               
                    



%>
