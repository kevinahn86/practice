<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
$(document).ready(function() {
	

	$("#modbtn").click(function(){
	
	var chk = confirm("글을 수정하시겠습니까?");	
	if(chk){
		if(check()){

    var dd =  $('#insertForm').serialize();

    $.ajax({
		url: "./mod.ino" ,
		type: "post" ,
		datatype: "json" ,
		data: dd,
		
		success: function(result){
			console.log(result);
			if(result==1){
				
				alert("글 수정에 성공 하였습니다.");
				location.href ="./main.ino";
				
				
			}else if(result==0){
				
				alert("글 수정에 실패 하였습니다");
			}
			
			
		},
		
		error:function(x,e){
			if(x.status==0){
	            alert('You are offline!!n Please Check Your Network.');
	            }else if(x.status==404){
	            alert('Requested URL not found.');
	            }else if(x.status==500){
	            alert('Internel Server Error.');
	            }else if(e=='parsererror'){
	            alert('Error.nParsing JSON Request failed.');
	            }else if(e=='timeout'){
	            alert('Request Time out.');
	            }else {
	            alert('Unknow Error.n'+x.responseText);
	            }
       }
		
		
		});
	}
	}
		
});
	
	$("#delbtn").click(function(){
		
		var chk = confirm("글을 삭제하시겠습니까?");	
		if(chk){
			if(check()){
	    var dd =  $('#insertForm').serialize();
	    
	    
	    $.ajax({
			url: "./del.ino" ,
			type: "post" ,
			datatype: "json" ,
			data: dd,
			
			success: function(result){
				console.log(result);
				if(result==1){
					
					alert("글 삭제에 성공 하였습니다.");
					location.href ="./main.ino";
					
				}else if(result==0){
					
					alert("글 삭제에 실패 하였습니다");
				}
	
			},
			
			error:function(x,e){
				if(x.status==0){
		            alert('You are offline!!n Please Check Your Network.');
		            }else if(x.status==404){
		            alert('Requested URL not found.');
		            }else if(x.status==500){
		            alert('Internel Server Error.');
		            }else if(e=='parsererror'){
		            alert('Error.nParsing JSON Request failed.');
		            }else if(e=='timeout'){
		            alert('Request Time out.');
		            }else {
		            alert('Unknow Error.n'+x.responseText);
		            }
	       }
			
			
			});
		}
		}
			
	});

});

function check() {
	var name = document.insertForm.name.value;
	
	var title = document.insertForm.title.value;

	var content = document.insertForm.content.value;

	name = name.replace(/ /gi,"");

	title = title.replace(/ /gi,"");

	content = content.replace(/ /gi,"");



	if(name!="" && title != "" && content !="" ) { 
		
		return true;

	}

	else{ 

		alert("올바르지 못한 값입니다.");
		
		location.href='./freeBoardDetail.ino?num='+num;
		
		return false;

	}
	
}

</script>
<title>Insert title here</title>
</head>


<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">
	
	<form	id="insertForm" 
			name="insertForm" 
		onsubmit="return check()"
			action = "./freeBoardModify.ino">
		<input type="hidden" name="num" value="${map.NUM }" />
		
		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${map.NAME }" readonly/></div>
		
		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${map.TITLE }"/></div>
	
		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${map.REGDATE }" readonly/></div>
	
		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${map.CONTENT }</textarea></div>
		<div align="right">
		<button type="button" name="modbtn" id="modbtn" >수정</button>
		<button type="button" name="delbtn"  id="delbtn" >삭제</button>
		
		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div>
		
	</form>
	
</body>
</html>