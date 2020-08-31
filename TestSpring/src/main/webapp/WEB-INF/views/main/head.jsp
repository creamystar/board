<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style type="text/css">
body{
margin:0px;
}
.top{
width: 100%;
height: 100px;
background-color:orange;
}
.top > div {
padding-top: 70px;
padding-left: 30px;
}
.top > div > div {
display:table-cell;
vertical-align: middle;
color:white;
padding-left: 10px;
padding-right: 10px;
height: 30px;
text-align:center;
cursor: pointer;
}

.top > div > div:hover{
background-color: darkgreen;
}
.select:hover{
background-color: gray !important;
}



</style>
<script type="text/javascript" src="resources/javascript/jquery/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#mainb").attr("class","select");
	
	$("#mainb").on("click",function(){
		$("#mainb").attr("class","select");
		location.href = "main";
	})
	
	$("#mainb").on("click",function(){
		$("#mainb").attr("class","select");
		location.href = "main";
	})
	
	
	
	
});//document
</script>

</head>
<body>
<div class="top">
<div>
<div id="mainb"> 메인 </div>
<div id="imageb"> 이미지 </div>
<div id="recb"> 추천 </div>
<div id="cultureb"> 컬쳐 </div>
<div id="tripb"> 트립 </div>
<div id="movieb"> 무비 </div>
<div id="dramab"> 드라마 </div>
<div id="lifeb"> 라이프 </div>
<div id="jobb"> 직장 </div>
<div id="bookb"> 책 </div>
</div>
</div>
</body>
</html>