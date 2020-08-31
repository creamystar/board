<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Boards</title>
<!-- 헤더  -->
<c:import url="/head"></c:import>
<style type="text/css">
.wrapb{
width:70%;
margin: 100px auto;
}
.btitle{
display: inline-block;
padding-left: 10px;
font-weight: bold;
font-size: 10pt;
color: #e17515;
}
.searchright{
display: inline-block;
float: right;
}
.searchTxt{
height: 20px;
margin-right: 5px;
border: 1px solid orange;
outline-color: darkgreen;
}
.searchBtn{
background-color: orange;
color: white;
border: 0px;
height: 25px;
outline-color: darkgreen;
}
.board{
text-align: center;
border-collapse: collapse;
vertical-align: center;
font-size:11pt;
margin-top: 15px;
}
.board tr{
height: 45px;
}
.board th{
border-top: 2px solid orange;
border-bottom: 1px solid orange;
color: #e17515;
}
.board td{
border-bottom: 1px solid lightgray;
}
.board tbody tr{
cursor: pointer;
}

.board tbody {
color: gray;
font-size:9pt;
}
.board td:nth-child(3){
color: black;
font-size:11pt;
}
.board tbody tr:hover{
background-color: lightgray;
}

.paging{
width: 70%;
margin: 0px auto;
text-align: center;
margin-top: 25px;
}
.paging > div {
display:inline-block;
}
.paging > div > div {
display: table-cell;
vertical-align: middle;
text-align: center;
height: 30px;
width:30px;
font-size:8pt;
color: gray;
cursor: pointer;
}
.paging > div > div:hover{
background-color: lightgray;
}
.pagehere{
background-color: orange;
color: white !important;
}
.pagehere:hover{
background-color: orange !important;
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
<div class="btitle"> 메인 게시판 </div> 
<div class="searchright"><input type="text" class="searchTxt"><input type="button" class="searchBtn" value="검색"></div>
<table class="board">
	<colgroup>
		<col width="80px">
		<col width="120px">
		<col width="70%">
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
			<td>3</td>
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
			<td>1</td>
			<td>드라마</td>
			<td>굿 플레이스 아시는 분?</td>
			<td>20.08.29</td>
			<td>14</td>
		</tr>
	</tbody>

</table>

<div class="paging">
<div>
	<div>처음</div><div>이전</div><div class="pagehere">1</div><div>2</div><div>3</div><div>다음</div><div>끝</div>
</div>
</div>
</div>

</body>
</html>