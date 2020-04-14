<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>권한설정</title>

<script type="text/javascript">

var uselist = new Array();
var nuselist = new Array();
var deptlist = new Array();
var dhlist = new Array();

$(document).ready(function() {

	$("#insert").click(function(){
		
		var dd = $("input[name=check]:checked");	
		var ndd = $('input[type=checkbox]:not(:checked)');
		var insArr = new Array();
		var delArr = new Array();
		var i= 0;
		var j= 0;
		var tr = dd.parent().parent();
		var td = tr.children();

		
		dd.each(function(i){
			
			var tr = dd.parent().parent().eq(i);
			var td = tr.children();

			var chk = td.eq(0).find('input[type=checkbox]:checked').val();
			var use = $('#hv').find('input[name=grpid]').val();
			var objc = td.eq(2).text();
			var objn = td.eq(3).text();
			var seq = td.eq(4).text();
			var ins = 'ins';
			var grpname = $('#hv').find('input[name=grpname]').val();
			var dept = td.eq(5).text();
			
			var tdArr2 = new Array();

			tdArr2.push(chk);
			tdArr2.push(use);
			tdArr2.push(objc);
			tdArr2.push(objn);
			tdArr2.push(seq);
			tdArr2.push(ins);
			tdArr2.push(grpname);
			tdArr2.push(dept);
			
			uselist.push(objc);
			dhlist.push(seq);
			
			insArr.push(tdArr2);

		})
	
		ndd.each(function(i){
			
			var tr = ndd.parent().parent().eq(i);
			var td = tr.children();

			var chk = td.eq(0).find('input[type=checkbox]:not(:checked)').val();
			var use = $('#hv').find('input[name=grpid]').val();
			var objc = td.eq(2).text();
			var objn = td.eq(3).text();
			var seq = td.eq(4).text();
			var del = 'del';
			var grpname = $('#hv').find('input[name=grpname]').val();
			var dept = td.eq(5).text();
	
			var tdArr2 = new Array();
		
			tdArr2.push(chk);
			tdArr2.push(use);
			tdArr2.push(objc);
			tdArr2.push(objn);
			tdArr2.push(seq);
			tdArr2.push(del);
			tdArr2.push(grpname);
			tdArr2.push(dept);

			nuselist.push(objc);
			deptlist.push(dept);
	
			delArr.push(tdArr2);
		})


		for(var i=0;i<insArr.length;++i){ 

			if(uselist.length>1){
				
				if(uselist.includes("OBJ100")){

					if( uselist.includes(insArr[i][4]) ){
						
						$("#hhv").html("<form><input type='hidden' name='chk' value='"+insArr[i][0]+"'></form>"+
								"<form><input type='hidden' name='grpid' value='"+insArr[i][1]+"'></form>"+
								"<form><input type='hidden' name='objid' value='OBJ100'></form>"+
								"<form><input type='hidden' name='objname' value='메인'></form>"+
								"<form><input type='hidden' name='high_obj' value=''></form>"+
								"<form><input type='hidden' name='ins' value='"+insArr[i][5]+"'></form>"+
								"<form><input type='hidden' name='grpname' value='"+insArr[i][6]+"'></form>"+
								"<form><input type='hidden' name='dept' value='1'></form>"+
								"<form><input type='hidden' name='flag' value='flag'></form>");
						

						$("#hv").append("<form><input type='hidden' name='chk' value='"+insArr[i][0]+"'></form>"+
								"<form><input type='hidden' name='grpid' value='"+insArr[i][1]+"'></form>"+
								"<form><input type='hidden' name='objid' value='"+insArr[i][2]+"'></form>"+
								"<form><input type='hidden' name='objname' value='"+insArr[i][3]+"'></form>"+
								"<form><input type='hidden' name='high_obj' value='"+insArr[i][4]+"'></form>"+
								"<form><input type='hidden' name='ins' value='"+insArr[i][5]+"'></form>"+
								"<form><input type='hidden' name='grpname' value='"+insArr[i][6]+"'></form>"+
								"<form><input type='hidden' name='dept' value='"+insArr[i][7]+"'></form>"+
								"<form><input type='hidden' name='flag' value='flag'></form>");
						
					}
					
				}
				
			}	

			if(uselist.length==1){
				
				if(uselist.includes("OBJ100")){

					$("#hhv").html("<form><input type='hidden' name='chk' value='"+insArr[i][0]+"'></form>"+
							"<form><input type='hidden' name='grpid' value='"+insArr[i][1]+"'></form>"+
							"<form><input type='hidden' name='objid' value='"+insArr[i][2]+"'></form>"+
							"<form><input type='hidden' name='objname' value='"+insArr[i][3]+"'></form>"+
							"<form><input type='hidden' name='high_obj' value='"+insArr[i][4]+"'></form>"+
							"<form><input type='hidden' name='ins' value='"+insArr[i][5]+"'></form>"+
							"<form><input type='hidden' name='grpname' value='"+insArr[i][6]+"'></form>"+
							"<form><input type='hidden' name='dept' value='"+insArr[i][7]+"'></form>"+
							"<form><input type='hidden' name='flag' value='flag'></form>");

				}
				
			} 

		}

		if($("input[name='ins']").length <uselist.length){
			
			$("#hhv").empty();
			$("#hv").empty();

		}

		for(j=0;j<delArr.length;++j){
			
			if(uselist.length>0 && nuselist.length>0){
				
				if(delArr[j][7]=="3"){

					$("#ddv").append("<form><input type='hidden' name='chk' value='"+delArr[j][0]+"'></form>"+
							"<form><input type='hidden' name='grpid' value='"+delArr[j][1]+"'></form>"+
							"<form><input type='hidden' name='objid' value='"+delArr[j][2]+"'></form>"+
							"<form><input type='hidden' name='objname' value='"+delArr[j][3]+"'></form>"+
							"<form><input type='hidden' name='high_obj' value='"+delArr[j][4]+"'></form>"+
							"<form><input type='hidden' name='del' value='"+delArr[j][5]+"'></form>"+
							"<form><input type='hidden' name='grpname' value='"+delArr[j][6]+"'></form>"+
							"<form><input type='hidden' name='dept' value='"+delArr[j][7]+"'></form>"+
							"<form><input type='hidden' name='flag' value='flag'></form>");
					
				}else if(uselist.includes(delArr[j][4]) && nuselist.includes(delArr[j][2]) ){
					
					if(delArr[j][7]=="3"){

						$("#ddv").append("<form><input type='hidden' name='chk' value='"+delArr[j][0]+"'></form>"+
								"<form><input type='hidden' name='grpid' value='"+delArr[j][1]+"'></form>"+
								"<form><input type='hidden' name='objid' value='"+delArr[j][2]+"'></form>"+
								"<form><input type='hidden' name='objname' value='"+delArr[j][3]+"'></form>"+
								"<form><input type='hidden' name='high_obj' value='"+delArr[j][4]+"'></form>"+
								"<form><input type='hidden' name='del' value='"+delArr[j][5]+"'></form>"+
								"<form><input type='hidden' name='grpname' value='"+delArr[j][6]+"'></form>"+
								"<form><input type='hidden' name='dept' value='"+delArr[j][7]+"'></form>"+
								"<form><input type='hidden' name='flag' value='flag'></form>");
						
					}else if(delArr[j][7]=="2"){
						
						if(!uselist.includes(delArr[j][2]) && !dhlist.includes(delArr[j][2])){
							
							$("#dv").append("<form><input type='hidden' name='chk' value='"+delArr[j][0]+"'></form>"+
									"<form><input type='hidden' name='grpid' value='"+delArr[j][1]+"'></form>"+
									"<form><input type='hidden' name='objid' value='"+delArr[j][2]+"'></form>"+
									"<form><input type='hidden' name='objname' value='"+delArr[j][3]+"'></form>"+
									"<form><input type='hidden' name='high_obj' value='"+delArr[j][4]+"'></form>"+
									"<form><input type='hidden' name='del' value='"+delArr[j][5]+"'></form>"+
									"<form><input type='hidden' name='grpname' value='"+delArr[j][6]+"'></form>"+
									"<form><input type='hidden' name='dept' value='"+delArr[j][7]+"'></form>"+
									"<form><input type='hidden' name='flag' value='flag'></form>");
							
						}
					
					}else if(delArr[j][7]=="1"){
						
						if(!uselist.includes(delArr[j][2])){
							
							$("#dv").append("<form><input type='hidden' name='chk' value='"+delArr[j][0]+"'></form>"+
									"<form><input type='hidden' name='grpid' value='"+delArr[j][1]+"'></form>"+
									"<form><input type='hidden' name='objid' value='"+delArr[j][2]+"'></form>"+
									"<form><input type='hidden' name='objname' value='"+delArr[j][3]+"'></form>"+
									"<form><input type='hidden' name='high_obj' value='"+delArr[j][4]+"'></form>"+
									"<form><input type='hidden' name='del' value='"+delArr[j][5]+"'></form>"+
									"<form><input type='hidden' name='grpname' value='"+delArr[j][6]+"'></form>"+
									"<form><input type='hidden' name='dept' value='"+delArr[j][7]+"'></form>"+
									"<form><input type='hidden' name='flag' value='flag'></form>");
							
						}
										
					}			

				}

			}
			
			if( uselist.length==0 ){
				
				$("#dv").append("<form><input type='hidden' name='chk' value='"+delArr[j][0]+"'></form>"+
						"<form><input type='hidden' name='grpid' value='"+delArr[j][1]+"'></form>"+
						"<form><input type='hidden' name='objid' value='"+delArr[j][2]+"'></form>"+
						"<form><input type='hidden' name='objname' value='"+delArr[j][3]+"'></form>"+
						"<form><input type='hidden' name='high_obj' value='"+delArr[j][4]+"'></form>"+
						"<form><input type='hidden' name='del' value='"+delArr[j][5]+"'></form>"+
						"<form><input type='hidden' name='grpname' value='"+delArr[j][6]+"'></form>"+
						"<form><input type='hidden' name='dept' value='"+delArr[j][7]+"'></form>"+
						"<form><input type='hidden' name='flag' value='flag'></form>");
			}
 
		}

		if($('input[type=checkbox]:not(:checked)').length > $("input[name='del']").length){
			
			$("#dv").html("");
			$("#ddv").html("");
			
		}
		
		var data =  $('form').serialize();

		$.ajax({
			
			url:"./crud.ino" ,
			type: "POST" ,
			data : data,
			dataType: "json" ,
			contentType: "application/json; charset=UTF-8" ,
			success:function(result){
				
				if(result.ins==1 || result.del==1){
					
					alert('정상적으로 처리되었습니다.');
					
				}else{
					
					alert('처리 되지 않았습니다.');
					
				}
				 
				$("#root").html("");
		
				var html = '';
				var a= "";
				var b= "";
				html+="<tr>"

				$("#hv").html("<form><input type='hidden' name='grpid' value='"+result.grpid+"'><input type='hidden' name='grpname' value='"+result.grpname+"'><input type='hidden' name='flag' value='flag'></form>");
				$("#dv").html("<form><input type='hidden' name='grpid' value='"+result.grpid+"'><input type='hidden' name='grpname' value='"+result.grpname+"'><input type='hidden' name='flag' value='flag'></form>");
				$("#hhv").html("<form><input type='hidden' name='grpid' value='"+result.grpid+"'><input type='hidden' name='grpname' value='"+result.grpname+"'><input type='hidden' name='flag' value='flag'></form>");
				$("#ddv").html("<form><input type='hidden' name='grpid' value='"+result.grpid+"'><input type='hidden' name='grpname' value='"+result.grpname+"'><input type='hidden' name='flag' value='flag'></form>");
				for(var j=0;j<result.objlist.length;++j){
					
					a= "미사용중";
					b= "<input type='checkbox' name='check' value='F'>";

					for(var i=0;i<result.uselist.length;++i){
						
						if(result.objlist[j].OBJID == result.uselist[i].M_OBJID ){
							 
							a = "사용중";
							b = "<input type='checkbox' name='check' checked='' value='T'>";
							
						}

					}//end for i
					
					html+="<td align='center'>"+b+"</td>"
					html+="<td align='center'>"+a+"</td>"
					html+="<td align='center'>"+result.objlist[j].OBJID+"</td>"
					html+="<td align='center'>"+result.objlist[j].OBJNAME+"</td>"
					if(result.objlist[j].HIGH_OBJ==null){
						html+="<td align='center'></td>"
						html+="<td align='center'>"+result.objlist[j].DEPT+"</td>"
						html+="</tr>"
					}else{
						html+="<td align='center'>"+result.objlist[j].HIGH_OBJ+"</td>"
						html+="<td align='center'>"+result.objlist[j].DEPT+"</td>"
						html+="</tr>"
					}
			 
				}//end for j
		
				$('#root').append(html);

				uselist = [];
				nuselist = [];
				dhlist = [];
			},
			
			error:function(){
				
			}
		})
		
	});
});


	function grpidtext(e){
		
		$("#root").html("");
		
		var frm = $(e).attr('value');
		
		$.ajax({
			url: "./objlist.ino" ,
			type: "post" ,
			data: frm ,
			dataType: "json" ,
			contentType: "application/json; charset=UTF-8" ,
			success:function(result){

			var html = '';
			var a= "";
			var b= "";
			html+="<tr>"

			$("#hv").html("<form><input type='hidden' name='grpid' value='"+result.grpid+"'><input type='hidden' name='grpname' value='"+result.grpname+"'><input type='hidden' name='flag' value='flag'></form>");
			$("#dv").html("<form><input type='hidden' name='grpid' value='"+result.grpid+"'><input type='hidden' name='grpname' value='"+result.grpname+"'><input type='hidden' name='flag' value='flag'></form>");
			$("#hhv").html("<form><input type='hidden' name='grpid' value='"+result.grpid+"'><input type='hidden' name='grpname' value='"+result.grpname+"'><input type='hidden' name='flag' value='flag'></form>");
			$("#default").html("<form><input type='hidden' name='grpid' value='"+result.grpid+"'><input type='hidden' name='grpname' value='"+result.grpname+"'><input type='hidden' name='flag' value='flag'></form>");
			for(var j=0;j<result.objlist.length;++j){
				
				a= "미사용중";
				b= "<input type='checkbox' name='check' value='F'>";

				for(var i=0;i<result.uselist.length;++i){

					if(result.objlist[j].OBJID == result.uselist[i].M_OBJID ){
						 
						a = "사용중";
						b = "<input type='checkbox' name='check' checked='' value='T'>";
						
					}

				}//end for i
				
				html+="<td align='center'>"+b+"</td>"
				html+="<td align='center'>"+a+"</td>"
				html+="<td align='center'>"+result.objlist[j].OBJID+"</td>"
				html+="<td align='center'>"+result.objlist[j].OBJNAME+"</td>"
				if(result.objlist[j].HIGH_OBJ==null){
					html+="<td align='center'></td>"
					html+="<td align='center'>"+result.objlist[j].DEPT+"</td>"
					html+="</tr>"
				}else{
					html+="<td align='center'>"+result.objlist[j].HIGH_OBJ+"</td>"
					html+="<td align='center'>"+result.objlist[j].DEPT+"</td>"
					html+="</tr>"
				}
				
		
			}//end for j
	
			$('#root').append(html);

			
			},
			error:function(){
				alert('error');
			}
		});
		
	};

