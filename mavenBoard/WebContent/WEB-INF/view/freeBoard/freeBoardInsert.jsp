<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	

	$("#insertbtn").click(function(){
	
	var chk = confirm("���� ����Ͻðڽ��ϱ�?");	
	if(chk){
		if(check()){
    var dd =  $('#insert').serialize();
    
    $.ajax({
		url: "./insert.ino" ,
		type: "post" ,
		datatype: "json" ,
		data: dd,
		
		success: function(result){
			console.log(result);
			if(result==1){
			
				alert("�� ��Ͽ� ������");
				location.href ="./main.ino";
				
			}else if(result==0){
				
				alert("�� ��Ͽ� ���� �Ͽ����ϴ�");
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
</script>
<script type="text/javascript">
function check() {
	var name = document.insert.name.value;
	
	var title = document.insert.title.value;

	var content = document.insert.content.value;

	name = name.replace(/ /gi,"");

	title = title.replace(/ /gi,"");


	content = content.replace(/ /gi,"");



	if(name!="" && title != "" && content !="" ) { 
		
	
		return true;

	}

	else{ 

		alert("�ùٸ��� ���� ���Դϴ�.");
		document.insert.name.focus();
		return false;

	}

}
function create() {
	var chk = confirm("���� ����Ͻðڽ��ϱ�?");
	
	
	if(check()){
	if (chk) {
		
		location.href="./main.ino";
	}
	}else{
		return false;
	}
	
}	


</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>�����Խ���</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">����Ʈ��</a>
	</div>
	<hr style="width: 600px">
	
	<form id="insert"
			name="insert" 
			action="./freeBoardInsertPro.ino" 
			onsubmit="return check()">
		
		<div style="width: 150px; float: left;">�̸� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name"/></div>
		
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"/></div>
	
		<div style="width: 150px; float: left;">���� :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  ></textarea></div>
		<div align="right">
		<button type="button" name="insertbtn"  id="insertbtn" >�۾���</button>
		<input type="button" value="�ٽþ���" onclick="reset()">
		<input type="button" value="���" onclick="history.back();">
		&nbsp;&nbsp;&nbsp;
		</div>
	
	</form>
	
	
	
</body>
</html>