<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="fixed">
<head>

<!-- Head Tag Script -->
<c:import url="/common/HeadTag.jsp"/>

<!-- Slider -->
<link rel="stylesheet" href="assets/vendor/jquery-ui/css/ui-lightness/jquery-ui-1.10.4.custom.css" />

<!-- Date-time picker -->
<link rel="stylesheet" href="plugins/datetime-picker/css/bootstrap-datetimepicker.min.css">

<!-- Full Calendar Original -->
<link href='assets/vendor/fullcalendar-ori/packages/core/main.css' rel='stylesheet' />
<link href='assets/vendor/fullcalendar-ori/packages/bootstrap/main.css' rel='stylesheet' />
<link href='assets/vendor/fullcalendar-ori/packages/timegrid/main.css' rel='stylesheet' />
<link href='assets/vendor/fullcalendar-ori/packages/daygrid/main.css' rel='stylesheet' />
<link href='assets/vendor/fullcalendar-ori/packages/list/main.css' rel='stylesheet' />

<script src='assets/vendor/fullcalendar-ori/packages/core/main.js'></script>
<script src='assets/vendor/fullcalendar-ori/packages/interaction/main.js'></script>
<script src='assets/vendor/fullcalendar-ori/packages/bootstrap/main.js'></script>
<script src='assets/vendor/fullcalendar-ori/packages/daygrid/main.js'></script>
<script src='assets/vendor/fullcalendar-ori/packages/timegrid/main.js'></script>
<script src='assets/vendor/fullcalendar-ori/packages/list/main.js'></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/4.2.0/core/locales/ko.js"></script>

<!-- sweet alert -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.0/sweetalert.min.js"></script>

<!-- select2 -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.0.12/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js" defer></script>
<!-- <link href="//cdnjs.cloudflare.com/ajax/libs/select2/4.0.0/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.8/js/select2.min.js" defer></script> -->

<!-- specific page vendor css form script -->
<link rel="stylesheet" href="assets/vendor/bootstrap-tagsinput/bootstrap-tagsinput.css" />
<link rel="stylesheet" href="assets/vendor/bootstrap-markdown/css/bootstrap-markdown.min.css" />

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
						<h2>부재 일정 신청</h2>
					
						<div class="right-wrapper pull-right">
							<ol class="breadcrumbs">
								<li>
									<a href="index.html">
										<i class="fa fa-briefcase" aria-hidden="true"></i>
									</a>
								</li>
								<li><span>근무</span></li>
								<li><span>부재 일정 신청</span></li>
								<li style="padding-right:30px;"><a href="#" style="cursor:default;"> <i class="fa fa-chevron-left"></i></a></li>
							</ol>
						</div>
					</header>
					<!-- 작업 여기부터~!~!~!~~! -->
					
					<section class="panel">
						<div class="row">
							
							<div class="col-md-7">
								<section class="panel">
									<header class="panel-heading">		
										<h2 class="panel-title">Calendar</h2>
									</header>
									<div class="panel-body">
										<div class="calendarArea" style="width:100%">
											<div id="calendar"></div>
										</div>
									</div>
								</section>
							</div>
							
							<div class="col-md-5 panel-body">
								<div class="col-md-12">
									<form id="breakApplyForm" action="#" method="post">
										<br>
										<br>
										<label class="control-label" for="textareaDefault">시작 시간</label>
										<input type='text' class="form-control" id='datetimepickerStart' name="startAt"/>
										<br>
										<label class="control-label" for="textareaDefault">종료 시간</label>
										<input type='text' class="form-control" id='datetimepickerEnd' name="endAt"/>
										<br>
										<label class="control-label" for="textareaDefault">부재 항목</label>
										<br>
										<select name="apyCode" id="apycodelist" style="width: 100%;">
											<option value="">부재 항목 선택</option>
											<option value="1">연차</option>
											<option value="2">반일연차</option>
											<option value="3">출장</option>
											<option value="4">외근</option>
											<option value="5">경조휴가</option>
										</select>
										<br>
										<div id="inputUseBreak">
											<br>
											<p id="divDays" class="output">연차 사용 일수 : <b id="days">0</b></p>
											<div class="col-md-12" id="showHide">
												<section class="panel">
													<div class="panel-body" style="padding:5px;">
														<div class="mt-lg mb-lg slider-primary" id="divSlider" data-plugin-slider data-plugin-options='{ "value": 0, "range": "min", "max": 27 }' data-plugin-slider-output="#listenSlider">
															<input name="useBreak" id="listenSlider" type="hidden" value="0" />
														</div>	
													</div>
												</section>
											</div>
										</div>
										
										<br>
										<div class="form-group">
											<label class="control-label" for="textareaDefault">사유</label>
											<textarea name="reason" class="form-control" rows="3" data-plugin-textarea-autosize="" data-plugin-maxlength maxlength="3000" style="height: 200px" placeholder="사유를 입력해주세요."></textarea>
										</div>
										<br>
										결재자
										<br>
										<select name="approval" id="approvalList" style="width:100%;">
											<option hidden>결재자 선택</option>
										</select>
										<br>
										<br>
										<br>
										<input id="breakApplyBtn" type="button" value="확인" class="btn btn-primary" style="width:auto;"> &nbsp;&nbsp;
										<input type="reset" value="초기화" class="btn btn-default" style="width:auto;">
									</form>
								</div>
							</div>
						</div>
					</section>
					<div id='calendar'></div>
				</section>
			</div>
		</section>
		<c:import url="/common/BottomTag.jsp"/>
		
		
