/**
 * 
 */
$(document).ready(function() {

	var username = $('#userName').text().trim();
	
	function fnameClickHandler(el){
		$(el).hide();
		$(el).parent().append("<input type='text' id='newFullName'></input>"+
				"<input type='submit' id='newFullNameSubmit'></input>");
		$('#newFullNameSubmit').click(function(){
			var newFullName = $('#newFullName').val();
			var url = "ajaxHandlers/changeProfileData.jsp?what=fname&fname="+newFullName+"&username="+username;
			$.ajax({
				   type: "POST",
				   url: url,
				   success: function(msg){
				     //alert( "Data Saved: " + msg );
					   var parentPar = $('#newFullNameSubmit').parent();
					   $(parentPar).html("Full name: "+newFullName+"<button id='changeFullNameBtn'>Change</button>");  
					   $('#changeFullNameBtn').click(function(){
						  fnameClickHandler($(this)); 
					   });
				   },
				   error :function(m,n){
					   
				   },
				   complete: function(m){
					   
				   }
				 });
		});
	}
	
	$('#changeFullNameBtn').click(function() {
		fnameClickHandler($(this));
	});

	function unameClickHandler(el){
		$(el).hide();
		$(el).parent().append("<input type='text' id='newUserName'></input>"+
				"<input type='submit' id='newUserNameSubmit'></input>");
		$('#newUserNameSubmit').click(function(){
			var newUserName = $('#newUserName').val();
			var url = "ajaxHandlers/changeProfileData.jsp?what=uname&uname="+newUserName+"&username="+username;
			$.ajax({
				   type: "POST",
				   url: url,
				   success: function(msg){
				     //alert( "Data Saved: " + msg );
					   var parentPar = $('#newUserNameSubmit').parent();
					   $(parentPar).html("Username: "+newUserName+"<button id='changeUserNameBtn'>Change</button>");  
					   $('#changeUserNameBtn').click(function(){
						  unameClickHandler($(this)); 
					   });
					   $('#userName').text(newUserName);//username contained in header
					   
				   },
				   error :function(m,n){
					   
				   },
				   complete: function(m){
					   
				   }
				 });
		});
	}
	
	
	$('#changeUserNameBtn').click(function() {
		unameClickHandler($(this));
	});

	function emailClickHandler(el){
		$(el).hide();
		$(el).parent().append("<input type='text' id='newEmail'></input>"+
				"<input type='submit' id='newEmailSubmit'></input>");
		$('#newUserNameSubmit').click(function(){
			var newEmail = $('#newEmail').val();
			var url = "ajaxHandlers/changeProfileData.jsp?what=email&email="+newEmail+"&username="+username;
			$.ajax({
				   type: "POST",
				   url: url,
				   success: function(msg){
				     //alert( "Data Saved: " + msg );
					   var parentPar = $('#newEmailSubmit').parent();
					   $(parentPar).html("Email: "+newEmail+"<button id='changeEmailBtn'>Change</button>");  
					   $('#changeEmailBtn').click(function(){
						  emailClickHandler($(this)); 
					   });				   					   
				   },
				   error :function(m,n){
					   
				   },
				   complete: function(m){
					   
				   }
				 });
		});
	}
	
	$('#changeEmailBtn').click(function() {
		emailClickHandler($(this));
	});
	
	function passClickHandler(el){
		$(el).hide();
		$(el).parent().append("<ul><li>Old pass:<input type='password' id='oldPass'></input></li>"+
				"<li>New pass:<input type='password' id='newPass'></input></li>"+
				"<li>Confirm new pass:<input type='password' id='newPass2'></input></li>"+
				"<li><input type='submit' id='newPassSubmit' value='Change pass'></input></li></ul>");
		$('#newPassSubmit').click(function(){
			var oldPass = $('#oldPass').val();
			var newPass = $('#newPass').val();
			var newPass2 = $('#newPass2').val();
			var url = "ajaxHandlers/changeProfileData.jsp?what=pass&oldpass="+oldPass+"&newPass="+newPass+"&username="+username;
			$.ajax({
				   type: "POST",
				   url: url,
				   success: function(msg){
				     //alert( "Data Saved: " + msg );
					   var parentPar = $('#newPassSubmit').parent();
					   $(parentPar).html("<button id='changePassBtn'>Change password</button>");  
					   $('#changePassBtn').click(function(){
						  passClickHandler($(this)); 
					   });				   					   
				   },
				   error :function(m,n){
					   
				   },
				   complete: function(m){
					   
				   }
				 });
		});
	}
	$('#changePassBtn').click(function() {
		passClickHandler($(this));
	});
	
	
	
	
	$('#requestAPIBtn').click(function(){
		console.log("request api key clicked");
		$.ajax({
			   type: "POST",
			   url: "ajaxHandlers/requestAPI.jsp",
			   data: "username="+username,
			   success: function(msg){
			     		   console.log("success. Got back="+msg);					   
			   },
			   error :function(m,n){
				   
			   },
			   complete: function(m){
				   
			   }
			 });
	});
	
	
	

});