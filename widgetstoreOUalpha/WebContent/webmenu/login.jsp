<%-- 
    Document   : index
    Created on : 25 Νοε 2008, 9:06:30 μμ
    Author     : Lucas
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../shared/css/login.css" type="text/css" media="screen" />
        <title></title>
        <link rel="shortcut icon" href="../shared/images/favicon.ico" type="image/ico" />
    </head>
    <body>

        <div id="formWrapper"> 
        <h2>Login page</h2>
        <%
            if (session.getAttribute("unauthorized")!=null){
                out.println("<p>You 've tried to access an unauthorized page</p>");
                out.println("<p>Please login before trying to access unautorized pages</p>");
            }
             if (session.getAttribute("failed")!=null){
                out.println("<p>Login failed</p>");
                out.println("<p>Username and password do not match.</p>");
            }else if (session.getAttribute("noSuchUser")!=null){
                 out.println("<p>Sorry</p>");
                 out.println("<p>No such user found in system</p>");
             }
            if (session.getAttribute("newRegistration")!=null){
                out.println("<p>Your registration was succesful</p>");
                out.println("<p>Go ahead and log in.</p>");
            }            
       %>
        
            <form type="post" action="handlers/loginhandler.jsp">
                <input name="prevPage" type="hidden" value="<% out.print(request.getHeader("Referer"));%>"></input>
                <div>
                    <label for="usr_name">userID</label>
                    <input id="name" name="name" type="text" />
                    <span id="nameInfo">What's your name?</span>
                </div>
                <div>
                    <label for="usr_password">password</label>
                    <input id="pass" name="pass" type="password" />
                    <span id="passInfo">Your password</span>
                </div>
                <div>
                    <input id="login" name="login" type="submit" value="login" />
                </div>
            </form>
            <p>Not a user yet? Go ahead and <a href="registerForm.jsp">register</a></p>
            
        </div>
   
        
        
    </body>
</html>