<head>
    <title>Tacacs+ Registration</title>
    <meta charset="utf-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <link rel="icon" type="image/png" href="favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="favicon-16x16.png" sizes="16x16">
</head>
<style>
body {
    font-family: Arial, sans-serif;
}
.title {
    text-align: center;
    font-family: Arial, sans-serif;
    font-weight: bold;
    margin-top: 20px;
}
.url-box {
  position: fixed;
  bottom: 0;
  left: 0;
  padding: 5px;
  text-align: center;
  font-family: "Roboto", sans-serif;
}
.form-box {
    max-width: 400px;
    margin-left: auto;
    margin-right: auto;
    position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 360px;
  margin: 0 auto 100px;
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}

form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #6e6e6e;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
form button:hover,form button:active,form button:focus {
  background: #333333;
}
form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
span {
  font-weight: bold;
}
</style>
<body>
    <h1 class="title">Tacacs+ Registration</h1>
    <div class="form-box">
    <form>
            <span id="confirmUsername" class="confirmUsername"></span>
            <input placeholder="User Name" type="username" name="username" id="username" onkeyup="checkUser(); return false">
            <span id="confirmPassword" class="confirmPassword"></span><br>
            <input placeholder="Password:" type="password" name="password" id="password">
            <input placeholder ="Confirm Password" type="password" name="confirm" id="confirm" onkeyup="checkPass(); return false;">
            <span id="confirmEmail" class="confirmEmail"></span>
            <input placeholder = "Email" type="email" name="usermail" id="usermail" onkeyup="checkMail(); return false;">
            <span id="confirmName" class="confirmName"></span>
            <input placeholder="Full Name: " type="fullname" name="fullname" id="fullname" onkeyup="checkName(); return false;">
        <td><button class="btn btn-primary" id="submit">Register</button></td>
    </form>
    </div>
    <div class="url-box">
      <form action="[WEBPLACEHOLDER]/dereg.php">
        <input style="background: #565656; color: #FFFFFF;"  type="submit" value="Deregister" />
      </form>
    </div>
    <script>

    var username = document.getElementById('username');
    var password = document.getElementById('password');
    var confirm  = document.getElementById('confirm');
    var usermail = document.getElementById('usermail');
    var fullname = document.getElementById('fullname');

      $("#submit").on("click", registerUser);

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
      function checkPass() {
          var message = document.getElementById('confirmPassword');
          var goodColor = "#66cc66";
          var badColor = "#ff6666";
          if(password.value == confirm.value){
              confirm.style.backgroundColor = goodColor;
              password.style.backgroundColor = goodColor;
              message.style.color = goodColor;
              message.innerHTML = "";
          }else{
              confirm.style.backgroundColor = badColor;
              password.style.backgroundColor = badColor;
              message.style.color = badColor;
              message.innerHTML = "Passwords Do Not Match";
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
      function registerUser() {
          if (password.value == confirm.value && username.value && password.value && usermail.value && fullname.value) {
              $.post( 'tacuser.php', { 'username': username.value, 'password': password.value, 'usermail': usermail.value, 'fullname': fullname.value });
             alert('Check your e-mail to ensure you have registered successfully\nUsername: ' + username.value + '\nE-mail: ' + usermail.value + '\nName: ' + fullname.value);
	     window.location.assign('register.php');
	     return false;
          }else{
              alert("There was a problem with your input.\nPlease be sure to fill out all boxes and follow any displayed instructions.\nPress OK to try again");
          }
      }

    </script>
</body>
</html>