<?php
    $u    = $_POST["username"];
    $e    = $_POST["usermail"];
    $n    = $_POST["fullname"];

    $command = "sudo /opt/bin/tacdelete.sh -u $u -e $e -n \"$n\"\n";
    echo "$command";
    $sanicommand = escapeshellcmd($command);
    system($sanicommand);
    exit();
?>