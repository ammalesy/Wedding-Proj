<?php

	require_once('config.db.php');

	$id = $_GET['id'];

	$result = mysqli_query($conn,"SELECT * FROM gift WHERE id = ".$id."");
	$row=mysqli_fetch_array($result,MYSQLI_ASSOC);
	$result = array("titleLb" => $row["title"],
					"subTitleLb" => $row["subTitle"],
					"pathImage" => $row["path_url"],
					"id"=>$row["id"]);
		echo json_encode($result);
	mysqli_close($conn);
?>