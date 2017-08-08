<?php
    $u    = $_POST["username"];
    $e    = $_POST["usermail"];
    $n    = $_POST["fullname"];

if (!empty($_POST['token'])) {
	if (hash_equals($_SESSION['token'], $_POST['token'])) {
    $command = "sudo /opt/bin/tacdelete -u $u -e $e -n \"$n\"\n";
    echo "$command";
    $sanicommand = escapeshellcmd($command);
    system($sanicommand);
    exit();
} else {
	<html>
	<script>
	alert('CSRF token does not match... exiting');
	</script>
	</html>
	exit();
	}
}
?>