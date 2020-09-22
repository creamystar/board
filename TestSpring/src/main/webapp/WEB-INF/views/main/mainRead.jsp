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
.btitle, .replyCnt {
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
.updateBtn, .deleteBtn {
background-color: orange;
color: white;
border: 0px;
height: 25px;
outline-color: darkgreen;
cursor: pointer;
margin-left: 7px;
}

#reUpBtn, #reDelBtn {
background-color: lightgray;
color: white;
border: 0px;
height: 20px;
ourtline-color: gray;
font-size: 7pt;
cursor: pointer;
margin-left: 7px;
}

#reUpBtn {
margin-left: 15px;
}

.board{
width: 100%;
text-align: center;
border-collapse: collapse;
vertical-align: center;
font-size:11pt;
margin-top: 15px;
margin-bottom: 15px;
}
.board tr{
height: 45px;
}
.board td{
border-top: 1px solid lightgray;
border-bottom: 1px solid lightgray;
}
.board tbody tr:first-child{
border-top: 2px solid orange !important;
}
.title{
width:85%;
font-weight: bold;
}
.date{
width:120px;
color: gray;
font-size: 9pt;
}
.view{
width: 80px;
color: gray;
font-size: 9pt;
}
.con {
padding-top: 100px;
padding-bottom: 100px;
}

.reply{
width: 100%;
border-collapse: collapse;
vertical-align: center;
font-size:11pt;
margin-top: 15px;
margin-bottom: 15px;
}
.reply tr td{
border-top: 1px solid lightgray;
border-bottom: 1px solid lightgray;
padding: 15px;
}

.reply tr td div{
font-weight: bold;
}

.reply tr td div span{
color: gray;
font-size: 9pt;
margin-left: 5px;
font-weight: normal;
}

.paging{
width: 70%;
margin: 0px auto;
text-align: center;
margin-top: 10px;
margin-bottom: 10px;
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
background-color: gray;
color: white !important;
}
#pagehere:hover{
background-color: orange !important;
}
.ta{
border: 1px solid orange;
width: 100%;
resize: none;
}
.bottomright{
display: inline-block;
float: right;
color: orange;
font-size: 10pt;
}
#pw{
border: 1px solid orange;
height: 22px;
}
.replyWriteBtn{
background-color: orange;
color: white;
border: 0px;
height: 25px;
outline-color: darkgreen;
cursor: pointer;
margin-left: 10px;
}

</style>
<script type="text/javascript" src="resources/javascript/jquery/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	loadreplyList();
	
	$(".updateBtn").on("click", function(){
		
	})//searchBtn 
	
	$(".deleteBtn").on("click", function(){
		
	})//writeBtn
	
	$(".replyWriteBtn").on("click", function(){
		
		if($("#retxt").val() == "" || $("#pw").val() == ""){
			alert("댓글 내용과 비밀번호를 입력하세요.")
		} else {
			var params = $("#replyForm").serialize();
			
			$.ajax({ //겟
				type : "post", 
				url : "replywriteAjax", //호출 
				dataType : "json",  
				data : params,
				success : function(res) { //석세스일때 넘어오는 값을 res로 받겠다 
					if(res.result == "success"){
						/* location.href = "bMain"; */
						loadreplyList();
						$("#pw").val("");
						$("#retxt").val("");
						console.log("res.cnt: "+res.cnt);
					} else {
						alert("오류가 발생하였습니다.");
					}
				},
				error : function(request, status, error) { 
					console.log("text : " + request.responseText); //반환텍스트 
					console.log("error : " + error); //에러 내용 
				} 
			});//ajax
			
			
		}	
		
		})//replyWriteBtn
		
	
	
});//document ready end

function loadreplyList(){
	
	var params = $("#actionForm").serialize();
	
	$.ajax({ //겟
		type : "post", 
		url : "replyAjax", //호출 
		dataType : "json",  
		data : params,
		success : function(res) { //석세스일때 넘어오는 값을 res로 받겠다 
			if(res.result == "success"){
				/* location.href = "bMain"; */
				redrawList(res.list,res.cnt,res.user);
				redrawPaging(res.pb,res.cnt);
				console.log("res.cnt: "+res.cnt);
			} else {
				alert("오류가 발생하였습니다.");
			}
		},
		error : function(request, status, error) { 
			console.log("text : " + request.responseText); //반환텍스트 
			console.log("error : " + error); //에러 내용 
		} 
	});//ajax
	
}//reloadList

