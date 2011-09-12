<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
        <link rel="shortcut icon" href="../shared/images/favicon.ico" type="image/ico" />
        <link rel="stylesheet" href="../shared/css/registration.css" type="text/css" media="screen" />
    </head>
    <body>

        <div id="formWrapper">
        <h2>Registration page</h2>
        <form method="post" action="handlers/registrationHandler.jsp">
            <div>
                <label for="name">Name</label>
                <input id="name" name="name" type="text" />
                <span id="nameInfo">What's your real name?</span>
            </div>
            <div>
                <label for="userID">userID</label>
                <input id="userID" name="userID" type="text" />
                <span id="userInfo">what's your desired ID ,you will need it to log in</span>
            </div>
            <div>
                <label for="email">E-mail</label>
                <input id="email" name="email" type="text" />
                <span id="emailInfo">Valid E-mail please</span>
            </div>
            <div>
                <label for="pass1">Password</label>
                <input id="pass1" name="pass1" type="password" />
                <span id="pass1Info">At least 5 characters: letters, numbers and '_'</span>
            </div>
            <div>
                <label for="pass2">Confirm Password</label>
                <input id="pass2" name="pass2" type="password" />
                <span id="pass2Info">Confirm password</span>
            </div>
            <div>
                <input id="register" name="register" type="submit" value="register" />
            </div>
        </form>
        </div>
    </body>
</html>
