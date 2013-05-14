<?php
	class SQLHelper{
		
		//本地sql连接信息 
		public $conn;
		public $host = "你自己的服务器ip:3306";
		public $user = "你数据库的用户名";
		public $password = "你数据库的密码";
		public $db_name = "数据库名";
		
		//构造函数
		public function __construct(){
			//连接数据库
			//$this->conn = mysql_connect(SAE_MYSQL_HOST_M.':'.SAE_MYSQL_PORT,SAE_MYSQL_USER,SAE_MYSQL_PASS) or die("数据库连接错误".mysql_error());
			$this->conn = mysql_connect($this->host,$this->user,$this->password) or die("数据库连接错误".mysql_error());
			//设置数据库字符串集
			mysql_query("set names utf8") or die("fuck ");
			//mysql_query("select * from game_record") or die("fuck ");
			//选择数据库
			mysql_select_db($this->db_name,$this->conn) or die("数据库选择错误".mysql_error());
		}
		
		//执行sql操作--查询，返回结果集
		public function execute_dql($sql){
			$res = mysql_query($sql) or die("数据库查询错误".mysql_error());
			return $res;
		}
		
		
		
		//执行sql操作，返回操作状态表示操作数据库结果
		public function execute_dml($sql){
			$status = mysql_query($sql) or die("数据库操作错误".mysql_error());
			if(!$status){
				return 0; //执行失败
			}else{
				if(mysql_affected_rows($this->conn) > 0){
					return 1;  //dml成功，影响到数据库记录
				}else{
					return 2;   //没有影响到数据库记录
				}
			}
		}
		
		//关闭连接
		public function close_connect(){
			if(!empty($this->conn)){
				mysql_close($this->conn);
			}
		}
		
	}
?>