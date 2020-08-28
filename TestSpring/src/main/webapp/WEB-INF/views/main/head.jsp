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
display:inline-block;
color:white;
width:50px;
heith:30px;
text-align:center;
margin-top: 80px;
cursor: pointer;
}

.first{
margin-left: 30px;
}

.top > div:hover{
background-color: darkgreen;
}

</style>
<script type="text/javascript" src="resources/javascript/jquery/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	
	
});//document
</script>

</head>
<body>
<div class="top">
<div class="first"> 메인 </div>
<div> 이미지 </div>
<div> 추천 </div>
<div> 컬쳐 </div>
<div> 트립 </div>
<div> 무비 </div>
<div> 드라마 </div>
<div> 라이프 </div>
<div> 직장 </div>
<div> 책 </div>
</div>
</body>
</html>