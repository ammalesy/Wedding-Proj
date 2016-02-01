<?php

	require_once('config.db.php');

	$result = mysqli_query($conn,'SELECT * FROM gift WHERE amount != 0 ORDER BY RAND() LIMIT 1');
	$row=mysqli_fetch_array($result,MYSQLI_ASSOC);

	if(count($row) <= 0){

		$result = array("titleLb" => "Not available item.",
					"subTitleLb" => "Please contact to host (Arnut).",
					"pathImage" => "http://www.reallifefootball.com/wedding_api/not_avai_item.png");
		echo json_encode($result);

	}else{
		$result = array("titleLb" => $row["title"],
					"subTitleLb" => $row["subTitle"],
					"pathImage" => $row["path_url"],
					"id"=>$row["id"]);
		echo json_encode($result);

		$amount = $row['amount']-1;
		$sql = "UPDATE `gift` SET `amount` = '".$amount."' WHERE `gift`.`id` = ".$row['id']."";
		$result = mysqli_query($conn,$sql);
	}

	mysqli_close($conn);
?>