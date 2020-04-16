<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
function logout(){
	
	location.href="./logout.ino";
	
}
</script>
</head>
<body> 
<form action="./login.ino" method="post"  id="loginfrm">

<c:choose>
	
	<c:when test="${sessionScope.grpid =='100'}">

		<br><br><br>
		<button type="button" onclick="logout();">로그아웃</button>
		<br><br><br>
			<ul>
				<c:forEach items="${treelist }" var="tree">				
					<c:if test="${tree.DEPT=='1' }">
						<li><a href="./${tree.M_OBJID }.ino">${tree.OBJNAME }</a></li>
					</c:if>
				</c:forEach>			
			</ul>
			
	</c:when>
	
	<c:when test="${sessionScope.grpid =='200'}">
		<br><br><br>
		<button type="button" onclick="logout();">로그아웃</button>
		<br><br><br>
			<ul>
				<c:forEach items="${treelist }" var="tree">
					<li><a href="./${tree.M_OBJID }.ino">${tree.OBJNAME }</a></li>			
				</c:forEach>
			</ul>
	</c:when>
	
	<c:when test="${sessionScope.grpid =='300'}">
		<br><br><br>
		<button type="button" onclick="logout();">로그아웃</button>
		<br><br><br>
			<ul>
				<c:forEach items="${treelist }" var="tree">
					<li><a href="./${tree.M_OBJID }.ino">${tree.OBJNAME }</a></li>			
				</c:forEach>
			</ul>
	</c:when>
	
	<c:when test="${sessionScope.grpid =='0'}">
	<br><br><br>
		<button type="button" onclick="logout();">로그아웃</button>
	
		<br><br><br><br>
		<ul>
			<li><a href="./admin.ino">권한설정</a></li>
		</ul>
		
	</c:when>
	
	<c:otherwise>
	
		<h1 class="member">LOGIN</h1>
		<div class="dd">
      		<label for="userid">ID</label><br><input type="text" name="userid"  size=8>
     	</div>
     		<br>
     		<button type="submit" >LOGIN</button>
     	<div class="clear"></div>


	</c:otherwise>
</c:choose>
</form>   
</body>
</html>