<html>
<head>
  <title>Administrator</title>
  <script>
    function validateForm(){
      var cname = document.forms["myForm"]["name"].value;
      var cpassword = document.forms["myForm"]["password"].value;

      var regname=new RegExp("^[a-zA-Z ]{1,30}$");
      var regpassword=new RegExp("^[a-zA-Z0-9]{1,20}$");

      if(regname.test(cname)==0){
        alert("Invalid Name");
        return false;
      }
      if(!regpassword.test(cpassword)){
        alert("Invalid Password");
        return false;
      }

    }
  </script>
</head>
<body>
  <form action="process2.php" method="post" onsubmit="return validateForm()">
    <h1> Admin Login</h1>
    Username: <input type="text" name="name"><br><br>
    Password: <input type="password" name="password">
    <input type="submit" name="submit" value="login">
  </form>
</body>
</html>
