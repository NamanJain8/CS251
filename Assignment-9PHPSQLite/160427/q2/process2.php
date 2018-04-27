<html>
<head>
  <title>Display Data</title>
</head>
<body>
  <?php  ?>
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
      $password = test_input($_POST["password"]);
      $query="select count(*) as num from admin where name='".$name."' AND password='".$password."'";
      $insres=$db->query($query)->fetchArray();
      if ($insres['num']) {
          $query="select * FROM records";
          $insres=$db->query($query);
          echo "<table>";
          echo "<tr><th>Name</th><th> Email</th><th> Moblie</th><th> Account number</th><th> Address</th></tr>\n ";
          while ($row=$insres->fetchArray()) {
              echo "<tr><td>".$row['name']."</td><td> ".$row['email']."</td><td> ".$row['mobile']."</td><td> ".$row['account']."</td><td> ".$row['address']."</td></tr> ";
          }
          echo "</table>";
      } else {
          header('Location:admin.php');
      }
  } else {
      header('Location:admin.php');
  }

  ?>
</body>
</html>
