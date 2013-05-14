<?php
	include_once 'SQLHelper.class.php';
	$sqlHelper = new SQLHelper();	
	$result = $sqlHelper->execute_dql("select * from game_record order by score desc,time limit 0,10");
	$xmldata="<scores>";
	while( $row = mysql_fetch_array($result)){
		$xmldata.="<record><name>{$row['username']}</name><score>{$row['score']}</score><time>{$row['time']}</time></record>";
	}
	$xmldata.="</scores>";
	echo ($xmldata);	
?>
