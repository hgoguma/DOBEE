<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="fixed">
<head>
	
	<style>
		.btn-info.btn-sm.반려 {
			border-color:lightgray;
			background-color:#4BDA64;
		}
		
		.btn-info.btn-sm.미승인 {
			border-color:lightgray;
			background-color:#f54242;
		}
		
		.btn-info.btn-sm.승인 {
			border-color:lightgray;
			background-color:#ffc107;
		}
		
		.btn-info.btn-sm {
			width : 80%;
			border : none;
			border-radius: 5px;
		}
		
		.btn-info.btn-sm.edit{
			background-color : white;
			color : black;
			width : 80%;
			border : black 2px;
			border-radius: 5px;
		}
		
	</style>
	
<!-- Head Tag Script -->
<c:import url="/common/HeadTag.jsp"/>

<!-- Modal -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">

<!-- Table Style -->
<link rel="stylesheet" href="assets/vendor/select2/select2.css" />
<link rel="stylesheet" href="assets/vendor/jquery-datatables-bs3/assets/css/datatables.css" />
<!--폰트  -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic:700&display=swap" rel="stylesheet">

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
						<h2>부재 일정 관리</h2>
					
						<div class="right-wrapper pull-right">
							<ol class="breadcrumbs">
								<li>
									<a href="index.html">
										<i class="fa fa-briefcase" aria-hidden="true"></i>
									</a>
								</li>
								<li><span>근무</span></li>
								<li><span>부재 일정 관리</span></li>
								<li style="padding-right:30px;"><a href="#" style="cursor:default;"> <i class="fa fa-chevron-left"></i></a></li>
							</ol>
						</div>
					</header>
					<!-- 작업 여기부터~!~!~!~~! -->
					
					<section class="panel">
						<div class="row">
							<div class="col-md-12 col-lg-6 col-xl-6">
								<section class="panel panel-featured-left panel-featured-primary">
									<div class="panel-body">
										<div class="widget-summary widget-summary-sm">
											<div class="widget-summary-col widget-summary-col-icon">
												<div class="summary-icon bg-primary">
													<i class="fa fa-smile-o"></i>
												</div>
											</div>
											<div class="widget-summary-col">
												<div class="summary">
													<h4 class="title">남은 연차</h4>
													<div class="info">
														<strong class="amount" id="remainVacation">불러오는 중...</strong>
													</div>
												</div>
											</div>
										</div>
									</div>
								</section>
							</div>
							
							<div class="col-md-12 col-lg-6 col-xl-6">
								<section class="panel panel-featured-left panel-featured-primary">
									<div class="panel-body">
										<div class="widget-summary widget-summary-sm">
											<div class="widget-summary-col widget-summary-col-icon">
												<div class="summary-icon bg-primary">
													<i class="fa fa-meh-o"></i>
												</div>
											</div>
											<div class="widget-summary-col">
												<div class="summary">
													<h4 class="title">사용 연차</h4>
													<div class="info">
														<strong class="amount" id="usedVacation">불러오는 중...</strong>
													</div>
												</div>
											</div>
										</div>
									</div>
								</section>
							</div>
						</div>
					</section>
					
					
					<section class="panel">
						<header class="panel-heading">
							<h3 class="panel-title">부재 신청 현황</h3>
						</header>
						<div class="panel-body">
							<table class="table table-bordered table-striped mb-none" id="brkTable" data-swf-path="assets/vendor/jquery-datatables/extras/TableTools/swf/copy_csv_xls_pdf.swf">
								<thead>
									<tr>
										<th width="10%">부재항목</th>
										<th>기간</th>
										<th width="15%">연차 사용 일수</th>
										<th width="15%">신청 일자</th>
										<th width="10%">승인여부</th>
										<th width="11%">수정 및 삭제</th>
									</tr>
								</thead>
								<tbody>
									
									<c:forEach items="${brkList}" var="bl">
										<tr>
											<td class="bcategory" style="text-align: center;">	${bl.entry }</td>
											<td class="tterm">		${bl.startAt } - ${bl.endAt }</td>
											<td class="tused" style="text-align: center;">		${bl.useBreak }</td>
											<td class="tregdate" style="text-align: center;">	${bl.reqDate }</td>
											<td class="notauth" style="text-align: center;"><button type="button" class="btn btn-info btn-sm ${bl.isAuth }" data-toggle="modal" data-target="#myModal"
																		data-aplSeq="${bl.aplSeq }" data-reason="${bl.reason }" data-rejReason="${bl.rejReason }">${bl.isAuth }</button>
											</td>
											<td class="teditdelete" style="text-align: center;padding-top:15px;">
												<c:choose>
													<c:when test="${bl.isAuth == '미승인'}">
														<%-- <button class="btn btn-info btn-sm edit" onclick="location.href='editApply.do?aplSeq=${bl.aplSeq}'">수정 / 삭제</button> --%>
														<a href="editApply.do?aplSeq=${bl.aplSeq}"><i class="fa fa-pencil"></i></a>
													</c:when>
													<c:otherwise>
														-
													</c:otherwise>
												</c:choose>
											</td>
											
										</tr>
									</c:forEach>
									
								</tbody>
							</table>
						</div>
					</section>
					
					
					
					<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true"
						style="display: none;">
						<div class="modal-dialog modal-lg cascading-modal" role="document">
							<div class="modal-content">
								<!--Header-->
								<div class="modal-header light-blue darken-3 white-text"
									style="text-align: center; padding-top: 25px; padding-bottom: 25px;">
									<button type="button" class="close" data-dismiss="modal"
										style="margin-top: -9px;">
										<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title" id="myModalLabel">
										<i class="fa fa-check fa-2x"></i>&nbsp;Reason
									</h4>
								</div>
								<!--Body-->
								<div class="container-fluid">
									<div class="modal-body mb-0" style="margin-top: 30px;">
										<div class="form-group">
											<input type="hidden" id="modalAplSeq" name="aplSeq">
											<label class="col-md-3 control-label"><i
												class="fa fa-comment-o fa-2x"></i><span style="font-size: 15px">&nbsp;&nbsp;부재 신청 사유</span></label>
											<div class="col-md-9">
												<textarea id="modalReason"  name="reason" class="form-control" rows="3" data-plugin-textarea-autosize="" style="height: 200px" readonly="readonly"></textarea>
												<!-- <input type="text" id="modalReason" name="reason" class="form-control" style="height: 35px;" readonly="readonly"> -->
											</div>
										</div>
										<br>
										<div class="form-group">
											<label class="col-md-3 control-label" for="userList"><i
												class="fa fa-times fa-2x"></i><span style="font-size: 15px">&nbsp;&nbsp;부재 신청 반려 사유</span></label>
											<div class="col-md-9">
												<textarea id="modalRejReason"  name="rejReason" class="form-control" rows="3" data-plugin-textarea-autosize="" style="height: 200px" readonly="readonly"></textarea>
												<!-- <input type="text" id="modalRejReason" name="rejReason" class="form-control" style="height: 35px;" readonly="readonly"> -->
											</div>
										</div>
										<br>
									</div>
								</div>
								<div class="modal-footer">
									<div class="row">
										<div class="col-md-4"></div>
										<div class="col-md-4 text-center">
											<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
										</div>
										<div class="col-md-4"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
						
					
					<!-- start: page -->
					<!-- end: page -->
				</section>
			</div>

					<!-- start: page -->
					<!-- end: page -->
		</section>

		</section>

		<c:import url="/common/BottomTag.jsp"/>
		
		