</script>



</head>

<body>
	
	<div>
		<h2 align="center">회사리스트</h2>
	</div>
	
	<hr style="width: 600px">
	
	<table style="width: 400px" border="1">
	
	<thead>
		<tr>
			<th align="center">회사아이디</th>
			<th align="center">회사이름</th>
			<th align="center">사용유무</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="grp" items="${grplist}">
		<tr> 
			<td align="center"><a href="javascript:void(0);"  onclick="grpidtext(this);" value="${grp.GRPID}">${grp.GRPID}</a></td>
			<td align="center"><a href="javascript:void(0);"  onclick="grpidtext(this);" value="${grp.GRPID}">${grp.GRPNAME }</a></td>
			<td align="center">${grp.USE_YN }</td>		
		</tr>	
	</c:forEach>
	</tbody>
	
	</table>
	
	<div>
		<h2 align="center">권한리스트</h2>
	</div>
	<div style="width:600px;" align="right">
		<button type="button" name="insert" id="insert" >등록</button>
	</div>

	<hr style="width: 600px">
	
	<table style="width: 600px" border="1">
	
	<thead>
		<tr>
			<th align="center">확인</th>
			<th align="center">사용여부</th>
			<th align="center">권한아이디</th>
			<th align="center">권한이름</th>
			<th align="center">권한소속</th>
			<th align="center">권한순위</th>			
		</tr>
	</thead>
	
	<tbody id="root">
	
	</tbody>
	
	</table>
	
	<div id="hv"></div>
	<div id="dv"></div>
	<div id="hhv"></div>
	<div id="ddv"></div>
	<div id="default"></div>

</body>

</html>