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
width:80%;
margin: 100px auto;
}
.btitle{
display: inline-block;
text-align: center;
padding-left: 10px;
margin-right: 20px;
font-weight: bold;
font-size: 10pt;
color: #e17515;
}
.searchright{
display: inline-block;
float: right;
}
#searchTxt{
height: 20px;
margin-right: 5px;
border: 1px solid orange;
outline-color: darkgreen;
}
.searchBtn, .writeBtn{
background-color: orange;
color: white;
border: 0px;
height: 25px;
outline-color: darkgreen;
cursor: pointer;
}
.writeBtn{
margin-left: 30px;
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
.pagingD {
display:inline-block;
}
.pagingD > div {
display: table-cell;
vertical-align: middle;
text-align: center;
height: 30px;
width:30px;
font-size:8pt;
color: gray;
cursor: pointer;
}
.pagingD > div:hover{
background-color: lightgray;
}
#pagehere{
background-color: orange;
color: white !important;
}
#pagehere:hover{
background-color: orange !important;
}


</style>
<script type="text/javascript" src="resources/javascript/jquery/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	loadList();
	
	$(".searchBtn").on("click", function(){
		$("#page").val("1");
		loadList();
	})//searchBtn 
	
	$(".writeBtn").on("click", function(){
		$("#actionForm").attr("action","mainWrite");
		$("#actionForm").submit();
	})//writeBtn
	
	$(".pagingD").on("click", "div", function(){
		$("#page").val($(this).attr("name"));
		loardList();
	})//pagingBtn
	
	$("#searchTxt").on("keypress",function(event){
		if(event.keyCode == 13){
			$(".searchBtn").click();
			return false;
		}
	})//searchTxt and endter
	
	$(".board tbody").on("click","tr",function(){
		if($(this).is("[name]")){
			$("#boardNo").val($(this).attr("name"));
			$("#actionForm").attr("action","mainRead");
			$("#actionForm").submit();
		}
	})//tbody click
	
});//document ready end


function loadList(){
	var params = $("#actionForm").serialize();
	
	$.ajax({ 
		type : "post", 
		url : "mainbListAjax", 
		dataType : "json",  
		data : params,
		success : function(res) { 
			if(res.result == "success"){
				drawList(res.list);
				drawPaging(res.pb);
			} else {
				alert("오류가 발생하였습니다.");
			}
		},
		error : function(request, status, error) { 
			console.log("text : " + request.responseText); 
			console.log("error : " + error); 
		} 
	});//ajax
	
}//loadList end

function drawList(list){
	if(list.length==0) {
		var html = "";
	
		$(".board tbody").html(html);
	
	} else {
		var html="";
		
		for(var i = 0; i < list.length; i++){
		
			html += "<tr name=\"" + list[i].BOARD_NO + "\">";
			html += "<td>" + list[i].BOARD_NO + "</td>";
			html += "<td>" + list[i].BOARD_TYPE + "</td>";
			html += "<td>" + list[i].BOARD_TITLE + "</td>";
			html += "<td>" + list[i].BOARD_DATE + "</td>";
			html += "<td>" + list[i].BOARD_VIEW + "</td>";
			html += "</tr>";
		
		$(".board tbody").html(html);
		
		}
	}
}//drawList end

function drawPaging(pb){
	
	var html = "<div name=\"1\">처음</div>";
	
	if($("#page").val() == "1"){
		html += "<div name=\"1\">이전</div>";
	} else {
		html += "<div name=\"" + ($("#page").val() * 1 - 1) + "\">이전</div>";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
		if(i == $("#page").val()) {
			html += "<div name = \"" + i + "\" id=\"pagehere\">" + i + "</div>";
		} else {
			html += "<div name = \"" + i + "\">" + i + "</div>";
		}
	}
	
	if($("#page").val() == pb.maxPcount){
		html += "<div name = \"" + pb.maxPcount + "\">다음</div>";
	} else {
		html += "<div name = \"" + ($("#page").val() * 1 + 1) + "\">다음</div>";		
	}
	
	html += "<div name = \"" + pb.maxPcount + "\">끝</div>";
	
	$(".pagingD").html(html);
	
	
} //drawPaging end
</script>

</head>
<body>

<div class="wrapb">
<form action="#" id="actionForm" method="post">
<input type="hidden" name="boardNo" id="boardNo">
<input type="hidden" name="page" id="page" value="1">

<div class="btitle"> 메인 게시판 </div> 
<input type="text" id="searchTxt" name="searchTxt"><input type="button" class="searchBtn" value="검색">

<div class="searchright"><input type="button" class="writeBtn" value="글쓰기"></div>
</form>
<table class="board">
	<colgroup>
		<col width="80px">
		<col width="120px">
		<col width="70%">
		<col width="120px">
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
		
	</tbody>

</table>

<div class="paging">
<div class="pagingD">
	<div>처음</div><div>이전</div><div id="pagehere">1</div><div>2</div><div>3</div><div>다음</div><div>끝</div>
</div>
</div>
</div>

</body>
</html>