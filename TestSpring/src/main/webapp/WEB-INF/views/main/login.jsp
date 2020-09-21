<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boards</title>
<style type="text/css">
.wrap{
width: 280px;
margin: 220px auto;
}
.title{
height: 50px;
background: linear-gradient(to bottom, #f6d365, #fda085);
color: white;
font-weight: bold;
text-align: center;
cursor: pointer;
}
.title:hover{
background: linear-gradient(to top, #f6d365, #fda085);
}
#email, #pswd {
height: 22px;
width: 200px;
}
.join{
text-decoration: underline;
font-size:9pt;
text-align: right;
cursor: pointer;
width: 270px;
}
</style>
<script type="text/javascript" src="resources/javascript/jquery/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".join").on("click",function(){
		location.href = "join";	
	})//join click
	
	$(".title").on("click",function(){
		if($("#email").val()==""||$("#pswd").val()==""){
			alert("이메일과 비밀번호를 입력해주세요.");
			if($("#email").val()==""){
				$("#email").focus();
			}else {
				$("#pswd").focus();
			}
		}else{
			var params = $("#actionForm").serialize();
			
			$.ajax({ //겟
				type : "post", 
				url : "loginAjax", //호출 
				dataType : "json",  
				data : params,
				success : function(res) { //석세스일때 넘어오는 값을 res로 받겠다 
					if(res.result == "success"){
						location.href = "main";
					} else {
						alert("아이디나 비밀번호를 다시 확인해주세요.");
					}
				},
				error : function(request, status, error) { 
					console.log("text : " + request.responseText); //반환텍스트 
					console.log("error : " + error); //에러 내용 
				} 
			});//ajax
		}
	})//title click
	
});//document ready end


</script>

</head>
<body>
<form action="#" id="actionForm" method="post">
<div class="wrap">
<table>
<tbody>
	<tr>
		<td>이메일 </td>
		<td><input type="text" id="email" name="email"></td>
	</tr>
	<tr>
		<td>비밀번호 </td>
		<td><input type="password" id="pswd" name="pswd"></td>
	</tr>
	<tr>
		<td colspan="2" class="title">
		LOGIN 
		</td>
	</tr>
</tbody>
</table>
<div class="join">회원가입</div>
</div>
</form>
</body>
</html>