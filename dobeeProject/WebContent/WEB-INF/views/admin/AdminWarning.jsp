<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div class="limiter" >
	  
		
			<div class ="container">	
              <img src="img/workplace.PNG" alt="AVATAR" style="width:20%; height: 200px; display: block; margin: 0px auto; ">
			</div>
			<br>
			<hr style=" width: 25%; display: block; margin: 0px auto;">
			<div class="wrap-login100 p-t-85 p-b-20" style="align-content: center; display: block; margin: 0px auto;">
				<form class="login100-form validate-form" style=" height: 50%; text-align: center; ">
				<h2> Warning </h2>
					<h5><c:out value="${user.name}"></c:out>��  ���� ������ ���̵�� �α����Ͽ����ϴ�</h5>
					<hr style=" width: 25%; display: block; margin: 0px auto;">
					<h6>���⼭ ������ ��� ������ ������ �ݿ��Ǹ�</h6>
					<h6>������ ������ ������ �� �����ϴ�.</h6>
					<hr style=" width: 10%; display: block; margin: 0px auto;">
					<h6> Your URL : �̰� �� �߰��ϴ� �ž�???? </h6>
					<h6> LOGIN ID : <c:out value="${user.mail}"></c:out> </h6>
					<div class="container-login100-form-btn" style="height: 20%">
						<a class="button btn-prev" href="adminMain.do">
							������ �������� �̵��ϱ�
						</a>
					</div>
				</form>
			</div>
		
	</div>
</body>
</html>