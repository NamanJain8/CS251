<html>
	<head>
		<title> Register </title>
		<script>
			function validateForm() {
    		var cname = document.forms["myForm"]["name"].value;
    		var caddress = document.forms["myForm"]["address"].value;
    		var cemail = document.forms["myForm"]["email"].value;
    		var cmobile = document.forms["myForm"]["mobile"].value;
    		var caccount = document.forms["myForm"]["account"].value;
    		var cpassword = document.forms["myForm"]["password"].value;

    		var regname=new RegExp("^[a-zA-Z ]{1,30}$");
    		var regemail=new RegExp("^[a-zA-Z]+@[a-z]+.com$");
    		var regmobile=new RegExp("^[1-9]{1}[0-9]{9}$");
    		var regaccount=new RegExp("^[0-9]{5}$");
    		var regpassword=new RegExp("^[a-zA-Z0-9]{1,20}$");

    		if(regname.test(cname)==0){
    			alert("Invalid Name");
    			return false;
    		}
    		if(caddress.length>=100 || caddress.length==0){
    			alert("Invalid Address")
    		}
    		if(!regemail.test(cemail)){
    			alert("Invalid Email");
    			return false;
    		}
    		if(!regmobile.test(cmobile)){
    			alert("Invalid Mobile No.");
    			return false;
    		}
    		if(!regaccount.test(caccount)){
    			alert("Invalid Bank Ac/No.");
    			return false;
    		}
    		if(!regpassword.test(cpassword)){
    			alert("Invalid Password");
    			return false;
    		}
				return true;
		}
		</script>
	</head>
	<body>
	<h1>Registration</h1>
	<form name="myForm" method="post" onsubmit="return validateForm()" action="process.php">
	Name: <input type="text" name="name"><br><br>
	Address: <input type="text" name="address"><br><br>
	Email: <input type="text" name="email"><br><br>
	Mobile No.: <input type="text" name="mobile"><br><br>
	Bank Ac/No.: <input type="text" name="account"><br><br>
	Password: <input type="password" name="password"><br><br>
	<input type="submit" name="submit" value="Register"><br><br>
	</form>
	<a href="admin.php">See all registrations</a>
	</body>
</html>
