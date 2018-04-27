<?php
      // define variables and set to empty values
      $db = new SQLite3('data.db');

      if (isset($_POST['submit'])) {
          function test_input($data)
          {
              $data = trim($data);
              $data = stripslashes($data);
              $data = htmlspecialchars($data);
              return $data;
          }
          $name = test_input($_POST["name"]);
          $address = test_input($_POST["address"]);
          $email = test_input($_POST["email"]);
          $mobile = test_input($_POST["mobile"]);
          $account = test_input($_POST["account"]);
          $password = test_input($_POST["password"]);


          $query="select count(*) as num from records where email='";
          $query.=$_POST["email"];
          $query.="'";
          $insres=$db->query($query)->fetchArray();
          if ($insres['num']==0) {
              $query="select count(*) as num from accounts where account='".$account."' AND password='".$password."'";
              $insres=$db->query($query)->fetchArray();
              if ($insres['num']) {
                  $query="select * from accounts where account='".$account."' AND password='".$password."'";
                  $insres=$db->query($query);
                  $obj=$insres->fetchArray();
                  $bal=(int)($obj['balance'])-1000;
                  if ($bal>=0) {
                      $query1="update `accounts` set balance='".$bal."' where account='".$account."'";
                      $query2="insert into `records` values ('".$name."', '".$address."', '".$email."', '".$mobile."', '".$account."', '".$password."' );";
                      if ($db->query($query1)==true&&$db->query($query2)==true) {
                          echo "<script>alert('Data submitted successfully!')</script>";
                          echo "<html>
                          <body>
                          <a href='register.php'>Submit another record</a>
                          </body>
                          </html>";
                      }
                  } else {
                      echo "<script>alert('Insufficient balance in account');</script>";
                      echo "<html>
                      <body>
                      <a href='register.php'>Try Again</a>
                      </body>
                      </html>";
                  }
              } else {
                  echo "<script>alert('Invalid account/password');</script>";
                  echo "<html>
                  <body>
                  <a href='register.php'>Try Again</a>
                  </body>
                  </html>";
              }
          } else {
              echo "<script>alert('User already existed');</script>";
              echo "<html>
              <body>
              <a href='register.php'>Try Again</a>
              </body>
              </html>";
          }
      } else {
          header('Location:register.php');
      }
