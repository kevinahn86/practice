<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

$(document).ready(function() {
	
	var count=0;
	
	$("#create").click(function(){

		var addedFormDiv = $("#addedFormDiv");
		
		    if(count<=2){
		    	
		    var str = "";

			str+="<form>";
			str+="<input type='text' name='code'  style='width: 210px; float: left;' value='${map.code}' readonly/>";
			str+="<input type='text' name='dcode' style='width: 230px; float: left;' >";
			str+="<input type='text' name='dcode_name' style='width: 200px; float: left;'>";
			str+="<label><input type='radio' name='use_yn' value='Y' checked='checked'/>Y</lable>";
		    str+="<label><input type='radio' name='use_yn' value='N'/>N</label>";
		    str+="<hr style='width: 850px' align='left'></div>";
			str+="<input type='hidden' name='flag' value='flag'>";
			str+="</form>";

		   
		    var addedDiv = document.createElement("div"); 

		    addedDiv.id = "added_"+count; 

		    addedDiv.innerHTML  = str; 

		    addedFormDiv.append(addedDiv); 

		    count++;
			
			return false;
			
		    }else{
		    	
		   	return true;
		   	
		    }
		
	});
	

	$("#insert").click(function(){
	
	var check = $("input[type=checkbox]:checked").val();
	var dcodearr = $("input[name='dcode']");
	var dcodenamarr = $("input[name='dcode_name']");
	var radionum = $("input:radio[name='use_yn']:checked");

	
 	for(var a=0;a<dcodearr.length;++a){
				
		if(dcodearr[a].value=="" || dcodearr==null){
			alert('값을 입력해주세요');
			return;
		}
		
		if(dcodenamarr[a].value=="" || dcodenamarr==null){
			alert('이름을 입력해주세요');
			return;
		}

		
		for(var b=a+1;b<dcodearr.length;++b){
			if(dcodearr[a].value==dcodearr[b].value){
				alert('중복된 값이 존재합니다.');
				return;
			}
		}
		
	} 

	var frm = $('form').serialize();

	if(frm==null || frm==""){
		alert('등록할 값이 존재하지 않습니다.');
		return;
	}
	
	$.ajax({ 
          url:"./create.ino" ,
          type : "POST",
          data : frm,
          dataType : "json",
          contentType: "application/json; charset=UTF-8" ,
          success:function(result){

				if(result.confirm==0){
					
				alert('정상적으로 입력되었습니다.');
				location.href='./commonCodeDetail.ino?code='+result.code;
					
				if(result.error==1){
						alert('정상적으로 입력되지 않았습니다.');	
						location.href='./commonCodeDetail.ino?code='+result.code;
					}	
				
    			}else if(result.confirm==null){
    				
    				alert('입력된 값이 존재 하지 않습니다.');
    				
    			}else{
    				
    				alert('중복된 값이 존재합니다.');
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
		
	});
	
	$("#modify").click(function(){
	
		var dd = $("input[name=check]:checked");	
		var tdArr = new Array();
		var i= 0;
		var tr = dd.parent().parent();
		var td = tr.children();
		
		dd.each(function(i){
			
			var tr = dd.parent().parent().eq(i);
			var td = tr.children();

			var chk = td.eq(0).find('input[type=checkbox]:checked').val();
			var cod = td.eq(1).text();
			var dcod = td.eq(2).text();
			var dcodn = td.eq(3).find('input[name=dcode_name]').val();
			var uyn = td.eq(4).find('input[name=use_yn]').val();

			var tdArr2 = new Array();
			
			tdArr2.push(chk);
			tdArr2.push(cod);
			tdArr2.push(dcod);
			tdArr2.push(dcodn);
			tdArr2.push(uyn);
			
			tdArr.push(tdArr2);
		})


		if(dd.length==0){
	
				alert('수정할 데이터가 선택 되지 않았습니다.');

		}

		for(i=0;i<tdArr.length;++i){

			if(tdArr[i][0]=='1'){
			
				tr.eq(i).html("");
				tr.eq(i).html("<td align='center'><input type='checkbox' name='check' checked='' value='M'></td>"+
					"<td align='center'><div style='width: 200px; float: left;'>"+tdArr[i][1]+"</div></td>"+
					"<td align='center'><form><input type='hidden' name='dcode' value='"+tdArr[i][2]+"'><div style='width: 240px; float: left;'>"+tdArr[i][2]+"</form></td> "+
					"<td align='center'><form><input type='text' name='dcode_name' style='width: 220px; float: left;' value='"+tdArr[i][3]+"'></form></td>");

			
				if(tdArr[i][4]=='Y'){
					tr.eq(i).append("<td align='center'><form><input type='hidden' name='use_yn' value='Y'><label><input type='radio' name='use_yn' checked='' value='Y'/>Y</lable>"+
						"<label><input type='radio' name='use_yn' value='N'/>N</label><input type='hidden' name='modify' value='modify'><input type='hidden' name='flag' value='flag'></form></td>");
				}else if(tdArr[i][4]=='N'){
					tr.eq(i).append("<td align='center'><form><input type='hidden' name='use_yn' value='N'><label><input type='radio' name='use_yn' value='Y'/>Y</lable>"+
						"<label><input type='radio' name='use_yn' checked='' value='N'/>N</label><input type='hidden' name='modify' value='modify'><input type='hidden' name='flag' value='flag'></form></td>");
				}
				
			}else if(tdArr[i][0]=='D'){
				
				tr.eq(i).html("");
				tr.eq(i).append("<td align='center'><input type='checkbox' name='check' checked='' value='D'></td>"+
						"<td align='center'><div style='width: 200px; float: left;'><font color='red'>"+tdArr[i][1]+"</font></div></td>"+
						"<td align='center'><form><input type='hidden' name='dcode' value='"+tdArr[i][2]+"'><div style='width: 240px; float: left;'><font color='red'>"+tdArr[i][2]+"</font></div></form></td> "+
						"<td align='center'><form><input type='hidden' name='dcode_name' value='"+tdArr[i][3]+"'><div style='width: 220px; float: left;'><font color='red'>"+tdArr[i][3]+"</font></form></td>"+
						"<td align='center'><form><input type='hidden' name='use_yn' value='"+tdArr[i][4]+"'><div style='width: 150px; float: left;'><font color='red'>"+tdArr[i][4]+"</font><input type='hidden' name='delete' value='delete'><input type='hidden' name='flag' value='flag'></form></td>");
			
			}else{
				
				tr.eq(i).html("");
				tr.eq(i).append("<td align='center'><input type='checkbox' name='check' value='1'></td>"+
						"<td align='center'><div style='width: 200px; float: left;'>"+tdArr[i][1]+"</div></td>"+
						"<td align='center'><div style='width: 240px; float: left;'>"+tdArr[i][2]+"</div></td> "+
						"<td align='center'><form><input type='hidden' name='dcode_name' value='"+tdArr[i][3]+"'><div style='width: 220px; float: left;'>"+tdArr[i][3]+"</form></td>"+
						"<td align='center'><form><input type='hidden' name='use_yn' value='"+tdArr[i][4]+"'><div style='width: 150px; float: left;'>"+tdArr[i][4]+"</form></td>");
				
			}

		}//end for

		
	});
	
	$("#delete").click(function(){

		var dd = $("input[name=check]:checked");					
		var tdArr = new Array();
		var i= 0;
		var tr = dd.parent().parent();
		var td = tr.children();
		
		dd.each(function(i){
			
			var tr = dd.parent().parent().eq(i);
			var td = tr.children();
	
			var chk = td.eq(0).find('input[type=checkbox]:checked').val();
	
			var cod = td.eq(1).text();
			var dcod = td.eq(2).text();
			var dcodn = td.eq(3).find('input[name=dcode_name]').val();
			var uyn = td.eq(4).find('input[name=use_yn]').val();

			
			var tdArr2 = new Array();
			
			tdArr2.push(chk);
			tdArr2.push(cod);
			tdArr2.push(dcod);
			tdArr2.push(dcodn);
			tdArr2.push(uyn);

			tdArr.push(tdArr2);

		})
		
		if(dd.length==0){
			
			alert('삭제할 데이터가 선택 되지 않았습니다.');

	}
	
		for(i=0;i<tdArr.length;++i){
			
			if(tdArr[i][0]=='1'){
				
			tr.eq(i).html("");
			tr.eq(i).append("<td align='center'><input type='checkbox' name='check' checked='' value='D'></td>"+
					"<td align='center'><div style='width: 200px; float: left;'><font color='red'>"+tdArr[i][1]+"</font></div></td>"+
					"<td align='center'><form><input type='hidden' name='dcode' value='"+tdArr[i][2]+"'><div style='width: 240px; float: left;'><font color='red'>"+tdArr[i][2]+"</font></div></form></td> "+
					"<td align='center'><form><input type='hidden' name='dcode_name' value='"+tdArr[i][3]+"'><div style='width: 220px; float: left;'><font color='red'>"+tdArr[i][3]+"</font></form></td>"+
					"<td align='center'><form><input type='hidden' name='use_yn' value='"+tdArr[i][4]+"'><div style='width: 150px; float: left;'><font color='red'>"+tdArr[i][4]+"</font><input type='hidden' name='delete' value='delete'><input type='hidden' name='flag' value='flag'></form></td>");
			
			}else if(tdArr[i][0]=='M'){
				
				tr.eq(i).html("");
				tr.eq(i).html("<td align='center'><input type='checkbox' name='check' checked='' value='M'></td>"+
					"<td align='center'><div style='width: 200px; float: left;'>"+tdArr[i][1]+"</div></td>"+
					"<td align='center'><form><input type='hidden' name='dcode' value='"+tdArr[i][2]+"'><div style='width: 240px; float: left;'>"+tdArr[i][2]+"</form></td> "+
					"<td align='center'><form><input type='text' name='dcode_name' style='width: 220px; float: left;' value='"+tdArr[i][3]+"'></form></td>");

			
				if(tdArr[i][4]=='Y'){
					tr.eq(i).append("<td align='center'><form><input type='hidden' name='use_yn' value='Y'><label><input type='radio' name='use_yn' checked='' value='Y'/>Y</lable>"+
						"<label><input type='radio' name='use_yn' value='N'/>N</label><input type='hidden' name='modify' value='modify'><input type='hidden' name='cf' value='cf'><input type='hidden' name='flag' value='flag'></form></td>");
				}else if(tdArr[i][4]=='N'){
					tr.eq(i).append("<td align='center'><form><input type='hidden' name='use_yn' value='N'><label><input type='radio' name='use_yn' value='Y'/>Y</lable>"+
						"<label><input type='radio' name='use_yn' checked='' value='N'/>N</label><input type='hidden' name='modify' value='modify'><input type='hidden' name='cf' value='cf'><input type='hidden' name='flag' value='flag'></form></td>");
				}
				
			
			}else{

				tr.eq(i).html("");
				tr.eq(i).append("<td align='center'><input type='checkbox' name='check' value='1'></td>"+
						"<td align='center'><div style='width: 200px; float: left;'>"+tdArr[i][1]+"</div></td>"+
						"<td align='center'><div style='width: 240px; float: left;'>"+tdArr[i][2]+"</div></td> "+
						"<td align='center'><form><input type='hidden' name='dcode_name' value='"+tdArr[i][3]+"'><div style='width: 220px; float: left;'>"+tdArr[i][3]+"</form></td>"+
						"<td align='center'><form><input type='hidden' name='use_yn' value='"+tdArr[i][4]+"'><div style='width: 150px; float: left;'>"+tdArr[i][4]+"</form></td>");
			}
			
		}//end for 	 
		
	});
	
});

</script>

</head>
<body>
	<div>
		<h1>공통코드</h1>
	</div>
	<div style="width:800px;" align="right">
		<button type="button" name="delete" id="delete">삭제</button>
		<button type="button" name="modify" id="modify">수정</button>
		<button type="button" name="create" id="create">추가</button>
		<button type="button" name="insert" id="insert">등록</button>
	</div>
	<hr style="width: 850px" align="left">
	<table id="rlist" border="0" style="width: 850px" align="left">

		<tr>
			<th align="left">   </th>
			<th>코드</th>
			<th>디테일코드</th>
			<th>코드명</th>
			<th>사용유무</th>
		</tr>
	<tbody id="rlistbody">
	<c:forEach var="nRow" items="${list}">
		
		<tr>
			<td align="center"><input type="checkbox" name="check" style="width:40px; float: left;" value="1"></td>
			<td align="center"><div style="width: 200px; float: left;">${nRow.CODE }</div></td>
			<td align="center"><div style="width: 240px; float: left;">${nRow.DCODE }</div></td>
			<td align="center"><div style="width: 220px; float: left;"><input type="hidden" name="dcode_name" value="${nRow.DCODE_NAME }">${nRow.DCODE_NAME }</div></td>
			<td align="center"><div style="width: 150px; float: left;"><input type="hidden" name="use_yn" value="${nRow.USE_YN }">${nRow.USE_YN }</div></td>
		</tr>

	</c:forEach>
	</tbody>
	</table>
	<br><br><br>

	<div id="addedFormDiv">
	
	</div>

</body>
</html>