<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%

request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">


$(document).ready(function() {
	
    
	 $('#keyword1').keydown(function(e) {
		    if (e.keyCode == 13) {
		        $('#search').trigger("click");
		    }
		});

	
	$("#search").click(function(){
	
	var dateval = /^\d{4}\-\d{2}\-\d{2}$/;
	
	var re = /(1[9]|2[0])[0-9]{2}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])/;
	
	var obj = new Object();

	obj.type = $('#searchType').val();
	
	obj.key = $('#keyword1').val();
	
	obj.day1 = $('#day1').val();

	obj.day2 =  $('#day2').val();
	
	if ( obj.key=="" && obj.day1=="" && obj.day2==""){
		alert("값을 입력해주세요");
		return false; 
	}
	
	if(obj.type=="num"){
		
		if(obj.key==""){
			alert("글번호를 입력해주세요.");
			return false;
		}
		
		if(isNaN(obj.key)){
			alert("숫자만 입력가능합니다.");
			return false;
		}
		
	}
	

	if(obj.key==""){
			
		if( obj.day1 > obj.day2 ){
			alert("입력한 날짜가 잘못되었습니다0.");
			$("#frm")[0].reset();
			return false;
		}
		if(!dateval.test(obj.day1)){
			alert("입력한 날짜가 잘못되었습니다1.");
			return false;
		}
		if(!dateval.test(obj.day2)){
			alert("입력한 날짜가 잘못되었습니다2.");
			return false;	
		} 
		if(!re.test(obj.day1)){
			alert("입력한 날짜가 잘못되었습니다3.");
			return false;	
		}
		if(!re.test(obj.day2)){
			alert("입력한 날짜가 잘못되었습니다4.");
			return false;	
		} 
	

	}else if(obj.key!='' && obj.day1!='' && obj.day2==''){
			
	
			if( obj.day1 > obj.day2 ){
				alert("입력한 날짜가 잘못되었습니다0.");
				$("#frm")[0].reset();
				return false;
			}
			if(!dateval.test(obj.day1)){
				alert("입력한 날짜가 잘못되었습니다1.");
				return false;
			}
			if(!dateval.test(obj.day2)){
				alert("입력한 날짜가 잘못되었습니다2.");
				return false;	
			} 
			if(!re.test(obj.day1)){
				alert("입력한 날짜가 잘못되었습니다3.");
				return false;	
			}
			if(!re.test(obj.day2)){
				alert("입력한 날짜가 잘못되었습니다4.");
				return false;	
			} 
		
			
			return false;
			
	}else if(obj.key!='' && obj.day2!='' && obj.day1==''){
		
		if( obj.day1 > obj.day2 ){
			alert("입력한 날짜가 잘못되었습니다0.");
			$("#frm")[0].reset();
			return false;
		}
		if(!dateval.test(obj.day1)){
			alert("입력한 날짜가 잘못되었습니다1.");
			return false;
		}
		if(!dateval.test(obj.day2)){
			alert("입력한 날짜가 잘못되었습니다2.");
			return false;	
		} 
		if(!re.test(obj.day1)){
			alert("입력한 날짜가 잘못되었습니다3.");
			return false;	
		}
		if(!re.test(obj.day2)){
			alert("입력한 날짜가 잘못되었습니다4.");
			return false;	
		} 
	
		alert("날짜입력을 해주세요");
		return false;
		
	}

	if(obj.day1 !='' && obj.day2 !=''){
		
		var checknum = 1;

		var yearday1 = obj.day1.substr(0,4);
		var monthday1 = obj.day1.substr(5,2);
		var dayday1 = obj.day1.substr(8,2);
		
		var yearday2 = obj.day2.substr(0,4);
		var monthday2 = obj.day2.substr(5,2);
		var dayday2 = obj.day2.substr(8,2);
		
		var resultday = ((yearday2*12)+monthday2) - ((yearday1*12)+monthday1);
		
		if(!(resultday<=checknum && dayday1 <= dayday2)){

			alert("날짜검색의 범위는 한달 입니다.");
			return false;
		}

	}

		var frm = $("#frm").serialize();

    	$.ajax({ 
                  url:"./search.ino",
                  type:"get",
                  datatype : "json",
                  data: frm , 
                  success:function(result){
       
                	var a = "";
                	$("#paging").empty();
                	var b = "";

                	for(var i=0;i<result.list.length;++i){
						
				   		a+= "<div style='width: 50px; float: left;'>"+result.list[i].NUM+"</div>"
				   		a+= "<div style='width: 300px; float: left;'><a href='./freeBoardDetail.ino?num="+result.list[i].NUM+"'>"+result.list[i].TITLE+"</a></div>"
				   		a+= "<div style='width: 150px; float: left;'>"+result.list[i].NAME+"</div>"
				   		a+= "<div style='width: 150px; float: left;'>"+result.list[i].REGDATE+"</div>"
				   		a+= "<hr style='width: 600px'>";	
						
 
					}    
					    $("#searchlist").html(a);
					    
					   for(var j=1;j<=result.pageMaker.totPage;++j){
						
			   				if(result.pageMaker.curPage>1){
			   					
			   					b+="<a href='./main.ino?curPage=1&searchType="+result.searchType+"&keyword1="+result.keyword1+"&day1="+result.day1+"&day2="+result.day2+" ' >[처음]</a>"
			   					b+="<a href='./main.ino?curPage="+result.pageMaker.prevPage+"&searchType="+result.searchType+"&keyword1="+result.keyword1+"&day1="+result.day1+"&day2="+result.day2+" '>[이전]</a>";
			   					 
			   				}
			   				if(result.pageMaker.curPage==j){
			   					
			   					b+="<span style='color: red'>"+j+"</span>&nbsp;";
			   					
			   				}else{
			   					
						   b+= "<a href='./main.ino?curPage="+j+"&searchType="+result.searchType+"&keyword1="+result.keyword1+"&day1="+result.day1+"&day2="+result.day2+" '>"+j+"</a> ";
			   				
			   				}
					    
					   }//end for
					   
						if(result.pageMaker.curPage<result.pageMaker.totPage){
							
							b+="<a href='./main.ino?curPage="+result.pageMaker.nextPage+"&searchType="+result.searchType+"&keyword1="+result.keyword1+"&day1="+result.day1+"&day2="+result.day2+" '>[다음]</a>"
							b+="<a href='./main.ino?curPage="+result.pageMaker.totPage+"&searchType="+result.searchType+"&keyword1="+result.keyword1+"&day1="+result.day1+"&day2="+result.day2+" '>[끝]</a>";
				  			 
						}

					   $("#paging").html(b);

                  },
                  
                  error:function(){
                      alert('Error');
                }

           });
    	
    });
	
});

