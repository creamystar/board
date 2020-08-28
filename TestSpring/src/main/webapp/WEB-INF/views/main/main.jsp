<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Main</title>
<!-- 헤더  -->
<c:import url="/head"></c:import>
<style type="text/css">
.wrapb{
width:70%;
margin: 100px auto;
}
.board{
text-align: center;
border-collapse: collapse;
vertical-align: center;
font-size:11pt;
}
.board tr{
height: 45px;
}
.board th{
border-top: 2px solid orange;
border-bottom: 1px solid orange;
}
.board td{
border-bottom: 1px solid lightgray;
}
.board tr:last-child{
border-bottom: 1px solid orange;
}
.paging{
margin: 30px auto;
}
.paging > div{
display: table-cell;
vertical-align: middle;
text-align: center;
height: 30px;
width:30px;
font-size:8pt;
background-color: green;
color:white;
margin-right: 3px;
}


</style>
<script type="text/javascript" src="resources/javascript/jquery/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	
	
});//document
</script>

</head>
<body>
<div class="wrapb">
<table class="board">
	<colgroup>
		<col width="80px">
		<col width="100px">
		<col width="80%">
		<col width="80px">
		<col width="80px">
	</colgroup>
	<thead>
		<tr>
			<th>No</th>
			<th>type</th>
			<th>title</th>
			<th>date</th>
			<th>view</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>1</td>
			<td>라이프</td>
			<td>셔츠 골라주면 소원 이뤄짐</td>
			<td>20.08.29</td>
			<td>14</td>
		</tr>
		<tr>
			<td>2</td>
			<td>라이프</td>
			<td>지나가는 밤의 구름은 보라</td>
			<td>20.08.29</td>
			<td>14</td>
		</tr>
		<tr>
			<td>3</td>
			<td>드라</td>
			<td>굿 플레이스 아시는 분?</td>
			<td>20.08.29</td>
			<td>14</td>
		</tr>
	</tbody>

</table>
<div class="paging">
	<div>처음</div><div>이전</div><div>1</div><div>2</div><div>3</div><div>다음</div><div>끝</div>
</div>
</div>
</body>
</html>