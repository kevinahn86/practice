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

function dd(e){
	$('#'+e).children('ul').toggle();
}

</script>
<style type="text/css">

</style>
</head>
<body> 
<form action="./login.ino" method="post"  id="loginfrm">

<c:choose> 
	
	<c:when test="${sessionScope.grpid =='100'}">

		<br><br><br>
		<button type="button" onclick="logout();">로그아웃</button>
		<br><br><br>
			<ul id="first"  onclick="dd(this.id);">
				<c:forEach items="${treelist }" var="tree">				
					<c:if test="${tree.DEPT=='1' }">
						<li><a href="./${tree.M_OBJID }.ino">${tree.OBJNAME }</a></li>
					</c:if>
				</c:forEach>
					<ul id="second-1"  onclick="dd(this.id);" >
							<c:forEach items="${sublist }" var="subtree">		
									<c:if test="${subtree.DEPT=='2' && subtree.M_OBJID=='OBJ110'}">
										<li><a href="./${subtree.M_OBJID }.ino">${subtree.OBJNAME }</a></li>
											<ul id="third-1" >
												<c:forEach items="${parent }" var="par">		
													<c:if test="${par.DEPT=='3' && par.HIGH_OBJ=='OBJ110'}">
														<li><a href="./${par.M_OBJID }.ino">${par.OBJNAME }</a></li>
													</c:if>		
												</c:forEach>
											</ul>					
									</c:if>		
							</c:forEach>		
					</ul>
					
					<ul id="second-2"  onclick="dd(this.id);" >
							<c:forEach items="${sublist }" var="subtree">		
									<c:if test="${subtree.DEPT=='2' && subtree.M_OBJID=='OBJ120'}">
										<li><a href="./${subtree.M_OBJID }.ino">${subtree.OBJNAME }</a></li>
											<ul id="third-2"  onclick="dd(this.id);">
												<c:forEach items="${parent1 }" var="par1">		
													<c:if test="${par1.DEPT=='3' && par1.HIGH_OBJ=='OBJ120'}">
														<li><a href="./${par1.M_OBJID }.ino">${par1.OBJNAME }</a></li>
													</c:if>		
												</c:forEach>
											</ul>					
									</c:if>		
							</c:forEach>		
					</ul>		
			</ul>

	</c:when>
	
	<c:when test="${sessionScope.grpid =='200'}">

		<br><br><br>
		<button type="button" onclick="logout();">로그아웃</button>
		<br><br><br>
			<ul>
				<c:forEach items="${treelist }" var="tree">				
					<c:if test="${tree.DEPT=='1' }">
						<li><a href="./${tree.M_OBJID }.ino">${tree.OBJNAME }</a></li>
					</c:if>
				</c:forEach>
					<ul>
							<c:forEach items="${sublist }" var="subtree">		
									<c:if test="${subtree.DEPT=='2' && subtree.M_OBJID=='OBJ110'}">
										<li><a href="./${subtree.M_OBJID }.ino">${subtree.OBJNAME }</a></li>
											<ul>
												<c:forEach items="${parent }" var="par">		
													<c:if test="${par.DEPT=='3' && par.HIGH_OBJ=='OBJ110'}">
														<li><a href="./${par.M_OBJID }.ino">${par.OBJNAME }</a></li>
													</c:if>		
												</c:forEach>
											</ul>					
									</c:if>		
							</c:forEach>		
					</ul>
					
					<ul>
							<c:forEach items="${sublist }" var="subtree">		
									<c:if test="${subtree.DEPT=='2' && subtree.M_OBJID=='OBJ120'}">
										<li><a href="./${subtree.M_OBJID }.ino">${subtree.OBJNAME }</a></li>
											<ul>
												<c:forEach items="${parent }" var="par">		
													<c:if test="${par.DEPT=='3' && par.HIGH_OBJ=='OBJ120'}">
														<li><a href="./${par.M_OBJID }.ino">${par.OBJNAME }</a></li>
													</c:if>		
												</c:forEach>
											</ul>					
									</c:if>		
							</c:forEach>		
					</ul>		
			</ul>

	</c:when>
	
	<c:when test="${sessionScope.grpid =='300'}">

		<br><br><br>
		<button type="button" onclick="logout();">로그아웃</button>
		<br><br><br>
			<ul>
				<c:forEach items="${treelist }" var="tree">				
					<c:if test="${tree.DEPT=='1' }">
						<li><a href="./${tree.M_OBJID }.ino">${tree.OBJNAME }</a></li>
					</c:if>
				</c:forEach>
					<ul>
							<c:forEach items="${sublist }" var="subtree">		
									<c:if test="${subtree.DEPT=='2' && subtree.M_OBJID=='OBJ110'}">
										<li><a href="./${subtree.M_OBJID }.ino">${subtree.OBJNAME }</a></li>
											<ul>
												<c:forEach items="${parent }" var="par">		
													<c:if test="${par.DEPT=='3' && par.HIGH_OBJ=='OBJ110'}">
														<li><a href="./${par.M_OBJID }.ino">${par.OBJNAME }</a></li>
													</c:if>		
												</c:forEach>
											</ul>					
									</c:if>		
							</c:forEach>		
					</ul>
					
					<ul>
							<c:forEach items="${sublist }" var="subtree">		
									<c:if test="${subtree.DEPT=='2' && subtree.M_OBJID=='OBJ120'}">
										<li><a href="./${subtree.M_OBJID }.ino">${subtree.OBJNAME }</a></li>
											<ul>
												<c:forEach items="${parent }" var="par">		
													<c:if test="${par.DEPT=='3' && par.HIGH_OBJ=='OBJ120'}">
														<li><a href="./${par.M_OBJID }.ino">${par.OBJNAME }</a></li>
													</c:if>		
												</c:forEach>
											</ul>					
									</c:if>		
							</c:forEach>		
					</ul>		
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