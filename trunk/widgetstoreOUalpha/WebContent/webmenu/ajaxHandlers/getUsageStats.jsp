<%@page import="org.apache.wookie.beans.jpa.impl.AccessLogImpl"%>
<%@page import="javax.persistence.TemporalType"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import='java.io.*'%>
<%@ page import='java.util.*'%>
<%@ page import='org.apache.wookie.beans.util.IPersistenceManager'%>
<%@ page import='org.apache.wookie.beans.util.PersistenceManagerFactory'%>
<%@ page import='javax.persistence.Query'%>
<%
	String what = request.getParameter("what");
	String widgetid = request.getParameter("wid");
	int wid = Integer.parseInt(widgetid);
	
	//response.setHeader("Content-Type","application/json");
	PrintWriter pw = response.getWriter();
	
	int howMany=-1;
	double step =0;
	if (what.equals("LASTWEEK")){
		howMany=7;
		step=0.5;
	}else if (what.equals("LASTMONTH")){
		howMany=30;
		step=1;
	}else if (what.equals("LASTYEAR")){
		howMany=52;
		step=7;
	}
	
	IPersistenceManager persistenceManager = PersistenceManagerFactory
	.getPersistenceManager();
	
	EntityManager em = persistenceManager.getEntityManager();
	
	long now = System.currentTimeMillis();
	
	pw.append("{");
	pw.append("		\"howMany\" : "+howMany+",");
	pw.append("		\"points\" : [");
	for (int i=0; i<howMany; i++){
		long oneDaysMillis = 24*60*60*1000;
		
		long millisToSubtract  = Math.round(i*step*oneDaysMillis);
		long millisToSubtract2 = Math.round((i+1)*step*oneDaysMillis);
		
		long startDateMillis = now - millisToSubtract2;
		long endDateMillis   = now - millisToSubtract;
		
		Timestamp startDate = new Timestamp(startDateMillis);
		Timestamp endDate   = new Timestamp(endDateMillis);
		
		String queryString = 	"SELECT a "+
								"FROM AccessLogImpl a "+
								"WHERE a.widgetId = ?1 AND (a.accessTime BETWEEN ?2 AND ?3)"+
								""; 
		
		
		List results = em.createQuery(queryString)
				.setParameter(1,wid)
				.setParameter(2,startDate,TemporalType.TIMESTAMP)
				.setParameter(3,endDate,TemporalType.TIMESTAMP)
				.getResultList();
		pw.append("{ \"index\" : "+ startDateMillis +",\"count\":"+results.size()+"}");
		if (i!=howMany-1) pw.append(",");
		//out.print("<p>From :"+startDate.toString()+" to:"+endDate.toString()+" count:"+results.size()+"</p>");
		
		
		
		//for (Object r : results){
		//	if (r instanceof AccessLogImpl){
		//		AccessLogImpl result = (AccessLogImpl) r;
		//		
		//	}
		//}
	}
	
	pw.append("]}");
%>
