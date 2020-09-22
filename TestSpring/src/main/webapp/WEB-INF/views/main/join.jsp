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
width: 370px;
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
#email, #pswd, #nm, #birth, #phone {
height: 22px;
width: 260px;
}
#email{
width: 190px;
margin-right: 5px;
}
#emailCheck{
height: 27px;
vertical-align: center;
}
.join{
text-decoration: underline;
font-size:9pt;
text-align: right;
cursor: pointer;
width: 380px;
}
tbody tr td:first-child{
width: 60px;
}
</style>
<script type="text/javascript" src="resources/javascript/jquery/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	
		var check = 0;
		var oldVal = "";
	$("#emailCheck").on("click",function(){
		check = 1;
		var emailRegExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		if(!emailRegExp.test($("#email").val())){
			check = 0; 
			alert("이메일 형식을 확인해주세요.")
		} else {
		
			var params = $("#actionForm").serialize();
			
			$.ajax({ //겟
				type : "post", 
				url : "emailCheckAjax", //호출 
				dataType : "json",  
				data : params,
				success : function(res) { 
					if(res.result == "success"){
						oldVal = $("#email").val();
						alert("사용가능한 이메일입니다.")
					} else {
						check = 0;
						alert("동일한 이메일이 있습니다. 다른 이메일을 사용해주세요.");
						
					}
				},
				error : function(request, status, error) { 
					console.log("text : " + request.responseText); //반환텍스트 
					console.log("error : " + error); //에러 내용 
				} 
			});//ajax
		}
	})//email check click
	
	$("#email").on("propertychange change keyup paste input", function() {
	    var currentVal = $(this).val();
	    if(currentVal == oldVal) {
	        return;
	    }else{
	    	check = 0;
	    }
	});//이메일 중복확인 후 값 변경시 
	
	$(".title").on("click",function(){
		
		var phoneRegExp = /^\d{2,3}-\d{3,4}-\d{4}$/;

		if($("#email").val()==""||$("#pswd").val()==""||
				$("#nm").val()==""||$("#birth").val()==""||$("#phone").val()==""){
			alert("빈칸을 입력해주세요.");
		}else if(check == 0){
			alert("이메일을 중복확인 해주세요. ")
		}else if(!phoneRegExp.test($("#phone").val())) {
			alert("전화번호는 010-0000-0000 또는 지역번호-000-0000으로 입력해주세요.");
		}else{
			var params = $("#actionForm").serialize();
			
			$.ajax({ //겟
				type : "post", 
				url : "joinAjax", //호출 
				dataType : "json",  
				data : params,
				success : function(res) { //석세스일때 넘어오는 값을 res로 받겠다 
					if(res.result == "success"){
						alert("가입이 완료되었습니다.");
						location.href = "login";
					} else {
						alert("오류가 있습니다. 다시 시도하세요.]");
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
		<td>별명 </td>
		<td><input type="text" id="nm" name="nm"></td>
	</tr>
	<tr>
		<td>이메일 </td>
		<td><input type="text" id="email" name="email"><input type="button" id="emailCheck" value="중복확인"></td>
	</tr>
	<tr>
		<td>비밀번호 </td>
		<td><input type="password" id="pswd" name="pswd"></td>
	</tr>
	<tr>
		<td>생년월일 </td>
		<td><input type="date" id="birth" name="birth"></td>
	</tr>
	<tr>
		<td>전화번호 </td>
		<td><input type="text" id="phone" name="phone"></td>
	</tr>
	<tr>
		<td colspan="2" class="title">
		JOIN 
		</td>
	</tr>
</tbody>
</table>
</div>
</form>
</body>
</html>