
<html>
<body>
<?php
	
	require_once 'SQLHelper.class.php';
	$sqlHelper = new SQLHelper();		 
	
	$username = $_POST['username'];
	$score = $_POST['score'];
	$sql = "insert into game_record(username,score) values('{$username}',{$score})";
	$sqlHelper->close_connect();
	echo($sqlHelper->execute_dml($sql));	
?>
</body>
</html>