function redrawList(list,cnt,user){
	
		var h = "댓글 " + cnt + "개";
		$(".replyCnt").html(h);
		
		if(list.length==0) {//가져온 데이터가 없다.
			var html = "";
		
		
		$(".reply tbody").html(html);
		} else {
			var html="";
			
			for(var i = 0; i < list.length; i++){
				
				
				html += "<tr>";
				html += "<td><div>" + list[i].REPLY_NO + ". ";
				
				//reply user1 user2 순 
				//근데 동일 user면 user3 뒤에 user2 가 글 썼으면 user2라고 뜨기 
				//지은이는 user writer
				html += "<span>" + user[i] + "</span>";
				
				if(list[i].REPLY_DATE == list[i].SYS_DATE){
					html += "<span>" + list[i].REPLY_TIME + "</span>";
				}else {
					html += "<span>" + list[i].REPLY_DATE + "</span>";
				}
				html += "</div>";
				html += list[i].REPLY_CON + "<input type=\"button\" id=\"reUpBtn\" name=\"" + list[i].REPLY_NO + "\" value=\"수정\"><input type=\"button\" id=\"reDelBtn\" name=\"" + list[i].REPLY_NO + "\" value=\"삭제\"></td>";
				html += "</tr>"
			}
			
			$(".reply tbody").html(html);

		}
}//redrawList

function redrawPaging(pb,cnt){
	
	var html = "";
	
	if(cnt > 3){
		html += "<div name=\"1\">처음</div>";
		
		if($("#page").val() == "1"){
			html += "<div name=\"1\">이전</div>";
		} else {
			html += "<div name=\"" + ($("#page").val() * 1 - 1) + "\">이전</div>";
		}
	}
	
	if(cnt > 1){
		for(var i = pb.startPcount ; i <= pb.endPcount ; i++){
			if(i == $("#page").val()) {
				html += "<div name = \"" + i + "\" id=\"pagehere\">" + i + "</div>";
			} else {
				html += "<div name = \"" + i + "\">" + i + "</div>";
			}
		}	
	}
	
	if(cnt > 3){
		if($("#page").val() == pb.maxPcount){
			html += "<div name = \"" + pb.maxPcount + "\">다음</div>";
		} else {
			html += "<div name = \"" + ($("#page").val() * 1 + 1) + "\">다음</div>";		
		}
		
		html += "<div name = \"" + pb.maxPcount + "\">끝</div>";
	}
	
	
	
	$(".pagingD").html(html);
	



	
}//redrawPaging

</script>

</head>
<body>

<div class="wrapb">
<form action="#" id="actionForm" method="post">
<input type="hidden" name="boardNo" id="boardNo" value="${param.boardNo}">
<input type="hidden" name="page" id="page" value="${param.page}">
<input type="hidden" name="replypage" id="replypage" value="1">

<div class="btitle"> ${data.BOARD_TYPE} </div> 
<input type="hidden" id="searchTxt" name="searchTxt" value="${param.searchTxt}">
<div class="searchright"><input type="button" class="updateBtn" value="수정"><input type="button" class="deleteBtn" value="삭제"></div>
</form>
<table class="board">
	<tbody>
		<tr>
			<td class="title">
				${data.BOARD_TITLE}
			</td>
			<td class="date">
				${data.BOARD_DATE2}
			</td>
			<td class="view">
				${data.BOARD_VIEW}
			</td>
		</tr>
		<tr>
			<td colspan="3" class="con">
				${data.BOARD_CON}
			</td>
		</tr>
	</tbody>

</table>
<div class="replyCnt">  </div>
<table class="reply">
	<tbody>
		<tr>
			
		</tr>
	</tbody>
</table>

<div class="paging">
<div class="pagingD">
	<div>처음</div><div>이전</div><div id="pagehere">1</div><div>2</div><div>3</div><div>다음</div><div>끝</div>
</div>
</div>

<form action="#" id="replyForm" method="post">
<input type="hidden" name="boardNo" id="boardNo" value="${param.boardNo}">
<input type="hidden" name="memberNo" id="memberNo" value="${sMemberNo}">
<textarea rows="5" class="ta" id="retxt" name="retxt"></textarea> 
<div>
<div class="bottomright"><input type="button" class="replyWriteBtn" value="댓글작성"></div>
</div>
</form>

</div>


</body>
</html>