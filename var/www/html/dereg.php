<?php
/* CSRF token generator */
    session_start();
    if (empty($_SESSION['token'])) {
        $_SESSION['token'] = bin2hex(random_bytes(32));
    }
    $token = $_SESSION['token'];
?>
<head>
    <title>Tacacs+ Deregistration</title>
    <meta charset="utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="favicon-16x16.png" sizes="16x16">
    <link rel="stylesheet" href="style.css" type="text/css">
</head>
<body class="blackbackground">
    <h1 class="title whitetext">Tacacs+ Deregistration</h1>
    <div class="form-box darkform-box">
    <form>
            <span id="confirmUsername" class="confirmUsername"></span>
            <input placeholder="User Name" type="username" name="username" id="username" onkeyup="checkUser(); return false">
            <span id="confirmEmail" class="confirmEmail"></span>
            <input placeholder = "Email" type="email" name="usermail" id="usermail">
            <span id="confirmName" class="confirmName"></span>
            <input placeholder="Full Name: " type="fullname" name="fullname" id="fullname" onkeyup="checkName(); return false;">
        <td><button class="btn btn-primary" id="submit">Submit</button></td>
    </form>
    </div>
    <div class="url-box">
      <form action="register.php">
        <input type="submit" value="Register" />
      </form>
    </div>
    <script>

    var username = document.getElementById('username');
    var usermail = document.getElementById('usermail');
    var fullname = document.getElementById('fullname');
    var token = '<?php echo "$token" ?>';

      $("#submit").on("click", deleteUser);

      function checkUser() {
          var message = document.getElementById('confirmUsername');
          var regex = /^[a-z]{1}[a-z0-9]+$/;
          var goodColor = "#66cc66";
          var badColor = "#ff6666";
          if(regex.test(username.value)){
              username.style.backgroundColor = goodColor;
              message.style.color = goodColor;
              message.innerHTML = "";
          }else{
              username.style.backgroundColor = badColor;
              message.style.color = badColor;
              message.innerHTML = "Invalid Username Characters";
          }
      }
      function checkName() {
          var message = document.getElementById('confirmName');
          var goodColor = "#66cc66";
          var badColor = "#ff6666";
          if(fullname.value){
              fullname.style.backgroundColor = goodColor;
              message.style.color = goodColor;
              message.innerHTML = "";
          }else{
              fullname.style.backgroundColor = badColor;
              message.style.color = badColor;
              message.innerHTML = "No Name Input";
          }
      }
      function deleteUser() {
          if (username.value && usermail.value && fullname.value) {
              $.post( 'tacdelete.php', { 'username': username.value, 'usermail': usermail.value, 'fullname': fullname.value, 'token': token });
             alert('Information sent. Check your e-mail to confirm the user has been deleted.');
	     <?php $_SESSION['token'] = NULL; ?>
       window.location.assign('dereg.php');
	     return false;
          }else{
              alert("There was a problem with your input.\nPlease be sure to fill out all boxes and follow any displayed instructions.\nPress OK to try again");
          }
      }

    </script>
</body>