function auto_date_format( e, oThis ){
    
    var num_arr = [ 
        97, 98, 99, 100, 101, 102, 103, 104, 105, 96,
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57
    ]
    
    var key_code = ( e.which ) ? e.which : e.keyCode;
    if( num_arr.indexOf( Number( key_code ) ) != -1 ){
    
        var len = oThis.value.length;
        if( len == 4 ) oThis.value += "-";
        if( len == 7 ) oThis.value += "-";
    
    }
    
}

</script>

</head>
<body> 

	<div>
		<h1>자유게시판</h1>
	</div>
	<form id = "frm"  name="frm"  onsubmit="return false;">
 	<div style="width:650px;" align="right">
		<select  name="searchType" id="searchType" >
			
			<option value="">전체</option>
			
		<c:forEach items="${dname }" var="kk">
			<option value="${kk.DCODE }"<c:if test=" ${map.searchType =='${kk.DCODE}' } ">selected</c:if>
			>${kk.DCODE_NAME }</option>
		</c:forEach>
		
		</select>
		
		<select>
			<option value="">월</option>
			
		<c:forEach items="${dname2 }" var="dd">
			<option value="${dd.DCODE }">${dd.DCODE_NAME }</option>
		</c:forEach>	
		
		</select>
			
		<input type="text"  id="keyword1" name="keyword1" value="${map.keyword1 }">

		<button  type="button" id="search" name="search">검색</button><a href="./freeBoardInsert.ino">글쓰기</a><br>
		
		<input type="text" id="day1" name="day1" value="${map.day1 }"
		onkeyup="auto_date_format(event, this)" onkeypress="auto_date_format(event, this)" maxlength="10">
		<input type="text" id="day2" name="day2" value="${map.day2 }"
		onkeyup="auto_date_format(event, this)" onkeypress="auto_date_format(event, this)" maxlength="10">
		
	</div>
	</form>

	<hr style="width: 600px">
	
	<div id="searchlist">
	
	<input type="hidden" name = "num" value="${kk.NUM}">
	<c:forEach items="${freeBoardList }" var="kk">	
			<div style="width: 50px; float: left;">${kk.NUM}</div>	
			<div style="width: 300px; float: left;"><a href="./freeBoardDetail.ino?num=${kk.NUM}">${kk.NAME }</a></div>
			<div style="width: 150px; float: left;">${kk.TITLE}</div>
			<div style="width: 150px; float: left;">${kk.REGDATE}</div> 
		<hr style="width: 600px">
	</c:forEach>
	
	
	</div>
	
	
	<div id="paging">
	
	<c:if test="${pageMaker.curPage > 1}">
	    <a href='./main.ino?curPage=1&searchType=${map.searchType}&keyword1=${map.keyword1}&day1=${map.day1}&day2=${map.day2}'>[처음]</a>
	</c:if>
	             
	<c:if test="${pageMaker.curPage > 1}">
	    <a href='./main.ino?curPage=${pageMaker.prevPage }&searchType=${map.searchType}&keyword1=${map.keyword1}&day1=${map.day1}&day2=${map.day2}'>[이전]</a>
	</c:if>
	
	<c:forEach var="dir" begin="${pageMaker.blockBegin}" end="${pageMaker.blockEnd}">
	    
	    <c:choose>
	        
	        <c:when test="${dir == pageMaker.curPage}">
	            <span style="color: red">${dir}</span> 
	        </c:when>
	        
	        <c:otherwise>
	            <a href='./main.ino?curPage=${dir }&searchType=${map.searchType}&keyword1=${map.keyword1}&day1=${map.day1}&day2=${map.day2}'>${dir}</a> 
	        </c:otherwise>
	        
	    </c:choose>
	    
	</c:forEach>
	
	<c:if test="${pageMaker.curPage < pageMaker.totPage}">
	    <a href='./main.ino?curPage=${pageMaker.nextPage }&searchType=${map.searchType}&keyword1=${map.keyword1}&day1=${map.day1}&day2=${map.day2}'>[다음]</a>
	</c:if>
	 
	<c:if test="${pageMaker.curPage < pageMaker.totPage}">
	    <a href='./main.ino?curPage=${pageMaker.totPage }&searchType=${map.searchType}&keyword1=${map.keyword1}&day1=${map.day1}&day2=${map.day2}'>[끝]</a>
	</c:if>



	</div>


</body>
</html>