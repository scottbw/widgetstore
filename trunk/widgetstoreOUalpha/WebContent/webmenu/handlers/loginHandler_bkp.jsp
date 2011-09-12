<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="org.apache.wookie.util.HashGenerator" %>
<%
			Boolean authenticated=false;
            String name = request.getParameter("name");
            String pass = request.getParameter("pass");            
            Connection conn=null;
            
            String salt = null;
            String hashedPassFromDB = null;
            String hashedUserNameWithSalt = null;
            
            try
            {
                String userName = "java";
                String password = "java";
                String url = "jdbc:mysql://localhost:3306/widgetdb";
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                conn = DriverManager.getConnection (url, userName, password);
                System.out.println ("Database connection established");
                
                String getPassNSalt="SELECT salt,password,hashedUserNameWS FROM storeusers WHERE username=?";
                PreparedStatement ps=conn.prepareStatement(getPassNSalt);
                ps.setString(1,name);
                
                ResultSet rs = ps.executeQuery();
                
                if (rs.next()) {
                     salt= rs.getString(1);
                     hashedPassFromDB=rs.getString(2);
                     hashedUserNameWithSalt=rs.getString(3);
                }else {}
                
                ps.close();
                rs.close();
                if (salt!=null && hashedPassFromDB!=null){
                	String hashedPassFromUser=HashGenerator.getInstance().encrypt(pass+salt);
                	if (hashedPassFromDB.equals(hashedPassFromUser)) {
                		authenticated=true;
                		//System.out.println(name+" authenticated");
                	}                	
                }
            }
            catch (Exception e)
            {
                System.err.println ("Cannot connect to database server");
                e.printStackTrace();
            }
            finally
            {
                if (conn != null)
                {
                    try
                    {
                        conn.close ();
                        System.out.println ("Database connection terminated");
                    }
                    catch (Exception e) { /* ignore close errors */ }
                }
            }
            
            if (authenticated) {
            	//if present remove other attributes 
            	session.removeAttribute("failed");
            	session.removeAttribute("noSuchUser");
            	session.setAttribute("userName",name);
            	session.setAttribute("hashedUserNameWithSalt",hashedUserNameWithSalt);
            	response.sendRedirect("http://localhost:12121/wookie/webmenu/WidgetWebMenuServlet?operation=NEW_DESIGN");
            }	
            else if (salt==null && hashedPassFromDB==null) {//no such user
            	session.removeAttribute("failed");
            	session.setAttribute("noSuchUser",true);
            	response.sendRedirect("/wookie/webmenu/login.jsp");
            }else {
            	session.removeAttribute("noSuchUser");
            	session.setAttribute("failed",true);
            	response.sendRedirect("/wookie/webmenu/login.jsp");
            }
            
            
%>