<!-- SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT//SCRIPT// -->
	
	<!-- Date-Time Picker -->
	<!-- Moment.js 2.24.0 min - cloudflare -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script src="plugins/datetime-picker/js/bootstrap-datetimepicker.min.js"></script>
	
	
	<script>
		window.onload = function(){

			// 웹 소켓 연결
			connect();

			
			$('#listenSlider').change(function() {
				$('.output b').text( this.value);
			});

			
			$('#apycodelist').change(function() {
				let apycode = this.value;
				
				if (apycode == 1) {
					$('.ui-slider-range').width(0);
					$('#divDays').show();
					$('#showHide').show();
				} else if (apycode == 2) {
					$('#listenSlider').val(0.5);
					$('#days').html(0.5);
					$('#divDays').show();
					$('#showHide').hide();
				} else {
					$('#listenSlider').val(0);
					$('#days').html(0);
					$('#showHide').hide();
					$('#divDays').hide();
				}
			});

			
			/*부재 항목 select2 적용*/
			$('#apycodelist').select2({
				 width: 'resolve',				
				});
			

			$.ajax({
				url : "ajax/apply/getApprovalList.do?teamCode="+${sessionScope.user.teamCode},
				dataType : "json",
				success : function(data) {
					var dArray = [];
					dArray = data.renewedList;
					for (var i =0; i<dArray.length; i++) {
						var option = $('<option>');
 	 					$(option).val(dArray[i].mail);
 	 					$(option).text(dArray[i].name+"("+dArray[i].mail+")");
	 	 				$('#approvalList').append(option);
					}
					$("#approvalList").select2();
					
				},
				error : function(request, status, error) {
					console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
			
			
			$('#datetimepickerEnd').datetimepicker({
	            format : 'YYYY-MM-DD HH:mm' ,
	            inline : true,
	            sideBySide : true
	        });
	        
		 	$('#datetimepickerStart').datetimepicker({
	            format : 'YYYY-MM-DD HH:mm',
	            inline : true,
	            sideBySide : true
	        });

		 	let dateTimeRegex = /^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})$/;

	        /*부재 일정 신청 비동기 처리 --01.26 알파카 */
	        $("#breakApplyBtn").on('click', function() {

	        	// 시작/종료 일정 미입력 확인
				if($('#datetimepickerStart').val() == "" || $('#datetimepickerEnd').val() == "" ) {
					swal({
						title : "시작 / 종료 날짜",
						text : "시작 / 종료 시간을 입력해주세요.",
						icon : "warning",
						button : "true"
					}).then((YES) => {
						$('#datetimepickerStart').focus()
					})

					return;
				// 시작 / 종료 일정 정규표현식 일치 여부 확인
				} else if (dateTimeRegex.test($('#datetimepickerStart').val() || dateTimeRegex.test($('#datetimepickerEnd').val()) ) == "") {
					
					swal({
						title : "시작 / 종료 날짜",
						text : "날짜 형식에 맞지 않습니다.",
						icon : "warning",
						button : "true"
					}).then((YES) => {
						$('#datetimepickerStart').focus()
					})

					return;
				// 부재 항목 선택 확인
				} else if ($('#apycodelist option:selected').val() == "") {
					
					swal({
						title : "부재 항목",
						text : "부재 항목을 선택해주세요.",
						icon : "warning",
						button : "true"
					}).then((YES) => {
						$('#apycodelist').focus()
					})

					return;
				// 부재 사유 입력 확인
				} else if ($('#breakReason').val() == "") {
					swal({
						title : "부재 사유",
						text : "부재 사유를 입력해주세요.",
						icon : "warning",
						button : "true"
					}).then((YES) => {
						$('#breakReason').focus()
					})

					return;
				// 결재자 선택 확인
				} else if ($('#approvalList option:selected').val() == "") {
					swal({
						title : "결재자",
						text : "결재자를 선택해주세요.",
						icon : "warning",
						button : "true"
					}).then((YES) => {
						$('#approvalList').focus()
					})

					return;
				// 시작 / 종료 일자 선택 오류 확인
				} else if($('#datetimepickerStart').val() > $('#datetimepickerEnd').val()) {
					swal({
						title : "날짜 선택 오류",
						text : "종료 시간을 다시 선택해주세요.",
						icon : "warning",
						button : "true"
					}).then((YES) => {
						$('#datetimepickerEnd').focus()
					})

					return;
				}

		        
		        var formData = $("#breakApplyForm").serialize();
		        
	        	$.ajax({
					url : "ajax/apply/breakApply.do",
					data : formData,
					dataType : "text",
					contentType :  "application/x-www-form-urlencoded; charset=UTF-8",
	 				type:"post",
					success : function(responseData) {
						
						send("breakApply");
						
						if(responseData == "success"){
							swal({
								title: "부재 일정 신청",
								text: "부재 일정이 신청되었습니다.",
								icon: "success", //"info,success,warning,error" 중 택1
								button : {
									confirm: {
									    text: "확인",
									    value: true,
									    visible: true,
									    className: "",
									    closeModal: true
									  }
									}
							}).then((YES) => {
								if(YES){
	 								location.reload(true); 
								} 
							})
						}
					},
					error : function(request, status, error) {
						console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
		    });
		}

		var eventList = [];

		$.ajax ({
			url : "ajax/apply/AbsAll.do",
			dataType : "json",
			success : function(data) {
				var events = [];
				events = data.AbsAll;

				$.each(events, (index, element) => {
					if (element.isAuth ==='승인' && element.apyCode == 1 ) {
						eventList.push({
							title : "연차",
							start : element.startAt,
							end : element.endAt,
							color : "#4BDA64"
						})
					} else if (element.isAuth ==='미승인' && element.apyCode == 1 ) {
						eventList.push({
							title : "연차 미승인",
							start : element.startAt,
							end : element.endAt,
							color : "#f54242"
						})
					} else if (element.isAuth == '승인' && element.apyCode == 2 ) {
						eventList.push({
							title : "반일 연차",
							start : element.startAt,
							end : element.endAt,
							color : "#4BDA64"
						})
					} else if (element.isAuth ==='미승인' && element.apyCode == 2 ) {
						eventList.push({
							title : "반일 연차 미승인",
							start : element.startAt,
							end : element.endAt,
							color : "#f54242"
						})					
					} else if (element.isAuth == '승인' && element.apyCode == 3 ) {
						eventList.push({
							title : "출장",
							start : element.startAt,
							end : element.endAt,
							color : "#ffc107"
						})
					} else if (element.isAuth ==='미승인' && element.apyCode == 3 ) {
						eventList.push({
							title : "출장 미승인",
							start : element.startAt,
							end : element.endAt,
							color : "#f54242"
							
						})
					} else if (element.isAuth == '승인' && element.apyCode == 4 ) {
						eventList.push({
							title : "외근",
							start : element.startAt,
							end : element.endAt,
							color : "#ffc107"
						})
					} else if (element.isAuth ==='미승인' && element.apyCode == 4 ) {
						eventList.push({
							title : "외근 미승인",
							start : element.startAt,
							end : element.endAt,
							color : "#f54242"
						})
					} else if (element.isAuth == '승인' && element.apyCode == 5 ) {
						eventList.push({
							title : "경조 휴가",
							start : element.startAt,
							end : element.endAt,
							color : "#0088cc"
						})
					} else if (element.isAuth ==='미승인' && element.apyCode == 5 ) {
						eventList.push({
							title : "경조 휴가 미승인",
							start : element.startAt,
							end : element.endAt,
							color : "#f54242"
						})
					}
				});
			},
			complete : function () {
				var calendarEl = document.getElementById('calendar');

			    var calendar = new FullCalendar.Calendar(calendarEl, {
			      plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list' ],
			      header: {
			    	left : 'prev,today,next',
					center : 'title',
					right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
			      },
			      timeFormat : 'h:mm',
			      navLinks: true, // can click day/week names to navigate views
			      businessHours: {
				      startTime : '09:00',
				      endTime : '18:00'
				  },
				  eventLimit : true,
			      editable: false,
			      events: eventList
			    });
			    calendar.render();
			}
		});

		/* 알람 */
		
		
		function send(data) {
			let mail = $('#approvalList').val();
			let content = $('#apycodelist').val();
			var jsonData = new Object();
			jsonData.cmd = data;
			jsonData.mail = mail;
			jsonData.content = content;
			jsonData.applier = '${sessionScope.user.name}';

			var parsedData = JSON.stringify(jsonData);
			
			wsocket.send(parsedData);
		}
		/* /알람  */
		
  	</script>
		
		
		
	</body>
</html>