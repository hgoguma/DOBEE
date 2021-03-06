<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="fixed">
<head>
	<script src="assets/vendor/jquery/jquery.js"></script>
	<!--폰트  -->
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:700&display=swap" rel="stylesheet">
	<link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"/>
	<c:import url="/common/HeadTag.jsp"/>
	<!-- <link rel="stylesheet" href="assets/vendor/select2/select2.css" />
	<link rel="stylesheet" href="assets/vendor/jquery-datatables-bs3/assets/css/datatables.css" /> -->
	
	<script type="text/javascript">
$(document).ready(function(){
		$('#myTable').DataTable({
			/*language option*/
			"language": {
 	        "emptyTable": "데이터가 없습니다.",
 	        "lengthMenu": "페이지당 _MENU_ 개씩 보기",
 	        "info": "현재 _START_ - _END_ / _TOTAL_건",
 	        "infoEmpty": "데이터 없음",
 	        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
 	        "search": "검색: ",
 	        "zeroRecords": "일치하는 데이터가 없습니다.",
 	        "loadingRecords": "로딩중...",
 	        "processing": "잠시만 기다려 주세요",
 	        "paginate": {
 	            "next": "다음",
 	            "previous": "이전"
 	        }
 	    },
 	    "columnDefs": [
 	        {
     	      className: "dt-center", "targets": [1],
   	        }
 	      ]
			});
	});

	</script>
</head>
	<body>
		<section class="body">

			<!-- start: header -->
			<c:import url="/common/Top.jsp"/>
			<!-- end: header -->

			<div class="inner-wrapper">
				<!-- start: sidebar -->
				<c:import url="/common/Side.jsp"/>
				<!-- end: sidebar -->
				
			<!-- start : main Content -->
				<section role="main" class="content-body" style="font-family: 'Nanum Gothic', sans-serif;">
					<header class="page-header">
						<h2>비용 신청 목록</h2>
					
						<div class="right-wrapper pull-right">
							<ol class="breadcrumbs">
								<li>
									<a href="index.html">
										<i class="fa fa-home"></i>
									</a>
								</li>
								<li><span>비용</span></li>
								<li><span>비용신청 목록</span></li>
								<li style="padding-right:30px;"><a href="#" style="cursor:default;"> <i class="fa fa-chevron-left"></i></a></li>
							</ol>
						</div>
					</header>
					<!-- 작업 여기부터~!~!~!~~! -->
					<!-- start: page -->
									<section class="panel">
					<header class="panel-heading">
						<div class="panel-actions">
					
						</div>
				
						<h2 class="panel-title">비용신청 목록</h2>
					</header>
			<div class="panel-body">
				<form action="#" method="post">
					<table id="myTable" class="table table-bordered table-striped mb-none">
						<thead>
					<tr>
						<th style="width: auto">번호</th>
						<th style="width: auto">작성일</th>
						<th style="width: auto">사용일</th>
						<th style="width: auto">사용처</th>
						<th style="width: auto">사용금액</th>
						<th style="width: auto">상세내용</th>
						<th style="width: auto">비용항목</th>
						<th style="width: auto">카드번호</th>
						<th style="width: auto">사원메일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="receiptList" varStatus="status">
							<c:set var="code" value="${receiptList.costCode}" />
							<c:if test="${code eq '1'}">
							   <c:set var="codeName" value="회식비" />
							</c:if>
							<c:if test="${code eq '2'}">
							   <c:set var="codeName" value="식비" />
							</c:if>
							<c:if test="${code eq '3'}">
							   <c:set var="codeName" value="소모품" />
							</c:if>
							<c:if test="${code eq '4'}">
							   <c:set var="codeName" value="워크샵" />
							</c:if>
							<c:if test="${code eq '5'}">
							   <c:set var="codeName" value="교통비" />
							</c:if>
							<c:if test="${code eq '6'}">
							   <c:set var="codeName" value="접대비" />
							</c:if>
							<c:if test="${code eq '7'}">
							   <c:set var="codeName" value="통신비" />
							</c:if>
							<c:if test="${code eq '8'}">
							   <c:set var="codeName" value="기타" />
							</c:if>

						<tr>
							<td>${status.index+1}</td>
							<td><fmt:formatDate value="${receiptList.regitReceiptDate}" pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${receiptList.useDate}" pattern="yyyy-MM-dd" /></td>
							<td>${receiptList.useAt}</td>
							<td><fmt:formatNumber value="${receiptList.cost}" pattern="#,###" /></td>
							<td>${receiptList.detail}</td>
							<td>${codeName}</td>
							<td>${receiptList.cardNum}</td>
							<td>${receiptList.mail}</td>
						</tr>
					</c:forEach>
				</tbody>
					</table>
				</form>
			</div>
		</section>
					
					
					
					
					
					
					
					
					
					
					<!-- end: page -->
				</section>
			</div>




		
		</section>

		<c:import url="/common/BottomTag.jsp"/>
		
		<script src="assets/vendor/magnific-popup/magnific-popup.js"></script>
		<script src="assets/vendor/select2/select2.js"></script>
		<script src="assets/vendor/jquery-datatables/media/js/jquery.dataTables.js"></script>
		<script src="assets/vendor/jquery-datatables-bs3/assets/js/datatables.js"></script> 
		
	</body>
</html>