<!-- SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT// -->
	
	<!-- Table Script -->
	<script src="assets/vendor/select2/select2.js"></script>
	<script src="assets/vendor/jquery-datatables/media/js/jquery.dataTables.js"></script>
	<script src="assets/vendor/jquery-datatables/extras/TableTools/js/dataTables.tableTools.min.js"></script>
	<script src="assets/vendor/jquery-datatables-bs3/assets/js/datatables.js"></script>

	
		<script>
			window.onload = function(){
	
				let aplSeq = "";
				let reason = "";
				let rejReason = "";
	
				$('.btn-sm').click('show.bs.modal', function(e) {
						
					aplSeq = $(this).data('aplseq');
					reason = $(this).data('reason');
					rejReason = $(this).data('rejreason');
	
					$('#modalAplSeq').val(aplSeq);
					$('#modalReason').val(reason);
					$('#modalRejReason').val(rejReason);
				});

				// 연차 정보 가져오기
				$.ajax ({
					url : "ajax/apply/getVacationInBM.do",
					dataType : "json",
					success : function (data) {
						$('#remainVacation').html(data.totalVacation[0].totalBreak - data.totalVacation[0].usedBreak + ' 일')
						$('#usedVacation').html(data.totalVacation[0].usedBreak + ' 일')						
					},
					error : function(request, status, error){
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
	

				$('#brkTable').DataTable({
					/*language option*/
					"language" : {
						"emptyTable" : "데이터가 없습니다.",
						"lengthMenu" : "_MENU_ 개씩 보기",
						"info" : "현재 _START_ - _END_ / _TOTAL_건",
						"infoEmpty" : "데이터 없음",
						"infoFiltered" : "( _MAX_건의 데이터에서 필터링됨 )",
						"search" : "검색: ",
						"zeroRecords" : "일치하는 데이터가 없습니다.",
						"loadingRecords" : "로딩중...",
						"processing" : "잠시만 기다려 주세요",
						"paginate" : {
							"next" : "다음",
							"previous" : "이전"
						}
					},
					"columnDefs" : [{
						className : "dt-center",
						"targets" : [ 1 ],
					}]
				});

				
	
			}
			
		</script>
		
	</body>
</html>