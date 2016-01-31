<?php
	
	$id = $_GET['id'];
	$result = array("titleLb" => "Test",
					"subTitleLb" => "TestSub",
					"pathImage" => "https://cdn.photographylife.com/wp-content/uploads/2014/06/Nikon-D810-Image-Sample-6.jpg",
					"id" => "1");
	echo json_encode($result);
?>