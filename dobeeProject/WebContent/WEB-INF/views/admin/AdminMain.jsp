<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="fixed">
<head>

	<!-- Basic -->
	<c:import url="/common/HeadTag.jsp"/>
	<meta name="author" content="okler.net">
	<!-- Specific Page Vendor CSS -->
	<link rel="stylesheet" href="assets/vendor/select2/select2.css" />
	<link rel="stylesheet" href="assets/vendor/jquery-datatables-bs3/assets/css/datatables.css" />
	<!--폰트  -->
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:700&display=swap" rel="stylesheet">
</head>
<body>
	<section class="body">

		<!-- start: header -->
		<c:import url="/common/TopAdmin.jsp"/>
		<!-- end: header -->

		<div class="inner-wrapper">
			<!-- start: sidebar -->
			<c:import url="/common/SideAdmin.jsp"/>
		<!-- end: sidebar -->
		<!-- start : main Content -->
			<section role="main" class="content-body" style="font-family: 'Nanum Gothic', sans-serif;">
				<header class="page-header">
					<h2>사원 목록</h2>
				
					<div class="right-wrapper pull-right">
						<ol class="breadcrumbs">
							<li>
								<a href="index.html">
									<i class="fa fa-briefcase"></i>
								</a>
							</li>
							<li><span>사원 관리</span></li>
							<li><span>사원 목록</span></li>
							<li style="padding-right:30px;"><a href="#" style="cursor:default;"> <i class="fa fa-chevron-left"></i></a></li>
						</ol>
					</div>
				</header>
				<!-- start: page -->
				<section class="panel">
				<header class="panel-heading">
					<h2 class="panel-title">사원 목록</h2>
				</header>
				<div class="panel-body">
					<table class="table table-bordered table-striped mb-none" id="datatable-details">
						<thead>
							<tr>
							<th>번호</th>
							<th>사원 E-mail</th>
							<th>사원 이름</th>
							<th>권한 코드</th>
							<th>팀</th>
							<th>입사일</th>
							<th>재직 상태</th>
							<th>고용 형태</th>
							<th>직책</th>
							<th>휴대폰 번호</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${userList}" var="user" varStatus="status">
						<tr>
							<td>${status.index+1}</td>
							<td><a href="modifyUser.do?mail=${user.mail}">${user.mail}</a></td>
							<td>${user.name}</td>
							<td>${user.authCode}</td>
							<td>${user.teamName}</td>
							<td><fmt:formatDate value="${user.regitDate}" pattern="yyyy-MM-dd"/></td>
							<td>${user.serve}</td>
							<td>${user.emp}</td>
							<td>${user.position}</td>
							<td>${user.phone}</td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</section>
				<!-- end: page -->
			</section>
		</div>
		
	</section>
	<c:import url="/common/BottomTag.jsp"/>
</body>
</html>