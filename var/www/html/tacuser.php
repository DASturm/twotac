<?php

    session_start();

    $u    = $_POST["username"];
    $pass = $_POST["password"];
    $e    = $_POST["usermail"];
    $n    = $_POST["fullname"];

    $salt = "$6$" . base64_encode(random_bytes(8)) . ".";
    $p = crypt($pass, $salt);

if (!empty($_POST['token'])) {
    if (hash_equals($_SESSION['token'], $_POST['token'])) {
    $command = "sudo /opt/bin/tacuser -u $u -p $p -e $e -n \"$n\"\n";
    echo "$command";
    $sanicommand = escapeshellcmd($command);
    system($sanicommand);
    exit();
} else {
    /* log CSRF problem */
    exit();
    }
}
?>