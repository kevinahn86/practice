<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>권한설정</title>

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
			<td align="center"><a href="./objlist.ino">${grp.GRPID }</a></td>
			<td align="center"><a href="./objlist.ino">${grp.GRPNAME }</a></td>
			<td align="center">${grp.USE_YN }</td>
		</tr>	
	</c:forEach>
	</tbody>
	
	</table>
	
	<div>
		<h2 align="center">권한리스트</h2>
	</div>
	<div style="width:600px;" align="right">
		<button type="button" name="insert" id="insert">등록</button>
	</div>
	
	<hr style="width: 600px">
	
	<table style="width: 600px" border="1">
	
	<thead>
		<tr>
			<th align="center">확인</th>
			<th align="center">사용여부</th>
			<th align="center">권한아이디</th>
			<th align="center">권한이름</th>
			<th align="center">권한순번</th>			
		</tr>
	</thead>
	<tbody id="root">

	
		<tr>
			<td align="center"></td>
		<c:forEach var="map" items="${maplist }">	
			<td align="center">${map.USE_YN }</td>
		</c:forEach>
		<c:forEach var="obj" items="${objlist}">
			<td align="center">${obj.OBJID }</td>
			<td align="center">${obj.OBJNAME }</td>
			<td align="center">${obj.ORDER_SEQ }</td>
		</c:forEach>
		</tr>	
	
	
		
	</tbody>
	
	</table>
	
</body>

</html>